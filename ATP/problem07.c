#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function to find the minimum of three numbers
int min(int x, int y, int z) {
    return x < y ? (x < z ? x : z) : (y < z ? y : z);
}

// Function to compute the Edit Distance between two strings
int editDistance(char *str1, char *str2) {
    int m = strlen(str1);
    int n = strlen(str2);
    int dp[m+1][n+1];
    int i, j;

    // Populate DP table
    for (i = 0; i <= m; i++) {
        for (j = 0; j <= n; j++) {
            // If first string is empty, only option is to insert all characters of second string
            if (i == 0)
                dp[i][j] = j;
            // If second string is empty, only option is to remove all characters of first string
            else if (j == 0)
                dp[i][j] = i;
            // If last characters are the same, ignore the last character and continue
            else if (str1[i-1] == str2[j-1])
                dp[i][j] = dp[i-1][j-1];
            // If the last character is different, consider all possibilities and find the minimum
            else
                dp[i][j] = 1 + min(dp[i-1][j],      // Remove
                                   dp[i][j-1],      // Insert
                                   dp[i-1][j-1]);   // Replace
        }
    }

    return dp[m][n]; // Return the edit distance
}

// Driver program to test the above function
int main() {
    char str1[] = "kitten";
    char str2[] = "sitting";
    printf("Edit Distance between '%s' and '%s' is %d\n", str1, str2, editDistance(str1, str2));
    return 0;
}

