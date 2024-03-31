#!/bin/bash

# Function to read vector elements from a file into memory
preluare_vector_1() {
    local nume_fisier="$1"  # The name of the file
    local -n arr=$2         # The name of the array to fill (Bash 4.3+ feature)
    local i=0               # Counter for number of elements

    while IFS= read -r line || [[ -n "$line" ]]; do
        arr[i++]="$line"  # Assign line to the array and increment counter
    done < "$nume_fisier"
}

# Main part of the script
echo -n "Introduceti numele fisierului: "
read nume_fisier  # Read the file name

declare -a a  # Declare 'a' as an array
preluare_vector_1 "$nume_fisier" a  # Call the function to fill the array

# Print the elements of the array
for (( i = 0; i < ${#a[@]}; i++ )); do
    printf "%4.1f ," "${a[i]}"
done
echo  # Print a newline at the end

