#!/bin/bash
exec &> >(tee rem6.txt)

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Print the header
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                           Remediation: Section 6                                                            |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo -e "|${YELLOW}Section${NC}  | ${YELLOW}Title${NC}                                                                                                          | ${YELLOW}Remarks${NC}          |"

# Section 6
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                           6 System Maintainence                                                             |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Section 6.1
echo "|6.1      | System File Permissions                                                                                        |                  |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Remediation steps for section 6.1.1
echo "|6.1.1    | Ensure permissions on /etc/passwd are configured (Automated)                                                   | Completed        |"
chown root:root /etc/passwd
chmod 644 /etc/passwd

# Remediation steps for section 6.1.2
echo "|6.1.2    | Ensure permissions on /etc/passwd- are configured (Automated)                                                  | Completed        |"
chown root:root /etc/passwd-
chmod u-x,go-wx /etc/passwd-

# Remediation steps for section 6.1.3

echo "|6.1.3    | Ensure permissions on /etc/group are configured (Automated)                                                    | Completed        |"

chown root:root /etc/group

chmod 644 /etc/group


# Remediation steps for section 6.1.4

echo "|6.1.4    | Ensure permissions on /etc/group- are configured (Automated)                                                   | Completed        |"

chown root:root /etc/group-

chmod u-x,go-wx /etc/group-


# Remediation steps for section 6.1.5

echo "|6.1.5    | Ensure permissions on /etc/shadow are configured (Automated)                                                   | Completed        |"

chown root:shadow /etc/shadow

chmod u-x,g-wx,o-rwx /etc/shadow


# Remediation steps for section 6.1.6

echo "|6.1.6    | Ensure permissions on /etc/shadow- are configured (Automated)                                                  | Completed        |"

chown root:shadow /etc/shadow-

chmod u-x,g-wx,o-rwx /etc/shadow-

# Remediation steps for section 6.1.7

echo "|6.1.7    | Ensure permissions on /etc/gshadow are configured (Automated)                                                  | Completed        |"

chown root:shadow /etc/gshadow
chmod u-x,g-wx,o-rwx /etc/gshadow


# Remediation steps for section 6.1.8

echo "|6.1.8    | Ensure permissions on /etc/gshadow- are configured (Automated)                                                 | Completed        |"

chown root:shadow /etc/gshadow-
chmod u-x,g-wx,o-rwx /etc/gshadow-


# Remediation steps for section 6.1.9

echo "|6.1.9    | Ensure no world writable files exist (Automated)                                                               | Completed        |"
 
world_writable_files=$(df --local -P | awk 'NR!=1 {print $6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002)

for file in $world_writable_files; do
    chmod o-w "$file"
done


# Remediation steps for section 6.1.10

echo "|6.1.10   | Ensure no unowned files or directories exist (Automated)                                                       | Manual           |"


# Remediation steps for section 6.1.11

echo "|6.1.11   | Ensure no ungrouped files or directories exist (Automated)                                                     | Manual           |"


# Remediation steps for section 6.1.12

echo "|6.1.12   | Audit SUID executables (Manual)                                                                                | Manual           |"


# Remediation steps for section 6.1.13

echo "|6.1.13   | Audit SGID executables (Manual)                                                                                | Manual           |"

# Section 6.2
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|6.2      | Local User and Group Settings                                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"



# Remediation steps for section 6.2.1

echo "|6.2.1    | Ensure accounts in /etc/passwd use shadowed passwords (Automated)                                              | Completed        |"

sed -e 's/^\([a-zA-Z0-9_]*\):[^:]*:/\1:x:/' -i /etc/passwd

# 6.2.2
echo "|6.2.2    | Ensure /etc/shadow password fields are not empty (Automated)                                                   | Completed        |"
# Run the command and capture the output
    output=$(awk -F: '($2 == "" ) { print $1 }' /etc/shadow)

if [ -n "$output" ]; then
        # Lock accounts without a password
        while read -r username; do
            passwd -l "$username" >/dev/null 2>&1
        done <<< "$output"
fi

# 6.2.3

echo "|6.2.3    | Ensure all groups in /etc/passwd exist in /etc/group (Automated)                                               | Manual           |"
 
# 6.2.4

echo "|6.2.4    | Ensure shadow group is empty (Automated)                                                                       | Manual           |"

# Remove all users from the shadow group
#sed -ri 's/(^shadow:[^:]*:[^:]*:)([^:]+$)/\1/' /etc/group

    # Prompt the user to enter the new primary group name
#    read -p "Enter the desired new primary group name: " new_primary_group

    # Find and change the primary group of users with shadow as their primary group
#    while read -r line; do
#        user=$(echo "$line" | awk -F: '{print $1}')
#        primary_group=$(echo "$line" | awk -F: '{print $4}')

#        if [ "$primary_group" = "shadow" ]; then
#            usermod -g "$new_primary_group" "$user"
#        fi
#    done < /etc/passwd

# Remediation steps for section 6.2.5

echo "|6.2.5    | Ensure no duplicate UIDs exist (Automated)                                                                     | Manual           |"


# Remediation steps for section 6.2.6

echo "|6.2.6    | Ensure no duplicate GIDs exist (Automated)                                                                     | Manual           |"


# Remediation steps for section 6.2.7

echo "|6.2.7    | Ensure no duplicate user names exist (Automated)                                                               | Manual           |"


# Remediation steps for section 6.2.8

echo "|6.2.8    | Ensure no duplicate group names exist (Automated)                                                              | Manual           |"


# Remediation steps for section 6.2.9

echo "|6.2.9    | Ensure root PATH Integrity (Automated)                                                                         | Manual           |"


# Remediation steps for section 6.2.10


echo "|6.2.10   | Ensure root is the only UID 0 account (Automated)                                                              | Manual           |"

# 6.2.11

echo "|6.2.11   | Ensure local interactive user home directories exist (Automated)                                               | Manual           |"

# 6.2.12
echo "|6.2.12   | Ensure local interactive users own their home directories (Automated)                                          | Manual           |"


# 6.2.13
echo "|6.2.13   | Ensure local interactive user home directories are mode 750 or more restrictive (Automated)                    | Manual           |"


#6.2.14
echo "|6.2.14   | Ensure no local interactive user has .netrc files (Automated)                                                  | Manual           |"


#6.2.15
echo "|6.2.15   | Ensure no local interactive user has .forward files (Automated)                                                | Manual           |"


#6.2.16
echo "|6.2.16   | Ensure no local interactive user has .rhosts files (Automated)                                                 | Manual           |"


#6.2.17
echo "|6.2.17   | Ensure local interactive user dot files are not group or world writable (Automated)                            | Manual           |"



# Print the summary
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|Finished remediation. Please re-run section 6 Audit to ensure that the 'fail' compliance is resolved                                         |"
echo "|Note: For 'manual' remarks, please refer to failed sections to remediate.                                                                    |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


