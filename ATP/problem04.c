#include <stdio.h>
#include <string.h> // Include this header to use memset

// Function to calculate the number of ways to make change for a given amount
void coin_change(int coins[], int numberOfCoins, int amount) {
    long ways[amount + 1]; // Array to store the number of ways to make change
    memset(ways, 0, sizeof(ways)); // Initialize all values in ways to 0
    ways[0] = 1; // There's exactly one way to make change for zero amount: use no coins

    // Update the ways array for each coin
    for (int i = 0; i < numberOfCoins; i++) {
        for (int j = coins[i]; j <= amount; j++) {
            ways[j] += ways[j - coins[i]];
        }
    }

    printf("Number of ways to make change for %d: %ld\n", amount, ways[amount]);
}

// Driver function
int main() {
    int coins[] = {1, 2, 5}; // Coin denominations
    int amount = 5; // Amount to make change for
    int numberOfCoins = sizeof(coins)/sizeof(coins[0]);

    coin_change(coins, numberOfCoins, amount);
    return 0;
}
