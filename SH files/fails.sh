#!/bin/bash

# color of compliance
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No color

section=$1

# Benchmark Section 2.2.1
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


# Benchmark Section 2.4
elif [[ $section == "2.4" ]];then
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


    	
# Benchmark Section 6.1.1
elif [[ $section == "6.1.1" ]]; then
    benchmark_title="6.1.1 Ensure permissions on /etc/passwd are configured (Automated)"
    audit=$(stat /etc/passwd | grep -E 'Access:|Uid:|Gid:' | sed '2d')
    permissions=$(stat -c %a /etc/passwd)
    uid=$(stat -c %u /etc/passwd)
    gid=$(stat -c %g /etc/passwd)

    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Check if /etc/passwd file exists
    filename="/etc/passwd"

    if [ -f $filename ]; then
        echo
    else
        echo -e '\n'
        echo "The $filename file does not exist."
        exit 1
    fi

    # Description
    echo -e "${YELLOW}Description:${NC} The /etc/passwd file contains user account information that is used by many system utilities and therefore must be readable for these utilities to operate. When performing the audit, it is crucial to check the file's permissions ${YELLOW}(0644/-rw-r--r--), owner (root), and group (root)${NC} to ensure proper access control and maintain system integrity."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because the /etc/passwd file does not meet the required criteria by either having the incorrect permissions($permissions), not being owned by the root user($uid), or not belonging to the root group($gid)."

    # Rationale and Remediation
    echo  
    echo -e "${YELLOW}Rationale:${NC} It is critical to ensure that the /etc/passwd file is protected from unauthorized write access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions."
    echo 
    echo -e "${YELLOW}Remediation:${NC} Run the following commands to set permissions on $filename"
    echo "1. chown root:root $filename"
    echo "2. chmod u-x,go-wx $filename"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo

