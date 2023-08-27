#!/bin/bash

# Colour of compliance
yellow='\033[0;33m'
red='\033[01;41m'
rednh='\033[01;31m'
green='\033[01;32m'
normal='\033[0m'
bold='\033[01;37m'

section=$1

 	# 5.1.1
if [[ $section == "5.1.1" ]]; then
	benchmark_title="5.1.1 Ensure cron daemon is enabled and running (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}cron ${normal}daemon is used to execute batch jobs on the system.\n\nWhen performing the audit, the output that should be shown is ${bold}enabled ${normal}and ${bold}Active: active (running) since <Day Date Time> ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	systemctl is-enabled cron | grep "enabled"
	systemctl status cron | grep "Active: active (running)"

	if ! systemctl is-enabled cron | grep -q "enabled" || ! systemctl status cron | grep -q "Active: active (running)"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}cron ${normal}daemon is not enabled and running, which does not meet the required criteria.\n\nWhile there may not be user jobs that need to be run on the system, the system does have maintenance jobs that may include security monitoring that have to run, and ${bold}cron${normal} is used to execute them.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to enable and start ${bold}cron${normal}:\n\n${bold}systemctl --now enable cron ${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
  	# 5.1.2
elif [[ $section == "5.1.2" ]]; then
	benchmark_title="5.1.2 Ensure permissions on /etc/crontab are configured (Automated)"
	expected_permissions="600"
	crontab_file="/etc/crontab"

	# Check permissions on /etc/crontab
	actual_permissions=$(stat -c "%a" "$crontab_file")
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}/etc/crontab ${normal}file is used by ${bold}cron ${normal}to control its own jobs. The commands in this item make sure that root is the user and group owner of the file and that only the owner can access the file.\n\nWhen performing the audit, the output that should be shown is\n${bold}Access: (0600/-rw-------) Uid: (    0/    root)   Gid: (    0/    root) ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/crontab

	if ! [[ "$actual_permissions" == "$expected_permissions" ]] || ! stat /etc/crontab | grep -q "Uid: (    0/    root)   Gid: (    0/    root)"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/crontab ${normal}permissions are not configured, which does not meet the required criteria.\n\nThis file contains information on what system jobs are run by cron. Write access to these files could provide unprivileged users with the ability to elevate their privileges. Read access to these files could provide users with the ability to gain insight on system jobs that run on the system and could provide them a way to gain unauthorized privileged access.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to set ownership and permissions on ${bold}/etc/crontab${normal}:\n\n${bold}chown root:root /etc/crontab\n\nchmod og-rwx /etc/crontab${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
   	# 5.1.3
elif [[ $section == "5.1.3" ]]; then
	benchmark_title="5.1.3 Ensure permissions on /etc/cron.hourly are configured (Automated)"
	expected_permissions="700"
	cron_hourly_dir="/etc/cron.hourly"

	# Check permissions on /etc/crontab
	actual_permissions=$(stat -c "%a" "$cron_hourly_dir")
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}This directory contains system ${bold}cron${normal} jobs that need to run on an hourly basis. The files in this directory cannot be manipulated by the ${bold}crontab${normal} command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}Access: (0700/drwx------) Uid: (    0/    root)   Gid: (    0/    root) ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/cron.hourly/

	if ! [[ "$actual_permissions" == "$expected_permissions" ]] || ! stat /etc/cron.hourly | grep -q "Uid: (    0/    root)   Gid: (    0/    root)"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/cron.hourly ${normal}permissions are not configured, which does not meet the required criteria.\n\nGranting write access to this directory for non-privileged users could provide them the means for gaining unauthorized elevated privileges. Granting read access to this directory could give an unprivileged user insight in how to gain elevated privileges or circumvent auditing controls.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to set ownership and permissions on ${bold}/etc/cron.hourly${normal} directory:\n\n${bold}chown root:root /etc/cron.hourly/\n\nchmod og-rwx /etc/cron.hourly/${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
    	# 5.1.4
elif [[ $section == "5.1.4" ]]; then
	benchmark_title="5.1.4 Ensure permissions on /etc/cron.daily are configured (Automated)"
	expected_permissions="700"
	cron_daily_dir="/etc/cron.daily"

	# Check permissions on /etc/crontab
	actual_permissions=$(stat -c "%a" "$cron_daily_dir")
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}/etc/cron.daily${normal} directory contains system cron jobs that need to run on a daily basis. The files in this directory cannot be manipulated by the ${bold}crontab${normal} command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}Access: (0700/drwx------) Uid: (    0/    root)   Gid: (    0/    root) ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/cron.daily/

	if ! [[ "$actual_permissions" == "$expected_permissions" ]] || ! stat /etc/cron.hourly | grep -q "Uid: (    0/    root)   Gid: (    0/    root)"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/cron.daily ${normal}permissions are not configured, which does not meet the required criteria.\n\nGranting write access to this directory for non-privileged users could provide them the means for gaining unauthorized elevated privileges. Granting read access to this directory could give an unprivileged user insight in how to gain elevated privileges or circumvent auditing controls.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to set ownership and permissions on ${bold}/etc/cron.daily${normal} directory:\n\n${bold}chown root:root /etc/cron.daily/\n\nchmod og-rwx /etc/cron.daily/${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
     	# 5.1.5
elif [[ $section == "5.1.5" ]]; then
	benchmark_title="5.1.5 Ensure permissions on /etc/cron.weekly are configured (Automated)"
	expected_permissions="700"
	cron_weekly_dir="/etc/cron.weekly"

	# Check permissions on /etc/crontab
	actual_permissions=$(stat -c "%a" "$cron_weekly_dir")
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}/etc/cron.weekly${normal} directory contains system cron jobs that need to run on a weekly basis. The files in this directory cannot be manipulated by the ${bold}crontab${normal} command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}Access: (0700/drwx------) Uid: (    0/    root)   Gid: (    0/    root) ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/cron.weekly/

	if ! [[ "$actual_permissions" == "$expected_permissions" ]] || ! stat /etc/cron.weekly | grep -q "Uid: (    0/    root)   Gid: (    0/    root)"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/cron.weekly ${normal}permissions are not configured, which does not meet the required criteria.\n\nGranting write access to this directory for non-privileged users could provide them the means for gaining unauthorized elevated privileges. Granting read access to this directory could give an unprivileged user insight in how to gain elevated privileges or circumvent auditing controls.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to set ownership and permissions on ${bold}/etc/cron.weekly${normal} directory:\n\n${bold}chown root:root /etc/cron.weekly/\n\nchmod og-rwx /etc/cron.weekly/${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
      	# 5.1.6
elif [[ $section == "5.1.6" ]]; then
	benchmark_title="5.1.6 Ensure permissions on /etc/cron.monthly are configured (Automated)"
	expected_permissions="700"
	cron_monthly_dir="/etc/cron.monthly"

	# Check permissions on /etc/crontab
	actual_permissions=$(stat -c "%a" "$cron_monthly_dir")
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}/etc/cron.monthly${normal} directory contains system cron jobs that need to run on a monthly basis. The files in this directory cannot be manipulated by the ${bold}crontab${normal} command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}Access: (0700/drwx------) Uid: (    0/    root)   Gid: (    0/    root) ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/cron.monthly/

	if ! [[ "$actual_permissions" == "$expected_permissions" ]] || ! stat /etc/cron.monthly | grep -q "Uid: (    0/    root)   Gid: (    0/    root)"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/cron.monthly ${normal}permissions are not configured, which does not meet the required criteria.\n\nGranting write access to this directory for non-privileged users could provide them the means for gaining unauthorized elevated privileges. Granting read access to this directory could give an unprivileged user insight in how to gain elevated privileges or circumvent auditing controls.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to set ownership and permissions on ${bold}/etc/cron.monthly${normal} directory:\n\n${bold}chown root:root /etc/cron.monthly/\n\nchmod og-rwx /etc/cron.monthly/${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
       	# 5.1.7
elif [[ $section == "5.1.7" ]]; then
	benchmark_title="5.1.7 Ensure permissions on /etc/cron.d are configured (Automated)"
	expected_permissions="700"
	cron_d_dir="/etc/cron.d"

	# Check permissions on /etc/crontab
	actual_permissions=$(stat -c "%a" "$cron_d_dir")
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}/etc/cron.d${normal} directory contains system ${bold}cron${normal} jobs that need to run in a similar manner to the hourly, daily weekly and monthly jobs from ${bold}/etc/crontab${normal}, but require more granular control as to when they run. The files in this directory cannot be manipulated by the ${bold}crontab${normal} command, but are instead edited by system administrators using a text editor. The commands below restrict read/write and search access to user and group root, preventing regular users from accessing this directory.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}Access: (0700/drwx------) Uid: (    0/    root)   Gid: (    0/    root) ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/cron.d/

	if ! [[ "$actual_permissions" == "$expected_permissions" ]] || ! stat /etc/cron.d | grep -q "Uid: (    0/    root)   Gid: (    0/    root)"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/cron.d ${normal}permissions are not configured, which does not meet the required criteria.\n\nGranting write access to this directory for non-privileged users could provide them the means for gaining unauthorized elevated privileges. Granting read access to this directory could give an unprivileged user insight in how to gain elevated privileges or circumvent auditing controls.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to set ownership and permissions on ${bold}/etc/cron.d${normal} directory:\n\n${bold}chown root:root /etc/cron.d/\n\nchmod og-rwx /etc/cron.d/${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
        # 5.1.8
elif [[ $section == "5.1.8" ]]; then
	benchmark_title="5.1.8 Ensure cron is restricted to authorized users (Automated)"
	cron_allow="/etc/cron.allow"
	cron_deny="/etc/cron.deny"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure ${bold}/etc/cron.allow${normal} to allow specific users to use this service. If ${bold}/etc/cron.allow${normal} does not exist, then ${bold}/etc/cron.deny${normal} is checked. Any user not specifically defined in this file is allowed to use ${bold}cron${normal}. By removing the file, only users in ${bold}/etc/cron.allow${normal} are allowed to use ${bold}cron${normal}.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}stat: cannot stat '/etc/cron.deny': No such file or directory ${normal}and ${bold}Access: (0640/-rw-r-xr--)  Uid: (    0/    root)   Gid: (    0/    root)${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/cron.deny
	stat /etc/cron.allow

	if ! [ -f "$cron_allow" ] && ! [ -f "$cron_deny" ]; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}cron ${normal}is not restricted to authorized users, which does not meet the required criteria.\n\nOn many systems, only the system administrator is authorized to schedule ${bold}cron${normal} jobs. Using the ${bold}cron.allow${normal} file to control who can run ${bold}cron${normal} jobs enforces this policy. It is easier to manage an allow list than a deny list. In a deny list, you could potentially add a user ID to the system and forget to add it to the deny files.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to remove ${bold}/etc/cron.deny${normal}:\n\n${bold}rm /etc/cron.deny${normal}\n\n2. Run the following command to create /etc/cron.allow:\n\n${bold}touch /etc/cron.allow${normal}\n\n3. Run the following commands to set permissions and ownership for /etc/cron.allow:\n\n${bold}chmod g-wx,o-rwx /etc/cron.allow\n\nchown root:root /etc/cron.allow${normal}\n\n4. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
         # 5.1.9
