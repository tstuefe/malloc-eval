#!/bin/bash
set -e

# Note: If we run with test type "leak", we will not allocate a pointer array on the heap and therefore the heap is rather static.
# Still, we run with -Xmx=Xms and pretouch.

NUM_THREADS=1

JVM_PARMS="-Xmx256m -Xms256m -XX:+AlwaysPreTouch -XX:+UnlockDiagnosticVMOptions -XX:+DumpVitalsAtExit -XX:VitalsSampleInterval=1"
TEST_PARMS="-T ${NUM_THREADS} -c 1 -y -t leak"

for (( s=8; s <= 1024; s=s*2 ))
do
let n=1073741824/s
echo "n= ${n}, s= ${s}"
../jdks/jdk/bin/java ${JVM_PARMS} -XX:-UseJemalloc -XX:VitalsFile=vitals-glibc-s${s} -cp $REPROS_JAR de.stuefe.repros.AllocCHeap ${TEST_PARMS} -n ${n} -s ${s} > output-glibc-s${s}.txt 2>&1
../jdks/jdk/bin/java ${JVM_PARMS} -XX:+UseJemalloc -XX:VitalsFile=vitals-jemalloc-s${s} -cp $REPROS_JAR de.stuefe.repros.AllocCHeap ${TEST_PARMS} -n ${n} -s ${s} > output-jemalloc-s${s}.txt 2>&1
done

# as convenience, display results
sh ./display-results.sh