# Benchmark Section: 6.1.2
elif [[ $section == "6.1.2" ]]; then
    benchmark_title="6.1.2 Ensure permissions on /etc/passwd- are configured (Automated)"
    audit=$(stat /etc/passwd- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
    permissions=$(stat -c %a /etc/passwd-)
    uid=$(stat -c %u /etc/passwd-)
    gid=$(stat -c %g /etc/passwd-)

    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Check if file exists
    filename="/etc/passwd-"
    if [ -f $filename ]; then
        echo
    else
        echo -e '\n'
        echo "The $filename file does not exist."
        exit 1
    fi

    # Description
    echo -e "${YELLOW}Description:${NC} The /etc/passwd- file contains backup user account information. When performing the audit, it is crucial to check the file's permissions ${YELLOW}(0644/-rw-r--r--) or more restrictive, owner (root), and group (root)${NC}."

    # Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    # Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    # Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because the /etc/passwd- file does not meet the required criteria by either having the incorrect permissions($permissions), not being owned by the root user($uid), or not belonging to the root group($gid)."
 
   # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} It is critical to ensure that the /etc/passwd- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run the following commands to set permissions on $filename"
    echo "1. chown root:root $filename"
    echo "2. chmod u-x,go-wx $filename"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo


# Benchmark Section 6.1.3
elif [[ $section == "6.1.3" ]]; then
    benchmark_title="6.1.3 Ensure permissions on /etc/group are configured (Automated)"
    audit=$(stat /etc/group | grep -E 'Access:|Uid:|Gid:' | sed '2d')
    permissions=$(stat -c %a /etc/group)
    uid=$(stat -c %u /etc/group)
    gid=$(stat -c %g /etc/group)

    echo -e "\n"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${YELLOW}Title: ${NC}$benchmark_title"

    # Check if file exists
    filename="/etc/group"
    if [ -f $filename ]; then
        echo
    else
        echo -e '\n'
        echo "The $filename file does not exist."
        exit 1
    fi

    #Description
    echo -e "${YELLOW}Description:${NC} The /etc/group file contains a list of all the valid groups defined in the system. The command below allows read/write access for root and read access for everyone else. When performing the audit, it is crucial to check the file's permissions ${YELLOW}(0644/-rw-r--r--), owner (root), and group (root)${NC} to ensure proper access control and maintain system integrity."

    #Compliance
    echo
    echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

    #Output
    echo
    echo -e "${YELLOW}Output:${NC} $audit"

    #Explanation
    echo
    echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because the /etc/group file does not meet the required criteria.The file either has incorrect permissions($permissions),not being owned by the root user($uid), or not belonging to the root group($gid)."

    # Rationale and Remediation
    echo
    echo -e "${YELLOW}Rationale:${NC} The /etc/group file needs to be protected from unauthorized changes by non-privileged users, but needs to be readable as this information is used with many non-privileged programs."
    echo
    echo -e "${YELLOW}Remediation:${NC} Run the following commands to set permissions on $filename"
    echo "1. chown root:root $filename"
    echo "2. chmod u-x,go-wx $filename"
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo

# Benchmark Section 6.1.4
elif [[ $section == "6.1.4" ]]; then
     benchmark_title="6.1.4 Ensure permissions on /etc/group- are configured (Automated)"
     audit=$(stat /etc/group- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
     permissions=$(stat -c %a /etc/group-)
     uid=$(stat -c %u /etc/group-)
     gid=$(stat -c %g /etc/group-)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"


     # Check if /etc/group file exists
     filename="/etc/group-"

     if [ -f $filename ]; then
         echo
     else
         echo -e '\n'
         echo "The $filename file does not exist."
         exit 1
     fi

     # Description
     echo -e "${YELLOW}Description:${NC} The /etc/group- file contains a backup list of all the valid groups defined in the system. When performing the audit, it is crucial to check the file's permissions ${YELLOW}(0644/-rw-r--r--) or more restrictive, owner (root), and group (root)${NC} to ensure proper access control and maintain system integrity."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because the /etc/group file does not meet the required criteria by either having the incorrect permissions($permissions), not being owned by the root user($uid), or not belonging to the root group($gid)."
     
     # Rationale and Remediation
     echo -e "${YELLOW}Rationale:${NC} It is critical to ensure that the /etc/group- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions."
     echo
     echo -e "${YELLOW}Remediation:${NC} Run the following commands to set permissions on $filename"
     echo "1. chown root:root $filename"
     echo "2. chmod u-x,go-wx $filename"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

# Benchmark Title 6.1.5
elif [[ $section == "6.1.5" ]]; then
     benchmark_title="6.1.5 Ensure permissions on /etc/shadow are configured (Automated)"
     audit=$(stat /etc/shadow | grep -E 'Access:|Uid:|Gid:' | sed '2d')
     permissions=$(stat -c %a /etc/shadow)
     uid=$(stat -c %u /etc/shadow)
     gid=$(stat -c %g /etc/shadow)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"


     # Check if /etc/shadow file exists
     filename="/etc/shadow"

     if [ -f $filename ]; then
         echo
     else
         echo -e '\n'
         echo "The $filename file does not exist."
         exit 1
     fi

     # Description
     echo -e "${YELLOW}Description:${NC} The /etc/shadow file serves as a critical repository for user account information, including hashed passwords and other security details essential for account security. When performing an audit, it is crucial to verify variables such as file permissions ${YELLOW}(0640/-rw-r-----) or more restrictive, owner (root), and group (root)${NC} to ensure appropriate access control and maintain the integrity of the system."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because the /etc/shadow file does not meet the required criteria by either having the incorrect permissions($permissions), not being owned by the root user($uid), or not belonging to the root/shadow group($gid)."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} If attackers can gain read access to the /etc/shadow file, they can easily run a password cracking program against the hashed password to break it. Other security information that is stored in the /etc/shadow file (such as expiration) could also be useful to subvert the user accounts."
     echo
     echo -e "${YELLOW}Remediation:${NC} Run the following commands to set permissions on $filename"
     echo "1. chown root:root $filename or chown root:shadow $filename"
     echo "2. chmod u-x,g-wx,o-rwx $filename"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

# Benchmark Title 6.1.6
elif [[ $section == "6.1.6" ]]; then
     benchmark_title="6.1.6 Ensure permissions on /etc/shadow- are configured (Automated)"
     audit=$(stat /etc/shadow- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
     permissions=$(stat -c %a /etc/shadow-)
     uid=$(stat -c %u /etc/shadow-)
     gid=$(stat -c %g /etc/shadow-)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Check if /etc/shadow- file exists
     filename="/etc/shadow-"

     if [ -f $filename ]; then
         echo
     else
         echo -e '\n'
         echo "The $filename file does not exist."
         exit 1
     fi

     # Description
     echo -e "${YELLOW}Description:${NC} The /etc/shadow- file is used to store backup information about user accounts that is critical to the security of those accounts, such as the hashed password and other security information. When performing an audit, it is crucial to verify variables such as file permissions ${YELLOW}(0640/-rw-r-----) or more restrictive, owner (root), and group (root)${NC} to ensure appropriate access control and maintain the integrity of the system."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because the /etc/shadow- file does not meet the required criteria by either having the incorrect permissions($permissions), not being owned by the root user($uid), or not belonging to the root/shadow group($gid)."
  
     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} It is critical to ensure that the /etc/shadow- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions."
     echo
     echo -e "${YELLOW}Remediation:${NC} Run the following commands to set permissions on $filename"
     echo "1. chown root:root $filename or chown root:shadow $filename"
     echo "2. chmod u-x,g-wx,o-rwx $filename"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo
 
# Benchmark Section 6.1.7
elif [[ $section == "6.1.7" ]]; then
     benchmark_title="6.1.7 Ensure permissions on /etc/gshadow are configured (Automated)"
     audit=$(stat /etc/gshadow | grep -E 'Access:|Uid:|Gid:' | sed '2d')
     permissions=$(stat -c %a /etc/gshadow)
     uid=$(stat -c %u /etc/gshadow)
     gid=$(stat -c %g /etc/gshadow)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Check if /etc/gshadow file exists
     filename="/etc/gshadow"

     if [ -f $filename ]; then
         echo
     else
         echo -e '\n'
         echo "The $filename file does not exist."
         exit 1
     fi

     # Description
     echo -e "${YELLOW}Description:${NC} The /etc/gshadow file is used to store the information about groups that is critical to the security of those accounts, such as the hashed password and other security information. When performing an audit, it is crucial to verify variables such as file permissions ${YELLOW}(0640/-rw-r-----) or more restrictive, owner (root), and group (root)${NC} to ensure appropriate access control and maintain the integrity of the system."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because the /etc/gshadow file does not meet the required criteria by either having the incorrect permissions($permissions), not being owned by the root user($uid), or not belonging to the root/shadow group($gid)."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} If attackers can gain read access to the /etc/gshadow file, they can easily run a password cracking program against the hashed password to break it. Other security information that is stored in the /etc/gshadow file (such as group administrators) could also be useful to subvert the group."
     echo
     echo -e "${YELLOW}Remediation:${NC} Run the following commands to set permissions on $filename"
     echo "1. chown root:root $filename or chown root:shadow $filename"
     echo "2. chmod u-x,g-wx,o-rwx $filename"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

# Benchmark Title 6.1.8
elif [[ $section == "6.1.8" ]]; then
     benchmark_title="6.1.8 Ensure permissions on /etc/gshadow- are configured (Automated)"
     audit=$(stat /etc/gshadow- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
     permissions=$(stat -c %a /etc/gshadow-)
     uid=$(stat -c %u /etc/gshadow-)
     gid=$(stat -c %g /etc/gshadow-)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Check if file exists
     filename="/etc/gshadow-"

     if [ -f $filename ]; then
         echo
     else
         echo -e '\n'
         echo "The $filename file does not exist."
         exit 1
     fi

     # Description
     echo -e "${YELLOW}Description:${NC}  The /etc/gshadow- file is used to store backup information about groups that is critical to the security of those accounts, such as the hashed password and other security information. When performing an audit, it is crucial to verify variables such as file permissions ${YELLOW}(0640/-rw-r-----) or more restrictive, owner (root), and group (root)${NC} to ensure appropriate access control and maintain the integrity of the system."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because the /etc/gshadow- file does not meet the required criteria by either having the incorrect permissions($permissions), not being owned by the root user($uid), or not belonging to the root/shadow group($gid)."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} It is critical to ensure that the /etc/gshadow- file is protected from unauthorized access. Although it is protected by default, the file permissions could be changed either inadvertently or through malicious actions."
     echo
     echo -e "${YELLOW}Remediation:${NC} Run the following commands to set permissions on $filename"
     echo "1. chown root:root $filename or chown root:shadow $filename"
     echo "2. chmod u-x,g-wx,o-rwx $filename"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

# Benchmark Title 6.1.9
elif [[ $section == "6.1.9" ]]; then
     benchmark_title="6.1.9 Ensure no world writable files exist (Automated)"
     audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Unix-based systems support variable settings to control access to files. World writable files are the least secure. To ensure this section of the becnhmark is compliant, the audit has to be run in root and there should be no output"

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because there were world-writable files in the output."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} Data in world-writable files can be modified and compromised by any user on the system. World writable files may also indicate an incorrectly written script or program that could potentially be the cause of a larger compromise to the system's integrity."
     echo
     echo -e "{$YELLOW}Remediation:${NC} Run the following command to remove write access for outputted files"
     echo "chmod o-w <filename>"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

# Benchmark Title 6.1.10
elif [[ $section == "6.1.10" ]]; then
     benchmark_title="6.1.10 Ensure no unowned files or directories exist (Automated)"
     audit=$( df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Sometimes when administrators delete users from the password file they neglect to remove all files owned by those users from the system. To pass this compliance of the benchmark, there should be no output"

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation${NC} The compliance for this benchmark failed because there were either unowned files or directories present in the output."
     
     # Rationale and Remediation
     echo 
     echo -e "${YELLOW}Rationale${NC} A new user who is assigned the deleted user's user ID or group ID may then end up "owning" these files, and thus have more access on the system than was intended."
     echo
     echo -e "${YELLOW}Remediation${NC} Locate files that are owned by users or groups not listed in the system configuration files, and reset the ownership of these files to some active user on the system as appropriate."
     echo
     echo "Note: The audit above only searches local filesystems. To check whether there are unowned files/directories, run the command below"
     echo "Command: find <partiion> -xdev -nouser"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Title 6.1.11
elif [[ $section == "6.1.11" ]]; then
     benchmark_title="6.1.11 Ensure no ungrouped files or directories exist (Automated)"
     audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Sometimes when administrators delete users or groups from the system they neglect to remove all files owned by those users or groups. To pass this compliance of the benchmark, there should be not output"

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation${NC} The compliance for this benchmark failed because there were either ungrouped files or directories present in the output."

     #Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} A new user who is assigned the deleted user's user ID or group ID may then end up "owning" these files, and thus have more access on the system than was intended"
     echo
     echo -e "${YELLOW}Remediation:${NC} Locate files that are owned by users or groups not listed in the system configuration files, and reset the ownership of these files to some active user on the system as appropriate."
     echo
     echo "Note: The audit above only searches local filesystems. To check whether there are ungrouped files/directories elsewhere, run the command below"
     echo "Command: find <partition> -xdev -nogroup"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo




# Benchmark Title 6.1.12
elif [[ $section == "6.1.12" ]]; then
     benchmark_title="6.1.12 Audit SUID executables (Manual)"
     audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} The owner of a file can set the file's permissions to run with the owner's or group's permissions, even if the user running the program is not the owner or a member of the group. The most common reason for a SGID program is to enable users to perform functions (such as changing their password) that require root privileges."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC}\n$audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because there might be potential unauthorized SUID programs. Please review the SUID programs that is being outputted"

     #Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} There are valid reasons for SUID programs, but it is important to identify and review such programs to ensure they are legitimate."
     echo
     echo -e "${YELLOW}Remediation:${NC} Ensure that no rogue SUID programs have been introduced into the system. Review the files returned by the action in the Audit section and confirm the integrity of these binaries."
     echo
     echo "Note: The audit above only searches local filesystems. To check wh
ether there are SUID programs elsewhere, run the command below"
     echo "Command: find <partition> -xdev -type f -perm -4000"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Title 6.1.13
elif [[  $section == "6.1.13" ]]; then
     benchmark_title="6.1.13 Audit SGID executables (Manual)"
     audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} The owner of a file can set the file's permissions to run with the owner's or group's permissions, even if the user running the program is not the owner or a member of the group. The most common reason for a SGID program is to enable users to perform functions (such as changing their password) that require root privileges."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC}\n$audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance for this benchmark failed because there might be potential unauthorized SGID programs. Please review the SGID programs that is being outputted"
     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} There are valid reasons for SGID programs, but it is important to identify and review such programs to ensure they are legitimate. Review the files returned by the action in the audit section and check to see if system binaries have a different md5 checksum than what from the package. This is an indication thatthe binary may have been replaced."
     echo
     echo -e "${YELLOW}Remediation:${NC} Ensure that no rogue SGID programs have been introduced into the system. Review the files returned by the action in the Audit section and confirm the integrity of these binaries."
     echo
     echo "Note: The audit above only searches local filesystems. To check whether there are SGID programs elsewhere, run the command below"
     echo "Command: find <partition> -xdev -type f -perm -2000"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Section 6.2.1

elif [[  $section == "6.2.1" ]]; then
     benchmark_title="6.2.1 Ensure accounts in /etc/passwd use shadowed passwords (Automated)"
     audit=$(awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd)
     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Local accounts can uses shadowed passwords. With shadowed passwords, The passwords are saved in shadow password file, /etc/shadow, encrypted by a salted one-way hash. Accounts with a shadowed password have an xin the second field in /etc/passwd. In order for the compliance to pass, there should be no output"

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"
     
     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this benchmark failed because there are accounts that does not use shadowed passwords.This can be seen in the output."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} The /etc/passwd file also contains information like user ID's and group ID's that are used by many system programs. Therefore, the /etc/passwd file must remain world readable. In spite of encoding the password with a randomly-generated one-way hash function, an attacker could still break the system if they got access to the /etc/passwd file. This can be mitigated by using shadowed passwords, thus moving the passwords in the /etc/passwd file to /etc/shadow. The /etc/shadow file is set so only root will be able to read and write. This helps mitigate the risk of an attacker gaining access to the encoded passwords with which to perform a dictionary attack."
     echo
     echo -e "${YELLOW}Remediation:${NC} Run the following command and verify that no output is returned"
     echo "Command: sed -e 's/^\([a-zA-Z0-9_]*\):[^:]*:/\1:x:/' -i /etc/passwd" 
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Section 6.2.2

elif [[ $section == "6.2.2" ]]; then
     benchmark_title="6.2.2 Ensure /etc/shadow password fields are not empty (Automated)"
     audit=$(awk -F: '($2 == "" ) { print $1 " does not have a password ") ' /etc/shadow)
     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} An account with an empty password field means that anybody may log in as that user without providing a password. Therefore, in order for the compliance to pass, there should be no output."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this benchmark failed because there are accounts with empty pasword fields"

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} All accounts must have passwords or be locked to prevent the account from being used by an unauthorized user."
     echo
     echo -e "${YELLOW}Remediation:${NC} If any accounts in the /etc/shadow file do not have a password, run the following command to lock the account until it can be determined why it does not have a password."
     echo "Command: passwd -l <username>"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

