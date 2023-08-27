#!/bin/bash
exec &> >(tee netconfig.txt)

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
    echo -e "\n${red}                                                                                          failed Sections:${NC}\n"
    for section in $failed_sections; do
        case $section in
 "3.1.1") $fails_script 3.1.1 ;;
                "3.1.2") $fails_script 3.1.2 ;;
                "3.2.1") $fails_script 3.2.1 ;;
                "3.2.2") $fails_script 3.2.2 ;;
                "3.3.1") $fails_script 3.3.1 ;;
                "3.3.2") $fails_script 3.3.2 ;;
                "3.3.3") $fails_script 3.3.3 ;;
                "3.3.4") $fails_script 3.3.4 ;;
                "3.3.5") $fails_script 3.3.5 ;;
                "3.3.6") $fails_script 3.3.6 ;;
                "3.3.7") $fails_script 3.3.7 ;;
                "3.3.8") $fails_script 3.3.8 ;;
                "3.3.9") $fails_script 3.3.9 ;;
                "3.4.1") $fails_script 3.4.1 ;;
                "3.4.2") $fails_script 3.4.2 ;;
                "3.4.3") $fails_script 3.4.3 ;;
                "3.4.4") $fails_script 3.4.4 ;;
                "3.5.1.1") $fails_script 3.5.1.1 ;;
                "3.5.1.2") $fails_script 3.5.1.2 ;;
                "3.5.1.3") $fails_script 3.5.1.3 ;;
                "3.5.1.4") $fails_script 3.5.1.4 ;;
                "3.5.1.5") $fails_script 3.5.1.5 ;;
                "3.5.1.6") $fails_script 3.5.1.6 ;;
                "3.5.1.7") $fails_script 3.5.1.7 ;;
                "3.5.2.1") $fails_script 3.5.2.1 ;;
                "3.5.2.2") $fails_script 3.5.2.2 ;;
                "3.5.2.3") $fails_script 3.5.2.3 ;;
                "3.5.2.4") $fails_script 3.5.2.4 ;;
                "3.5.2.5") $fails_script 3.5.2.5 ;;
                "3.5.2.6") $fails_script 3.5.2.6 ;;
                "3.5.2.7") $fails_script 3.5.2.7 ;;
                "3.5.2.8") $fails_script 3.5.2.8 ;;
                "3.5.2.9") $fails_script 3.5.2.9 ;;
                "3.5.2.10") $fails_script 3.5.2.10 ;;
                "3.5.3.1.1") $fails_script 3.5.3.1.1 ;;
                "3.5.3.1.2") $fails_script 3.5.3.1.2 ;;
                "3.5.3.1.3") $fails_script 3.5.3.1.3 ;;
                "3.5.3.2.1") $fails_script 3.5.3.2.1 ;;
                "3.5.3.2.2") $fails_script 3.5.3.2.2 ;;
                "3.5.3.2.3") $fails_script 3.5.3.2.3 ;;
                "3.5.3.2.4") $fails_script 3.5.3.2.4 ;;
                "3.5.3.3.1") $fails_script 3.5.3.3.1 ;;
                "3.5.3.3.2") $fails_script 3.5.3.3.2 ;;
                "3.5.3.3.3") $fails_script 3.5.3.3.3 ;;
                "3.5.3.3.4") $fails_script 3.5.3.3.4 ;;
 # Add more cases for other sections if needed
            *) echo "Invalid section: $section" ;;
        esac
        echo
    done
}


echo
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                       Automated Audit Tool for Linux(2)                                                     |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo -e "|${YELLOW}Section${NC}  | ${YELLOW}Title${NC}                                                                                                          | ${YELLOW}Compliance${NC}       |"

#Section 3 -Javier
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                                 3 Network Configuration                                                     |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Section 3.1

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.1       | Disable unused network protocols and devices                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

{
        #3.1.1
# Function to check if IPv6 is enabled
function check_ipv6_enabled() {
        # Check if IPv6 is enabled through the GRUB2 config
        if grep -q "^\s*GRUB_CMDLINE_LINUX.*ipv6.disable=1" /etc/default/grub; then
                echo -e "|${red}3.1.1     | Ensure system is checked to determine if IPv6 is enabled (Manual)                                             | FAIL       ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.1.1 "
        else
                # Check if IPv6 is disabled through sysctl setting
                if sysctl -a | grep -q "net.ipv6.conf.all.disable_ipv6 = 1" || \
                sysctl -a | grep -q "net.ipv6.conf.default.disable_ipv6 = 1" || \
                sysctl -a | grep -q "net.ipv6.route.flush = 1"; then
                        echo -e "|${red}3.1.1     | Ensure system is checked to determine if IPv6 is enabled (Manual)                                             | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.1.1 "
                else
                        echo -e "|3.1.1     | Ensure system is checked to determine if IPv6 is enabled (Manual)                                             | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                fi
        fi
}
# Execute the check function
check_ipv6_enabled
}
((total++))

