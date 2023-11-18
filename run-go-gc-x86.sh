#!/bin/bash
set -x

touch X86_GO_GC_RESULTS.out
echo "GO Garbage Collection Results" > X86_GO_GC_RESULTS.out

# echo "Pin threads to 1 core"          >> X86_GO_GC_RESULTS.out
# GOMAXPROCS=1  taskset -c 0 ./main.x86 >> X86_GO_GC_RESULTS.out
# GOMAXPROCS=2  taskset -c 0 ./main.x86 >> X86_GO_GC_RESULTS.out
# GOMAXPROCS=3  taskset -c 0 ./main.x86 >> X86_GO_GC_RESULTS.out
# GOMAXPROCS=4  taskset -c 0 ./main.x86 >> X86_GO_GC_RESULTS.out

echo "Pin threads to GOMAXPROCS cores"      >> X86_GO_GC_RESULTS.out
GOMAXPROCS=1  taskset -c 0       ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=2  taskset -c 0,1     ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=3  taskset -c 0,1,2   ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=4  taskset -c 0,1,2,3 ./main.x86 >> X86_GO_GC_RESULTS.out

# echo "Pin thread to separate NUMA domains"  >> X86_GO_GC_RESULTS.out
# CORES_PER_SOCKET=$(lscpu -b -p=Core,Socket | grep -v '^#' | sort -u | wc -l)
# SOCKET_COUNT=$(lscpu -b -p=Socket | grep -v '^#' | sort -u | wc -l)
# echo "$CORES_PER_SOCKET cores per socket, $SOCKET_COUNT sockets"
# if [ $SOCKET_COUNT -ne 2 ]; then
# exit 1
# fi
# GOMAXPROCS=2  taskset -c 0,$CORES_PER_SOCKET    ./main.x86 >> X86_GO_GC_RESULTS.out

echo "Pin threads to GOMAXPROCS cores GOGC=1"      >> X86_GO_GC_RESULTS.out
GOMAXPROCS=1  GOGC=10 taskset -c 0       ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=2  GOGC=10 taskset -c 0,1     ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=3  GOGC=10 taskset -c 0,1,2   ./main.x86 >> X86_GO_GC_RESULTS.out
GOMAXPROCS=4  GOGC=10 taskset -c 0,1,2,3 ./main.x86 >> X86_GO_GC_RESULTS.out
