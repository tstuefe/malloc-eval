#!/bin/bash
set -e

JVM_PARMS="-Xmx2g -Xms2g -XX:+AlwaysPreTouch -XX:+UnlockDiagnosticVMOptions -XX:+DumpVitalsAtExit -XX:VitalsSampleInterval=1"
TEST_PARMS="-r 100"

../jdks/jdk/bin/java ${JVM_PARMS} -XX:-UseJemalloc -XX:VitalsFile=vitals-glibc${s} -jar /shared/projects/openjdk/benchmarks/renaissance/renaissance-gpl-0.13.0.jar philosophers
../jdks/jdk/bin/java ${JVM_PARMS} -XX:+UseJemalloc -XX:VitalsFile=vitals-jemalloc${s} -jar /shared/projects/openjdk/benchmarks/renaissance/renaissance-gpl-0.13.0.jar philosophers


