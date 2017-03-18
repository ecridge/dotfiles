#!/usr/bin/env bash

# Make a password more likely to satisfy arbitrary complexity requirements.

sed 's/^\(.\)/\u\1/' | tr ' ' 5 | sed 's/$/!/'
