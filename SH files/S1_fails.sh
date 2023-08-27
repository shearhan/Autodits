#!/bin/bash
yellow='\033[0;33m'
NC='\033[0m'
green='\033[0;32m'
red='\033[0;41m'
failred='\033[0;31m'

section=$1

# Benchmark Section 1.1.2.1
if [[ $section == "1.1.2.1" ]]; then
    title="1.1.2.1 Ensure /tmp is a separate partition (Automated)"
    findmnt --kernel /tmp &> output.txt
    output=$(cat output.txt)


    echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
    if [ $(wc -l < "${output}") -eq 0 ]; then
	        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /tmp directory is a world-writable directory used for temporary storage by all users and some applications.\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /tmp file does not exsist.\n\n${yellow}Rationale: ${NC}Making /tmp its own file system allows an administrator to set additional mount options such as the noexec option on the mount, making /tmp useless for an attacker to install executable code. It would also prevent an attacker from establishing a hard link to a system setuid program and wait for it to be updated\n\n${yellow}Remediation: ${NC}Please create /tmp file system and run this command to ensure that /tmp will be mounted at boot time. systemctl unmask tmp.mount\n\n "
	else
		systemctl is-enabled tmp.mount >> output.txt
		output=$(cat output.txt)
		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /tmp directory is a world-writable directory used for temporary storage by all users and some applications.\n\n${yellow}Output: ${NC}$output\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /tmp file system will ${red}NOT${NC} mount at boot time.\n\n${yellow}Rationale: ${NC}Making /tmp its own file system allows an administrator to set additional mount options such as the noexec option on the mount, making /tmp useless for an attacker to install executable code. It would also prevent an attacker from establishing a hard link to a system setuid program and wait for it to be updated\n\n${yellow}Remediation: ${NC}Please run this command to ensure that /tmp will be mounted at boot time. systemctl unmask tmp.mount \n\n"
    fi
    sudo rm -f output.txt
    echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	#Benchmark Section: 1.1.2.2
