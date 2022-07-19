#!/bin/bash
set -e

JVM_PARMS="-Xmx1g -Xms1g -XX:+AlwaysPreTouch -XX:+UnlockDiagnosticVMOptions -XX:+DumpVitalsAtExit -XX:VitalsSampleInterval=1"

../jdks/jdk/bin/java ${JVM_PARMS} -XX:-UseJemalloc -XX:VitalsFile=vitals-glibc -jar /shared/projects/spring-petclinic/target/spring-petclinic-2.5.0-SNAPSHOT.jar > output-glibc.txt 2>&1 &
PID=$!
echo "Started spring petclinic, pid=$PID"
sleep 20
echo "Will stop now, pid=$PID"
kill -SIGTERM $PID

../jdks/jdk/bin/java ${JVM_PARMS} -XX:+UseJemalloc -XX:VitalsFile=vitals-jemalloc -jar /shared/projects/spring-petclinic/target/spring-petclinic-2.5.0-SNAPSHOT.jar > output-jemalloc.txt 2>&1 &
PID=$!
echo "Started spring petclinic, pid=$PID"
sleep 20
echo "Will stop now, pid=$PID"
kill -SIGTERM $PID

echo "Done."
