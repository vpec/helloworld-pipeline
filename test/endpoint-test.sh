#!/bin/bash
endpoint="$1"
expected_result="Hello World!"
echo "Checking endpoint "$endpoint""
result=$(curl "$endpoint")
if [ "$result" == "$expected_result" ]; then  
    echo "Test passed: endpoint responded \"$result\""
    exit 0
else
    echo "Test failed: endpoint responded \"$result\" , \"$expected_result\" was expected"
    exit 1
fi

