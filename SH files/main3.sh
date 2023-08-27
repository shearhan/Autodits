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


# Function to display failed sections
display_failed_sections() {
    local fails_script=$1
    echo -e "\n${red}                                                                                          failed Sections:${NC}\n"
    for section in $failed_sections; do
        case $section in
	    "1.1.2.1") $fails_script 1.1.2.1;;
	    "2.1.1.1") $fails_script 2.1.1.1 ;;
            "2.2.1") $fails_script 2.2.1 ;;
	    "2.2.2") $fails_script 2.2.2 ;;
	    "2.2.3") $fails_script 2.2.3 ;;
	    "2.2.4") $fails_script 2.2.4 ;;
	    "2.2.5") $fails_script 2.2.5 ;;
	    "2.2.6") $fails_script 2.2.6 ;;
	    "2.2.7") $fails_script 2.2.7 ;;
	    "2.2.8") $fails_script 2.2.8 ;;
	    "2.2.9") $fails_script 2.2.9 ;;
	    "2.2.10") $fails_script 2.2.10 ;;
	    "2.2.11") $fails_script 2.2.11 ;;
	    "2.2.12") $fails_script 2.2.12 ;;
	    "2.2.13") $fails_script 2.2.13 ;;
	    "2.2.14") $fails_script 2.2.14 ;;
	    "2.2.15") $fails_script 2.2.15 ;;
	    "2.2.16") $fails_script 2.2.16 ;;
	    "2.3.1") $fails_script 2.3.1 ;;
	    "2.3.2") $fails_script 2.3.2 ;;
	    "2.3.3") $fails_script 2.3.3 ;;
	    "2.3.4") $fails_script 2.3.4 ;;
	    "2.3.5") $fails_script 2.3.5 ;;
	    "2.3.6") $fails_script 2.3.6 ;;
	    "2.4") $fails_script 2.4 ;;
            "6.1.1") $fails_script 6.1.1 ;;
            "6.1.2") $fails_script 6.1.2 ;;
	    "6.1.3") $fails_script 6.1.3 ;;
	    "6.1.4") $fails_script 6.1.4 ;;
            "6.1.5") $fails_script 6.1.5 ;;
            "6.1.6") $fails_script 6.1.6 ;;
	    "6.1.7") $fails_script 6.1.7 ;;
	    "6.1.8") $fails_script 6.1.8 ;;
	    "6.1.9") $fails_script 6.1.9 ;;
	    "6.1.10") $fails_script 6.1.10 ;;
	    "6.1.11") $fails_script 6.1.11 ;;
	    "6.1.12") $fails_script 6.1.12 ;;
            "6.1.13") $fails_script 6.1.13 ;;
	    "6.2.1") $fails_script 6.2.1 ;;
            "6.2.2") $fails_script 6.2.2 ;;
            "6.2.3") $fails_script 6.2.3 ;;
            "6.2.4") $fails_script 6.2.4 ;;
            "6.2.5") $fails_script 6.2.5 ;;
            "6.2.6") $fails_script 6.2.6 ;;
	    "6.2.7") $fails_script 6.2.7 ;;
            "6.2.8") $fails_script 6.2.8 ;;
            "6.2.9") $fails_script 6.2.9 ;;
            "6.2.10") $fails_script 6.2.10 ;;
            "6.2.11") $fails_script 6.2.11 ;;
            "6.2.12") $fails_script 6.2.12 ;;
            "6.2.13") $fails_script 6.2.13 ;;
            "6.2.14") $fails_script 6.2.14 ;;
            "6.2.15") $fails_script 6.2.15 ;;
            "6.2.16") $fails_script 6.2.16 ;;
            "6.2.17") $fails_script 6.2.17 ;;


            # Add more cases for other sections if needed
            *) echo "Invalid section: $section" ;;
        esac
        echo
    done
}


# Function to remediate a specific section
function remediate_section() {
    local section="$1"
    case "$section" in
        "2.1.1.1") ./remediation.sh 2.1.1.1 ;;
        "6.1.1") ./remediation.sh 6.1.1 ;;
        "6.1.2") ./remediation.sh 6.1.2 ;;
	"6.1.3") ./remediation.sh 6.1.3 ;;
	"6.1.4") ./remediation.sh 6.1.4 ;;
	"6.1.5") ./remediation.sh 6.1.5 ;;
	"6.1.6") ./remediation.sh 6.1.6 ;;
	"6.1.7") ./remediation.sh 6.1.7 ;;
	"6.1.8") ./remediation.sh 6.1.8 ;;
	"6.1.9") ./remediation.sh 6.1.9 ;;
	"6.1.10") ./remediation.sh 6.1.10 ;;
	"6.1.11") ./remediation.sh 6.1.11 ;;
	"6.1.12") ./remediation.sh 6.1.12 ;;
	"6.1.13") ./remediation.sh 6.1.13 ;;
	"6.2.1") ./remediation.sh 6.2.1 ;;
	"6.2.2") ./remediation.sh 6.2.2 ;;
	"6.2.3") ./remediation.sh 6.2.3 ;;
	"6.2.4") ./remediation.sh 6.2.4 ;;
	"6.2.5") ./remediation.sh 6.2.5 ;;
	"6.2.6") ./remediation.sh 6.2.6 ;;
	"6.2.7") ./remediation.sh 6.2.7 ;;
	"6.2.8") ./remediation.sh 6.2.8 ;;
	"6.2.9") ./remediation.sh 6.2.9 ;;
	"6.2.10") ./remediation.sh 6.2.10 ;;
	"6.2.11") ./remediation.sh 6.2.11 ;;
	"6.2.12") ./remediation.sh 6.2.12 ;;
	"6.2.13") ./remediation.sh 6.2.13 ;;
	"6.2.14") ./remediation.sh 6.2.14 ;;
	"6.2.15") ./remediation.sh 6.2.15 ;;
	"6.2.16") ./remediation.sh 6.2.16 ;;
	"6.2.17") ./remediation.sh 6.2.17 ;;
        # Add more cases for other sections if needed
        *) echo "Invalid section: $section" ;;
    esac
}

echo
echo -e "${red}*** DISCLAIMER: This automated audit tool is designed to assist in evaluating the security configuration of your system, use at your own risk. ***${NC}"
echo -e "${red}*** NOTE: Please run this tool with root user privileges for comprehensive and effective system assessment. ***${NC}"
echo
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                       Automated Audit Tool for Linux(2)                                                     |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo -e "|${YELLOW}Section${NC}  | ${YELLOW}Title${NC}                                                                                                          | ${YELLOW}Compliance${NC}       |"

# Section 1

echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                               1 Initial Setup                                                               |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|1.1      | Filesystem Configuration                                                                                       |                  |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
# Audit Title 1.1.1

echo -e "|1.1.1    | Disable unused filesystems                                                                                     |${BLUE} Not-Accessed${NC}     |"

# Section 1.1.2
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|1.2      | Configure /tmp                                                                                                 |                  |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Audit Title 1.1.2.1

