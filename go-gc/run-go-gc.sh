#!/bin/bash
set -x

cd /root

touch GO_GC_RESULTS.out
echo "GO Garbage Collection Results" > GO_GC_RESULTS.out


echo "Pin threads to GOMAXPROCS cores, GOGC=100" >> GO_GC_RESULTS.out
echo "GOMAXPROCS 1" >> GO_GC_RESULTS.out
GOMAXPROCS=1  GOGC=100 taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 2" >> GO_GC_RESULTS.out
GOMAXPROCS=2  GOGC=100 taskset -c 0,1 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 3" >> GO_GC_RESULTS.out
GOMAXPROCS=3  GOGC=100 taskset -c 0,1,2 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 4" >> GO_GC_RESULTS.out
GOMAXPROCS=4  GOGC=100 taskset -c 0,1,2,3 ./main.riscv >> GO_GC_RESULTS.out

echo "Pin threads to GOMAXPROCS cores, GOGC=10" >> GO_GC_RESULTS.out
echo "GOMAXPROCS 1" >> GO_GC_RESULTS.out
GOMAXPROCS=1  GOGC=10 taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 2" >> GO_GC_RESULTS.out
GOMAXPROCS=2  GOGC=10 taskset -c 0,1 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 3" >> GO_GC_RESULTS.out
GOMAXPROCS=3  GOGC=10 taskset -c 0,1,2 ./main.riscv >> GO_GC_RESULTS.out

echo "GOMAXPROCS 4" >> GO_GC_RESULTS.out
GOMAXPROCS=4  GOGC=10 taskset -c 0,1,2,3 ./main.riscv >> GO_GC_RESULTS.out



# echo "Pin threads to 1 cores" >> GO_GC_RESULTS.out
# echo "GOMAXPROCS 1" >> GO_GC_RESULTS.out
# GOMAXPROCS=1  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

# echo "GOMAXPROCS 2" >> GO_GC_RESULTS.out
# GOMAXPROCS=2  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

# echo "GOMAXPROCS 3" >> GO_GC_RESULTS.out
# GOMAXPROCS=3  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out

# echo "GOMAXPROCS 4" >> GO_GC_RESULTS.out
# GOMAXPROCS=4  taskset -c 0 ./main.riscv >> GO_GC_RESULTS.out


poweroff -f
