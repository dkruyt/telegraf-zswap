#!/bin/bash

cd /sys/kernel/debug/zswap

grep . * |  awk -F":" '{print "zswap "$1"="$2}'