elif [[ $section == "1.1.2.2" ]];
then
	title="1.1.2.2 Ensure nodev option set on /tmp partition (Automated)"
	findmnt --kernel /tmp >> output.txt
	output=$(cat output.txt)
	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	if [ $(wc -l < "${output}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /tmp directory is a world-writable directory used for temporary storage by all users and some applications.\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /tmp file does not exsist.\n\n${yellow}Rationale: ${NC}Making /tmp its own file system allows an administrator to set additional mount options such as the noexec option on the mount, making /tmp useless for an attacker to install executable code. It would also prevent an attacker from establishing a hard link to a system setuid program and wait for it to be updated\n\n${yellow}Remediation: ${NC}Please create /tmp file system and run this command to ensure that /tmp will be mounted at boot time. systemctl unmask tmp.mount\n\n "
        else
		findmnt --kernel /tmp | grep nodev >> output.txt
		output= $(cat output.txt)
		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}the nodev mount option has not been set on the /tmp file system.\n\n${yellow}Rationale: ${NC}Since the /tmp filesystem is not intended to support devices, set this option to ensure that users cannot create a block or character special devices in /tmp.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the /tmp partition.\n\n "
	fi
	sudo rm -f output.txt
	echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	#Benchmark Section: 1.1.2.3
elif [[ $section == "1.1.2.3" ]]; then
	title="1.1.2.3 Ensure noexec option set on /tmp partition (Automated)"
	audit=$(findmnt --kernel /tmp | grep noexec)
	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	#check if mount exsist:
	findmnt --kernel /tmp == output.txt
	output=$(cat output.txt)
	if [ $(wc -l < "${output}") -eq 0 ]; then
		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /tmp directory is a world-writable directory used for temporary storage by all users and some applications.\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /tmp file does not exsist.\n\n${yellow}Rationale: ${NC}Making /tmp its own file system allows an administrator to set additional mount options such as the noexec option on the mount, making /tmp useless for an attacker to install executable code. It would also prevent an attacker from establishing a hard link to a system setuid program and wait for it to be updated\n\n${yellow}Remediation: ${NC}Please create /tmp file system and run this command to ensure that /tmp will be mounted at boot time. systemctl unmask tmp.mount\n\n "
	else
		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The noexec mount option specifies that the filesystem cannot contain executable binaries.\n\n${yellow}Output: ${NC} $audit\n\n${yellow}Explanation: ${NC}The noexec mount option has not been set on the /tmp file system. \n\n${yellow}Rationale: ${NC}Since the /tmp filesystem is only intended for temporary file storage, set this option to ensure that users cannot run executable binaries from /tmp.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add noexec to the fourth field (mounting options) for the /tmp partition.\n\n "
	fi
	sudo rm -f output.txt


elif [[ $section == "1.1.2.4" ]]; then
	title="1.1.2.4 Ensure nosuid option set on /tmp partition (Automated)"
	audit=$(findmnt --kernel /tmp | grep nosuid)
	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	findmnt --kernel /tmp == output.txt
	output=$(cat output.txt)
        if [ $(wc -l < "${output}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /tmp directory is a world-writable directory used for temporary storage by all users and some applications.\n\n${yellow}Output: ${NC}${output}\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /tmp file does not exsist.\n\n${yellow}Rationale: ${NC}Making /tmp its own file system allows an administrator to set additional mount options such as the noexec option on the mount, making /tmp useless for an attacker to install executable code. It would also prevent an attacker from establishing a hard link to a system setuid program and wait for it to be updated\n\n${yellow}Remediation: ${NC}Please create /tmp file system and run this command to ensure that /tmp will be mounted at boot time. systemctl unmask tmp.mount\n\n "
        else
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Output: ${NC} $audit\n\n${yellow}Explanation: ${NC}The nosuid mount option has not been set on the /tmp file system\n\n${yellow}Rationale: ${NC}Since the /tmp filesystem is only intended for temporary file storage, set this option to ensure that users cannot create setuid files in /tmp.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the /tmp partition.\n\n "
	fi
	sudo rm -f output.txt
	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"


elif [[ $section == "1.1.3.1" ]]; then
	title="1.1.3.1 Ensure separate partition exists for /var (Automated)"
	audit=$(findmnt --kernel /var)

	echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /var directory is used by daemons and other system services to temporarily store dynamic data. Some directories created by these processes may be world-writable.\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection from exploitation\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "

echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

elif [[ $section == "1.1.3.2" ]]; then
	title="1.1.3.2 Ensure nodev option set on /var partition (Automated)"
	audit=$(findmnt --kernel /var | grep nodev)
	findmnt --kernel /var >> output.txt
	auditfile=output.txt
	if [ $(wc -l < "${auditfile}") -eq 0 ]; then
		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /var directory is used by daemons and other system services to temporarily store dynamic data. Some directories created by these processes may be world-writable.\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection from exploitation\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
	else
		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nodev option has not been set on the /var file system\n\n${yellow}Rationale: ${NC}Since the /var filesystem is not intended to support devices, set this option to ensure that users cannot create a block or character special devices in /var.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the /var partition.\n\n "
	fi
	sudo rm -f output.txt

	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

elif [[ $section == "1.1.3.3" ]]; then
	title="1.1.3.3 Ensure nosuid option set on /var partition (Automated)"
	audit=$(findmnt --kernel /var grep nosuid)
	findmnt --kernel /var >> output.txt
	auditfile=output.txt
	if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /var directory is used by daemons and other system services to temporarily store dynamic data. Some directories created by these processes may be world-writable.\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection from exploitation\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nosuid option has not been set on the /var file system\n\n${yellow}Rationale: ${NC}Since the /var filesystem is only intended for variable files such as logs, set this option to ensure that users cannot create setuid files in /var.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the /var partition.\n\n "
	fi

	echo -e "\n---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------"

elif [[ $section == "1.1.4.1" ]]; then
	title="1.1.4.1 Ensure separate partition exists for /var/tmp (Automated)"
	findmnt --kernel /var/tmp >> output.txt
	auditfile=output.txt
	if [ $(wc -l < "${auditfile}") -eq 0 ]; then
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /var/tmp directory is a world-writable directory used for temporary storage by all users and some applications. Temporary file residing in /var/tmp is to be preserved between reboots.\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/tmp file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection from exploitation\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/tmp.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
	fi
sudo rm -f output.txt

echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

elif [[ $section == "1.1.4.2" ]]; then
	title="1.1.4.2 Ensure noexec option set on /var/tmp partition"
	audit=$(findmnt --kernel /var/tmp | grep noexec)
	findmnt --kernel /var/tmp >> output.txt
	auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /var/tmp directory is a world-writable directory used for temporary storage by all users and some applications. Temporary file residing in /var/tmp is to be preserved between reboots.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/tmp file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection from exploitation\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/tmp.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
else
	echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The noexec mount option specifies that the filesystem cannot contain executable binaries.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The noexec otion has not been set on the /var/tmp file system\n\n${yellow}Rationale: ${NC}Since the /var/tmp filesystem is only intended for temporary file storage, set this option to ensure that users cannot run executable binaries from /var/tmp.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add noexec to the fourth field (mounting options) for the /var/tmp partition.\n\n "
	fi

	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

elif [[ $section == "1.1.4.3" ]]; then
        title="1.1.4.3 Ensure nosuid option set on /var/tmp partition (Automated)"
        audit=$(findmnt --kernel /var/tmp | grep nosuid)
        findmnt --kernel /var/tmp >> output.txt
	auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /var/tmp directory is a world-writable directory used for temporary storage by all users and some applications. Temporary file residing in /var/tmp is to be preserved between reboots.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/tmp file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection from exploitation\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/tmp.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nosuid otion has not been set on the /var/tmp file system\n\n${yellow}Rationale: ${NC}Since the /var/tmp filesystem is only intended for temporary file storage, set this option to ensure that users cannot create setuid files in /var/tmp.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the /var/tmp partition.\n\n "
	fi

	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	elif [[ $section == "1.1.4.4" ]]; then
        title="1.1.4.4 Ensure nodev option set on /var/tmp partition (Automated)"
        audit=$(findmnt --kernel /var/tmp | grep nodev)
        findmnt --kernel /var/tmp >> output.txt
	auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /var/tmp directory is a world-writable directory used for temporary storage by all users and some applications. Temporary file residing in /var/tmp is to be preserved between reboots.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/tmp file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection from exploitation\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/tmp.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nodev option has not been set on the /var/tmp file system\n\n${yellow}Rationale: ${NC}Since the /var/tmp filesystem is not intended to support devices, set this option to ensure that users cannot create a block or character special devices in /var/tmp.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the /var/tmp partition.\n\n "
	fi


	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

elif [[ $section == "1.1.5.1" ]]; then
        title="1.1.5.1 Ensure separate partition exists for /var/log (Automated)"
        findmnt --kernel /var/log >> output.txt
	auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /var/log directory is used by system services to store log data.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/log file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of log data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/log.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        fi
sudo rm -f output.txt

echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

elif [[ $section == "1.1.5.2" ]]; then
        title="1.1.5.2 Ensure nodev option set on /var/log partition (Automated)"
        audit=$(findmnt --kernel /var/log | grep nodev)
        findmnt --kernel /var/log >> output.txt
	auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /var/log directory is used by system services to store log data.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/log file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of log data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/log.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
	else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nodev option has not been set on the /var/log file system\n\n${yellow}Rationale: ${NC}Since the /var/log filesystem is not intended to support devices, set this option to ensure that users cannot create a block or character special devices in /var/log.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the /var/log partition, then run the following command to remount /var/log with the configured options:\n mount -o remount /var/log \n\n "
	fi

	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------"

elif [[ $section == "1.1.5.3" ]]; then
        title="1.1.5.3 Ensure noexec option set on /var/log partition (Automated)"
        audit=$(findmnt --kernel /var/log | grep noexec)
        findmnt --kernel /var/log >> output.txt
	auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The noexec mount option specifies that the filesystem cannot contain executable binaries.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/log file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of log data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/log.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The noexec mount option specifies that the filesystem cannot contain executable binaries.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The noexec option has not been set on the /var/log file system\n\n${yellow}Rationale: ${NC}Since the /var/log filesystem is only intended for log files, set this option to ensure that users cannot run executable binaries from /var/log.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add noexec to the fourth field (mounting options) for the /var/log partition, then run the following command to remount /var/log with the configured options:\n mount -o remount /var/log \n\n "
	fi

	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------"

elif [[ $section == "1.1.5.4" ]]; then
        title="1.1.5.4 Ensure nosuid option set on /var/log partition (Automated)"
        audit=$(findmnt --kernel /var/log | grep nosuid)
        findmnt --kernel /var/log >> output.txt
	auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/log file system does not exsist\n\n${yellow}Rationale: ${NC}1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of log data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/log.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nosuid option has not been set on the /var/log file system\n\n${yellow}Rationale: ${NC}Since the /var/log filesystem is only intended for log files, set this option to ensure that users cannot create setuid files in /var/log.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the /var/log partition, then run the following command to remount /var/log with the configured options:\n mount -o remount /var/log \n\n "
	fi
	sudo rm -f output.txt


	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------"


elif [[ $section == "1.1.6.1" ]]; then
        title="1.1.6.1 Ensure separate partition exists for /var/log/audit (Automated)"
        findmnt --kernel /var/log/audit >> output.txt
	auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The auditing daemon, auditd, stores log data in the /var/log/audit directory.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/log/audit file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of audit data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/log/audit.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        fi
sudo rm -f output.txt


echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"


elif [[ $section == "1.1.6.2" ]]; then
        title="1.1.6.2 Ensure noexec option set on /var/log/audit partition (Automated)"
        audit=$(findmnt --kernel /var/log/audit | grep noexec)
        findmnt --kernel /var/log/audit >> output.txt
        auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The noexec mount option specifies that the filesystem cannot contain executable binaries.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/log/audit file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of audit data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/log/audit.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The noexec mount option specifies that the filesystem cannot contain executable binaries.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The noexec option has not been set on the /var/log/audit file system\n\n${yellow}Rationale: ${NC}Since the /var/log/audit filesystem is only intended for audit logs, set this option to ensure that users cannot run executable binaries from /var/log/audit.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add noexec to the fourth field (mounting options) for the /var/log/audit partition, then run the following command to remount /var/log/audit with the configured options:\n mount -o remount /var/log/audit \n\n "
        fi
        sudo rm -f output.txt


	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"


	elif [[ $section == "1.1.6.3" ]]; then
        title="1.1.6.3 Ensure nodev option set on /var/log/audit partition (Automated)"
        audit=$(findmnt --kernel /var/log/audit | grep nodev)
        findmnt --kernel /var/log/audit >> output.txt
        auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/log/audit file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of audit data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/log/audit.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nodev option has not been set on the /var/log/audit file system\n\n${yellow}Rationale: ${NC}Since the /var/log/audit filesystem is not intended to support devices, set this option to ensure that users cannot create a block or character special devices in /var/log/audit.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the /var/log/audit partition, then run the following command to remount /var/log/audit with the configured options:\n mount -o remount /var/log/audit \n\n "
        fi
        sudo rm -f output.txt


	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"



        elif [[ $section == "1.1.6.4" ]]; then
        title="1.1.6.4 Ensure nosuid option set on /var/log/audit partition (Automated)"
        audit=$(findmnt --kernel /var/log/audit | grep nosuid)
        findmnt --kernel /var/log/audit >> output.txt
        auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /var/log/audit file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of audit data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /var/log/audit.\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nosuid option has not been set on the /var/log/audit file system\n\n${yellow}Rationale: ${NC}Since the /var/log/audit filesystem is only intended for variable files such as logs, set this option to ensure that users cannot create setuid files in /var/log/audit.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the /var/log/audit partition, then run the following command to remount /var/log/audit with the configured options:\n mount -o remount /var/log/audit \n\n "
        fi
        sudo rm -f output.txt


	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"


	elif [[ $section == "1.1.7.1" ]]; then
        title="1.1.7.1 Ensure separate partition exists for /home (Automated)"
        findmnt --kernel /home >> output.txt
        auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The /home directory is used to support disk storage needs of local users.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /home file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of user data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /home\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        fi
sudo rm -f output.txt


echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"



        elif [[ $section == "1.1.7.2" ]]; then
        title="1.1.7.2 Ensure nodev option set on /home partition (Automated)"
        audit=$(findmnt --kernel /home | grep nodev)
        findmnt --kernel /home >> output.txt
        auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /home file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of user data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /home\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nodev option has not been set on the /home file system\n\n${yellow}Rationale: ${NC}Since the /home filesystem is not intended to support devices, set this option to ensure that users cannot create a block or character special devices in /var.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the /home partition, then run the following command to remount /home with the configured options:\n mount -o remount /home \n\n "
        fi
        sudo rm -f output.txt


        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




elif [[ $section == "1.1.7.3" ]]; then
        title="1.1.7.3 Ensure nosuid option set on /home partition (Automated)"
        audit=$(findmnt --kernel /home | grep nosuid)
        findmnt --kernel /home >> output.txt
        auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /home file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of user data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /home\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nosuid option has not been set on the /home file system\n\n${yellow}Rationale: ${NC}Since the /home filesystem is only intended for user file storage, set this option to ensure that users cannot create setuid files in /home.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the /home partition, then run the following command to remount /home with the configured options:\n mount -o remount /home \n\n "
        fi
        sudo rm -f output.txt


        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.1.8.1" ]]; then
        title="1.1.8.1 Ensure nodev option set on /dev/shm partition (Automated)"
        audit=$(findmnt --kernel /dev/shm | grep nodev)
        findmnt --kernel / >> output.txt
        auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /dev/shm file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of user data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /dev/shm\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nodev mount option specifies that the filesystem cannot contain special devices.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nodev option has not been set on the /dev/shm file system\n\n${yellow}Rationale: ${NC}Since the /dev/shm filesystem is not intended to support devices, set this option to ensure that users cannot create a block or character special devices in /dev/shm.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nodev to the fourth field (mounting options) for the /dev/shm partition, then run the following command to remount /dev/shm with the configured options:\n mount -o remount /dev/shm \n\n "
        fi
        sudo rm -f output.txt


        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.1.8.2" ]]; then
        title="1.1.8.2 Ensure noexec option set on /dev/shm partition (Automated)"
	audit=$(findmnt --kernel /dev/shm | grep noexec)
        findmnt --kernel /dev/shm >> output.txt
        auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The noexec mount option specifies that the filesystem cannot contain executable binaries.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /dev/shm file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of user data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /dev/shm\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The noexec mount option specifies that the filesystem cannot contain executable binaries.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The no exec option has not been set on the /dev/shm file system\n\n${yellow}Rationale: ${NC}Setting this option on a file system prevents users from executing programs from shared memory. This deters users from introducing potentially malicious software on the system.\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add noexec to the fourth field (mounting options) for the /dev/shm partition, then run the following command to remount /dev/shm with the configured options:\n mount -o remount /dev/shm \n\n "
        fi
        sudo rm -f output.txt


        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.1.8.3" ]]; then
        title="1.1.8.3 Ensure nosuid option set on /dev/shm partition (Automated)"
        audit=$(findmnt --kernel /dev/shm | grep nosuid)
        findmnt --kernel /dev/shm >> output.txt
        auditfile=output.txt
        if [ $(wc -l < "${auditfile}") -eq 0 ]; then
                echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}1.1.8.3 Ensure nosuid option set on /dev/shm partition (Automated)\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}The compliance for this benchmark has failed because the /dev/shm file system does not exsist\n\n${yellow}Rationale: ${NC}\n1. Protection from resource exhaustion\n2. Fine grained control over the mount\n3. Protection of user data\n\n${yellow}Remediation: ${NC}For new installations, during installation create a custom partition setup and specify a separate partition for /dev/shm\nOR\nFor systems that were previously installed, create a new partition and configure /etc/fstab as appropriate.\n\n "
        else
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}The nosuid mount option specifies that the filesystem cannot contain setuid files.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The nosuid option has not been set on the /dev/shm file system\n\n${yellow}Rationale: Setting this option on a file system prevents users from introducing privileged programs onto the system and allowing non-root users to execute them.${NC}\n\n${yellow}Remediation: ${NC}Edit the /etc/fstab file and add nosuid to the fourth field (mounting options) for the /dev/shm partition, then run the following command to remount /dev/shm with the configured options:\n mount -o remount /dev/shm \n\n "
        fi
        sudo rm -f output.txt


        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




