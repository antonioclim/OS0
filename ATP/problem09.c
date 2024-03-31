#include <stdio.h>

// Function to find the maximum subarray sum using Kadane's Algorithm
int maxSubarraySum(int arr[], int size) {
    int max_current = arr[0]; // Maximum sum ending at the current position
    int max_global = arr[0]; // Maximum sum found so far

    // Iterate through the array, updating max_current and max_global
    for (int i = 1; i < size; i++) {
        max_current = (arr[i] > max_current + arr[i]) ? arr[i] : (max_current + arr[i]);
        max_global = (max_global > max_current) ? max_global : max_current;
    }

    return max_global; // Return the overall maximum sum
}

// Driver program to test the above function
int main() {
    int arr[] = {-2, 1, -3, 4, -1, 2, 1, -5, 4};
    int size = sizeof(arr)/sizeof(arr[0]);
    printf("Maximum Subarray Sum is %d\n", maxSubarraySum(arr, size));
    return 0;
}


