#!/bin/bash
# TODO List
# 1. Add more checks
# 2. Do some improvments 

# My Privilege Escalation Info and my Blog Website
version="Version: v0.33"
name="-=MPE=- Linux Enumeration Script"
site="https://redops.cc"
echo -e "\e[33m$name\e[0m\n\e[31m$version\e[0m \e[32m$site\e\n[0m"

# Function to check Kernel
check_kernel() {
    echo -e "\e[33m[*] Checking Kernel:\e[0m"
    uname -a
}

# Function to check Arch
check_arch() {
    echo -e "\e[33m[*] Checking Arch:\e[0m"
    file /bin/bash |cut -b 12- |grep "x64\|x86\|86\|64\|bit\|version" --color=auto
}

# Function to check Issue & Release
check_issue_release() {
    echo -e "\e[33m[*] Checking Issue & Release:\e[0m"
    cat /etc/issue;cat /etc/*-release
}

# Checking Permissions on /etc/passwd
check_perm_passwd() {
    echo -e "\e[33m[*] Checking Permissions on /etc/passwd:\e[0m"
    ls -la /etc/passwd
}

# Checking Users
check_users() {
    echo -e "\e[33m[*] Checking Users:\e[0m"
    cat /etc/passwd | grep "sh$"
}

# Current User
check_current_user() {
  echo -e "\e[33m[*] Current User & Group Info:\e[0m"
  id
}

# Check for ssh Keys in Home Directory
check_ssh_keys() {
    echo -e "\e[33m[*] Checking for ssh Keys in /home:\e[0m"
    find /home/ -type f -name '*' | grep -i  "authorized_keys\|id_rsa\|known_hosts" --color=auto
}

# Function to check sudo privileges
check_sudo_privileges() {
    echo -e "\e[33m[*] Checking Sudo Privileges:\e[0m"
    if sudo -l >/dev/null 2>&1; then
        sudo=`sudo -l`
        echo -e "\e[97m $sudo \e[0m"
    else
        echo -e "\e[31m[] Password is Required:\e[0m  \e[35m sudo -l \e[0m"
    fi
}

# Function to check config files
check_config_files() {
    echo -e "\e[33m[*] Checking Config Files in /var/www/:\e[0m"
    find /var/www/ -type f -name 'conf*' | grep -i  "conf\|config\|configuration" --color=auto
}

# Useful Binaries on the Target
check_binaries() {
    echo -e "\e[33m[*] Useful Binaries Installed:\e[0m"
    which gcc;
    which cc;
    which python;
    which python3;
    which perl;
    which wget;
    which curl;
    which fetch;
    which nc;
    which ncat;
    which nc.traditional;
    which socat
}

# Function to check for SUID binaries
check_suid_binaries() {
    echo -e "\e[33m[*] SUID Binaries:\e[0m"
    while IFS= read -r line; do
        permissions=$(echo "$line" | awk '{print $1}')
        file=$(echo "$line" | awk '{print $NF}')
        if [[ $permissions =~ ^.{4}.{3}x ]]; then
            echo -e "\e[34m$file\e[0m"
        else
            echo "$file"
        fi
    done < <(find / -perm -4000 -type f -exec ls -l {} \; 2>/dev/null)
}

# Function to check for GUID binaries
check_guid_binaries() {
    echo -e "\e[33m[*] GUID Binaries:\e[0m"
    while IFS= read -r line; do
        permissions=$(echo "$line" | awk '{print $1}')
        file=$(echo "$line" | awk '{print $NF}')
        if [[ $permissions =~ ^.{4}.....x ]]; then
            echo -e "\e[97m$file\e[0m"
        else
            echo "$file"
        fi
    done < <(find / -perm -2000 -type f -exec ls -l {} \; 2>/dev/null)
}

# Get the local machine's IPv4 address from eth0 using ifconfig
host_discovery() {
ipv4_address=$(ifconfig eth0 | awk '/inet / {print $2}' | cut -d ':' -f2)

if [ -z "$ipv4_address" ]; then
    echo "Unable to retrieve IPv4 address from eth0. Exiting."
    exit 1
fi

# Extract the subnet from the obtained IPv4 address
subnet=$(echo "$ipv4_address" | cut -d '.' -f 1-3)

echo -e "\e\n[33m[*] Local IPv4 address:\e[0m \e[97mIP: $ipv4_address\e[0m"
echo -e "\e\n[33m[*] Scanning Subnet:\e[0m \e[97mIPs: $subnet\e[0m"

# Perform host discovery on the local subnet
for i in {1..255}; do
    ip_address="$subnet.$i"
    (ping -c 1 "$ip_address" 2>/dev/null | grep "bytes from" | cut -d ' ' -f4 | tr -d ':' &)
done

# Wait for all background jobs to finish
wait
}

# Perform port discovery on the local machine, on top 10000 ports with a timeout of 1 second per port using a for loop
port_scaning() {
echo -e "\e\n[33m[*] Scaning Open Ports on:\e[0m \e[97mIP: $ipv4_address\e[0m"
for port in {1..10000}; do
    { echo >/dev/tcp/"$ipv4_address"/"$port"; } 2>/dev/null &&
    echo "Port $port is open" &
done

# Wait for all background jobs to finish
wait
}

# Checking what is on Local Network
check_network() {
    echo -e "\e[33m[*] Checking Whats on Local Network:\e[0m"
    netstat -antup
}

# Checking Crontabs
check_crontab() {
    echo -e "\e[33m[*] Checking Crontabs:\e[0m"
    cat /etc/crontab
}

# Checking What is Running as root
check_processes_root() {
    echo -e "\e[33m[*] Checking What is Running as Root:\e[0m"
    ps aux |grep -i 'root' --color=auto
}

# Run Pspy
check_pspy() {
    echo -e "\e[33m[*] Pspy:\e[0m"
    echo -e "\e[35m[!] Dont Forget to Run:\e[0m \e[31m Pspy \e[0m"
    echo -e "\e[32m--> https://github.com/DominicBreuker/pspy/releases \e[0m"
}

# Main function to perform checks
perform_checks() {	
    check_kernel
    echo ""
    check_arch
    echo ""
    check_issue_release
    echo ""
    check_perm_passwd
    echo ""
    check_users
    echo ""
    check_current_user
    echo ""
    check_ssh_keys
    echo ""
    check_sudo_privileges
    echo ""
    check_config_files
    echo ""
    check_binaries
    echo ""
    check_suid_binaries
    echo ""
    check_guid_binaries
    echo ""
    host_discovery
    echo ""
    port_scaning
    echo ""
    check_network
    echo ""
    check_crontab
    echo ""
    check_processes_root
    echo ""
    check_pspy
    echo ""
}

# Perform checks
perform_checks