elif [[ $section == "1.1.9" ]]; then
	title="1.1.9 Disable Automounting (Automated)"
	systemctl is-enabled autofs >> output.txt
	if grep -q "Failed to get unit file state for autofs.service: No such file or directory" output.txt;
	then
		audit=$(systemctl is-enabled autofs)
		echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}1.1.9 Disable Automounting (Automated)\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}This Benchmark failed because autofs is installed.\n\n${yellow}Rationale: ${NC}\nWith automounting enabled anyone with physical access could attach a USB drive or disc and have its contents available in system even if they lacked permissions to mount it themselves.\n\n${yellow}Remediation: ${NC}If there are no other packages that depends on autofs, remove the package with:\n apt purge autofs\nOR\nif there are dependencies on the autofs package: Run the following commands to mask autofs:\nsystemctl stop autofs\nsystemctl mask autofs\n\n "
	else
		systemctl is-enabled autofs >> output.txt
		audit2=$(systemctl is-enabled autofs)
		if grep -q "enabled" output.txt
		then
			echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}1.1.9 Disable Automounting (Automated)\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$auditfile\n\n${yellow}Explanation: ${NC}This Benchmark failed because autofs is installed and enabled.\n\n${yellow}Rationale: ${NC}\nWith automounting enabled anyone with physical access could attach a USB drive or disc and have its contents available in system even if they lacked permissions to mount it themselves.\n\n${yellow}Remediation: ${NC}If there are no other packages that depends on autofs, remove the package with:\n apt purge autofs\nOR\nif there are dependencies on the autofs package: Run the following commands to mask autofs:\nsystemctl stop autofs\nsystemctl mask autofs\n\n "
		fi
	fi
	sudo rm -f output.txt


        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.3.1" ]]; then
        title="1.3.1 Ensure AIDE is installed (Automated)"
	audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' aide aide-common)
        echo -e "${yellow}Title: ${NC}$title\n\n${yellow}Description:${NC}1.3.1 Ensure AIDE is installed (Automated)\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}This Benchmark failed because either aide or aide-common is not installed, or both.\n\n${yellow}Rationale: ${NC}\nBy monitoring the filesystem state compromised files can be detected to prevent or limit the exposure of accidental or malicious misconfigurations or modified binaries.\n\n${yellow}Remediation: ${NC}Run the following commands to initialize AIDE:\naideinit\nmv /var/lib/aide/aide.db.new /var/lib/aide/aide.db\n\n "
