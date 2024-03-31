#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// A structure to represent an edge in the graph
struct Edge {
    int src, dest, weight;
};

// A structure to represent a subset for union-find
struct subset {
    int parent;
    int rank;
};

// Function prototypes
int find(struct subset subsets[], int i);
void Union(struct subset subsets[], int x, int y);
int compare(const void* a, const void* b);
void KruskalMST(int V, struct Edge edges[], int E);

// Driver program to test above functions
int main() {
    /* Let's assume the graph has 4 vertices and 5 edges */
    int V = 4;  // Number of vertices in the graph
    int E = 5;  // Number of edges in the graph
    struct Edge edges[E];

    // Define edges of the graph
    edges[0].src = 0;
    edges[0].dest = 1;
    edges[0].weight = 10;

    edges[1].src = 0;
    edges[1].dest = 2;
    edges[1].weight = 6;

    edges[2].src = 0;
    edges[2].dest = 3;
    edges[2].weight = 5;

    edges[3].src = 1;
    edges[3].dest = 3;
    edges[3].weight = 15;

    edges[4].src = 2;
    edges[4].dest = 3;
    edges[4].weight = 4;

    // Function call to construct MST using Kruskal's algorithm
    KruskalMST(V, edges, E);
    return 0;
}

// Define the functions declared above
int find(struct subset subsets[], int i) {
    if (subsets[i].parent != i)
        subsets[i].parent = find(subsets, subsets[i].parent);
    return subsets[i].parent;
}

void Union(struct subset subsets[], int x, int y) {
    int rootX = find(subsets, x);
    int rootY = find(subsets, y);

    if (subsets[rootX].rank < subsets[rootY].rank)
        subsets[rootX].parent = rootY;
    else if (subsets[rootX].rank > subsets[rootY].rank)
        subsets[rootY].parent = rootX;
    else {
        subsets[rootY].parent = rootX;
        subsets[rootX].rank++;
    }
}

int compare(const void* a, const void* b) {
    struct Edge* a1 = (struct Edge*)a;
    struct Edge* b1 = (struct Edge*)b;
    return a1->weight - b1->weight;
}

void KruskalMST(int V, struct Edge edges[], int E) {
    struct Edge result[V];  // Tnis will store the resultant MST
    int e = 0;  // Index used for result[]
    int i = 0;  // Index used for sorted edges

    // Step 1: Sort all the edges in non-decreasing order of their weight
    qsort(edges, E, sizeof(edges[0]), compare);

    // Allocate memory for creating V subsets
    struct subset *subsets = (struct subset*) malloc(V * sizeof(struct subset));

    // Create V subsets with single elements
    for (int v = 0; v < V; ++v) {
        subsets[v].parent = v;
        subsets[v].rank = 0;
    }

    // Number of edges to be taken is equal to V-1
    while (e < V - 1 && i < E) {
        // Step 2: Pick the smallest edge and increment the index for next iteration
        struct Edge next_edge = edges[i++];

        int x = find(subsets, next_edge.src);
        int y = find(subsets, next_edge.dest);

        // If including this edge does not cause cycle, include it in result
        // and increment the index of result for next edge
        if (x != y) {
            result[e++] = next_edge;
            Union(subsets, x, y);
        }
        // Else discard the next_edge
    }

    // Print the resultant MST
    printf("Following are the edges in the constructed MST\n");
    for (i = 0; i < e; ++i)
        printf("%d -- %d == %d\n", result[i].src, result[i].dest, result[i].weight);

    // Free the memory allocated to subsets
    free(subsets);
}

