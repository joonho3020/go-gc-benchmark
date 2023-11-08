#!/bin/bash
set -x

touch GO_GC_RESULTS.out
echo "GO Garbage Collection Results" > GO_GC_RESULTS.out


echo "Pin threads to 1 core" >> GO_GC_RESULTS.out
echo "GOMAXPROCS 1" >> GO_GC_RESULTS.out
GOMAXPROCS=1  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 2" >> GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 4" >> GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 8" >> GO_GC_RESULTS.out
GOMAXPROCS=8  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out




echo "Pin threads to 4 cores" >> GO_GC_RESULTS
echo "GOMAXPROCS 1" >> GO_GC_RESULTS.out
GOMAXPROCS=1  taskset -c 0,1,2,3 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 2" >> GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0,1,2,3 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 4" >> GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0,1,2,3 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 8" >> GO_GC_RESULTS.out
GOMAXPROCS=8  taskset -c 0,1,2,3 ./main.riscv >> GO_GC_RESULTS.out




echo "Pin threads to 8 cores" >> GO_GC_RESULTS.out
echo "GOMAXPROCS 1" >> GO_GC_RESULTS.out
GOMAXPROCS=1  taskset -c 0,1,2,3,4,5,6,7 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 2" >> GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0,1,2,3,4,5,6,7 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 4" >> GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0,1,2,3,4,5,6,7 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 8" >> GO_GC_RESULTS.out
GOMAXPROCS=8  taskset -c 0,1,2,3,4,5,6,7 ./main.riscv >> GO_GC_RESULTS.out
