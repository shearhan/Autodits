#!/bin/bash
# color of compliance
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No color

section=$1

# Benchmark Section 6.1.1
if [[ $section == "6.1.1" ]]; then
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

