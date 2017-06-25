#!/bin/bash

cd /sys/kernel/debug/zswap

echo -n "zswap " ;grep . * |  awk -F":" '{printf $1"="$2","}' | sed 's/,$/\n/'
