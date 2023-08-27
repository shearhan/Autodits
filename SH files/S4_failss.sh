#!/bin/bash

yellow='\033[0;33m'
NC='\033[0;37m'
green='\033[0;032m'
red='\033[0;041m'
failred='\033[0;031m'

section=$1

# Benchmark Section 4.1.1.1
if [[ $section == "4.1.1.1" ]]; then
    title="4.1.1.1 Ensure auditd is installed (Automated)"
    dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' auditd audispd-plugins &>> output.txt
    output=$(cat output.txt)
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}auditd is the userspace component to the Linux Auditing System. It's responsible for writing audit records to the disk\n\n${yellow}Compliance: ${red}FAIL${NC}\\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance has failed as auditd is not installed\n\n${yellow}Rationale: ${NC}The capturing of system events provides system administrators with information to allow them to determine if unauthorized access to their system is occurring.\n\n${yellow}Remediation: ${NC}Please run the following command to install auditd:\n\napt install auditd audispd-plugins\n\n "

    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    
    # Benchmark Section 4.1.1.2
elif [[ $section == "4.1.1.2" ]]; then
    title="4.1.1.2 Ensure auditd service is enabled and active (Automated)"
    systemctl is-enabled auditd &>> output.txt
        if grep "enabled" output.txt;
    then
	    if grep "active" output.txt;
		    then
			    echo""
		    else


				    systemctl is-active auditd &>> output.txt
				    output=$(cat output.txt)
			    		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}Turn on the auditd daemon to record system events.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance has failed as auditd is not active\n\n${yellow}Rationale: ${NC}The capturing of system events provides system administrators with information to allow them to determine if unauthorized access to their system is occurring.\n\n${yellow}Remediation: ${NC}Please run the following command to start auditd:\n\nsystemctl --now enable auditd\n\n "
	    fi
    else
	    systemctl is-enabled auditd &>> output.txt
				    output=$(cat output.txt)
	    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}Turn on the auditd daemon to record system events.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance has failed as auditd is not enabled\n\n${yellow}Rationale: ${NC}The capturing of system events provides system administrators with information to allow them to determine if unauthorized access to their system is occurring.\n\n${yellow}Remediation: ${NC}Please run the following command to start auditd:\n\nsystemctl --now enable auditd\n\n "
	fi
sudo rm -f output.txt


	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"




