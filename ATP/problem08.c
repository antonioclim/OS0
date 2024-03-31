#include <stdio.h>
#include <stdlib.h>

// Function to find maximum of two integers
int max(int a, int b) {
    return (a > b) ? a : b;
}

// Function for solving the Rod Cutting problem using Dynamic Programming
int rodCutting(int price[], int n) {
    int *val = (int*)malloc((n+1) * sizeof(int));
    int i, j;

    // Initialize the value array
    val[0] = 0;

    // Build the table val[] in bottom-up manner
    for (i = 1; i<=n; i++) {
        int max_val = -1;
        for (j = 0; j < i; j++)
            max_val = max(max_val, price[j] + val[i-j-1]);
        val[i] = max_val;
    }

    int result = val[n]; // Store the result before freeing memory
    free(val); // Free the dynamically allocated memory

    return result; // Return the maximum value obtainable
}

// Driver program to test the above function
int main() {
    int prices[] = {1, 5, 8, 9, 10, 17, 17, 20};
    int size = sizeof(prices)/sizeof(prices[0]);
    printf("Maximum Obtainable Value is %d\n", rodCutting(prices, size));
    return 0;
}

