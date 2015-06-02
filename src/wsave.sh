#!/usr/bin/env bash

# Download an entire website for offline viewing into the current directory
# Usage: $ wsave example.com www.example.com/part/tosave/

wget \
  --recursive \
  --no-clobber \
  --page-requisites \
  --adjust-extension \
  --convert-links \
  --domains $1 \
  --no-parent \
  $2
