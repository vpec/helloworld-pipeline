#!/bin/bash
i=$1
endpoint=$2
while [[ $i -gt 0 ]] ; do
  curl $endpoint
  (( i -= 1 ))
  echo
  echo "$i requests left"
done
