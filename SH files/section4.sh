#!/bin/bash
exec &> >(tee log.txt)
#Update Log:
#       2023-08-14: Fixed errors in section 4 and 1(error outputting, spacing for fail sections, renaming failsections to failed_sections 

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
                "4.1.1.1") $fails_script 4.1.1.1;;
                "4.1.1.2") $fails_script 4.1.1.2;;
                "4.1.1.3") $fails_script 4.1.1.3;;
                "4.1.1.4") $fails_script 4.1.1.4;;
                "4.1.2.1") $fails_script 4.1.2.1;;
                "4.1.2.3") $fails_script 4.1.2.3;;
                "4.1.3.1") $fails_script 4.1.3.1;;
                "4.1.3.2") $fails_script 4.1.3.2;;
                "4.1.3.3") $fails_script 4.1.3.3;;
                "4.1.3.4") $fails_script 4.1.3.4;;
                "4.1.3.5") $fails_script 4.1.3.5;;
                "4.1.3.6") $fails_script 4.1.3.6;;
                "4.1.3.7") $fails_script 4.1.3.7;;
                "4.1.3.8") $fails_script 4.1.3.8;;
                "4.1.3.9") $fails_script 4.1.3.9;;
                "4.1.3.10") $fails_script 4.1.3.10;;
                "4.1.3.11") $fails_script 4.1.3.11;;
                "4.1.3.12") $fails_script 4.1.3.12;;
                "4.1.3.13") $fails_script 4.1.3.13;;
                "4.1.3.14") $fails_script 4.1.3.14;;
                "4.1.3.15") $fails_script 4.1.3.15;;
                "4.1.3.16") $fails_script 4.1.3.16;;
                "4.1.3.17") $fails_script 4.1.3.17;;
                "4.1.3.18") $fails_script 4.1.3.18;;
                "4.1.3.19") $fails_script 4.1.3.19;;
                "4.1.3.20") $fails_script 4.1.3.20;;
                "4.1.3.21") $fails_script 4.1.3.21;;
                "4.1.4.1")  $fails_script 4.1.4.1;;
                "4.1.4.2") $fails_script 4.1.4.2;;
                "4.1.4.3") $fails_script 4.1.4.3;;
                "4.1.4.4") $fails_script 4.1.4.4;;
                "4.1.4.5") $fails_script 4.1.4.5;;
                "4.1.4.6") $fails_script 4.1.4.6;;
                "4.1.4.7") $fails_script 4.1.4.7;;
                "4.1.4.7") $fails_script 4.1.4.7;;
                "4.1.4.8") $fails_script 4.1.4.8;;
                "4.1.4.9") $fails_script 4.1.4.9;;
                "4.1.4.10") $fails_script 4.1.4.10;;
                "4.1.4.11") $fails_script 4.1.4.11;;
                "4.2.1.1.1") $fails_script 4.2.1.1.1;;
                "4.2.1.1.2") $fails_script 4.2.1.1.2;;
                "4.2.1.1.3") $fails_script 4.2.1.1.3;;
                "4.2.1.1.4") $fails_script 4.2.1.1.4;;
                "4.2.1.2") $fails_script 4.2.1.2;;
                "4.2.1.3") $fails_script 4.2.1.3;;
                "4.2.1.4") $fails_script 4.2.1.4;;
                "4.2.1.5") $fails_script 4.2.1.5;;
                "4.2.2.1") $fails_script 4.2.2.1;;
                "4.2.2.2") $fails_script 4.2.2.2;;
                "4.2.2.4") $fails_script 4.2.2.4;;
                "4.2.2.7") $fails_script 4.2.2.7;;
 # Add more cases for other sections if needed
        *) echo "Invalid section: $section" ;;
    esac
    echo
  done
}
	
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                       Automated Audit Tool for Linux(2)                                                     |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo -e "|${YELLOW}Section${NC}  | ${YELLOW}Title${NC}                                                                                                          | ${YELLOW}Compliance${NC}       |"

# Section 4
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                           4 Logging and Auditing                                                            |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Section 4.1
    echo "|4.1      | Configure System Accounting (auditd)                                                                           |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Section 4.1.1
    echo "|4.1.1    | Ensure auditing is enabled                                                                                     |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"



dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' auditd audispd-plugins &>> output.txt
if grep -q "installed" output.txt;
then
        echo -e "|4.1.1.1  |Ensure auditd is installed (Automated)                                                                          | ${green}PASS${NC}             |"
        
        ((pass_count++))
else
        echo -e "|${red}4.1.1.1  |Ensure auditd is installed (Automated)                                                                          | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.1.1 "
fi
sudo rm -f output.txt
((total++))



systemctl is-enabled auditd &>> output.txt
if grep -q "enabled" output.txt;
then
        systemctl is-active auditd &>> output.txt
        if grep -q -E "active" output.txt;
        then
                echo -e "|4.1.1.2  |Ensure auditd service is enabled and active (Automated)                                                         | ${green}PASS${NC}             |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.1.2  |Ensure auditd service is enabled and active (Automated)                                                         | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.1.2 "
        fi
else
        echo -e "|${red}4.1.1.2  |Ensure auditd service is enabled and active (Automated)                                                         | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.1.2 "
fi
sudo rm -f output.txt
((total++))

find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + | grep -v 'audit=1' &>> output.txt
outputprioraudit=output.txt
if [ $(wc -l < "${outputprioraudit}") -eq 0 ]; then

        echo -e "|4.1.1.3  |Ensure auditd service is enabled and active (Automated)                                                         | ${green}PASS${NC}             |"
        
        ((pass_count++))
else
        echo -e "|${red}4.1.1.3  |Ensure auditd service is enabled and active (Automated)                                                         | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.1.3 "
fi
sudo rm -f output.txt
((total++))

find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + | grep -Pv 'audit_backlog_limit=\d+\b' &>> output.txt
outputbacklog=output.txt
if [ $(wc -l < "${outputbacklog}") -eq 0 ]; then
        echo -e "|4.1.1.4  |Ensure audit_backlog_limit is sufficient (Automated)                                                            | ${green}PASS${NC}             |"
        
        ((pass_count++))
else
    echo -e "|${red}4.1.1.4  |Ensure audit_backlog_limit is sufficient (Automated)                                                            | FAIL             ${NC}|"
    
    ((fail_count++))
    failed_sections+="4.1.1.4 "
fi
sudo rm -f output.txt
((total++))



# Section 4.1.2
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|4.1.2    | Configure Data Retention                                                                                       |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


grep -Po -- '^\h*max_log_file\h*=\h*\d+\b' /etc/audit/auditd.conf &>> output.txt
if grep -x -q "max_log_file = 8" output.txt;
then
        echo -e "|4.1.2.1  |Ensure audit log storage size is configured (Automated)                                                         | ${green}PASS${NC}             |"
        
        ((pass_count++))