findmnt --kernel /tmp >> output.txt
if grep -E -q "/tmp   tmpfs  tmpfs  rw,nosuid,nodev,noexec,relatime,size=2097152k,inode64" output.txt;
then
	systemctl is-enabled tmp.mount >> output.txt
	if grep -q "enabled" output.txt;
	then
		echo -e "|1.1.2.1  | Ensure /tmp is a separate partition                                                                            |${GREEN} Pass${NC}              |"
		tput init
		((pass_count++))
	else
		echo -e "|${RED}1.1.2.1  | Ensure /tmp is a separate partition                                                                            | Fail             ${NC}|"
		tput init
		((fail_count++))
		failed_sections+="1.1.2.1 "
	fi
  else
	  echo -e  "|${RED}1.1.2.1  | Ensure /tmp is a separate partition                                                                            | Fail             ${NC}|"
	  tput init
	  ((fail_count++))
	  failed_sections+="1.1.2.1 "
fi
sudo rm -f output.txt
((total++))


# Audit Title 1.1.2.2

findmnt --kernel /tmp | grep nodev >> output.txt
if grep -E -q "nodev" output.txt;
then
        echo -e "|1.1.2.2  | Ensure nodev option set on /tmp partition                                                                      |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.2.2  | Ensure nodev option set on /tmp partition                                                                      | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.2.2 "
fi
sudo rm -f output.txt
((total++))

# Audit Title 1.1.2.3

findmnt --kernel /tmp | grep noexec >> output.txt
if grep -E -q "noexec" output.txt;
then
        echo -e "|1.1.2.3  | Ensure noexec option set on /tmp partition                                                                     |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.2.3  | Ensure noexec option set on /tmp partition                                                                     | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.2.3 "
fi
sudo rm -f output.txt
((total++))

findmnt --kernel /tmp | grep nosuid >> output.txt
if grep -E -q "nosuid" output.txt;
then
        echo -e "|1.1.2.4  | Ensure nosuid option set on /tmp partition                                                                     |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.2.4  | Ensure nosuid option set on /tmp partition                                                                     | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.2.4 "
fi
sudo rm -f output.txt
((total++))

# Section 1.3
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.3      | Configure /var                                                                                                 |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

findmnt --kernel /var >> output.txt
if grep -E -q "/var" output.txt;
then
        echo -e "|1.1.3.1  | Ensure separate partition exists for /var                                                                      |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.3.1  | Ensure separate partition exists for /var                                                                      | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.3.1 "
fi
sudo rm -f output.txt
((total++))

#Description: The /var directory is used by daemons and other system services to temporarily store dynamic data. Some directories created by these processes may be world-writable.

#Explanation: the /var partition has not been set or has been setup incorrectly.


findmnt --kernel /var | grep nodev >> output.txt
if grep -E -q "nodev" output.txt;
then
        echo -e "|1.1.3.2  | Ensure nodev option set on /var partition                                                                      |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.3.2  | Ensure nodev option set on /var partition                                                                      | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.3.2 "
fi
sudo rm -f output.txt
((total++))

#Description: The nodev mount option specifies that the filesystem cannot contain special devices.

#Explanation: The nodev option option has not been set or has been set incorrectly for the /car mount.


findmnt --kernel /var | grep nosuid >> output.txt
if grep -E -q "nosuid" output.txt;
then
        echo -e "|1.1.3.3  | Ensure nosuid option set on /var partition                                                                     |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.3.3  | Ensure nosuid option set on /var partition                                                                     | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.3.3 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files.

#Explanation: The nosuid opition has not been set, or has been set incorrectly on the /var mount

# Section 1.4

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.4      | Configure /var/tmp                                                                                             |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

findmnt --kernel /var/tmp >> output.txt
if grep -E -q "/var/tmp" output.txt;
then
        echo -e "|1.1.4.1  | Ensure separate partition exists for /var/tmp                                                                 |${GREEN} Pass${NC}              |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.4.1  | Ensure separate partition exists for /var/tmp                                                                  | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.4.1 "
fi
sudo rm -f output.txt
((total++))

#Description: The /var/tmp directory is a world-writable directory used for temporary storage by all users and some applications. Temporary file residing in /var/tmp is to be preserved between reboots.

#Explanation: the /var/tmp partition has not been mounted, or has been mounted incorrectly.


findmnt --kernel /var/tmp | grep noexec >> output.txt
if grep -E -q "noexec" output.txt;
then
        echo -e "|1.1.4.2  | Ensure noexec option set on /var/tmp partition                                                                |${GREEN} Pass${NC}              |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.4.2  | Ensure noexec option set on /var/tmp partition                                                                 | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.4.2 "
fi
sudo rm -f output.txt
((total++))

#Description: The noexec mount option specifies that the filesystem cannot contain executable binaries
#Explanation: The noexec option has not been set or has been set incorrectly on the /var/tmp mount


findmnt --kernel /var/tmp | grep nosuid >> output.txt
if grep -E -q "nosuid" output.txt;
then
        echo -e "|1.1.4.3  | Ensure nosuid option set on /var/tmp partition                                                                |${GREEN} Pass${NC}              |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.4.3  | Ensure nosuid option set on /var/tmp partition                                                                 | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.4.3 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files
#Explanation: The nosuid option has not been set or has been set incorrectly on the /var/tmp mount


findmnt --kernel /var/tmp | grep nodev >> output.txt
if grep -E -q "nodev" output.txt;
then
        echo -e "|1.1.4.4  | Ensure nodev option set on /var/tmp partition                                                                 |${GREEN} Pass${NC}              |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.4.4  | Ensure nodev option set on /var/tmp partition                                                                  | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.4.4 "
fi
sudo rm -f output.txt


#Description: The nodev mount option specifies that the filesystem cannot contain special devices.
#Explanation: The nodev option has not been set, or has been set incorrectly on the /var/tmp mount
((total++))

findmnt --kernel /var/log >> output.txt
if grep -E -q "/var/log" output.txt;
then
        echo -e "|1.1.5.1  | Ensure separate partition exists for /var/log                                                                 |${GREEN} Pass${NC}              |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.5.1  | Ensure separate partition exists for /var/log                                                                  | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.5.1 "
fi
sudo rm -f output.txt
((total++))

#Description: The /var/log directory is used by system services to store log data
#Explanation: the /var/log partition has not been mounted, or has been mounted incorrectly


findmnt --kernel /var/log | grep nodev >> output.txt
if grep -E -q "nodev" output.txt;
then
        echo -e "|1.1.5.2  | Ensure nodev option set on /var/log partition                                                                  |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.5.2  | Ensure nodev option set on /var/log partition                                                                  | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.5.2 "
fi
sudo rm -f output.txt
((total++))

#Description: The nodev mount option specifies that the filesystem cannot contain special devices
#Explanation: The nodev option has not been set, or has been set incorrectly on the /var/log mount


findmnt --kernel /var/log | grep noexec >> output.txt
if grep -E -q "noexec" output.txt;
then
        echo -e "|1.1.5.3  | Ensure noexec option set on /var/log partition                                                                |${GREEN} Pass${NC}              |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.5.3  | Ensure noexec option set on /var/log partition                                                                 | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.5.3 "
fi
sudo rm -f output.txt
((total++))

#Description: The noexec mount option specifies that the filesystem cannot contain executable binaries.
#Explanation: The noexec option has not been set, or has been set incorrectly on the /var/log mount


findmnt --kernel /var/log | grep nosuid >> output.txt
if grep -E -q "nosuid" output.txt;
then
        echo -e "|1.1.5.4  | Ensure nosuid option set on /var/log partition                                                                 |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.5.4  | Ensure nosuid option set on /var/log partition                                                                 | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.5.4 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files
#Explanation: The nosuid option has not been set, or has been set incorrectly on the /var/log mount


