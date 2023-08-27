#!/bin/bash
exec &> >(tee rem4.txt)
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


echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                           Section 4: Remediation                                                               |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo -e "|${YELLOW}Section${NC}  | ${YELLOW}Title${NC}                                                                                                          | ${YELLOW}Remarks${NC}             |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
# Section 4.1
echo "|4.1      | Configure System Accounting (auditd)                                                                           |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"

# Section 4.1.1
echo "|4.1.1    | Ensure auditing is enabled                                                                                     |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
    #echo "apt install auditd audispd-plugins"
    function remediate_4111() {
    apt install auditd audispd-plugins &>> output.txt
    echo -e "|4.1.1.1  |Ensure auditd is installed (Automated)                                                                          | Completed           |"
    sudo rm -f output.txt
    }
    
    
    function remediate_4112() {
   systemctl --now enable auditd &>> output.txt
   if grep -q "Failed to enable unit: Unit file auditd.service does not exist." output.txt;
   then
   #remediation_status["4.1.1.2"]="Could not Remediate"
   echo -e "|4.1.1.2  |Ensure auditd service is enabled and active (Automated)                                                         | Could not Remediate |"
   else
    #remediation_status["4.1.1.2"]="Completed"
    echo -e "|4.1.1.2  |Ensure auditd service is enabled and active (Automated)                                                         | Completed           |"
    fi
        sudo rm -f output.txt
}


function remediate_4113() {
   sed -i '/GRUB_CMDLINE_LINUX="audit=/d' /etc/default/grub
   printf '\nGRUB_CMDLINE_LINUX="audit=1"' >> /etc/default/grub
   update-grub &>> output.txt
   echo -e "|4.1.1.3  |Ensure auditing for processes that start prior to auditd is enabled (Automated)                                 | Completed           |"
    #remediation_status["4.1.1.3"]="Completed"
    sudo rm -f output.txt
}


function remediate_4114() {
  sed -i '/GRUB_CMDLINE_LINUX="audit_backlog_limit=/d' /etc/default/grub
   printf '\nGRUB_CMDLINE_LINUX="audit_backlog_limit=8192"' >> /etc/default/grub
   update-grub &>> output.txt
   sudo rm -f output.txt
    #remediation_status["4.1.1.4"]="Completed"
    echo -e "|4.1.1.4  |Ensure audit_backlog_limit is sufficient (Automated)                                                            | Completed           |"
}



function remediate_4121() {
   { sed -i '/max_log_file =/d' /etc/audit/auditd.conf
   printf '\nmax_log_file = 8' >> /etc/audit/auditd.conf
   } &>> output.txt
   if grep -q "No such file or directory" output.txt
   then
   #remediation_status["4.1.2.1"]="Completed"
   echo -e "|4.1.2.1  |Ensure audit log storage size is configured (Automated)                                                         | Completed           |"
   else
    #remediation_status["4.1.2.1"]="Could not remediate"
    echo -e "|4.1.2.1  |Ensure audit log storage size is configured (Automated)                                                         | Could not Remediate |"
    fi
    sudo rm -f output.txt
}


function remediate_4122() {

   { sed -i '/keep_logs/d' /etc/audit/auditd.conf
   printf '/nmax_log_file_action = keep_logs' >> /etc/audit/auditd.conf
   } &>> output.txt
   if grep -q "No such file or directory" output.txt;
   then
   echo -e "|4.1.2.2  |Ensure audit logs are not automatically deleted (Automated)                                                     | Could not Remediate |"
   else
    #remediation_status["4.1.2.2"]="Completed"
    echo -e "|4.1.2.2  |Ensure audit logs are not automatically deleted (Automated)                                                     | Completed           |"
    fi
    sudo rm -f output.txt
}


function remediate_4123() {
   {
   sed -i '/space_left_action/d' /etc/audit/auditd.conf
   sed -i '/action_mail_acct/d' /etc/audit/auditd.conf
   sed -i '/admin_space_left_action/d' /etc/audit/auditd.conf
   printf '\nspace_left_action = email\n' >> /etc/audit/auditd.conf
   printf 'action_mail_acct = root\n' >> /etc/audit/auditd.conf
   printf 'admin_space_left_action = halt\n' >> /etc/audit/auditd.conf
   } &>> output.txt
   if grep -q "No such file or directory" output.txt;
   then
   #remediation_status["4.1.2.3"]="Could not remediate"  
   echo -e "|4.1.2.3  |Ensure system is disabled when audit logs are full (Automated)                                                  | Could not Remediate |"
   else
    #remediation_status["4.1.2.3"]="Completed"
    echo -e "|4.1.2.3  |Ensure system is disabled when audit logs are full (Automated)                                                  | Completed           |"
    fi
    sudo rm -f output.txt
}


