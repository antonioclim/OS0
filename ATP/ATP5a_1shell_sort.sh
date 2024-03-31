#!/bin/bash

# A simpler example of the Shell sort algorithm in Bash

# Function to perform Shell sort on an array of integers
# Arguments: None, but uses global array 'arr'
shell_sort() {
    local gap i j temp
    local n=${#arr[@]} # Get the length of the array

    # Start with a large gap, then reduce the gap
    for ((gap=n/2; gap>0; gap/=2)); do
        # Do a gapped insertion sort for this gap size
        # The first element in the gap is assumed to be sorted, we start from the second
        for ((i=gap; i<n; i++)); do
            # Save arr[i] to temp and make a hole at position i
            temp=${arr[i]}
            # Shift earlier gap-sorted elements up until we find the correct position for arr[i]
            for ((j=i; j>=gap && arr[j-gap]>temp; j-=gap)); do
                arr[j]=${arr[j-gap]} # Move the gap-sorted element forward
            done
            # Put temp (the original arr[i]) in its correct position
            arr[j]=$temp
        done
    done
}

# Main program starts here
echo "Enter numbers separated by spaces:"
read -a arr # Read the array of numbers into 'arr'

# Call the shell_sort function
shell_sort

# Print the sorted array
echo "Sorted array:"
echo "${arr[@]}"

# Add explanations as comments

# The Concept:
# Shell sort is like an improved version of insertion sort. With insertion sort,
# you take one book at a time and place it in the correct position relative to the books you've already sorted,
# moving one step at a time. But if a book needs to be moved a long way, it could take a lot of steps.
# Here’s where Shell sort steps in—it starts sorting books (or numbers in an array) that are far apart from each other first,
# reducing the distance between books to be compared as it goes along. This method helps move books into their correct positions
# more quickly than moving them one space at a time.

# The Steps:
# 1. Choosing Gaps: You start with a large 'gap' between the books you're comparing.
#    For example, if you have 12 books, you might start with a gap of 6 books. You compare the book in position 1 with the book in position 7,
#    the book in position 2 with the book in position 8, and so on, moving them as needed so that the one that belongs earlier in the sequence goes first.
# 2. Reducing the Gap: Once you've gone through all the books with that initial gap, you reduce the gap size.
#    If the first gap was 6, you might reduce it to 3. Now you compare the book in position 1 with the book in position 4,
#    the book in position 2 with the book in position 5, and so on.
# 3. Continuing the Process: You keep reducing the gap and reordering the books until the gap is 1.
#    When the gap is 1, Shell sort becomes just like insertion sort, but by this time, most of the books are already close to their final positions,
#    so this last step is much quicker than starting with insertion sort from the beginning.
# 4. Finished: Once you’ve done the comparisons and movements for a gap of 1, your books (or array elements) are sorted!

# Why It's Better:
# Imagine if one of the first books belongs at the very end. With regular insertion sort, you'd be moving that one book a little bit at a time,
# all the way to the end, which takes a lot of steps. But with Shell sort, because you start with big gaps, you can quickly leap it closer to where it needs to be,
# then fine-tune its position as the gaps get smaller.

# In Practice:
# When sorting numbers instead of books, you follow the same principle. You start with a large gap and reduce it over time.
# Initially, you make large adjustments, jumping over several elements to put numbers closer to where they belong,
# and then you make smaller and smaller adjustments to finalize the order.

# Simplified Example:
# If you had the numbers [34, 8, 64, 51, 32, 21] and started with a gap of 3, you first compare and potentially swap pairs like (34 and 51) and (8 and 32)
# based on their values. After going through this process and reducing the gap each time, the numbers start to "drift" to their correct positions,
# leading to a fully sorted list with far fewer moves than if you moved each number only one spot at a time.

