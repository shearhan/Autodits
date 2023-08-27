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
	    "1.1.2.1") $fails_script 1.1.2.1;;
	    "1.1.2.1") $fails_script 1.1.2.1;;
                "1.1.2.2") $fails_script 1.1.2.1;;
                "1.1.2.3") $fails_script 1.1.2.3;;
                "1.1.2.4") $fails_script 1.1.2.2;;
                "1.1.3.1") $fails_script 1.1.3.1;;
                "1.1.3.2") $fails_script 1.1.3.2;;
                "1.1.3.3") $fails_script 1.1.3.3;;
                "1.1.4.1") $fails_script 1.1.4.1;;
                "1.1.4.2") $fails_script 1.1.4.2;;
                "1.1.4.3") $fails_script 1.1.4.3;;
                "1.1.4.4") $fails_script 1.1.4.4;;
                "1.1.5.1") $fails_script 1.1.5.1;;
                "1.1.5.2") $fails_script 1.1.5.2;;
                "1.1.5.3") $fails_script 1.1.5.3;;
                "1.1.5.4") $fails_script 1.1.5.4;;
                "1.1.6.1") $fails_script 1.1.6.1;;
		"1.1.6.2") $fails_script 1.1.6.2;;
                "1.1.6.3") $fails_script 1.1.6.3;;
                "1.1.6.4") $fails_script 1.1.6.4;;
                "1.1.7.1") $fails_script 1.1.7.1;;
                "1.1.7.2") $fails_script 1.1.7.2;;
                "1.1.7.3") $fails_script 1.1.7.3;;
                "1.1.8.1") $fails_script 1.1.8.1;;
                "1.1.8.2") $fails_script 1.1.8.2;;
                "1.1.8.3") $fails_script 1.1.8.3;;
                "1.1.9")  $fails_script 1.1.9;;
                "1.1.10") $fails_script 1.1.10;;
                "1.3.1")  $fails_script 1.3.1;;
                "1.3.2") $fails_script 1.3.2;;
                "1.4.1") $fails_script 1.4.1;;
                #"1.4.12") $initialsetupfail 1.4.11;;
                #"1.4.12") $initialsetupfail 1.4.12;;
                #"1.4.13") $initialsetupfail 1.4.3;;
                "1.4.2") $fails_script 1.4.2;;
                "1.4.3") $fails_script 1.4.3;;
                "1.5.1") $fails_script 1.5.1;;
                "1.5.2") $fails_script 1.5.2;;
                "1.5.3") $fails_script 1.5.3;;
                "1.5.4") $fails_script 1.5.4;;
		"1.6.1.1") $fails_script 1.6.1.1;;
                "1.6.1.2") $fails_script 1.6.1.2;;
                "1.6.1.3") $fails_script 1.6.1.3;;
                "1.6.1.4") $fails_script 1.6.1.4;;
                "1.7.1") $fails_script 1.7.1;;
                "1.7.2") $fails_script 1.7.2;;
                "1.7.3") $fails_script 1.7.3;;
                "1.7.4") $fails_script 1.7.4;;
                "1.7.5") $fails_script 1.7.5;;
                "1.7.6") $fails_script 1.7.6;;
                "1.8.1") $fails_script 1.8.1;;
                "1.8.10") $fails_script 1.8.10;;
                "1.9") $fails_script 1.9;;
                            # Add more cases for other sections if needed
            *) echo "Invalid section: $section" ;;
        esac
        echo
    done
}





