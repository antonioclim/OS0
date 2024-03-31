#!/bin/bash

# Read the word to search for
read -p "Enter the word to search for: " word

# Convert the word to lowercase for case-insensitive search
word=${word,,}

# Initialize total count and file count
total_count=0
file_count=0

# Loop through all files under /home/TXT
for file in ./TXT/**/*.txt; do
  # Check if file is readable
  if [[ -r "$file" ]]; then
    # Count occurrences of the word in the current file
    count=$(grep -oi "\<$word\>" "$file" | wc -l)

    # Add the count to the total and file count
    total_count=$((total_count + count))
    file_count=$((file_count + 1))
  else
    echo "Warning: Skipping unreadable file: $file"
  fi
done

# Print results
if [[ $file_count -gt 0 ]]; then
  echo "Total occurrences of '$word' in $file_count files: $total_count"
else
  echo "No files found under /home/TXT that contain the word '$word'."
fi