findmnt --kernel /var/log/audit >> output.txt
if grep -E -q "/var/log/audit" output.txt;
then
        echo -e "|1.1.6.1  | Ensure separate partition exists for /var/log/audit                                                            |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.6.1  | Ensure separate partition exists for /var/log/audit                                                            | Fail             ${NC}|"
	((fail_count++))
	failed_sections+="1.1.6.1 "
fi
sudo rm -f output.txt
((total++))

#Description: The auditing daemon, auditd, stores log data in the /var/log/audit directory
#Explanation: The /var/log/audit has not been mounted or has been mounted incorrectly


findmnt --kernel /var/log/audit |grep noexec >> output.txt
if grep -E -q "/var/log/audit.*noexec" output.txt;
then
        echo -e "|1.1.6.2  | Ensure noexec option set on /var/log/audit partition                                                           |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.6.2  | Ensure noexec option set on /var/log/audit partition                                                           | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.6.2 "
fi
sudo rm -f output.txt
((total))

#Description: The noexec mount option specifies that the filesystem cannot contain executable binaries
#Explanation: The noexec option has not been set, or has been set incorrectly.


findmnt --kernel /var/log/audit |grep nodev >> output.txt
if grep -E -q "/var/log/audit.*nodev" output.txt;
then
        echo -e "|1.1.6.3  | Ensure nodev option set on /var/log/audit partition                                                            |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.6.3  | Ensure nodev option set on /var/log/audit partition                                                            | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.6.3 "
fi
sudo rm -f output.txt
((total++))

#Description: The nodev mount option specifies that the filesystem cannot contain special devices
#Explanation: The nodev option has not been set, or has been set incorrectly.


findmnt --kernel /var/log/audit |grep nosuid >> output.txt
if grep -E -q "/var/log/audit.*nosuid" output.txt;
then
        echo -e "|1.1.6.4  | Ensure nosuid option set on /var/log/audit partition                                                           |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.6.4  | Ensure nosuid option set on /var/log/audit partition                                                           | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.6.4 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files.
#Explanation: The nosuid option has not been set, or has been set incorrectly.


findmnt --kernel /home >> output.txt
if grep -E -q "/home" output.txt;
then
        echo -e "|1.1.7.1  | Ensure separate partition exists for /home                                                                     |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.7.1  | Ensure separate partition exists for /home                                                                     | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.7.1 "
fi
sudo rm -f output.txt
((total++))

#Description: The /home directory is used to support disk storage needs of local users
#Explanation: the /home partition has not been mounted, or has been mounted incorrectly


findmnt --kernel /home grep nodev >> output.txt
if grep -E -q "/home.*nodev" output.txt;
then
        echo -e "|1.1.7.2  | Ensure nodev option set on /home partition                                                                     |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.7.2  | Ensure nodev option set on /home partition                                                                     | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.7.2 "
fi
sudo rm -f output.txt
((total++))

#Description: The nodev mount option specifies that the filesystem cannot contain special devices
#Explanation: The nodev opition has not been set, or has been set incorrectly on /home


findmnt --kernel /home grep nosuid >> output.txt
if grep -E -q "/home.*nosuid" output.txt;
then
        echo -e "|1.1.7.3  | Ensure nosuid option set on /home partition                                                                    |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.7.3  | Ensure nosuid option set on /home partition\                                                                   | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.7.3 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files.
#Explanation: The nosuid opition has not been set, or has been set incorrectly on /home


findmnt --kernel /dev/shm | grep nodev>> output.txt
if grep -E -q "/dev/shm.*nodev" output.txt;
then
        echo -e "|1.1.8.1  | Ensure nodev option set on /dev/shm partition                                                                  |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.8.1  | Ensure nodev option set on /dev/shm partition                                                                  | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.8.1 "
fi
sudo rm -f output.txt
((total++))

#Description: The nodev mount option specifies that the filesystem cannot contain special devices
#Explanation: The nodev option has not been set, or has been set incorrectly on the /dev/shm partition


findmnt --kernel /dev/shm | grep noexec >> output.txt
if grep -E -q "/dev/shm.*noexec" output.txt;
then
        echo -e "|1.1.8.2  | Ensure noexec option set on /dev/shm partition                                                                 |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.8.2  | Ensure noexec option set on /dev/shm partition                                                                 | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.8.2 "
fi
sudo rm -f output.txt
((total++))

#Description: The noexec mount option specifies that the filesystem cannot contain executable binaries.
#Explanation: The noexec option has not been set, or has been set incorrectly on the /dev/shm partition


findmnt --kernel /dev/shm | grep nosuid >> output.txt
if grep -E -q "/dev/shm.*nosuid" output.txt;
then
        echo -e "|1.1.8.3  | Ensure nosuid option set on /dev/shm partition                                                                 |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.8.3  | Ensure nosuid option set on /dev/shm partition                                                                 | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.8.3 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files
#Explanation: The nosuid option has not been set, or has been set incorrectly on the /dev/shm partition


systemctl is-enabled autofs &> output.txt
if grep -q "failed to get unit file state for autofs.service: No such file or directory" output.txt;
then
        echo -e "|1.1.9    | Disable Automounting (Automated)                                                                               |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.1.9    | Disable Automounting (Automated)                                                                               | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.1.9 "
fi
sudo rm -f output.txt
((total++))

#Description: autofs allows automatic mounting of devices, typically including CD/DVDs and USB drives.
#Explanation: As a preference autofs should not be installed unless other packages depend on it


#dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' aide aide-common >> output.txt
: '
if grep -q "aide	install ok installed	installed" output.txt;
then
	if grep -q "aide-common	install ok installed	installed" output.txt;
	then
		echo -e "|1.3.1       |Ensure AIDE is installed                                                                                |${GREEN} PASS${NC}      |"
		tput init
		((pass_count++))
	else
		echo -e "|${RED}1.3.1       |Ensure AIDE is installed                                                                                | fail      ${NC}|"
        tput init
        ((fail_count++))
        failed_sections+="1.3.1 "
	fi
else
	echo -e "|${RED}1.3.1       |Ensure AIDE is installed                                                                                | fail      ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.3.1 "
fi
sudo rm -f output.txt
'
((total++))

 grep -Prs '^([^#\n\r]+\h+)?(\/usr\/s?bin\/|^\h*)aide(\.wrapper)?\h+(--check|([^#\n\r]+\h+)?\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/ >>output.txt
if grep -x -q "/etc/cron.daily/aide:aide --config="${CONFIG}" $AIDEARGS "--$COMMAND" >|"$ARUNLOG" 2>|"$AERRLOG" && ARETVAL="$?"" output.txt;
then
                echo -e "|1.3.2    | Ensure filesystem integrity is regularly checked                                                                |${GREEN}Pass${NC}             |"
		tput init
		((pass_count++))
        else
                systemctl is-enabled aidecheck.service &> output.txt
                systemctl is-enabled aidecheck.timer &> output.txt
                systemctl status aidecheck.timer &> output.txt
                if grep -q "failed to get unit file state for aidecheck.service: No such file or directory" output.txt;
                then
                        echo -e "|${RED}1.3.2    | Ensure filesystem integrity is regularly checked                                                               | Fail             ${NC}|"
			tput init
			((fail_count++))
			failed_sections+="1.3.2 "
                        #Explaination: failed to get unit file state for aidecheck.service: No such file or directory
                else
                        if grep -E -q "failed to get unit file state for aidecheck.timer: No such file or directory" output.txt;
                        then
                                echo -e "|${RED}1.3.2    | Ensure filesystem integrity is regularly checked                                                               | Fail             ${NC}|"
				tput init
				((fail_count++))
				failed_sections+="1.3.2 "
                                #Explaination: failed to get unit file state for aidecheck.timer: No such file or directory
                        else
                                if grep -q "Unit aidecheck.timer could not be found." output.txt;
                                        then
                                                echo -e "|${RED}1.3.2    | Ensure filesystem integrity is regularly checked                                                               | Fail             ${NC}|"
                                                #Explaination: Unit aidecheck.timer could not be found
                                        	tput init
						((fail_count++))
						failed_sections+="1.3.2 "
					else
                                                echo -e "|1.3.2    | Ensure filesystem integrity is regularly checked                                                               |${GREEN} Pass${NC}             |"
						tput init
						((pass_count++))
                                fi
                        fi
                fi