elif [[ $section == "5.1.9" ]]; then
	benchmark_title="5.1.9 Ensure at is restricted to authorized users (Automated)"
	at_allow="/etc/at.allow"
	at_deny="/etc/at.deny"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure ${bold}/etc/at.allow${normal} to allow specific users to use this service. If ${bold}/etc/at.allow${normal} does not exist, then ${bold}/etc/at.deny${normal} is checked. Any user not specifically defined in this file is allowed to use ${bold}at${normal}. By removing the file, only users in ${bold}/etc/cron.allow${normal} are allowed to use ${bold}at${normal}.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}stat: cannot stat '/etc/at.deny': No such file or directory ${normal}and ${bold}Access: (0640/-rw-r-xr--)  Uid: (    0/    root)   Gid: (    0/    root)${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/at.deny
	stat /etc/at.allow

	if ! [ -f "$at_allow" ] && ! [ -f "$at_deny" ]; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}at ${normal}is not restricted to authorized users, which does not meet the required criteria.\n\nOn many systems, only the system administrator is authorized to schedule ${bold}at${normal} jobs. Using the ${bold}at.allow${normal} file to control who can run ${bold}at${normal} jobs enforces this policy. It is easier to manage an allow list than a deny list. In a deny list, you could potentially add a user ID to the system and forget to add it to the deny files.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to remove ${bold}/etc/at.deny${normal}:\n\n${bold}rm /etc/at.deny${normal}\n\n2. Run the following command to create /etc/at.allow:\n\n${bold}touch /etc/at.allow${normal}\n\n3. Run the following commands to set permissions and ownership for /etc/at.allow:\n\n${bold}chmod g-wx,o-rwx /etc/at.allow\n\nchown root:root /etc/at.allow${normal}\n\n4. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
        # 5.2.1
elif [[ $section == "5.2.1" ]]; then
	benchmark_title="5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured (Automated)"
	expected_permissions="600"
	sshd_config="/etc/ssh/sshd_config"

	# Check permissions on /etc/crontab
	actual_permissions=$(stat -c "%a" "$sshd_config")
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}/etc/ssh/sshd_config${normal} file contains configuration specifications for ${bold}sshd${normal}. The command below sets the owner and group of the file to ${bold}root${normal}.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}Access: (0600/-rw-------) Uid: (    0/    root)   Gid: (    0/    root) ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/ssh/sshd_config

	if ! [[ "$actual_permissions" == "$expected_permissions" ]] || ! stat /etc/ssh/sshd_config | grep -q "Uid: (    0/    root)   Gid: (    0/    root)"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}permissions are not configured, which does not meet the required criteria.\n\nThe ${bold}/etc/ssh/sshd_config${normal} file needs to be protected from unauthorized changes by non-privileged users.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to set ownership and permissions on ${bold}/etc/ssh/sshd_config${normal} directory:\n\n${bold}chown root:root /etc/ssh/sshd_config\n\nchmod og-rwx /etc/ssh/sshd_config${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
         # 5.2.2
elif [[ $section == "5.2.2" ]]; then
	benchmark_title="5.2.2 Ensure permissions on SSH private host key files are configured (Automated)"
	expected_permissions="600"
	rsa_key_file="/etc/ssh/ssh_host_rsa_key"
	ecdsa_key_file="/etc/ssh/ssh_host_ecdsa_key"

	# Check permissions on ssh_host_rsa_key file
	rsa_actual_permissions=$(stat -c "%a" "$rsa_key_file")

	# Check permissions on ssh_host_ecdsa_key file
	ecdsa_actual_permissions=$(stat -c "%a" "$ecdsa_key_file")
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}An SSH private key is one of two files used in SSH public key authentication. In this authentication method, the possession of the private key is proof of identity. Only a private key that corresponds to a public key will be able to authenticate successfully. The private keys need to be stored and handled carefully, and no copies of the private key should be distributed.\n\nWhen performing the audit, the output should verify SSH private host key files are mode 0600 or more restrictive, owned be the root user, and owned be the group root or group designated to own openSSH private keys."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	stat /etc/ssh/ssh_host_rsa_key
	stat /etc/ssh/ssh_host_ecdsa_key

	if [ "$rsa_actual_permissions" == "$expected_permissions" ] && [ "$ecdsa_actual_permissions" == "$expected_permissions" ]; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the SSH private host key files permissions are not configured, which does not meet the required criteria.\n\nIf an unauthorized user obtains the private SSH host key file, the host could be impersonated\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 623 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_skgn="ssh_keys" # Group designated to own openSSH keys
	l_skgid="$(awk -F: ''($1 == "'"$l_skgn"'")''{print $3}'' /etc/group)"

	awk '{print}' <<< "$(find /etc/ssh -xdev -type f -name ''ssh_host_*_key'' -exec stat -L -c "%n %#a %U %G %g" {} +)" | (
		while read -r l_file l_mode l_owner l_group l_gid; do
			[ -n "$l_skgid" ] && l_cga="$l_skgn" || l_cga="root"
			[ "$l_gid" = "$l_skgid" ] && l_pmask="0137" || l_pmask="0177"
			l_maxperm="$( printf ''%o'' $(( 0777 & ~$l_pmask )) )"

			if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
				echo -e " - File: \"$l_file\" is mode \"$l_mode\" changing to mode: \"$l_maxperm\""
				if [ -n "$l_skgid" ]; then
					chmod u-x,g-wx,o-rwx "$l_file"
				else
					chmod u-x,go-rwx "$l_file"
				fi
			fi

			if [ "$l_owner" != "root" ]; then
				echo -e " - File: \"$l_file\" is owned by: \"$l_owner\" changing owner to \"root\""
				chown root "$l_file"
			fi

			if [ "$l_group" != "root" ] && [ "$l_gid" != "$l_skgid" ]; then
				echo -e " - File: \"$l_file\" is owned by group \"$l_group\" should belong to group \"$l_cga\""
				chgrp "$l_cga" "$l_file"
			fi
		done
	)
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
         # 5.2.3
elif [[ $section == "5.2.3" ]]; then
	benchmark_title="5.2.3 Ensure permissions on SSH public host key files are configured (Automated)"
	expected_permissions="644"

	# Find SSH public key files in /etc/ssh
	public_key_files=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub')
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}An SSH public key is one of two files used in SSH public key authentication. In this authentication method, a public key is a key that can be used for verifying digital signatures generated using a corresponding private key. Only a public key that corresponds to a private key will be able to authenticate successfully.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}Access: (0644/-rw-r--r--) Uid: (    0/    root)   Gid: (    0/    root) ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec stat {} \;
	
	for file in $public_key_files; do
		actual_permissions=$(stat -c "%a" "$file")
	done
	
	if [ "$actual_permissions" != "$expected_permissions" ]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}SSH public host key files ${normal}permissions are not configured, which does not meet the required criteria.\n\nIf a public host key file is modified by an unauthorized user, the SSH service may be compromised.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to set permissions and ownership on the SSH host public key files:\n\n${bold}find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chmod u-x,go-wx {} \;\n\nfind /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' -exec chown root:root {} \;${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
         # 5.2.4
