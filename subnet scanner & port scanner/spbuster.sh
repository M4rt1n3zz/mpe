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
echo "Scanning Subnet: $subnet"

# Perform host discovery on the local subnet
for i in {1..255}; do
    ip_address="$subnet.$i"
    (ping -c 1 "$ip_address" 2>/dev/null | grep "bytes from" | cut -d ' ' -f4 | tr -d ':' &)
done

# Wait for all background jobs to finish
wait

# Perform port discovery on the local machine with a timeout of 1 second per port using a for loop
echo -e "\nOpen Ports on $ipv4_address:"
for port in {1..10000}; do
    { echo >/dev/tcp/"$ipv4_address"/"$port"; } 2>/dev/null &&
    echo "Port $port is open" &
done

# Wait for all background jobs to finish
wait