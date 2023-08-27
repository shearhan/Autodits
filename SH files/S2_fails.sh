#!/bin/bash

# color of compliance
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No color

section=$1

# Benchmark Section 2.1.1.1

if [[ $section == "2.1.1.1" ]]; then
    benchmark_title="2.1.1.1 Ensure a single time synchronization daemon is in use (Automated)"
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} System time should be synchronized between all systems in an environment. This is typically done by establishing an authoritative time server or set of servers and having all systems synchronize their clocks to them. To pass this section, there should be no output upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
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

if [ -z "$l_tsd" ]; then
    echo -e "${YELLOW}Output:${NC} $output"
fi

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this benchmark failed as there are more than one time synchronization daemon in use."

    # Rationale and Remediaiton
    echo
    echo -e "${YELLOW}Rationale:${NC} Time synchronization is important to support time sensitive security mechanisms and ensures log files have consistent time records across the enterprise, which aids in forensic investigations."
    echo
    echo -e "${YELLOW}Remediation:${NC} Select one of the three time synchronization daemons; chrony (1), systemd-timesyncd (2), or ntp (3), and following the remediation procedure for the selected daemon."
    echo -e "\n1. chrony"
    echo "Run the following command to install chrony:"
    echo "# apt install chrony"
    echo "Run the following commands to stop and mask the systemd-timesyncd daemon:"
    echo "# systemctl stop systemd-timesyncd.service"
    echo "# systemctl --now mask systemd-timesyncd.service"
    echo "Run the following command to remove the ntp package:"
    echo "# apt purge ntp"
    echo "NOTE:"
    echo "- Subsection: Configure chrony should be followed"
    echo "- Subsections: Configure systemd-timesyncd and Configure ntp should be skipped"

    echo -e "\n2. systemd-timesyncd"
    echo "Run the following command to remove the chrony package:"
    echo "# apt purge chrony"
    echo "Run the following command to remove the ntp package:"
    echo "# apt purge ntp"
    echo "NOTE:"
    echo "- Subsection: Configure systemd-timesyncd should be followed"
    echo "- Subsections: Configure chrony and Configure ntp should be skipped"

    echo -e "\n3. ntp"
    echo "Run the following command to install ntp:"
    echo "# apt install ntp"
    echo "Run the following commands to stop and mask the systemd-timesyncd daemon:"
    echo "# systemctl stop systemd-timesyncd.service"
    echo "# systemctl --now mask systemd-timesyncd.service"
    echo "Run the following command to remove the chrony package:"
    echo "# apt purge chrony"
    echo "NOTE:"
    echo "- Subsection: Configure ntp should be followed"
    echo "- Subsections: Configure chrony and Configure systemd-timesyncd should be skipped"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
## | tee s2fail.txt

	
elif [[ $section == "2.2.1" ]]; then
    benchmark_title="2.2.1 Ensure X Window System is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' xserver-xorg* | grep -Pi '\h+installed\b')
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The X Window System provides a GUI with multiple windows for programs and add-ons. It's used on workstations, not servers. Compliance requires no output after the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this benchmark failed as the X Window System (xserver-xorg*) is installed on the system."

    # Rationale and Remediation
    echo  
    echo -e "${YELLOW}Rationale:${NC} Unless your organization specifically requires graphical login access via X Windows, remove it to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} To remove the X Windows System Package, use the command below."
    echo "Command: apt purge xserver-xorg*"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt

# Benchmark Section 2.2.2
elif [[ $section == "2.2.2" ]]; then
    benchmark_title="2.2.2 Ensure Avahi Server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' avahi-daemon)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} Avahi is a free zeroconf implementation, facilitating service and host discovery on a local network without configuration. Compliance requires the avahi-daemon service status to be ${red}not-installed${NC} to pass this section."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the the avahi-daemon service is installed."

    # Rationale and Remediation
    echo  
    echo -e "${YELLOW}Rationale:${NC} Automatic discovery of network services is not normally required for system functionality. It is recommended to remove this package to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run the following commands below to remove avahi-daemon."
    echo "1. systemctl stop avahi-daaemon.service"
    echo "2. systemctl stop avahi-daemon.socket"
    echo "3. apt purge avahi-daemon"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt



# Benchmark Section 2.2.3
elif [[ $section == "2.2.3" ]]; then
    benchmark_title="2.2.3 Ensure CUPS is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' cups)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} CUPS enables printing to local and network printers, accepting remote print jobs, and offering web-based administration. To comply, the service status of cups should be "not-installed" to pass this section."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service named cups is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} If the system does not need to print jobs or accept print jobs from other systems, it is recommended that CUPS be removed to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to remove cups: apt purge cups"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark Section 2.2.4