#echo
#echo -e "${red2}*** DISCLAIMER: This automated audit tool is designed to assist in evaluating the security configuration of your system, use at your own risk. ***${NC}"
#echo -e "${red2}*** NOTE: Please run this tool with root user privileges for comprehensive and effective system assessment. ***${NC}"
{
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
((not_accessed++))
((total++))
((not_accessed++))
((total++))
((not_accessed++))
((total++))


# Section 1.1.2
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|1.1.2    | Configure /tmp                                                                                                 |                  |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#section 1.1.2.1
output=$(findmnt --kernel /tmp)
if echo "$output" | grep -q "/tmp   tmpfs  tmpfs  rw,nosuid,nodev,noexec,relatime,size=2097152k,inode64"
then
	if systemctl is-enabled tmp.mount | grep -q 'enabled'; then
		echo -e "|1.1.2.1    |Ensure /tmp is a separate partition                                                                     |${green} Pass       ${NC}|"
		
		((passcount++))
	else
		echo -e "|${red}1.1.2.1     |Ensure /tmp is a separate partition                                                                     | Fail      ${NC}|"
		
		((failcount++))
		failed_sections+="1.1.2.1 "
	fi
  else
	  echo -e "|${red}1.1.2.1  |Ensure /tmp is a separate partition                                                                             | Fail             ${NC}|"
	  
	  ((failcount++))
	  failed_sections+="1.1.2.1 "
fi
((total++))	  

# Audit Title 1.1.2.2
if output=$(findmnt --kernel /tmp) && echo "$output" | grep -q 'nodev';
then
        echo -e "|1.1.2.2  | Ensure nodev option set on /tmp partition                                                                      |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.2.2  | Ensure nodev option set on /tmp partition                                                                      | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.2.2 "
fi
((total++))

# Audit Title 1.1.2.3
if findmnt --kernel /tmp | grep -q 'noexec';
then
        echo -e "|1.1.2.3  | Ensure noexec option set on /tmp partition                                                                     |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.2.3  | Ensure noexec option set on /tmp partition                                                                     | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.2.3 "
fi
((total++))

#Audit Title 1.1.2.4
if findmnt --kernel /tmp | grep -q 'nosuid';
then
        echo -e "|1.1.2.4  | Ensure nosuid option set on /tmp partition                                                                     |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.2.4  | Ensure nosuid option set on /tmp partition                                                                     | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.2.4 "
fi
((total++))

# Section 1.1.3
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.3    | Configure /var                                                                                                 |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Section 1.1.3.1
if findmnt --kernel /var;
then
        echo -e "|1.1.3.1  | Ensure separate partition exists for /var                                                                      |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.3.1  | Ensure separate partition exists for /var                                                                      | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.3.1 "
fi
((total++))

#Section 1.1.3.2
if findmnt --kernel /var | grep -q 'nodev';
then
        echo -e "|1.1.3.2  | Ensure nodev option set on /var partition                                                                      |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.3.2  | Ensure nodev option set on /var partition                                                                      | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.3.2 "
fi
((total++))

#Section 1.1.3.3
if findmnt --kernel /var | grep -q 'nosuid';
then
        echo -e "|1.1.3.3  | Ensure nosuid option set on /var partition                                                                     |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.3.3  | Ensure nosuid option set on /var partition                                                                     | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.3.3 "
fi
((total++))

# Section 1.1.4

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.4    | Configure /var/tmp                                                                                             |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Section 1.1.4.1
output=$(findmnt --kernel /var/tmp)
if [ -z "$output" ]
then
	echo -e "|${RED}1.1.4.1  | Ensure separate partition exists for /var/tmp                                                                  | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.4.1 "
else
      echo -e "|1.1.4.1  | Ensure separate partition exists for /var/tmp                                                                 |${GREEN} Pass${NC}              |"
	
	((pass_count++))  
fi
((total++))

#Section 1.1.4.2
if findmnt --kernel /var/tmp | grep -q 'noexec';
then
        echo -e "|1.1.4.2  | Ensure noexec option set on /var/tmp partition                                                                |${GREEN} Pass${NC}              |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.4.2  | Ensure noexec option set on /var/tmp partition                                                                 | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.4.2 "
fi
((total++))

#Section 1.1.4.3
if findmnt --kernel /var/tmp | grep -q 'nosuid';
then
        echo -e "|1.1.4.3  | Ensure nosuid option set on /var/tmp partition                                                                |${GREEN} Pass${NC}              |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.4.3  | Ensure nosuid option set on /var/tmp partition                                                                 | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.4.3 "
fi
((total++))

#Section 1.1.4.4
 &>> output.txt
if findmnt --kernel /var/tmp | grep -q 'nodev';
then
        echo -e "|1.1.4.4  | Ensure nodev option set on /var/tmp partition                                                                 |${GREEN} Pass${NC}              |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.4.4  | Ensure nodev option set on /var/tmp partition                                                                  | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.4.4 "
fi
((total++))

# Section 1.1.5

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.5    | Configure /var/log                                                                                             |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Section 1.1.5.1
output=$(findmnt --kernel /var/log)
if [ -z "$output" ]
then
	echo -e "|${RED}1.1.5.1  | Ensure separate partition exists for /var/log                                                                  | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.5.1 "
else
        echo -e "|1.1.5.1  | Ensure separate partition exists for /var/log                                                                 |${GREEN} Pass${NC}              |"
	
	((pass_count++))
fi
((total++))

#Section 1.1.5.2
if findmnt --kernel /var/log | grep -q 'nodev';
then
        echo -e "|1.1.5.2  | Ensure nodev option set on /var/log partition                                                                  |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.5.2  | Ensure nodev option set on /var/log partition                                                                  | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.5.2 "
fi
((total++))

#Section 1.1.5.3
if findmnt --kernel /var/log | grep -q 'noexec';
then
        echo -e "|1.1.5.3  | Ensure noexec option set on /var/log partition                                                                |${GREEN} Pass${NC}              |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.5.3  | Ensure noexec option set on /var/log partition                                                                 | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.5.3 "
fi
((total++))

#Section 1.1.5.4
if findmnt --kernel /var/log | grep -q 'nosuid';
then
        echo -e "|1.1.5.4  | Ensure nosuid option set on /var/log partition                                                                 |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.5.4  | Ensure nosuid option set on /var/log partition                                                                 | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.5.4 "
fi
((total++))

# Section 1.1.6

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.6    | Configure /var/log/audit                                                                                       |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Section 1.1.6.1
output=$(findmnt --kernel /var/log/audit)
if [ -z "$output" ]
then
	echo -e "|${RED}1.1.6.1  | Ensure separate partition exists for /var/log/audit                                                            | Fail             ${NC}|"
	((fail_count++))
	failed_sections+="1.1.6.1 "
else
	echo -e "|1.1.6.1  | Ensure separate partition exists for /var/log/audit                                                            |${GREEN} Pass${NC}             |"
	
	((pass_count++))
fi
((total++))

#Section 1.1.6.2
if findmnt --kernel /var/log/audit |grep -q 'noexec';
then
        echo -e "|1.1.6.2  | Ensure noexec option set on /var/log/audit partition                                                           |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.6.2  | Ensure noexec option set on /var/log/audit partition                                                           | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.6.2 "
fi
((total))

#Section 1.1.6.3
if findmnt --kernel /var/log/audit |grep -q 'nodev';
then
        echo -e "|1.1.6.3  | Ensure nodev option set on /var/log/audit partition                                                            |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.6.3  | Ensure nodev option set on /var/log/audit partition                                                            | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.6.3 "
fi
((total++))

#Section 1.1.6.4
if findmnt --kernel /var/log/audit |grep -q 'nosuid';
then
        echo -e "|1.1.6.4  | Ensure nosuid option set on /var/log/audit partition                                                           |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.6.4  | Ensure nosuid option set on /var/log/audit partition                                                           | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.6.4 "
fi
((total++))

# Section 1.1.7

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.7    | Configure /home                                                                                                |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Section 1.1.7.1
output=$(findmnt --kernel /home)
if [ -z "$output" ]
then
	echo -e "|${RED}1.1.7.1  | Ensure separate partition exists for /home                                                                     | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.7.1 "
else
        echo -e "|1.1.7.1  | Ensure separate partition exists for /home                                                                     |${GREEN} Pass${NC}             |"
	
	((pass_count++))
fi
((total++))

#Section 1.1.7.2
if findmnt --kernel /home | grep -q 'nodev';
then
        echo -e "|1.1.7.2  | Ensure nodev option set on /home partition                                                                     |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.7.2  | Ensure nodev option set on /home partition                                                                     | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.7.2 "
fi
((total++))

#Section 1.1.7.3
if findmnt --kernel /home | grep -q 'nosuid';
then
        echo -e "|1.1.7.3  | Ensure nosuid option set on /home partition                                                                    |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.7.3  | Ensure nosuid option set on /home partition\                                                                   | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.7.3 "
fi
((total++))

# Section 1.1.8

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.8    | Configure /dev/shm                                                                                             |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Section 1.1.8.1
if findmnt --kernel /dev/shm | grep -q 'nodev';
then
        echo -e "|1.1.8.1  | Ensure nodev option set on /dev/shm partition                                                                  |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.8.1  | Ensure nodev option set on /dev/shm partition                                                                  | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.8.1 "
fi
((total++))

#Section 1.1.8.2
if findmnt --kernel /dev/shm | grep -q 'noexec';
then
        echo -e "|1.1.8.2  | Ensure noexec option set on /dev/shm partition                                                                 |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.8.2  | Ensure noexec option set on /dev/shm partition                                                                 | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.8.2 "
fi
((total++))

#Section 1.1.8.3
if findmnt --kernel /dev/shm | grep -q 'nosuid';
then
        echo -e "|1.1.8.3  | Ensure nosuid option set on /dev/shm partition                                                                 |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.1.8.3  | Ensure nosuid option set on /dev/shm partition                                                                 | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.1.8.3 "
fi
((total++))

#section 1.1.9
#output=$(systemctl is-enabled autofs)
#if systemctl is-enabled autofs | grep -q "Failed";
#then
#        echo -e "|1.1.9    | Disable Automounting (Automated)                                                                               |${GREEN} Pass${NC}             |"
#	
#	((pass_count++))
#else
#       echo -e "|${RED}1.1.9    | Disable Automounting (Automated)                                                                               | Fail             ${NC}|"
#	
#	((fail_count++))
#	failed_sections+="1.1.9 "
#fi
((total++))
((not_accessed++))

#Section 1.1.10
echo -e "|1.1.10   | Disable USB Storage (Automated)                                                                                |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))
    
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo -e "|1.2      | Configure Software Updates                                                                                     |${BLUE} Not-Accessed${NC}     |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
((not_accessed++))
((total++))
((not_accessed++))
((total++))



# Section 1.3

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.3      | Filesystem Integrity Checking                                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Section 1.3.1
echo -e "|1.3.1    | Ensure AIDE is installed                                                                                       |${BLUE} Not-Accessed${NC}     |"
		
((not_accessed++))
((total++))

 grep -Prs '^([^#\n\r]+\h+)?(\/usr\/s?bin\/|^\h*)aide(\.wrapper)?\h+(--check|([^#\n\r]+\h+)?\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/ >>output.txt
if grep -x -q "/etc/cron.daily/aide:aide --config="${CONFIG}" $AIDEARGS "--$COMMAND" >|"$ARUNLOG" 2>|"$AERRLOG" && ARETVAL="$?"" output.txt;
then
                echo -e "|1.3.2    | Ensure filesystem integrity is regularly checked                                                                |${GREEN}Pass${NC}             |"

                ((pass_count++))
        else
                systemctl is-enabled aidecheck.service &> output.txt
                systemctl is-enabled aidecheck.timer &> output.txt
                systemctl status aidecheck.timer &> output.txt
                if grep -q "failed to get unit file state for aidecheck.service: No such file or directory" output.txt;
                then
                        echo -e "|${RED}1.3.2    | Ensure filesystem integrity is regularly checked                                                               | Fail             ${NC}|"

                        ((fail_count++))
                        failed_sections+="1.3.2 "
                        #Explaination: failed to get unit file state for aidecheck.service: No such file or directory
                else
                        if grep -E -q "failed to get unit file state for aidecheck.timer: No such file or directory" output.txt;
                        then
                                echo -e "|${RED}1.3.2    | Ensure filesystem integrity is regularly checked                                                               | Fail             ${NC}|"

                                ((fail_count++))
                                failed_sections+="1.3.2 "
                                #Explaination: failed to get unit file state for aidecheck.timer: No such file or directory
                        else
                                if grep -q "Unit aidecheck.timer could not be found." output.txt;
                                        then
                                                echo -e "|${RED}1.3.2    | Ensure filesystem integrity is regularly checked                                                               | Fail             ${NC}|"
                                                #Explaination: Unit aidecheck.timer could not be found

                                                ((fail_count++))
                                                failed_sections+="1.3.2 "
                                        else
                                                echo -e "|1.3.2    | Ensure filesystem integrity is regularly checked                                                               |${GREEN} Pass${NC}             |"

                                                ((pass_count++))
                                fi
                        fi
                fi
fi

sudo rm -f output.txt
((total++))
#Description:Periodic checking of the filesystem integrity is needed to detect changes to the filesystem


#Section 1.4
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.4      | Secure Boot Settings                                                                                           |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
#Section 1.4.1
output=$(grep "^set superusers" /boot/grub/grub.cfg)
if echo "$output" | grep 'set superusers="<username>"'; then
output=$(grep "^password" /boot/grub/grub.cfg)
if echo "$output" | grep 'password_pbkdf2 <username> <encrypted-password>'; then
echo -e "|1.4.1    | Ensure bootloader password is set                                                                             |${GREEN} Pass${NC}              |"
		
		((pass_count++))
		else
		echo -e "|${RED}1.4.1    | Ensure bootloader password is set                                                                              | Fail             ${NC}|"
		
		((fail_count++))
		failed_sections+="1.4.1 "
		fi
		else
		echo -e "|${RED}1.4.1    | Ensure bootloader password is set                                                                              | Fail             ${NC}|"
		
		((fail_count++))
		failed_sections+="1.4.1 "
		fi
((total++))

#Section 1.4.2
output=$(stat /boot/grub/grub.cfg)
if echo "$output" | grep -x -q 'Access: (0400/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)';
then
        echo -e "|1.4.2    | Ensure permissions on bootloader config are configured                                                         |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.4.2    | Ensure permissions on bootloader config are configured                                                         | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.4.2 "
fi
((total++))

#Section 1.4.3
output=$(grep -Eq '^root:\$[0-9]' /etc/shadow || echo "root is locked")
if echo "$output" | grep -q "root is locked";
then
        echo -e "|${RED}1.4.3    | Ensure authentication required for single user mode                                                            | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.4.3 "
else
        echo -e "|1.4.3    | Ensure authentication required for single user mode                                                            |${GREEN} Pass${NC}             |"
	
	((pass_count++))
fi
sudo rm -f output.txt
((total++))

#Section 1.5
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.5      | Additional Process Hardening                                                                                   |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
#Section 1.5.1
output=$(sysctl kernel.randomize_va_space)
if echo "$output" | grep -x -q "kernel.randomize_va_space = 2";
then
        echo -e "|1.5.1    | Ensure address space layout randomization (ASLR) is enabled                                                    |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
        echo -e "|${RED}1.5.1    | Ensure address space layout randomization (ASLR) is enabled                                                    | Fail             ${NC}|"
	((fail_count++))
	failed_sections+="1.5.1 "
fi
((total++))

#Section 1.5.2
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n')
if echo "$output" | grep -q -E "prelink.*not-installed";
then
	echo -e "|1.5.2    | Ensure prelink is not installed (Automated)                                                                    |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
	echo -e "|${RED}1.5.2    | Ensure prelink is not installed (Automated)                                                                    | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.5.2 "
fi
((total++))

#Section 1.5.3
output=$(dpkg-query -s apport > /dev/null 2>&1 && grep -Psi -- '^\h*enabled\h*=\h*[^0]\b' /etc/default/apport)
if [ -z "$output" ]; then
        output=$(systemctl is-active apport.service | grep '^active')
        if echo "$output" | grep -q "active";
        then
                echo -e "|${RED}1.5.3    | Ensure Automatic Error Reporting is not enabled (Automated)                                                    | Fail             ${NC}|"
                ((fail_count++))
		failed_sections+="1.5.3 "
		#Explanation: service 'apport' is still actiive
        else
                echo -e "|1.5.3    | Ensure Automatic Error Reporting is not enabled (Automated)                                                    |${GREEN} Pass${NC}             |"
                
		((pass_count++))
		#Explnation: Automatic error reporting is not enabled
        fi
else
    echo -e "|${RED}1.5.3    | Ensure Automatic Error Reporting is not enabled (Automated)                                                    | Fail             ${NC}|"
    #Explanation: apport is enabled
    ((fail_count++))
    failed_sections+="1.5.3 "
fi
((total++))

#Section 1.5.4
output=$(grep -Es '^(\*|\s).*hard.*core.*(\s+#.*)?$' /etc/security/limits.conf /etc/security/limits.d/*)
if echo "$output" | grep -q '* hard core 0';
then
        output=$(sysctl fs.suid_dumpable)
        if echo "$output" | grep -q 'fs.suid_dumpable = 0';
        then
        	output=$(grep "fs.suid_dumpable" /etc/sysctl.conf /etc/sysctl.d/*)
        	if echo "$output" | grep -q 'fs.suid_dumpable = 0'; 
        	then
        	output=$(systemctl is-enabled coredump.service)
        	if echo "$output" | grep -E -q 'enabled|masked|disabled'; then
                echo -e "|1.5.4    | Ensure core dumps are restricted (Automated)                                                                   |${GREEN} Pass${NC}             |"
                
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
                #Explanation: systemd-coREDump is not installed
		((fail_count++))
		failed_sections+="1.5.4 "
		fi
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

((total++))

#Section 1.6
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.6      | Mandatory Access Control                                                                                       |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Section 1.6.1.1
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' apparmor)
if echo "$output" | grep -q -E "apparmor	install ok installed	installed";
then
	echo -e "|1.6.1.1  | Ensure AppArmor is installed (Automated)                                                                       |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
	echo -e "|${RED}1.6.1.1  | Ensure AppArmor is installed (Automated)                                                                       | Fail             ${NC}|"
	((fail_count++))
	failed_sections+="1.6.1.1 "
fi
((total++))

#Section 1.6.1.2
output=$(grep "^\s*linux" /boot/grub/grub.cfg | grep -v "apparmor=1")
if [ -z "$output" ]; then
    output=$(grep "^\s*linux" /boot/grub/grub.cfg | grep -v "security=apparmor")
    if [ -z "$output" ]; then
	    echo -e "|1.6.1.2  | Ensure AppArmor is enabled in the bootloader configuration (Automated)                                         |${GREEN}Pass${NC}              |"
    		
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
((total++))

#Section 1.6.1.3
output=$(apparmor_status | grep profiles)
if echo "$output" | grep -q -E "0 profiles are in kill mode.";
then
	if echo "$output" | grep -q -E "0 profiles are in unconfined mode.";
	then
		output=$(apparmor_status | grep processes | grep unconfined)
		if echo "$output" | grep -q -E "0 processes are unconfined";
		then
			echo -e "|1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                                       |${GREEN} Pass${NC}             |"
			((pass_count++))
		else
			echo -e "|${RED}1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                                       | Fail             ${NC}|"
			
			((fail_count++))
			failed_sections+="1.6.1.3 "
			#Explanation: There are unconfined processes.
		fi
	else
		echo -e "|${RED}1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                                       | Fail             ${NC}|"
		
		((fail_count++))
		failed_sections+="1.6.1.3 "
		#Explanation: There are processes in unconfined mode.
	fi
else
	echo -e "|${RED}1.6.1.3  | Ensure all AppArmor Profiles are in enforce or complain mode (Automated)                                       | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.6.1.3 "
	#Explanation: There are profiles in kill mode.
fi
((total++))

#Section 1.6.1.4
output=$(apparmor_status | grep profiles)
if echo "$output" | grep -q -E "0 profiles are in complain mode.";
then
	if echo "$output" | grep -q -E "0 profiles are in kill mode.";
	then
		if echo "$output" | grep -q -E "0 profiles are in unconfined mode.";
		then
			output=$(apparmor_status | grep processes | grep unconfined)
			if echo "$output" | grep -q -E "0 processes are unconfined";
			then
				echo -e "|1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                                         |${GREEN} Pass${NC}             |"
				((pass_count++))
			else
				echo -e "|${RED}1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                                         | Fail             ${NC}|"
				
				((fail_count++))
				failed_sections+="1.6.1.4 "
				#Explanation: There are unconfined processes.
			fi
		else
			echo -e "|${RED}1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                                         | Fail             ${NC}|"
			
			((fail_count++))
			failed_sections+="1.6.1.4 "
			#Explanation: There are profiles in unconfined mode.
		fi
	else
		echo -e "|${RED}1.6.1.4     | Ensure all AppArmor Profiles are enforcing (Automated)                                                      | Fail             ${NC}|"
		
		((fail_count++))
		failed_sections+="1.6.1.4 "
		#Explanation: There are profiles in kill mode.
	fi
else
	echo -e "|${RED}1.6.1.4  | Ensure all AppArmor Profiles are enforcing (Automated)                                                         | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.6.1.4 "
	#Explanation: There are profiles in complain mode.
fi
((total++))

#Section 1.7
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.7      | Command Line Warning Banners                                                                                   |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

#Section 1.7.1
output=$(grep -Eis "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd)
if [ -z "$output" ]; then
    echo -e "|1.7.1    | Ensure message of the day is configured properly (Automated)                                                   |${GREEN} Pass${NC}             |"
    
    ((pass_count++))
else
    echo "|${RED}1.7.1    | Ensure message of the day is configured properly (Automated)                                                      | Fail             ${NC}|"
	((fail_count++))
	failed_sections+="1.7.1 "
fi
sudo rm -f output.txt
((total++))

#Section 1.7.2
output=$(grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue)
if [ -z "$output" ]; then
	echo -e "|1.7.2    | Ensure local login warning banner is configured properly (Automated)                                           |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
	echo -e "|${RED}1.7.2    | Ensure local login warning banner is configured properly (Automated)                                           | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.7.2 "
	#Explanation: Login banner is not configured properly
fi
((total++))

#section 1.7.3
output=$(grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue.net)
if [ -z "$output" ]; then
	output=$(cat /etc/issue.net)
	if echo "$output" | grep -q "Ubuntu 22.04.2 LTS";
	then
		echo -e "|${RED}1.7.3    | Ensure remote login warning banner is configured properly (Automated)                                          | Fail             ${NC}|"
		
		((fail_count++))
		failed_sections+="1.7.3 "

		#Explanation: Warning banner displays OS information
	else
	        echo -e "|1.7.3    | Ensure remote login warning banner is configured properly (Automated)                                          |${GREEN} Pass${NC}             |"
		
		((pass_count++))
	fi
else
    echo -e "|${RED}1.7.3    | Ensure remote login warning banner is configured properly (Automated)                                          | Fail             ${NC}|"
    
    ((fail_count++))
    failed_sections+="1.7.3 "
    #Explanation: Remote login banner is not configured properly
fi
((total++))

#Section 1.7.4
#output=$(stat -L /etc/motd)
#if echo "$output" | grep -q "stat: cannot statx '/etc/motd': No such file or directory|Access: (0644/-rw-r--r--) Uid: (0/	root)	Gid: (	0/	root)";
#then
#	echo -e "|1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                                     |${GREEN} Pass${NC}             |"
#	
#	((pass_count++))
#else
#	echo -e "|${RED}1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                                     | Fail             ${NC}|"
#	
#	((fail_count++))
#	failed_sections+="1.7.4 "
#	#Explanation: Uid and/or Gid are not set to 0/root, and/or Access is not set to 644
#fi

echo -e "|1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                                     |${BLUE} Not-Accessed${NC}     |"
((not_accessed++))
((total++))

#Section 1.7.5
output=$(stat -L /etc/issue)
if echo "$output" | grep -q "Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)";
then
	echo -e "|1.7.5    | Ensure permissions on /etc/issue are configured (Automated)                                                    |${GREEN} Pass${NC}             |"
	
	((pass_count++))
else
	echo -e "|${RED}1.7.5    | Ensure permissions on /etc/issue are configured (Automated)                                                    | Fail             ${NC}|"
	
	((fail_count++))
	failed_sections+="1.7.5 "
	#Explanation: Permissions have not been set, or have been set incorrectly for /etc/issue.
fi
((total++))

#Section 1.7.6
output=$(stat -L /etc/issue.net)
if echo "$output" | grep -q "Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)";
then
        echo -e "|1.7.6    | Ensure permissions on /etc/issue.net are configured (Automated)                                                |${GREEN} Pass${NC}             |"
        
	((pass_count++))
else
        echo -e "|${RED}1.7.6    | Ensure permissions on /etc/issue.net are configured (Automated)                                                | Fail             ${NC}|"
        
	((fail_count++))
	failed_sections+="1.7.6 "
        #Explanation: Permissions have not been set, or have been set incorrectly for /etc/issue.net.
fi
((total++))

#Section 1.8
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.8      | GNOME Display Manager                                                                                          |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


#Section 1.8.1
output=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' gdm3)
if echo "$output" | grep -q "gdm3	install ok not-installed	not-installed";
then
       	echo -e "|1.8.1    | Ensure GNOME Display Manager is removed (Automated)                                                            |${GREEN} Pass             ${NC}|"
        
	((pass_count++))
else
        echo -e "|${RED}1.8.1    | Ensure GNOME Display Manager is removed (Automated)                                                            | Fail             ${NC}|"
        
	((fail_count++))
	failed_sections+="1.8.1 "
        #Explanation: The GNOME GUI is installed on the system.
fi
((total++))



#Section 1.8.2
echo -e "|1.8.2    | Ensure GDM login banner is configured (Automated)                                                              |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

echo -e "|1.8.3    | Ensure GDM disable-user-list option is enabled (Automated)                                                     |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

echo -e "|1.8.4    | Ensure GDM screen locks when the user is idle  (Automated)                                                     |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

echo -e "|1.8.5    | Ensure GDM screen locks cannot be overridden (Automated)                                                       |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

echo -e "|1.8.6    | Ensure GDM automatic mounting of removable media is disabled (Automated)                                       |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

echo -e "|1.8.7    | Ensure GDM disabling automatic mounting of removable media is not overridden (Automated)                       |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

echo -e "|1.8.8    | Ensure GDM autorun-never is enabled (Automated)                                                                |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

echo -e "|1.8.9    | Ensure GDM autorun-never is not overridden (Automated)                                                         |${BLUE} Not-Accessed${NC}     |"
    ((not_accessed++))
    ((total++))

output=$(grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm3/custom.conf)
if [ -z "$output" ]; then
    echo -e "|1.8.10   | Ensure XDCMP is not enabled (Automated)                                                                        |${GREEN} Pass${NC}             |"
    
    ((pass_count++))
else
    echo -e "|${RED}1.8.10   | Ensure XDCMP is not enabled (Automated)                                                                        | Fail             ${NC}|"
    
    ((fail_count++))
    failed_sections+="1.8.10 "
fi
((total++))




#output=$(apt -s upgrade)
#if [ -z "$output" ]; then
#    echo -e "|1.9      | Ensure updates, patches, and additional security software are installed (Manual)                               |${GREEN} Pass${NC}             |"
#    
#    ((pass_count++))
#else
#    echo -e "|${RED}1.9      | Ensure updates, patches, and additional security software are installed (Manual)                               | Fail             ${NC}|"
#    
#    ((fail_count++))
#    failed_sections+="1.9 "
#fi

echo -e "|1.9      | Ensure updates, patches, and additional security software are installed (Manual)                               |${BLUE} Not-Accessed${NC}     |"
((total++))
((not_accessed++))


echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
} > setup.txt

# Display Summary
#summary_line="| ${YELLOW}Audit Results Summary${NC}                                                                                                                       |"
#total_audits="| Total Audits: ${total}"
#pass="|${GREEN} Pass${NC} Count: ${GREEN}${pass_count}${NC}/${total}"
#fail="|${red2} fail${NC} Count: ${red2}${fail_count}${NC}/${total}"
#NA="|${BLUE} Not-Accessed${NC} Count: ${BLUE}${not_accessed}${NC}/${total}"

#echo -e "$summary_line"
#echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
#echo "$total_audits"
#echo -e "$pass"
#echo -e "$fail"
#echo -e "$NA"
#echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


# Display Summary
#summary_line="| ${YELLOW}Audit Results Summary${NC}                                                                                                                       |"
#total_audits="| Total Audits: ${total}"
#pass="|${GREEN} Pass${NC} Count: ${GREEN}${pass_count}${NC}/${total}"
#fail="|${red2} fail${NC} Count: ${red2}${fail_count}${NC}/${total}"
#NA="|${BLUE} Not-Accessed${NC} Count: ${BLUE}${not_accessed}${NC}/${total}"

#echo -e "$summary_line"
#echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
#echo "$total_audits"
#echo -e "$pass"
#echo -e "$fail"
#echo -e "$NA"
#echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


# Check if all sections are compliant
if [ "$fail_count" -eq 0 ]; then
    exit 0  # Exit the script if all sections are compliant
fi

#./fails2.sh "$1"
# Prompt user for more details on failures
#read -p "                                       Do you want to see more details on the failed sections? (y/n): " choice
#if [[ $choice == "y" ]]; then
    path_to_fails="./S1_fails.sh"
#    echo
    display_failed_sections "$path_to_fails" > s1fails.txt
#else 
#    echo -e "\nYou have decided to not see more details on the failed sections."
#    echo -e "\nThank you for utilizing our audit tool to enhance your system's security and adherence to standards."
#    echo -e "\nClosing..."
#fi
