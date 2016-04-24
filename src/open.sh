#!/usr/bin/env bash

# Open a directory in Nautilus file browser
# Usage: $ open /path/to/dir
# Note: this overrides /bin/open

nautilus $1 &> /dev/null  # Ignore icon not found error
exit 0
