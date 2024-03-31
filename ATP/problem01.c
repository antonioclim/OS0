#include <stdio.h>

// Function to calculate the nth Fibonacci number
int fibonacci_dynamic_programming(int n) {
    int fib[n+1];
    fib[0] = 0; // Base case assignment
    fib[1] = 1; // Base case assignment

    // Calculating Fibonacci numbers from 2 to n
    for (int i = 2; i <= n; i++) {
        fib[i] = fib[i - 1] + fib[i - 2];
    }
    return fib[n]; // Returning the nth Fibonacci number
}

int main() {
    int n = 10; // Example: Find the 10th Fibonacci number
    printf("The %dth Fibonacci number is: %d\n", n, fibonacci_dynamic_programming(n));
    return 0;
}