fi

sudo rm -f output.txt
((total++))
#Description:Periodic checking of the filesystem integrity is needed to detect changes to the filesystem


grep "^set superusers" /boot/grub/grub.cfg >> output.txt
grep "^password" /boot/grub/grub.cfg >>output.txt
if grep -E -q "superusers=.*password_pbkdf2" output.txt;
then
                echo -e "|1.4.1    | Ensure bootloader password is set                                                                             |${GREEN} Pass${NC}              |"
		tput init
		((pass_count++))
        elif grep -q "password_pbkdf2" output.txt;
        then
                echo -e "|${RED}1.4.1    | Ensure bootloader password is set                                                                              | Fail             ${NC}|"
		tput init
		((fail_count++))
		failed_sections+="1.4.1 "
                #Explanation: Superusers is not set.
        elif grep -q "superusers=" output.txt;
        then
                echo -e "|${RED}1.4.1    | Ensure bootloader password is set                                                                              | Fail             ${NC}|"
		tput init
		((fail_count++))
		failed_sections+="1.4.1 "
                #Explanation: Encrypted password is not set
        else
                echo -e "|${RED}1.4.1    | Ensure bootloader password is set                                                                              | Fail             ${NC}|"
		tput init
		((fail_count++))
		failed_sections+="1.4.1 "
                #Explanation: Superusers and encrypted passwords are not set.
fi
sudo rm -f output.txt
((total++))
#Description:Setting the boot loader password will require that anyone rebooting the system must enter a password before being able to set command line boot parameters


stat /boot/grub/grub.cfg >> output.txt
if grep -x -q "Access: (0400/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)" output.txt;
then
        echo -e "|1.4.2    | Ensure permissions on bootloader config are configured                                                         |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.4.2    | Ensure permissions on bootloader config are configured                                                         | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.4.2 "
fi
sudo rm -f output.txt
((total++))
#Description: The grub configuration file contains information on boot settings and passwords for unlocking boot options
#Explanation: The grub confirgurations have not been set, or has been set incorrectly.


grep -Eq '^root:\$[0-9]' /etc/shadow || echo "root is locked" >> output.txt
if grep -q "root is locked" output.txt;
then
        echo -e "|${RED}1.4.3    | Ensure authentication required for single user mode                                                            | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.4.3 "
else
        echo -e "|1.4.3    | Ensure authentication required for single user mode                                                            |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
fi
sudo rm -f output.txt
#Description: Single user mode is used for recovery when the system detects an issue during boot or by manual selection from the bootloader
#Explanation: root user password is not set
((total++))

sysctl kernel.randomize_va_space >> output.txt
if grep -x -q "kernel.randomize_va_space = 2" output.txt;
then
        echo -e "|1.5.1    | Ensure address space layout randomization (ASLR) is enabled                                                    |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
        echo -e "|${RED}1.5.1    | Ensure address space layout randomization (ASLR) is enabled                                                    | Fail             ${NC}|"
	((fail_count++))
	failed_sections+="1.5.1 "
fi
sudo rm -f output.txt
((total++))
#Description: Address space layout randomization (ASLR) is an exploit mitigation technique which randomly arranges the address space of key data areas of a process

#Explanation: kernel.randomize_va_space is not set to 2





dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' >> output.txt
if grep -q -E "prelink.*not-installed" output.txt;
then
	echo -e "|1.5.2    | Ensure prelink is not installed (Automated)                                                                    |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
	echo -e "|${RED}1.5.2    | Ensure prelink is not installed (Automated)                                                                    | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.5.2 "
fi
sudo rm -f output.txt
((total++))





dpkg-query -s apport > /dev/null 2>&1 && grep -Psi -- '^\h*enabled\h*=\h*[^0]\b' /etc/default/apport >> output.txt

output=output.txt
if [ $(wc -l < "${output}") -eq 0 ]; then
        systemctl is-active apport.service | grep '^active' >> output.txt
        if grep -q "active" output.txt;
        then
                echo -e "|${RED}1.5.3    | Ensure Automatic Error Reporting is not enabled (Automated)                                                    | Fail             ${NC}|"
                ((fail_count++))
		failed_sections+="1.5.3 "
		#Explanation: service 'apport' is still actiive
        else
                echo -e "|1.5.3    | Ensure Automatic Error Reporting is not enabled (Automated)                                                    |${GREEN} Pass${NC}             |"
                tput init
		((pass_count++))
		#Explnation: Automatic error reporting is not enabled
        fi
else
    echo -e "|${RED}1.5.3    | Ensure Automatic Error Reporting is not enabled (Automated)                                                    | Fail             ${NC}|"
    #Explanation: apport is enabled
    ((fail_count++))
    failed_sections+="1.5.3 "
fi
sudo rm -f output.txt
#Description:Apport collects potentially sensitive data, such as core dumps, stack traces, and log files. They can contain passwords, cREDit card numbers, serial numbers, and other private material
((total++))

