#!/bin/bash

# This function performs the partition part of Quick Sort.
# It rearranges elements so that all elements less than the pivot come before it,
# and all elements greater come after it.
partition() {
    # These are the starting and ending indexes of the segment of the array we're dealing with.
    local low=$1
    local high=$2
    # This is the pivot element around which we're going to do the partitioning.
    local pivot=${global_arr[high]}
    local i=$((low - 1))
    local j temp

    # We iterate through the segment of the array from 'low' to 'high-1'
    # (since 'high' is the pivot).
    for ((j=low; j<=high-1; j++)); do
        # If the current element is less than or equal to the pivot,
        # it should be moved to the left side of the pivot.
        if [[ ${global_arr[j]} -le $pivot ]]; then
            ((i++))
            # Swapping global_arr[i] and global_arr[j]
            temp=${global_arr[i]}
            global_arr[i]=${global_arr[j]}
            global_arr[j]=$temp
        fi
    done
    # Swap the element just after the last element smaller than the pivot
    # with the pivot itself.
    temp=${global_arr[i + 1]}
    global_arr[i + 1]=${global_arr[high]}
    global_arr[high]=$temp

    # Return the partitioning index.
    return $((i + 1))
}

# This function performs the Quick Sort algorithm.
# It takes in a segment of the array defined by 'low' and 'high' indices.
quick_sort() {
    local low=$1
    local high=$2
    local pi

    if [[ low -lt high ]]; then
        # This call partitions the array and returns the position where
        # the partition is made.
        partition $low $high
        pi=$?
        # Recursively call Quick Sort on the sub-arrays created by the partition.
        quick_sort $low $((pi - 1))
        quick_sort $((pi + 1)) $high
    fi
}

# Main script starts here.

# Prompt user for input
echo "Enter numbers separated by spaces:"
# Read the numbers into a global array 'global_arr'.
read -r -a global_arr  

# Get the number of elements in the array.
array_length=${#global_arr[@]}

# Call the Quick Sort function on the entire array.
quick_sort 0 $((array_length - 1))

# Print the sorted array.
echo "Sorted array:"
# This line prints each element of the array followed by a space.
printf "%s " "${global_arr[@]}"
# Print a newline for clean output
echo

