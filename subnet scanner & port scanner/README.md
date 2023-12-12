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

Port Discovery: It conducts port discovery on the local machine, checking for open ports in the range of 1 to 10000 with a timeout of 1 second per port.

Background Jobs: The script uses background jobs for efficiency, allowing multiple tasks to be executed simultaneously.

## Notes
If the script is unable to retrieve the IPv4 address from eth0, it will exit with an error message.

The discovered hosts and open ports will be displayed in the script's output.

Example Output:
```bash
Local IPv4 address: 192.168.1.1
Scanning Subnet: 192.168.1

Discovered Hosts:
192.168.1.2
192.168.1.3

Open Ports on 192.168.1.1:
Port 22 is open
Port 80 is open
```