function remediate_4131() {
   {
   sed -i '/sudoers/d' /etc/audit/rules.d/*.rules
   printf "\n-w /etc/sudoers -p wa -k scope" >> /etc/audit/rules.d/50-scope.rules
   printf "\n-w /etc/sudoers.d -p wa -k scope" >> /etc/audit/rules.d/50-scope.rules
   } &>> output.txt
   if grep -q "No such file or directory" output.txt;
   then
   #remediation_status["4.1.3.1"]="Could not remediate"
   echo -e "|4.1.3.1  |Ensure changes to system administration scope (sudoers) is collected (Automated)                                | Could not Remediate |"
   else
   augenrules --load &>> output.txt
   #remediation_status["4.1.3.1"]="Completed"
   echo -e "|4.1.3.1  |Ensure changes to system administration scope (sudoers) is collected (Automated)                                | Completed           |"
   fi 
   sudo rm -f output.txt
}


function remediate_4132() {
   { printf "\n-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k user_emulation" >> /etc/audit/rules.d/50-user_emulation.rules
printf "\n-a always,exit -F arch=b32 -C euid!=uid -F auid!=unset -S execve -k user_emulation" >> /etc/audit/rules.d/50-user_emulation.rules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
   then 
   #remediation_status["4.1.3.2"]="Could not remediate"
   echo -e "|4.1.3.2  |Ensure actions as another user are always logged (Automated)                                                    | Could not Remediate |"
   else
   augenrules --load &>> output.txt
   #remediation_status["4.1.3.2"]="Completed"
   echo -e "|4.1.3.2  |Ensure actions as another user are always logged (Automated)                                                    | Completed           |"
   fi
   sudo rm -f output.txt
}


function remediate_4133() {
   if {
   SUDO_LOG_FILE=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,?.*//' -e 's/"//g')
   [ -n "${SUDO_LOG_FILE}" ] && printf "-w ${SUDO_LOG_FILE} -p wa -k sudo_log_file" >> /etc/audit/rules.d/50-sudo.rules || printf "ERROR: Variable'SUDO_LOG_FILE_ESCAPED' is unset.\n"
   } | grep -q "Variable'SUDO_LOG_FILE_ESCAPED' is unset.";
   then
   #remediation_status["4.1.3.3"]="Cannot be Remediated"
   echo -e "|4.1.3.3  |Ensure events that modify the sudo log file are collected (Automated)                                           | Could not Remediate |"
   else
   #remediation_status["4.1.3.3"]="Completed"
   echo -e "|4.1.3.2  |Ensure events that modify the sudo log file are collected (Automated)                                           | Completed           |"
   augenrules --load &>> output.txt
   fi 
}


function remediate_4134() {
   { printf "
\n-a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -k time-
change
\n-a always,exit -F arch=b32 -S adjtimex,settimeofday,clock_settime -k time-
change
\n-w /etc/localtime -p wa -k time-change
" >> /etc/audit/rules.d/50-time-change.rules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.4"]="Could not remediate"
echo -e "|4.1.3.4  |Ensure events that modify date and time information are collected (Automated)                                   | Could not Remediate |"
else
#remediation_status["4.1.3.4"]="Completed"
echo -e "|4.1.3.4  |Ensure events that modify date and time information are collected (Automated)                                   | Completed           |"

augenrules --load &>> output.txt
fi
sudo rm -f output.txt
}