# Benchmark Section 6.2.3

elif [[ $section == "6.2.3" ]]; then 
     benchmark_title="6.2.3 Ensure all groups in /etc/passwd exist in /etc/group (Automated)"
     audit=$(for i in $(cut -s -d: -f4 /etc/passwd | sort -u); do
    if ! grep -q -P "^.*?:[^:]*:$i:" /etc/group; then
        echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"
    fi
done)
     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Over time, system administration errors and changes can lead to groups being defined in /etc/passwd but not in /etc/group."
     
     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanantion:${NC} The compliance of this benchmark failed because there are some groups that does not exist in /etc/group"

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} Groups defined in the /etc/passwd file but not in the /etc/group file pose a threat to system security since group permissions are not properly managed."
     echo
     echo -e "${YELLOW}Remediation:${NC} Analyze the output of the Audit step above and perform the appropriate action to correct any discrepancies found."
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Section 6.2.4

elif [[ $section == "6.2.4" ]]; then
     benchmark_title="6.2.4 Ensure shadow group is empty (Automated)"
     audit1=$(awk -F: '($1=="shadow") {print $NF}' /etc/group)
     audit2=$(awk -F: -v GID="$(awk -F: '($1=="shadow") {print $3}' /etc/group)" '($4==GID) {print $1}' /etc/passwd)
     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} The shadow group allows system programs which require access the ability to read the /etc/shadow file. No users should be assigned to the shadow group."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit1 \n $audit2"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this benchmark failed because the shadow group is not empty."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} Any users assigned to the shadow group would be granted read access to the /etc/shadow file. If attackers can gain read access to the /etc/shadow file, they can easily run a password cracking program against the hashed passwords to break them. Other security information that is stored in the /etc/shadow file (such as expiration) could also be useful to subvert additional user accounts."
     echo
     echo -e "${YELLOW}Remediation:${NC}"
     echo "Run the following command to remove all users from the shadow group"
     echo "Command: sed -ri 's/(^shadow:[^:]*:[^:]*:)([^:]+$)/\1/' /etc/group"
     echo "Change the primary group of any users with shadow as their primary group."
     echo "usermod -g <primary group> <user>"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Section 6.2.5
