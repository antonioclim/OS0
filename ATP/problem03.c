#include <stdio.h>
#include <string.h>

// Function to find the maximum of two integers
int max(int a, int b) {
    return (a > b) ? a : b;
}

// Function to find the longest common subsequence of X and Y
void longest_common_subsequence(char *X, char *Y) {
    int m = strlen(X);
    int n = strlen(Y);
    int L[m+1][n+1];
    int i, j;

    // Building the LCS table in bottom-up fashion
    for (i=0; i<=m; i++) {
        for (j=0; j<=n; j++) {
            if (i == 0 || j == 0)
                L[i][j] = 0;
            else if (X[i-1] == Y[j-1])
                L[i][j] = L[i-1][j-1] + 1;
            else
                L[i][j] = max(L[i-1][j], L[i][j-1]);
        }
    }

    // Following the path in the matrix to construct the LCS string
    int index = L[m][n];
    char lcs[index+1];
    lcs[index] = '\0'; // Set the terminating character

    // Start from the right-bottom corner and trace the LCS
    i = m, j = n;
    while (i > 0 && j > 0) {
        if (X[i-1] == Y[j-1]) {
            lcs[index-1] = X[i-1]; // Append current character to LCS
            i--; j--; index--;     
        }
        else if (L[i-1][j] > L[i][j-1])
            i--;
        else
            j--;
    }

    printf("LCS of %s and %s is %s\n", X, Y, lcs);
}

// Driver program to test the above function
int main() {
    char X[] = "AGGTAB";
    char Y[] = "GXTXAYB";
    longest_common_subsequence(X, Y);
    return 0;
}

