#!/bin/bash
#
sum=0
for i in {1..100}; do
  if [ $[$i%3] -ne 0 ]; then
     continue
  fi
  let sum+=$i
done

echo $sum