else
        echo -e "|${red}4.1.2.1  |Ensure audit log storage size is configured (Automated)                                                         | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.2.1 "
fi
sudo rm -f output.txt
((total++))



grep max_log_file_action /etc/audit/auditd.conf &>> output.txt
if grep -q "keep_logs" output.txt
then
        echo -e "|4.1.2.2  |Ensure audit log storage size is configured (Automated)                                                         | ${green}PASS${NC}             |"
        ((pass_count++))
        
else
        echo -e "|${red}4.1.2.2  |Ensure audit log storage size is configured (Automated)                                                         | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.2.2 "
fi
sudo rm -f output.txt
((total++))

grep space_left_action /etc/audit/auditd.conf &>> output.txt
if grep -x "space_left_action = email" output.txt;
then
        grep action_mail_acct /etc/audit/auditd.conf &>> output.txt
        if grep -q -E "action_mail_acct = root" output.txt
        then
                grep -E 'admin_space_left_action\s*=\s*(halt|single)' /etc/audit/auditd.conf &>> output.txt
                if grep -x "admin_space_left_action = halt \| admin_space_left_action = single" output.txt;
                then
                        echo -e "|4.1.2.3  |Ensure system is disabled when audit logs are full (Automated)                                                                |${green} PASS${NC}             |"
                        
                        ((passcount++))
                else
                        echo -e "|${red}4.1.2.3  |Ensure system is disabled when audit logs are full (Automated)                                                        | FAIL             |${NC}"
                        
                        ((failcount++))
                        failed_sections+="4.1.2.3 "
                        #Explanation: admin_space_left_action is not set to 'halt' or 'single'
                fi
        else
                echo -e "|${red}4.1.2.3  |Ensure system is disabled when audit logs are full (Automated)                                                         | FAIL             ${NC}|"
                
                ((failcount++))
                failed_sections+="4.1.2.3 "
                #Explanation: action_mail_acct is not set to 'root'
        fi
else
        echo -e "|${red}4.1.2.3  |Ensure system is disabled when audit logs are full (Automated)                                                  | FAIL             ${NC}|"
        
        ((failcount++))
        failed_sections+="4.1.2.3 "
        #Explanation: space_left_action is not set to 'email'
fi
sudo rm -f output.txt
((total++))
#Description: The max_log_file_action setting determines how to handle the audit log file reaching the max file size. A value of keep_logs will rotate the logs but never delete old logs. In high security contexts, the benefits of maintaining a long audit history exceed the cost of storing the audit history.



echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|4.1.3    | Configure auditd rules                                                                                         |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"



awk '/^ *-w/ &&/\/etc\/sudoers/&&/ +-p *wa/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules &>> output.txt
sed -i -e 's/^/ /' output.txt
if grep -x -q " -w /etc/sudoers -p wa -k scope.*-w /etc/sudoers.d -p wa -k scope" output.txt;
then
        auditctl -l | awk '/^ *-w/&&/\/etc\/sudoers/&&/ +-p *wa/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' &>> output.txt
        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -w /etc/sudoers.d -p wa -k scope.*-w /etc/sudoers.d -p wa -k scope" output.txt;
        then
                echo -e "|4.1.3.1  |Ensure changes to system administration scope (sudoers) is collected (Automated)                                | ${green}PASS${NC}             |"
                
                ((passcount++))
        else
                echo -e "|${red}4.1.3.1  |Ensure changes to system administration scope (sudoers) is collected (Automated)                                | FAIL            ${NC}|"
                
                ((failcount++))
                failed_sections+="4.1.3.1 "
                #Explanation: Loaded rules have not been set, or has been set incorrectly
        fi
else
        echo -e "|${red}4.1.3.1  |Ensure changes to system administration scope (sudoers) is collected (Automated)                                | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.1 "
        #Explanation: On-disk rules have not been set, or has been set incorrectly
fi
sudo rm -f output.txt
((total++))

awk '/^ *-a *always,exit/&&/ -F *arch=b[2346]{2}/&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/)&&(/ -C *euid!=uid/||/ -C *uid!=euid/)&&/ -S *execve/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules &>> output.txt
sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation" output.txt;
then
        echo "skn"
        auditctl -l | awk '/^ *-a *always,exit/&&/ -F *arch=b[2346]{2}/&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/)&&(/ -C *euid!=uid/||/ -C *uid!=euid/)&&/ -S *execve/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' &>> output.txt
        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -F arch=b64 -S execve -C uid!=euid -F auid!=-1 -F key=user_emulation" output.txt;
        then
                echo -e "|4.1.3.2     |Ensure actions as another user are always logged (Automated)                                                    | ${green}PASS${NC}             |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.2  |Ensure actions as another user are always logged (Automated)                                                    | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.2 "
                #Explanation: Loaded rules have not been set, or has been set incorrectly.
        fi
else
        echo -e "|${red}4.1.3.2  |Ensure actions as another user are always logged (Automated)                                                    | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.2 "
        #Explanation: On-Disk rules have not been set, or has been set incorrectly.
fi
sudo rm -f output.txt
#Description: sudo provides users with temporary elevated privileges to perform operations, either as the superuser or another user. Creating an audit log of users with temporary elevated privileges and the operations they performed is essential to reporting.
((total++))


