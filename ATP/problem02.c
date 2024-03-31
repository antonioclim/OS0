#include <stdio.h>

// Function to find the maximum of two integers
int max(int a, int b) {
    return (a > b) ? a : b;
}

// Implementation of 0/1 Knapsack Problem using Dynamic Programming
int knapsack_01(int values[], int weights[], int n, int capacity) {
    int table[n+1][capacity+1];

    // Build table K[][] in a bottom-up manner
    for (int i = 0; i <= n; i++) {
        for (int w = 0; w <= capacity; w++) {
            if (i == 0 || w == 0)
                table[i][w] = 0;
            else if (weights[i - 1] <= w)
                table[i][w] = max(values[i - 1] + table[i - 1][w - weights[i - 1]], table[i - 1][w]);
            else
                table[i][w] = table[i - 1][w];
        }
    }
    return table[n][capacity]; // Return the maximum value that can be put in the knapsack
}

// Example usage
int main() {
    int values[] = {60, 100, 120}; // Example values
    int weights[] = {10, 20, 30}; // Example weights
    int capacity = 50; // Example knapsack capacity
    int n = sizeof(values)/sizeof(values[0]);
    printf("Maximum value achievable is %d\n", knapsack_01(values, weights, n, capacity));
    return 0;
}

