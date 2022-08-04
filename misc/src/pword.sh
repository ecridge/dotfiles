#!/usr/bin/env bash

# Lazy Diceware password generator.

DATA_CHECK=37ed6e9b146abe2b96f22a36a0610384ce679036166fec9536e2ca8cb39ff462
DEFAULT_WORDS=6
WORD_LIST="$HOME/resources/diceware"


# Determine number of words to generate.
if [[ $# -eq 1 ]]; then
    nwords=$1
else
    nwords=$DEFAULT_WORDS
fi


# Verify the integrity of the word list.
chksum=$(sha256sum "$WORD_LIST" | cut -d' ' -f1)
if [[ $chksum != $DATA_CHECK ]]; then
    echo "word list has been tampered with"
    exit 1
fi


# Read and discard 16 bytes.
dd bs=16 count=1 if=/dev/random of=/dev/null status='none'


# Generate and output the words.
(( i = 0 ))
while [[ $i -lt $nwords ]]; do
    if [[ $i -ne 0 ]]; then
        echo -n ' '
    fi
    idx=$(ruby << EOF
require 'securerandom'
p SecureRandom.random_number(7776)
EOF
)
    word=$(sed -n "${idx}p" "$WORD_LIST")
    echo -n "$word"
    (( i++ ))
done
echo
