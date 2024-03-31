#!/usr/bin/env bash

echo "using cut"
time for count in {1..1000}
do
  cut -d ":" -f 7 </etc/passwd > /dev/null
done

echo "using ##"
time for count in {1..1000}
do
  while read
  do
    echo "${REPLY##*:}" > /dev/null
  done </etc/passwd
done