elif [[ $section == "6.2.5" ]]; then
     benchmark_title="6.2.5 Ensure no duplicate UIDs exist (Automated)"
     audit=$(cut -f3 -d":" /etc/passwd | sort -n | uniq -c | while read x ; do
    [ -z "$x" ] && break
    set - $x
    if [ $1 -gt 1 ]; then
        users=$(awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs)
        echo "Duplicate UID ($2): $users"
    fi
done)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Although the useradd program will not let you create a duplicate User ID (UID), it is possible for an administrator to manually edit the /etc/passwd file and change the UID field. For the compliance to pass, no results should be returned from the output."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance for this section failed due to having duplicate UIDs."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale: Users must be assigned unique UIDs for accountability and to ensure appropriate access protections."
     echo
     echo -e "${YELLOW}Remediation: Based on the results of the audit script, establish unique UIDs and review all files owned by the shared UIDs to determine which UID they are supposed to belong to."
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

     


# Benchmark Section 6.2.6
elif [[ $section == "6.2.6" ]]; then
     benchmark_title="6.2.6 Ensure no duplicate GIDs exist (Automated)"
     audit=$(cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do
    echo "Duplicate GID ($x) in /etc/group"
done)
 
     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Although the groupadd program will not let you create a duplicate Group ID (GID), it is possible for an administrator to manually edit the /etc/group file and change the GID field. For the compliance to pass, no results should be in the output."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this benchmark failed as there are duplicate GIDs."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} User groups must be assigned unique GIDs for accountability and to ensure appropriate access protections."
     echo
     echo -e "${YELLOW}Remediation:${NC} Based on the results of the audit script, establish unique GIDs and review all files owned by the shared GID to determine which group they are supposed to belong to."
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo



