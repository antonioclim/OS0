#!/bin/bash

# Recursive function to solve Towers of Hanoi
# Inputs are: number of disks (n), starting rod (ti), target rod (tf), and auxiliary rod (tint)
# The function will print each move
solve_hanoi() {
    local n=$1      # Number of disks
    local ti=$2     # Initial rod
    local tf=$3     # Final rod
    local tint=$4   # Intermediate rod

    # If there is only one disk, move it from the initial rod to the final rod
    if [[ $n -eq 1 ]]; then
        echo "Move disk from rod $ti to rod $tf"
    else
        # Move n-1 disks from the initial rod to the intermediate rod, using the final rod as auxiliary
        solve_hanoi $(($n - 1)) $ti $tint $tf
        # Move the remaining disk to the final rod
        echo "Move disk from rod $ti to rod $tf"
        # Move the n-1 disks from the intermediate rod to the final rod, using the initial rod as auxiliary
        solve_hanoi $(($n - 1)) $tint $tf $ti
    fi
}

# Main part of the script
echo -n "Enter the number of disks: "
read n

# Call the solve_hanoi function with the number of disks and the rods labeled as 1, 3, and 2 respectively
solve_hanoi $n 1 3 2

