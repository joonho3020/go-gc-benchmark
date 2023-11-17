#!/bin/bash
set -x

cd /root

touch GO_GC_RESULTS.out
echo "GO Garbage Collection Results" > GO_GC_RESULTS.out


echo "Pin threads to GOMAXPROCS cores" >> GO_GC_RESULTS.out
echo "GOMAXPROCS 1" >> GO_GC_RESULTS.out
GOMAXPROCS=1  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 2" >> GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0,1 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 3" >> GO_GC_RESULTS.out
GOMAXPROCS=3  taskset -c 0,1,2 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 4" >> GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0,1,2,3 ./main.riscv >> GO_GC_RESULTS.out



echo "Pin threads to 1 cores" >> GO_GC_RESULTS.out
echo "GOMAXPROCS 1" >> GO_GC_RESULTS.out
GOMAXPROCS=1  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 2" >> GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 3" >> GO_GC_RESULTS.out
GOMAXPROCS=3  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 4" >> GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out


poweroff -f