elif [[ $section == "5.2.4" ]]; then
	benchmark_title="5.2.4 Ensure SSH access is limited (Automated)"
	sshd_config="/etc/ssh/sshd_config"
	allow_users_configured=0
	allow_groups_configured=0

	# Check if the SSHd configuration contains AllowUsers or AllowGroups directives
	if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -Pi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$'; then
		allow_users_configured=1
	fi

	if grep -rPi -q '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$' "$sshd_config"; then
		allow_groups_configured=1
    	fi
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}/etc/ssh/sshd_config${normal} file contains configuration specifications for ${bold}sshd${normal}. The command below sets the owner and group of the file to ${bold}root${normal}.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}allowusers <userlist>\nallowgroups <grouplist>\ndenyusers <userlist>\ndenygroups <grouplist>${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -Pi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$'
	grep -rPi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$' /etc/ssh/sshd_config*

	if ! [ "$allow_users_configured" -eq 1 ] || ! [ "$allow_groups_configured" -eq 1 ]; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}permissions are not configured, which does not meet the required criteria.\n\nThe ${bold}/etc/ssh/sshd_config${normal} file needs to be protected from unauthorized changes by non-privileged users.\n\n${yellow}Remidation: ${normal}\n1. Edit the ${bold}/etc/ssh/sshd_config${normal} file or a included configuration file to set one or more of the parameter as follows:\n\n${bold}AllowUsers <userlist>${normal}\nOR\n${bold}AllowGroups <grouplist>${normal}\nOR\n${bold}DenyUsers <userlist>${normal}\nOR\n${bold}DenyGroups <grouplist>${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.5
elif [[ $section == "5.2.5" ]]; then
	benchmark_title="5.2.5 Ensure SSH LogLevel is appropriate (Automated)"
	audit=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep loglevel)

	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}LogLevel ${normal}parameter is set to 2 variables; ${bold}INFO ${normal}and ${bold}VERBOSE ${normal}level.\n\n${bold}INFO ${normal}level is the basic level that only records login activity of SSH users. In many situations, such as\nIncident Response, it is important to determine when a particular user was active on a system. The logout record can eliminate those users who disconnected, which helps narrow the field.\n\n${bold}VERBOSE ${normal}level specifies that login and logout activity as well as the key fingerprint for any SSH key used\nfor login will be logged. This information is important for SSH key management, especially in legacy\nenvironments.\n\nWhen performing the audit, the output that should be shown is ${bold}loglevel INFO ${normal}or ${bold}loglevel VERBOSE ${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} $audit"

	if [[ ! "$output" == "loglevel INFO" ]] && [[ ! "$output" == "loglevel VERBOSE" ]]; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the\nrequired criteria by having the ${bold}LogLevel ${normal}not being set to ${bold}INFO${normal} or ${bold}VERBOSE${normal}, which is not recommended other than debugging SSH\ncommunications due to it being able to provide so much data that it is difficult to identify important security\ninformation.\n\nThis permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}LogLevel ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}DEBUG ${normal}to either a ${bold}INFO ${normal}or ${bold}VERBOSE ${normal}to appropriate the ${bold}LogLevel ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"

	# 5.2.6
elif [[ $section == "5.2.6" ]]; then
	benchmark_title="5.2.6 Ensure SSH PAM is enabled (Automated)"
	audit=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep usepam)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}UsePAM ${normal}directive enables the Pluggable Authentication Module (PAM) interface. If set to yes this will\nenable PAM authentication using ${bold}ChallengeResponseAuthentication ${normal}and ${bold}PasswordAuthentication ${normal}directives in addition to\nPAM account and session module processing for all authentication types.\n\nWhen performing the audit, the output that should be shown is ${bold}usepam yes ${normal}to allow PAM authentication while using SSH."

	# Output
	echo -e "\n${yellow}Output:${normal} $audit"

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "usepam\s*no"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the\nrequired criteria by having the ${bold}UsePAM ${normal}being set to ${bold}no${normal}.\n\nThis permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}UsePAM ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}no ${normal}to ${bold}yes ${normal}to enable the ${bold}UsePAM ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.7
elif [[ $section == "5.2.7" ]]; then
	benchmark_title="5.2.7 Ensure SSH root login is disabled (Automated)"
	audit=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitrootlogin)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}PermitRootLogin ${normal}parameter specifies if the root user can log in using SSH.\n\nWhen performing the audit, the output that should be shown is ${bold}permitrootlogin no ${normal}to not allow root login through SSH."

	# Output
	echo -e "\n${yellow}Output:${normal} $audit"

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "permitrootlogin\s*yes"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the\nrequired criteria by having the ${bold}PermitRootLogin ${normal}being set to ${bold}yes${normal}.\n\nThis permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}PermitRootLogin ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}yes ${normal}to ${bold}no ${normal}to disable the ${bold}PermitRootLogin ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 5.2.8
elif [[ $section == "5.2.8" ]]; then
	benchmark_title="5.2.8 Ensure SSH HostbasedAuthentication is disabled (Automated)"
	audit=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep hostbasedauthentication)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}HostbasedAuthentication ${normal}parameter specifies if authentication is allowed through trusted hosts via\nthe user of ${bold}.rhosts${normal}, or ${bold}/etc/hosts.equiv${normal}, along with successful public key client host authentication.\n\nWhen performing the audit, the output that should be shown is ${bold}hostbasedauthentication no ${normal}to not allow the user of\n${bold}.rhosts${normal}, or ${bold}/etc/hosts.equiv${normal}, along with successful public key client host authentication to have access through SSH."

	# Output
	echo -e "\n${yellow}Output:${normal} $audit"

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "hostbasedauthentication\s*yes"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the\nrequired criteria by having the ${bold}HostbasedAuthentication ${normal}being set to ${bold}yes${normal}.\n\nThis permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}HostbasedAuthentication ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}yes ${normal}to ${bold}no ${normal}to disable the ${bold}HostbasedAuthentication ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 5.2.9
elif [[ $section == "5.2.9" ]]; then
	benchmark_title="5.2.9 Ensure SSH PermitEmptyPasswords is disabled (Automated)"
	audit=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitemptypasswords)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}PermitEmptyPasswords ${normal}parameter specifies if the SSH server allows login to accounts with empty\npassword strings.\n\nWhen performing the audit, the output that should be shown is ${bold}permitemptypasswords no ${normal}to not allow any accounts that\nhave empty passwords strings."

	# Output
	echo -e "\n${yellow}Output:${normal} $audit"

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "permitemptypasswords\s*yes"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the\nrequired criteria by having the ${bold}PermitEmptyPasswords ${normal}being set to ${bold}yes${normal}, this permission could be used either\ninadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}PermitEmptyPasswords ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}yes ${normal}to ${bold}no ${normal}to disable the ${bold}PermitEmptyPasswords ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 5.2.10
elif [[ $section == "5.2.10" ]]; then
	benchmark_title="5.2.10 Ensure SSH PermitUserEnvironment is disabled (Automated)"
	audit=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permituserenvironment)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}PermitUserEnvironment ${normal}option allows users to present environment options to the SSH daemon.\n\nWhen performing the audit, the output that should be shown is ${bold}permituserenvironment no ${normal}to not allow any users to\npresent enviroment option through the SSH daemon."

	# Output
	echo -e "\n${yellow}Output:${normal} $audit"

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "permituserenvironment\s*yes"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the\nrequired criteria by having the ${bold}PermitUserEnvironment ${normal}being set to ${bold}yes${normal}, this permission could be used either\ninadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}PermitUserEnvironment ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}yes ${normal}to ${bold}no ${normal}to disable the ${bold}PermitUserEnvironment ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 5.2.11
elif [[ $section == "5.2.11" ]]; then
	benchmark_title="5.2.11 Ensure SSH IgnoreRhosts is disabled (Automated)"
	audit=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep ignorerhosts)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}IgnoreRhosts ${normal}parameter specifies that ${bold}.rhosts ${normal}and ${bold}.shosts ${normal}files will not be used in\n${bold}RhostsRSAAuthentication ${normal}or ${bold}HostbasedAuthentication${normal}.\n\nWhen performing the audit, the output that should be shown is ${bold}ignorerhosts no ${normal}to not allow any accounts that\nhave empty passwords strings."

	# Output
	echo -e "\n${yellow}Output:${normal} $audit"

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "ignorerhosts\s*yes"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the\nrequired criteria by having the ${bold}IgnoreRhosts ${normal}being set to ${bold}yes${normal}, this permission could be used either\ninadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}IgnoreRhosts ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}yes ${normal}to ${bold}no ${normal}to disable the ${bold}IgnoreRhosts ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 5.2.12
elif [[ $section == "5.2.12" ]]; then
	benchmark_title="5.2.12 Ensure SSH X11 forwarding is disabled (Automated)"
	audit=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep x11forwarding)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}X11Forwarding ${normal}parameter provides the ability to tunnel X11 traffic through the connection to enable\nremote graphic connections.\n\nWhen performing the audit, the output that should be shown is ${bold}x11forwarding no ${normal}to not allow remote graphic connections\nthrough SSH."

	# Output
	echo -e "\n${yellow}Output:${normal} $audit"

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "x11forwarding\s*yes"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the\nrequired criteria by having the ${bold}X11forwarding ${normal}being set to ${bold}yes${normal}, this permission could be used either\ninadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}X11forwarding ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}yes ${normal}to ${bold}no ${normal}to disable the ${bold}X11forwarding ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
          # 5.2.13
elif [[ $section == "5.2.13" ]]; then
	benchmark_title="5.2.13 Ensure only strong Ciphers are used (Automated)"
	sshd_config="/etc/ssh/sshd_config"
	benchmark_ciphers="chacha20-poly1305@openssh.com|aes256-gcm@openssh.com|aes128-gcm@openssh.com|aes256-ctr|aes192-ctr|aes128-ctr"

	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}This variable limits the ciphers that SSH can use during communication.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}chacha20-poly1305@openssh.com\naes256-gcm@openssh.com\naes128-gcm@openssh.com\naes256-ctr\naes192-ctr\naes128-ctr${normal}"

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep ciphers

	if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -E "ciphers\s+$benchmark_ciphers"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because weak ciphers are being used, which does not meet the required criteria.\n\nWeak ciphers that are used for authentication to the cryptographic module cannot be relied upon to provide confidentiality or integrity, and system data may be compromised.\n\n${yellow}Remidation: ${normal}\n1. Edit the ${bold}/etc/ssh/sshd_config${normal} file add/modify the Ciphers line to contain a comma separated list of the site approved ciphers.\nExample:\n\n${bold}Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.14
