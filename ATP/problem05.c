#include <stdio.h>
#include <limits.h>

// Function to compute the minimum cost of matrix chain multiplication
// p[] is the array of dimensions of matrices
int MatrixChainOrder(int p[], int n) {
    /* m[][] is used to store the cost of multiplication of matrix chains.
       m[i,j] represents the minimum number of scalar multiplications needed
       to multiply the chain of matrices from i to j. */
    int m[n][n];
    int i, j, k, L, q;

    // cost is zero when multiplying one matrix
    for (i = 1; i < n; i++)
        m[i][i] = 0;

    // L is chain length
    for (L = 2; L < n; L++) {
        for (i = 1; i <= n - L; i++) {
            j = i + L - 1;
            m[i][j] = INT_MAX; // Assign to maximum value as default
            for (k = i; k <= j - 1; k++) {
                // q = cost/scalar multiplications
                q = m[i][k] + m[k + 1][j] + p[i - 1] * p[k] * p[j];
                if (q < m[i][j])
                    m[i][j] = q;
            }
        }
    }

    // Return the minimum cost
    return m[1][n - 1];
}

// Driver program to test the above function
int main() {
    int arr[] = {10, 30, 5, 60}; // Example dimensions
    int size = sizeof(arr)/sizeof(arr[0]);

    printf("Minimum number of multiplications is %d\n",
           MatrixChainOrder(arr, size));

    return 0;
}

