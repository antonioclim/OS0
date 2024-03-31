#!/bin/bash

echo "Enter the word to search: "
read search_word

start_time=$(date +%s%N) # Start time of the script in nanoseconds

# Count the number of occurrences of the search word
occurrences=$(grep -rio --ignore-case "$search_word" ./TXT | wc -l)

# Count the number of files/documents
num_files=$(find ./TXT -type f | wc -l)

# Count the total number of words in all files
total_words=$(find ./TXT -type f -exec wc -w {} + | awk '{total += $1} END {print total}')

echo "Word to search: '$search_word'"
echo "Number of occurrences: $occurrences"
echo "Number of documents: $num_files"
echo "Total number of words across all documents: $total_words"

end_time=$(date +%s%N) # End time of the script in nanoseconds
execution_time=$((end_time - start_time)) # Calculate script execution time in nanoseconds
execution_time_ms=$((execution_time / 1000000)) # Convert execution time to milliseconds

echo "Execution time: $execution_time_ms milliseconds"

