#!/bin/bash

# Quick Sort function in Bash
quick_sort() {
    local array=("${@}")
    local length=${#array[@]}

    if [ "$length" -le 1 ]; then
        echo "${array[@]}"
        return
    fi

    # Choose pivot (here, we choose the last element)
    local pivot=${array[length-1]}
    local left=()
    local right=()

    # Divide array into two parts based on pivot
    for (( i=0; i<length-1; i++ )); do
        if [[ "${array[i]}" < "$pivot" ]]; then
            left+=("${array[i]}")
        else
            right+=("${array[i]}")
        fi
    done

    # Recursively sort left and right arrays and concatenate results
    sorted_left=($(quick_sort "${left[@]}"))
    sorted_right=($(quick_sort "${right[@]}"))
    echo "${sorted_left[@]} $pivot ${sorted_right[@]}"
}

# Main program starts here
# Simulate reading IP addresses from a log file
ips=("192.168.1.102" "10.0.0.5" "172.16.0.1" "192.168.1.101" "10.0.0.1")

# Apply Quick Sort and store results
sorted_ips=($(quick_sort "${ips[@]}"))

# Output sorted IP addresses
echo "Sorted IP addresses:"
printf "%s\n" "${sorted_ips[@]}"