elif [[ $section == "2.2.4" ]]; then
    benchmark_title="2.2.4 Ensure DHCP Server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' isc-dhcp-server)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The Dynamic Host Configuration Protocol (DHCP) is a service that allows machines to be dynamically assigned IP addresses. To comply, the serive isc-dhcp-server should shown not-installed in the output."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service named isc-dhcp-server is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} Unless a system is specifically set up to act as a DHCP server, it is recommended that this package be removed to reduce the potential attack surface."
    echo
    echo -e"${YELLOW}Remediation:${NC} Run the following command to remove isc-dhcp-server: apt purge isc-dhcp-server"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt

# Benchmark Section 2.2.5
elif [[ $section == "2.2.5" ]]; then
    benchmark_title="2.2.5 Ensure LDAP server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' slapd)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The Lightweight Directory Access Protocol (LDAP) was introduced as a replacement for NIS/YP. It is a service that provides a method for looking up information from a central database. To comply, the service slapd should show not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service named slapd is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} If the system will not need to act as an LDAP server, it is recommended that the software be removed to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to remove slapd: apt purge slapd"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark Section 2.2.6
elif [[ $section == "2.2.6" ]]; then
    benchmark_title="2.2.6 Ensure NFS is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' nfs-kernel-server)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The Network File System (NFS) is one of the first and most widely distributed file systems in the UNIX environment. It provides the ability for systems to mount file systems of other servers through the network. To comply, the service nfs-kenerl-server should show not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service named nfs-kernel-server is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} If the system does not export NFS shares or act as an NFS client, it is recommended that these services be removed to reduce the remote attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to remove nfs: apt purge nfs-kernel-server"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt

# Benchmark Section 2.2.7
elif [[ $section == "2.2.7" ]]; then
    benchmark_title="2.2.7 Ensure DNS Server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' bind9)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The Domain Name System (DNS) is a hierarchical naming system that maps names to IP addresses for computers, services and other resources connected to a network. To comply, the service bind9 show show not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service named bind9 is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} Unless a system is specifically designated to act as a DNS server, it is recommended that the package be deleted to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to disable DNS server: apt purge bind9"    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt

# Benchmark Section 2.2.8
elif [[ $section == "2.2.8" ]]; then
    benchmark_title="2.2.8 Ensure FTP Server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' vsftpd)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The File Transfer Protocol (FTP) provides networked computers with the ability to transfer files. To comply, the service vsftpd should show not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service named bind9 is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} FTP does not protect the confidentiality of data or authentication credentials. It is recommended SFTP be used if file transfer is required. Unless there is a need to run the system as a FTP server (for example, to allow anonymous downloads), it is recommended that the package be deleted to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to remove vsftpd: apt purge vsftpd"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark Section 2.2.9
elif [[ $section == "2.2.9" ]]; then
    benchmark_title="2.2.9 Ensure HTTP server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' apache2)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} HTTP or web servers provide the ability to host web site content. To comply, the service apache2 should display not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service named apache2 is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} Unless there is a need to run the system as a web server, it is recommended that the package be deleted to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to remove apache: apt purge apache2"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark Section 2.2.10
elif [[ $section == "2.2.10" ]]; then
    benchmark_title="2.2.10 Ensure IMAP and POP3 server are not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' dovecot-imapd dovecot-pop3d)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} dovecot-imapd and dovecot-pop3d are an open source IMAP and POP3 server for Linux based systems. To comply, these services should display not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the services dovecot-imapd and dovecot-pop3d  is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} Unless POP3 and/or IMAP servers are to be provided by this system, it is recommended that the package be removed to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run the following command to remove dovecot-impapd and dovecot-pop3d"
    echo "Command: apt purge dovecot-imapd dovecot-pop3d"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark Section 2.2.11
elif [[ $section == "2.2.11" ]]; then
    benchmark_title="2.2.11 Ensure Samba is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' samba)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} Samba facilitates seamless file sharing between Linux and Windows systems using the SMB protocol, and for compliance during an audit, the service should show not-installed."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service samba is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} If there is no need to mount directories and file systems to Windows systems, then this service should be deleted to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run the following command to remove samba: apt purge samba"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt



# Benchmark Section 2.2.12
elif [[ $section == "2.2.12" ]]; then
    benchmark_title="2.2.12 Ensure HTTP Proxy Server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' squid)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} Squid is a standard proxy server used in many distributions and environments. To comply, the service squid should display not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service samba is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} If there is no need for a proxy server, it is recommended that the squid proxy be deleted to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to remove squid: apt purge squid"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark Section 2.2.13
