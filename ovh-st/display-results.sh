#!/bin/bash
set -e

# convenience script to display results (the end Vitals state)
echo "Results glibc malloc:"
for (( s=8; s <= 1024; s=s*2 ))
do
echo "s=${s}: "
ack -m 1 -B 1 '\d\d\d\d-\d\d-\d\d' vitals-glibc-s${s}.txt
done

echo
echo
echo "Results jemalloc:"
for (( s=8; s <= 1024; s=s*2 ))
do
echo "s=${s}: "
ack -m 1 -B 1 '\d\d\d\d-\d\d-\d\d' vitals-jemalloc-s${s}.txt
done


