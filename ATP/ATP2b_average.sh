#!/bin/bash

echo -n "Enter the file name: "
read file_name

if [ ! -f "$file_name" ]; then
    echo "The file cannot be opened."
    exit 1
fi

# Variables to store totals and counts
total_students=0
total_sum=0
max_average=0

# Read from the file line by line
while read -r line; do
    # Break down the line into individual components
    read -ra arr <<< "$line"
    # Initialize sum and pass flag for this student
    sum=0
    pass=1

    # Loop over grades (from the 4th element to the 13th)
    for i in {3..12}; do
        # Add each grade to the sum
        sum=$((sum + arr[i]))
        # If any grade is below 5, mark as fail
        if [ "${arr[i]}" -lt 5 ]; then
            pass=0
        fi
    done

    # If pass flag is still set, calculate average and update totals
    if [ "$pass" -eq 1 ]; then
        average=$(echo "$sum / 10" | bc -l)
        total_sum=$(echo "$total_sum + $average" | bc -l)
        total_students=$((total_students + 1))
        # Update maximum if this student's average is higher
        if (( $(echo "$average > $max_average" |bc -l) )); then
            max_average=$average
        fi
    fi
done < "$file_name"

# If there were full-time students, print the averages
if [ "$total_students" -gt 0 ]; then
    overall_average=$(echo "$total_sum / $total_students" | bc -l)
    printf "\nAverage: %.2f" $overall_average
    printf "\nHighest average: %.2f\n" $max_average
else
    echo "There are no full-time students."
fi