elif [[ $section == "2.2.13" ]]; then
    benchmark_title="2.2.13 Ensure SNMP Server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' snmp)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} SNMP is widely used to monitor network equipment and devices like UPSs. Net-SNMP implements SNMPv1, SNMPv2, and SNMPv3 using both IPv4 and IPv6. SNMPv2 classic support was dropped in UCD-snmp 4.0. The SNMP server listens for commands, executes them, and sends results back. To comply, the service snmp should display not-installed during an audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service snmp is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} The SNMP server can communicate using SNMPv1, which transmits data in the clear and does not require authentication to execute commands. SNMPv3 replaces the simple/clear text password sharing used in SNMPv2 with more securely encoded parameters. If the the SNMP service is not required, the net-snmp package should be removed to reduce the attack surface of the system."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to remove snmp: apt purge snmp"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt

# Benchmark Section 2.2.14
elif [[ $section == "2.2.14" ]]; then
    benchmark_title="2.2.14 Ensure NIS Server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' nis)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The Network Information Service (NIS) (formally known as Yellow Pages) is a client-server directory service protocol for distributing system configuration files. The NIS server is a collection of programs that allow for the distribution of configuration files. To comply, the service nis should display not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service snmp is installed"

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} The NIS service is inherently an insecure system that has been vulnerable to DOS attacks, buffer overflows and has poor authentication for querying NIS maps. NIS generally has been replaced by such protocols as Lightweight Directory Access Protocol (LDAP). It is recommended that the service be removed and other, more secure services be used"
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to remove nis: apt purge nis"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt



# Benchmark Section 2.2.15
elif [[ $section == "2.2.15" ]]; then
    benchmark_title="Ensure mail transfer agent is configured for local-only mode (Automated)"
    audit=$(ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|::1):25\s')
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} MTAs like sendmail and Postfix listen for incoming mail and transfer messages to the appropriate user or mail server. To comply, if the system isn't meant to be a mail server, configure the MTA to only process local mail with no output upon auditing."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the MTA is listening on certain non-loopback address(127.0.0.1 or ::1)."

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} The software for all Mail Transfer Agents is complex and most have a long history of security issues. While it is important to ensure that the system can process local mail messages, it is not necessary to have the MTA's daemon listening on a port unless the server is intended to be a mail server that receives and processes mail from other systems."
    echo
    echo -e "${YELLOW}Remediation:${NC} Edit /etc/postfix/main.cf and add the following line to the RECEIVING MAIL section. If the line already exists, change it to look like the line below:"
    echo "line to edit: inet_interfaces = loopback-only"
    echo "Run the following command to restart postfix: systemctl restart postfix"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt

# Benchmark Section 2.2.16
elif [[ $section == "2.2.16" ]]; then

    benchmark_title="2.2.16 Ensure rsync service is either not installed or masked (Automated)"

    # Check if rsync is installed
    rsync_installed=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' rsync | grep -E 'rsync\s+unknown\s+ok\s+not-installed\s+not-installed')

    # Check if rsync is inactive
    rsync_inactive=$(systemctl is-active rsync | grep -E 'inactive')

    # Check if rsync is masked
    rsync_masked=$(systemctl is-enabled rsync | grep -E 'masked')
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The script checks whether rsync is not installed and also verifies if it is inactive and masked. This helps ensure that rsync is properly configured to comply with security guidelines."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Installed Output:${NC} $rsync_installed"
    echo -e "${YELLOW}Inactive Output:${NC} $rsync_inactive"
    echo -e "${YELLOW}Masked Output:${NC} $rsync_masked"

    # Explanation
    echo
     if [[ -n "$rsync_installed" ]]; then
        echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the \"rsync\" service is installed."
    elif [[ -n "$rsync_inactive" && -z "$rsync_masked" ]]; then
        echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the \"rsync\" service is inactive but not masked."
    elif [[ -z "$rsync_inactive" && -n "$rsync_masked" ]]; then
        echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the \"rsync\" service is active but masked."
    else
        echo -e "${YELLOW}Explanation:${NC} The compliance of this section passed as the \"rsync\" service is either not installed or installed but either inactive or masked."
    fi
    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} The rsync service presents a security risk as it uses unencrypted protocols for communication. The rsync package should be removed to reduce the attack area of the system."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run the following commands to either remove/stop and mask rsync"
    echo "Remove rsync: apt purge rysnc"
    echo "Stop rsync: systemctl stop rsync"
    echo "mask rsync: systemctl mask rsync"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark Section 2.3.1