# Benchmark Section 6.2.7
elif [[ $section == "6.2.7" ]]; then
     benchmark_title="6.2.7 Ensure no duplicate user names exist (Automated)"
     audit=$(cut -d: -f1 /etc/passwd | sort | uniq -d | while read -r x; do
    echo "Duplicate login name $x in /etc/passwd"
done)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Although the useradd program will not let you create a duplicate user name, it is possible for an administrator to manually edit the /etc/passwd file and change the user name."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this benchmark failed as there are dupliate user names present in the output."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} If a user is assigned a duplicate user name, it will create and have access to files with the first UID for that username in /etc/passwd . For example, if "test4" has a UID of 1000 and a subsequent "test4" entry has a UID of 2000, logging in as "test4" will use UID 1000. Effectively, the UID is shared, which is a security problem."
     echo
     echo -e "${YELLOW}Remediation:${NC} Based on the results of the audit script, establish unique user names for the users. File ownerships will automatically reflect the change as long as the users have unique UIDs."
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Section 6.2.8
elif [[ $section == "6.2.8" ]]; then
     benchmark_title="6.2.8 Ensure no duplicate group names exist (Automated)"
     audit=$(cut -d: -f1 /etc/group | sort | uniq -d | while read -r x; do
    echo "Duplicate group name $x in /etc/group"
done)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Although the groupadd program will not let you create a duplicate group name, it is possible for an administrator to manually edit the /etc/group file and change the group name."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as there are duplicate group names present in the output."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} If a group is assigned a duplicate group name, it will create and have access to files with the first GID for that group in /etc/group . Effectively, the GID is shared, which is a security problem."
     echo
     echo -e "${YELLOW}Remediation:${NC} Based on the results of the audit script, establish unique names for the user groups. File group ownerships will automatically reflect the change as long as the groups have unique GIDs."
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Section 6.2.9
elif [[ $section == "6.2.9" ]]; then
     benchmark_title="6.2.9 Ensure root PATH Integrity (Automated)"     audit=$(
RPCV="$(sudo -Hiu root env | grep '^PATH' | cut -d= -f2)"
echo "$RPCV" | grep -q "::" && echo "Root's path contains an empty directory (::)"
echo "$RPCV" | grep -q ":$" && echo "Root's path contains a trailing (:)"
for x in $(echo "$RPCV" | tr ":" " "); do
    if [ -d "$x" ]; then
        ls -ldH "$x" | awk '
            $9 == "." { print "PATH contains current working directory (.)"; exit 1 }
            $3 != "root" { print $9, "is not owned by root"; exit 1 }
            substr($1,6,1) != "-" { print $9, "is group writable"}
            substr($1,9,1) != "-" { print $9, "is world writable"}'
    else
        echo "$x is not a directory"
    fi
done
)
     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} The root user can execute any command on the system and could be fooled into executing programs unintentionally if the PATH is not set correctly."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this bench failed as PATH is not set correctly. Please refer to the output."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} Including the current working directory (.) or other writable directory in root's executable path makes it likely that an attacker can gain superuser access by forcing an administrator operating as root to execute a Trojan horse program."
     echo
     echo -e "${YELLOW}Remediation:${NC} Correct or justify any items discovered in the Audit step."
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Section 6.2.10
elif [[ $section == "6.2.10" ]]; then
     benchmark_title="6.2.10 Ensure root is the only UID 0 account (Automated)"
     audit=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Any account with UID 0 has superuser privileges on the system. To pass this section of the benchmark, ensure that 'root' is being printed out in the output"

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this benchmark failed as there are other accounts with UID 0."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} This access must be limited to only the default root account and only from the system console. Administrative access must be through an unprivileged account using an approved mechanism as noted in Item 5.6 Ensure access to the su command is restricted."
     echo
     echo -e "${YELLOW}Remediation:${NC} Remove any users other than root with UID 0 or assign them a new UID if appropriate"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo


