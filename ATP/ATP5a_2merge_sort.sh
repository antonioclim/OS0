#!/bin/bash

# Function to merge two sorted subarrays of arr
# Arguments: arr, starting index of first subarray, ending index of second subarray
merge() {
    local start=$1
    local middle=$2
    local end=$3
    local -a merged=()
    local i=$start
    local j=$((middle+1))

    # Merge the two arrays while there are elements in both
    while [[ $i -le $middle && $j -le $end ]]; do
        if [[ ${arr[i]} -le ${arr[j]} ]]; then
            merged+=(${arr[i]})
            ((i++))
        else
            merged+=(${arr[j]})
            ((j++))
        fi
    done

    # Copy any remaining elements from the first subarray
    while [[ $i -le $middle ]]; do
        merged+=(${arr[i]})
        ((i++))
    done

    # Copy any remaining elements from the second subarray
    while [[ $j -le $end ]]; do
        merged+=(${arr[j]})
        ((j++))
    done

    # Copy the merged temporary array back into the original array
    for ((i = $start; i <= $end; i++)); do
        arr[$i]=${merged[i-$start]}
    done
}

# Recursive function to perform merge sort
# Arguments: starting index, ending index
merge_sort() {
    local start=$1
    local end=$2
    if [[ $start -lt $end ]]; then
        local middle=$(((start+end)/2))
        merge_sort $start $middle
        merge_sort $((middle+1)) $end
        merge $start $middle $end
    fi
}

# Main script
echo "Enter numbers separated by spaces:"
read -r -a arr  # Read the array of numbers into 'arr'

# Perform merge sort on the array
merge_sort 0 $((${#arr[@]}-1))

# Print the sorted array
echo "Sorted array:"
printf "%s " "${arr[@]}"
echo  # Newline for clean output

