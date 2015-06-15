#!/usr/bin/env bash

# Download a problem from Project Euler and save it into a Ruby file.
# Usage: $ ./get-problem 42

PROBNUM=$1
PADNUM=`printf "%03d" $PROBNUM`

# Download problem page, convert to plain text, and comment out.
wget -q https://projecteuler.net/problem=$PROBNUM -O $PADNUM.html
pandoc -f html -t plain --columns 76 -o $PADNUM.{txt,html}
sed -i 's/^\(.*\)$/# \1/' $PADNUM.txt
sed -i 's/^# $/#/' $PADNUM.txt

# Create a `.rb' file with shebang, TITLE, and problem body.
printf "#!/usr/bin/env ruby\n\n##\n" > $PADNUM.rb
cat $PADNUM.txt | tail -n +17 | head -n 1 | sed 's/\(.*\)/\U\1/' >> $PADNUM.rb
printf "##\n" >> $PADNUM.rb
cat $PADNUM.txt | head -n -4 | tail -n +24 >> $PADNUM.rb
printf "##\n" >> $PADNUM.rb

# Add some metadata about the problem.
STR=`sed -n '21s/\([0-9]\{1,2\}\)[a-z]\{2\}/\1/p' $PADNUM.txt`
PD=`echo $STR | grep -o -Pe '(?<=, )[0-9]{1,2} [A-Z][a-z]{2,8} [0-9]{4}(?=,)'`
SVS=`echo $STR | grep -o -Pe '[0-9]+(?=;)'`
PUBDATE=`date -I --date="$PD"`
SOLVERS=`echo $SVS | sed 's/\([0-9]\+\)\([0-9]\{3\}\)/\1,\2/'`
DIFFICULTY=`sed -n '21,22p' $PADNUM.txt | grep -o -Pe '[0-9]{1,3}(?=%)'`
printf "# Published:  $PUBDATE\n# Solved by:  $SOLVERS\n" >> $PADNUM.rb
printf "# Difficulty: 0.%02d\n##\n\n" $DIFFICULTY >> $PADNUM.rb

# Add timing skeleton.
printf "started = Time.now\n\n" >> $PADNUM.rb
printf "# CODE HERE\n\n" >> $PADNUM.rb
printf "stopped = Time.now\n" >> $PADNUM.rb
printf 'puts "Answer: #{answer}"\n' >> $PADNUM.rb
printf 'puts "Time taken: #{(stopped - started) * 1000}ms"\n' >> $PADNUM.rb

# Tidy up and make executable.
chmod +x $PADNUM.rb
rm $PADNUM.{txt,html}
