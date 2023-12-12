#!/bin/bash

# Get the local machine's IPv4 address from eth0 using ifconfig
ipv4_address=$(ifconfig eth0 | awk '/inet / {print $2}' | cut -d ':' -f2)

if [ -z "$ipv4_address" ]; then
    echo "Unable to retrieve IPv4 address from eth0. Exiting."
    exit 1
fi

# Extract the subnet from the obtained IPv4 address
subnet=$(echo "$ipv4_address" | cut -d '.' -f 1-3)

echo "Local IPv4 address: $ipv4_address"
echo "Scanning subnet: $subnet"

# Perform host discovery on the local subnet and save alive hosts in a variable
alive_hosts=$(for i in {1..255}; do
    ip_address="$subnet.$i"
    (ping -c 1 "$ip_address" 2>/dev/null | grep "bytes from" | cut -d ' ' -f4 | tr -d ':' &)
done)

# Wait for all background jobs to finish
wait

# Display the alive hosts
echo -e "\n$alive_hosts"

# Export alive hosts into a variable
export alive_hosts

# Perform port discovery for each alive host
for host in $alive_hosts; do
    echo -e "\nScaning Ports on: $host"
    for port in {1..10000}; do
        { echo >/dev/tcp/"$host"/"$port"; } 2>/dev/null &&
        echo "Port $port is open" &
    done
    # Wait for all background jobs to finish before moving to the next host
    wait
done