elif [[ $section == "5.2.14" ]]; then
	benchmark_title="5.2.14 Ensure only strong MAC algorithms are used (Automated)"
	sshd_config="/etc/ssh/sshd_config"
	benchmark_macs="hmac-sha2-512-etm@openssh.com|hmac-sha2-256-etm@openssh.com|hmac-sha2-512|hmac-sha2-256"

	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}This variable limits the types of MAC algorithms that SSH can use during communication.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}hmac-sha2-512-etm@openssh.com\nhmac-sha2-256-etm@openssh.com,\nmac-sha2-512\nhmac-sha2-256${normal}"

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i "MACs"

	if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -E "MACs\s+$benchmark_macs"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because weak MAC algorithms are being used, which does not meet the required criteria.\n\nMD5 and 96-bit MAC algorithms are considered weak and have been shown to increase exploitability in SSH downgrade attacks. Weak algorithms continue to have a great deal of attention as a weak spot that can be exploited with expanded computing power. An attacker that breaks the algorithm could take advantage of a MiTM position to decrypt the SSH tunnel and capture credentials and information.\n\n${yellow}Remidation: ${normal}\n1. Edit the ${bold}/etc/ssh/sshd_config${normal} file and add/modify the MACs line to contain a comma separated list of the site approved MACs.\nExample:\n\n${bold}MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 5.2.15
elif [[ $section == "5.2.15" ]]; then
	benchmark_title="5.2.15 Ensure only strong Key Exchange algorithms are used (Automated)"
	sshd_config="/etc/ssh/sshd_config"
	benchmark_keyx="curve25519-sha256|curve25519-sha256@libssh.org|diffie-hellman-group14-sha256|diffie-hellman-group16-sha512|diffie-hellman-group18-sha512|ecdh-sha2-nistp521|ecdh-sha2-nistp384|ecdh-sha2-nistp256|diffie-hellman-group-exchange-sha256"

	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Key exchange is any method in cryptography by which cryptographic keys are exchanged between two parties, allowing use of a cryptographic algorithm. If the sender and receiver wish to exchange encrypted messages, each must be equipped to encrypt messages to be sent and decrypt messages received.\n\nWhen performing the audit, the output that should be shown is\n\n${bold}curve25519-sha256\ncurve25519-sha256@libssh.org\ndiffie-hellman-group14-sha256\ndiffie-hellman-group16-sha512\ndiffie-hellman-group18-sha512\necdh-sha2-nistp521\necdh-sha2-nistp384\necdh-sha2-nistp256\ndiffie-hellman-group-exchange-sha256${normal}"

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep kexalgorithms

	if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -E "kexalgorithms\s+$benchmark_keyx"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because weak Key Exchange algorithms are being used, which does not meet the required criteria.\n\nKey exchange methods that are considered weak should be removed. A key exchange method may be weak because too few bits are used, or the hashing algorithm is considered too weak. Using weak algorithms could expose connections to man-in-the-middle attacks.\n\n${yellow}Remidation: ${normal}\n1. Edit the ${bold}/etc/ssh/sshd_config${normal} file and add/modify the KexAlgorithms line to contain a comma separated list of the site approved key exchange algorithms.\nExample:\n\n${bold}KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.16
elif [[ $section == "5.2.16" ]]; then
	benchmark_title="5.2.16 Ensure SSH AllowTcpForwarding is disabled (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}SSH port forwarding is a mechanism in SSH for tunneling application ports from the client to the server, or servers to clients. It can be used for adding encryption to legacy applications, going through firewalls, and some system administrators and IT professionals use it for opening backdoors into the internal network from their home machines.\n\nWhen performing the audit, the output that should be shown is ${bold}allowtcpforwarding no${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i allowtcpforwarding

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "allowtcpforwarding\s*yes"; then
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the required criteria by having the ${bold}AllowTcpForwarding ${normal}being set to ${bold}yes${normal}, this permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}AllowTcpForwarding ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}yes ${normal}to ${bold}no ${normal}to disable the ${bold}AllowTcpForwarding ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.17
elif [[ $section == "5.2.17" ]]; then
	benchmark_title="5.2.17 Ensure SSH warning banner is configured (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}Banner${normal} parameter specifies a file whose contents must be sent to the remote user before authentication is permitted. By default, no banner is displayed.\n\nWhen performing the audit, the output that should be shown is ${bold}banner /etc/issue.net${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep banner

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "banner\s*/etc/issue.net"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the required criteria by having the ${bold}Banner ${normal}being set to ${bold}none${normal}, this permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}Banner ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the ${bold}none ${normal}to ${bold}/etc/issue.net ${normal}to change the ${bold}Banner ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.18
elif [[ $section == "5.2.18" ]]; then
	benchmark_title="5.2.18 Ensure SSH MaxAuthTries is set to 4 or less (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}MaxAuthTries${normal} parameter specifies the maximum number of authentication attempts permitted per connection. When the login failure count reaches half the number, error messages will be written to the ${bold}syslog${normal} file detailing the login failure.\n\nWhen performing the audit, the output that should be shown is ${bold}maxauthtries 4${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep maxauthtries

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "maxauthtries\s*4"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the required criteria by having the ${bold}MaxAuthTries ${normal}not being set correctly, this permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}MaxAuthTries ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the number to ${bold}4 or less ${normal}to change the ${bold}MaxAuthTries ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.19
elif [[ $section == "5.2.19" ]]; then
	benchmark_title="5.2.19 Ensure SSH MaxStartups is configured (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}MaxStartups${normal} parameter specifies the maximum number of concurrent unauthenticated connections to the SSH daemon.\n\nWhen performing the audit, the output that should be shown is ${bold}maxstartups 10:30:60${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxstartups

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "maxstartups\s*10:30:60"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the required criteria by having the ${bold}MaxStartups ${normal}not being set correctly, this permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}MaxStartups ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the number to ${bold}10:30:60 ${normal}to change the ${bold}MaxStartups ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.20
elif [[ $section == "5.2.20" ]]; then
	benchmark_title="5.2.20 Ensure SSH MaxSessions is set to 10 or less (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}MaxSessions${normal} parameter specifies the maximum number of open sessions permitted from a given connection.\n\nWhen performing the audit, the output that should be shown is ${bold}maxsessions 10${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxsessions

	if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "maxsessions\s*10"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the required criteria by having the ${bold}MaxSessions ${normal}not being set correctly, this permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}MaxSessions ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the number to ${bold}10 ${normal}to change the ${bold}MaxSessions ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.21
elif [[ $section == "5.2.21" ]]; then
	benchmark_title="5.2.21 Ensure SSH LoginGraceTime is set to one minute or less (Automated)"
	expected_min_login_grace_time=1
	expected_max_login_grace_time=60
	sshd_config="/etc/ssh/sshd_config"
	
	# Get the current LoginGraceTime setting from sshd_config
	login_grace_time=$(sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -Ei "logingracetime\s*[0-9]+[m]?" | awk '{print $2}' | tr -d 'm')
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}LoginGraceTime${normal} parameter specifies the time allowed for successful authentication to the SSH server. The longer the Grace period is the more open unauthenticated connections can exist. Like other session controls in this session the Grace Period should be limited to appropriate organizational limits to ensure the service is available for needed access.\n\nWhen performing the audit, the output that should be shown is ${bold}logingracetime 60${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i logingracetime

	if [[ "$login_grace_time" =~ ^[0-9]+$ ]] && ((login_grace_time >= expected_min_login_grace_time)) && ((login_grace_time <= expected_max_login_grace_time)); then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the required criteria by having the ${bold}LoginGraceTime ${normal}not being set correctly, this permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}LoginGraceTime ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the number to ${bold}60 ${normal}to change the ${bold}LoginGraceTime ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.2.22
elif [[ $section == "5.2.22" ]]; then
	benchmark_title="5.2.22 Ensure SSH Idle Timeout Interval is configured (Automated)"

	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The two options ${bold}ClientAliveInterval${normal} and ${bold}ClientAliveCountMax${normal} control the timeout of SSH sessions.\n\nWhen performing the audit, the output that should be shown is ${bold}clientaliveinterval 15\nclientalivecountmax 3${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i clientaliveinterval
	sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep clientalivecountmax

	if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "clientaliveinterval\s*15" && sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "clientalivecountmax\s*3"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/ssh/sshd_config ${normal}file does not meet the required criteria by having the ${bold}ClientAliveInterval${normal} and ${bold}ClientAliveCountMax ${normal}not being set correctly, this permission could be used either inadvertently or through malicious intent.\n\n${yellow}Remidation: ${normal}\n1. Access the sshd_config file by using the command ${bold}vim /etc/ssh/sshd_config ${normal}\n2. Scroll down until you see the ${bold}ClientAliveInterval${normal} and ${bold}ClientAliveCountMax ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Change the number to ${bold}15 ${normal}and ${bold}3 ${normal}to change the ${bold}ClientAliveInterval${normal} and ${bold}ClientAliveCountMax ${normal}parameter respectively\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.3.1
elif [[ $section == "5.3.1" ]]; then
	benchmark_title="5.3.1 Ensure sudo is installed (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}sudo${normal} allows a permitted user to execute a command as the superuser or another user, as specified by the security policy. The invoking user's real (not effective) user ID is used to determine the user name with which to query the security policy.\n\nWhen performing the audit, the output that should show ${bold}sudo${normal} or ${bold}sudo-ldap${normal} in installed."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	dpkg-query -W sudo sudo-ldap
	
	if ! dpkg-query -W sudo sudo-ldap > /dev/null 2>&1; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}sudo ${normal}is not installed, which does not meet the required criteria.\n\n${bold}sudo${normal} supports a plug-in architecture for security policies and input/output logging. Third parties can develop and distribute their own policy and I/O logging plug-ins to work seamlessly with the ${bold}sudo${normal} front end. The default security policy is sudoers, which is configured via the file ${bold}/etc/sudoers${normal} and any entries in ${bold}/etc/sudoers.d${normal}.\n\nThe security policy determines what privileges, if any, a user has to run ${bold}sudo${normal}. The policy may require that users authenticate themselves with a password or another authentication mechanism. If authentication is required, ${bold}sudo${normal} will exit if the user's password is not entered within a configurable time limit. This limit is policy-specific.\n\n${yellow}Remidation: ${normal}\n1. First determine is LDAP functionality is required. If so, then install ${bold}sudo-ldap${normal}, else install ${bold}sudo${normal}.\n\n${bold}apt install sudo${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.3.2
