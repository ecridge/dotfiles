#!/usr/bin/env bash

# Takes binary files and generates PNG images to represent them.
# Usage:  $ data2png file1.txt file2.mp3 ...

for file in "$@" ; do
  # Create empty PPM image.
  printf "P3\nWIDTH HEIGHT\nMAX\n" > $file.ppm

  # Append decimal file data and remove leading whitespace.
  od -A n -t d1 -v $file >> $file.ppm
  sed -i 's/^  //' $file.ppm

  # Complete any partial pixels.
  BYTES=`stat --printf="%s" $file`
  while [ $(( $BYTES % 3 )) -gt 0 ] ; do
    sed -i '$s/^\(.*\)$/\1    0/' $file.ppm
    (( BYTES++ ))
  done
  (( PIXELS = $BYTES / 3 ))

  # Split into rows and columns (as regularly as possible).
  HEIGHT=`dc -e "$PIXELS v p"`
  while [ $(dc -e "$PIXELS $HEIGHT % p") -gt 0 ] ; do
    (( HEIGHT-- ))
  done
  (( WIDTH = $PIXELS / $HEIGHT ))
  sed -i "2s/WIDTH HEIGHT/$WIDTH $HEIGHT/" $file.ppm

  # Find maximum value.
  # MAX=`tail -n +4 $file.ppm | grep -oe '[0-9]\{1,3\}' | sort -n | tail -n 1`
  MAX=127  # Gives better consistency when only using ASCII data.
  sed -i "3s/MAX/$MAX/" $file.ppm

  # Convert to PNG using ImageMagick
  convert $file.ppm $file.png
  rm $file.ppm
done
