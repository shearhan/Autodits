#!/bin/bash

# Store no of pass/fails
pass_count=0
fail_count=0
not_accessed=0
total=0

# failed sections
failed_sections=""

# color of compliance
red='\033[0;31m'
RED='\033[0;41m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'  # No color
normal='\033[0m'
red='\033[0;41m'
green='\033[01;32m'
red2='\033[0;31m'



# Function to display failed sections
display_failed_sections() {
    local fails_script=$1
#    echo -e "\n${red}                                                                                          failed Sections:${NC}\n"
    for section in $failed_sections; do
        case $section in
            "2.1.1.1") $fails_script 2.1.1.1 ;;
            "2.2.1") $fails_script 2.2.1 ;;
            "2.2.2") $fails_script 2.2.2 ;;
            "2.2.3") $fails_script 2.2.3 ;;
#            "2.2.4") $fails_script 2.2.4 ;;
            "2.2.5") $fails_script 2.2.5 ;;
            "2.2.6") $fails_script 2.2.6 ;;
            "2.2.7") $fails_script 2.2.7 ;;
#            "2.2.8") $fails_script 2.2.8 ;;
#            "2.2.9") $fails_script 2.2.9 ;;
#            "2.2.10") $fails_script 2.2.10 ;;
            "2.2.11") $fails_script 2.2.11 ;;
            "2.2.12") $fails_script 2.2.12 ;;
            "2.2.13") $fails_script 2.2.13 ;;
            "2.2.14") $fails_script 2.2.14 ;;
            "2.2.15") $fails_script 2.2.15 ;;
            "2.2.16") $fails_script 2.2.16 ;;
            "2.3.1") $fails_script 2.3.1 ;;
            "2.3.2") $fails_script 2.3.2 ;;
#            "2.3.3") $fails_script 2.3.3 ;;
            "2.3.4") $fails_script 2.3.4 ;;
            "2.3.5") $fails_script 2.3.5 ;;
#            "2.3.6") $fails_script 2.3.6 ;;
            "2.4") $fails_script 2.4 ;;
# Add more cases for other sections if needed
            *) echo "Invalid section: $section" ;;
        esac
        echo
    done
} 