elif [[ $section == "5.3.2" ]]; then
	benchmark_title="5.3.2 Ensure sudo commands use pty (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}sudo${normal} acan be configured to run only from a pseudo terminal.\n\nWhen performing the audit, the output that should show ${bold}/etc/sudoers:Defaults use_pty${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep -rPi '^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*
	
	if ! grep -rPi -q '^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}sudo ${normal}command does not use pty, which does not meet the required criteria.\n\nAttackers can run a malicious program using ${bold}sudo${normal} which would fork a background process that remains even when the main program has finished executing.\n\n${yellow}Remidation: ${normal}\n1. Edit the file /etc/sudoers with visudo or a file in /etc/sudoers.d/ with visudo -f <PATH TO FILE> and add the following line:\n\n${bold}Defaults use_pty${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.3.3
elif [[ $section == "5.3.3" ]]; then
	benchmark_title="5.3.3 Ensure sudo log file exists (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}A sudo log file simplifies auditing of sudo commands.\n\nWhen performing the audit, the output that should show ${bold}Defaults logfile="/var/log/sudo.log"${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep -rPsi "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers*
	
	if ! grep -rPsi -q "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|')?\H+(\"|')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers*; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}sudo ${normal}log file dows not exist, which does not meet the required criteria.\n\nA sudo log file simplifies auditing of sudo commands.\n\n${yellow}Remidation: ${normal}\n1. Edit the file /etc/sudoers or a file in /etc/sudoers.d/ with visudo or visudo -f <PATH TO FILE> and add the following line:\n\n${bold}Defaults logfile="/var/log/sudo.log"${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.3.4
elif [[ $section == "5.3.4" ]]; then
	benchmark_title="5.3.4 Ensure users must provide password for privilege escalation (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The operating system must be configured so that users must provide a password for privilege escalation.\n\nWhen performing the audit, the output that should show nothing."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep -r "^[^#].*NOPASSWD" /etc/sudoers*
	
	if grep -r "^[^#].*NOPASSWD" /etc/sudoers*; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the password is not provided to users to privilege escalate, which does not meet the required criteria.\n\nWithout (re-)authentication, users may access resources or perform tasks for which they do not have authorization.\n\nWhen operating systems provide the capability to escalate a functional capability, it is critical the user (re-)authenticate.\n\n${yellow}Remidation: ${normal}\n1. Based on the outcome of the audit procedure, use visudo -f <PATH TO FILE> to edit the relevant sudoers file.\n\n2. Remove any line with occurrences of NOPASSWD tags in the file.\n\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.3.5
elif [[ $section == "5.3.5" ]]; then
	benchmark_title="5.3.5 Ensure re-authentication for privilege escalation is not disabled globally (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The operating system must be configured so that users must re-authenticate for privilege escalation.\n\nWhen performing the audit, the output that should show nothing."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep -r "^[^#].*\!authenticate" /etc/sudoers*
	
	if grep -r "^[^#].*\!authenticate" /etc/sudoers*; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the re-authentication for privilege escalation is disabled globally, which does not meet the required criteria.\n\nWithout re-authentication, users may access resources or perform tasks for which they do not have authorization.\n\nWhen operating systems provide the capability to escalate a functional capability, it is critical the user re-authenticate.\n\n${yellow}Remidation: ${normal}\n1. Based on the outcome of the audit procedure, use visudo -f <PATH TO FILE> to edit the relevant sudoers file.\n\n2. Remove any occurrences of !authenticate tags in the file(s).\n\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.3.6