# Benchmark Section 6.2.11
elif [[ $section == "6.2.11" ]]; then
     benchmark_title="6.2.11 Ensure local interactive user home directories exist (Automated)"
     audit=$(
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  [ ! -d "$home" ] && output="$output\n  - User \"$user\" home directory \"$home\" doesn't exist"
done
)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} Users can be defined in /etc/passwd without a home directory or with a home directory that does not actually exist."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as there is something outputted. Refer to Output for more information."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} If the user's home directory does not exist or is unassigned, the user will be placed in "/" and will not be able to write any files or have local environment variables set."
     echo
     echo -e "${YELLOW}Remediation:${NC} If any users' home directories do not exist, create them and make sure the respective user owns the directory. Users without an assigned home directory should be removed or assigned a home directory as appropriate."
     echo "A script that will create a home directory for users with an interactive shell whose home directory doesn't exist will be run under remediation.sh"
     echo 'valid_shells="^($(sed -rn '\''/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '\''|'\'' -))$"

awk -v pat="$valid_shells" -F: '\''$(NF) ~ pat { print $1 " " $(NF-1) }'\'' /etc/passwd | while read -r user home; do

    if [ ! -d "$home" ]; then

        echo -e "\n- User \"$user\" home directory \"$home\" does not exist\n- creating home directory \"$home\"\n"

        mkdir "$home"

        chmod g-w,o-wrx "$home"

        chown "$user" "$home"

    fi

done
'



     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo






# Benchmark Section 6.2.12
elif [[ $section == "6.2.12" ]]; then
     benchmark_title="6.2.12 Ensure local interactive users own their home directories (Automated)"
     audit=$(
output=""
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd | (
    while read -r user home; do
        owner="$(stat -L -c "%U" "$home")"
        [ "$owner" != "$user" ] && output="$output\n - User \"$user\" home directory \"$home\" is owned by user \"$owner\""
done)
)
  
     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} The user home directory is space defined for the particular user to set local environment variables and to store personal files."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as there is something outputted. Refer to Output for more information."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} Since the user is accountable for files stored in the user home directory, the user must be the owner of the directory."
     echo
     echo -e "${YELLOW}Remediation:${NC} The following script will update local interactive user home directories to be own by the user:"
     echo "output=\"\"