{
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                       Automated Audit Tool for Linux(2)                                                     |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo -e "|${YELLOW}Section${NC}  | ${YELLOW}Title${NC}                                                                                                          | ${YELLOW}Compliance${NC}       |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                                 2 Services                                                                  |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"



#Audit Title 2.1.1.1
echo "|2.1.1    | Ensure time synchronization is in use                                                                          |                  |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
output="" l_tsd="" l_sdtd="" chrony="" l_ntp=""
dpkg-query -W chrony > /dev/null 2>&1 && l_chrony="y"
dpkg-query -W ntp > /dev/null 2>&1 && l_ntp="y" || l_ntp=""
systemctl list-units --all --type=service | grep -q 'systemd-timesyncd.service' && systemctl is-enabled systemd-timesyncd.service | grep -q 'enabled' && l_sdtd="y"
# ! systemctl is-enabled systemd-timesyncd.service | grep -q 'enabled' && l_nsdtd="y" || l_nsdtd=""

if [[ "$l_chrony" = "y" && "$l_ntp" != "y" && "$l_sdtd" != "y" ]]; then
    l_tsd="chrony"
    output="$output\n- chrony is in use on the system"
elif [[ "$l_chrony" != "y" && "$l_ntp" = "y" && "$l_sdtd" != "y" ]]; then
    l_tsd="ntp"
    output="$output\n- ntp is in use on the system"
elif [[ "$l_chrony" != "y" && "$l_ntp" != "y" ]]; then
    if systemctl list-units --all --type=service | grep -q 'systemd-timesyncd.service' && systemctl is-enabled systemd-timesyncd.service | grep -Eq '(enabled|disabled|masked)'; then
        l_tsd="sdtd"
        output="$output\n- systemd-timesyncd is in use on the system"
    fi
else
    [[ "$l_chrony" = "y" && "$l_ntp" = "y" ]] && output="$output\n- both chrony and ntp are in use on the system"
    [[ "$l_chrony" = "y" && "$l_sdtd" = "y" ]] && output="$output\n- both chrony and systemd-timesyncd are in use on the system"
    [[ "$l_ntp" = "y" && "$l_sdtd" = "y" ]] && output="$output\n- both ntp and systemd-timesyncd are in use on the system"
fi

if [ -n "$l_tsd" ]; then
    echo -e "|2.1.1.1  | Ensure a single time synchronization daemon is in use (Automated)                                              |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.1.1.1  | Ensure a single time synchronization daemon is in use (Automated)                                              | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.1.1.1 "
fi
    ((total++))

#Audit Title 2.1.2 -2.1.4
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|2.1.2    | Configure chrony                                                                                               |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

    echo -e "|2.1.2.1  | Ensure chrony is configured with authorized timeserver (Manual)                                                |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

    echo -e "|2.1.2.2  | Ensure chrony is running as user _chrony (Automated)                                                           |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

    echo -e "|2.1.2.3  | Ensure chrony is enabled and running (Automated)                                                               |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|2.1.3    | Configure systemd-timesyncd                                                                                    |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

    echo -e "|2.1.3.1  | Ensure systemd-timesyncd configured with authorized timeserver (Manual)                                        |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

    echo -e "|2.1.3.2  | Ensure systemd-timesyncd is enabled and running (Automated)                                                    |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|2.1.4    | Configure ntp                                                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

    echo -e "|2.1.4.1  | Ensure ntp access control is configured (Automated)                                                            |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

    echo -e "|2.1.4.2  | Ensure ntp is configured with authorized timeserver (Manual)                                                   |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))
    echo -e "|2.1.4.3  | Ensure ntp is running as user ntp (Automated)                                                                  |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

    echo -e "|2.1.4.4  | Ensure ntp is enabled and running (Automated)                                                                  |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

# Section 1

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|2.2      | Special Purpose Services                                                                                       |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Audit Title 2.2.1

audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' xserver-xorg* | grep -Pi '\h+installed\b')

if [[ -z $audit ]]; then
    echo -e "|2.2.1    | Ensure X Window System is not installed (Automated)                                                            |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.1    | Ensure X Window System is not installed (Automated)                                                            | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.1 "
fi
    ((total++))

# Audit Title 2.2.2
package_name="avahi-daemon"
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.2    | Ensure Avahi Server is not installed (Automated)                                                               |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.2    | Ensure Avahi Server is not installed (Automated)                                                               | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.2 "
fi
    ((total++))

# Audit Title 2.2.3
package_name="cups"
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.3    | Ensure CUPS is not installed (Automated)                                                                       |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.3    | Ensure CUPS is not installed (Automated)                                                                       | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.3 "
fi
    ((total++))
# Audit Title 2.2.4

#package_name="isc-dhcp-server"
#output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

#if echo "$output" | grep -q "not-installed"; then
#    echo -e "|2.2.4    | Ensure DHCP Server is not installed                                                                            |${GREEN} Pass${NC}             |"
#    ((pass_count++))
#else
    echo -e "|2.2.4    | Ensure DHCP Server is not installed (Automated)                                                                |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
#    failed_sections+="2.2.4 "
#fi
    ((total++))


# Audit Title 2.2.5
package_name="slapd"
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.5    | Ensure LDAP server is not installed (Automated)                                                                |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.5    | Ensure LDAP server is not installed (Automated)                                                                | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.5 "
fi
    ((total++))

# Audit Title 2.2.6
package_name="nfs-kernel-server"
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.6    | Ensure NFS is not installed (Automated)                                                                        |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.6    | Ensure NFS is not installed (Automated)                                                                        | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.6 "
fi
    ((total++))

# Audit Title 2.2.7
package_name="bind9"
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.7    | Ensure DNS server is not installed (Automated)                                                                 |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.7    | Ensure DNS Server is not installed (Automated)                                                                 | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.7 "
fi
    ((total++))

# Audit Title 2.2.8
#package_name="vsftpd"
#output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

#if echo "$output" | grep -q "not-installed"; then
#    echo -e "|2.2.8    | Ensure FTP Server is not installed (Automated)                                                                 |${GREEN} Pass${NC}             |"
#    ((pass_count++))
#else
    echo -e "|2.2.8    | Ensure FTP Server is not installed (Automated)                                                                 |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
#    failed_sections+="2.2.8 "
#fi
    ((total++))

# Audit Title 2.2.9
#package_name="apache2"
#output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

#if echo "$output" | grep -q "not-installed"; then
#    echo -e "|2.2.9    | Ensure HTTP server is not installed (Automated)                                                                |${GREEN} Pass${NC}             |"
#    ((pass_count++))
#else
    echo -e "|2.2.9    | Ensure HTTP server is not installed (Automated)                                                                |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
#    failed_sections+="2.2.9 "
#fi
    ((total++))
# Audit Title 2.2.10
#package1_name="dovecot-impd"
#package2_name="dovecot-pop3d"
#output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package1_name $package2_name 2>/dev/null)

#if echo "$output" | grep -q "not-installed"; then
#    echo -e "|2.2.10   | Ensure IMAP and POP3  server is not installed (Automated)                                                      |${GREEN} Pass${NC}             |"
#    ((pass_count++))
#else
    echo -e "|2.2.10   | Ensure IMAP and POP3 server is not installed (Automated)                                                       |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
#    failed_sections+="2.2.10 "
#fi
    ((total++))

# Audit Title 2.2.11
package_name="samba"
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.11   | Ensure Samba server is not installed (Automated)                                                               |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.11   | Ensure Samba server is not installed (Automated)                                                               | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.11 "
fi
    ((total++))

# Audit Title 2.2.12
package_name="squid"
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.12   | Ensure HTTP Proxy Server is not installed (Automated)                                                          |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.12    | Ensure HTTP Proxy Server is not installed (Automated)                                                         | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.12 "
fi
    ((total++))

# Audit Title 2.2.13
package_name="snmp"
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.13   | Ensure SNMP Server is not installed (Automated)                                                                |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.13    | Ensure SNMP Server is not installed (Automated)                                                               | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.13 "
fi
    ((total++))

# Audit Title 2.2.14
package_name="nis"
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.14   | Ensure NIS Server is not installed (Automated)                                                                 |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.2.14   | Ensure NIS Server is not installed (Automated)                                                                 | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.14 "

fi
    ((total++))

# Audit Title 2.2.15
audit=$(ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|::1):25\s')

if [ -z $audit ]; then
    echo -e "|2.2.15   | Ensure mail transfer agent is configured for local-only mode (Automated)                                       |${GREEN} Pass${NC}             |"

    ((pass_count++))
else
    echo -e "|${RED}2.2.15   | Ensure mail transfer agent is configured for local-only mode (Automated)                                       | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.2.15 "
fi
    ((total++))

# Audit Title 2.2.16
package_name="rsync"

# Check if rsync is installed
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.2.16   | Ensure rsync service is either not installed or masked (Automated)                                             |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    # Check if rsync is inactive and masked
    is_active=$(systemctl is-active rsync)
    is_enabled=$(systemctl is-enabled rsync)

    if [ "$is_active" = "inactive" ] && [ "$is_enabled" = "masked" ]; then
        echo -e "|2.2.16   | Verify rsync service is either not installed or masked (Automated)                                             |${GREEN} Pass${NC}             |"
        ((pass_count++))
    else
        echo -e "|${RED}2.2.16   | Verify rsync service is either not installed or masked (Automated)                                             | Fail             ${NC}|"
        ((fail_count++))
        failed_sections+="2.2.16 "
    fi
fi
    ((total++))

# Section 2.3

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|2.3      | Service Clients                                                                                                |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Audit Title 2.3.1
package_name="nis"

# Check if NIS CLient is installed
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.3.1    | Ensure NIS Client is not installed (Automated)                                                                 |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.3.1    | Ensure NIS Client is not installed (Automated)                                                                 | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.3.1 "
fi
    ((total++))


# Audit Title 2.3.2
package_name="rsh-client"

# Check if rsh CLient is installed
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.3.2    | Ensure rsh client is not installed (Automated)                                                                 |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.3.2    | Ensure rsh client is not installed (Automated)                                                                 | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.3.2 "
fi
    ((total++))


# Audit Title 2.3.3
#package_name="talk"

# Check if talk client is installed
#output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

#if echo "$output" | grep -q "not-installed"; then
#    echo -e "|2.3.3    | Ensure talk client is not installed (Automated)                                                                |${GREEN} Pass${NC}             |"
#    ((pass_count++))
#else
    echo -e "|2.3.3    | Ensure talk client is not installed (Automated)                                                                |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
    ((total++))
#    failed_sections+="2.3.3 "
#fi


# Audit Title 2.3.4
package_name="telnet"

# Check if telnet client is installed
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.3.4    | Ensure telnet client is not installed (Automated)                                                              |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.3.4    | Ensure telnet client is not installed (Automated)                                                              | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.3.4 "
fi
    ((total++))


# Audit Title 2.3.5
package_name="ldap-utils"

# Check if LDAP client is installed
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

if echo "$output" | grep -q "not-installed"; then
    echo -e "|2.3.5    | Ensure LDAP client is not installed (Automated)                                                                |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.3.5    | Ensure LDAP client is not installed (Automated)                                                                | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.3.5 "
fi
    ((total++))

# Audit Title 2.3.6
#package_name="rpcbind"

# Check if RPC is installed
#output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' $package_name 2>/dev/null)

#if echo "$output" | grep -q "not-installed"; then
#    echo -e "|2.3.6    | Ensure RPC is not installed (Automated)                                                                        |${GREEN} Pass${NC}             |"
#    ((pass_count++))
#else
    echo -e "|2.3.6    | Ensure RPC is not installed (Automated)                                                                        |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
    ((total++))
#    failed_sections+="2.3.6 "
#fi

# Audit Title 2.4
output=$(lsof -i -P -n | grep -v "(ESTABLISHED)")

if [ -z '$output' ]; then
    echo -e "|2.4      | Ensure nonessential services are removed or masked (Manual)                                                    |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}2.4      | Ensure nonessential services are removed or masked (Manual)                                                    | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="2.4 "
fi
    ((total++))


echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
} > services.txt


path_to_fails="./S2_fails.sh"
display_failed_sections "$path_to_fails" > s2fails.txt
