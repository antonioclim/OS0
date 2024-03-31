#!/bin/bash

# Function to write vector elements to a file
scriere_vector() {
    local nume_fisier="$1"  # The name of the file is passed as the first argument
    local x                 # Variable to store the user input

    # Loop indefinitely until the user breaks out
    while true; do
        echo -n "x= "  # Prompt the user to enter a value
        read x        # Read the value into variable x
        # If the user simply presses enter, assume they want to stop
        if [[ -z "$x" ]]; then
            break  # Exit the loop if no input is given (end-of-file equivalent in Bash)
        fi
        # Write the input to the file, ensuring it's treated as a floating point number
        printf "%4.2f\n" "$x" >> "$nume_fisier"
    done
}

# Main part of the script
echo -n "Introduceti numele fisierului: "  # Prompt for the file name
read nume_fisier                          # Read the file name

# Call the function with the file name as an argument
scriere_vector "$nume_fisier"