valid_shells=\"^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$\"

awk -v pat=\"\$valid_shells\" -F: '\$(NF) ~ pat { print \$1 \" \" \$(NF-1) }' /etc/passwd | while read -r user home; do
    owner=\"\$(stat -L -c \"%U\" \"\$home\")\"
    if [ \"\$owner\" != \"\$user\" ]; then
        echo -e \"\\n- User \"\$user\" home directory \"\$home\" is owned by user \"\$owner\"\\n- changing ownership to \"\$user\"\\n\"
        chown \"\$user\" \"\$home\"
    fi
done
\""



# Benchmark Section 6.2.13
elif [[ $section == "6.2.13" ]]; then
     benchmark_title="6.2.13 Ensure local interactive user home directories are mode 750 or more restrictive (Automated)"
     audit=$(
output=""
perm_mask='0027'
maxperm="$(printf '%o' $((0777 & ~$perm_mask)))"
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  if [ -d "$home" ]; then
    mode=$(stat -L -c '%#a' "$home")
    [ $(( $mode & $perm_mask )) -gt 0 ] && output="$output\n- User $user home directory: \"$home\" is too permissive: \"$mode\" (should be: \"$maxperm\" or more restrictive)"
  fi
done)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} While the system administrator can establish secure permissions for users' home directories, the users can easily override these. To pass this section of the benchmark, the output should be empty"

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as there is something outputted. Refer to Output for more information."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} Group or world-writable user home directories may enable malicious users to steal or modify other users' data or to gain another user's system privileges."
     echo
     echo -e "${YELLOW}Remediation:${NC} The following script can be used to remove permissions is excess of 750 from interactive user home directories:"
     echo "perm_mask='0027'
maxperm=\"\$(printf '%o' \$((0777 & ~\$perm_mask)))\"
valid_shells=\"^(\$(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))\$\"
awk -v pat=\"\$valid_shells\" -F: '\$(NF) ~ pat { print \$1 \" \" \$(NF-1) }' /etc/passwd | (
    while read -r user home; do
        mode=\$(stat -L -c '%#a' \"\$home\")
        if [ \$((\$mode & \$perm_mask)) -gt 0 ]; then
            echo -e \"- modifying User \$user home directory: \"\$home\"\\n- removing excessive permissions from current mode of \"\$mode\"\"
            chmod g-w,o-rwx \"\$home\"
        fi
    done
)"

     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo



      

# Benchmark Section 6.2.14
elif [[ $section == "6.2.14" ]]; then
     benchmark_title="6.2.14 Ensure no local interactive user has .netrc files (Automated)"
     audit=$(
output=""
output2=""
perm_mask='0177'
maxperm="$(printf '%o' $((0777 & ~$perm_mask)))"
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  if [ -f "$home/.netrc" ]; then
    mode="$(stat -L -c '%#a' "$home/.netrc")"
    if [ $(( $mode & $perm_mask )) -gt 0 ]; then
      output="$output\n  - User \"$user\" file: \"$home/.netrc\" is too permissive: \"$mode\" (should be: \"$maxperm\" or more restrictive)"
    else
      output2="$output2\n  - User \"$user\" file: \"$home/.netrc\" exists and has file mode: \"$mode\" (should be: \"$maxperm\" or more restrictive)"
    fi
  fi
done)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} The .netrc file contains data for logging into a remote host for file transfers via FTP.
While the system administrator can establish secure permissions for users' .netrc files, the users can easily override these."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as there is something outputted. Refer to Output for more information."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} The .netrc file presents a significant security risk since it stores passwords in unencrypted form. Even if FTP is disabled, user accounts may have brought over .netrc files from other systems which could pose a risk to those systems.
If a .netrc file is required, and follows local site policy, it should have permissions of 600 or more restrictive."
     echo
     echo -e "${YELLOW}Remediation:${NC} The following script will remove .netrc files from interactive users' home directories: "
     echo "perm_mask='0177'
valid_shells=\"^(\$(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$\"

awk -v pat=\"\$valid_shells\" -F: '\$(NF) ~ pat { print \$1 \" \" \$(NF-1) }' /etc/passwd | while read -r user home; do
    if [ -f \"\$home/.netrc\" ]; then
        echo -e \"\\n- User \"\$user\" file: \"\$home/.netrc\" exists\\n- removing file: \"\$home/.netrc\"\\n\"
        rm -f \"\$home/.netrc\"
    fi
done
"

     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo




# Benchmark Section 6.2.15
elif [[ $section == "6.2.15" ]]; then
     benchmark_title="6.2.15 Ensure no local interactive user has .forward files (Automated)"
     audit=$(output=""
fname=".forward"
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  [ -f "$home/$fname" ] && output="$output\n  - User \"$user\" file: \"$home/$fname\" exists"
done
)
     
     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} The .forward file specifies an email address to forward the user's mail to."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as there is something outputted. Refer to Output for more information."
     
     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} Use of the .forward file poses a security risk in that sensitive data may be inadvertently transferred outside the organization. The .forward file also poses a risk as it can be used to execute commands that may perform unintended actions."
     echo
     echo -e "${YELLOW}Remediation:${NC} The following script will remove .forward files from interactive users' home directories:"
     echo "output=\"\"