function remediate_4135() {
   { printf "
-a always,exit -F arch=b64 -S sethostname,setdomainname -k system-locale
-a always,exit -F arch=b32 -S sethostname,setdomainname -k system-locale
-w /etc/issue -p wa -k system-locale
-w /etc/issue.net -p wa -k system-locale
-w /etc/hosts -p wa -k system-locale
-w /etc/networks -p wa -k system-locale
-w /etc/network/ -p wa -k system-locale
" >> /etc/audit/rules.d/50-system_local.rules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.5"]="Could not remediate"
echo -e "|4.1.3.5  |Ensure events that modify the system's network environment are collected (Automated)                            | Could not Remediate |"
else
#remediation_status["4.1.3.5"]="Completed"
echo -e "|4.1.3.5  |Ensure events that modify the system's network environment are collected (Automated)                            | Completed           |"
augenrules --load &>> output.txt
fi
sudo rm -f output.txt
}


   function remediate_4136() {
   #remediation_status["4.1.3.6"]="Cannot be remediated"
   echo -e "|4.1.3.6  |Ensure use of privileged commands are collected (Automated)                                                     | Could not Remediate |"
   }
   
   
function remediate_4137() {
      {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf "
-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=-
EACCES -F auid>=${UID_MIN} -F auid!=unset -k access
-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=-
EPERM -F auid>=${UID_MIN} -F auid!=unset -k access
-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=-
EACCES -F auid>=${UID_MIN} -F auid!=unset -k access
-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=-
EPERM -F auid>=${UID_MIN} -F auid!=unset -k access
" >> /etc/audit/rules.d/50-access.rules || printf "ERROR: Variable 'UID_MIN'
is unset.\n"
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then 
#remediation_status["4.1.3.7"]="Cannot be remediated"
echo -e "|4.1.3.7  |Ensure unsuccessful file access attempts are collected (Automated)                                              | Could not Remediate |"
else
if grep -q "ERROR: Variable 'UID_MIN' is unset." output.txt;
   then
   #remediation_status["4.1.3.7"]="Cannot be remediated"
   echo -e "|4.1.3.7  |Ensure unsuccessful file access attempts are collected (Automated)                                           | Could not Remediate |"
   else
   #remediation_status["4.1.3.7"]="Completed"
   echo -e "|4.1.3.7  |Ensure unsuccessful file access attempts are collected (Automated)                                              | Completed           |"
   augenrules --load &>> output.txt 
   fi
   fi
   sudo rm -f output.txt
   }
   
   
function remediate_4138() { 
{
printf "
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity
" >> /etc/audit/rules.d/50-identity.rules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.8"]="Could not remediate"
echo -e "|4.1.3.8  |Ensure events that modify user/group information are collected (Automated)                                      | Could not Remediate |"
else
#remediation_status["4.1.3.8"]="Completed"
echo -e "|4.1.3.8  |Ensure events that modify user/group information are collected (Automated)                                      | Completed           |"
augenrules --load &>> output.txt
fi
sudo rm -f output.txt
}


       function remediate_4139() {
 {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf "
-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
-a always,exit -F arch=b32 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=${UID_MIN} -F auid!=unset -F key=perm_mod
" >> /etc/audit/rules.d/50-perm_mod.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt 
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.9"]="Could not remediate"
echo -e "|4.1.3.9  |Ensure discretionary access control permission modification events are collected (Automated)                    | Could not Remediate |"
else
if grep -q "ERROR: Variable 'UID_MIN' is unset." output.txt; then
#remediation_status["4.1.3.9"]="Could not remediate"
echo -e "|4.1.3.9  |Ensure discretionary access control permission modification events are collected (Automated)                    | Could not Remediate |"
   else
   #remediation_status["4.1.3.9"]="Completed"
   echo -e "|4.1.3.9  |Ensure discretionary access control permission modification events are collected (Automated)                    | Completed           |"
      augenrules --load &>> output.txt
   fi
   fi
   sudo rm -f output.txt
   }
   
   
   function remediate_41310() {
   {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf "
-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=unset -k mounts
-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=unset -k mounts
" >> /etc/audit/rules.d/50-mounts.rules || printf "ERROR: Variable 'UID_MIN'
is unset.\n"
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.10"]="Could not remediate"  
echo -e "|4.1.3.10 |Ensure successful file system mounts are collected (Automated)                                                  | Could not Remediate |"
else
if grep -q "ERROR: Variable 'UID_MIN'" output.txt; then
#remediation_status["4.1.3.10"]="Could not remediate"
echo -e "|4.1.3.10 |Ensure successful file system mounts are collected (Automated)                                                  | Could not Remediate |"
   else
   #remediation_status["4.1.3.10"]="Completed"
   echo -e "|4.1.3.10 |Ensure successful file system mounts are collected (Automated)                                                  | Completed           |"
   augenrules --load &>> output.txt
   fi
   fi
   }
   
   
         function remediate_41311() {
   { printf "
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k session
-w /var/log/btmp -p wa -k session
" >> /etc/audit/rules.d/50-session.rules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.11"]="Cannot remediate"
echo -e "|4.1.3.11 |Ensure session initiation information is collected (Automated)                                                  | Could not Remediate |"
else
#remediation_status["4.1.3.11"]="Completed"
echo -e "|4.1.3.11 |Ensure session initiation information is collected (Automated)                                                  | Completed           |"
augenrules --load &>> output.txt
fi
sudo rm -f output.txt
}


      function remediate_41312() {
   { printf "
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock -p wa -k logins
" >> /etc/audit/rules.d/50-login.rules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.12"]="Could not remediate"
echo -e "|4.1.3.12 |Ensure login and logout events are collected (Automated)                                                        | Could not Remediate |"
else
augenrules --load &>> output.txt
#remediation_status["4.1.3.12"]="Completed" 
echo -e "|4.1.3.12 |Ensure login and logout events are collected (Automated)                                                        | Completed           |"
fi 
}


      function remediate_41314() {
   { printf "
-w /etc/apparmor/ -p wa -k MAC-policy
-w /etc/apparmor.d/ -p wa -k MAC-policy
" >> /etc/audit/rules.d/50-MAC-policy.rules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.14"]="Could not remediate"
echo -e "|4.1.3.14 |Ensure events that modify the system's Mandatory Access Controls are collected (Automated)                      | Could not Remediate |"
else
augenrules --load &>> output.txt
#remediation_status["4.1.3.14"]="Completed"
echo -e "|4.1.3.14 |Ensure events that modify the system's Mandatory Access Controls are collected (Automated)                      | Completed           |"
fi
}


      function remediate_41315() {
   {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf "
-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k perm_chng
" >> /etc/audit/rules.d/50-perm_chng.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.15"]="Could not remediate"
echo -e "|4.1.3.15 |Ensure successful and unsuccessful attempts to use the chcon command are recorded (Automated)                   | Could not Remediate |"
else
if grep -q "ERROR: Variable 'UID_MIN' is unset." output.txt; then
#remediation_status["4.1.3.15"]="Could not remediate"
echo -e "|4.1.3.15 |Ensure successful and unsuccessful attempts to use the chcon command are recorded (Automated)                   | Could not Remediate |"
   else
   #remediation_status["4.1.3.15"]="Completed"
   echo -e "|4.1.3.15 |Ensure successful and unsuccessful attempts to use the chcon command are recorded (Automated)                   | Completed           |"
      augenrules --load &>> output.txt
   fi
   fi
      sudo rm -f output.txt
   }
   
   
            function remediate_41316() {
   {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf "
-a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k perm_chng
" >> /etc/audit/rules.d/50-priv_cmd.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.16"]="Could not remediate"
echo -e "|4.1.3.16 |Ensure successful and unsuccessful attempts to use the setfacl command are recorded (Automated)                 | Could not Remediate |"
else
if grep -q "ERROR: Variable 'UID_MIN' is unset." output.txt; then
#remediation_status["4.1.3.16"]="Could not remediate"
echo -e "|4.1.3.16 |Ensure successful and unsuccessful attempts to use the setfacl command are recorded (Automated)                 | Could not Remediate |"
   else
   #remediation_status["4.1.3.16"]="Completed"
   echo -e "|4.1.3.16 |Ensure successful and unsuccessful attempts to use the setfacl command are recorded (Automated)                 | Completed           |"
      augenrules --load &>> output.txt
   fi
   fi
      sudo rm -f output.txt
      }
      
      
                  function remediate_41317() {
   {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf "
-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k perm_chng
" >> /etc/audit/rules.d/50-perm_chng.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.17"]="Could not remediate"
echo -e "|4.1.3.17 |Ensure successful and unsuccessful attempts to use the chacl command are recorded (Automated)                   | Could not Remediate |"
else
if grep -q "ERROR: Variable 'UID_MIN' is unset." output.txt; then
#remediation_status["4.1.3.17"]="Could not remediate"
echo -e "|4.1.3.17 |Ensure successful and unsuccessful attempts to use the chacl command are recorded (Automated)                   | Could not Remediate |"
   else
   #remediation_status["4.1.3.17"]="Completed"
   echo -e "|4.1.3.17 |Ensure successful and unsuccessful attempts to use the chacl command are recorded (Automated)                   | Completed           |"
      augenrules --load &>> output.txt
   fi
   fi
      sudo rm -f output.txt
   }
   
   
   function remediate_41318() {
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf "
-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k usermod
" >> /etc/audit/rules.d/50-usermod.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.18"]="Could not remediate"
echo -e "|4.1.3.18 |Ensure successful and unsuccessful attempts to use the usermod command are recorded (Automated)                 | Could not Remediate |"
else
if grep -q "ERROR: Variable 'UID_MIN' is unset." output.txt; then
#remediation_status["4.1.3.18"]="Could not remediate"
echo -e "|4.1.3.18 |Ensure successful and unsuccessful attempts to use the usermod command are recorded (Automated)                 | Could not Remediate |"
   else
   #remediation_status["4.1.3.18"]="Completed"
   echo -e "|4.1.3.18 |Ensure successful and unsuccessful attempts to use the usermod command are recorded (Automated)                 | Completed           |"
      augenrules --load &>> output.txt
   fi
   fi
      sudo rm -f output.txt
   }
   
   
   function remediate_41319() {
   {
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && printf "
-a always,exit -F arch=b64 -S init_module,finit_module,delete_module,create_module,query_module -F
auid>=${UID_MIN} -F auid!=unset -k kernel_modules
-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=${UID_MIN} -F auid!=unset -k kernel_modules
" >> /etc/audit/rules.d/50-kernel_modules.rules || printf "ERROR: Variable 'UID_MIN' is unset.\n"
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.19"]="Could not remediate"
echo -e "|4.1.3.19 |Ensure kernel module loading unloading and modification is collected (Automated)                                | Could not Remediate |"
else
if grep -q "ERROR: Variable 'UID_MIN' is unset." output.txt; then
#remediation_status["4.1.3.19"]="Could not remediate"
echo -e "|4.1.3.19 |Ensure kernel module loading unloading and modification is collected (Automated)                                | Could not Remediate |"
   else
   #remediation_status["4.1.3.19"]="Completed"
   echo -e "|4.1.3.19 |Ensure kernel module loading unloading and modification is collected (Automated)                                | Completed           |"
      augenrules --load &>> output.txt
   fi
   fi
      sudo rm -f output.txt
   }
   
   
   function remediate_41320() {
{ printf -- "-e 2" >> /etc/audit/rules.d/99-finalize.rules 
} &>> output.txt
augenrules --load &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.20"]="Could not remediate"
echo -e "|4.1.3.20 |Ensure the audit configuration is immutable (Automated)                                                         | Could not Remediate |"
else
#remediation_status["4.1.3.20"]="Completed"
echo -e "|4.1.3.20 |Ensure the audit configuration is immutable (Automated)                                                         | Completed           |"
fi
   sudo rm -f output.txt
}


   function remediate_41321() {
augenrules --load &>> output.txt
{ if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then echo "Reboot required to load rules"; fi
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
#remediation_status["4.1.3.21"]="Could not remediate"
echo -e "|4.1.3.21 |Ensure the running and on disk configuration is the same (Manual)                                               | Could not Remediate |"
elif grep -q "command not found" output.txt;
then
#remediation_status["4.1.3.21"]="Could not remediate"
echo -e "|4.1.3.21 |Ensure the running and on disk configuration is the same (Manual)                                               | Could not Remediate |"
else
#remediation_status["4.1.3.21"]="Reboot required"
echo -e "|4.1.3.21 |Ensure the running and on disk configuration is the same (Manual)                                               | Completed           |"
fi
sudo rm -f output.txt
}


   function remediate_4141() {
{ find "$(dirname $( awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf | xargs))" -type f \( ! -perm 600 -a ! -perm 0400 -a ! -perm 0200 -a ! -perm 0000 -a ! -perm 0640 -a ! -perm 0440 -a ! -perm 0040 \) -exec chmod u-x,g-wx,o-rwx {} +
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.4.1  |Ensure audit log files are mode 0640 or less permissive (Automated)                                             | Could not Remediate |"
else
#remediation_status["4.1.4.1"]="Completed"
echo -e "|4.1.4.1  |Ensure audit log files are mode 0640 or less permissive (Automated)                                             | Completed           |"
fi
sudo rm -f output.txt
}


   function remediate_4142() {
{ find $(dirname $(awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf | xargs)) -type f ! -user root -exec chown root {} +
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.4.2  |Ensure only authorized users own audit log files (Automated)                                                    | Could not Remediate |"
else
#remediation_status["4.1.4.2"]="Completed"
echo -e "|4.1.4.2  |Ensure only authorized users own audit log files (Automated)                                                    | Completed           |"
fi
sudo rm -f output.txt
}


   function remediate_4143() {
{ find $(dirname $(awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf | xargs)) -type f \( ! -group adm -a ! -group root \) -exec chgrp adm {} +
chgrp adm /var/log/audit/
sed -ri 's/^\s*#?\s*log_group\s*=\s*\S+(\s*#.*)?.*$/log_group = adm\1/' /etc/audit/auditd.conf
systemctl restart auditd 
} &>> output.txt
#remediation_status["4.1.4.3"]="Completed"
echo -e "|4.1.4.3  |Ensure only authorized groups are assigned ownership of audit log files (Automated)                             | Completed           |"
sudo rm -f output.txt
}


  function remediate_4144() {
{ chmod g-w,o-rwx "$(dirname $( awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf))"
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.4.4  |Ensure the audit log directory is 0750 or more restrictive (Automated)                                          | Could not Remediate |"
else
#remediation_status["4.1.4.4"]="Completed"
echo -e "|4.1.4.4  |Ensure the audit log directory is 0750 or more restrictive (Automated)                                          | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_4145() {
{ find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec chmod u-x,g-wx,o-rwx {} +
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.4.5  |Ensure audit configuration files are 640 or more restrictive (Automated)                                        | Could not Remediate |"
else
#remediation_status["4.1.4.5"]="Completed"
echo -e "|4.1.4.5  |Ensure audit configuration files are 640 or more restrictive (Automated)                                        | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_4146() {
{ find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root -exec chown root {} +
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.4.6  |Ensure audit configuration files are owned by root (Automated)                                                  | Could not Remediate |"
else
#remediation_status["4.1.4.6"]="Completed"
echo -e "|4.1.4.6  |Ensure audit configuration files are owned by root (Automated)                                                  | Completed           |"
fi
sudo rm -f ooutput.txt
}


  function remediate_4147() {
{ find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root -exec chgrp root {} +
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.4.7  |Ensure audit configuration files belong to group root (Automated)                                               | Could not Remediate |"
else
#remediation_status["4.1.4.7"]="Completed"
echo -e "|4.1.4.7  |Ensure audit configuration files belong to group root (Automated)                                               | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_4148() {
{ chmod go-w /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      | Could not Remediate |"
else
#remediation_status["4.1.4.8"]="Completed"
echo -e "|4.1.4.8  |Ensure audit tools are 755 or more restrictive (Automated)                                                      | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_4149() {
{ chown root /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                | Could not Remediate |"
else
#remediation_status["4.1.4.9"]="Completed"
echo -e "|4.1.4.9  |Ensure audit tools are owned by root (Automated)                                                                | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_41410() {
{ chmod go-w /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules
chown root:root /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.4.10  |Ensure audit tools belong to group root (Automated)                                                            | Could not Remediate |"
else
#remediation_status["4.1.4.10"]="Completed"
echo -e "|4.1.4.10 |Ensure audit tools belong to group root (Automated)                                                             | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_41411() {
{ printf "\n/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
printf "\n/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
printf "\n/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
printf "\n/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
printf "\n/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
printf "\n/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512" >> /etc/aide/aide.conf
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
echo -e "|4.1.3.11 |Ensure cryptographic mechanisms are used to protect the integrity of audit tools (Automated)                    | Could not Remediate |"
else
#remediation_status["4.1.4.11"]="Completed"
echo -e "|4.1.4.11  |Ensure cryptographic mechanisms are used to protect the integrity of audit tools (Automated)                   | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_42111() {
apt install systemd-journal-remote &>> output.txt
#remediation_status["4.2.1.1.1"]="Completed"
echo -e "|4.2.1.1.1  |Ensure systemd-journal-remote is installed (Automated)                                                        | Completed           |"
sudo rm -f output.txt
}


  function remediate_42112() {
#remediation_status["4.2.1.1.2"]="Cannot be remediated"
echo -e "|4.2.1.1.2  |Ensure systemd-journal-remote is configured (Manual)                                                          | Completed           |"
}


  function remediate_42113() {
systemctl --now enable systemd-journal-upload.service &>> output.txt
if grep -q "Failed" output.txt;
then
#remediation_status["4.2.1.1.3"]="Could not Remediate"
echo -e "|4.2.1.1.3 |Ensure systemd-journal-remote is enabled (Manual)                                                              | Could not Remediate |"
else
#remediation_status["4.2.1.1.3"]="Completed"
echo -e "|4.2.1.1.3 |Ensure systemd-journal-remote is enabled (Manual)                                                              | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_42114() {
systemctl --now disable systemd-journal-remote.socket &>> output.txt
if grep -q "Failed" output.txt;
then
#remediation_status["4.2.1.1.4"]="Could not Remediate"
echo -e "|4.2.1.1.4 |Ensure journald is not configured to recieve logs from a remote client (Automated)                             | Could not Remediate |"
else
#remediation_status["4.2.1.1.4"]="Completed"
echo -e "|4.2.1.1.4 |Ensure journald is not configured to recieve logs from a remote client (Automated)                             | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_4212() {
#remediation_status["4.2.1.2"]="Cannot be remediated"
echo -e "|4.2.1.2 |Ensure journald service is enabled (Automated)                                                                   | Could not Remediate |"
}


  function remediate_4213() {
{ printf "\nCompress=yes" >> etc/systemd/journald.conf
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
systemctl restart systemd-journald
#remediation_status["4.2.1.3"]="Could not Remediate"
echo -e "|4.2.1.3 |Ensure journald is configured to compress large log files (Automated)                                            | Could not Remediate |"
else
#remediation_status["4.2.1.3"]="Completed"
echo -e "|4.2.1.3 |Ensure journald is configured to compress large log files (Automated)                                            | Completed           |"
fi
sudo rm -f output.txt
}


  function remediate_4214() {
{ printf "\nStorage=persistent" >> etc/systemd/journald.conf
} &>> output.txt
if grep -q "No such file or directory" output.txt;
then
systemctl restart systemd-journald
#remediation_status["4.2.1.4"]="Could not Remediate"
echo -e "|4.2.1.4 |Ensure journald is configured to write logfiles to persistent disk (Automated)                                   | Could not Remediate |"
else
systemctl restart systemd-journald
#remediation_status["4.2.1.4"]="Completed"
echo -e "|4.2.1.4 |Ensure journald is configured to write logfiles to persistent disk (Automated)                                   | Completed           |"
fi
sudo rm -f output.txt
}


function remediate_4215() {
sed -i 'ForwardToSyslog=yes' /etc/systemd/journald.conf &>> output.txt
systemctl restart systemd-journald
#remediation_status["4.2.1.5"]="Completed"
echo -e "|4.2.1.5 |Ensure journald is not configured to send logs to rsyslog (Manual)                                               | Completed           |"
sudo rm -f output.txt
}


  function remediate_4216() {
#remediation_status["4.2.1.6"]="Cannot be remediated"
echo -e "|4.2.1.6 |Ensure journald log rotation is configured per site policy (Manual)                                              | Completed           |"
}


  function remediate_4217() {
#remediation_status["4.2.1.7"]="Cannot be remediated"
echo -e "|4.2.1.7 |Ensure journald default file permissions configured (Manual)                                                     | Completed           |"
}


  function remediate_4221() {
apt install rsyslog &>> output.txt
#remediation_status["4.2.2.1"]="Completed"
echo -e "|4.2.2.1 |Ensure rsyslog is installed (Automated)                                                                          | Completed           |"
sudo rm -f output.txt
}


  function remediate_4222() {
systemctl --now enable rsyslog &>> output.txt
#remediation_status["4.2.2.2"]="Completed"
echo -e "|4.2.2.2 |Ensure rsyslog service is enabled (Automated)                                                                    | Completed           |"
sudo rm -f output.txt
}


  function remediate_4223() {
{ sed -i 'ForwardToSyslog=yes' /etc/systemd/journald.conf
} &>> output.txt
systemctl restart rsyslog
#remediation_status["4.2.2.3"]="Completed"
echo -e "|4.2.2.3 |Ensure journald is configured to send logs to rsyslog (Manual)                                                   | Could not Remediate |"
sudo rm -f output.txt
}


  function remediate_4224() {
{ sed -i '$FileCreateMode' /etc/rsyslog.conf
} &>> output.txt
systemctl restart rsyslog
#remediation_status["4.2.2.4"]="Completed"
echo -e "|4.2.2.4 |Ensure rsyslog default file permissions are configured (Automated)                                               | Could not Remediate |"
sudo rm -f output.txt
}


  function remediate_4225() {
# remediation_status["4.2.2.5"]="Cannot be remediated"
echo -e "|4.2.1.5 |Ensure logging is configured (Manual)                                                                            | Could not Remediate |"
}


  function remediate_4226() {
#remediation_status["4.2.2.6"]="Cannot be remediated"
echo -e "|4.2.1.6 |Ensure rsyslog is configured to send logs to a remote log host (Manual)                                          | Could not Remediate |"
}


  function remediate_4227() {
{ sed -i ' $ModLoad imtcp' /etc/rsyslog.conf
sed -i ' $InputTCPServerRun' /etc/rsyslog.conf
sed -i ' $ModLoad imtcp' /etc/rsyslog.d/*.conf
sed -i ' $InputTCPServerRun' /etc/rsyslog.d/*.conf

sed -i ' module(load="imtcp")' /etc/rsyslog.conf
sed -i ' input(type="imtcp" port="514")' /etc/rsyslog.conf
sed -i ' module(load="imtcp")' /etc/rsyslog.d/*.conf
sed -i ' input(type="imtcp" port="514")' /etc/rsyslog.d/*.conf
} &>> output.txt

systemctl restart rsyslog
#remediation_status["4.2.2.7"]="Cannot be remediated"
echo -e "|4.2.1.7 |Ensure rsyslog is not configured to receive logs from a remote client (Automated)                                | Could not Remediate |"
sudo rm -f output.txt
}


  function remediate_423() {
#remediation_status["4.2.3"]="Cannot be remediated"
echo -e "|4.2.3   |Ensure all logfiles have appropriate permissions and ownership (Automated)                                       | Could not Remediate |"
}
yes | remediate_4111
remediate_4112
remediate_4113
remediate_4114
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|4.1.2    | Configure Data Retention                                                                                       |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
# Section 4.1.2
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|4.1.2    | Configure Data Retention                                                                                       |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
remediate_4121
remediate_4122
remediate_4123
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|4.1.3    | Configure auditd rules                                                                                         |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
remediate_4131
remediate_4132
remediate_4133
remediate_4134
remediate_4135
remediate_4136
remediate_4137
remediate_4138
remediate_4139
remediate_41310
remediate_41311
remediate_41312
#remediate_41313
remediate_41314
remediate_41315
remediate_41316
remediate_41317
remediate_41318
remediate_41319
remediate_41320
remediate_41321
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|4.1.4    | Configure auditd file access                                                                                   |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
remediate_4141
remediate_4142
remediate_4143
remediate_4144
remediate_4145
remediate_4146
remediate_4147
remediate_4148
remediate_4149
remediate_41410
remediate_41411
#section 4.2
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|4.2      | Configure Logging                                                                                              |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
    #section 4.2.1
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|4.2.1    | Configure journald                                                                                             |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
    #section 4.2.1.1
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|4.2.1.1  | Ensure journald is configured to send logs to a remote log host                                                |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
yes | remediate_42111
remediate_42112
remediate_42113
remediate_42114
remediate_4212
remediate_4213
remediate_4214
remediate_4215
remediate_4216
remediate_4217
    #section 4.2.2
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|4.2.2   | Configure rsyslog                                                                                               |                     |"
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"
yes | remediate_4221
remediate_4222
remediate_4223
remediate_4224
remediate_4225
remediate_4226
remediate_4227
remediate_423
echo "|------------------------------------------------------------------------------------------------------------------------------------------------|"