grep -Es '^(\*|\s).*hard.*core.*(\s+#.*)?$' /etc/security/limits.conf /etc/security/limits.d/* >> output.txt
sysctl fs.suid_dumpable >> output.txt
grep "fs.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/* >> output.txt

if grep -E '* hard core 0.*fs.suid_dumpable = 0.*fs.suid_dumpable = 0' output.txt;
then
        systemctl is-enabled coREDump.service >> output.txt
        if grep -E 'enabled|masked|disabled' output.txt;
        then
                echo -e "|1.5.4    | Ensure core dumps are restricted (Automated)                                                                   |${GREEN} Pass${NC}             |"
                tput init
		((pass_count++))
		#Explanation: Core dumps are restricted
        else
                echo -e "|${RED}1.5.4    | Ensure core dumps are restricted (Automated)                                                                   | Fail             ${NC}|"
                #Explanation: systemd-coREDump is not installed
		((fail_count++))
		failed_sections+="1.5.4 "
        fi
else
        echo -e "|${RED}1.5.4    | Ensure core dumps are restricted (Automated)                                                                   | Fail             ${NC}|"
        #coREDump parameters are not set, or are set incorrectly
	((fail_count++))
	failed_sections+="1.5.4 "
fi
tput init
sudo rm -f output.txt
((total++))
#Description:Setting a hard limit on core dumps prevents users from overriding the soft variable




dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' apparmor >> output.txt
if grep -q -E "apparmor	install ok installed	installed" output.txt;
then
	echo -e "|1.6.1.1  | Ensure AppArmor is installed (Automated)                                                                       |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
	echo -e "|${RED}1.6.1.1  | Ensure AppArmor is installed (Automated)                                                                       | Fail             ${NC}|"
	((fail_count++))
	failed_sections+="1.6.1.1 "
fi
sudo rm -f output.txt
((total++))


outputfile=output.txt
grep "^\s*linux" /boot/grub/grub.cfg | grep -v "apparmor=1" >> output.txt
if [ $(wc -l < "${outputfile}") -eq 0 ]; then
    grep "^\s*linux" /boot/grub/grub.cfg | grep -v "security=apparmor" >> output.txt
    if [ $(wc -l < "${outputfile}") -eq 0 ]; then
	    echo -e "|1.6.1.2  | Ensure AppArmor is enabled in the bootloader configuration (Automated)                                         |${GREEN}Pass${NC}              |"
    		tput init
		((pass_count++))
    else
	    echo -e "|${RED}1.6.1.2  | Ensure AppArmor is enabled in the bootloader configuration (Automated)                                         | Fail             ${NC}|"
	   ((fail_count++))
	   failed_sections+="1.6.1.2 "
		 #Explanation: variable 'security=apparmor' has not been set, or has been set incorrectly
    fi
else
    echo -e "|${RED}1.6.1.2  | Ensure AppArmor is enabled in the bootloader configuration (Automated)                                         | Fail             ${NC}|"
    #Explanation: variable apparmor=1' has not been set, or has been set incorrectly
    ((fail_count++))
failed_sections+="1.6.1.2 "
fi
sudo rm -f output.txt
((total++))
#Description:Configure AppArmor to be enabled at boot time and verify that it has not been overwritten by the bootloader boot parameters





apparmor_status | grep profiles >> output.txt
if grep -q -E "0 profiles are in kill mode." output.txt;
then
	if grep -q -E "0 profiles are in unconfined mode." output.txt;
	then
		apparmor_status | grep processes | grep unconfined >> output.txt
		if grep -q -E "0 processes are unconfined" output.txt;
		then
			echo -e "|1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                                       |${GREEN} Pass${NC}             |"
			((pass_count++))
		else
			echo -e "|${RED}1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                                       | Fail             ${NC}|"
			tput init
			((fail_count++))
			failed_sections+="1.6.1.3 "
			#Explanation: There are unconfined processes.
		fi
	else
		echo -e "|${RED}1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                                       | Fail             ${NC}|"
		tput init
		((fail_count++))
		failed_sections+="1.6.1.3 "
		#Explanation: There are processes in unconfined mode.
	fi
else
	echo -e "|${RED}1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                                       | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.6.1.3 "
	#Explanation: There are profiles in kill mode.
fi
sudo rm -f output.txt
((total++))




apparmor_status | grep profiles >> output.txt
if grep -q -E "0 profiles are in complain mode." output.txt;
then
	if grep -q -E "0 profiles are in kill mode." output.txt;
	then
		if grep -q -E "0 profiles are in unconfined mode." output.txt;
		then
			apparmor_status | grep processes | grep unconfined >> output.txt
			if grep -q -E "0 processes are unconfined" output.txt;
			then
				echo -e "|1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                                         |${GREEN} Pass${NC}             |"
				((pass_count++))
			else
				echo -e "|${RED}1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                                         | Fail             ${NC}|"
				tput init
				((fail_count++))
				failed_sections+="1.6.1.4 "
				#Explanation: There are unconfined processes.
			fi
		else
			echo -e "|${RED}1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                                         | Fail             ${NC}|"
			tput init
			((fail_count++))
			failed_sections+="1.6.1.4 "
			#Explanation: There are profiles in unconfined mode.
		fi
	else
		echo -e "|${RED}1.6.1.4     | Ensure all AppArmor Profiles are enforcing (Automated)                                                      | Fail             ${NC}|"
		tput init
		((fail_count++))
		failed_sections+="1.6.1.4 "
		#Explanation: There are profiles in kill mode.
	fi
else
	echo -e "|${RED}1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                                         | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.6.1.4 "
	#Explanation: There are profiles in complain mode.
fi
sudo rm -f output.txt
((total++))



outputtxt=output.txt
grep -Eis "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd >> output.txt
if [ $(wc -l < "${outputtxt}") -eq 0 ]; then
    echo -e "|1.7.1    | Ensure message of the day is configured properly (Automated)                                                   |${GREEN} Pass${NC}             |"
    tput init
    ((pass_count++))
else
    echo "|${RED}1.7.1    | Ensure message of the day is configured properly (Automated)                                                      | Fail             ${NC}|"
	((fail_count++))
	failed_sections+="1.7.1 "
fi
sudo rm -f output.txt
((total++))




grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue >> output.txt
outputbanner=output.txt
if [ $(wc -l < "${outputbanner}") -eq 0 ]; then
	echo -e "|1.7.2    | Ensure local login warning banner is configured properly (Automated)                                           |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
	echo -e "|${RED}1.7.2    | Ensure local login warning banner is configured properly (Automated)                                           | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.7.2 "
	#Explanation: Login banner is not configured properly
fi
sudo rm -f output.txt
((total++))



grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue.net >> output.txt
outputremotebanner=output.txt
if [ $(wc -l < "${outputremotebanner}") -eq 0 ]; then
	cat /etc/issue.net >> output.txt
	if grep -q "Ubuntu 22.04.2 LTS" output.txt
	then
		echo -e "|${RED}1.7.3    | Ensure remote login warning banner is configured properly (Automated)                                          | Fail             ${NC}|"
		tput init
		((fail_count++))
		failed_sections+="1.7.3 "

		#Explanation: Warning banner displays OS information
	else
	        echo -e "|1.7.3    | Ensure remote login warning banner is configured properly (Automated)                                          |${GREEN} Pass${NC}             |"
		tput init
		((pass_count++))
	fi
else
    echo -e "|${RED}1.7.3    | Ensure remote login warning banner is configured properly (Automated)                                          | Fail             ${NC}|"
    tput init
    ((fail_count++))
    failed_sections+="1.7.3 "
    #Explanation: Remote login banner is not configured properly
fi
sudo rm -f output.txt
#Description: The contents of the /etc/issue.net file are displayed to users prior to login for remote connections from configured services. Warning messages inform users who are attempting to login to the system of their legal status regarding the system and must include the name of the organization that owns the system and any monitoring policies that are in place. Displaying OS and patch level information in login banners also has the side effect of providing detailed system information to attackers attempting to target specific exploits of a system.
((total++))




stat -L /etc/motd &> output.txt
if grep -q -E "stat: cannot statx '/etc/motd': No such file or directory|Access: (0644/-rw-r--r--) Uid: (0/	root)	Gid: (	0/	root)" output.txt;
then
	echo -e "|1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                                     |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
	echo -e "|${RED}1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                                     | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.7.4 "
	#Explanation: Uid and/or Gid are not set to 0/root, and/or Access is not set to 644
fi
sudo rm -f output.txt
#Description:The contents of the /etc/motd file are displayed to users after login and function as a message of the day for authenticated users. If the /etc/motd file does not have the correct ownership it could be modified by unauthorized users with incorrect or misleading information.
((total++))




stat -L /etc/issue >> output.txt
if grep -q "Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)" output.txt;
then
	echo -e "|1.7.5    | Ensure permissions on /etc/issue are configured (Automated)                                                    |${GREEN} Pass${NC}             |"
	tput init
	((pass_count++))
else
	echo -e "|${RED}1.7.5    | Ensure permissions on /etc/issue are configured (Automated)                                                    | Fail             ${NC}|"
	tput init
	((fail_count++))
	failed_sections+="1.7.5 "
	#Explanation: Permissions have not been set, or have been set incorrectly for /etc/issue.
fi
sudo rm -f output.txt
#Description: The contents of the /etc/issue file are displayed to users prior to login for local terminals. If the /etc/issue file does not have the correct ownership it could be modified by unauthorized users with incorrect or misleading information.
((total++))



stat -L /etc/issue.net >> output.txt
if grep -q "Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)" output.txt;
then
        echo -e "|1.7.6    | Ensure permissions on /etc/issue.net are configured (Automated)                                                |${GREEN} Pass${NC}             |"
        tput init
	((pass_count++))
else
        echo -e "|${RED}1.7.6    | Ensure permissions on /etc/issue.net are configured (Automated)                                                | Fail             ${NC}|"
        tput init
	((fail_count++))
	failed_sections+="1.7.6 "
        #Explanation: Permissions have not been set, or have been set incorrectly for /etc/issue.net.
fi
sudo rm -f output.txt
#Description: The contents of the /etc/issue.net file are displayed to users prior to login for local terminals. If the /etc/issue.net file does not have the correct ownership it could be modified by unauthorized users with incorrect or misleading information.
((total++))




dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' gdm3 >> output.txt
if grep -q "gdm3	install ok not-installed	not-installed" output.txt
then
       	echo -e "|1.8.1    | Ensure GNOME Display Manager is removed (Automated)                                                            |${GREEN} Pass             ${NC}|"
        tput init
	((pass_count++))
else
        echo -e "|${RED}1.8.1    | Ensure GNOME Display Manager is removed (Automated)                                                            | Fail             ${NC}|"
        tput init
	((fail_count++))
	failed_sections+="1.8.1 "
        #Explanation: The GNOME GUI is installed on the system.
fi
sudo rm -f output.txt
#Decription: If a Graphical User Interface (GUI) is not required, it should be removed to REDuce the attack surface of the system.
((total++))




grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm3/custom.conf >> output.txt
outputxdcmp=output.txt
if [ $(wc -l < "${outputxdcmp}") -eq 0 ]; then
    echo -e "|1.8.10   | Ensure XDCMP is not enabled (Automated)                                                                        |${GREEN} Pass${NC}             |"
    tput init
    ((pass_count++))
else
    echo -e "|${RED}1.8.10   | Ensure XDCMP is not enabled (Automated)                                                                        | Fail             ${NC}|"
    tput init
    ((fail_count++))
    failed_sections+="1.8.10 "
fi
sudo rm -f output.txt
((total++))




apt -s upgrade &> output.txt
outputupgrade=output.txt
if [ $(wc -l < "${outputupgrade}") -eq 0 ]; then
    echo -e "|1.9      | Ensure updates, patches, and additional security software are installed (Manual)                               |${GREEN} Pass${NC}             |"
    tput init
    ((pass_count++))
else
    echo -e "|${RED}1.9      | Ensure updates, patches, and additional security software are installed (Manual)                               | Fail             ${NC}|"
    tput init
    ((fail_count++))
    failed_sections+="1.9 "
fi
sudo rm -f output.txt
((total++))

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

# Section 2.2
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





# Section 6
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                           6 System Maintainence                                                             |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Section 6.1
    echo "|6.1      | System File Permissions                                                                                        |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Audit Title 6.1.1
expected_permissions="644"
expected_uid="0"
expected_gid="0"
audit=$(stat /etc/passwd | grep -E 'Access:|Uid:|Gid:' | sed '2d')
permissions=$(stat -c %a /etc/passwd)
uid=$(stat -c %u /etc/passwd)
gid=$(stat -c %g /etc/passwd)

if [[ "$permissions" == "$expected_permissions" && "$uid" == "$expected_uid" && "$gid" == "$expected_gid" ]]; then
    echo -e "|6.1.1    | Ensure permissions on /etc/passwd are configured (Automated)                                                   |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.1    | Ensure permissions on /etc/passwd are configured (Automated)                                                   | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.1 "
fi
    ((total++))

# Audit Title: 6.1.2
benchmark_title="6.1.2 Ensure permissions on /etc/passwd- are configured (Automated)"
expected_permissions="644"
expected_uid="0"
expected_gid="0"
audit=$(stat /etc/passwd- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
permissions=$(stat -c %a /etc/passwd-)
uid=$(stat -c %u /etc/passwd-)
gid=$(stat -c %g /etc/passwd-)

if [[ "$permissions" -le "$expected_permissions" && "$uid" -eq "$expected_uid" && "$gid" -eq "$expected_gid" ]]; then
    echo -e "|6.1.2    | Ensure permissions on /etc/passwd- are configured (Automated)                                                  |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.2    | Ensure permissions on /etc/passwd- are configured (Automated)                                                  | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.2 "
fi
    ((total++))

# Audit Title 6.1.3
benchmark_title="6.1.3 Ensure permissions on /etc/group are configured (Automated)"
expected_permissions="644"
expected_uid="0"
expected_gid="0"
audit=$(stat /etc/group | grep -E 'Access:|Uid:|Gid:' | sed '2d')
permissions=$(stat -c %a /etc/group)
uid=$(stat -c %u /etc/group)
gid=$(stat -c %g /etc/group)

if [[ "$permissions" == "$expected_permissions" && "$uid" == "$expected_uid" && "$gid" == "$expected_gid" ]]; then
    echo -e "|6.1.3    | Ensure permissions on /etc/group are configured (Automated)                                                    |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.3    | Ensure permissions on /etc/group are configured (Automated)                                                    | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.3 "
fi
    ((total++))

# Audit Title 6.1.4
benchmark_title="6.1.4 Ensure permissions on /etc/group- are configured (Automated)"
expected_permissions="644"
expected_uid="0"
expected_gid="0"
audit=$(stat /etc/group- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
permissions=$(stat -c %a /etc/group-)
uid=$(stat -c %u /etc/group-)
gid=$(stat -c %g /etc/group-)

if [[ "$permissions" -le "$expected_permissions" && "$uid" -eq "$expected_uid" && "$gid" -eq "$expected_gid" ]]; then
    echo -e "|6.1.4    | Ensure permissions on /etc/group- are configured (Automated)                                                   |${GREEN} Pass${NC}             |" 
    ((pass_count++))
else
    echo -e "|${RED}6.1.4   | Ensure permissions on /etc/group- are configured (Automated)                                                   | Fail              ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.4 "
fi
    ((total++))


# Audit Title 6.1.5
benchmark_title="6.1.5 Ensure permissions on /etc/shadow are configured (Automated)"
expected_permissions="640"
expected_uid=0
expected_gid=0,42
audit=$(stat /etc/shadow | grep -E 'Access:|Uid:|Gid:' | sed '2d')
permissions=$(stat -c %a /etc/shadow)
uid=$(stat -c %u /etc/shadow)
gid=$(stat -c %g /etc/shadow)

if [[ "$permissions" -le "$expected_permissions" && "$uid" -eq "$expected_uid" && "$gid" -eq "$expected_gid" ]]; then
    echo -e "|6.1.5    | Ensure permissions on /etc/shadow are configured (Automated)                                                   |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.5    | Ensure permissions on /etc/shadow are configured (Automated)                                                   | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.5 "
fi
    ((total++))


# Audit Title 6.1.6
benchmark_title="6.1.6 Ensure permissions on /etc/shadow- are configured (Automated)"
expected_permissions="640"
expected_uid=0
expected_gid=0,42
audit=$(stat /etc/shadow- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
permissions=$(stat -c %a /etc/shadow-)
uid=$(stat -c %u /etc/shadow-)
gid=$(stat -c %g /etc/shadow-)

if [[ "$permissions" -le "$expected_permissions" && "$uid" -eq "$expected_uid" && "$gid" -eq "$expected_gid" ]]; then
    echo -e "|6.1.6    | Ensure permissions on /etc/shadow- are configured (Automated)                                                  |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.6    | Ensure permissions on /etc/shadow- are configured (Automated)                                                  | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.6 "
fi
    ((total++))

# Audit Title 6.1.7
benchmark_title="6.1.7 Ensure permissions on /etc/gshadow are configured (Automated)"
expected_permissions="640"
expected_uid=0
expected_gid=0,42
audit=$(stat /etc/gshadow | grep -E 'Access:|Uid:|Gid:' | sed '2d')
permissions=$(stat -c %a /etc/gshadow)
uid=$(stat -c %u /etc/gshadow)
gid=$(stat -c %g /etc/gshadow)

if [[ "$permissions" -le "$expected_permissions" && "$uid" -eq "$expected_uid" && "$gid" -eq "$expected_gid" ]]; then
    echo -e "|6.1.7    | Ensure permissions on /etc/gshadow are configured (Automated)                                                  |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.7    | Ensure permissions on /etc/gshadow are configured (Automated)                                                  | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.7 "
fi
    ((total++))

# Audit Title 6.1.8
benchmark_title="6.1.8 Ensure permissions on /etc/gshadow- are configured (Automated)"
expected_permissions="640"
expected_uid=0
expected_gid=0,42
audit=$(stat /etc/gshadow- | grep -E 'Access:|Uid:|Gid:' | sed '2d')
permissions=$(stat -c %a /etc/gshadow-)
uid=$(stat -c %u /etc/gshadow-)
gid=$(stat -c %g /etc/gshadow-)

if [[ "$permissions" -le "$expected_permissions" && "$uid" -eq "$expected_uid" && "$gid" -eq "$expected_gid" ]]; then
    echo -e "|6.1.8    | Ensure permissions on /etc/gshadow- are configured (Automated)                                                 |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.8    | Ensure permissions on /etc/gshadow- are configured (Automated)                                                 | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.8 "
fi
    ((total++))

# Audit Title 6.1.9
benchmark_title="6.1.9 Ensure no world writable files exist (Automated)"
audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002)

if [[ -z "$audit" ]]; then
    echo -e "|6.1.9    | Ensure no world writable files exist (Automated)                                                               |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.9    | Ensure no world writable files exist (Automated)                                                               | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.9 "
fi
    ((total++))


# Audit Title 6.1.10
benchmark_title="6.1.10 Ensure no unowned files or directories exist (Automated)"
audit=$( df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -nouser)

if [[ -z "$audit" ]]; then
    echo -e "|6.1.10   | Ensure no unowned files or directories exist (Automated)                                                       |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.10   | Ensure no unowned files or directories exist (Automated)                                                       | Fail             ${NC}|"	
    ((fail_count++))
    failed_sections+="6.1.10 "
fi
    ((total++))


# Audit Title 6.1.11
benchmark_title="6.1.11 Ensure no ungrouped files or directories exist (Automated)"
audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -nogroup)

if [[ -z "$audit" ]]; then
    echo -e "|6.1.11   | Ensure no ungrouped files or directories exist (Automated)                                                     |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.11   | Ensure no ungrouped files or directories exist (Automated)                                                     | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.11 "
fi
    ((total++))


# Audit Title 6.1.12
benchmark_title="6.1.12 Audit SUID executables (Manual)"
audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000)

if [[ -z "$audit" ]]; then
    echo -e "|6.1.12   | Audit SUID executables (Manual)                                                                                |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.12   | Audit SUID executables (Manual)                                                                                | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.12 "
fi
    ((total++))


# Audit Title 6.1.13
benchmark_title="6.1.13 Audit SGID executables (Manual)"
audit=$(df --local -P | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000)

if [[ -z "$audit" ]]; then
    echo -e "|6.1.13   | Audit SGID executables (Manual)                                                                                |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.1.13   | Audit SGID executables (Manual)                                                                                | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.1.13 "
fi
    ((total++))

# Section 6.2
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|6.2      | Local User and Group Settings                                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


# Audit Title 6.2.1
benchmark_title="6.2.1 Ensure accounts in /etc/passwd use shadowed passwords (Automated)"
audit=$(awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd)

if [[ -z "$audit" ]]; then
    echo -e "|6.2.1    | Ensure accounts in /etc/passwd use shadowed passwords (Automated)                                              |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.1    | Ensure accounts in /etc/passwd use shadowed passwords (Automated)                                              | Fail             ${NC}|"
    ((fail_count++)) 
    failed_sections+="6.2.1 "
fi
    ((total++))


# Audit Title 6.2.2
benchmark_title="6.2.2 Ensure /etc/shadow password fields are not empty (Automated)"
audit=$( awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow)

if [[ -z "$audit" ]]; then
    echo -e "|6.2.2    | Ensure /etc/shadow password fields are not empty (Automated)                                                   |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.2    | Ensure /etc/shadow password fields are not empty (Automated)                                                   | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.2 "
fi
    ((total++))



# Audit Title 6.2.3
benchmark_title="6.2.3 Ensure all groups in /etc/passwd exist in /etc/group (Automated)"
# Defining missing groups
missing_groups=0

for i in $(cut -s -d: -f4 /etc/passwd | sort -u); do
  grep -q -P "^.*?:[^:]*:$i:" /etc/group
  if [ $? -ne 0 ]; then
    missing_groups=1
    break
  fi
done

if [ $missing_groups -eq 0 ]; then
    echo -e "|6.2.3    | Ensure all groups in /etc/passwd exist in /etc/group (Automated)                                               |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.3    | Ensure all groups in /etc/passwd exist in /etc/group (Automated)                                               | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.3 "
fi
    ((total++))


# Audit Title 6.2.4
benchmark_title="6.2.4 Ensure shadow group is empty (Automated)"
audit1=$(awk -F: '($1=="shadow") {print $NF}' /etc/group)
audit2=$(awk -F: -v GID="$(awk -F: '($1=="shadow") {print $3}' /etc/group)" '($4==GID) {print $1}' /etc/passwd)

if [ -z "$audit1" ] && [ -z "$audit2" ]; then
    echo -e "|6.2.4    | Ensure shadow group is empty (Automated)                                                                       |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.4    | Ensure shadow group is empty (Automated)                                                                       | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.4 "

fi
    ((total++))


# Audit Title 6.2.5
benchmark_title="6.2.5 Ensure no duplicate UIDs exist (Automated)"
duplicate_uids=$(cut -f3 -d":" /etc/passwd | sort -n | uniq -d)

if [ -z "$duplicate_uids" ]; then
    echo -e "|6.2.5    | Ensure no duplicate UIDs exist (Automated)                                                                     |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.5    | Ensure no duplicate UIDs exist (Automated)                                                                     | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.5 "
fi
    ((total++))

# Audit Title 6.2.6
benchmark_title="6.2.6 Ensure no duplicate GIDs exist (Automated)"
audit=$(cut -d: -f3 /etc/group | sort | uniq -d)

if [ -z "$audit" ]; then
    echo -e "|6.2.6    | Ensure no duplicate GIDs exist (Automated)                                                                     |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.6    | Ensure no duplicate GIDs exist (Automated)                                                                     | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.6 "
fi
    ((total++))


# Audit Title 6.2.7
benchmark_title="6.2.7 Ensure no duplicate user names exist (Automated)"
audit=$(cut -d: -f1 /etc/passwd | sort | uniq -d)

if [ -z "$audit" ]; then
    echo -e "|6.2.7    | Ensure no duplicate user names exist (Automated)                                                               |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.7    | Ensure no duplicate user names exist (Automated)                                                               | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.7 "
fi
    ((total++))


# Audit Title 6.2.8
benchmark_title="6.2.8 Ensure no duplicate group names exist (Automated)"
audit=$(cut -d: -f1 /etc/group | sort | uniq -d)

if [ -z "$audit" ]; then
    echo -e "|6.2.8    | Ensure no duplicate group names exist (Automated)                                                              |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.8    | Ensure no duplicate group names exist (Automated)                                                              | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.8 "
fi
    ((total++))


# Audit Title 6.2.9
benchmark_title="6.2.9 Ensure root PATH Integrity (Automated)"
audit=$(
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
if [[ -z $audit ]]; then
    echo -e "|6.2.9    | Ensure root PATH Intergity (Automated)                                                                         |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.9    | Ensure root PATH Integrity (Automated)                                                                         | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.9 "
fi
    ((total++))


# Audit Title 6.2.10
benchmark_title="6.2.10 Ensure root is the only UID 0 account (Automated)"
audit=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)

if [ "$audit" == "root" ]; then
    echo -e "|6.2.10   | Ensure root is the only UID 0 account (Automated)                                                              |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.10   | Ensure root is the only UID 0 account (Automated)                                                              | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.10 "
fi
    ((total++))


# Audit Title 6.2.11
benchmark_title="6.2.11 Ensure local interactive user home directories exist (Automated)"
audit=$(
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  [ ! -d "$home" ] && output="$output\n  - User \"$user\" home directory \"$home\" doesn't exist"
done
)
if [ -z "$audit" ]; then
    echo -e "|6.2.11   | Ensure local interactive user home directories exist (Automated)                                               |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.11   | Ensure local interactive user home directories exist (Automated)                                               | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.11 "
fi
    ((total++))


# Audit Title 6.2.12
benchmark_title="6.2.12 Ensure local interactive users own their home directories (Automated)"
output=""
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  owner="$(stat -L -c "%U" "$home")"
  [ "$owner" != "$user" ] && output="$output\n  - User \"$user\" home directory \"$home\" is owned by user \"$owner\""
done

if [ -z "$output" ]; then
    echo -e "|6.2.12   | Ensure local interactive user own their home directories (Automated)                                           |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.12   | Ensure local interactive user own their home directories (Automated)                                           | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.12 "
fi
    ((total++))


# Audit Title 6.2.13
benchmark_title="6.2.13 Ensure local interactive user home directories are mode 750 or more restrictive (Automated)"
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
done

if [ -z "$output" ]; then
    echo -e "|6.2.13   | Ensure local interactive user home directories are mode 750 or more restrictive (Automated)                    |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.13   | Ensure local interactive user home directories are mode 750 or more restrictive (Automated)                    | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.13 "
fi
    ((total++))


# Audit Title 6.2.14
benchmark_title="6.2.14 Ensure no local interactive user has .netrc files (Automated)"
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
done

if [ -z "$output" ]; then
  if [ -z "$output2" ]; then
    echo -e "|6.2.14   | Ensure no local interactive user has .netrc files (Automated)                                                  |${GREEN} Pass${NC}             |"
    ((pass_count++))
  else
    echo -e "|${RED}6.2.14   | Ensure no local interactive user has .netrc files (Automated)                                                  | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.14 "
  fi
else
    echo -e "|${RED}6.2.14   | Ensure no local interactive user has .netrc files (Automated)                                                  | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.14 "
fi
    ((total++))

# Audit Title 6.2.15
benchmark_title="6.2.15 Ensure no local interactive user has .forward files (Automated)"
output=""
fname=".forward"
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  [ -f "$home/$fname" ] && output="$output\n  - User \"$user\" file: \"$home/$fname\" exists"
done

if [ -z "$output" ]; then
    echo -e "|6.2.15   | Ensure no local interactive user has .forward files (Automated)                                                |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.15   | Ensure no local interactive user has .forward files (Automated)                                                | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.15 "
fi
    ((total++))


# Audit Title 6.2.16
benchmark_title="6.2.16 Ensure no local interactive user has .rhosts files (Automated)"
output=""
fname=".rhosts"
valid_shells="^($(sed -rn '/^\//{s,/,\\\\/,g;p}' /etc/shells | paste -s -d '|' -))$"

awk -v pat="$valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd |
while read -r user home; do
  [ -f "$home/$fname" ] && output="$output\n  - User \"$user\" file: \"$home/$fname\" exists"
done

if [ -z "$output" ]; then
    echo -e "|6.2.16   | Ensure no local interactive user has .rhosts files (Automated)                                                 |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.16   | Ensure no local interactive user has .rhosts files (Automated)                                                 | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.16 "
fi
    ((total++))

# Audit Title 6.2.17
benchmark_title="6.2.17 Ensure local interactive user dot files are not group or world writable (Automated)"
output=""
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

if [ -z "$output" ]; then
    echo -e "|6.2.17   | Ensure local interactive user dot files are not group or world writable (Automated)                            |${GREEN} Pass${NC}             |"
    ((pass_count++))
else
    echo -e "|${RED}6.2.17   | Ensure local interactive user dot files are not group or world writable (Automated)                            | Fail             ${NC}|"
    ((fail_count++))
    failed_sections+="6.2.17 "
fi
    ((total++))


echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


# Display Summary
summary_line="| ${YELLOW}Audit Results Summary${NC}                                                                                                                       |"
total_audits="| Total Audits: ${total}"
pass="|${GREEN} Pass${NC} Count: ${GREEN}${pass_count}${NC}/${total}"
fail="|${red} fail${NC} Count: ${red}${fail_count}${NC}/${total}"
NA="|${BLUE} Not-Accessed${NC} Count: ${BLUE}${not_accessed}${NC}/${total}"

echo -e "$summary_line"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "$total_audits"
echo -e "$pass"
echo -e "$fail"
echo -e "$NA"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


# Check if all sections are compliant
if [ "$fail_count" -eq 0 ]; then
    exit 0  # Exit the script if all sections are compliant
fi

#./fails2.sh "$1"
# Prompt user for more details on failures
read -p "                                       Do you want to see more details on the failed sections? (y/n): " choice
if [[ $choice == "y" ]]; then
    path_to_fails="./fails.sh"
    echo
    display_failed_sections "$path_to_fails"
else 
    echo -e "\nYou have decided to not see more details on the failed sections."
    echo -e "\nThank you for utilizing our audit tool to enhance your system's security and adherence to standards."
    echo -e "\nClosing..."
fi
    # Ask user if they want to remediate
#    read -p "Do you want to remediate the failed sections? (y/n): " remediate_choice
#    if [[ $remediate_choice == "y" ]]; then
#	read -p "Are You Sure? (y/n): " remediate_choice
#	if [[ $remediate_choice == "y" ]]; then
#            for section in $failed_sections; do
#            remediate_section "$section"
#           done
#	fi
#    fi
#fi