elif [[ $section == "5.3.6" ]]; then
	benchmark_title="5.3.6 Ensure sudo authentication timeout is configured correctly (Automated)"
	sudo_timeout=$(grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers* | sort -n | head -1)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}sudo${normal} caches used credentials for a default of 15 minutes. This is for ease of use when there are multiple administrative tasks to perform. The timeout can be modified to suit local security policies.\n\nThis default is distribution specific. See audit section for further information.\n\nWhen performing the audit, the output that should show nothing."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers*
	sudo -V | grep "Authentication timestamp timeout:"
	
	if [[ -z "$sudo_timeout" ]] || [[ $sudo_timeout =~ ^[0-9]+$ && $sudo_timeout -le 900 ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the sudo authentication timeout is not configured correctly, which does not meet the required criteria.\n\nSetting a timeout value reduces the window of opportunity for unauthorized privileged access to another user.\n\n${yellow}Remidation: ${normal}\n1. If the currently configured timeout is larger than 15 minutes, edit the file listed in the audit section with visudo -f <PATH TO FILE> and modify the entry timestamp_timeout= to 15 minutes or less as per your site policy. The value is in minutes. This particular entry may appear on its own, or on the same line as env_reset.\n\n${bold}Defaults	timestamp_timeout=15\nDefaults	env_reset${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.3.7
elif [[ $section == "5.3.7" ]]; then
	benchmark_title="5.3.7 Ensure access to the su command is restricted (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}su${normal} command allows a user to run a command or shell as another user. The program has been superseded by ${bold}sudo${normal}, which allows for more granular control over privileged access. Normally, the ${bold}su${normal} command can be executed by any user. By uncommenting the ${bold}pam_wheel.so${normal} statement in ${bold}/etc/pam.d/su${normal}, the ${bold}su${normal} command will only allow users in a specific groups to execute su. This group should be empty to reinforce the use of sudo for privileged access.\n\nWhen performing the audit, the output that should show ${bold}auth required pam_wheel.so use_uid group=<group_name>${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su
	
	if ! grep -Pi -q '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because access to the su command is not restricted, which does not meet the required criteria.\n\nRestricting the use of ${bold}su${normal}, and using ${bold}sudo${normal} in its place, provides system administrators better control of the escalation of user privileges to execute privileged commands. The sudo utility also provides a better logging and audit mechanism, as it can log each command executed via ${bold}sudo${normal}, whereas ${bold}su${normal} can only record that a user executed the ${bold}su${normal} program.\n\n${yellow}Remidation: ${normal}\n1. Create an empty group that will be specified for use of the su command. The group should be named according to site policy.\n\n${bold}groupadd sugroup${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.4.1
elif [[ $section == "5.4.1" ]]; then
	benchmark_title="5.4.1 Ensure password creation requirements are configured (Automated)"
	# Check minlen in pwquality.conf
	minlen=$(grep '^\s*minlen\s*' /etc/security/pwquality.conf | awk '{print $3}')
	# Check minclass in pwquality.conf
	minclass=$(grep '^\s*minclass\s*' /etc/security/pwquality.conf | awk '{print $3}')
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}pam_pwquality.so${normal} module checks the strength of passwords. It performs checks such as making sure a password is not a dictionary word, it is a certain length, contains a mix of characters (e.g. alphabet, numeric, other) and more.\n\nWhen performing the audit, the output that should show ${bold}minlen = 14${normal} and ${bold}minclass = 4${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep '^\s*minlen\s*' /etc/security/pwquality.conf
	grep '^\s*minclass\s*' /etc/security/pwquality.conf
	
	if ! [[ "$minlen" -eq 14 && "$minclass" -eq 4 ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because password creation requirements are not configured, which does not meet the required criteria.\n\nStrong passwords protect systems from being hacked through brute force methods.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to install the pam_pwquality module:\n\n${bold}apt install libpam-pwquality${normal}\n\n2. Edit the file ${bold}/etc/security/pwquality.conf${normal} and add or modify the following line for password length to conform to site policy:\n\n${bold}minlen = 14${normal}\n\n3. Edit the file ${bold}/etc/security/pwquality.conf${normal} and add or modify the following line for password complexity to conform to site policy:\n\n${bold}minclass = 4${normal}\n\n4. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.4.2
elif [[ $section == "5.4.2" ]]; then
	benchmark_title="5.4.2 Ensure lockout for failed password attempts is configured (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Lock out users after n unsuccessful consecutive login attempts. The first sets of changes are made to the common PAM configuration files. The second set of changes are applied to the program specific PAM configuration file. The second set of changes must be applied to each program that will lock out users. Check the documentation for each secondary program for instructions on how to configure them to work with PAM.\n\nWhen performing the audit, the output that should show ${bold}pam_faillock.so${normal} to be configured in ${bold}/etc/pam.d/common-auth${normal}, ${bold}/etc/pam.d/common-account${normal} and ${bold}/etc/security/faillock.conf${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep "pam_faillock.so" /etc/pam.d/common-auth
	grep "pam_faillock.so" /etc/pam.d/common-account
	awk '/^ *deny *=/\
	||/^ *fail_interval *=/\
	||/^ *unlock_time *=/' /etc/security/faillock.conf
	
	if grep -q "pam_faillock.so" /etc/pam.d/common-auth && grep -q "pam_faillock.so" /etc/pam.d/common-account; then
		# Check faillock configuration in faillock.conf
		deny=$(awk '/^ *deny *=/{print $3}' /etc/security/faillock.conf)
		fail_interval=$(awk '/^ *fail_interval *=/{print $3}' /etc/security/faillock.conf)
		unlock_time=$(awk '/^ *unlock_time *=/{print $3}' /etc/security/faillock.conf)

		# Check if settings follow local site policy
		if ! [[ "$deny" -le 4 && "$fail_interval" -le 900 && "$unlock_time" -eq 0 || "$unlock_time" -ge 600 ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because lockout for failed password attempts is not configured, which does not meet the required criteria.\n\nSLocking out user IDs after n unsuccessful consecutive login attempts mitigates brute force password attacks against your systems.\n\n${yellow}Remidation: ${normal}\n1. Edit /etc/pam.d/common-auth and ensure that faillock is configured:\n\n${bold}# here are the per-package modules (the "Primary" block)\nauth	required	pam_faillock.so preauth # Added to enable faillock\nauth	[success=1 default=ignore]	pam_unix.so nullok\nauth	[default=die]	pam_faillock.so authfail # Added to enable faillock\nauth	sufficient	pam_faillock.so authsucc # Added to enable faillock${normal}\n\n2. Edit /etc/pam.d/common-account and ensure that the following stanza is at the end of the file:\n\n${bold}account	required	pam_faillock.so${normal}\n\n3. Edit /etc/security/faillock.conf and configure it per your site policy:\n\n${bold}deny = 4\nfail_interval = 900\nunlock time = 600${normal}\n\n4. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		else
			echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
		fi
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because lockout for failed password attempts is not configured, which does not meet the required criteria.\n\nSLocking out user IDs after n unsuccessful consecutive login attempts mitigates brute force password attacks against your systems.\n\n${yellow}Remidation: ${normal}\n1. Edit /etc/pam.d/common-auth and ensure that faillock is configured:\n\n${bold}# here are the per-package modules (the "Primary" block)\nauth	required	pam_faillock.so preauth # Added to enable faillock\nauth	[success=1 default=ignore]	pam_unix.so nullok\nauth	[default=die]	pam_faillock.so authfail # Added to enable faillock\nauth	sufficient	pam_faillock.so authsucc # Added to enable faillock${normal}\n\n2. Edit /etc/pam.d/common-account and ensure that the following stanza is at the end of the file:\n\n${bold}account	required	pam_faillock.so${normal}\n\n3. Edit /etc/security/faillock.conf and configure it per your site policy:\n\n${bold}deny = 4\nfail_interval = 900\nunlock time = 600${normal}\n\n4. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.4.3
elif [[ $section == "5.4.3" ]]; then
	benchmark_title="5.4.3 Ensure password reuse is limited (Automated)"
	remember_value=$(grep -Po '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?remember=\K([5-9]|[1-9][0-9]+)' /etc/pam.d/common-password)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}/etc/security/opasswd${normal} file stores the users' old passwords and can be checked to ensure that users are not recycling recent passwords.\n\nWhen performing the audit, the output that should show\n${bold}password	[success=1 default=ignore]	pam_unix.so obscure\nuse_authtok try_first_pass yescrypt remember=5${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep -P '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?remember=([5-9]|[1-9][0-9]+)\b' /etc/pam.d/common-password
	
	if ! grep -Pq '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?remember=([5-9]|[1-9][0-9]+)\b' /etc/pam.d/common-password && ! [[ "$remember_value" -ge 5 ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because password reuse is not limited, which does not meet the required criteria.\n\nForcing users not to reuse their past 5 passwords make it less likely that an attacker will be able to guess the password.\n\n${yellow}Remidation: ${normal}\n1. Edit the /etc/pam.d/common-password file to include the remember option and conform to site policy as shown:\n\n${bold}password	[success=1 default=ignore]	pam_unix.so obscure\nuse_authtok try_first_pass yescrypt remember=5${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.4.4
elif [[ $section == "5.4.4" ]]; then
	benchmark_title="5.4.4 Ensure password hashing algorithm is up to date with the latest standards (Automated)"
	common_password_output=$(grep -v '^#' /etc/pam.d/common-password | grep -E "(yescrypt|md5|bigcrypt|sha256|sha512|blowfish)")
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The commands below change password encryption to ${bold}yescrypt${normal}. All existing accounts will need to perform a password change to upgrade the stored hashes to the new algorithm.\n\nWhen performing the audit, the output that should show ${bold}ENCRYPT_METHOD yescrypt${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep -v ^# /etc/pam.d/common-password | grep -E "(yescrypt|md5|bigcrypt|sha256|sha512|blowfish)"
	grep -i "^\s*ENCRYPT_METHOD\s*yescrypt\s*$" /etc/login.defs
	
	if ! [[ -z "$common_password_output" ]] && ! grep -qi "^\s*ENCRYPT_METHOD\s*yescrypt\s*$" /etc/login.defs; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because password hashing algorithm is not up to date with the latest standards, which does not meet the required criteria.\n\nThe ${bold}yescrypt${normal} algorithm provides much stronger hashing than previous available algorithms, thus providing additional protection to the system by increasing the level of effort for an attacker to successfully determine passwords.\n\n${yellow}Remidation: ${normal}\n1. Edit the /etc/pam.d/common-password file and ensure that no hashing algorithm option for pam_unix.so is set:\n\n${bold}password	[success=1 default=ignore]	pam_unix.so obscure\nuse_authtok try_first_pass remember=5${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.4.5
elif [[ $section == "5.4.5" ]]; then
	benchmark_title="5.4.5 Ensure all current passwords uses the configured hashing algorithm (Manual)"
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

	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}TCurrently used passwords with out of date hashing algorithms may pose a security risk to the system.\n\nWhen performing the audit, the output that should show nothing."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	
	
	for MY_USER in $(sed -n "s/^\(.*\):\\$.*/\1/p" /etc/shadow); do
		CURRENT_HASH=$(sed -n "s/${MY_USER}:\\$\(.\).*/\1/p" /etc/shadow)
	done
	
	if ! [[ "${HASH_MAP["${CURRENT_HASH}"]^^}" != "${CONFIGURED_HASH^^}" ]]; then
		has_mismatch=true
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because all current passwords does not use the configured hashing algorithm, which does not meet the required criteria.\n\nIf the administrator forces a password change, this could cause a large spike in CPU usage if a large number of users change their password during the same time.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 701 as shown:\n"
echo '#!/usr/bin/env bash
{
	UID_MIN=$(awk ''/^\s*UID_MIN/{print $2}'' /etc/login.defs)
	awk -F: -v UID_MIN="${UID_MIN}" ''( $3 >= UID_MIN && $1 != "nfsnobody" ) { print $1 }'' /etc/passwd | xargs -n 1 chage -d 0
}'
		
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
	
	if ! $has_mismatch; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.5.1.1
elif [[ $section == "5.5.1.1" ]]; then
	benchmark_title="5.5.1.1 Ensure minimum days between password changes is configured (Automated)"
	min_days=$(grep -Ei "^\s*PASS_MIN_DAYS\s+" /etc/login.defs | awk '{print $2}')
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}PASS_MIN_DAYS${normal} parameter in ${bold}/etc/login.defs${normal} allows an administrator to prevent users from changing their password until a minimum number of days have passed since the last time the user changed their password. It is recommended that ${bold}PASS_MIN_DAYS${normal} parameter be set to 1 or more days.\n\nWhen performing the audit, the output that should show\n${bold}PASS_MIN_DAYS 1${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep PASS_MIN_DAYS /etc/login.defs
	awk -F : '(/^[^:]+:[^!*]/ && $4 < 1){print $1 " " $4}' /etc/shadow
	
	
	if [[ -z "$min_days" ]] || ! [[ "$min_days" -ge 1 ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because minimum days between password changes is not configured properly, which does not meet the required criteria.\n\nBy restricting the frequency of password changes, an administrator can prevent users from repeatedly changing their password in an attempt to circumvent password reuse controls.\n\n${yellow}Remidation: ${normal}\n1. Set the ${bold}PASS_MIN_DAYS${normal} parameter to 1 in ${bold}/etc/login.defs${normal}:\n\n${bold}PASS_MIN_DAYS 1${normal}\n\n2. Modify user parameters for all users with a password set to match:\n\n${bold}chage --mindays 1 <user>${normal}\n\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 5.5.1.2
elif [[ $section == "5.5.1.2" ]]; then
	benchmark_title="5.5.1.2 Ensure password expiration is 365 days or less (Automated)"
	max_days=$(grep -Ei "^\s*PASS_MAX_DAYS\s+" /etc/login.defs | awk '{print $2}')
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}PASS_MAX_DAYS${normal} parameter in ${bold}/etc/login.defs${normal} allows an administrator to force passwords to expire once they reach a defined age.\n\nWhen performing the audit, the output that should show\n${bold}PASS_MAX_DAYS 365 or less${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep PASS_MAX_DAYS /etc/login.defs
	awk -F: '(/^[^:]+:[^!*]/ && ($5>365 || $5~/([0-1]|-1|\s*)/)){print $1 " " $5}' /etc/shadow
	
	
	if [[ -z "$max_days" ]] || ! [[ "$max_days" -le 365 && "$max_days" -gt 0 ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because password expiration is more than 365 days, which does not meet the required criteria.\n\nThe window of opportunity for an attacker to leverage compromised credentials or successfully compromise credentials via an online brute force attack is limited by the age of the password. Therefore, reducing the maximum age of a password also reduces an attacker's window of opportunity. It is recommended that the ${bold}PASS_MAX_DAYS${normal} parameter does not exceed ${bold}365${normal} days and is greater than the value of ${bold}PASS_MIN_DAYS${normal}.\n\n${yellow}Remidation: ${normal}\n1. Set the ${bold}PASS_MAX_DAYS${normal} parameter to conform to site policy in ${bold}/etc/login.defs${normal}:\n\n${bold}PASS_MAX_DAYS 365${normal}\n\n2. Modify user parameters for all users with a password set to match:\n\n${bold}chage --maxdays 365 <user>${normal}\n\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.5.1.3
elif [[ $section == "5.5.1.3" ]]; then
	benchmark_title="5.5.1.3 Ensure password expiration warning days is 7 or more (Automated)"
	warn_age=$(grep -Ei "^\s*PASS_WARN_AGE\s+" /etc/login.defs | awk '{print $2}')
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}PASS_WARN_DAYS${normal} parameter in ${bold}/etc/login.defs${normal} allows an administrator to notify users that their password will expire in a defined number of days. It is recommended that the ${bold}PASS_WARN_AGE${normal} parameter be set to 7 or more days.\n\nWhen performing the audit, the output that should show\n${bold}PASS_WARN_AGE 7${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep PASS_WARN_AGE /etc/login.defs
	awk -F: '(/^[^:]+:[^!*]/ && $6<7){print $1 " " $6}' /etc/shadow
	
	
	if [[ -z "$warn_age" ]] || ! [[ "$warn_age" -ge 7 ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because password expiration warning days is not 7 or more, which does not meet the required criteria.\n\nProviding an advance warning that a password will be expiring gives users time to think of a secure password. Users caught unaware may choose a simple password or write it down where it may be discovered.\n\n${yellow}Remidation: ${normal}\n1. Set the ${bold}PASS_WARM_DAYS${normal} parameter to 7 in ${bold}/etc/login.defs${normal}:\n\n${bold}PASS_WARN_AGE 7${normal}\n\n2. Modify user parameters for all users with a password set to match:\n\n${bold}chage --warndays 7 <user>${normal}\n\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.5.1.4
elif [[ $section == "5.5.1.4" ]]; then
	benchmark_title="5.5.1.4 Ensure inactive password lock is 30 days or less (Automated)"
	inactive_default=$(useradd -D | grep INACTIVE | awk -F'=' '{print $2}')
	users_with_inactive=$(awk -F: '($7~/^\s*$|-1/ || $7>30) && /^[^:]+:[^!*]/ {print $1 " " $7}' /etc/shadow)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}User accounts that have been inactive for over a given period of time can be automatically disabled. It is recommended that accounts that are inactive for 30 days after password expiration be disabled.\n\nWhen performing the audit, the output that should show\n${bold}INACTIVE=30${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	useradd -D | grep INACTIVE
	awk -F: '(/^[^:]+:[^!*]/ && ($7~/(\\s*$|-1)/ || $7>30)){print $1 " " $7}' /etc/shadow
	
	
	if [[ -z "$inactive_default" ]] || ! [[ "$inactive_default" -le 30 && -z "$users_with_inactive" ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because inactive password lock is not 30 days or less, which does not meet the required criteria.\n\nInactive accounts pose a threat to system security since the users are not logging in to notice failed login attempts or other anomalies.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to set the default password inactivity period to 30 days:\n\n${bold}useradd -D -f 30${normal}\n\n2. Modify user parameters for all users with a password set to match:\n\n${bold}chage --inactive 30 <user>${normal}\n\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.5.1.5
elif [[ $section == "5.5.1.5" ]]; then
	benchmark_title="5.5.1.5 Ensure all users last password change date is in the past (Automated)"
	current_date=$(date +%s)
	users_list=$(cut -d: -f1 /etc/passwd)
	for user in $users_list; do
		# Get the password change date for the user in seconds since epoch
		password_change_date=$(chage -l "$user" | grep "Last password change" | awk '{print $NF}')
		password_change_date_in_seconds=$(date -d "$password_change_date" +%s)
	done
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}All users should have a password change date in the past.\n\nWhen performing the audit, the output that should show nothing."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	awk -F: '/^[^:]+:[^!*]/{print $1}' /etc/shadow | while read -r usr;
	do
		change=$(date -d "$(chage --list $usr | grep '^Last password change' | cut -d: -f2 | grep -v 'never$')" +%s);
		if [[ "$change" -gt "$(date +%s)" ]]; then
			echo "User: \"$usr\" last password change was \"$(chage --list $usr | grep '^Last password change' | cut -d: -f2)\"";
		fi;
	done

	
	if [[ $password_change_date_in_seconds -ge $current_date ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because all users last password change date is not in the past, which does not meet the required criteria.\n\nIf a users recorded password change date is in the future then they could bypass any set password expiration.\n\n${yellow}Remidation: ${normal}\n1. Investigate any users with a password change date in the future and correct them. Locking the account, expiring the password, or resetting the password manually may be appropriate.\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.5.2
elif [[ $section == "5.5.2" ]]; then
	benchmark_title="5.5.2 Ensure system accounts are secured (Automated)"
	uid_min=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
	invalid_accounts=$(awk -F: '$1!~/(root|sync|shutdown|halt|^\+)/ && $3<'"$uid_min"' && $7!~/((\/usr)?\/sbin\/nologin)/ && $7!~/(\/bin)?\/false/ {print}' /etc/passwd)
	locked_accounts=$(awk -F: '($1!~/(root|^\+)/ && $3<'"$uid_min"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!~/LK?/) {print $1}')
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}There are a number of accounts provided with most distributions that are used to manage applications and are not intended to provide an interactive shell.\n\nWhen performing the audit, the output that should show nothing."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	awk -F: '$1!~/(root|sync|shutdown|halt|^\+)/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $7!~/((\/usr)?\/sbin\/nologin)/ && $7!~/(\/bin)?\/false/ {print}' /etc/passwd
	awk -F: '($1!~/(root|^\+)/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!~/LK?/) {print $1}'

	
	if [[ -z "$invalid_accounts" ]] && [[ -z "$locked_accounts" ]]; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the system accounts are not secured, which does not meet the required criteria.\n\nIt is important to make sure that accounts that are not being used by regular users are prevented from being used to provide an interactive shell. By default, most distributions set the password field for these accounts to an invalid string, but it is also recommended that the shell field in the password file be set to the ${bold}nologin${normal} shell. This prevents the account from potentially being used to run any commands.\n\n${yellow}Remidation: ${normal}\n1. Set the shell for any accounts returned by the audit to nologin:\n\n${bold}usermod -s $(which nologin) <user>${normal}\n\n2. Lock any non root accounts returned by the audit:\n\n${bold}usermod -L <user>${normal}\n\n3. The following command will set all system accounts to a non login shell:\n\n${bold}"
		echo 'awk -F: ''$1!~/(root|sync|shutdown|halt|^\+)/ && $3<''"$(awk' '/^\s*UID_MIN/{print $2}'' /etc/login.defs)"' '&& $7!~/((\/usr)?\/sbin\/nologin)/ && $7!~/(\/bin)?\/false/ {print $1}'' /etc/passwd | while read -r user; do usermod -s "$(which nologin)" "$user"; done'
		echo -e "${normal}\n\n4. The following command will automatically lock not root system accounts:\n\n${bold}"
		echo 'awk -F: ''($1!~/(root|^\+)/ && $3<''"$(awk' '/^\s*UID_MIN/{print $2}'' /etc/login.defs)"'') {print '$1'} /etc/passwd | xargs -I '{}' passwd -S '{}' | awk ''($2!~/LK?/) {print $1}'' | while read -r user; do usermod -L "$user"; done'
		echo -e "${normal}\n\n5. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.5.3
elif [[ $section == "5.5.3" ]]; then
	benchmark_title="5.5.3 Ensure default group for the root account is GID 0 (Automated)"
	root_group=$(grep "^root:" /etc/passwd | cut -f4 -d:)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The usermod command can be used to specify which group the root user belongs to. This affects permissions of files that are created by the root user.\n\nWhen performing the audit, the output that should show ${bold}0${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	grep "^root:" /etc/passwd | cut -f4 -d:
	
	if ! [[ "$root_group" -eq 0 ]]; then
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the default group for the root account is not GID 0, which does not meet the required criteria.\n\nUsing GID 0 for the ${bold}root${normal} account helps prevent ${bold}root${normal} -owned files from accidentally becoming accessible to non-privileged users.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to set the ${bold}root${normal} user default group to GID ${bold}0${normal}:\n\n${bold}usermod -g 0 root${normal}\n\n2. Remove any line with occurrences of NOPASSWD tags in the file.\n\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.5.4
elif [[ $section == "5.5.4" ]]; then
	benchmark_title="5.5.4 Ensure default user umask is 027 or more restrictive (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The user file-creation mode mask (${bold}umask${normal}) is use to determine the file permission for newly created directories and files. In Linux, the default permissions for any newly created directory is 0777 (rwxrwxrwx), and for any newly created file it is 0666 (rw-rw-rw-). The ${bold}umask${normal} modifies the default Linux permissions by restricting (masking) these permissions. The ${bold}umask${normal} is not simply subtracted, but is processed bitwise. Bits set in the ${bold}umask${normal} are cleared in the resulting file mode.\n\nWhen performing the audit, the output that should show ${bold}0${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	passing=""; grep -Eiq '^\s*UMASK\s+(0[0-7][2-7]7|[0-7][2-7]7)\b' /etc/login.defs && grep -Eqi '^\s*USERGROUPS_ENAB\s*"?no"?\b' /etc/login.defs && grep -Eq '^\s*session\s+(optional|requisite|required)\s+pam_umask\.so\b' /etc/pam.d/common-session && passing=true; grep -REiq '^\s*UMASK\s+\s*(0[0-7][2-7]7|[0-7][2-7]7|u=(r?|w?|x?)(r?|w?|x?)(r?|w?|x?),g=(r?x?|x?r?),o=)\b' /etc/profile* /etc/bash.bashrc* && passing=true; [ "$passing" = true ] && echo "Default user umask is set"
	
	# Check if the default user umask is 027 or more restrictive
	if grep -Eiq '^\s*UMASK\s+(0[0-7][2-7]7|[0-7][2-7]7)\b' /etc/login.defs; then
		# Check if newly created directories have permissions 750
		if [ "$(umask)" == "0027" ]; then
			mkdir -p /tmp/umask_test_dir
			touch /tmp/umask_test_file
			dir_perms="$(stat -c '%a' /tmp/umask_test_dir)"
			file_perms="$(stat -c '%a' /tmp/umask_test_file)"

			if [ "$dir_perms" == "750" ] && [ "$file_perms" == "640" ]; then
				echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
			else
				echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the default user umask is not 027 or more restrictive, which does not meet the required criteria.\n\nSetting a very secure default value for ${bold}umask${normal} ensures that users make a conscious choice about their file permissions. A default ${bold}umask${normal} setting of ${bold}077${normal} causes files and directories created by users to not be readable by any other user on the system. A ${bold}umask${normal} of ${bold}027${normal} would make files and directories readable by users in the same Unix group, while a ${bold}umask${normal} of ${bold}022${normal} would make files readable by every user on the system.\n\n${yellow}Remidation: ${normal}\n1. Run the following command and remove or modify the ${bold}umask${normal} of any returned files:\n\n${bold}grep -RPi '(^|^[^#]*)\s*umask\s+([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b|[0-7][01][0-7]\b|[0-7][0-7][0-6]\b|(u=[rwx]{0,3},)?(g=[rwx]{0,3},)?o=[rwx]+\b|(u=[rwx]{1,3},)?g=[^rx]{1,3}(,o=[rwx]{0,3})?\b)' /etc/login.defs /etc/profile* /etc/bash.bashrc*${normal}\n\n2. Edit ${bold}/etc/login.defs${normal} and edit the ${bold}UMASK${normal} and ${bold}USERGROUPS_ENAB${normal} lines as follows:\n\n${bold}UMASK 027\nUSERGROUPS_ENAB no${normal}\n\n3. Edit ${bold}/etc/pam.d/common-session${normal} and add or edit the following:\n\n${bold}session optional			pam_umask.so${normal}\n\n4. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
			fi

			rm -rf /tmp/umask_test_dir /tmp/umask_test_file
		else
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the default user umask is not 027 or more restrictive, which does not meet the required criteria.\n\nSetting a very secure default value for ${bold}umask${normal} ensures that users make a conscious choice about their file permissions. A default ${bold}umask${normal} setting of ${bold}077${normal} causes files and directories created by users to not be readable by any other user on the system. A ${bold}umask${normal} of ${bold}027${normal} would make files and directories readable by users in the same Unix group, while a ${bold}umask${normal} of ${bold}022${normal} would make files readable by every user on the system.\n\n${yellow}Remidation: ${normal}\n1. Run the following command and remove or modify the ${bold}umask${normal} of any returned files:\n\n${bold}grep -RPi '(^|^[^#]*)\s*umask\s+([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b|[0-7][01][0-7]\b|[0-7][0-7][0-6]\b|(u=[rwx]{0,3},)?(g=[rwx]{0,3},)?o=[rwx]+\b|(u=[rwx]{1,3},)?g=[^rx]{1,3}(,o=[rwx]{0,3})?\b)' /etc/login.defs /etc/profile* /etc/bash.bashrc*${normal}\n\n2. Edit ${bold}/etc/login.defs${normal} and edit the ${bold}UMASK${normal} and ${bold}USERGROUPS_ENAB${normal} lines as follows:\n\n${bold}UMASK 027\nUSERGROUPS_ENAB no${normal}\n\n3. Edit ${bold}/etc/pam.d/common-session${normal} and add or edit the following:\n\n${bold}session optional			pam_umask.so${normal}\n\n4. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		fi
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the default user umask is not 027 or more restrictive, which does not meet the required criteria.\n\nSetting a very secure default value for ${bold}umask${normal} ensures that users make a conscious choice about their file permissions. A default ${bold}umask${normal} setting of ${bold}077${normal} causes files and directories created by users to not be readable by any other user on the system. A ${bold}umask${normal} of ${bold}027${normal} would make files and directories readable by users in the same Unix group, while a ${bold}umask${normal} of ${bold}022${normal} would make files readable by every user on the system.\n\n${yellow}Remidation: ${normal}\n1. Run the following command and remove or modify the ${bold}umask${normal} of any returned files:\n\n${bold}grep -RPi '(^|^[^#]*)\s*umask\s+([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b|[0-7][01][0-7]\b|[0-7][0-7][0-6]\b|(u=[rwx]{0,3},)?(g=[rwx]{0,3},)?o=[rwx]+\b|(u=[rwx]{1,3},)?g=[^rx]{1,3}(,o=[rwx]{0,3})?\b)' /etc/login.defs /etc/profile* /etc/bash.bashrc*${normal}\n\n2. Edit ${bold}/etc/login.defs${normal} and edit the ${bold}UMASK${normal} and ${bold}USERGROUPS_ENAB${normal} lines as follows:\n\n${bold}UMASK 027\nUSERGROUPS_ENAB no${normal}\n\n3. Edit ${bold}/etc/pam.d/common-session${normal} and add or edit the following:\n\n${bold}session optional			pam_umask.so${normal}\n\n4. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 5.5.5
elif [[ $section == "5.5.5" ]]; then
	benchmark_title="5.5.5 Ensure default user shell timeout is 900 seconds or less (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}TMOUT${normal} is an environmental setting that determines the timeout of a shell in seconds.\n\nWhen performing the audit, the output that should show ${bold}0${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	output1=""; output2=""; [ -f /etc/bash.bashrc ] && BRC="/etc/bash.bashrc"; for f in "$BRC" /etc/profile /etc/profile.d/*.sh ; do grep -Pq '^\s*([^#]+\s+)?TMOUT=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9])\b' "$f" && grep -Pq '^\s*([^#]+;\s*)?readonly\s+TMOUT(\s+|\s*;|\s*$|=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9]))\b' "$f" && grep -Pq '^\s*([^#]+;\s*)?export\s+TMOUT(\s+|\s*;|\s*$|=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9]))\b' "$f" && output1="$f"; done; grep -Pq '^\s*([^#]+\s+)?TMOUT=(9[0-9][1-9]|9[1-9][0-9]|0+|[1-9]\d{3,})\b' /etc/profile /etc/profile.d/*.sh "$BRC" && output2=$(grep -Ps '^\s*([^#]+\s+)?TMOUT=(9[0-9][1-9]|9[1-9][0-9]|0+|[1-9]\d{3,})\b' /etc/profile /etc/profile.d/*.sh $BRC); if [ -n "$output1" ] && [ -z "$output2" ]; then echo -e "\nPASSED\n\nTMOUT is configured in: \"$output1\"\n"; else [ -z "$output1" ] && echo -e "\nFAILED\n\nTMOUT is not configured\n"; [ -n "$output2" ] && echo -e "\nFAILED\n\nTMOUT is incorrectly configured in: \"$output2\"\n"; fi

	
	# Check if TMOUT is configured in /etc/profile or /etc/bash.bashrc
	if grep -qE '^\s*export\s+TMOUT\s*=\s*[0-9]+\s*$' /etc/profile /etc/bash.bashrc; then
		# Get the value of TMOUT
		tmout_value=$(grep -E '^\s*export\s+TMOUT\s*=\s*[0-9]+\s*$' /etc/profile /etc/bash.bashrc | awk -F= '{print $2}')

		# Check if TMOUT is 900 seconds or less
		if [[ "$tmout_value" -le 900 ]]; then
			echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
		else
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the default user shell timeout is not 900 seconds or less, which does not meet the required criteria.\n\nSetting a timeout value reduces the window of opportunity for unauthorized user access to another user's shell session that has been left unattended. It also ends the inactive session and releases the resources associated with that session.\n\n${yellow}Remidation: ${normal}\n1. Review ${bold}/etc/bash.bashrc, /etc/profile${normal}, and all files ending in ${bold}*.sh${normal} in the ${bold}/etc/profile.d/${normal} directory and remove or edit all ${bold}TMOUT=_n_${normal} entries to follow local site policy. ${bold}TMOUT${normal} should not exceed 900 or be equal to ${bold}0${normal}:\n\n${bold}TMOUT=900\nreadonly TMOUT\nexport TMOU${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		fi
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the default user shell timeout is not 900 seconds or less, which does not meet the required criteria.\n\nSetting a timeout value reduces the window of opportunity for unauthorized user access to another user's shell session that has been left unattended. It also ends the inactive session and releases the resources associated with that session.\n\n${yellow}Remidation: ${normal}\n1. Review ${bold}/etc/bash.bashrc, /etc/profile${normal}, and all files ending in ${bold}*.sh${normal} in the ${bold}/etc/profile.d/${normal} directory and remove or edit all ${bold}TMOUT=_n_${normal} entries to follow local site policy. ${bold}TMOUT${normal} should not exceed 900 or be equal to ${bold}0${normal}:\n\n${bold}TMOUT=900\nreadonly TMOUT\nexport TMOU${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
else
	exit 0
fi

