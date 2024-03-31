#!/bin/bash

# Warning: This script is designed for educational purposes only.
# It will consume a significant amount of memory and potentially swap space,
# which can affect system performance. Use with caution.

# Function to consume memory
consume_memory() {
    local -a num_array
    local result=1

    for i in {1..100000}; do
        # Perform some math operations and store results in an array
        result=$((result * i % 123456789))
        num_array[i]=$result
    done
}

# Main loop to continuously consume memory
while true; do
    consume_memory
    echo "Memory consumption phase completed. Press Ctrl+C to stop."
    sleep 1
done


#This script defines a function consume_memory that creates an array and fills it with the 
#results of a series of mathematical operations. 
#It then enters an infinite loop, repeatedly calling this function to continuously consume memory. 

