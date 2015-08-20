#!/usr/bin/env bash

# Format source code into an 80 column PDF for printing
# Usage: $ cprint lang file

enscript --header '$n||Page $% of $=' \
         --footer 'hi' \
         --line-numbers \
         --word-wrap \
         --mark-wrapped-lines=arrow \
         --color=1 \
         --pretty-print=$1 \
         --output=$2.ps \
         $2
