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
{
echo
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                       Automated Audit Tool for Linux(2)                                                     |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo -e "|${YELLOW}Section${NC}  | ${YELLOW}Title${NC}                                                                                                          | ${YELLOW}Compliance${NC}       |"



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
} > sysmain.txt

path_to_fails="./S6_fails.sh"
display_failed_sections "$path_to_fails" > s6fails.txt