elif [[ $section == "4.1.1.3" ]]; then
    title="4.1.1.3 Ensure auditing for processes that start prior to auditd is enabled (Automated)"
    #output=$(find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + | grep -v 'audit=1')
    find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + | grep -v 'audit=1' &>> output.txt
    output=$(cat output.txt)
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}Configure grub2 so that processes that are capable of being audited can be audited even if they start up prior to auditd startup.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance has failed because processes that start prior to auditd is not enabled\n\n${yellow}Rationale: ${NC}Audit events need to be captured on processes that start up prior to auditd , so that potential malicious activity cannot go undetected.\n\n${yellow}Remediation: ${NC}Run the following command to update the grub2 configuration:\n\nupdate-grub\n\n "
sudo rm -f output.txt

  echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.1.1.4" ]]; then
    title="4.1.1.4 Ensure audit_backlog_limit is sufficient (Automated)"
    #output=$(find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + |grep -Pv 'audit_backlog_limit=\d+\b')
    find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + |grep -Pv 'audit_backlog_limit=\d+\b' &>> output.txt
    output=$(cat output.txt)
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}In the kernel-level audit subsystem, a socket buffer queue is used to hold audit events. Whenever a new audit event is received, it is logged and prepared to be added to this queue.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance failed because audit_backlog_limit is not sufficient of has not been set.\n\n${yellow}Rationale: ${NC}If an audit event is logged which would grow the queue beyond the audit_backlog_limit, then a failure occurs, auditd records will be lost, and potential malicious activity could go undetected.\n\n${yellow}Remediation: ${NC}Edit /etc/default/grub and add audit_backlog_limit=N to GRUB_CMDLINE_LINUX. The recommended size for N is 8192 or larger.\n1: GRUB_CMDLINE_LINUX="audit_backlog_limit=8192"\n\n Run the following command:\n update-grub\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.1.2.1" ]]; then
    title="4.1.2.1 Ensure audit log storage size is configured (Automated)"
    #output=$(grep -Po -- '^\h*max_log_file\h*=\h*\d+\b' /etc/audit/auditd.conf)
    grep -Po -- '^\h*max_log_file\h*=\h*\d+\b' /etc/audit/auditd.conf &>> output.txt
    output=$(cat output.txt)
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}Configure the maximum size of the audit log file. Once the log reaches the maximum size, it will be rotated and a new log file will be started.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance failed because max_log_file is not sufficient of has not been set.\n\n${yellow}Rationale: ${NC}It is important that an appropriate size is determined for log files so that they do not impact the system and audit data is not lost.\n\n${yellow}Remediation: ${NC}Set the following parameter in /etc/audit/auditd.conf in accordance with site policy:\nmax_log_file = 8\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.2.2" ]]; then
    title="(Ensure audit logs are not automatically deleted (Automated))"
    output=$(grep max_log_file_action /etc/audit/auditd.conf)
    grep max_log_file_action /etc/audit/auditd.conf &>>output.txt
    output=$(cat output.txt)
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The max_log_file_action setting determines how to handle the audit log file reaching the max file size. A value of keep_logs will rotate the logs but never delete old logs.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance for this has failed because max_log_file_action has not been set, or has been set incorrectly.\n\n${yellow}Rationale: ${NC}Set the following parameter in /etc/audit/auditd.conf:\nmax_log_file_action = keep_logs\n\n${yellow}Remediation: ${NC}\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.1.2.3" ]]; then
    title="4.1.2.3 Ensure system is disabled when audit logs are full (Automated)"
    grep space_left_action /etc/audit/auditd.conf &>> output.txt
    output=$(cat output.txt)
    grep action_mail_acct /etc/audit/auditd.conf &>> output2.txt
    output2=$(cat output2.txt)
    grep -E admin_space_left_action /etc/audit/auditd.conf &>> output3.txt
    output3=$(cat output3.txt)
    sudo rm -f output.txt
    description="The auditd daemon can be configured to halt the system when the audit logs are full. The admin_space_left_action parameter tells the system what action to take when the system has detected that it is low on disk space."
    explanation="The compliance for this has failed because the space_left_action and/or the action_mail_acct and/or the admin_space_left_action has either not been set, hr have not been set correctly."
    rationale="In high security contexts, the risk of detecting unauthorized access or nonrepudiation exceeds the benefit of the system's availability."
    remediation="Set the following parameters in /etc/audit/auditd.conf:\nspace_left_action = email\naction_mail_acct = root\n\n And set admin_space_left_action to either halt or single in /etc/audit/auditd.conf.\nadmin_space_left_action = halt"
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n${output3}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
sudo rm -f output3.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.1.3.1" ]]; then
    title="4.1.3.1 Ensure changes to system administration scope (sudoers) is collected (Automated)"
    { awk '/^ *-w/ &&/\/etc\/sudoers/&&/ +-p *wa/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 
    } &>> output.txt
    output=$(cat output.txt)
    #output=$(awk '/^ *-w/ &&/\/etc\/sudoers/&&/ +-p *wa/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules)
    { auditctl -l | awk '/^ *-w/&&/\/etc\/sudoers/&&/ +-p *wa/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' 
    } &>> output2.txt
    output2=$(cat output2.txt)
    #output2=$(auditctl -l | awk '/^ *-w/&&/\/etc\/sudoers/&&/ +-p *wa/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)')
    description="Monitor scope changes for system administrators. The file /etc/sudoers, or files in /etc/sudoers.d, will be written to when the file(s) or related attributes have changed."
    explanation="The compliance for this has failed because either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Changes in the /etc/sudoers and /etc/sudoers.d files can indicate that an unauthorized change has been made to the scope of system administrator activity."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor scope changes for system administrators. Example:\n #printf ' -w /etc/sudoers -p wa -k scope -w /etc/sudoers.d -p wa -k scope ' >> /etc/audit/rules.d/50-scope.rules\n\nMerge and load the rules into active configuration:\naugenrules --load\n\nCheck if reboot is required."	
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.1.3.2" ]]; then
    title="4.1.3.2 Ensure actions as another user are always logged (Automated)"
    { awk '/^ *-a *always,exit/&&/ -F *arch=b[2346]{2}/&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/)&&(/ -C *euid!=uid/||/ -C *uid!=euid/)&&/ -S *execve/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 
    } &>> output.txt
    output=$(cat output.txt)
    { auditctl -l | awk '/^ *-a *always,exit/&&/ -F *arch=b[2346]{2}/&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/)&&(/ -C *euid!=uid/||/ -C *uid!=euid/)&&/ -S *execve/&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
    } &>> output2.txt  
    output2=$(cat output2.txt)
    description="sudo provides users with temporary elevated privileges to perform operations, either as the superuser or another user."
    explanation="The compliance for this hs failed because either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Creating an audit log of users with temporary elevated privileges and the operation(s) they performed is essential to reporting. Administrators will want to correlate the events written to the audit trail with the records written to sudo's logfile to verify if unauthorized commands have been executed."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor elevated privileges. Example:\n# printf ' -a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation -a always,exit -F arch=b32 -C euid!=uid -F auid!=unset -S execve -k user_emulation ' >> /etc/audit/rules.d/50-user_emulation.rules\n\nMerge and load the rules into active configuration:\naugenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.1.3.3" ]]; then
    title="4.1.3.3 Ensure events that modify the sudo log file are collected (Automated)"
    {
SUDO_LOG_FILE_ESCAPED=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//' -e 's/"//g' -e 's|/|\\/|g') [ -n "${SUDO_LOG_FILE_ESCAPED}" ] && awk "/^ *-w/ \
&&/"${SUDO_LOG_FILE_ESCAPED}"/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'SUDO_LOG_FILE_ESCAPED' is unset.\n"
} &>> output.txt
output=$(cat output.txt)
{
        SUDO_LOG_FILE_ESCAPED=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,? .*//' -e 's/"//g' -e 's|/|\\/|g') [ -n "${SUDO_LOG_FILE_ESCAPED}" ] && auditctl -l | awk "/^ *-w/ \
&&/"${SUDO_LOG_FILE_ESCAPED}"/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'SUDO_LOG_FILE_ESCAPED' is unset.\n"
} &>>  output2.txt
output2=$(cat output2.txt)
    description="Monitor the sudo log file. Any time a command is executed, an audit event will be triggered as the /var/log/sudo.log file will be opened for write and the executed administration command will be written to the log."
    explanation="The compliance for this has failed because because either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Changes in /var/log/sudo.log indicate that an administrator has executed a command or the log file itself has been tampered with. Administrators will want to correlate the events written to the audit trail with the records written to /var/log/sudo.log to verify if unauthorized commands have been executed."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor events that modify the sudo log file. Example:\n\n# {
SUDO_LOG_FILE=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,?.*//' -e 's/"//g')
[ -n '${SUDO_LOG_FILE}' ] && printf '-w ${SUDO_LOG_FILE} -p wa -k sudo_log_file' >> /etc/audit/rules.d/50-sudo.rules || printf 'ERROR: Variable 'SUDO_LOG_FILE_ESCAPED' is unset.\n'
}"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.1.3.4" ]]; then
    title="4.1.3.4 Ensure events that modify date and time information are collected (Automated)"
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
output=$(cat output.txt)
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
                                        } &>> output2.txt
                                        output2=$(cat output2.txt)
    description="Capture events where the system date and/or time has been modified. Further, ensure to write an audit record to the configured audit log file upon exit, tagging the records with a unique identifier such as 'time-change'."
    explanation="The compliance for this failed because either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Unexpected changes in system date and/or time could be a sign of malicious activity on the system."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor events that modify date and time information.\nExample:\n\n# printf '
