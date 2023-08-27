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
    echo -e "\n${red}                                                                                          failed Sections:${NC}\n"
    for section in $failed_sections; do
        case $section in
                "5.1.1") $fails_script 5.1.1 ;;
                "5.1.2") $fails_script 5.1.2 ;;
                "5.1.3") $fails_script 5.1.3 ;;
                "5.1.4") $fails_script 5.1.4 ;;
                "5.1.5") $fails_script 5.1.5 ;;
                "5.1.6") $fails_script 5.1.6 ;;
                "5.1.7") $fails_script 5.1.7 ;;
                "5.1.8") $fails_script 5.1.8 ;;
                "5.1.9") $fails_script 5.1.9 ;;
                "5.2.1") $fails_script 5.2.1 ;;
                "5.2.2") $fails_script 5.2.2 ;;
                "5.2.3") $fails_script 5.2.3 ;;
                "5.2.4") $fails_script 5.2.4 ;;
                "5.2.5") $fails_script 5.2.5 ;;
                "5.2.6") $fails_script 5.2.6 ;;
                "5.2.7") $fails_script 5.2.7 ;;
                "5.2.8") $fails_script 5.2.8 ;;
                "5.2.9") $fails_script 5.2.9 ;;
                "5.2.10") $fails_script 5.2.10 ;;
                "5.2.11") $fails_script 5.2.11 ;;
                "5.2.12") $fails_script 5.2.12 ;;
                "5.2.13") $fails_script 5.2.13 ;;
                "5.2.14") $fails_script 5.2.14 ;;
                "5.2.15") $fails_script 5.2.15 ;;
                "5.2.16") $fails_script 5.2.16 ;;
                "5.2.17") $fails_script 5.2.17 ;;
                "5.2.18") $fails_script 5.2.18 ;;
                "5.2.19") $fails_script 5.2.19 ;;
                "5.2.20") $fails_script 5.2.20 ;;
                "5.2.21") $fails_script 5.2.21 ;;
                "5.2.22") $fails_script 5.2.22 ;;
                "5.3.1") $fails_script 5.3.1 ;;
                "5.3.2") $fails_script 5.3.2 ;;
                "5.3.3") $fails_script 5.3.3 ;;
                "5.3.4") $fails_script 5.3.4 ;;
                "5.3.5") $fails_script 5.3.5 ;;
                "5.3.6") $fails_script 5.3.6 ;;
                "5.3.7") $fails_script 5.3.7 ;;
                "5.4.1") $fails_script 5.4.1 ;;
                "5.4.2") $fails_script 5.4.2 ;;
                "5.4.3") $fails_script 5.4.3 ;;
                "5.4.4") $fails_script 5.4.4 ;;
                "5.4.5") $fails_script 5.4.5 ;;
                "5.5.1.1") $fails_script 5.5.1.1 ;;
                "5.5.1.2") $fails_script 5.5.1.2 ;;
                "5.5.1.3") $fails_script 5.5.1.3 ;;
                "5.5.1.4") $fails_script 5.5.1.4 ;;
                "5.5.1.5") $fails_script 5.5.1.5 ;;
                "5.5.2") $fails_script 5.5.2 ;;
                "5.5.3") $fails_script 5.5.3 ;;
                "5.5.4") $fails_script 5.5.4 ;;
                "5.5.5") $fails_script 5.5.5 ;;

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
# Section 5
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                           5 Access, Authentication and Authorization                                        |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
{
        #5.1.1
# Function to check if cron daemon is enabled and running
if systemctl is-enabled cron | grep -q "enabled"; then
                # Check if cron daemon is running
        if systemctl status cron | grep -q "Active: active (running)"; then
                echo -e "| 5.1.1   | Ensure cron daemon is enabled and running (Automated)                                                          | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.1     | Ensure cron daemon is enabled and running (Automated)                                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.1 "
        fi
else
        echo -e "|${red} 5.1.1     | Ensure cron daemon is enabled and running (Automated)                                                          | FAIL             ${normal}|"
        fail_count=$((fail_count + 1))
        failed_sections+="5.1.1 "
fi
}
((total++))

{
        #5.1.2
# Function to check permissions on /etc/crontab directory
function check_crontab_permissions() {
        local expected_permissions="600"
        local crontab_file="/etc/crontab"

    # Check permissions on /etc/crontab
        actual_permissions=$(stat -c "%a" "$crontab_file")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.2   | Ensure permissions on /etc/crontab are configured (Automated)                                                  | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.2   | Ensure permissions on /etc/crontab are configured (Automated)                                                  | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.2 "
        fi
}
# Execute the check function
check_crontab_permissions
}
((total++))


