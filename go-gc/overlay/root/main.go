package main

import (
	"flag"
	"fmt"
	"math/rand"
	"net/http"
	_ "net/http/pprof"
	"runtime/trace"
	"sort"
	"time"
)

func main() {
	children := 10
	globalGarbage := 9
	childGarbage := 17
	mainGarbage := 0
	sampleCount := 100000
// period := 100 * time.Millisecond
// period := time.Millisecond
	period := 10 * time.Microsecond
	traceFile := "trace.out"

	flag.IntVar(&globalGarbage, "globalGarbage", globalGarbage, "global garbage count")
	flag.IntVar(&childGarbage, "childGarbage", childGarbage, "child garbage count")
	flag.IntVar(&mainGarbage, "mainGarbage", mainGarbage, "main garbage count")
	flag.IntVar(&children, "children", children, "Number of child processes to launch")
	flag.IntVar(&sampleCount, "samples", sampleCount, "Number of iterations to run")
	flag.DurationVar(&period, "period", period, "Main loop period")
	flag.StringVar(&traceFile, "trace", traceFile, "Trace file")
	flag.Parse()

	rand.Seed(time.Now().Unix())

// f, err := os.Create(traceFile)
// if err != nil {
// log.Fatal(err)
// }
// defer f.Close()

	globalG0 = makeGarbage(globalGarbage, false)
	globalG1 = makeGarbage(globalGarbage, false)
	childG = make([]*garbage, children)

	for i := 0; i < children; i++ {
		go childLoop(childGarbage, i, period)
	}

	go http.ListenAndServe(":6060", nil)

// err = trace.Start(f)
// if err != nil {
// log.Fatal(err)
// }

	mainLoop(mainGarbage, sampleCount, period)

	trace.Stop()
}

// Force heap allocation by using globals
var globalG0, globalG1 *garbage
var mainG *garbage
var childG []*garbage

func mainLoop(mainGarbage int, sampleCount int, period time.Duration) {
	ticker := time.NewTicker(period)
	lastTime := time.Now()
	samples := make([]float64, sampleCount)
	for i := 0; i < sampleCount; i++ {
		select {
		case t := <-ticker.C:
			tdiff := t.Sub(lastTime) - period
// if tdiff > 20*time.Millisecond {
// fmt.Printf("Higher latency than expected at iteration %v.  Tick was delayed %v\n", i, tdiff)
// }

			samples[i] = float64(tdiff)

			mainG = makeGarbage(mainGarbage, true)
			lastTime = t
		}
	}
	printStats(samples[:])
}

func printStats(values []float64) {
	sort.Float64s(values)
// for _, pct := range []float64{0, .01, .05, .50, .95, .99, 1.00} {
	for _, pct := range []float64{.50, .95, .99} {
		idx := int((float64(len(values)) - 1) * pct)
		fmt.Printf(" % 4.1f%% %v\n", pct*100, time.Duration(values[idx]))
	}
}

func childLoop(childGarbage int, childCount int, period time.Duration) {
	for {
		delay := time.Duration(rand.Intn(int(period) * 3 / 2))
		time.Sleep(delay)

		childG[childCount] = makeGarbage(childGarbage, true)
	}
}

type garbage struct {
	data     [100]byte
	children []*garbage
}

func makeGarbage(amount int, random bool) *garbage {
	if amount <= 0 {
		return nil
	}
	g := new(garbage)
	children := amount - 1
	if random {
		children = rand.Intn(amount)
	}
	for i := 0; i < children; i++ {
		g.children = append(g.children, makeGarbage(children, random))
	}
	return g
}
