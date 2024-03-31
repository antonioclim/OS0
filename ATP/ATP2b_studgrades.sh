#!/bin/bash

echo -n "Enter the file name: "
read file_name

# Continue until the user decides to stop
while true; do
    echo -n "Enter the registration number (or 'exit' to finish): "
    read reg_num
    # Check if the user wants to exit
    if [[ "$reg_num" == "exit" ]]; then
        break
    fi

    # Read the rest of the student's information
    echo -n "Enter first name and last name: "
    read name
    echo -n "Enter year: "
    read year
    echo -n "Enter group: "
    read group

    # Prepare the line to be written to the file
    line="$reg_num $name $year $group"

    # Read and append the grades
    for i in {1..10}; do
        echo -n "Enter grade $i: "
        read grade
        # If no grade is provided, assume 0
        grade=${grade:-0}
        line+=" $grade"
    done

    # Write the line to the file
    echo $line >> "$file_name"

    echo "Student information recorded."
done

echo "All data has been saved to $file_name."