sudo rm -f output.txt
echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




elif [[ $section == "1.3.2" ]]; then
        title="1.3.2 Ensure filesystem integrity is regularly checked (Automated)"
        grep -Prs '^([^#\n\r]+\h+)?(\/usr\/s?bin\/|^\h*)aide(\.wrapper)?\h+(--check|([^#\n\r]+\h+)?\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/ >>output.txt
	systemctl is-enabled aidecheck.service &> output.txt
                systemctl is-enabled aidecheck.timer &> output.txt
                systemctl status aidecheck.timer &> output.txt
	audit=output.txt
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}Periodic checking of the filesystem integrity is needed to detect changes to the filesystem.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}This Benchmark failed because there is no cron job scheduled to run the aide check, OR aidcheck.service and aidcheck.timer are not enabled OR aidcheck.timer is not running OR all three\n\n${yellow}Rationale: ${NC}\nPeriodic file checking allows the system administrator to determine on a regular basis if critical files have been changed in an unauthorized fashion.\n\n${yellow}Remediation: ${NC}If cron will be used to schedule and run aide check: Run the following command:\ncrontab -u root -e\nAdd the following line to the crontab:\n0 5 * * * /usr/bin/aide.wrapper --config /etc/aide/aide.conf --check\nOR\nIf aidecheck.service and aidecheck.timer will be used to schedule and run aide
check, follow CIS benchmark for steps. "
sudo rm -f output.txt
echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"