{
        #3.1.2
# Function to check if wireless interfaces are disabled
function check_wireless_interfaces_disabled() {
        # Check for active wireless interfaces using nmcli
        if nmcli radio all | grep -Eq '\s*\S+\s+enabled\s+\S+\s+enabled\b'; then
                echo -e "|${red}3.1.2     | Ensure wireless interfaces are disabled (Automated)                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.1.2 "
        else
                # Check for wireless interfaces in /sys/class/net/ directory
                if find /sys/class/net/*/ -type d -name wireless 2>/dev/null | grep -q .; then
                        echo -e "|${red}3.1.2 | Ensure wireless interfaces are disabled (Automated)                                                           | FAIL            ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.1.2 "
                else
                        echo -e "|3.1.2     | Ensure wireless interfaces are disabled (Automated)                                                           | ${green}PASS${normal}            |"
                        pass_count=$((pass_count + 1))
                fi
        fi
}
# Execute the check function
check_wireless_interfaces_disabled
}
((total++))

# Section 3.2

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.2       | Network Parameters (Host Only)                                                                                |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #3.2.1
# Function to check if packet redirect sending is disabled
function check_packet_redirect() {
        # Get the value of the `send_redirects` parameter in sysctl
        send_redirects=$(sysctl -n net.ipv4.conf.all.send_redirects)
        send_redirects_default=$(sysctl -n net.ipv4.conf.default.send_redirects)

        # Check if the value is set to 0, which means packet redirect sending is disabled
        if [[ "$send_redirects" && "$send_redirects_default" -eq 0 ]]; then
                echo -e "| 3.2.1     | Ensure packet redirect sending is disabled (Automated)                                                       | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 3.2.1     | Ensure packet redirect sending is disabled (Automated)                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.2.1 "
        fi
}
# Execute the check function
check_packet_redirect
}
((total++))

{
        #3.2.2
# Function to check if IP forwarding is disabled
function check_ip_forwarding() {
        # Get the values of net.ipv4.ip_forward and net.ipv6.conf.all.forwarding from sysctl
        ipv4_forward=$(sysctl -n net.ipv4.ip_forward)
        ipv6_forward=$(sysctl -n net.ipv6.conf.all.forwarding)

        # Check if both values are set to 0, indicating that IP forwarding is disabled
        if [ "$ipv4_forward" -eq 0 ] && [ "$ipv6_forward" -eq 0 ]; then
                echo -e "| 3.2.2     | Ensure IP forwarding is disabled (Automated)                                                                 | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 3.2.2     | Ensure IP forwarding is disabled (Automated)                                                                 | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.2.2 "
        fi
}
# Execute the check function
check_ip_forwarding
}
((total++))


# Section 3.3

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.3       | Network Parameters (Host and Router)                                                                          |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

{
        #3.3.1
# Function to check if source routed packets are not accepted
function check_source_route() {
        # Get the values of the relevant sysctl settings
        ipv4_all_accept_source_route=$(sysctl -n net.ipv4.conf.all.accept_source_route)
        ipv4_default_accept_source_route=$(sysctl -n net.ipv4.conf.default.accept_source_route)
        ipv6_all_accept_source_route=$(sysctl -n net.ipv6.conf.all.accept_source_route)
        ipv6_default_accept_source_route=$(sysctl -n net.ipv6.conf.default.accept_source_route)

        # Check if all the settings are set to 0, indicating that source routed packets are not accepted
        if [ "$ipv4_all_accept_source_route" -eq 0 ] && \
        [ "$ipv4_default_accept_source_route" -eq 0 ] && \
        [ "$ipv6_all_accept_source_route" -eq 0 ] && \
        [ "$ipv6_default_accept_source_route" -eq 0 ]; then
        echo -e "|3.3.1     | Ensure source routed packets are not accepted (Automated)                                                     | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
    else
        echo -e "|${red}3.3.1     | Ensure source routed packets are not accepted (Automated)                                                     |  FAIL             ${normal}|"
        fail_count=$((fail_count + 1))
        failed_sections+="3.3.1 "
    fi
}
# Execute the check function
check_source_route
}
((total++))

{
        #3.3.2
# Function to check if ICMP redirects are not accepted
function check_icmp_redirects() {
        # Get the values of the relevant sysctl settings
        ipv4_all_accept_redirects=$(sysctl -n net.ipv4.conf.all.accept_redirects)
        ipv4_default_accept_redirects=$(sysctl -n net.ipv4.conf.default.accept_redirects)
        ipv6_all_accept_redirects=$(sysctl -n net.ipv6.conf.all.accept_redirects)
        ipv6_default_accept_redirects=$(sysctl -n net.ipv6.conf.default.accept_redirects)

        # Check if all the settings are set to 0, indicating that ICMP redirects are not accepted
        if [ "$ipv4_all_accept_redirects" -eq 0 ] && \
        [ "$ipv4_default_accept_redirects" -eq 0 ] && \
            [ "$ipv6_all_accept_redirects" -eq 0 ] && \
        [ "$ipv6_default_accept_redirects" -eq 0 ]; then
                echo -e "|3.3.2     | Ensure ICMP redirects are not accepted (Automated)                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.2     | Ensure ICMP redirects are not accepted (Automated)                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.2 "
        fi
}
# Execute the check function
check_icmp_redirects
}
((total++))

{
        #3.3.3
# Function to check if secure ICMP redirects are not accepted
function check_secure_icmp_redirects() {
    # Get the values of the relevant sysctl settings
    ipv4_default_secure_redirects=$(sysctl -n net.ipv4.conf.default.secure_redirects)
    ipv4_all_secure_redirects=$(sysctl -n net.ipv4.conf.all.secure_redirects)

    # Check if both settings are set to 0, indicating that secure ICMP redirects are not accepted
    if [ "$ipv4_default_secure_redirects" -eq 0 ] && [ "$ipv4_all_secure_redirects" -eq 0 ]; then
        echo -e "|3.3.3     | Ensure secure ICMP redirects are not accepted (Automated)                                                     | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
    else
        echo -e "|${red}3.3.3     | Ensure secure ICMP redirects are not accepted (Automated)                                                     | FAIL             ${normal}|"
        fail_count=$((fail_count + 1))
        failed_sections+="3.3.3 "
    fi
}
# Execute the check function
check_secure_icmp_redirects
}
((total++))


{
        #3.3.4
# Function to check if suspicious packets are logged
function check_suspicious_packets_logged() {
        # Check if net.ipv4.conf.all.log_martians is set to 1
        if [[ $(sysctl -n net.ipv4.conf.all.log_martians) -eq 1 ]]; then
                # Check if net.ipv4.conf.default.log_martians is set to 1
                if [[ $(sysctl -n net.ipv4.conf.default.log_martians) -eq 1 ]]; then
                        echo -e "|3.3.4     | Ensure suspicious packets are logged (Automated)                                                              | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red}3.3.4     | Ensure suspicious packets are logged (Automated)                                                              | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.3.4 "
                fi
        else
                echo -e "|${red}3.3.4     | Ensure suspicious packets are logged (Automated)                                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.4 "
        fi
}
# Execute the check function
check_suspicious_packets_logged
}
((total++))

{
        #3.3.5
# Function to check if broadcast ICMP requests are ignored
function check_ignore_broadcast_icmp() {
        # Check if net.ipv4.icmp_echo_ignore_broadcasts is set to 1
        if [[ $(sysctl -n net.ipv4.icmp_echo_ignore_broadcasts) -eq 1 ]]; then
                echo -e "|3.3.5     | Ensure broadcast ICMP requests are ignored (Automated)                                                        | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 3.3.5     | Ensure broadcast ICMP requests are ignored (Automated)                                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.5 "
        fi
}
# Execute the check function
check_ignore_broadcast_icmp
}
((total++))

{
        #3.3.6
# Function to check if bogus ICMP responses are ignored
function check_ignore_bogus_icmp() {
        # Check if net.ipv4.icmp_ignore_bogus_error_responses is set to 1
        if [[ $(sysctl -n net.ipv4.icmp_ignore_bogus_error_responses) -eq 1 ]]; then
                echo -e "|3.3.6     | Ensure bogus ICMP responses are ignored (Automated)                                                           |${green} PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.6     | Ensure bogus ICMP responses are ignored (Automated)                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.6 "
        fi
}
# Execute the check function
check_ignore_bogus_icmp
}
((total++))

{
        #3.3.7
# Function to check if Reverse Path Filtering is enabled
function check_reverse_path_filter() {
        # Check if net.ipv4.conf.all.rp_filter and net.ipv4.conf.default.rp_filter are set to 1
        if [[ $(sysctl -n net.ipv4.conf.all.rp_filter) -eq 1 ]] && [[ $(sysctl -n net.ipv4.conf.default.rp_filter) -eq 1 ]]; then
                echo -e "|3.3.7     | Ensure Reverse Path Filtering is enabled (Automated)                                                          | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.7     | Ensure Reverse Path Filtering is enabled (Automated)                                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.7 "
        fi
}
# Execute the check function
check_reverse_path_filter
}
((total++))

{
        #3.3.8
# Function to check if TCP SYN Cookies are enabled
function check_tcp_syn_cookies() {
        # Check if net.ipv4.tcp_syncookies is set to 1
        if [[ $(sysctl -n net.ipv4.tcp_syncookies) -eq 1 ]]; then
                echo -e "|3.3.8     | Ensure TCP SYN Cookies is enabled (Automated)                                                                 | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.8     | Ensure TCP SYN Cookies is enabled (Automated)                                                                 | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.8 "
        fi
}
((total++))
# Execute the check function
check_tcp_syn_cookies
}

{
        #3.3.9
# Function to check if IPv6 router advertisements are not accepted
function check_ipv6_router_advertisements() {
        # Check if net.ipv6.conf.all.accept_ra is set to 0 and net.ipv6.conf.default.accept_ra is set to 0
        if [[ $(sysctl -n net.ipv6.conf.all.accept_ra) -eq 0 && $(sysctl -n net.ipv6.conf.default.accept_ra) -eq 0 ]]; then
                echo -e "|3.3.9     | Ensure IPv6 router advertisements are not accepted (Automated)                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.9     | Ensure IPv6 router advertisements are not accepted (Automated)                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.9 "
        fi
}
# Execute the check function
check_ipv6_router_advertisements
}
((total++))


# Section 3.4

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.4       | Uncommon Network Protocols                                                                                    |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #3.4.1
# Function to check if DCCP is disabled
function check_dccp_disabled() {
        # Check if DCCP kernel module is loaded
        if lsmod | grep -q '^dccp\s'; then
                echo -e "|${red}3.4.1     | Ensure DCCP is disabled (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.1 "
        else
                echo -e "|3.4.1     | Ensure DCCP is disabled (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_dccp_disabled
}
((total++))

{
        #3.4.2
# Function to check if SCTP is disabled
function check_sctp_disabled() {
        # Check if SCTP kernel module is loaded
           if lsmod | grep -q '^sctp\s'; then
                   echo -e "|${red}3.4.2     | Ensure SCTP is disabled (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.2 "
        else
                echo -e "|3.4.2     | Ensure SCTP is disabled (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_sctp_disabled
}
((total++))

{
        #3.4.3
# Function to check if RDS is disabled
function check_rds_disabled() {
        # Check if RDS kernel module is loaded
        if lsmod | grep -q '^rds\s'; then
                echo -e "|${red}3.4.3     | Ensure RDS is disabled (Automated)                                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.3 "
        else
                echo -e "|3.4.3     | Ensure RDS is disabled (Automated)                                                                            | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_rds_disabled
}
((total++))

{
        #3.4.4
# Function to check if TIPC is disabled
function check_tipc_disabled() {
        # Check if TIPC kernel module is loaded
        if lsmod | grep -q '^tipc\s'; then
                echo -e "|${red}3.4.4     | Ensure TIPC is disabled (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.4 "
        else
                echo -e "|3.4.4     | Ensure TIPC is disabled (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_tipc_disabled
}
((total++))



# Section 3.5

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5       | Firewall Configuration                                                                                        |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"



    {
        #3.5.1.1
# Function to check if ufw is installed
function check_ufw_installed() {
        # Check if ufw package is installed
        if dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' ufw | grep -q '^ufw\s*install\s*ok\s*installed'; then
                echo -e "|3.5.1.1   | Ensure ufw is installed (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.1.1   | Ensure ufw is installed (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.1 "
        fi
}
# Execute the check function
check_ufw_installed
}
((total++))

{
        #3.5.1.2
# Function to check if iptables-persistent is installed
function check_iptables_persistent() {
        # Check if iptables-persistent package is not installed
        if ! dpkg-query -s iptables-persistent &>/dev/null; then
                echo -e "|3.5.1.2   | Ensure iptables-persistent is not installed with ufw (Automated)                                              | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.1.2   | Ensure iptables-persistent is not installed with ufw (Automated)                                              | FAIL       ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.2 "
        fi
}
# Execute the check function
check_iptables_persistent
}
((total++))

{
        #3.5.1.3

# Function to check if ufw service is enabled and active
function check_ufw_status() {
        # Check if ufw service is enabled
        if systemctl is-enabled ufw.service | grep -q 'enabled'; then
                # Check if ufw service is active
                if systemctl is-active ufw | grep -q 'active'; then
                        # Check if ufw is active
                        if ufw status | grep -q 'Status: active'; then
                                echo -e "|3.5.1.3   | Ensure ufw service is enabled (Automated)                                                                     | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
                                echo -e "|${red}3.5.1.3   | Ensure ufw service is enabled (Automated)                                                                     | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="3.5.1.3 "
                        fi
                else
                        echo -e "|${red}3.5.1.3   | Ensure ufw service is enabled (Automated)                                                                     | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.1.3 "
                fi
        else
                echo -e "|${red}3.5.1.3   | Ensure ufw service is enabled (Automated)                                                                     | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.3 "
        fi
}
# Execute the check function
check_ufw_status
}
((total++))

{
        #3.5.1.4
# Function to check ufw loopback traffic configuration
function check_ufw_loopback_traffic() {
        ufw_status=$(ufw status verbose)

        # Check if the required loopback rules are present in the ufw status output
        if echo "$ufw_status" | grep -q "Anywhere on lo\s*ALLOW IN\s*Anywhere" &&
        echo "$ufw_status" | grep -q "Anywhere DENY IN 127.0.0.0/8" &&
        echo "$ufw_status" | grep -q "Anywhere \(v6\) on lo\s*ALLOW IN\s*Anywhere \(v6\)" &&
        echo "$ufw_status" | grep -q "Anywhere \(v6\) DENY IN ::1" &&
        echo "$ufw_status" | grep -q "Anywhere ALLOW OUT Anywhere on lo" &&
        echo "$ufw_status" | grep -q "Anywhere \(v6\) ALLOW OUT Anywhere \(v6\) on lo"; then
                echo -e "|3.5.1.4   | Ensure ufw loopback traffic is configured (Automated)                                                         | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.1.4   | Ensure ufw loopback traffic is configured (Automated)                                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.4 "
        fi
}
# Execute the check function
check_ufw_loopback_traffic
}
((total++))

{
        #3.5.1.5
# Function to check if ufw outbound connections are configured
function check_ufw_outbound_connections() {
        ufw_status=$(ufw status numbered)

        if echo "$ufw_status" | grep -q "Status: active"; then
                if echo "$ufw_status" | grep -q "allow out on all"; then
                        echo -e "|3.5.1.5   | Ensure ufw outbound connections are configured (Manual)                                                       | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red}3.5.1.5   | Ensure ufw outbound connections are configured (Manual)                                                       | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.1.5 "
                fi
        else
                echo -e "|${red}3.5.1.5   | Ensure ufw outbound connections are configured (Manual)                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.5 "
        fi
}
# Execute the check function
check_ufw_outbound_connections
}
((total++))

{
        #3.5.1.6
function check_ufw_open_ports() {
        ufw_out="$(ufw status verbose)"
        open_ports=$(ss -tuln | awk '($5!~/%lo:/ && $5!~/127.0.0.1:/ && $5!~/::1/) {split($5, a, ":"); print a[2]}')
        missing_rules=0

        while read -r lpn; do
                if ! grep -Pq "^\h*$lpn\b" <<< "$ufw_out"; then
                        missing_rules=$((missing_rules + 1))
                fi
        done <<< "$open_ports"

        if [ $missing_rules -eq 0 ]; then
                echo -e "|3.5.1.6   | Ensure ufw firewall rules exist for all open ports (Automated)                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.1.6   | Ensure ufw firewall rules exist for all open ports (Automated)                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.6 "
        fi
}
# Execute the check function
check_ufw_open_ports
}
((total++))


{
        #3.5.1.7
# Function to check ufw default deny firewall policy
function check_ufw_default_deny_policy() {
        ufw_status=$(ufw status verbose | grep Default:)

        if echo "$ufw_status" | grep -q "Default: deny (incoming)"; then
                if echo "$ufw_status" | grep -q "Default: reject (outgoing)"; then
                        if echo "$ufw_status" | grep -q "Default: disabled (routed)"; then
                                echo -e "|3.5.1.7   | Ensure ufw default deny firewall policy (Automated)                                                           | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
                                echo -e "|${red}3.5.1.7   | Ensure ufw default deny firewall policy (Automated)                                                           | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="3.5.1.7 "
                        fi
                else
                        echo -e "|${red}3.5.1.7   | Ensure ufw default deny firewall policy (Automated)                                                           | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.1.7 "
                fi
        else
                echo -e "|${red}3.5.1.7   | Ensure ufw default deny firewall policy (Automated)                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.7 "
        fi
}
# Execute the check function
check_ufw_default_deny_policy
}
((total++))





# Section 3.5.2

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.2     | Configure nftables                                                                                            |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #3.5.2.1
# Function to check if nftables is installed
function check_nftables_installed() {
        if dpkg-query -s nftables 2>/dev/null | grep -q 'Status: install ok installed'; then
                echo -e "|3.5.2.1   | Ensure nftables is installed (Automated)                                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.1   | Ensure nftables is installed (Automated)                                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.1 "
        fi
}
# Execute the check function
check_nftables_installed
}
((total++))

{
        #3.5.2.2
# Function to check if ufw is uninstalled or disabled with nftables
function check_ufw_disabled_with_nftables() {
        # Check if ufw is installed
        if dpkg-query -s ufw 2>/dev/null | grep -q 'Status: install ok installed'; then
                # Check if ufw is disabled
                ufw_status=$(ufw status 2>/dev/null)
                if grep -q 'Status: inactive' <<< "$ufw_status"; then
                        echo -e "|3.5.2.2   | Ensure ufw is uninstalled or disabled with nftables (Automated)                                               | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red}3.5.2.2   | Ensure ufw is uninstalled or disabled with nftables (Automated)                                               | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.2 "
                fi
        else
                echo -e "|3.5.2.2   | Ensure ufw is uninstalled or disabled with nftables (Automated)                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_ufw_disabled_with_nftables
}
((total++))

{
        #3.5.2.3
# Function to check if iptables are flushed with nftables
function check_iptables_flushed_with_nftables() {
        # Check iptables rules
        iptables_rules=$(iptables -L)
        if [[ -z "$iptables_rules" ]]; then
                # Check ip6tables rules
                ip6tables_rules=$(ip6tables -L)
                if [[ -z "$ip6tables_rules" ]]; then
                        echo -e "|3.5.2.3   | Ensure iptables are flushed with nftables (Manual)                                                            | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red}3.5.2.3   | Ensure iptables are flushed with nftables (Manual)                                                            | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.3 "
                fi
        else
                echo -e "|${red}3.5.2.3   | Ensure iptables are flushed with nftables (Manual)                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.3 "
        fi
}
# Execute the check function
check_iptables_flushed_with_nftables
}
((total++))

{
        #3.5.2.4
# Function to check if a nftables table exists
function check_nftables_table_exists() {
        # Define the name of the table to check
        table_name="my_table"  # Replace "my_table" with the actual table name

        # Check if the table exists using nft list tables command
        nft_list_tables=$(nft list tables)

        if grep -q "table $table_name" <<< "$nft_list_tables"; then
                echo -e "|3.5.2.4   | Ensure a nftables table exists (Automated)                                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.4   | Ensure a nftables table exists (Automated)                                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.4 "
        fi
}
# Execute the check function
check_nftables_table_exists
}
((total++))

{
        #3.5.2.5
# Function to check if base chains exist in nftables
function check_nftables_base_chains() {
        # Check if base chains exist for INPUT, FORWARD, and OUTPUT
        if nft list ruleset | grep -q 'hook input'; then
                if nft list ruleset | grep -q 'hook forward'; then
                        if nft list ruleset | grep -q 'hook output'; then
                                echo -e "|3.5.2.5   | Ensure nftables base chains exist (Automated)                                                                 | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
                                echo -e "|${red}3.5.2.5   | Ensure nftables base chains exist (Automated)                                                                 | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="3.5.2.5 "
                        fi
                else
                        echo -e "|${red}3.5.2.5   | Ensure nftables base chains exist (Automated)                                                                 | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.5 "
                fi
        else
                echo -e "|${red}3.5.2.5   | Ensure nftables base chains exist (Automated)                                                                 | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.5 "
        fi
}
# Execute the check function
check_nftables_base_chains
}
((total++))

{
        #3.5.2.6
# Function to check if nftables loopback traffic is configured
function check_nftables_loopback_config() {
        # Check for loopback interface configuration
        if nft list ruleset | awk '/hook input/,/}/' | grep -q 'iif "lo" accept' &&
        nft list ruleset | awk '/hook input/,/}/' | grep -q 'ip saddr 127.0.0.0/8 counter packets 0 bytes 0 drop'; then
                echo -e "|3.5.2.6   | Ensure nftables loopback traffic is configured (Automated)                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.6   | Ensure nftables loopback traffic is configured (Automated)                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.6 "
    fi
}
# Execute the check function
check_nftables_loopback_config
}
((total++))

{
        #3.5.2.7
# Function to check if nftables outbound and established connections are configured
function check_nftables_outbound_config() {
        # Check for outbound established connections
        local outbound_established_rules=(
                "ip protocol tcp ct state established accept"
                "ip protocol udp ct state established accept"
                "ip protocol icmp ct state established accept"
        )

        # Check for outbound established, related, new connections
        local outbound_established_related_new_rules=(
                "ip protocol tcp ct state established,related,new accept"
                "ip protocol udp ct state established,related,new accept"
                "ip protocol icmp ct state established,related,new accept"
        )

        # Check outbound rules
        local outbound_rules=$(nft list ruleset | awk '/hook output/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state')

        for rule in "${outbound_established_rules[@]}"; do
                if ! grep -q "$rule" <<< "$outbound_rules"; then
                        echo -e "|${red}3.5.2.7   | Ensure nftables outbound and established connections are configured (Manual)                                  | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.7 "
                return 1
                fi
        done

        # Check outbound related new rules
        local outbound_related_new_rules=$(nft list ruleset | awk '/hook output/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state')

        for rule in "${outbound_established_related_new_rules[@]}"; do
                if ! grep -q "$rule" <<< "$outbound_related_new_rules"; then
                        echo -e "|${red}3.5.2.7   | Ensure nftables outbound and established connections are configured (Manual)                                  | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.7 "
                        return 1
                fi
        done

        echo -e "|3.5.2.7   | Ensure nftables outbound and established connections are configured (Manual)                                  | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
        return 0
}
# Execute the check function
check_nftables_outbound_config
}
((total++))

{
        #3.5.2.8
# Function to check if nftables has a default deny firewall policy
function check_nftables_default_deny() {
        # Check base chains for policy DROP
        local base_chains=("input" "forward" "output")

        for chain in "${base_chains[@]}"; do
                local policy=$(nft list ruleset | grep "hook $chain" | grep "policy drop")
                if [ -z "$policy" ]; then
                        echo -e "|${red}3.5.2.8   | Ensure nftables default deny firewall policy (Automated)                                                      | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.8 "
                        return 1
                fi
        done

        echo -e "|3.5.2.8   | Ensure nftables default deny firewall policy (Automated)                                                      | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
        return 0
}
# Execute the check function
check_nftables_default_deny
}
((total++))

{
        #3.5.2.9
# Function to check if nftables service is enabled
function check_nftables_service_enabled() {
        if systemctl is-enabled nftables | grep -q "enabled"; then
                echo -e "|3.5.2.9   | Ensure nftables service is enabled (Automated)                                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.9   | Ensure nftables service is enabled (Automated)                                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.9 "
        fi
}
# Execute the check function
check_nftables_service_enabled
}
((total++))

{
        #3.5.2.10
# Function to check if nftables rules are permanent
function check_nftables_rules_permanent() {
        if [ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook input/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$" &&
            [ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook forward/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$" &&
        [ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook output/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$"; then
                echo -e "|3.5.2.10  | Ensure nftables rules are permanent (Automated)                                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.10  | Ensure nftables rules are permanent (Automated)                                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.10 "
        fi
}
# Execute the check function
check_nftables_rules_permanent
}
((total++))



# Section 3.5.3
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.3     | Configure iptables                                                                                            |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.3.1   | Configure iptables software                                                                                   |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #3.5.3.1.1
# Function to check if iptables and iptables-persistent packages are installed
function check_iptables_installed() {
        if apt list iptables iptables-persistent 2>/dev/null | grep -q "installed"; then
                echo -e "|3.5.3.1.1 | Ensure iptables packages are installed (Automated)                                                            | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.1.1 | Ensure iptables packages are installed (Automated)                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.1.1"
        fi
}
# Execute the check function
check_iptables_installed
}
((total++))

{
        #3.5.3.1.2
# Function to check if nftables is not installed with iptables
function check_nftables_not_installed() {
        if ! dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' nftables 2>/dev/null | grep -q "installed"; then
                echo -e "|3.5.3.1.2 | Ensure nftables is not installed with iptables (Automated)                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.1.2 | Ensure nftables is not installed with iptables (Automated)                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.1.2 "
        fi
}
# Execute the check function
check_nftables_not_installed
}
((total++))


{
        #3.5.3.1.3
# Function to check if ufw is uninstalled or disabled with iptables
function check_ufw_not_installed_disabled() {
        # Check if ufw is not installed
        if ! dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' ufw 2>/dev/null | grep -q "installed"; then
                # Check if ufw status shows it as disabled
                if ufw status | grep -q "Status: inactive"; then
                        # Check if ufw service is masked
                        if systemctl is-enabled ufw | grep -q "masked"; then
                                echo -e "|3.5.3.1.3 | Ensure ufw is uninstalled or disabled with iptables (Automated)                                               | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
                                echo -e "|${red}3.5.3.1.3 | Ensure ufw is uninstalled or disabled with iptables (Automated)                                               | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="3.5.3.1.3 "
                        fi
                else
                        echo -e "|${red}3.5.3.1.3 | Ensure ufw is uninstalled or disabled with iptables (Automated)                                               | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.3.1.3 "
                fi
        else
                echo -e "|${red}3.5.3.1.3 | Ensure ufw is uninstalled or disabled with iptables (Automated)                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.1.3 "
        fi
}
# Execute the check function
check_ufw_not_installed_disabled
}
((total++))

echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.3.2   | Configure IPv4 iptables                                                                                       |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


{
        #3.5.3.2.1
# Function to check iptables default deny firewall policy
function check_iptables_default_policy() {
        # Check the default policy for INPUT chain
        iptables -L INPUT | grep -E -q "Policy: (DROP|REJECT)"
        input_policy_status=$?

        # Check the default policy for OUTPUT chain
        iptables -L OUTPUT | grep -E -q "Policy: (DROP|REJECT)"
        output_policy_status=$?

        # Check the default policy for FORWARD chain
        iptables -L FORWARD | grep -E -q "Policy: (DROP|REJECT)"
        forward_policy_status=$?

        if [[ $input_policy_status -eq 0 && $output_policy_status -eq 0 && $forward_policy_status -eq 0 ]]; then
                echo -e "|3.5.3.2.1 | Ensure iptables default deny firewall policy (Automated)                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.2.1 | Ensure iptables default deny firewall policy (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.2.1 "
        fi
}
# Execute the check function
check_iptables_default_policy
}
((total++))

{
        #3.5.3.2.2
# Function to check iptables loopback traffic configuration
function check_iptables_loopback_traffic() {
        # Check if the loopback traffic is configured in INPUT chain
        iptables -L INPUT -v -n | grep -E -q "ACCEPT\s+all\s+--\s+lo\s+\*\s+0.0.0.0/0\s+0.0.0.0/0"

        # Check if the loopback traffic is configured in OUTPUT chain
        iptables -L OUTPUT -v -n | grep -E -q "ACCEPT\s+all\s+--\s+\*\s+lo\s+0.0.0.0/0\s+0.0.0.0/0"

        # Check if the rule to drop loopback traffic from other addresses is configured in INPUT chain
        iptables -L INPUT -v -n | grep -E -q "DROP\s+all\s+--\s+\*\s+\*\s+127.0.0.0/8\s+0.0.0.0/0"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.2.2 | Ensure iptables loopback traffic is configured (Automated)                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.2.2 | Ensure iptables loopback traffic is configured (Automated)                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.2.2 "
        fi
}
# Execute the check function
check_iptables_loopback_traffic
}
((total++))

{
        #3.5.3.2.3
# Function to check iptables outbound and established connections configuration
function check_iptables_outbound_connections() {
        # Check if outbound TCP, UDP, and ICMP connections are configured
        iptables -L -v -n | grep -E -q "(tcp|udp|icmp)\s+all\s+--\s+\*\s+\*\s+0.0.0.0/0\s+0.0.0.0/0\s+state\s+(NEW,ESTABLISHED|ESTABLISHED)"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.2.3 | Ensure iptables outbound and established connections are configured (Manual)                                  | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.2.3 | Ensure iptables outbound and established connections are configured (Manual)                                  | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.2.3 "
        fi
}
# Execute the check function
check_iptables_outbound_connections
}
((total++))

{
        #3.5.3.2.4
# Function to check iptables firewall rules for all open ports
function check_iptables_open_ports() {
        # Get a list of open ports using ss
        open_ports=$(ss -4tuln | awk 'NR>1 {print $5}' | awk -F':' '{print $NF}')

        # Check if iptables has rules for all open ports
        for port in $open_ports; do
                iptables -L INPUT -v -n | grep -q ":$port\s"
                if [[ $? -ne 0 ]]; then
                        echo -e "|${red}3.5.3.2.4 | Ensure iptables firewall rules exist for all open ports (Automated)                                           | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.3.2.4 "
                        return
                fi
        done

        echo -e "|3.5.3.2.4 | Ensure iptables firewall rules exist for all open ports (Automated)                                           | ${green}PASS${normal}       |"
        pass_count=$((pass_count + 1))
}
# Execute the check function
check_iptables_open_ports
}
((total++))


echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.3.3   | Configure IPv6 ip6tables                                                                                      |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"



{
        #3.5.3.3.1
# Function to check ip6tables default deny firewall policy
function check_ip6tables_default_policy() {
        # Check if ip6tables has default deny policy for INPUT, OUTPUT, and FORWARD chains
        ip6tables -L INPUT | grep -q "Chain INPUT (policy DROP)"
        ip6tables -L OUTPUT | grep -q "Chain OUTPUT (policy DROP)"
        ip6tables -L FORWARD | grep -q "Chain FORWARD (policy DROP)"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.3.1 | Ensure ip6tables default deny firewall policy (Automated)                                                     | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.3.1 | Ensure ip6tables default deny firewall policy (Automated)                                                     | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.3.1 "
        fi
}
# Execute the check function
check_ip6tables_default_policy
}
((total++))

{
        #3.5.3.3.2
# Function to check ip6tables loopback traffic configuration
function check_ip6tables_loopback() {
        # Check if ip6tables has rules for loopback traffic in INPUT and OUTPUT chains
        ip6tables -L INPUT -v -n | grep -q "ACCEPT.*lo"
        ip6tables -L OUTPUT -v -n | grep -q "ACCEPT.*lo"
        ip6tables -L INPUT -v -n | grep -q "DROP.*::1"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.3.2 | Ensure ip6tables loopback traffic is configured (Automated)                                                   | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.3.2 | Ensure ip6tables loopback traffic is configured (Automated)                                                   | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.3.2 "
        fi
}
# Execute the check function
check_ip6tables_loopback
}
((total++))

{
        #3.5.3.3.3
# Function to check ip6tables outbound and established connections configuration
function check_ip6tables_outbound() {
        # Check if ip6tables has rules for outbound and established connections
        ip6tables -L -v -n | grep -q "ACCEPT.*tcp.*state NEW,ESTABLISHED"
        ip6tables -L -v -n | grep -q "ACCEPT.*udp.*state NEW,ESTABLISHED"
        ip6tables -L -v -n | grep -q "ACCEPT.*icmp.*state NEW,ESTABLISHED"
        ip6tables -L -v -n | grep -q "ACCEPT.*tcp.*state ESTABLISHED"
          ip6tables -L -v -n | grep -q "ACCEPT.*udp.*state ESTABLISHED"
        ip6tables -L -v -n | grep -q "ACCEPT.*icmp.*state ESTABLISHED"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.3.3 | Ensure ip6tables outbound and established connections are configured (Manual)                                 | ${green}PASS${normal}              |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.3.3 | Ensure ip6tables outbound and established connections are configured (Manual)                                 | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.3.3 "
        fi
}
# Execute the check function
check_ip6tables_outbound
}
((total++))

{
        #3.5.3.3.4
# Function to check if ip6tables firewall rules exist for all open ports
function check_ip6tables_open_ports() {
        # Get open ports from ss command
        open_ports=$(ss -6tuln | awk 'NR>1 {print $5}' | cut -d':' -f2 | sort -u)

        # Check if ip6tables has rules for each open port
        for port in $open_ports; do
              ip6tables -L INPUT -v -n | grep -q -E "ACCEPT.*tcp.*dpt:$port.*state NEW"
                if [[ $? -ne 0 ]]; then
                        echo -e "|${red}3.5.3.3.4 | Ensure ip6tables firewall rules exist for all open ports (Automated)                                          | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.3.3.4 "
                        return
                fi
        done

        echo -e "|3.5.3.3.4 | Ensure ip6tables firewall rules exist for all open ports (Automated)                                          | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
}
# Execute the check function
check_ip6tables_open_ports
}
((total++))
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


path_to_fails="./S3_fails.sh"
display_failed_sections "$path_to_fails" > s3fails.txt
