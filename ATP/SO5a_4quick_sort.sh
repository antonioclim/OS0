#!/bin/bash

# Function to perform the Quick Sort algorithm on IP addresses
quicksort() {
    # Receives a list of IP addresses and stores them in a local array
    local ips=("$@")
    # Base case: if the list is empty or contains a single element, it's already sorted
    if [ ${#ips[@]} -le 1 ]; then
        echo "${ips[@]}"
        return
    fi
    # Choosing the first element of the array as the pivot for the Quick Sort
    local pivot=${ips[0]}
    # Initializing two arrays to hold IPs less than and greater than the pivot
    local lower=()
    local greater=()
    # Loop through the rest of the array, starting from the second element
    for ip in "${ips[@]:1}"; do
        # If the current IP is less than the pivot, add it to the 'lower' array
        if [[ $ip < $pivot ]]; then
            lower+=("$ip")
        else
            # Otherwise, add it to the 'greater' array
            greater+=("$ip")
        fi
    done
    # Recursively sort the lower and greater arrays and concatenate them with the pivot
    quicksort "${lower[@]}" && echo "$pivot" && quicksort "${greater[@]}"
}

# Function to check if an IP address is routable
is_routable() {
    # Takes an IP address as input and checks if it's routable
    local ip=$1
    # Regular expression matching non-routable (private) IP address ranges
    if [[ $ip =~ ^(10|172\.(1[6-9]|2[0-9]|3[0-1])|192\.168)\. ]]; then
        # If IP is non-routable, return "no"
        echo "no"
    else
        # If IP is routable, return "yes"
        echo "yes"
    fi
}

# Extracting current active sessions using 'who' command and parsing the output
readarray -t sessions <<< "$(who | awk '{print $1,$3,$4,$5}')"
# Initialize associative arrays for storing session details based on IP routability
declare -A routable_ips non_routable_ips session_info

# Loop through each session to categorize IPs and collect session info
for session in "${sessions[@]}"; do
    # Extracting user, start time, and IP from session string
    user=$(echo $session | awk '{print $1}')
    start_time=$(echo $session | awk '{print $2 " " $3}')
    ip=$(echo $session | awk '{print $4}' | tr -d '()')
    # Check if the IP address format is valid
    if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        # Determine if IP is routable or not
        route_status=$(is_routable "$ip")
        # Group IP addresses based on their routability
        if [ "$route_status" = "yes" ]; then
            routable_ips["$ip"]="$user $start_time"
        else
            non_routable_ips["$ip"]="$user $start_time"
        fi
        # Store session info by IP for later use
        session_info["$ip"]="$user $start_time"
    fi
done

# Sort IPs and group them based on their routability
sorted_routable_ips=( $(quicksort "${!routable_ips[@]}") )
sorted_non_routable_ips=( $(quicksort "${!non_routable_ips[@]}") )

# Display session information
echo "Session info:"
echo "Routable IP addresses:"
# Loop through sorted routable IPs
for ip in "${sorted_routable_ips[@]}"; do
    # Retrieve session info for each routable IP
    info="${routable_ips[$ip]}"
    # Attempt to fetch email details from the whois command for the provider
    provider=$(whois "$ip" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}' | awk -F'@' '{print $2}' | uniq)
    # Output user info, IP, session start time, and provider name
    echo "User: ${info%% *}, IP: $ip, Start Time: ${info#* }, Provider: ${provider:-Unknown}"
done

echo "Non-routable IP addresses:"
# Loop through sorted non-routable IPs
for ip in "${sorted_non_routable_ips[@]}"; do
    # Retrieve session info for each non-routable IP
    info="${non_routable_ips[$ip]}"
    # Output user info, IP, and session start time for non-routable IPs
    echo "User: ${info%% *}, IP: $ip, Start Time: ${info#* }"
done