-a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -k time-
change
-a always,exit -F arch=b32 -S adjtimex,settimeofday,clock_settime -k time-
change
-w /etc/localtime -p wa -k time-change
' >> /etc/audit/rules.d/50-time-change.rules"
    sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.1.3.5" ]]; then
    title="4.1.3.5 Ensure events that modify the system's network environment are collected (Automated)"
awk '/^ *-a *always,exit/ \
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
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules &>> output2.txt
{ auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' 
} &>> output3.txt
{ auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/issue/ \
||/\/etc\/issue.net/ \
||/\/etc\/hosts/ \
||/\/etc\/network/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' 
}&>> output4.txt
output=$(cat output.txt)
output2=$(cat output2.txt)
output3=$(cat output3.txt)
output4=$(cat output4.txt)
    description="Record changes to network environment files or system calls."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Monitoring sethostname and setdomainname will identify potential unauthorized changes to host and domainname of a system. The changing of these names could potentially break security parameters that are set based on those names. 
    The /etc/hosts file is monitored for changes that can indicate an unauthorized intruder is trying to change machine associations with IP addresses and trick users and processes into connecting to unintended machines. 
    Monitoring /etc/issue and /etc/issue.net is important, as intruders could put disinformation into those files and trick users into providing information to the intruder. 
    Monitoring /etc/network is important as it can show if network interfaces or scripts are being modified in a way that can lead to the machine becoming unavailable or compromised. 
    All audit records should have a relevant tag associated with them."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor events that modify the system's network environment. Example:\n\n# printf '
-a always,exit -F arch=b64 -S sethostname,setdomainname -k system-locale
-a always,exit -F arch=b32 -S sethostname,setdomainname -k system-locale
-w /etc/issue -p wa -k system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/hosts -p wa -k system-locale
-w /etc/networks -p wa -k system-locale
-w /etc/network/ -p wa -k system-locale
' >> /etc/audit/rules.d/50-system_local.rules\n\nMerge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
sudo rm -f output.txt
sudo rm -f output2.txt
sudo rm -f output3.txt
sudo rm -f output4.txt
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${NC}${output2}\n${NC}${output3}\n${NC}${output4}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "

    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.6" ]]; then
    title="4.1.3.6 Ensure use of privileged commands are collected (Automated)"
    
    { for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do
 for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f); do
 grep -qr "${PRIVILEGED}" /etc/audit/rules.d && printf "OK: '${PRIVILEGED}' found in auditing rules.\n" || printf "Warning: '${PRIVILEGED}' not found in on disk configuration.\n"
 done
 done } &>> output.txt
output=$(cat output.txt)
    description="Monitor privileged programs, those that have the setuid and/or setgid bit set on execution, to determine if unprivileged users are running these commands."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Loaded Rules or both, has not been set or has been set incorrectly."
    rationale="Execution of privileged commands by non-privileged users could be an indication of someone trying to gain unauthorized access to the system."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor the use of privileged commands.
    
    View CIS Benchmark for example
    
    
Merge and load the rules into active configuration:
# augenrules --load

Check if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.7" ]]; then
    title="4.1.3.7 Ensure unsuccessful file access attempts are collected (Automated)"
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
output=$(cat output.txt)
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
        } &>> output2.txt
        output2=(cat output2.txt)
    description="Monitor for unsuccessful attempts to access files."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Failed attempts to open, create or truncate files could be an indication that an individual or process is trying to gain unauthorized access to the system."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor unsuccessful file access attempts. See CIS Benchmark for example\n\nMerge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.8" ]]; then
    title="4.1.3.8 Ensure events that modify user/group information are collected (Automated)"
{ awk '/^ *-w/ \
&&(/\/etc\/group/ \
||/\/etc\/passwd/ \
||/\/etc\/gshadow/ \
||/\/etc\/shadow/ \
||/\/etc\/security\/opasswd/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules 
} &>> output.txt 
output=$(cat output.txt)
{ auditctl -l | awk '/^ *-w/ \
        &&(/\/etc\/group/ \
        ||/\/etc\/passwd/ \
        ||/\/etc\/gshadow/ \
        ||/\/etc\/shadow/ \
        ||/\/etc\/security\/opasswd/) \
        &&/ +-p *wa/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
        } &>> output2.txt
        output2=$(cat output2.txt)
    description="Record events affecting the modification of user or group information, including that of passwords and old passwords if in use."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Loaded Rules or both, has not been set or has been set incorrectly."
    rationale="Unexpected changes to these files could be an indication that the system has been compromised and that an unauthorized user is attempting to hide their activities or compromise additional accounts."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor unsuccessful file access attempts. Example:\n\n# printf '
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
' >> /etc/audit/rules.d/50-identity.rules \n\nMerge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.9" ]]; then
    title="4.1.3.9 Ensure discretionary access control permission modification events are collected (Automated)"
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
output=$(cat output.txt)
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
        } &>> output2.txt
        output2=(cat output2.txt)
    description="Monitor changes to file permissions, attributes, ownership and group. The parameters in this section track changes for system calls that affect file permissions and attributes. The following commands and system calls effect the permissions, ownership and various attributes of files."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Loaded Rules or both, has not been set or has been set incorrectly."
    rationale="Monitoring for changes in file attributes could alert a system administrator to activity that could indicate intruder activity or policy violation."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor discretionary access control permission modification events. Example:\n\n# {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n '${UID_MIN}' ] && printf '
-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=${UID_MIN} -F
auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F
auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=${UID_MIN} -F
auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F
auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S
setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F
auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S
setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F
auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
' >> /etc/audit/rules.d/50-perm_mod.rules || printf 'ERROR: Variable
'UID_MIN' is unset.\n'
}

