#!/bin/bash


set -ex



GOMAXPROCS=2 ./main.x86 &

THREADID=$(pgrep main.x86)
THREADIDSHERE=$(ps -mo tid -p $THREADID | grep [0-9])

echo $THREADIDSHERE


COUNTER=0
# PROC2BIN=(0x1 0x1000000000 0x2 0x2000000000 0x4 0x4000000000)
PROC2BIN=(1 36 2 37 3 38 4 39)
ps -mo tid,psr -p $THREADID


for i in $THREADIDSHERE;
do
# taskset -p ${PROC2BIN[COUNTER]} $i
    taskset -p --cpu-list ${PROC2BIN[COUNTER]} $i
    COUNTER=$(($COUNTER + 1))
# COUNTER=$(($COUNTER % 4))
done

ps -mo tid,psr -p $THREADID

while :; do sleep 86400; done
