# Content Table:

- [Linux Enumeration Script (MPE](#Linux-Enumeration-Script-(MPE))
- [Overview](#Overview)
- [Features](#Features)
- [To-Do List](#To-Do-List)

# Linux Enumeration Script (MPE)  
This Bash script, named "MPE - Linux Privilege Escalation & Enumeration Script," is designed for privilege escalation information gathering and system enumeration on Linux machines. It provides valuable insights into the system's configuration, user privileges, and potential security vulnerabilities.  
## Make the script executable:    

```bash
chmod +x mpe.sh
```

Run the script:
```bash
./linux_enumeration.sh
```
## Overview

- **Version:** v0.33
- **Author:** m4rt1n3zz
- **Website:** [redops.cc](https://redops.cc/)

## Features

- Kernel and architecture information check
- Display system issue and release information
- Check permissions on /etc/passwd
- List users with shell access
- Display current user and group information
- Check for SSH keys in home directories
- Check sudo privileges
- Check configuration files in /var/www/
- List useful binaries installed on the target
- Check for SUID and GUID binaries
- Perform host discovery on the local subnet
- Scan the top 10000 ports on the local machine
- Display network status using netstat
- Check crontabs
- Display processes running as root
- Suggest running `Pspy` for advanced monitoring

## To-Do List

1. Add more checks
2. Implement improvements

Feel free to explore the script's output for detailed system information and potential security risks.

Happy Enumeration!