elif [[ $section == "2.3.1" ]]; then
    benchmark_title="2.3.1 Ensure NIS Client is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' nis)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The Network Information Service (NIS), formerly known as Yellow Pages, is a client-server directory service protocol used to distribute system configuration files. The NIS client was used to bind a machine to an NIS server and receive the distributed configuration files. To comply, the service nis should display not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service nis is installed."

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} The NIS service is inherently an insecure system that has been vulnerable to DOS attacks, buffer overflows and has poor authentication for querying NIS maps. NIS generally has been replaced by such protocols as Lightweight Directory Access Protocol (LDAP). It is recommended that the service be removed."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to uninstall nis: apt purge nis"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark section 2.3.2
elif [[ $section == "2.3.2" ]]; then
    benchmark_title="2.3.2 Ensure rsh client is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' rsh-client)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The rsh-client package contains the client commands for the rsh services. To comply, the service rsh-client should display not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service rsh-client is installed."

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} These legacy clients contain numerous security exposures and have been replaced with the more secure SSH package. Even if the server is removed, it is best to ensure the clients are also removed to prevent users from inadvertently attempting to use these commands and therefore exposing their credentials. Note that removing the rsh package removes the clients for rsh , rcp and rlogin ."
    echo
    echo -e "${YELLOW}Remediation${NC} Run this command to uninstall rsh: apt purge rsh-client"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark Section 2.3.3
elif [[ $section == "2.3.3" ]]; then
    benchmark_title="2.3.3 Ensure talk client is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' talk)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The talk software makes it possible for users to send and receive messages across systems through a terminal session. The talk client, which allows initialization of talk sessions, is installed by default. To comply, the service talk should display not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service talk is installed."

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} The software presents a security risk as it uses unencrypted protocols for communication."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to uninstall talk: apt purge talk"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt


# Benchmark Section 2.3.4
elif [[ $section == "2.3.4" ]]; then
    benchmark_title="2.3.4 Ensure telnet client is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' telnet)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The telnet package contains the telnet client, which allows users to start connections to other systems via the telnet protocol. To comply, the service telnet should display not-installed upon running the audit"

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service telnet is installed."

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} The telnet protocol is insecure and unencrypted. The use of an unencrypted transmission medium could allow an unauthorized user to steal credentials. The ssh package provides an encrypted session and stronger security and is included in most Linux distributions."
    echo
    echo -e "${YELLOW}Remediation;${NC} Run this command to remove telnet: apt purge telnet"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt

# Benchmark Section 2.3.5
elif [[ $section == "2.3.5" ]]; then
    benchmark_title="2.3.5 Ensure LDAP client is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' ldap-utils)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} The Lightweight Directory Access Protocol (LDAP) was introduced as a replacement for NIS/YP. It is a service that provides a method for looking up information from a central database. To comply, the service ldap-utils should display not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service ldap-utils is installed."

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} If the system will not need to act as an LDAP client, it is recommended that the software be removed to reduce the potential attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to uninstall ldap-utils: apt purge ldap-utils"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt



# Benchmark Section 2.3.6
elif [[ $section == "2.3.6" ]]; then
    benchmark_title="2.3.6 Ensure RPC is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' rpcbind)
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} Remote Procedure Call (RPC) is a method for creating low level client server applications across different system architectures. It requires an RPC compliant client listening on a network port. The supporting package is rpcbind. To comply, the service rpcbind should display not-installed upon running the audit."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as the service ldap-utils is installed."

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} If RPC is not required, it is recommended that this services be removed to reduce the remote attack surface."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run this command to remove rpcbind: apt purge rpcbind"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo
# | tee s2fail.txt        

# Benchmark Section 2.4

elif [[ $section == "2.4" ]]; then

    benchmark_title="2.4 Ensure nonessential services are removed or masked (Manual)"
    audit=$(lsof -i -P -n | grep -v "(ESTABLISHED)")
    
    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Description
    echo
    echo -e "${YELLOW}Description:${NC} A network port is identified by its number, the associated IP address, and the type of the communication protocol such as TCP or UDP.

A listening port is a network port on which an application or process listens on, acting as a communication endpoint.

Each listening port can be open or closed (filtered) using a firewall. In general terms, an open port is a network port that accepts incoming packets from remote locations."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance for this section failed as there might be possible services that are not required in the system. Please review the output to ensure that all services listed are required."

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} Services listening on the system pose a potential risk as an attack vector. These services should be reviewed, and if not required, the service should be stopped, and the package containing the service should be removed. If required packages have a dependency, the service should be stopped and masked to reduce the attack surface of the system."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run the following command to remove the package containing the service: apt purge <package_name>"
    echo "OR If required packages have a dependency:"
    echo "Run the following command to stop and mask the service: systemctl --now mask <service_name>"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo



else
    echo "Invalid section: $section"

fi