Merge and load the rules into active configuration:\naugenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
sudo rm -f output3.txt
sudo rm -f output4.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.10" ]]; then
    title="4.1.3.10 Ensure successful file system mounts are collected (Automated)"
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
output=$(cat output.txt)
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
        } &>> output2.txt
        output2=$(cat output2.txt)
    description="Monitor the use of the mount system call. The mount (and umount ) system call controls the mounting and unmounting of file systems"
    explanation="The compliance for this has failed because, either the On-Disk rules or the Loaded Rules or both, has not been set or has been set incorrectly."
    rationale="It is highly unusual for a non privileged user to mount file systems to the system. While tracking mount commands gives the system administrator evidence that external media may have been mounted it does not conclusively indicate that data was exported to the media. System administrators who wish to determine if data were exported, would also have to track successful open, creat and truncate system calls requiring write access to a file under the mount point of the external media file system. This could give a fair indication that a write occurred. The only way to truly prove it, would be to track successful writes to the external media. Tracking write system calls could quickly fill up the audit log and is not recommended."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor successful file system mounts. Example:\n\n# {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf '
-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=unset -k mounts
-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=unset -k mounts
' >> /etc/audit/rules.d/50-mounts.rules || printf 'ERROR: Variable 'UID_MIN'
is unset.\n'
}

Merge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
sudo rm -f output3.txt
sudo rm -f output4.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.11" ]]; then
    title="Ensure session initiation information is collected (Automated)"
{
awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
||/\/var\/log\/wtmp/ \
||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
} &>> output.txt
output=$(cat output.txt)
{
auditctl -l | awk '/^ *-w/ \
        &&(/\/var\/run\/utmp/ \
        ||/\/var\/log\/wtmp/ \
        ||/\/var\/log\/btmp/) \
        &&/ +-p *wa/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
        } &>> output2.txt
        output2=$(cat output.txt)
    description="Monitor session initiation events."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Loaded Rules or both, has not been set or has been set incorrectly."
    rationale="Monitoring these files for changes could alert a system administrator to logins occurring at unusual hours, which could indicate intruder activity (i.e. a user logging in at a time when they do not normally log in)."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor session initiation information. Example:\n# printf '
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k session
-w /var/log/btmp -p wa -k session
' >> /etc/audit/rules.d/50-session.rules

Merge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt

    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.12" ]]; then
    title="4.1.3.12 Ensure login and logout events are collected (Automated)"
{
awk '/^ *-w/ \
&&(/\/var\/log\/lastlog/ \
||/\/var\/run\/faillock/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
} &>> output.txt
output=$(cat output.txt)
{
auditctl -l | awk '/^ *-w/ \
        &&(/\/var\/log\/lastlog/ \
        ||/\/var\/run\/faillock/) \
        &&/ +-p *wa/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
        } &>> output2.txt
        output2=$(cat output2.txt)
    description="Monitor login and logout events. The parameters below track changes to files associated with login/logout events."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Loaded Rules or both, has not been set or has been set incorrectly."
    rationale="Monitoring login/logout events could provide a system administrator with information associated with brute force attacks against user logins."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor login and logout events.
Example:
# printf '
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock -p wa -k logins
' >> /etc/audit/rules.d/50-login.rules

Merge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.13" ]]; then
    title="4.1.3.13 Ensure file deletion events by users are collected (Automated)"
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
output=$(cat output.txt)
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
        } &>> output2.txt
        output2=(cat output2.txt)
    description="Monitor the use of system calls associated with the deletion or renaming of files and file attributes."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Loaded Rules or both, has not been set or has been set incorrectly."
    rationale="Monitoring these calls from non-privileged users could provide a system administrator with evidence that inappropriate removal of files and file attributes associated with protected files is occurring. While this audit option will look at all events, system administrators will want to look for specific privileged files that are being deleted or altered."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor file deletion events by users. Example:\n\n# {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n '${UID_MIN}' ] && printf '
-a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F
auid>=${UID_MIN} -F auid!=unset -F key=delete
-a always,exit -F arch=b32 -S rename,unlink,unlinkat,renameat -F
auid>=${UID_MIN} -F auid!=unset -F key=delete
' >> /etc/audit/rules.d/50-delete.rules || printf 'ERROR: Variable 'UID_MIN'
is unset.\n'
}

	"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.14" ]]; then
    title="4.1.3.14 Ensure events that modify the system's Mandatory Access Controls are collected (Automated)"
{
awk '/^ *-w/ \
&&(/\/etc\/apparmor/ \
||/\/etc\/apparmor.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
} &>> output.txt
output=$(cat output.txt)
{
auditctl -l | awk '/^ *-w/ \
        &&(/\/etc\/apparmor/ \
        ||/\/etc\/apparmor.d/) \
        &&/ +-p *wa/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
        } &>> output2.txt
        output2=$(cat output2.txt)
    description="Monitor AppArmor, an implementation of mandatory access controls."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Loaded Rules or both, has not been set or has been set incorrectly."
    rationale="Changes to files in the /etc/apparmor/ and /etc/apparmor.d/ directories could indicate that an unauthorized user is attempting to modify access controls and change security contexts, leading to a compromise of the system."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor events that modify the system's Mandatory Access Controls. Example:
    
    # printf '
-w /etc/apparmor/ -p wa -k MAC-policy
-w /etc/apparmor.d/ -p wa -k MAC-policy
' >> /etc/audit/rules.d/50-MAC-policy.rules

Merge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.15" ]]; then
    title="4.1.3.15 Ensure successful and unsuccessful attempts to use the chcon command are recorded (Automated)"
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
output=(cat output.txt)
{
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -F *perm=x/ \
        &&/ -F *path=\/usr\/bin\/chcon/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output2.txt
        output2=(cat output2.txt)
    description="The operating system must generate audit records for successful/unsuccessful uses of the chcon command."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Without generating audit records that are specific to the security and mission needs of the organization, it would be difficult to establish, correlate, and investigate the events relating to an incident or identify those responsible for one. Audit records can be generated from various components within the information system"
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor successful and unsuccessful attempts to use the chcon command.
    
    # {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n '${UID_MIN}' ] && printf '
-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=${UID_MIN} -F
auid!=unset -k perm_chng
' >> /etc/audit/rules.d/50-perm_chng.rules || printf 'ERROR: Variable
'UID_MIN' is unset.\n'
}

