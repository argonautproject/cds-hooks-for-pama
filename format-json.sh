#!/bin/bash

# For `sponge`, see the "moreutils" package (Mac, Ubuntu)
# Consider installing via cp format-json.sh .git/hooks/pre-commit

for i in $(find . -name *.json); do
    echo $i;
    cat $i | jq '.' | sponge $i;
done
