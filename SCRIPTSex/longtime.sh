#!/bin/bash

# Initialize sum variable
total_sum=0

# Loop from 1 to 1000000
for i in {1..1000000}
do
    total_sum=$((total_sum + i))
done

# Print the total sum
echo "The total sum is: $total_sum"

