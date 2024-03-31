#!/bin/bash

# Prompt the user for the word to search
echo "Please enter the word you want to search:"
read searchWord

# Search the ./TXT directory and its subdirectories for the specified word
# -r: recursive search
# -i: ignore case
# -o: only matching words, each on a new line
# wc -l: count the lines, which corresponds to the number of occurrences
occurrences=$(grep -rio "$searchWord" ./TXT | wc -l)

# Display the total count of occurrences
echo "The word '$searchWord' occurs $occurrences times in the files under ./TXT."

