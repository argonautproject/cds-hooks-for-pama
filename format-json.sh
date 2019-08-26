#!/bin/bash

# Consider installing via cp format-json.sh .git/hooks/pre-commit

for i in $(find . -name *.json); do
    echo $i;
    cat $i | jq '.' | sponge $i;
done
