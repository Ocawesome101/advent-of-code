#!/bin/bash

last=-1
overlap=0
for line in $(cat input/day1); do
  if [ $line -gt $last ] && [ $last != -1 ]; then
    overlap=$(($overlap + 1))
  fi
  last=$line
done

echo $overlap
