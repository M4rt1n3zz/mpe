# Content Table:

- [Network Discovery Script](#Network-Discovery-Script)
- [Usage](#Usage)
- [Description](#Description)
- [Notes](#Notes)
## Network Discovery Script

This Bash script performs network discovery on the local machine. It retrieves the local machine's IPv4 address, extracts the subnet, and scans the subnet for live hosts. Additionally, it performs port discovery on the local machine to identify open ports.

## Usage

Make the script executable:

```bash
   chmod +x spbuster.sh
```
Run the script:

```bash
./spbuster.sh
```
## Description
IPv4 Address Retrieval: The script uses ifconfig to retrieve the IPv4 address from the eth0 interface.

Subnet Extraction: It extracts the subnet from the obtained IPv4 address.

Host Discovery: The script performs host discovery on the local subnet by pinging each potential host.

Port Discovery: It conducts port discovery on the local machine, checking for open ports in the range of 1 to 1000.

Background Jobs: The script uses background jobs for efficiency, allowing multiple tasks to be executed simultaneously.

## Notes
If the script is unable to retrieve the IPv4 address from eth0, it will exit with an error message.

The discovered hosts and open ports will be displayed in the script's output.

Example Output:
```bash
➜  ~ ./host1.sh
Local IPv4 address: 192.168.1.10
Scanning subnet: 192.168.1

192.168.1.1
192.168.1.10
192.168.1.12
192.168.1.3

Scaning Ports on: 192.168.1.1

Scaning Ports on: 192.168.1.10
Port 22 is open
Port 80 is open
Port 445 is open

Scaning Ports on: 192.168.1.12
Port 21 is open

Scaning Ports on: 192.168.1.3
```
