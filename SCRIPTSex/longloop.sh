#!/bin/bash

# Define N - the upper limit of the loop
N=100

# Loop from 1 to N
for (( i=1; i<=N; i++ ))
do
    # Calculate the square of i
    square=$((i * i))

    # Print the result
    echo "The square of $i is $square"

    # Sleep for a second to slow down the loop
#    sleep 1
done

echo "Finished calculating squares."