Merge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.16" ]]; then
    title="4.1.3.16 Ensure successful and unsuccessful attempts to use the setfacl command are recorded (Automated)"
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
output=$(cat output.txt)
{
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -F *perm=x/ \
        &&/ -F *path=\/usr\/bin\/setfacl/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output2.txt
        output2=$(cat output2.txt)
    description="The operating system must generate audit records for successful/unsuccessful uses of the setfacl command"
    explanation="The compliance for this has failed because, either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Without generating audit records that are specific to the security and mission needs of the organization, it would be difficult to establish, correlate, and investigate the events relating to an incident or identify those responsible for one. Audit records can be generated from various components within the information system (e.g., module or policy filter)."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor successful and unsuccessful attempts to use the setfacl command.
    
    # {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n '${UID_MIN}' ] && printf '
-a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=${UID_MIN} -F
auid!=unset -k perm_chng
' >> /etc/audit/rules.d/50-priv_cmd.rules || printf 'ERROR: Variable
'UID_MIN' is unset.\n'
}

Merge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.17" ]]; then
    title="4.1.3.17 Ensure successful and unsuccessful attempts to use the chacl command are recorded (Automated)"
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
output=(cat output.txt)
{
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -F *perm=x/ \
        &&/ -F *path=\/usr\/bin\/chacl/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset.\n"
        } &>> output2.txt
        output2=$(cat output2.txt)
    description="The operating system must generate audit records for successful/unsuccessful uses of the chacl command"
    explanation="The compliance for this has failed because, either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Without generating audit records that are specific to the security and mission needs of the organization, it would be difficult to establish, correlate, and investigate the events relating to an incident or identify those responsible for one. Audit records can be generated from various components within the information system (e.g., module or policy filter)."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor successful and unsuccessful attempts to use the chacl command.
    
    # {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n '${UID_MIN}' ] && printf '
-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=${UID_MIN} -F
auid!=unset -k perm_chng
' >> /etc/audit/rules.d/50-perm_chng.rules || printf 'ERROR: Variable
'UID_MIN' is unset.\n'
}

Merge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.18" ]]; then
    title="4.1.3.18 Ensure successful and unsuccessful attempts to use the usermod command are recorded (Automated)"
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
output=$(cat output.txt)
{
        UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
        [ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
        &&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
        &&/ -F *auid>=${UID_MIN}/ \
        &&/ -F *perm=x/ \
        &&/ -F *path=\/usr\/sbin\/usermod/ \
        &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
        || printf "ERROR: Variable 'UID_MIN' is unset."
        } &>> output2.txt
        output2=$(cat output2.txt)
    description="The operating system must generate audit records for successful/unsuccessful uses of the usermod command."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Without generating audit records that are specific to the security and mission needs of the organization, it would be difficult to establish, correlate, and investigate the events relating to an incident or identify those responsible for one. Audit records can be generated from various components within the information system (e.g., module or policy filter)."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor successful and unsuccessful attempts to use the usermod command. Example:\n\n# {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n '${UID_MIN}' ] && printf '
-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=${UID_MIN} -F
auid!=unset -k usermod
' >> /etc/audit/rules.d/50-usermod.rules || printf 'ERROR: Variable 'UID_MIN'
is unset.\n'
}\n\nMerge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
sudo rm -f output2.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.19" ]]; then
    title="4.1.3.19 Ensure kernel module loading unloading and modification is collected (Automated)"
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
output=$(cat output.txt)
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
        } &>> output2.txt
        output2=$(cat output2.txt)
    description="Monitor the loading and unloading of kernel modules. All the loading / listing / dependency checking of modules is done by kmod via symbolic links. Any execution of the loading and unloading module programs and system calls will trigger an audit record with an identifier of modules."
    explanation="The compliance for this has failed because, either the On-Disk rules or the Running Configuration or both, has not been set or has been set incorrectly."
    rationale="Monitoring the use of all the various ways to manipulate kernel modules could provide system administrators with evidence that an unauthorized change was made to a kernel module, possibly compromising the security of the system."
    remediation="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension, with the relevant rules to monitor kernel module modification. Example:\n\n# {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n '${UID_MIN}' ] && printf '
