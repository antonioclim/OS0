#!/bin/bash

# Define a function to solve the fractional knapsack problem
solve_knapsack() {
    local -a capacities=("${!1}")
    local -a values=("${!2}")
    local total_capacity=$3
    local -i num_items=${#capacities[@]}
    local -a solution=()
    local -a gain=()
    local total_gain=0
    local remaining_capacity=$total_capacity

    # Calculate value per unit for each item and sort items by this metric
    for (( i = 0; i < num_items; i++ )); do
        value_per_unit[i]=$(bc <<< "scale=4; ${values[$i]} / ${capacities[$i]}")
        indices[i]=$i
    done

    # Sort items by value per unit (Bubble Sort for demonstration)
    for (( i = 0; i < num_items; i++ )); do
        for (( j = 0; j < num_items - i - 1; j++ )); do
            if (( $(bc <<< "${value_per_unit[j]} < ${value_per_unit[j + 1]}") )); then
                # Swap value_per_unit
                temp=${value_per_unit[j]}
                value_per_unit[j]=${value_per_unit[j + 1]}
                value_per_unit[j + 1]=$temp
                # Swap indices
                temp=${indices[j]}
                indices[j]=${indices[j + 1]}
                indices[j + 1]=$temp
            fi
        done
    done

    # Compute the solution by filling the knapsack
    for (( i = 0; i < num_items; i++ )); do
        idx=${indices[i]}
        if (( $(bc <<< "${capacities[idx]} <= $remaining_capacity") )); then
            solution[idx]=1
            gain[idx]=${values[idx]}
            remaining_capacity=$(bc <<< "$remaining_capacity - ${capacities[idx]}")
            total_gain=$(bc <<< "$total_gain + ${values[idx]}")
        else
            solution[idx]=$(bc <<< "scale=4; $remaining_capacity / ${capacities[idx]}")
            gain[idx]=$(bc <<< "scale=4; ${values[idx]} * ${solution[idx]}")
            total_gain=$(bc <<< "$total_gain + ${gain[idx]}")
            break # No room for more items
        fi
    done

    # Print the solution and total gain
    for (( i = 0; i < num_items; i++ )); do
        echo "Item $((i + 1)): Take ${solution[i]} (Gain: ${gain[i]})"
    done
    echo "Total Gain: $total_gain"
}

# Main script starts here
read -p "Enter total capacity of the knapsack: " total_capacity
read -p "Enter number of items: " num_items

declare -a capacities=()
declare -a values=()

for (( i = 0; i < num_items; i++ )); do
    read -p "Enter capacity and value for item $((i + 1)) (separated by a space): " cap val
    capacities[i]=$cap
    values[i]=$val
done

solve_knapsack capacities[@] values[@] $total_capacity