elif [[ $section == "1.4.1" ]]; then
        title="1.4.1 Ensure bootloader password is set (Automated)"
        audit=$(grep "^set superusers" /boot/grub/grub.cfg)
	audit=$(grep "^password" /boot/grub/grub.cfg)
        echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}Setting the boot loader password will require that anyone rebooting the system must enter a password before being able to set command line boot parameters\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}This Benchmark failed because either the Superusers or encrypted passwords or both has not been set\n\n${yellow}Rationale: ${NC}\nRequiring a boot password upon execution of the boot loader will prevent an unauthorized user from entering boot parameters or changing the boot partition. This prevents users from weakening security\n\n${yellow}Remediation: ${NC}Create an encrypted password with the command:\ngrub-mkpasswd-pbkdf2\n\nAdd the following into a custom /etc/grub.d configuration file:\ncat <<EOF\nset superusers='<username>'\npassword_pbkdf2 <username> <encrypted-password>\nEOF\n\nRun the following command to update the grub2 configuration:\nupdate-grub\n\n"
sudo rm -f output.txt
echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"


elif [[ $section == "1.4.2" ]]; then
        title="1.4.2 Ensure permissions on bootloader config are configured (Automated)"
	audit=$(stat /boot/grub/grub.cfg)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}The grub configuration file contains information on boot settings and passwords for unlocking boot options.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The grub confirgurations have not been set, or has been set incorrectly.\n\n${yellow}Rationale: ${NC}\nSetting the permissions to read and write for root only prevents non-root users from seeing the boot parameters or changing them. Non-root users who read the boot parameters may be able to identify weaknesses in security upon boot and be able to exploit them.\n\n${yellow}Remediation: ${NC}Run the following commands to set permissions on your grub configuration:\n\nchown root:root /boot/grub/grub.cfg\nchmod u-wx,go-rwx /boot/grub/grub.cfg\n\n"