{
SUDO_LOG_FILE_ESCAPED=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//' -e 's/"//g' -e 's|/|\\/|g') [ -n "${SUDO_LOG_FILE_ESCAPED}" ] && awk "/^ *-w/ \
&&/"${SUDO_LOG_FILE_ESCAPED}"/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'SUDO_LOG_FILE_ESCAPED' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -w /var/log/sudo.log -p wa -k sudo_log_file" output.txt;
then
        {
        SUDO_LOG_FILE_ESCAPED=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//' -e 's/"//g' -e 's|/|\\/|g') [ -n "${SUDO_LOG_FILE_ESCAPED}" ] && auditctl -l | awk "/^ *-w/ \
&&/"${SUDO_LOG_FILE_ESCAPED}"/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'SUDO_LOG_FILE_ESCAPED' is unset.\n"
} &>> output.txt
        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -w /var/log/sudo.log -p wa -k sudo_log_file" output.txt;
        then
                echo -e "|4.1.3.3     |Ensure events that modify the sudo log file are collected (Automated)                                           | ${green}PASS${NC}             |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.3      |Ensure events that modify the sudo log file are collected (Automated)                                           | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.3 "
                #Explanation: Loaded rules have not been set, or have been set incorrectly
        fi
else
        echo -e "|${red}4.1.3.3  |Ensure events that modify the sudo log file are collected (Automated)                                           | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.3 "
        #Explanation: On-Disk rules have not been set, or have been set incorrectly
fi
sudo rm -f output.txt
((total++))


{
awk '/^ *-a *always,exit/ \
&&/ -F *arch=b[2346]{2}/ \
&&/ -S/ \
&&(/adjtimex/ \
||/settimeofday/ \
||/clock_settime/ ) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
awk '/^ *-w/ \
&&/\/etc\/localtime/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -k time-
change
 -a always,exit -F arch=b32 -S adjtimex,settimeofday,clock_settime -k time-
change
 -w /etc/localtime -p wa -k time-change" output.txt;
then
        {
                auditctl -l | awk '/^ *-a *always,exit/ \
                        &&/ -F *arch=b[2346]{2}/ \
                        &&/ -S/ \
                        &&(/adjtimex/ \
                        ||/settimeofday/ \
                        ||/clock_settime/ ) \
                        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
                                        auditctl -l | awk '/^ *-w/ \
                                                &&/\/etc\/localtime/ \
                                                &&/ +-p *wa/ \
                                                &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
                                        } &>> output.txt
        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -F key=time-change
                 -a always,exit -F arch=b32 -S adjtimex,settimeofday,clock_settime -F key=time-change
                 -w /etc/localtime -p wa -k time-change" output.txt;
         then
                 echo -e "|4.1.3.4  |Ensure events that modify date and time information are collected (Automated)                                   | ${green}PASS${NC}             |"
                 
                 ((pass_count++))
         else
                 echo -e "|${red}4.1.3.4  |Ensure events that modify date and time information are collected (Automated)                                   | FAIL             ${NC}|"
                 
                 ((fail_count++))
                 failed_sections+="4.1.3.4 "
                 #Explanation: Loaded Rules have not been set, or have been set incorrectly
        fi
else
        echo -e "|${red}4.1.3.4  |Ensure events that modify date and time information are collected (Automated)                                   | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.4 "
        #Expanation: On-Disk rules have not been set, or have been set incorrectly
fi
sudo rm -f output.txt
#Description: Capture events where the system date and/or time has been modified. Unexpected changes in system date and/or time could be a sign of malicious activity on the system.
((total++))

wk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules &>> output.txt
awk '/^ *-w/ \
&&(/\/etc\/issue/ \
||/\/etc\/issue.net/ \
||/\/etc\/hosts/ \
||/\/etc\/network/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F arch=b64 -S sethostname,setdomainname -k system-locale
 -a always,exit -F arch=b32 -S sethostname,setdomainname -k system-locale
 -w /etc/issue -p wa -k system-locale
 -w /etc/issue.net -p wa -k system-locale
 -w /etc/hosts -p wa -k system-locale
 -w /etc/networks -p wa -k system-locale
 -w /etc/network/ -p wa -k system-locale" output.txt;
then
        auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' &>> output.txt
auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/issue/ \
||/\/etc\/issue.net/ \
||/\/etc\/hosts/ \
||/\/etc\/network/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' &>> output.txt

        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -F arch=b64 -S sethostname,setdomainname -F key=system-locale
                -a always,exit -F arch=b32 -S sethostname,setdomainname -F key=system-locale
                -w /etc/issue -p wa -k system-locale
                -w /etc/issue.net -p wa -k system-locale
                -w /etc/hosts -p wa -k system-locale
                -w /etc/networks -p wa -k system-locale
                -w /etc/network/ -p wa -k system-locale" output.txt;
        then
                echo -e "|4.1.3.5   |Ensure events that modify the system's network environment are collected (Automated)                           | ${green}PASS${NC}             |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.5  |Ensure events that modify the system's network environment are collected (Automated )                           | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.5 "
                #Explanation: Loaded rules have not been set, or has been incorrectly
        fi
else
        echo -e "|${red}4.1.3.5  |Ensure events that modify the system's network environment are collected (Automated)                            | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.5 "
        #Explanation: On-Disk configuration have not been set, or has been incorrectly
fi
sudo rm -f output.txt
#Description: Record changes to network environment files or system calls. The below parameters monitors the following system calls, and write an audit event on system call exit. Monitoring se hostname and setdomainname will identify potential unauthorized changes to host and domainname of a system
((total++))

for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do
 for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f); do
 grep -qr "${PRIVILEGED}" /etc/audit/rules.d && printf "OK: '${PRIVILEGED}' found in auditing rules.\n" || printf "Warning: '${PRIVILEGED}' not found in on disk configuration.\n"
 done
 done &>> output.txt
 if grep -q -E "OK" output.txt;
 then
         {
                 RUNNING=$(auditctl -l)
                 [ -n "${RUNNING}" ] && for PARTITION in $(findmnt -n -l -k -it $(awk
                 '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv
                 "noexec|nosuid" | awk '{print $1}'); do
                 for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f); do
                         printf -- "${RUNNING}" | grep -q "${PRIVILEGED}" && printf "OK:
                         '${PRIVILEGED}' found in auditing rules.\n" || printf "Warning:
                         '${PRIVILEGED}' not found in running configuration.\n"
                 done
         done \
                 || printf "ERROR: Variable 'RUNNING' is unset.\n"
         }
         if grep -q -E "OK" output.txt;
         then
                 echo -e "|4.1.3.6   |Ensure use of privileged commands are collected (Automated)                                                     |${green}PASS${NC}              |"
                 
                 ((pass_count++))
         else
                 echo -e "|${red}4.1.3.6   |Ensure use of privileged commands are collected (Automated)                                                     | FAIL             ${NC}|"
                 
                 ((fail_count++))
                 failed_sections+="4.1.3.6 "
                 #Explanation: Loaded rules have not been set, or has been set incorrectly
         fi
 else
         echo -e "|${red}4.1.3.6  |Ensure use of privileged commands are collected (Automated)                                                     | FAIL             ${NC}|"
         
         ((fail_count++))
         failed_sections+="4.1.3.6 "
         #Explanation: On-Disk Configuration have not been set, or has been set incorrectly
 fi
 sudo rm -f output.txt
 #Description: Monitor privileged programs, those that have the setuid and/or setgid bit set on execution, to determine if unprivileged users are running these commands. Execution of privileged commands by non-privileged users could be an indication of someone trying to gain unauthorized access to the system.
 ((total++))


 {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&/ -F *arch=b[2346]{2}/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) \
&&/ -S/ \
&&/creat/ \
&&/open/ \
&&/truncate/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=- EACCES -F auid>=1000 -F auid!=unset -k access
 -a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=- EPERM -F auid>=1000 -F auid!=unset -k access
 -a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=- EACCES -F auid>=1000 -F auid!=unset -k access
 -a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=- EPERM -F auid>=1000 -F auid!=unset -k access" output.txt;
then
        {
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&/ -F *arch=b[2346]{2}/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) \
        &&/ -S/ \
        &&/creat/ \
        &&/open/ \
        &&/truncate/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output.txt
        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=- EACCES -F auid>=1000 -F auid!=-1 -F key=access
         -a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=- EPERM -F auid>=1000 -F auid!=-1 -F key=access
         -a always,exit -F arch=b32 -S open,truncate,ftruncate,creat,openat -F exit=- EACCES -F auid>=1000 -F auid!=-1 -F key=access
         -a always,exit -F arch=b32 -S open,truncate,ftruncate,creat,openat -F exit=- EPERM -F auid>=1000 -F auid!=-1 -F key=access" output.txt;
        then
                echo -e "|4.1.3.7  |Ensure unsuccessful file access attempts are collected (Automated)                                              |${green} PASS            ${NC} |"
                
                ((pass_count++))

        else
                echo -e "|${red}4.1.3.7  |Ensure unsuccessful file access attempts are collected (Automated)                                              | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.7 "
        fi
        else
        echo -e "|${red}4.1.3.7  |Ensure unsuccessful file access attempts are collected (Automated)                                              | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.7 "
fi
sudo rm -f output.txt
((total++))


awk '/^ *-w/ \
&&(/\/etc\/group/ \
||/\/etc\/passwd/ \
||/\/etc\/gshadow/ \
||/\/etc\/shadow/ \
||/\/etc\/security\/opasswd/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -w /etc/group -p wa -k identity
 -w /etc/passwd -p wa -k identity
 -w /etc/gshadow -p wa -k identity
 -w /etc/shadow -p wa -k identity
 -w /etc/security/opasswd -p wa -k identity" output.txt;
then
        auditctl -l | awk '/^ *-w/ \
        &&(/\/etc\/group/ \
        ||/\/etc\/passwd/ \
        ||/\/etc\/gshadow/ \
        ||/\/etc\/shadow/ \
        ||/\/etc\/security\/opasswd/) \
        &&/ +-p *wa/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' &>> output.txt
                sed -i -e 's/^/ /' output.txt
                if grep -x -q " -w /etc/group -p wa -k identity
         -w /etc/passwd -p wa -k identity
         -w /etc/gshadow -p wa -k identity
         -w /etc/shadow -p wa -k identity
         -w /etc/security/opasswd -p wa -k identity" output.txt
        then
                echo -e "|4.1.3.8  |Ensure events that modify user/group information are collected (Automated)                                      |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.8  |Ensure events that modify user/group information are collected (Automated)                                      | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.8 "
                fi
        else
                echo -e "|${red}4.1.3.8  |Ensure events that modify user/group information are collected (Automated)                                      | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.8 "
fi
sudo rm -f output.txt
((total++))

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&/ -F *arch=b[2346]{2}/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -S/ \
&&/ -F *auid>=${UID_MIN}/ \
&&(/chmod/||/fchmod/||/fchmodat/ \
||/chown/||/fchown/||/fchownat/||/lchown/ \
||/setxattr/||/lsetxattr/||/fsetxattr/ \
||/removexattr/||/lremovexattr/||/fremovexattr/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod
 -a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod
 -a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod
 -a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod
 -a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod
 -a always,exit -F arch=b32 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=unset -F key=perm_mod" output.txt;
then
        {
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&/ -F *arch=b[2346]{2}/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -S/ \
        &&/ -F *auid>=${UID_MIN}/ \
        &&(/chmod/||/fchmod/||/fchmodat/ \
        ||/chown/||/fchown/||/fchownat/||/lchown/ \
        ||/setxattr/||/lsetxattr/||/fsetxattr/ \
        ||/removexattr/||/lremovexattr/||/fremovexattr/) \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output.txt

        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod
         -a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod
         -a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=-1 -F key=perm_mod
         -a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod
         -a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod
         -a always,exit -F arch=b32 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod" output.txt;
        then
                echo -e "|4.1.3.9  |Ensure discretionary access control permission modification events are collected (Automated)                    |${green} PASS             ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.9  |Ensure discretionary access control permission modification events are collected (Automated)                    | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.9 "
                fi
        else
                echo -e "|${red}4.1.3.9  |Ensure discretionary access control permission modification events are collected (Automated)                    | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.9 "
fi
sudo rm -f output.txt
((total++))

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&/ -F *arch=b[2346]{2}/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -S/ \
&&/mount/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=unset -k mounts
 -a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=unset -k mounts" output.txt;
then
        {
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&/ -F *arch=b[2346]{2}/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -S/ \
        &&/mount/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output.txt

        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=-1 -F key=mounts
 -a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=-1 -F key=mounts" output.txt;
then
        echo -e "|4.1.3.10 |Ensure successful file system mounts are collected (Automated)                                                  |${green} PASS             ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.10 |Ensure successful file system mounts are collected (Automated)                                                  | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.10 "
                fi
        else
                echo -e "|${red}4.1.3.10 |Ensure successful file system mounts are collected (Automated)                                                  | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.10 "
fi
sudo rm -f output.txt
((total++))


awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
||/\/var\/log\/wtmp/ \
||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules &>> output.txt
sed -i -e 's/^/ /' output.txt
if grep -x -q " -w /var/run/utmp -p wa -k session
 -w /var/log/wtmp -p wa -k session
 -w /var/log/btmp -p wa -k session" output.txt;
then
        auditctl -l | awk '/^ *-w/ \
        &&(/\/var\/run\/utmp/ \
        ||/\/var\/log\/wtmp/ \
        ||/\/var\/log\/btmp/) \
        &&/ +-p *wa/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' &>> output.txt
        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -w /var/run/utmp -p wa -k session
 -w /var/log/wtmp -p wa -k session
 -w /var/log/btmp -p wa -k session" output.txt;
        then
                echo -e "|4.1.3.11 |Ensure session initiation information is collected (Automated)                                                  |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.11 |Ensure session initiation information is collected (Automated)                                                  | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.11 "
                fi
        else
                echo -e "|${red}4.1.3.11 |Ensure session initiation information is collected (Automated)                                                  | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.11 "
fi
sudo rm -f output.txt
((total++))


awk '/^ *-w/ \
&&(/\/var\/log\/lastlog/ \
||/\/var\/run\/faillock/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -w /var/log/lastlog -p wa -k logins
 -w /var/run/faillock -p wa -k logins" output.txt;
then
        auditctl -l | awk '/^ *-w/ \
        &&(/\/var\/log\/lastlog/ \
        ||/\/var\/run\/faillock/) \
        &&/ +-p *wa/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' &>> output.txt
        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -w /var/log/lastlog -p wa -k logins
 -w /var/run/faillock -p wa -k logins" output.txt;
        then
                echo -e "|4.1.3.12 |Ensure login and logout events are collected (Automated)                                                        |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.12 |Ensure login and logout events are collected (Automated)                                                        | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.12 "
                fi
        else
                echo -e "|${red}4.1.3.12 |Ensure login and logout events are collected (Automated)                                                        | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.12 "
fi
sudo rm -f output.txt
((total++))


{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&/ -F *arch=b[2346]{2}/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -S/ \
&&(/unlink/||/rename/||/unlinkat/||/renameat/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F arch=b64 -S unlink,unlinkat,rename,renameat -F auid>=1000 -F auid!=unset -k delete
 -a always,exit -F arch=b32 -S unlink,unlinkat,rename,renameat -F auid>=1000 -F auid!=unset -k delete" output.txt;
then
        {
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&/ -F *arch=b[2346]{2}/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -S/ \
        &&(/unlink/||/rename/||/unlinkat/||/renameat/) \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } >> output.txt
        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete
 -a always,exit -F arch=b32 -S unlink,rename,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete" output.txt;
        then
                echo -e "|4.1.3.13 |Ensure file deletion events by users are collected (Automated)                                          |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.13 |Ensure file deletion events by users are collected (Automated)                                          | FAIL             ${NC}|"
                
                ((fail_count++))
                failsectioon+="4.1.3.13"
        fi
else
        echo -e "|${red}4.1.3.13 |Ensure file deletion events by users are collected (Automated)                                                  | FAIL             ${NC}|"
        
        ((fail_count++))
        failsectioon+="4.1.3.13"
fi
sudo rm -f output.txt
((total++))

awk '/^ *-w/ \
&&(/\/etc\/apparmor/ \
||/\/etc\/apparmor.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -w /etc/apparmor/ -p wa -k MAC-policy
 -w /etc/apparmor.d/ -p wa -k MAC-policy" output.txt;
then
        auditctl -l | awk '/^ *-w/ \
        &&(/\/etc\/apparmor/ \
        ||/\/etc\/apparmor.d/) \
        &&/ +-p *wa/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' &>> output.txt

        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -w /etc/apparmor/ -p wa -k MAC-policy
 -w /etc/apparmor.d/ -p wa -k MAC-policy" output.txt;
        then
                echo -e "|4.1.3.14 |Ensure events that modify the system's Mandatory Access Controls are collected (Automated)                      |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.14 |Ensure events that modify the system's Mandatory Access Controls are collected (Automated)                      | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.14 "
        fi
else
        echo -e "|${red}4.1.3.14 |Ensure events that modify the system's Mandatory Access Controls are collected (Automated)                      | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.14 "
fi
sudo rm -f output.txt
((total++))


{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/chcon/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=unset
 -k perm_chng" output.txt
then
        {
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -F *perm=x/ \
        &&/ -F *path=\/usr\/bin\/chcon/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output.txt

        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -S all -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F
 auid!=-1 -F key=perm_chng" output.txt
        then
                echo -e "|4.1.3.15 |Ensure successful and unsuccessful attempts to use the chcon command are recorded (Automated)                   |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.15 |Ensure successful and unsuccessful attempts to use the chcon command are recorded (Automated)                   | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.15 "
        fi
else
        echo -e "|${red}4.1.3.15 |Ensure successful and unsuccessful attempts to use the chcon command are recorded (Automated)                   | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.15 "
fi
sudo rm -f output.txt
((total++))

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/setfacl/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=unset -k perm_chng" output.txt;
then
        {
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -F *perm=x/ \
        &&/ -F *path=\/usr\/bin\/setfacl/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output.txt
        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -S all -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=-1 -F key=perm_chng" output.txt;
        then
                echo -e "|4.1.3.16 |Ensure successful and unsuccessful attempts to use the setfacl command are recorded (Automated)                 |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.16 |Ensure successful and unsuccessful attempts to use the setfacl command are recorded (Automated)                 | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.16 "
        fi
else
        echo -e "|${red}4.1.3.16 |Ensure successful and unsuccessful attempts to use the setfacl command are recorded (Automated)                 | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.16 "
fi
sudo rm -f output.txt
((total++))


{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/chacl/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=unset
 -k priv_cmd" output.txt;
then
        {
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -F *perm=x/ \
        &&/ -F *path=\/usr\/bin\/chacl/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output.txt

        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -S all -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=-1 -F key=priv_cmd" output.txt;
        then
                echo -e "|4.1.3.17 |Ensure successful and unsuccessful attempts to use the chacl command are recorded (Automated)                   |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.17 |Ensure successful and unsuccessful attempts to use the chacl command are recorded (Automated)                   | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.17 "
        fi
else
        echo -e "|${red}4.1.3.17 |Ensure successful and unsuccessful attempts to use the chacl command are recorded (Automated)                   | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.17 "
fi
sudo rm -f output.txt
((total++))

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/sbin\/usermod/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=unset -k usermod" output.txt;
then
        {
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -F *perm=x/ \
        &&/ -F *path=\/usr\/sbin\/usermod/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output.txt

        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -S all -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=-1 -F key=usermod" output.txt;
        then
                echo -e "|4.1.3.18 |Ensure successful and unsuccessful attempts to use the usermod command are recorded (Automated)                 |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.18 |Ensure successful and unsuccessful attempts to use the usermod command are recorded (Automated)                 | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.18 "
        fi
else
        echo -e "|${red}4.1.3.18 |Ensure successful and unsuccessful attempts to use the usermod command are recorded (Automated)                 | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.18 "
fi
sudo rm -f output.txt
((total++))

{
awk '/^ *-a *always,exit/ \
&&/ -F *arch=b[2346]{2}/ \
&&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) \
&&/ -S/ \
&&(/init_module/ \
||/finit_module/ \
||/delete_module/ \
||/create_module/ \
||/query_module/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/kmod/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt

sed -i -e 's/^/ /' output.txt
if grep -x -q " -a always,exit -F arch=b64 -S init_module,finit_module,delete_module,create_module,query_module -F auid>=1000 -F auid!=unset -k kernel_modules
 -a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=unset -k kernel_modules" output.txt;
then
        {
        auditctl -l | awk '/^ *-a *always,exit/ \
        &&/ -F *arch=b[2346]{2}/ \
        &&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) \
        &&/ -S/ \
        &&(/init_module/ \
        ||/finit_module/ \
        ||/delete_module/ \
        ||/create_module/ \
        ||/query_module/) \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -F *perm=x/ \
        &&/ -F *path=\/usr\/bin\/kmod/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output.txt

        sed -i -e 's/^/ /' output.txt
        if grep -x -q " -a always,exit -F arch=b64 -S create_module,init_module,delete_module,query_module,finit_module -F auid>=1000 -F auid!=-1 -F key=kernel_modules
 -a always,exit -S all -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=-1 -F key=kernel_modules" output.txt;
        then
                echo -e "|4.1.3.19 |Ensure kernel module loading unloading and modification is collected (Automated)                                |${green} PASS         ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.19 |Ensure kernel module loading unloading and modification is collected (Automated)                                | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.19 "
        fi
else
        echo -e "|${red}4.1.3.19 |Ensure kernel module loading unloading and modification is collected (Automated)                                | FAIL             ${NC}|"
        
        ((fail_count++))
        failed_sections+="4.1.3.19 "
fi
sudo rm -f output.txt
((total++))


grep -Ph -- '^\h*-e\h+2\b' /etc/audit/rules.d/*.rules &>> output.txt
tail -1 output.txt &>> output.txt
sed -i -e 's/^/ /' output.txt
if grep -q " -e 2" output.txt;
then
        echo -e "|4.1.3.20 |Ensure the audit configuration is immutable (Automated)                                                         |${green} PASS         ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.20 |Ensure the audit configuration is immutable (Automated)                                                         | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.20 "
fi
sudo rm -f output.txt
((total++))

augenrules --check &>> output.txt
if grep -q "/usr/sbin/augenrules: No change" output.txt
then
        echo -e "|4.1.3.21 |Ensure the running and on disk configuration is the same (Manual)                                               |${green} PASS            ${NC} |"
                
                ((pass_count++))
        else
                echo -e "|${red}4.1.3.21 |Ensure the running and on disk configuration is the same (Manual)                                               | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.3.21 "
fi
sudo rm -f output.txt
((total++))


#section 4.1.4
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|4.1.4    | Configure auditd file access                                                                                   |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"




    file=/etc/audit/auditd.conf
    if test -f "$file"; then
            grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*// output.txt|xargs stat -c %a:%n output.txt &>> output.txt
            if awk -F\, '$1 < 640 && $1 > 1' output.txt
            then
                echo -e "|4.1.4.1  |Ensure audit log files are mode 0640 or less permissive (Automated)                                             |${green} PASS            ${NC} |"
                ((pass_count++))
                
        else
                echo -e "|${red}4.1.4.1  |Ensure audit log files are mode 0640 or less permissive (Automated)                                             | FAIL             ${NC}|"
                
                        ((fail_count++))
                        failed_sections+="4.1.4.1 "
        fi
else
        echo -e "|${red}4.1.4.1  |Ensure audit log files are mode 0640 or less permissive (Automated)                                             | FAIL             ${NC}|"
                
                        ((fail_count++))
                        failed_sections+="4.1.4.1 "
    fi
sudo rm -f output.txt
((total++))


file=/etc/audit/auditd.conf
if test -f "$file"; then
        stat -Lc "%n %U" "$(dirname $(awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf | xargs))"/* | grep -Pv -- '^\H+\h+root\b' &>> output.txt
        output=output.txt
        if [ $(wc -l < "${output}") -eq 0 ]; then
        echo -e "|4.1.4.2  |Ensure only authorized users own audit log files (Automated)                                                    |${green} PASS            ${NC} |"
        ((pass_count++))
        
        else
        echo -e "|${red}4.1.4.2  |Ensure only authorized users own audit log files (Automated)                                                    | FAIL             ${NC}|"
                        
                        ((fail_count++))
                        failed_sections+="4.1.4.2 "
        fi
else
        echo -e "|${red}4.1.4.2  |Ensure only authorized users own audit log files (Automated)                                                    | FAIL             ${NC}|"
                        
                        ((fail_count++))
                        failed_sections+="4.1.4.2 "
fi
sudo rm -f output.txt
((total++))

file=/etc/audit/auditd.conf
if test -f "$file"; then
        grep -Piw -- '^\h*log_group\h*=\h*(adm|root)\b' /etc/audit/auditd.conf >> output.txt
        if grep -q "log_group = adm" output.txt
        then
                echo -e "|4.1.4.3  |Ensure only authorized groups are assigned ownership of audit log files (Automated)                             |${green} PASS            ${NC} |"
                ((pass_count++))
                
        else
                if grep -q "log_group = root" output.txt
                then
                        echo -e "|4.1.4.3  |Ensure only authorized groups are assigned ownership of audit log files (Automated)                             |${green} PASS            ${NC} |"
                        ((pass_count++))
                        
                else
                        echo -e "|${red}4.1.4.3  |Ensure only authorized groups are assigned ownership of audit log files (Automated)                             | FAIL          ${NC}|"
                        
                        ((fail_count++))
                        failed_sections+="4.1.4.3 "
                fi
        fi
else
        echo -e "|${red}4.1.4.3  |Ensure only authorized groups are assigned ownership of audit log files (Automated)                             | FAIL             ${NC}|"
                        
                        ((fail_count++))
                        failed_sections+="4.1.4.3 "
fi
sudo rm -f output.txt
((total++))

file=/etc/audit/auditd.conf
if test -f "$file"; then
        stat -Lc "%n %a" "$(dirname $( awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf))" | grep -Pv -- '^\h*\H+\h+([0,5,7][0,5]0)' >> output.txt
        output=output.txt
        if [ $(wc -l < "${output}") -eq 0 ]; then
                echo -e "|4.1.4.4  |Ensure the audit log directory is 0750 or more restrictive (Automated)                                          |${green} PASS            ${NC} |"
                ((pass_count++))
                
        else
                echo -e "|${red}4.1.4.4  |Ensure the audit log directory is 0750 or more restrictive (Automated)                                          | FAIL             ${NC}|"
                        
                        ((fail_count++))
                        failed_sections+="4.1.4.4 "
        fi
else
        echo -e "|${red}4.1.4.4  |Ensure the audit log directory is 0750 or more restrictive (Automated)                                          | FAIL             ${NC}|"
                        
                        ((fail_count++))
                        failed_sections+="4.1.4.4 "
fi

sudo rm -f output.txt
((total++))



file=/etc/audit/audit
if test -f "$file"; then
        find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec stat -Lc "%n %a" {} + | grep -Pv -- '^\h*\H+\h*([0,2,4,6][0,4]0)\h*$' >> output.txt
        output=output.txt
        if [ $(wc -l < "${output}") -eq 0 ]; then
                echo -e "|4.1.4.5  |Ensure audit configuration files are 640 or more restrictive (Automated)                                        |${green} PASS         ${NC} |"
                ((pass_count++))
                
        else
                echo -e "|${red}4.1.4.5  |Ensure audit configuration files are 640 or more restrictive (Automated)                                        | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.4.5 "
        fi
else
        echo -e "|${red}4.1.4.5  |Ensure audit configuration files are 640 or more restrictive (Automated)                                        | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.4.5 "
fi

sudo rm -f output.txt
((total++))


file=/etc/audit/audit/
if test -f "$file"; then
        find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root >> output.txt
        output=output.txt
        if [ $(wc -l < "${output}") -eq 0 ]; then
                echo -e "|4.1.4.6  |Ensure audit configuration files are owned by root (Automated)                                                  |${green} PASS            ${NC} |"
                ((pass_count++))
                
        else
                echo -e "|${red}4.1.4.6  |Ensure audit configuration files are owned by root (Automated)                                                  | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.4.6 "
        fi
else
        echo -e "|${red}4.1.4.6  |Ensure audit configuration files are owned by root (Automated)                                                  | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.4.6 "
fi
sudo rm -f output.txt
((total++))


file=/etc/audit/audit/
if test -f "$file"; then
find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root >> output.txt
output=output.txt
if [ $(wc -l < "${output}") -eq 0 ]; then
    echo -e "|4.1.4.7  |Ensure audit configuration files belong to group root (Automated)                                               |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.1.4.7  |Ensure audit configuration files belong to group root (Automated)                                               | FAIL          ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.4.7 "
fi
else
        echo -e "|${red}4.1.4.7  |Ensure audit configuration files belong to group root (Automated)                                               | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.4.7 "
fi
sudo rm -f output.txt
((total++))

file=/sbin/auditctl
if test -f "$file"; then
        file=/sbin/aureport
        if test -f "$file"; then
                file=/sbin/ausearch
                if test -f "$file"; then
                        file=/sbin/autrace
                        if test -f "$file"; then
                                file=/sbin/auditd
                                if test -f "$file"; then
                                        file=/sbin/augenrules
                                        if test -f "$file"; then
                                                stat -c "%n %a" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+([0-7][0,1,4,5][0,1,4,5])\h*$' >> output.txt
                                                output=output.txt
                                                if [ $(wc -l < "${output}") -eq 0 ]; then
                                                        echo -e "|4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      |${green} PASS            ${NC} |"
                                                        ((pass_count++))
                                                        
                                                else
                                                echo -e "|${red}4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      | FAIL             ${NC}|"
                                                
                                                ((fail_count++))
                                                failed_sections+="4.1.4.8 "
                                                fi
                                        else
                                                echo -e "|${red}4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      | FAIL             ${NC}|"
                                                
                                                ((fail_count++))
                                                failed_sections+="4.1.4.8 "
                                        fi
                                else
                                        echo -e "|${red}4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      | FAIL             ${NC}|"
                                                
                                                ((fail_count++))
                                                failed_sections+="4.1.4.8 "
                                fi
                        else
                                echo -e "|${red}4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      | FAIL             ${NC}|"
                                                
                                                ((fail_count++))
                                                failed_sections+="4.1.4.8 "
                        fi
                else
                        echo -e "|${red}4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      | FAIL             ${NC}|"
                                                
                                                ((fail_count++))
                                                failed_sections+="4.1.4.8 "
                fi
        else
                echo -e "|${red}4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      | FAIL             ${NC}|"
                                                
                                                ((fail_count++))
                                                failed_sections+="4.1.4.8 "
        fi
else
        echo -e "|${red}4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      | FAIL             ${NC}|"
                                                
                                                ((fail_count++))
                                                failed_sections+="4.1.4.8 "
fi
sudo rm -f output.txt
((total++))


file=/sbin/auditctl
if test -f "$file"; then
        file=/sbin/aureport
        if test -f "$file"; then
                file=/sbin/ausearch
                if test -f "$file"; then
                        file=/sbin/autrace
                        if test -f "$file"; then
                                file=/sbin/auditd
                                if test -f "$file"; then
                                        file=/sbin/augenrules
                                        if test -f "$file"; then
                                                stat -c "%n %U" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+root\h*$' >> output.txt
                                                output=output.txt
                                                if [ $(wc -l < "${output}") -eq 0 ]; then
                                                        echo -e "|4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                |${green} PASS            ${NC} |"
                                                        ((pass_count++))
                                                        
                                                else
                                                        echo -e "|${red}4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                | FAIL            ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.9 "
                                                fi
                                        else
                                                echo -e "|${red}4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                | FAIL            ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.9 "
                                        fi
                                else
                                        echo -e "|${red}4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                | FAIL            ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.9 "
                                fi
                        else
                                echo -e "|${red}4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                | FAIL            ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.9 "
                        fi
                else
                        echo -e "|${red}4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                | FAIL            ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.9 "
                fi
        else
                echo -e "|${red}4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                | FAIL            ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.9 "
        fi
else
        echo -e "|${red}4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                | FAIL             ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.9 "
fi

sudo rm -f output.txt
((total++))


file=/sbin/auditctl
if test -f "$file"; then
        file=/sbin/aureport
        if test -f "$file"; then
                file=/sbin/ausearch
                if test -f "$file"; then
                        file=/sbin/autrace
                        if test -f "$file"; then
                                file=/sbin/auditd
                                if test -f "$file"; then
                                        file=/sbin/augenrules
                                        if test -f "$file"; then
                                                stat -c "%n %a %U %G" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+([0-7][0,1,4,5][0,1,4,5])\h+root\h+root\h*$' >> output.txt
                                                output=output.txt
                                                if [ $(wc -l < "${output}") -eq 0 ]; then
                                                        echo -e "|4.1.4.10 |Ensure audit tools belong to group root (Automated)                                                             |${green} PASS            ${NC} |"
                                                        ((pass_count++))
                                                        
                                                else
                                                        echo -e "|${red}4.1.4.10 |Ensure audit tools belong to group root (Automated)                                                             | FAIL             ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.10 "
                                                fi
                                        else
                                                echo -e "|${red}4.1.4.10 |Ensure audit tools belong to group root (Automated)                                                             | FAIL             ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.10 "
                                        fi
                                else
                                        echo -e "|${red}4.1.4.10 |Ensure audit tools belong to group root (Automated)                                                             | FAIL             ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.10 "
                                fi
                        else
                                echo -e "|${red}4.1.4.10 |Ensure audit tools belong to group root (Automated)                                                             | FAIL             ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.10 "
                        fi
                else
                        echo -e "|${red}4.1.4.10 |Ensure audit tools belong to group root (Automated)                                                             | FAIL             ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.10 "
                fi
        else
                echo -e "|${red}4.1.4.10 |Ensure audit tools belong to group root (Automated)                                                             | FAIL             ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.10 "
        fi
else
        echo -e "|${red}4.1.4.10 |Ensure audit tools belong to group root (Automated)                                                             | FAIL             ${NC}|"
                                                        
                                                        ((fail_count++))
                                                        failed_sections+="4.1.4.10 "
fi
sudo rm -f output.txt
((total++))

file=/etc/aide/aide.conf
if test -f "$file"; then
        grep -P -- '(\/sbin\/(audit|au)\H*\b)' /etc/aide/aide.conf >> output.txt
        if grep -q "/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512
                /sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512
                /sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512
                /sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512
                /sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512
                /sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512" output.txt;
        then
                echo -e "|4.1.4.11 |Ensure cryptographic mechanisms are used to protect the integrity of audit tools (Automated)                    |${green} PASS            ${NC} |"
                ((pass_count++))
                
        else
                echo -e "|${red}4.1.4.11 |Ensure cryptographic mechanisms are used to protect the integrity of audit tools (Automated)                    | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.4.11 "
        fi
else
        echo -e "|${red}4.1.4.11 |Ensure cryptographic mechanisms are used to protect the integrity of audit tools (Automated)                    | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.1.4.11 "
fi
sudo rm -f output.txt
((total++))




#section 4.2
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|4.2      | Configure Logging                                                                                              |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    #section 4.2.1
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|4.2.1    | Configure journald                                                                                             |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    #section 4.2.1.1
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|4.2.1.1  | Ensure journald is configured to send logs to a remote log host                                                |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n'systemd-journal-remote >> output.txt
if grep -q "systemd-journal-remote
install ok installed
installed" output.txt;
then
        echo -e "|4.2.1.1.1|Ensure systemd-journal-remote is installed (Automated)                                                          |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.1.1.1|Ensure systemd-journal-remote is installed (Automated)                                                          | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.1.1.1 "
fi
sudo rm -f output.txt
((total++))


echo -e "|4.2.1.1.2| Ensure systemd-journal-remote is configured (Manual)                                                           |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
    ((total++))



systemctl is-enabled systemd-journal-upload.service &> output.txt
if grep -q "enabled" output.txt;
then
        echo -e "|4.2.1.1.3|Ensure systemd-journal-remote is enabled (Manual)                                                               |${green} PASS               ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.1.1.3|Ensure systemd-journal-remote is enabled (Manual)                                                               | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.1.1.3 "
fi
sudo rm -f output.txt
((total++))

systemctl is-enabled systemd-journal-remote.socket &>> output.txt
if grep -q "disabled" output.txt;
then
        echo -e "|4.2.1.1.4|Ensure journald is not configured to recieve logs from a remote client (Automated)                              |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.1.1.4|Ensure journald is not configured to recieve logs from a remote client (Automated)                              | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.1.1.4 "
fi
sudo rm -f output.txt
((total++))


systemctl is-enabled systemd-journald.service >> output.txt
if grep -q "static" output.txt;
then
        echo -e "|4.2.1.2  |Ensure journald service is enabled (Automated)                                                                  |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.1.2  |Ensure journald service is enabled (Automated)                                                                  | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.1.2 "
fi
sudo rm -f output.txt
((total++))



grep ^\s*Compress /etc/systemd/journald.conf >> output.txt
if grep -q "Compress=yes" output.txt;
then
        echo -e "|4.2.1.3 |Ensure journald is configured to compress large log files (Automated)                                            |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.1.3  |Ensure journald is configured to compress large log files (Automated)                                           | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.1.3 "
fi
sudo rm -f output.txt
((total++))



grep ^\s*Storage /etc/systemd/journald.conf >> output.txt
if grep -q "Storage=persistent" output.txt;
then
        echo -e "|4.2.1.4  |Ensure journald is configured to write logfiles to persistent disk (Automated)                                 |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.1.4  |Ensure journald is configured to write logfiles to persistent disk (Automated)                                  | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.1.4 "
fi
sudo rm -f output.txt
((total++))


grep ^\s*ForwardToSyslog /etc/systemd/journald.conf >> output.txt
output=output.txt
if [ $(wc -l < "${output}") -eq 0 ]; then
    echo -e "|4.2.1.5  |Ensure journald is not configured to send logs to rsyslog (Manual)                                              |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.1.5  |Ensure journald is not configured to send logs to rsyslog (Manual)                                              | FAIL          ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.1.5 "
fi
sudo rm -f output.txt
((total++))


echo -e "|4.2.1.6  | Ensure journald log rotation is configured per site policy (Manual)                                            |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
    ((total++))


echo -e "|4.2.1.7  | Ensure journald default file permissions configured (Manual)                                                   |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
    ((total++))

    #section 4.2.2
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|4.2.2    | Configure rsyslog                                                                                              |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' rsyslog >> output.txt
if grep -q "rsyslog     install ok installed    installed" output.txt;
then
        echo -e "|4.2.2.1  |Ensure rsyslog is installed (Automated)                                                                         |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.2.1  |Ensure rsyslog is installed (Automated)                                                                         | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.2.1 "
fi
sudo rm -f output.txt
((total++))



systemctl is-enabled rsyslog >> output.txt
if grep -q "enabled" output.txt;
then
    echo -e "|4.2.2.2  |Ensure rsyslog service is enabled (Automated)                                                                   |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.2.2  |Ensure rsyslog service is enabled (Automated)                                                                   | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.2.2 "
fi
sudo rm -f output.txt
((total++))


echo -e "|4.2.2.3  | Ensure journald is configured to send logs to rsyslog (Manual)                                                 |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
    ((total++))



grep ^\$FileCreateMode /etc/rsyslog.conf /etc/rsyslog.d/*.conf >> output.txt
if grep -q "$FileCreateMode 0640" output.txt;
then
        echo -e "|4.2.2.4  |Ensure rsyslog default file permissions are configured (Automated)                                              |${green} PASS            ${NC} |"
    ((pass_count++))
    
else
    echo -e "|${red}4.2.2.4  |Ensure rsyslog default file permissions are configured (Automated)                                              | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.2.4 "
fi
sudo rm -f output.txt
((total++))


echo -e "|4.2.2.5  | Ensure logging is configured (Manual)                                                                          |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
    ((total++))


    echo -e "|4.2.2.6  | Ensure rsyslog is configured to send logs to a remote log host (Manual)                                        |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
    ((total++))



grep -P -- '^\h*module\(load="imtcp"\)' /etc/rsyslog.conf /etc/rsyslog.d/*.conf >> output.txt
output=output.txt
if [ $(wc -l < "${output}") -eq 0 ]; then
        grep -P -- '^\h*input\(type="imtcp" port="514"\)' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
        output=output.txt
        if [ $(wc -l < "${output}") -eq 0 ]; then

                echo -e "|4.2.2.7  |Ensure rsyslog is not configured to receive logs from a remote client (Automated)                               |${green} PASS            ${NC} |"
                ((pass_count++))
                
                else
                echo -e "|${red}4.2.2.7  |Ensure rsyslog is not configured to receive logs from a remote client (Automated)                               | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.2.7 "
        fi
        else
                echo -e "|${red}4.2.2.7  |Ensure rsyslog is not configured to receive logs from a remote client (Automated)                               | FAIL             ${NC}|"
                
                ((fail_count++))
                failed_sections+="4.2.2.7 "
fi
sudo rm -f output.txt
((total++))


echo -e "|4.2.3    | Ensure all logfiles have appropriate permissions and ownership (Automated)                                     |${BLUE} Not-Accessed     ${NC}|"
    ((not_accessed++))
    ((total++))

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

path_to_fails="./S4_failss.sh"
display_failed_sections "$path_to_fails" > s4fails.txt
