#!/bin/bash
set -x

touch GO_GC_RESULTS.out
echo "GO Garbage Collection Results" > GO_GC_RESULTS.out

echo "Pin threads to 1 core"
GOMAXPROCS=1  taskset -c 0 ./main.x86 >> GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0 ./main.x86 >> GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0 ./main.x86 >> GO_GC_RESULTS.out
GOMAXPROCS=8  taskset -c 0 ./main.x86 >> GO_GC_RESULTS.out

echo "Pin threads to 4 cores"
GOMAXPROCS=1  taskset -c 0,1,2,3 ./main.x86 >> GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0,1,2,3 ./main.x86 >> GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0,1,2,3 ./main.x86 >> GO_GC_RESULTS.out
GOMAXPROCS=8  taskset -c 0,1,2,3 ./main.x86 >> GO_GC_RESULTS.out

echo "Pin threads to 8 cores"
GOMAXPROCS=1  taskset -c 0,1,2,3,4,5,6,7 ./main.x86 >> GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0,1,2,3,4,5,6,7 ./main.x86 >> GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0,1,2,3,4,5,6,7 ./main.x86 >> GO_GC_RESULTS.out
GOMAXPROCS=8  taskset -c 0,1,2,3,4,5,6,7 ./main.x86 >> GO_GC_RESULTS.out