sudo rm -f output.txt
echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




elif [[ $section == "1.4.3" ]]; then
        title="1.4.3 Ensure authentication required for single user mode (Automated)"
	audit=$(grep -Eq '^root:\$[0-9]' /etc/shadow || echo "root is locked")
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}Single user mode is used for recovery when the system detects an issue during boot or by manual selection from the bootloader.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}root user password is not set\n\n${yellow}Rationale: ${NC}\nRequiring authentication in single user mode prevents an unauthorized user from rebooting the system into single user to gain root privileges without credentials.\n\n${yellow}Remediation: ${NC}Run the following command and follow the prompts to set a password for the root user:\npasswd root\n\n"

sudo rm -f output.txt
echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




elif [[ $section == "1.5.1" ]]; then
        title="1.5.1 Ensure address space layout randomization (ASLR) is enabled (Automated)"
	audit=$(sysctl kernel.randomize_va_space)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}Address space layout randomization (ASLR) is an exploit mitigation technique which randomly arranges the address space of key data areas of a process.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}kernel.randomize_va_space is not set to 2\n\n${yellow}Rationale: ${NC}\nRandomly placing virtual memory regions will make it difficult to write memory page exploits as the memory placement will be consistently shifting.\n\n${yellow}Remediation: ${NC}Set following paremeter in in /etc/sysctl.conf or a /etc/sysctl.d/* file:\n\nkernel.randomize_va_space = 2\n\nRun the following command to set the active kernel parameter:\n\nsysctl -w kernel.randomize_va_space=2\n\n"
	echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	elif [[ $section == "1.5.2" ]]; then
        title="1.5.2 Ensure prelink is not installed (Automated)"
	audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n'prelink)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}prelink is a program that modifies ELF shared libraries and ELF dynamically linked binaries in such a way that the time needed for the dynamic linker to perform relocations at startup significantly decreases.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}\n\n${yellow}Explanation: ${NC}Prelink is installed\n\n${yellow}Rationale: ${NC}\nThe prelinking feature can interfere with the operation of AIDE, because it changes binaries. Prelinking can also increase the vulnerability of the system if a malicious user is able to compromise a common library such as libc.\n\n${yellow}Remediation: ${NC}Run the following command to restore binaries to normal:\n\nprelink -ua\n\nUninstall prelink using the appropriate package manager or manual installation:\n\napt purge prelink\n\n"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.5.3" ]]; then
        title="1.5.3 Ensure Automatic Error Reporting is not enabled (Automated)"
	audit=$(dpkg-query -s apport > /dev/null 2>&1 && grep -Psi -- '^\h*enabled\h*=\h*[^0]\b' /etc/default/apport)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}The Apport Error Reporting Service automatically generates crash reports for debugging\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}service 'apport' is either still active or enabled or both\n\n${yellow}Rationale: ${NC}\nApport collects potentially sensitive data, such as core dumps, stack traces, and log files. They can contain passwords, credit card numbers, serial numbers, and other private material.\n\n${yellow}Remediation: ${NC}Edit /etc/default/apport and add or edit the ${yellow}'enabled'${NC} parameter to equal 0.\nRun the following commands to stop and disable the apport service:\n\nsystemctl stop apport.service\nsystemctl --now disable apport.service\n\nOR\n\nRun the following command to remove the apport package:\n\napt purge apport\n\n"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"






	elif [[ $section == "1.5.4" ]]; then
        title="1.5.4 Ensure core dumps are restricted (Automated)"
	grep -Es '^(\*|\s).*hard.*core.*(\s+#.*)?$' /etc/security/limits.conf /etc/security/limits.d/* >> output.txt
	sysctl fs.suid_dumpable &> output.txt 
	grep "fs.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/* >> output.txt
	systemctl is-enabled coredump.service &> output.txt
	audit=$(output.txt)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}A core dump is the memory of an executable program. It is generally used to determine why a program aborted. It can also be used to glean confidential information from a core file. The system provides the ability to set a soft limit for core dumps, but this can be overridden by the user.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}systemd-coredump is not installed or coredump parameters are not set\n\n${yellow}Rationale: ${NC}\nSetting a hard limit on core dumps prevents users from overriding the soft variable. If core dumps are required, consider setting limits for user groups (see limits.conf(5) ). In addition, setting the fs.suid_dumpable variable to 0 will prevent setuid programs from dumping core.\n\n${yellow}Remediation: ${NC}1. Add line '${yellow}* hard core 0${NC}' to /etc/security/limits.conf or a /etc/security/limits.d/* file.\n\n2. Set the following parameter in /etc/sysctl.conf or a /etc/sysctl.d/* file:\n\nfs.suid_dumpable = 0\n\n3. Run the following command to set the active kernel parameter:\n\nsysctl -w fs.suid_dumpable=0\n\n\n IF systemd-coredump is installed, edit /etc/systemd/coredump.conf and add/modify the following lines:\n\nStorage=none\nProcessSizeMax=0\n\nRun the command:\n\nsystemctl daemon-reload"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"


	
	elif [[ $section == "1.6.1.1" ]]; then
        title="1.6.1.1 Ensure AppArmor is installed (Automated)"
	audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' apparmor)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}AppArmor provides Mandatory Access Controls.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}AppArmor is not installed\n\n${yellow}Rationale: ${NC}\nWithout a Mandatory Access Control system installed only the default Discretionary Access Control system will be available.\n\n${yellow}Remediation: ${NC}Install AppArmor:\n\napt install apparmor\n\n"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.6.1.2" ]]; then
        title="1.6.1.2 Ensure AppArmor is enabled in the bootloader configuration (Automated)"
	grep "^\s*linux" /boot/grub/grub.cfg | grep -v "apparmor=1" >> output.txt
	grep "^\s*linux" /boot/grub/grub.cfg | grep -v "security=apparmor" >> output.txt
	audit=$(cat output.txt)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}Configure AppArmor to be enabled at boot time and verify that it has not been overwritten by the bootloader boot parameters.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}AppArmor parameters have not been set or have been set incorrectly\n\n${yellow}Rationale: ${NC}AppArmor must be enabled at boot time in your bootloader configuration to ensure that the controls it provides are not overridden.\n\n${yellow}Remediation: ${NC}\n1. Edit /etc/default/grub and add the apparmor=1 and security=apparmor parameters to the GRUB_CMDLINE_LINUX= line:\n\nGRUB_CMDLINE_LINUX="apparmor=1 security=apparmor"\n\n2. Run the following command to update the grub2 configuration:\n\nupdate-grub\n\n"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.6.1.3" ]]; then
        title="1.6.1.3 Ensure all AppArmor Profiles are in enforce or complain mode (Automated)"
	apparmor_status | grep profiles >> output.txt
	apparmor_status | grep processes | grep unconfined >> output.txt
	audit=$(cat output.txt)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}AppArmor profiles define what resources applications are able to access.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}There are profiles that are either not in loaded/enforce/complain mode, or, there are processes which are unconfined\n\n${yellow}Rationale: ${NC}Security configuration requirements vary from site to site. Some sites may mandate a policy that is stricter than the default policy, which is perfectly acceptable. This item is intended to ensure that any policies that exist on the system are activated.\n\n${yellow}Remediation: ${NC}Run the following command to set all profiles to enforce mode:\naa-enforce /etc/apparmor.d/*\n\nOR\n\nRun the following command to set all profiles to complain mode:\naa-complain /etc/apparmor.d/*\n\n"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.6.1.4" ]]; then
        title="1.6.1.4 Ensure all AppArmor Profiles are enforcing (Automated)"
	apparmor_status | grep profiles >> output.txt
        apparmor_status | grep processes | grep unconfined >> output.txt
	audit=$(cat output.txt)
        echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}AppArmor profiles define what resources applications are able to access.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}There are profiles that are either not in loaded/enforce mode, or, there are processes which are unconfined\n\n${yellow}Rationale: ${NC}Security configuration requirements vary from site to site. Some sites may mandate a policy that is stricter than the default policy, which is perfectly acceptable. This item is intended to ensure that any policies that exist on the system are activated.\n\n${yellow}Remediation: ${NC}Run the following command to set all profiles to enforce mode:\naa-enforce /etc/apparmor.d/*\n\n"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.7.2" ]]; then
        title="1.7.1 Ensure message of the day is configured properly (Automated)"
	audit+$(grep -Eis "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}The contents of the /etc/motd file are displayed to users after login and function as a message of the day for authenticated users.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}message of the day is not configured properly\n\n${yellow}Rationale: ${NC}Warning messages inform users who are attempting to login to the system of their legal status regarding the system and must include the name of the organization that owns the system and any monitoring policies that are in place. Displaying OS and patch level information in login banners also has the side effect of providing detailed system information to attackers attempting to target specific exploits of a system.\n\n${yellow}Remediation: ${NC}Edit the /etc/motd file with the appropriate contents according to your site policy, remove any instances of \m , \r , \s , \v or references to the OS platform\n\nOR\n\nif the motd is not used, this file can be removed. Run the following command to remove the motd file:if the motd is not used, this file can be removed. Run the following command to remove the motd file:\nrm /etc/motd\n\n"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.7.2" ]]; then
        title="1.7.2 Ensure local login warning banner is configured properly (Automated)"
	audit=$(grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}The contents of the /etc/issue file are displayed to users prior to login for local terminals.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}Local login warning banner is not configured properly\n\n${yellow}Rationale: ${NC}Warning messages inform users who are attempting to login to the system of their legal status regarding the system and must include the name of the organization that owns the system and any monitoring policies that are in place. Displaying OS and patch level information in login banners also has the side effect of providing detailed system information to attackers attempting to target specific exploits of a system.\n\n${yellow}Remediation: ${NC}Edit the /etc/issue file with the appropriate contents according to your site policy, remove any instances of \m , \r , \s , \v or references to the OS platform. \nExample:\n\necho "Authorized uses only. All activity may be monitored and reported." > /etc/issue\n\n"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.7.3" ]]; then
        title="1.7.3 Ensure remote login warning banner is configured properly (Automated)"
	audit=$(grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue.net)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}The contents of the /etc/issue.net file are displayed to users prior to login for remote connections from configured services.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}Remote login warning banner is not configured properly\n\n${yellow}Rationale: ${NC}Warning messages inform users who are attempting to login to the system of their legal status regarding the system and must include the name of the organization that owns the system and any monitoring policies that are in place. Displaying OS and patch level information in login banners also has the side effect of providing detailed system information to attackers attempting to target specific exploits of a system.\n\n${yellow}Remediation: ${NC}Edit the /etc/issue file with the appropriate contents according to your site policy, remove any instances of \m , \r , \s , \v or references to the OS platform. \nExample:\n\necho "Authorized uses only. All activity may be monitored and reported." > /etc/issue.net\n\n"
        echo -e "\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	elif [[ $section == "1.7.4" ]]; then
        title="1.7.4 Ensure permissions on /etc/motd are configured (Automated)"
	audit=$(stat -L /etc/motd &> output.txt)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}The contents of the /etc/motd file are displayed to users after login and function as a message of the day for authenticated users.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}Uid and/or Gid are not set to 0/root, and/or Access is not set to 644\n\n${yellow}Rationale: ${NC}If the /etc/motd file does not have the correct ownership it could be modified by unauthorized users with incorrect or misleading information.\n\n${yellow}Remediation: ${NC}Run the following commands to set permissions on /etc/motd:\n\nchown root:root $(readlink -e /etc/motd)\nchmod u-x,go-wx $(readlink -e /etc/motd)\n\nOR\n\nrun the following command to remove the /etc/motd file:\nrm /etc/motd\n\n"
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




	elif [[ $section == "1.7.5" ]]; then
        title="1.7.5 Ensure permissions on /etc/issue are configured (Automated)"
	audit=$(stat -L /etc/issue)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}The contents of the /etc/issue file are displayed to users prior to login for local terminals.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}Permissions have not been set, or have been set incorrectly for /etc/issue.\n\n${yellow}Rationale: ${NC}If the /etc/issue file does not have the correct ownership it could be modified by unauthorized users with incorrect or misleading information.\n\n${yellow}Remediation: ${NC}Run the following commands to set permissions on /etc/issue :\nchown root:root $(readlink -e /etc/issue)\nchmod u-x,go-wx $(readlink -e /etc/issue)\n\n"
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	elif [[ $section == "1.7.6" ]]; then
        title="1.7.6 Ensure permissions on /etc/issue.net are configured (Automated)"
	audit=$(stat -L /etc/issue.net)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}The contents of the /etc/issue.net file are displayed to users prior to login for remote connections from configured services.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC} Permissions have not been set, or have been set incorrectly for /etc/issue.\n\n${yellow}Rationale: ${NC}If the /etc/issue.net file does not have the correct ownership it could be modified by unauthorized users with incorrect or misleading information.\n\n${yellow}Remediation: ${NC}Run the following commands to set permissions on /etc/issue.net :\n\nchown root:root $(readlink -e /etc/issue.net)\nchmod u-x,go-wx $(readlink -e /etc/issue.net)\n\n"
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"




elif [[ $section == "1.8.1" ]]; then
        title="1.8.1 Ensure GNOME Display Manager is removed (Automated)"
	audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' gdm3)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}The GNOME Display Manager (GDM) is a program that manages graphical display servers and handles graphical user logins.\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}The GNOME GUI is installed on the system.\n\n${yellow}Rationale: ${NC}If a Graphical User Interface (GUI) is not required, it should be removed to reduce the attack surface of the system.\n\n${yellow}Remediation: ${NC}Run the following command to uninstall gdm3:\napt purge gdm3"
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	elif [[ $section == "1.8.10" ]]; then
        title="1.8.10 Ensure XDCMP is not enabled (Automated)"
	audit=$(grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm3/custom.conf)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}X Display Manager Control Protocol (XDMCP) is designed to provide authenticated access to display management services for remote displays\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}XDCMP is enabled\n\n${yellow}Rationale: ${NC}XDMCP is inherently insecure.\n\n\n1. XDMCP is not a ciphered protocol. This may allow an attacker to capture keystrokes entered by a user\n2. XDMCP is vulnerable to man-in-the-middle attacks. This may allow an attacker to
steal the credentials of legitimate users by impersonating the XDMCP server.\n\n${yellow}Remediation: ${NC}Edit the file /etc/gdm3/custom.conf and remove the line:\nEnable=true"
echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"


elif [[ $section == "1.9" ]]; then
        title="1.9 Ensure updates, patches, and additional security software are installed (Manual)"
	audit=$(apt -s upgrade)
	echo -e "${yellow}Title:${NC}$title\n\n${yellow}Description:${NC}1.9 Ensure updates, patches, and additional security software are installed (Manual)\n\n${yellow}Compliance: ${red}FAIL${NC}\n\n${yellow}Output: ${NC}$audit\n\n${yellow}Explanation: ${NC}There are updates/patches left to install\n\n${yellow}Rationale: ${NC}Newer patches may contain security enhancements that would not be available through the latest full update. As a result, it is recommended that the latest software patches be used to take advantage of the latest functionality. As with any software installation, organizations need to determine if a given update meets their requirements and verify the compatibility and supportability of any additional software against the update revision that is selected.\n\n${yellow}Remediation: ${NC}Run the following command to update all packages following local site policy guidance on applying updates and patches:\napt upgrade\n\nOR\n\napt dist-upgrade"
echo -e "\n------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------"

else
	echo "Invalid section: $section"
fi


