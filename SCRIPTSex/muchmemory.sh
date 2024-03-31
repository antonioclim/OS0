#!/bin/bash

# Initialize an array
declare -a big_array

# Loop to fill the array with large numbers
for i in {1..10000000}; do
    big_array[i]=$RANDOM$RANDOM$RANDOM$RANDOM
    if ! ((i % 100000)); then
        echo "Array size: $i"
    fi
done

# Print the final size of the array
echo "Final array size: ${#big_array[@]}"
echo "Memory usage increased. Please monitor your system's resources."


#This script creates an array and fills it with random numbers concatenated multiple times to make each array 
#element large. 
#The loop runs 10,000,000 times, and every 100,000th iteration, it outputs the current size of the array. 
#This can lead to significant memory usage, depending on the capacity of your system.

#Please use this script responsibly and monitor your system's resources while it's running. 
#It's designed for systems with sufficient memory and may lead to performance issues or instability 
#on systems with limited resources. 
#Always ensure you have a way to terminate such scripts if they start impacting system performance adversely.#
