#!/bin/bash

# color of compliance
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No color

section=$1
output_file="failed_sections_output.txt"


if [[ $section == "2.2.1" ]]; then
    
    touch "$output_file"

    benchmark_title="2.2.1 Ensure X Window System is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' xserver-xorg* | grep -Pi '\h+installed\b')

    if [[ -n "$audit" ]] && ! grep -qF "$audit" "$output_file"; then
        {
    echo "#####################################################################################################################################################################################################" 
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

     } >> "$output_file"

  fi

# Benchmark Section 2.2.2
elif [[ $section == "2.2.2" ]]; then
    benchmark_title="2.2.2 Ensure Avahi Server is not installed (Automated)"
    audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' avahi-daemon)

    if [[ -n "$audit" ]] && ! grep -qF "$audit" "$output_file"; then
        {
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

     } >> "${output_file}"
  fi

else
    echo "Invalid section: $section"

fi