-a always,exit -F arch=b64 -S
init_module,finit_module,delete_module,create_module,query_module -F
auid>=${UID_MIN} -F auid!=unset -k kernel_modules
-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=${UID_MIN} -F
auid!=unset -k kernel_modules
' >> /etc/audit/rules.d/50-kernel_modules.rules || printf 'ERROR: Variable
'UID_MIN' is unset.\n'
} Merge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${output2}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "

    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.20" ]]; then
    title="4.1.3.20 Ensure the audit configuration is immutable (Automated)"
    { grep -Ph -- '^\h*-e\h+2\b' /etc/audit/rules.d/*.rules | tail -1 
    } &>> output.txt
    output=$(cat output.txt)
    description="Set system audit so that audit rules cannot be modified with auditctl . Setting the flag '-e 2' forces audit to be put in immutable mode. Audit changes can only be made on system reboot."
    explanation="The compliance for this has failed because the audit has not been set to immutable mode."
    rationale="In immutable mode, unauthorized users cannot execute changes to the audit system to potentially hide malicious activity and then put the audit rules back. Users would most likely notice a system reboot and that could alert administrators of an attempt to make unauthorized audit changes."
    remediation="Edit or create the file /etc/audit/rules.d/99-finalize.rules and add the line -e 2 at the end of the file:
Example:\n# printf -- '-e 2
' >> /etc/audit/rules.d/99-finalize.rules\n\nMerge and load the rules into active configuration:\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.3.21" ]]; then
    title="4.1.3.21 Ensure the running and on disk configuration is the same (Manual)"
    { augenrules --check
    } &>> output.txt
    output=$(cat output.txt)
    description="The Audit system have both on disk and running configuration. It is possible for these configuration settings to differ."
    explanation="The compliance for this has failed because the Running and On-Disk configuration is not the same"
    rationale="Configuration differences between what is currently running and what is on disk could cause unexpected problems or may give a false impression of compliance requirements."
    remediation="If the rules are not aligned across all three () areas, run the following command to merge and load all rules\n# augenrules --load\n\nCheck if reboot is required."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

#Section 
elif [[ $section == "4.1.4.1" ]]; then
    title="4.1.4.1 Ensure audit log files are mode 0640 or less permissive (Automated)"
    { grep "^log_file" /etc/audit/auditd.conf|sed s/^[^\/]*//|xargs stat -c %a:%n
    } &>> output.txt
    output=$(cat output.txt)
    description="Audit log files contain information about the system and system activity."
    explanation="The compliance fot this has failed because the audit logs permissions have not been set, or have been set incorrectly"
    rationale="Access to audit records can reveal system and configuration data to attackers, potentially compromising its confidentiality."
    remediation="Follow CIS Benchmark section 4.1.4.1, for commands to remove more permissive mode than 0640 from audit log files."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.2" ]]; then
    title="4.1.4.2 Ensure only authorized users own audit log files (Automated)"
    { stat -Lc "%n %U" "$(dirname $(awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf | xargs))"/* | grep -Pv -- '^\H+\h+root\b'
    } &>> output.txt
    output=$(cat output.txt)
    description="Audit log files contain information about the system and system activity."
    explanation="The compliance to this has failed as the audit log files are own by a user other than root."
    rationale="Access to audit records can reveal system and configuration data to attackers, potentially compromising its confidentiality."
    remediation="Follow CIS Benchmark section 4.1.4.2, for commands to configure the audit log files to be owned by the root user:"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.3" ]]; then
    title="4.1.4.3 Ensure only authorized groups are assigned ownership of audit log files (Automated)"
    { grep -Piw -- '^\h*log_group\h*=\h*(adm|root)\b' /etc/audit/auditd.conf
    } &>> output.txt
    output=$(cat output.txt)
    description="Audit log files contain information about the system and system activity"
    explanation="The compliance for this has failed because the log_group parameter is not set to adm or root"
    rationale="Access to audit records can reveal system and configuration data to attackers, potentially compromising its confidentiality."
    remediation="Follow CIS Benchmark section 4.1.4.3, for commands to configure the audit log files to be owned by adm group"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.4" ]]; then
    title="4.1.4.4 Ensure the audit log directory is 0750 or more restrictive (Automated)"
    { stat -Lc "%n %a" "$(dirname $( awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf))" | grep -Pv -- '^\h*\H+\h+([0,5,7][0,5]0)'
    } &>> output.txt
    output=$(cat output.txt)
    description="The audit log directory contains audit log files."
    explanation="The compliance for this has failed because the audit log directory does not have a mode of 0750 or less permissive:"
    rationale="Audit information includes all information including: audit records, audit settings and audit reports. This information must be protected from unauthorized modification or deletion. If this information were to be compromised, forensic analysis and discovery of the true source of potentially malicious system activity is impossible to achieve."
    remediation="Follow CIS Benchmark section 4.1.4.4, for commands to configure the audit log directory to have a mode of '0750' or less permissive"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.5" ]]; then
    title="4.1.4.5 Ensure audit configuration files are 640 or more restrictive (Automated)"
    { find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec stat -Lc "%n %a" {} + | grep -Pv -- '^\h*\H+\h*([0,2,4,6][0,4]0)\h*$'
    } &>> output.txt
    output=$(cat output.txt)
    description="Audit configuration files control auditd and what events are audited."
    explanation="The compliance for this has failed because the audit configuration files does not have mode 640 or more restrictive and/or not owned by the root user and root group"
    rationale="Access to the audit configuration files could allow unauthorized personnel to prevent the
auditing of critical events. Misconfigured audit configuration files may prevent the auditing of critical events or impact the system's performance by overwhelming the audit log. Misconfiguration of the audit configuration files may also make it more difficult to establish and investigate events relating to an incident."
    remediation="Run the following command to remove more permissive mode than 0640 from the audit configuration files:
    
    # find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec
chmod u-x,g-wx,o-rwx {} +"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.6" ]]; then
    title="4.1.4.6 Ensure audit configuration files are owned by root (Automated)"
    { find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root 
    } &>> output.txt
    output=$(cat output.txt)
    description="Audit configuration files control auditd and what events are audited."
    explanation="The compliance for this has failed because the audit configuration files do not have mode 640 or more restrictive and are not owned by the root user and root group"
    rationale="Access to the audit configuration files could allow unauthorized personnel to prevent the
auditing of critical events. Misconfigured audit configuration files may prevent the auditing of critical events or impact the system's performance by overwhelming the audit log. Misconfiguration of the audit configuration files may also make it more difficult to establish and investigate events relating to an incident."
    remediation="Run the following command to change ownership to root user:
    
    # find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root -exec chown root {} +"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.7" ]]; then
    title="4.1.4.7 Ensure audit configuration files belong to group root (Automated)"
    { find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root 
    } &>> output.txt
    output=$(cat output.txt)
    description="Audit configuration files control auditd and what events are audited"
    explanation="The compliance for this has failed because the audit configuration files do not have mode 640 or more restrictive and/or are not owned by the root user and root group"
    rationale="Access to the audit configuration files could allow unauthorized personnel to prevent the
auditing of critical events. Misconfigured audit configuration files may prevent the auditing of critical events or impact the system's performance by overwhelming the audit log. Misconfiguration of the audit configuration files may also make it more difficult to establish and investigate events relating to an incident."
    remediation="Run the following command to change group to root:
    
    # find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root -exec chgrp root {} +"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.8" ]]; then
    title="4.1.4.8 Ensure audit tools are 755 or more restrictive (Automated)"
    { stat -c "%n %a" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+([0-7][0,1,4,5][0,1,4,5])\h*$'
    } &>> output.txt
    output=$(cat output.txt)
    description="Audit tools include, but are not limited to, vendor-provided and open source audit tools needed to successfully view and manipulate audit information system activity and records. Audit tools include custom queries and report generators."
    explanation="The compliance for this failed because the audit tools do not have mode of 755 or more restrictive, and/or are not owned by the root user and group root"
    rationale="Protecting audit information includes identifying and protecting the tools used to view and manipulate log data. Protecting audit tools is necessary to prevent unauthorized operation on audit information."
    remediation="Run the following command to remove more permissive mode from the audit tools:
    
    # chmod go-w /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.9" ]]; then
    title="4.1.4.9 Ensure audit tools are owned by root (Automated)"
    { stat -c "%n %U" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+root\h*$'
} &>> output.txt
output=$(cat output.txt)
    description="Audit tools include, but are not limited to, vendor-provided and open source audit tools needed to successfully view and manipulate audit information system activity and records. Audit tools include custom queries and report generators."
    explanation="The compliance for this has failed because the audit tools does not have a mode of 755 or more restrictive, and/or are owned by the root user and group root"
    rationale="Protecting audit information includes identifying and protecting the tools used to view and manipulate log data. Protecting audit tools is necessary to prevent unauthorized operation on audit information."
    remediation="Run the following command to change the owner of the audit tools to the root user:
    
    # chown root /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.10" ]]; then
    title="4.1.4.10 Ensure audit tools belong to group root (Automated)"
    { stat -c "%n %a %U %G" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+([0-7][0,1,4,5][0,1,4,5])\h+root\h+root\h*$'
    } &>> output.txt
    output=$(cat output.txt)
    description="Audit tools include, but are not limited to, vendor-provided and open source audit tools needed to successfully view and manipulate audit information system activity and records. Audit tools include custom queries and report generators."
    explanation="The compliance for this has failed because the audit tools does not have a mode of 755 or more restrictive, and/or are not owned by the root user and group root"
    rationale="Protecting audit information includes identifying and protecting the tools used to view and manipulate log data. Protecting audit tools is necessary to prevent unauthorized operation on audit information."
    remediation="Run the following command to verify the audit tools have mode 755 or more restrictive, are owned by the root user and group root
    
    # stat -c '%n %a %U %G' /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+([0-7][0,1,4,5][0,1,4,5])\h+root\h+root\h*$'"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.1.4.11" ]]; then
    title="Ensure cryptographic mechanisms are used to protect the integrity of audit tools (Automated)"
    { grep -P -- '(\/sbin\/(audit|au)\H*\b)' /etc/aide/aide.conf
    } &>> output.txt
    output=$(cat output.txt)
    description="Audit tools include, but are not limited to, vendor-provided and open source audit tools needed to successfully view and manipulate audit information system activity and records. Audit tools include custom queries and report generators."
    explanation="The compliance for this has failed because AIDE is not properly configured"
    rationale="Protecting the integrity of the tools used for auditing purposes is a critical step toward ensuring the integrity of audit information. Audit information includes all information needed to successfully auditcinformation system activity. Attackers may replace the audit tools or inject code into the existing tools with the purpose of providing the capability to hide or erase system activity from the audit logs. Audit tools should be cryptographically signed in order to provide the capability to identify when the audit tools have been modified, manipulated, or replaced"
    remediation="Add or update the following selection lines for '/etc/aide/aide.conf' to protect the integrity of the audit tools:
    
# Audit Tools
/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512
/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512
/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512
/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512
/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512
/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.2.1.1.1" ]]; then
    title="4.2.1.1.1 Ensure systemd-journal-remote is installed (Automated)"
    { dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n'systemd-journal-remote
    } &>> output.txt
    output=$(output.txt)
    description="Journald supports the ability to send log events it gathers to a remote log host or to receive messages from remote hosts, thus enabling centralised log management."
    explanation="The compliance for this has failed because systemd-journal-remote is not installed"
    rationale="Storing log data on a remote host protects log integrity from local attacks. If an attacker gains root access on the local system, they could tamper with or remove log data that is stored on the local system."
    remediation="Run the following command to install systemd-journal-remote:
    
    # apt install systemd-journal-remote"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.2.1.1.2" ]]; then
    title="4.2.1.1.2 Ensure systemd-journal-remote is configured (Manual)"
    { grep -P "^ *URL=|^ *ServerKeyFile=|^ *ServerCertificateFile=|^ *TrustedCertificateFile=" /etc/systemd/journal-upload.conf
    } &>> output.txt
    output=$(cat output.txt)
    description="Journald supports the ability to send log events it gathers to a remote log host or to receive messages from remote hosts, thus enabling centralised log management."
    explanation="The compliance for this has failed because systemd-journal-remote is not configured or is not configured properly"
    rationale="Storing log data on a remote host protects log integrity from local attacks. If an attacker gains root access on the local system, they could tamper with or remove log data that is stored on the local system."
    remediation="Edit the /etc/systemd/journal-upload.conf file and ensure the following lines are set per your environment:
    
URL=192.168.50.42
ServerKeyFile=/etc/ssl/private/journal-upload.pem
ServerCertificateFile=/etc/ssl/certs/journal-upload.pem
TrustedCertificateFile=/etc/ssl/ca/trusted.pem

Restart the service:
# systemctl restart systemd-journal-upload"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.2.1.1.3" ]]; then
    title="4.2.1.1.3 Ensure systemd-journal-remote is enabled (Manual)"
    systemctl is-enabled systemd-journal-upload.service &>> output.txt
    output=$(cat output.txt)
    description="Journald supports the ability to send log events it gathers to a remote log host or to receive messages from remote hosts, thus enabling centralised log management."
    explanation="The compliance for this has failed because systemd-journal-remote is not enabled"
    rationale="Storing log data on a remote host protects log integrity from local attacks. If an attacker gains root access on the local system, they could tamper with or remove log data that is stored on the local system."
    remediation="Run the following command to enable systemd-journal-remote:
    
    # systemctl --now enable systemd-journal-upload.service"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.2.1.1.4" ]]; then
    title="4.2.1.1.4 Ensure journald is not configured to recieve logs from a remote client (Automated)"
    systemctl is-enabled systemd-journal-remote.socket &>> output.txt
    output=$(cat output.txt)
    description="Journald supports the ability to receive messages from remote hosts, thus acting as a log server. Clients should not receive data from other hosts."
    explanation="The compliance for this has failed because systemd-journal-remote.socket is enabled"
    rationale="If a client is configured to also receive data, thus turning it into a server, the client system is acting outside it's operational boundary."
    remediation="Run the following command to disable systemd-journal-remote.socket:
    
    # systemctl --now disable systemd-journal-remote.socket"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.2.1.2" ]]; then
    title="4.2.1.2 Ensure journald service is enabled (Automated)"
    { systemctl is-enabled systemd-journald.service
    } &>> output.txt
    output=$(cat output.txt)
    description="Ensure that the systemd-journald service is enabled to allow capturing of logging events."
    explanation="The compliance for this has failed because"
    rationale="If the systemd-journald service is not enabled to start on boot, the system will not capture logging events."
    remediation="By default the systemd-journald service does not have an [Install] section and thus cannot be enabled / disabled. It is meant to be referenced as Requires or Wants by other unit files. As such, if the status of systemd-journald is not static, investigate why."
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "

    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.2.1.3" ]]; then
    title="4.2.1.3 Ensure journald is configured to compress large log files (Automated)"
    { grep ^\s*Compress /etc/systemd/journald.conf
    } &>> output.txt
    output=$(cat output.txt)
    description="The journald system includes the capability of compressing overly large files to avoid filling up the system with logs or making the logs unmanageably large."
    explanation="The compliance for this has failed"
    rationale="Uncompressed large files may unexpectedly fill a filesystem leading to resource unavailability. Compressing logs prior to write can prevent sudden, unexpected filesystem impacts."
    remediation="Edit the /etc/systemd/journald.conf file and add the following line:
    
    Compress=yes
    
    Restart the service:
    # systemctl restart systemd-journald"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.2.1.4" ]]; then
    title="4.2.1.4 Ensure journald is configured to write logfiles to persistent disk (Automated)"
    { grep ^\s*Storage /etc/systemd/journald.conf
    } &>> output.txt
    output=$(cat output.txt)
    description="Data from journald may be stored in volatile memory or persisted locally on the server. Logs in memory will be lost upon a system reboot. By persisting logs to local disk on the server they are protected from loss due to a reboot."
    explanation="The compliance for this has failed because the logs are not persisted to disk"
    rationale="Writing log data to disk will provide the ability to forensically reconstruct events which may have impacted the operations or security of a system even after a system crash or reboot."
    remediation="Edit the /etc/systemd/journald.conf file and add the following line:
    
    Storage=persistent
    
    Restart the service:
    # systemctl restart systemd-journald"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.2.1.5" ]]; then
    title="4.2.1.5 Ensure journald is not configured to send logs to rsyslog (Manual)"
    { grep ^\s*ForwardToSyslog /etc/systemd/journald.conf
    } &>> output.txt
    output=$(cat output.txt)
    description="Data from journald should be kept in the confines of the service and not forwarded on to other services."
    explanation="The compliance for this has failed because the logs are forwarded to rsyslog"
    rationale="IF journald is the method for capturing logs, all logs of the system should be handled by journald and not forwarded to other logging mechanisms."
    remediation="Edit the /etc/systemd/journald.conf file and ensure that ForwardToSyslog=yes is removed.
Restart the service

# systemctl restart systemd-journald"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.2.2.1" ]]; then
    title="4.2.2.1 Ensure rsyslog is installed (Automated)"
    { dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' rsyslog
    } &>> output.txt
    output=$(cat output.txt)
    description="The rsyslog software is recommended in environments where journald does not meet operation requirements."
    explanation="The explanation for this compliance has failed because rsyslog i not installed"
    rationale="The security enhancements of rsyslog such as connection-oriented (i.e. TCP) transmission of logs, the option to log to database formats, and the encryption of log data en route to a central logging server) justify installing and configuring the package."
    remediation="Run the following command to install rsyslog:
    
    # apt install rsyslog"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.2.2.2" ]]; then
    title="4.2.2.2 Ensure rsyslog service is enabled (Automated)"
    { systemctl is-enabled rsyslog
    } &>> output.txt
    output=$(cat output.txt)
    description="Once the rsyslog package is installed, ensure that the service is enabled."
    explanation="The compliance for this has failed because rsyslog is not enabled"
    rationale="If the rsyslog service is not enabled to start on boot, the system will not capture logging events."
    remediation="Run the following command to enable rsyslog:
    
    # systemctl --now enable rsyslog"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"

elif [[ $section == "4.2.2.4" ]]; then
    title="4.2.2.4 Ensure rsyslog default file permissions are configured (Automated)"
    { grep '$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
    } &>> output.txt
    output=$(cat output.txt)
    description="RSyslog will create logfiles that do not already exist on the system. This setting controls what permissions will be applied to these newly created files."
    explanation="The compliance for this has failed because rsyslog permissions are not configured, or have been configured incorrectly"
    rationale="It is important to ensure that log files have the correct permissions to ensure that sensitive data is archived and protected."
    remediation="Edit either /etc/rsyslog.conf or a dedicated .conf file in /etc/rsyslog.d/ and set
$FileCreateMode to 0640 or more restrictive:

$FileCreateMode 0640

Restart the service:
# systemctl restart rsyslog"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "

    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"


elif [[ $section == "4.2.2.7" ]]; then
    title="4.2.2.7 Ensure rsyslog is not configured to receive logs from a remote client (Automated)"
    { grep '$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
    } &>> output.txt
    output=$(cat output.txt)
    description="RSyslog supports the ability to receive messages from remote hosts, thus acting as a log server. Clients should not receive data from other hosts."
    explanation="The compliance for this has failed because syslog is not configured correctly"
    rationale="If a client is configured to also receive data, thus turning it into a server, the client system is acting outside it's operational boundary."
    remediation="Should there be any active log server configuration found in the auditing section, modify those file and remove the specific lines highlighted by the audit. Ensure none of the following entries are present in any of /etc/rsyslog.conf or /etc/rsyslog.d/*.conf.
    
$ModLoad imtcp
$InputTCPServerRun"
    
    echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description: ${NC}$description\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output:\n${NC}${output}\n\n${yellow}Explanation: ${NC}$explanation\n\n${yellow}Rationale: ${NC}$rationale\n\n${yellow}Remediation:\n${NC}$remediation\n\n "
sudo rm -f output.txt
    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------"







else
        echo "Invalid section: $section"
fi