{
        #5.1.3
# Function to check permissions on /etc/cron.hourly directory
function check_cron_hourly_permissions() {
        local expected_permissions="700"
        local cron_hourly_dir="/etc/cron.hourly"

        # Check permissions on /etc/cron.hourly
        actual_permissions=$(stat -c "%a" "$cron_hourly_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.3   | Ensure permissions on /etc/cron.hourly are configured (Automated)                                              | ${green}PASS${normal}       |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.3   | Ensure permissions on /etc/cron.hourly are configured (Automated)                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.3 "
        fi
}
# Execute the check function
check_cron_hourly_permissions
}
((total++))

{
        #5.1.4
# Function to check permissions on /etc/cron.daily directory
function check_cron_daily_permissions() {
        local expected_permissions="700"
        local cron_daily_dir="/etc/cron.daily"

        # Check permissions on /etc/cron.daily directory
        actual_permissions=$(stat -c "%a" "$cron_daily_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.4   | Ensure permissions on /etc/cron.daily are configured (Automated)                                               | ${green}PASS${normal}                    |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.4   | Ensure permissions on /etc/cron.daily are configured (Automated)                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.4 "
        fi
}
# Execute the check function
check_cron_daily_permissions
}
((total++))

{
        #5.1.5
# Function to check permissions on /etc/cron.weekly directory
function check_cron_weekly_permissions() {
        local expected_permissions="700"
        local cron_weekly_dir="/etc/cron.weekly"

        # Check permissions on /etc/cron.weekly directory
        actual_permissions=$(stat -c "%a" "$cron_weekly_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.5     | Ensure permissions on /etc/cron.weekly are configured (Automated)                                              | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.5   | Ensure permissions on /etc/cron.weekly are configured (Automated)                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.5 "
        fi
}
# Execute the check function
check_cron_weekly_permissions
}
((total++))

{
        #5.1.6
# Function to check permissions on /etc/cron.monthly directory
function check_cron_monthly_permissions() {
        local expected_permissions="700"
        local cron_monthly_dir="/etc/cron.monthly"

        # Check permissions on /etc/cron.monthly directory
        actual_permissions=$(stat -c "%a" "$cron_monthly_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.6   | Ensure permissions on /etc/cron.monthly are configured (Automated)                                             | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.6   | Ensure permissions on /etc/cron.monthly are configured (Automated)                                             | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.6 "
        fi
}
# Execute the check function
check_cron_monthly_permissions
}
((total++))

{
        #5.1.7
# Function to check permissions on /etc/cron.d directory
function check_cron_d_permissions() {
        local expected_permissions="700"
        local cron_d_dir="/etc/cron.d"

        # Check permissions on /etc/cron.d directory
        actual_permissions=$(stat -c "%a" "$cron_d_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.7   | Ensure permissions on /etc/cron.d are configured (Automated)                                                   | ${GREEN}PASS${NC}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${RED} 5.1.7   | Ensure permissions on /etc/cron.d are configured (Automated)                                                   | FAIL             ${NC}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.7 "
        fi
}

# Execute the check function
check_cron_d_permissions
}
((total++))


{
        #5.1.8
# Function to check if cron is restricted to authorized users
function check_cron_access() {
        local cron_allow="/etc/cron.allow"
        local cron_deny="/etc/cron.deny"

        if [ -f "$cron_allow" ]; then
                echo -e "| 5.1.8   | Ensure cron is restricted to authorized users (Automated)                                                      | ${GREEN}PASS${NC}             |"
                pass_count=$((pass_count + 1))
        elif [ -f "$cron_deny" ]; then
                echo -e "|${RED} 5.1.8   | Ensure cron is restricted to authorized users (Automated)                                                      | FAIL             ${NC}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.8 "
        else
                echo -e "|${RED} 5.1.8   | Ensure cron is restricted to authorized users (Automated)                                                      | FAIL             ${NC}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.8 "
        fi
}

# Execute the check function
check_cron_access
}
((total++))

{
        #5.1.9
# Function to check if 'at' command is restricted to authorized users
function check_at_access() {
        local at_allow="/etc/at.allow"
        local at_deny="/etc/at.deny"

        if [ -f "$at_allow" ]; then
                echo -e "| 5.1.9   | Ensure 'at' is restricted to authorized users (Automated)                                                      | ${GREEN}PASS${NC}             |"
                pass_count=$((pass_count + 1))
        elif [ -f "$at_deny" ]; then
                echo -e "|${RED} 5.1.9   | Ensure 'at' is restricted to authorized users (Automated)                                                      | FAIL             ${NC}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.9 "
        else
                echo -e "|${RED} 5.1.9   | Ensure 'at' is restricted to authorized users (Automated)                                                      | FAIL             ${NC}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.9 "
        fi
}

# Execute the check function
check_at_access
}
((total++))


#section 5.2
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.2      | Configure SSH Server                                                                                           |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #5.2.1
# Function to check permissions on /etc/ssh/sshd_config
function check_sshd_config_permissions() {
        local expected_permissions="600"
        local sshd_config="/etc/ssh/sshd_config"

        # Check permissions on /etc/ssh/sshd_config
        actual_permissions=$(stat -c "%a" "$sshd_config")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.2.1   | Ensure permissions on /etc/ssh/sshd_config are configured (Automated)                                          | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.1   | Ensure permissions on /etc/ssh/sshd_config are configured (Automated)                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.1 "
        fi
}

# Execute the check function
check_sshd_config_permissions
}
((total++))

{
        #5.2.2
# Function to check permissions on SSH private host key files
function check_ssh_key_permissions() {
        local expected_permissions="600"
        local rsa_key_file="/etc/ssh/ssh_host_rsa_key"
        local ecdsa_key_file="/etc/ssh/ssh_host_ecdsa_key"

        # Check permissions on ssh_host_rsa_key file
        rsa_actual_permissions=$(stat -c "%a" "$rsa_key_file")

        # Check permissions on ssh_host_ecdsa_key file
        ecdsa_actual_permissions=$(stat -c "%a" "$ecdsa_key_file")

        if [ "$rsa_actual_permissions" == "$expected_permissions" ] && [ "$ecdsa_actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.2.2   | Ensure permissions on SSH private host key files are configured (Automated)                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.2   | Ensure permissions on SSH private host key files are configured (Automated)                                    | FAIL                ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.2 "
        fi
}
# Execute the check function
check_ssh_key_permissions
}
((total++))


{
        #5.2.3
# Function to check permissions on SSH public host key files
function check_ssh_public_key_permissions() {
        local expected_permissions="644"

        # Find SSH public key files in /etc/ssh
        public_key_files=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub')

        # Loop through the public key files and check their permissions
        for file in $public_key_files; do
                actual_permissions=$(stat -c "%a" "$file")

                if [ "$actual_permissions" != "$expected_permissions" ]; then
                        echo -e "|${red} 5.2.3     | Ensure permissions on SSH public host key files are configured (Automated)                                     | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.2.3 "
                return
                fi
        done

        echo -e "| 5.2.3   | Ensure permissions on SSH public host key files are configured (Automated)                                     | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
}

# Execute the check function
check_ssh_public_key_permissions
}
((total++))

{
        #5.2.4
# Function to check if SSH access is limited
function check_ssh_access_limit() {
        local sshd_config="/etc/ssh/sshd_config"
        local allow_users_configured=0
        local allow_groups_configured=0

        # Check if the SSHd configuration contains AllowUsers or AllowGroups directives
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -Pi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$'; then
                allow_users_configured=1
        fi

        if grep -rPi -q '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$' "$sshd_config"; then
                allow_groups_configured=1
        fi

        if [ "$allow_users_configured" -eq 1 ] || [ "$allow_groups_configured" -eq 1 ]; then
                echo -e "| 5.2.4   | Ensure SSH access is limited (Automated)                                                                       | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.4   | Ensure SSH access is limited (Automated)                                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.4 "
        fi
}
# Execute the check function
check_ssh_access_limit
}
((total++))

{
        #5.2.5
        output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep loglevel)

        if [[ "$output" == "loglevel INFO" ]]; then
                echo -e "| 5.2.5   | Ensure SSH LogLevel is appropriate (Automated)                                                                 | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        elif [[ "$output" == "loglevel VERBOSE" ]]; then
echo -e "| 5.2.5   | Ensure SSH LogLevel is appropriate (Automated)                                                                                 | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
echo -e "|${red} 5.2.5   | Ensure SSH LogLevel is appropriate (Automated)                                                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))\
                failed_sections+="5.2.5 "
        fi
}

((total++))

{
        #5.2.6
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "usepam\s*yes"; then
                echo -e "| 5.2.6   | Ensure SSH PAM is appropriate (Automated)                                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.6   | Ensure SSH PAM is appropriate (Automated)                                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.6 "
        fi
}
((total++))

{
        #5.2.7
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "permitrootlogin\s*no"; then
                echo -e "| 5.2.7     | Ensure SSH root login is disabled (Automated)                                                                  | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.7   | Ensure SSH root login is disabled (Automated)                                                                  | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.7 "
        fi
}
((total++))

{
        #5.2.8
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "hostbasedauthentication\s*no"; then
                echo -e "| 5.2.8   | Ensure SSH HostbasedAuthentication is disabled (Automated)                                                     | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.8   | Ensure SSH HostbasedAuthentication is disabled (Automated)                                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.8 "
        fi
}
((total++))

{
        #5.2.9
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "permitemptypasswords\s*no"; then
                echo -e "| 5.2.9   | Ensure SSH PermitEmptyPasswords is disabled (Automated)                                                        | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.9   | Ensure SSH PermitEmptyPasswords is disabled (Automated)                                                        | FAIL            ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.9 "

        fi
}
((total++))


{
        #5.2.10
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "permituserenvironment\s*no"; then
                echo -e "| 5.2.10  | Ensure SSH PermitUserEnvironment is disabled (Automated)                                                       | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.10  | Ensure SSH PermitUserEnvironment is disabled (Automated)                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.10 "
        fi
}
((total++))

{
        #5.2.11
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "ignorerhosts\s*no"; then
                echo -e "| 5.2.11  | Ensure SSH IgnoreRhosts is disabled (Automated)                                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.11  | Ensure SSH IgnoreRhosts is disabled (Automated)                                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.11 "
        fi
}
((total++))

{
        #5.2.12
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "x11forwarding\s*no"; then
                echo -e "| 5.2.12  | Ensure SSH X11 forwarding is disabled (Automated)                                                             | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.12  | Ensure SSH X11 forwarding is disabled (Automated)                                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.12 "
        fi
}
((total++))

{
        #5.2.13
function check_strong_ciphers() {
        local sshd_config="/etc/ssh/sshd_config"
        local benchmark_ciphers="chacha20-poly1305@openssh.com|aes256-gcm@openssh.com|aes128-gcm@openssh.com|aes256-ctr|aes192-ctr|aes128-ctr"

        # Check if the SSHd configuration uses only strong ciphers
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -E "ciphers\s+$benchmark_ciphers"; then
                echo -e "| 5.2.13  | Ensure only strong Ciphers are used (Automated)                                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.13  | Ensure only strong Ciphers are used (Automated)                                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.13 "
        fi
        }
check_strong_ciphers
}
((total++))


{
        #5.2.14
function check_macs_algo() {
        local sshd_config="/etc/ssh/sshd_config"
        local benchmark_macs="hmac-sha2-512-etm@openssh.com|hmac-sha2-256-etm@openssh.com|hmac-sha2-512|hmac-sha2-256"

        # Check if the SSHd configuration uses only strong MACs Algo
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -E "MACs\s+$benchmark_macs"; then
                echo -e "| 5.2.14  | Ensure only strong MAC algorithms are used (Automated)                                                         | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.14  | Ensure only strong MAC algorithms are used (Automated)                                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.14 "
        fi
        }
check_macs_algo
}
((total++))

{
        #5.2.15
function check_keyx_algo() {
        local sshd_config="/etc/ssh/sshd_config"
        local benchmark_keyx="curve25519-sha256|curve25519-sha256@libssh.org|diffie-hellman-group14-sha256|diffie-hellman-group16-sha512|diffie-hellman-group18-sha512|ecdh-sha2-nistp521|ecdh-sha2-nistp384|ecdh-sha2-nistp256|diffie-hellman-group-exchangg
e-sha256"

        # Check if the SSHd configuration uses only strong Key Exchange Algo
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -E "kexalgorithms\s+$benchmark_keyx"; then
                echo -e "| 5.2.15  | Ensure only strong Key Exchange are used (Automated)                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.15  | Ensure only strong Key Exchange are used (Automated)                                                           | FAIL       ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.15 "
        fi
        }
check_keyx_algo
}
((total++))


{
        #5.2.16
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "allowtcpforwarding\s*no"; then
                echo -e "| 5.2.16  | Ensure SSH AllowTcpForwarding is disabled (Automated)                                                          | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.16  | Ensure SSH AllowTcpForwarding is disabled (Automated)                                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.16 "
        fi
}
((total++))

{
        #5.2.17
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "banner\s*/etc/issue.net"; then
                echo -e "| 5.2.17  | Ensure SSH warning banner is configured (Automated)                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.17  | Ensure SSH warning banner is configured (Automated)                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.17 "
        fi
}
((total++))

{
        #5.2.18
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "maxauthtries\s*4"; then
                echo -e "| 5.2.18  | Ensure SSH MaxAuthTries is set to 4 or less (Automated)                                                         | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.18  | Ensure SSH MaxAuthTries is set to 4 or less (Automated)                                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.18 "
        fi
}
((total++))

{
        #5.2.19
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "maxstartups\s*10:30:60"; then
                echo -e "| 5.2.19  | Ensure SSH MaxStartups is configured (Automated)                                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.19  | Ensure SSH MaxStartups is configured (Automated)                                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.19 "
        fi
}
((total++))

{
        #5.2.20
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "maxsessions\s*10"; then
                echo -e "| 5.2.20  | Ensure SSH MaxSessions is set to 10 or less (Automated)                                                        | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.20  | Ensure SSH MaxSessions is set to 10 or less (Automated)                                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.20 "
        fi
}
((total++))


{
        #5.2.21
# Function to check SSH LoginGraceTime setting
function check_ssh_login_grace_time() {
        local expected_min_login_grace_time=1
        local expected_max_login_grace_time=60
        local sshd_config="/etc/ssh/sshd_config"

        # Get the current LoginGraceTime setting from sshd_config
        login_grace_time=$(sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -Ei "logingracetime\s*[0-9]+[m]?" | awk '{print $2}' | tr -d 'm')

        # Check if the LoginGraceTime is numeric and within the allowed range
        if [[ "$login_grace_time" =~ ^[0-9]+$ ]] && ((login_grace_time >= expected_min_login_grace_time)) && ((login_grace_time <= expected_max_login_grace_time)); then
                echo -e "| 5.2.21  | Ensure SSH LoginGraceTime is set to one minute or less (Automated)                                            | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.21  | Ensure SSH LoginGraceTime is set to one minute or less (Automated)                                             | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.21 "
        fi
}
# Execute the check function
check_ssh_login_grace_time
}
((total++))

{
        #5.2.22
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "clientaliveinterval\s*15" && sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{prinn
t $1}')" | grep -q "clientalivecountmax\s*3"; then
                echo -e "| 5.2.22  | Ensure SSH Idle Timeout Interval is configured (Automated)                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.22  | Ensure Idle Timeout Interval is configured (Automated)                                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.22 "
        fi
}
((total++))

#section 5.3
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.3      | Configure privilege escalation                                                                                 |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #5.3.1
# Function to check if sudo is installed
function check_sudo_installed() {
        # Check if sudo package is installed
        if dpkg-query -W sudo sudo-ldap > /dev/null 2>&1; then
                # Package is installed
                echo -e "| 5.3.1   | Ensure sudo is installed (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # Package is not installed
                echo -e "|${red} 5.3.1   | Ensure sudo is installed (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.1 "
        fi
}
# Execute the check function
check_sudo_installed
}
((total++))

{
        #5.3.2
# Function to check if sudo commands use pty
function check_sudo_use_pty() {
        # Check if use_pty option is set in the sudoers configuration
        if grep -rPi -q '^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*; then
                # use_pty option is set
                echo -e "| 5.3.2   | Ensure sudo commands use pty (Automated)                                                                       | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # use_pty option is not set
                echo -e "|${red} 5.3.2   | Ensure sudo commands use pty (Automated)                                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.2 "
        fi
}
# Execute the check function
check_sudo_use_pty
}
((total++))


{
        #5.3.3
# Function to check if sudo log file exists and is configured
function check_sudo_logfile() {
        # Check if sudo log file is configured in sudoers
        if grep -rPsi -q "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|')?\H+(\"|')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers*; then
                # sudo log file is configured
                echo -e "| 5.3.3   | Ensure sudo log file exists and is configured (Automated)                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # sudo log file is not configured
                echo -e "|${red} 5.3.3   | Ensure sudo log file exists and is configured (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.3 "
        fi
}

# Execute the check function
check_sudo_logfile
}
((total++))

{
        #5.3.4
# Function to check if users must provide password for privilege escalation
function check_users_password_required() {
        # Check if any users have been granted NOPASSWD privilege escalation
        if grep -r "^[^#].*NOPASSWD" /etc/sudoers*; then
                # Users have NOPASSWD privilege escalation
                echo -e "|${red} 5.3.4   | Ensure users must provide password for privilege escalation (Automated)                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.4 "
        else
                # Users must provide password for privilege escalation
                echo -e "| 5.3.4   | Ensure users must provide password for privilege escalation (Automated)                                        | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_users_password_required
}
((total++))

{
        #5.3.5
# Function to check if re-authentication for privilege escalation is not disabled globally
function check_reauth_enabled() {
        # Check if re-authentication is disabled globally in sudoers configuration
        if grep -r "^[^#].*\!authenticate" /etc/sudoers*; then
                # Re-authentication is disabled globally
                echo -e "|${red} 5.3.5   | Ensure re-authentication for privilege escalation is not disabled                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.5 "
        else
                # Re-authentication is not disabled globally
                echo -e "| 5.3.5   | Ensure re-authentication for privilege escalation is not disabled                                              | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_reauth_enabled
}
((total++))

{
        #5.3.6 (buggy)
function check_sudo_auth_timeout() {
        # Get the configured authentication timeout from sudoers file
        local sudo_timeout=$(grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers* | sort -n | head -1)

        # Check if sudo_timeout is empty (when timestamp_timeout is not found)
        if [[ -z "$sudo_timeout" ]]; then
                # Timeout is not found in sudoers
                echo -e "|${red} 5.3.6   | Ensure sudo authentication timeout is configured correctly (Automated)                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.6 "
        else
                # Check if the timeout is no more than 15 minutes (900 seconds)
                if [[ $sudo_timeout =~ ^[0-9]+$ && $sudo_timeout -le 900 ]]; then
                        # Timeout is configured correctly
                        echo -e "| 5.3.6    | Ensure sudo authentication timeout is configured correctly (Automated)                                         | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        # Timeout is not configured correctly
                        echo -e "|${red} 5.3.6   | Ensure sudo authentication timeout is configured correctly (Automated)                                         | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.3.6 "
                fi
        fi
}
# Execute the check function
check_sudo_auth_timeout
}
((total++))

{
        #5.3.7
# Function to check if access to su command is restricted
function check_su_restrictions() {
        # Check if the pam_wheel.so configuration restricts access to su
        if grep -Pi -q '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su; then
                # Access to su command is restricted
                echo -e "| 5.3.7   | Ensure access to the su command is restricted (Automated)                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # Access to su command is not restricted
                echo -e "|${red} 5.3.7   | Ensure access to the su command is restricted (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.7 "
        fi
}

# Execute the check function
check_su_restrictions
}
((total++))




#section 5.4
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.4      | Configure PAM                                                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"




    {
        #5.4.1
# Function to check if password creation requirements are configured
function check_password_requirements() {
        # Check minlen in pwquality.conf
        local minlen=$(grep '^\s*minlen\s*' /etc/security/pwquality.conf | awk '{print $3}')
        # Check minclass in pwquality.conf
        local minclass=$(grep '^\s*minclass\s*' /etc/security/pwquality.conf | awk '{print $3}')

        # Check if minlen is set to 14 and minclass is set to 4
        if [[ "$minlen" -eq 14 && "$minclass" -eq 4 ]]; then
                # Password creation requirements are configured correctly
                echo -e "| 5.4.1   | Ensure password creation requirements are configured (Automated)                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # Password creation requirements are not configured correctly
                echo -e "|${red} 5.4.1   | Ensure password creation requirements are configured (Automated)                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.1 "
        fi
}
# Execute the check function
check_password_requirements
}
((total++))

{
        #5.4.2
# Function to check if lockout for failed password attempts is configured
function check_password_lockout() {
        # Check if pam_faillock.so is configured in common-auth
        if grep -q "pam_faillock.so" /etc/pam.d/common-auth &&
                grep -q "pam_faillock.so" /etc/pam.d/common-account; then
                # Check faillock configuration in faillock.conf
                local deny=$(awk '/^ *deny *=/{print $3}' /etc/security/faillock.conf)
                local fail_interval=$(awk '/^ *fail_interval *=/{print $3}' /etc/security/faillock.conf)
                local unlock_time=$(awk '/^ *unlock_time *=/{print $3}' /etc/security/faillock.conf)

                # Check if settings follow local site policy
                if [[ "$deny" -le 4 && "$fail_interval" -le 900 && "$unlock_time" -eq 0 || "$unlock_time" -ge 600 ]]; then
                        # Lockout for failed password attempts is configured correctly
                        echo -e "| 5.4.2   | Ensure lockout for failed password attempts is configured (Automated)                                          | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        # Lockout for failed password attempts is not configured correctly
                        echo -e "|${red} 5.4.2   | Ensure lockout for failed password attempts is configured (Automated)                                          | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.4.2 "
                fi
        else
                # pam_faillock.so is not configured in common-auth or common-account
                echo -e "|${red} 5.4.2   | Ensure lockout for failed password attempts is configured (Automated)                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.2 "
        fi
}
# Execute the check function
check_password_lockout
}
((total++))


{
        #5.4.3
# Function to check if password reuse is limited
function check_password_reuse() {
        # Check if password reuse is limited in common-password
        if grep -Pq '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?remember=([5-9]|[1-9][0-9]+)\b' /etc/pam.d/common-password; then
                # Password reuse is limited, check the value of remember option
                local remember_value=$(grep -Po '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?remember=\K([5-9]|[1-9][0-9]+)' /etc/pam.d/common-password)

                # Check if the remember option is 5 or more
                if [[ "$remember_value" -ge 5 ]]; then
                        # Password reuse is limited correctly
                        echo -e "| 5.4.3   | Ensure password reuse is limited (Automated)                                                                   | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        # Password reuse is not limited correctly
                        echo -e "|${red} 5.4.3   | Ensure password reuse is limited (Automated)                                                                   | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.4.3 "
                fi
        else
                # Password reuse is not limited
                echo -e "|${red} 5.4.3   | Ensure password reuse is limited (Automated)                                                                   | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.3 "
        fi
}
# Execute the check function
check_password_reuse
}
((total++))


{
        #5.4.4
# Function to check if password hashing algorithm is up to date
function check_password_hashing_algorithm() {
        # Check if the password hashing algorithm is up to date in common-password
        local common_password_output=$(grep -v '^#' /etc/pam.d/common-password | grep -E "(yescrypt|md5|bigcrypt|sha256|sha512|blowfish)")

        # Check if there is no output for the first code
        if [[ -z "$common_password_output" ]]; then
                # Check if the ENCRYPT_METHOD is set to yescrypt in /etc/login.defs
                if grep -qi "^\s*ENCRYPT_METHOD\s*yescrypt\s*$" /etc/login.defs; then
                        # Password hashing algorithm is up to date
                        echo -e "| 5.4.4   | Ensure password hashing algorithm is up to date (Automated)                                                    | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        # ENCRYPT_METHOD is not set to yescrypt in /etc/login.defs
                        echo -e "|${red} 5.4.4   | Ensure password hashing algorithm is up to date (Automated)                                                    | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.4.4 "
                fi
        else
                # Output is present for the first code
                echo -e "|${red} 5.4.4   | Ensure password hashing algorithm is up to date (Automated)                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.4 "
        fi
}

# Execute the check function
check_password_hashing_algorithm
}
((total++))

{
        #5.4.5
declare -A HASH_MAP=(
        ["y"]="yescrypt"
        ["1"]="md5"
        ["2"]="blowfish"
        ["5"]="SHA256"
        ["6"]="SHA512"
        ["g"]="gost-yescrypt"
)

CONFIGURED_HASH=$(sed -n "s/^\s*ENCRYPT_METHOD\s*\(.*\)\s*$/\1/p" /etc/login.defs)

has_mismatch=false

for MY_USER in $(sed -n "s/^\(.*\):\\$.*/\1/p" /etc/shadow); do
        CURRENT_HASH=$(sed -n "s/${MY_USER}:\\$\(.\).*/\1/p" /etc/shadow)
        if [[ "${HASH_MAP["${CURRENT_HASH}"]^^}" != "${CONFIGURED_HASH^^}" ]]; then
                echo -e "|${red} 5.4.5   | Ensure all current passwords uses the configured hashing algorithm (Manual)                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.5 "
                has_mismatch=true
        fi
done

if ! $has_mismatch; then
        echo -e "| 5.4.5   | Ensure all current passwords uses the configured hashing algorithm (Manual)                                    | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
fi
}
((total++))





#section 5.5
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.5      | User Accounts and Environment                                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.5.1    | Set Shadow Password Suite Parameters                                                                           |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


{
        #5.5.1.1
# Function to check and remediate minimum days between password changes
function check_min_days_password_change() {
        # Check /etc/login.defs for PASS_MIN_DAYS
        local min_days=$(grep -Ei "^\s*PASS_MIN_DAYS\s+" /etc/login.defs | awk '{print $2}')

        if [[ -z "$min_days" ]]; then
                # PASS_MIN_DAYS is not found in /etc/login.defs
                echo -e "|${red} 5.5.1.1 | Ensure minimum days between password changes is configured (Automated)                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.1 "
        elif [[ "$min_days" -ge 1 ]]; then
                # PASS_MIN_DAYS is configured correctly
                echo -e "| 5.5.1.1 | Ensure minimum days between password changes is configured (Automated)                                         | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # PASS_MIN_DAYS is not configured correctly
                echo -e "|${red} 5.5.1.1 | Ensure minimum days between password changes is configured (Automated)                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.1 "
        fi
}
# Execute the check function
check_min_days_password_change
}
((total++))


{
        #5.5.1.2
# Function to check and remediate minimum days between password changes
function check_max_days_password_change() {
        # Check /etc/login.defs for PASS_MIN_DAYS
        local max_days=$(grep -Ei "^\s*PASS_MAX_DAYS\s+" /etc/login.defs | awk '{print $2}')

        if [[ -z "$max_days" ]]; then
                # PASS_MAX_DAYS is not found in /etc/login.defs
                echo -e "|${red} 5.5.1.2 | Ensure password expiration is 365 days or less (Automated)                                                     | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.2 "
        elif [[ "$max_days" -le 365 && "$max_days" -gt 0 ]]; then
                # PASS_MAX_DAYS is configured correctly
                echo -e "| 5.5.1.2 | Ensure password expiration is 365 days or less (Automated)                                                     | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # PASS_MAX_DAYS is not configured correctly
                echo -e "|${red} 5.5.1.2 | Ensure password expiration is 365 days or less (Automated)                                                     | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.2 "
        fi
}
# Execute the check function
check_max_days_password_change
}
((total++))

{
        #5.5.1.3
# Function to check and remediate password expiration warning days
function check_password_warn_age() {
        # Check /etc/login.defs for PASS_WARN_AGE
        local warn_age=$(grep -Ei "^\s*PASS_WARN_AGE\s+" /etc/login.defs | awk '{print $2}')

        if [[ -z "$warn_age" ]]; then
                # PASS_WARN_AGE is not found in /etc/login.defs
                echo -e "|${red} 5.5.1.3 | Ensure password expiration warning days is 7 or more (Automated)                                               | FAIL             |${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.3 "
        elif [[ "$warn_age" -ge 7 ]]; then
                # PASS_WARN_AGE is 7 or more
                echo -e "| 5.5.1.3 | Ensure password expiration warning days is 7 or more (Automated)                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # PASS_WARN_AGE is less than 7
                echo -e "|${red} 5.5.1.3 | Ensure password expiration warning days is 7 or more (Automated)                                               | FAIL             |${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.3 "
        fi
}
# Execute the check function
check_password_warn_age
}
((total++))

{
        #5.5.1.4
# Function to check and remediate inactive password lock
function check_inactive_password_lock() {
        # Check useradd default for INACTIVE
        local inactive_default=$(useradd -D | grep INACTIVE | awk -F'=' '{print $2}')

        # Check /etc/shadow for users with INACTIVE set
        local users_with_inactive=$(awk -F: '($7~/^\s*$|-1/ || $7>30) && /^[^:]+:[^!*]/ {print $1 " " $7}' /etc/shadow)

        if [[ -z "$inactive_default" ]]; then
                # INACTIVE not found in useradd defaults
                echo -e "|${red} 5.5.1.4 | Ensure inactive password lock is 30 days or less (Automated)                                                   | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.4 "
        elif [[ "$inactive_default" -le 30 && -z "$users_with_inactive" ]]; then
                # INACTIVE is 30 days or less, and no users have INACTIVE set
                echo -e "| 5.5.1.4 | Ensure inactive password lock is 30 days or less (Automated)                                                   | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # INACTIVE is more than 30 or users have INACTIVE set
                echo -e "|${red} 5.5.1.4 | Ensure inactive password lock is 30 days or less (Automated)                                                   | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.4 "
        fi
}
# Execute the check function
check_inactive_password_lock
}
((total++))


{
        #5.5.1.5
# Function to check if users' last password change date is in the past
function check_users_password_change_date() {
        # Get the current date in seconds since epoch
        local current_date=$(date +%s)

        # Get a list of all users
        local users_list=$(cut -d: -f1 /etc/passwd)

            # Loop through each user and check their password change date
        for user in $users_list; do
                # Get the password change date for the user in seconds since epoch
                local password_change_date=$(chage -l "$user" | grep "Last password change" | awk '{print $NF}')
                local password_change_date_in_seconds=$(date -d "$password_change_date" +%s)

                if [[ $password_change_date_in_seconds -ge $current_date ]]; then
                        # Password change date is in the future or today
                        echo -e "|${red} 5.5.1.5 | Ensure all users last password change date is in the past (Automated)                                          | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.5.1.5 "
                        return
                fi
        done

        # If we reach here, all users' password change dates are in the past
        echo -e "| 5.5.1.5 | Ensure all users last password change date is in the past (Automated)                                          | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
}
# Execute the check function
check_users_password_change_date
}
((total++))


{
        #5.5.2
# Function to check if system accounts are secured
function check_system_accounts_secured() {
        local uid_min=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

        # Check if system accounts have a valid shell and UID
        local invalid_accounts=$(awk -F: '$1!~/(root|sync|shutdown|halt|^\+)/ && $3<'"$uid_min"' && $7!~/((\/usr)?\/sbin\/nologin)/ && $7!~/(\/bin)?\/false/ {print}' /etc/passwd)

        if [[ -z "$invalid_accounts" ]]; then
                # Check if system accounts are not locked
                local locked_accounts=$(awk -F: '($1!~/(root|^\+)/ && $3<'"$uid_min"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!~/LK?/) {print $1}')

                if [[ -z "$locked_accounts" ]]; then
                        echo -e "| 5.5.2   | Ensure system accounts are secured (Automated)                                                                 | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red} 5.5.2   | Ensure system accounts are secured (Automated)                                                                 | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.5.2 "
                fi
        else
                echo -e "|${red} 5.5.2   | Ensure system accounts are secured (Automated)                                                                 | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.2 "
        fi
}
# Execute the check function
check_system_accounts_secured
}
((total++))


{
        #5.5.3
# Function to check if the default group for the root account is GID 0
function check_default_root_group() {
        local root_group=$(grep "^root:" /etc/passwd | cut -f4 -d:)

        if [[ "$root_group" -eq 0 ]]; then
                echo -e "| 5.5.3   | Ensure default group for the root account is GID 0 (Automated)                                                 | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.5.3   | Ensure default group for the root account is GID 0 (Automated)                                                 |  FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.3 "
        fi
}
# Execute the check function
check_default_root_group
}
((total++))

{
        #5.5.4
# Function to check default user umask and enforce directory and file permissions
function check_default_user_umask() {
        # Check if the default user umask is 027 or more restrictive
        if grep -Eiq '^\s*UMASK\s+(0[0-7][2-7]7|[0-7][2-7]7)\b' /etc/login.defs; then
                # Check if newly created directories have permissions 750
                if [ "$(umask)" == "0027" ]; then
                        mkdir -p /tmp/umask_test_dir
                        touch /tmp/umask_test_file
                        dir_perms="$(stat -c '%a' /tmp/umask_test_dir)"
                        file_perms="$(stat -c '%a' /tmp/umask_test_file)"

                        if [ "$dir_perms" == "750" ] && [ "$file_perms" == "640" ]; then
                                echo -e "| 5.5.4   | Ensure default user umask is 027 or more restrictive (Automated)                                               | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
                                echo -e "|${red} 5.5.4   | Ensure default user umask is 027 or more restrictive (Automated)                                               | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="5.5.4 "
                        fi

                        rm -rf /tmp/umask_test_dir /tmp/umask_test_file
                else
                        echo -e "|${red} 5.5.4   | Ensure default user umask is 027 or more restrictive (Automated)                path_to_fails="./fails.sh"
    echo
    display_failed_sections "$path_to_fails"  | FAIL       ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.5.4 "
                fi
        else
                echo -e "|${red} 5.5.4   | Ensure default user umask is 027 or more restrictive (Automated)                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.4 "
        fi
}
# Execute the check function
check_default_user_umask
}
((total++))


{
        #5.5.5
# Function to check default user shell timeout (TMOUT)
function check_default_shell_timeout() {
        # Check if TMOUT is configured in /etc/profile or /etc/bash.bashrc
        if grep -qE '^\s*export\s+TMOUT\s*=\s*[0-9]+\s*$' /etc/profile /etc/bash.bashrc; then
                # Get the value of TMOUT
                tmout_value=$(grep -E '^\s*export\s+TMOUT\s*=\s*[0-9]+\s*$' /etc/profile /etc/bash.bashrc | awk -F= '{print $2}')

                # Check if TMOUT is 900 seconds or less
                if [[ "$tmout_value" -le 900 ]]; then
                        echo -e "| 5.5.5   | Ensure default user shell timeout is 900 seconds or less (Automated)                                           | ${green}PASS${normal}            |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red} 5.5.5   | Ensure default user shell timeout is 900 seconds or less (Automated)                                           | FAIL            ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.5.5 "
                fi
        else
                echo -e "|${red} 5.5.5   | Ensure default user shell timeout is 900 seconds or less (Automated)                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.5 "
        fi
}
# Execute the check function
check_default_shell_timeout
}
((total++))

echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
} > aaa.txt

path_to_fails="./S5_fails.sh"
display_failed_sections "$path_to_fails" > s5fails.txt
