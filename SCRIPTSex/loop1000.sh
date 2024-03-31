#!/usr/bin/env bash
#Bash provides a powerful way to manipulate with text strings using #, ##,% and %% — it called bash variable expansions.
#Using this syntax, you can cut the needful by the pattern without executing external commands, so it will work really fast.
STRING="Name:Date:Shell"

#VAR1: Using cut the execution time will be almost 1 sec

echo "using cut"
time for A in {1..1000}
do
  cut -d ":" -f 3 > /dev/null <<<"$STRING"
done

#VAR2: Using ## improvments in time execution are bigger
#The second option does not start child process (cut), and does not use pipes at all, which should work much faster.

echo "using ##"
time for A in {1..1000}
do
 echo "${STRING##*:}" > /dev/null
done

#Well, the above example is a bit artificial .. let's see next example
