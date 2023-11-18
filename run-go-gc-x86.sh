#!/bin/bash
set -x

touch X86_GO_GC_RESULTS.out
echo "GO Garbage Collection Results" > X86_GO_GC_RESULTS.out

echo "Pin threads to 1 core"          >> X86_GO_GC_RESULTS.out
GOMAXPROCS=1  taskset -c 0 ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0 ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=3  taskset -c 0 ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0 ./main.x86 >> X86_GO_GC_RESULTS.out

echo "Pin threads to GOMAXPROCS cores"      >> X86_GO_GC_RESULTS.out
GOMAXPROCS=1  taskset -c 0       ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0,1     ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=3  taskset -c 0,1,2   ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0,1,2,3 ./main.x86 >> X86_GO_GC_RESULTS.out

echo "Pin thread to separate NUMA domains"  >> X86_GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0,36    ./main.x86 >> X86_GO_GC_RESULTS.out