fname=\".forward\"
valid_shells=\"^(\$(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$\"

awk -v pat=\"\$valid_shells\" -F: '\$(NF) ~ pat { print \$1 \" \" \$(NF-1) }' /etc/passwd | (
    while read -r user home; do
        if [ -f \"\$home/\$fname\" ]; then
            echo -e \"\$output\\n- User \"\$user\" file: \"\$home/\$fname\" exists\\n- removing file: \"\$home/\$fname\"\\n\"
            rm -r \"\$home/\$fname\"
        fi
    done
)
"

     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

# Benchmark Section 6.2.16
elif [[ $section == "6.2.16" ]]; then
     benchmark_title="6.2.16 Ensure no local interactive user has .rhosts files (Automated)"
     audit=$(
output=""
fname=".rhosts"
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  [ -f "$home/$fname" ] && output="$output\n  - User \"$user\" file: \"$home/$fname\" exists"
done
)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} While no .rhosts files are shipped by default, users can easily create them."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as there is something outputted. Refer to Output for more information."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} This action is only meaningful if .rhosts support is permitted in the file /etc/pam.conf . Even though the .rhosts files are ineffective if support is disabled in /etc/pam.conf, they may have been brought over from other systems and could contain information useful to an attacker for those other systems."
     echo
     echo -e "${YELLOW}Remediation:${NC} The following script will remove .rhosts files from interactive users's home directories:"
     echo "perm_mask='0177'
valid_shells=\"^(\$(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$\"

awk -v pat=\"\$valid_shells\" -F: '\$(NF) ~ pat { print \$1 \" \" \$(NF-1) }' /etc/passwd | while read -r user home; do
    if [ -f \"\$home/.rhosts\" ]; then
        echo -e \"\\n- User \"\$user\" file: \"\$home/.rhosts\" exists\\n- removing file: \"\$home/.rhosts\"\\n\"
        rm -f \"\$home/.rhosts\"
    fi
done
"


     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

# Benchmark Section 6.2.17
elif [[ $section == "6.2.17" ]]; then
     benchmark_title="6.2.17 Ensure local interactive user dot files are not group or world writable (Automated)"
     audit=$(output=""
perm_mask='0022'
maxperm="$(printf '%o' $((0777 & ~$perm_mask)))"
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  for dfile in $(find "$home" -type f -name '.*'); do
    mode=$(stat -L -c '%#a' "$dfile")
    [ $(( $mode & $perm_mask )) -gt 0 ] && output="$output\n- User $user file: \"$dfile\" is too permissive: \"$mode\" (should be: \"$maxperm\" or more restrictive)"
  done
done
)

     echo -e "\n"
     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo -e "${YELLOW}Title: ${NC}$benchmark_title"

     # Description
     echo
     echo -e "${YELLOW}Description:${NC} While the system administrator can establish secure permissions for users' "dot" files, the users can easily override these."

     # Compliance
     echo
     echo -e "${YELLOW}Compliance:${RED} Fail${NC}"

     # Output
     echo
     echo -e "${YELLOW}Output:${NC} $audit"

     # Explanation
     echo
     echo -e "${YELLOW}Explanation:${NC} The compliance of this section failed as there is something outputted. Refer to Output for more information."

     # Rationale and Remediation
     echo
     echo -e "${YELLOW}Rationale:${NC} Group or world-writable user configuration files may enable malicious users to steal or modify other users' data or to gain another user's system privileges."
     echo
     echo -e "${YELLOW}Remediation:${NC} The following script will remove excessive permissions on dot files within interactive users' home directories:"
     echo "perm_mask='0022'
valid_shells=\"^(\$(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$\"

awk -v pat=\"\$valid_shells\" -F: '\$(NF) ~ pat { print \$1 \" \" \$(NF-1) }' /etc/passwd | while read -r user home; do
    find \"\$home\" -type f -name '.*' | while read -r dfile; do
        mode=\$(stat -L -c '%#a' \"\$dfile\")
        if [ \$((mode & perm_mask)) -gt 0 ]; then
            echo -e \"\\n- Modifying User \"\$user\" file: \"\$dfile\"\\n- removing group and other write permissions\"
            chmod go-w \"\$dfile\"
        fi
    done
done
"

     echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
     echo

     

    




     


else
    echo "Invalid section: $section"

fi 


