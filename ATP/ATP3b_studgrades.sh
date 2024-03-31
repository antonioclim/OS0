#!/bin/bash

echo -n "Enter the file name: "
read file_name

# Open file for writing
exec 3>"$file_name"

# Loop for data entry
while true; do
    echo -n "Enter registration number (or 'exit' to finish): "
    read reg_num
    if [[ "$reg_num" == "exit" ]]; then
        break
    fi

    echo -n "Enter name: "
    read name
    echo -n "Enter year: "
    read year
    echo -n "Enter group: "
    read group
    echo -n "Enter number of grades (up to 15): "
    read num_grades

    # Initialize grades as a string
    grades=""
    for ((i = 0; i < num_grades; i++)); do
        echo -n "Enter grade $(($i + 1)): "
        read grade
        grades="$grades $grade"
    done

    # Pad the remaining grades with 0 if less than 15 grades were entered
    for ((i = num_grades; i < 15; i++)); do
        grades="$grades 0"
    done

    # Write student information to file
    echo "$reg_num $name $year $group $num_grades$grades" >&3
done

# Close file descriptor
exec 3>&-

echo "Data has been saved to $file_name."

