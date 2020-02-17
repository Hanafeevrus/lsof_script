#!/bin/sh
pid=1
files=$(sudo ls -l /proc/$pid/map_files/ | awk '{print $11}' | uniq & sudo ls -l /proc/$pid/fd | sed 1d | awk '{print $11}')
  printf "%5s\t%s\n" "PID" "FILES"

for files in ${files[@]}; do
printf "%5s\t%s\n" "$pid"  "$files"
  done
exit 0
