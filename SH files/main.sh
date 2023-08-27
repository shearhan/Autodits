#!/bin/bash
exec &> >(tee output2.txt)



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
	    "3.1.1") $fails_script 3.1.1 ;;
                "3.1.2") $fails_script 3.1.2 ;;
                "3.2.1") $fails_script 3.2.1 ;;
                "3.2.2") $fails_script 3.2.2 ;;
                "3.3.1") $fails_script 3.3.1 ;;
                "3.3.2") $fails_script 3.3.2 ;;
                "3.3.3") $fails_script 3.3.3 ;;
                "3.3.4") $fails_script 3.3.4 ;;
                "3.3.5") $fails_script 3.3.5 ;;
                "3.3.6") $fails_script 3.3.6 ;;
                "3.3.7") $fails_script 3.3.7 ;;
                "3.3.8") $fails_script 3.3.8 ;;
                "3.3.9") $fails_script 3.3.9 ;;
                "3.4.1") $fails_script 3.4.1 ;;
                "3.4.2") $fails_script 3.4.2 ;;
                "3.4.3") $fails_script 3.4.3 ;;
                "3.4.4") $fails_script 3.4.4 ;;
                "3.5.1.1") $fails_script 3.5.1.1 ;;
                "3.5.1.2") $fails_script 3.5.1.2 ;;
                "3.5.1.3") $fails_script 3.5.1.3 ;;
                "3.5.1.4") $fails_script 3.5.1.4 ;;
                "3.5.1.5") $fails_script 3.5.1.5 ;;
                "3.5.1.6") $fails_script 3.5.1.6 ;;
                "3.5.1.7") $fails_script 3.5.1.7 ;;
                "3.5.2.1") $fails_script 3.5.2.1 ;;
                "3.5.2.2") $fails_script 3.5.2.2 ;;
                "3.5.2.3") $fails_script 3.5.2.3 ;;
                "3.5.2.4") $fails_script 3.5.2.4 ;;
                "3.5.2.5") $fails_script 3.5.2.5 ;;
                "3.5.2.6") $fails_script 3.5.2.6 ;;
                "3.5.2.7") $fails_script 3.5.2.7 ;;
                "3.5.2.8") $fails_script 3.5.2.8 ;;
                "3.5.2.9") $fails_script 3.5.2.9 ;;
                "3.5.2.10") $fails_script 3.5.2.10 ;;
                "3.5.3.1.1") $fails_script 3.5.3.1.1 ;;
                "3.5.3.1.2") $fails_script 3.5.3.1.2 ;;
                "3.5.3.1.3") $fails_script 3.5.3.1.3 ;;
                "3.5.3.2.1") $fails_script 3.5.3.2.1 ;;
                "3.5.3.2.2") $fails_script 3.5.3.2.2 ;;
                "3.5.3.2.3") $fails_script 3.5.3.2.3 ;;
                "3.5.3.2.4") $fails_script 3.5.3.2.4 ;;
                "3.5.3.3.1") $fails_script 3.5.3.3.1 ;;
                "3.5.3.3.2") $fails_script 3.5.3.3.2 ;;
                "3.5.3.3.3") $fails_script 3.5.3.3.3 ;;
                "3.5.3.3.4") $fails_script 3.5.3.3.4 ;;
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
		"5.1.1") $fails_script 5.1.1 ;;
                "5.1.2") $fails_script 5.1.2 ;;
                "5.1.3") $fails_script 5.1.3 ;;
                "5.1.4") $fails_script 5.1.4 ;;
                "5.1.5") $fails_script 5.1.5 ;;
                "5.1.6") $fails_script 5.1.6 ;;
                "5.1.7") $fails_script 5.1.7 ;;
                "5.1.8") $fails_script 5.1.8 ;;
                "5.1.9") $fails_script 5.1.9 ;;
                "5.2.1") $fails_script 5.2.1 ;;
                "5.2.2") $fails_script 5.2.2 ;;
                "5.2.3") $fails_script 5.2.3 ;;
                "5.2.4") $fails_script 5.2.4 ;;
                "5.2.5") $fails_script 5.2.5 ;;
                "5.2.6") $fails_script 5.2.6 ;;
                "5.2.7") $fails_script 5.2.7 ;;
                "5.2.8") $fails_script 5.2.8 ;;
                "5.2.9") $fails_script 5.2.9 ;;
                "5.2.10") $fails_script 5.2.10 ;;
                "5.2.11") $fails_script 5.2.11 ;;
                "5.2.12") $fails_script 5.2.12 ;;
                "5.2.13") $fails_script 5.2.13 ;;
                "5.2.14") $fails_script 5.2.14 ;;
                "5.2.15") $fails_script 5.2.15 ;;
                "5.2.16") $fails_script 5.2.16 ;;
                "5.2.17") $fails_script 5.2.17 ;;
                "5.2.18") $fails_script 5.2.18 ;;
                "5.2.19") $fails_script 5.2.19 ;;
                "5.2.20") $fails_script 5.2.20 ;;
                "5.2.21") $fails_script 5.2.21 ;;
                "5.2.22") $fails_script 5.2.22 ;;
                "5.3.1") $fails_script 5.3.1 ;;
                "5.3.2") $fails_script 5.3.2 ;;
                "5.3.3") $fails_script 5.3.3 ;;
                "5.3.4") $fails_script 5.3.4 ;;
                "5.3.5") $fails_script 5.3.5 ;;
                "5.3.6") $fails_script 5.3.6 ;;
                "5.3.7") $fails_script 5.3.7 ;;
                "5.4.1") $fails_script 5.4.1 ;;
                "5.4.2") $fails_script 5.4.2 ;;
                "5.4.3") $fails_script 5.4.3 ;;
                "5.4.4") $fails_script 5.4.4 ;;
                "5.4.5") $fails_script 5.4.5 ;;
                "5.5.1.1") $fails_script 5.5.1.1 ;;
                "5.5.1.2") $fails_script 5.5.1.2 ;;
                "5.5.1.3") $fails_script 5.5.1.3 ;;
                "5.5.1.4") $fails_script 5.5.1.4 ;;
                "5.5.1.5") $fails_script 5.5.1.5 ;;
                "5.5.2") $fails_script 5.5.2 ;;
                "5.5.3") $fails_script 5.5.3 ;;
                "5.5.4") $fails_script 5.5.4 ;;
                "5.5.5") $fails_script 5.5.5 ;;
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
	    "1.1.2.1") ./remediation.sh 1.1.2.1;;
                "1.1.2.2") ./remediation.sh 1.1.2.1;;
                "1.1.2.3") ./remediation.sh 1.1.2.3;;
                "1.1.2.4") ./remediation.sh 1.1.2.2;;
                "1.1.3.1") ./remediation.sh 1.1.3.1;;
                "1.1.3.2") ./remediation.sh 1.1.3.2;;
                "1.1.3.3") ./remediation.sh 1.1.3.3;;
                "1.1.4.1") ./remediation.sh 1.1.4.1;;
                "1.1.4.2") ./remediation.sh 1.1.4.2;;
                "1.1.4.3") ./remediation.sh 1.1.4.3;;
                "1.1.4.4") ./remediation.sh 1.1.4.4;;
                "1.1.5.1") ./remediation.sh 1.1.5.1;;
                "1.1.5.2") ./remediation.sh 1.1.5.2;;
                "1.1.5.3") ./remediation.sh 1.1.5.3;;
                "1.1.5.4") ./remediation.sh 1.1.5.4;;
                "1.1.6.1") ./remediation.sh 1.1.6.1;;
                "1.1.6.2") ./remediation.sh 1.1.6.2;;
                "1.1.6.3") ./remediation.sh 1.1.6.3;;
                "1.1.6.4") ./remediation.sh 1.1.6.4;;
                "1.1.7.1") ./remediation.sh 1.1.7.1;;
                "1.1.7.2") ./remediation.sh 1.1.7.2;;
                "1.1.7.3") ./remediation.sh 1.1.7.3;;
                "1.1.8.1") ./remediation.sh 1.1.8.1;;
                "1.1.8.2") ./remediation.sh 1.1.8.2;;
                "1.1.8.3") ./remediation.sh 1.1.8.3;;
                "1.1.9")  ./remediation.sh 1.1.9;;
                "1.1.10") ./remediation.sh 1.1.10;;
                "1.3.1")  ./remediation.sh 1.3.1;;
                "1.3.2") ./remediation.sh 1.3.2;;
                "1.4.1") ./remediation.sh 1.4.1;;
                "1.4.2") ./remediation.sh 1.4.2;;
                "1.4.3") ./remediation.sh 1.4.3;;
                "1.5.1") ./remediation.sh 1.5.1;;
                "1.5.2") ./remediation.sh 1.5.2;;
                "1.5.3") ./remediation.sh 1.5.3;;
                "1.5.4") ./remediation.sh 1.5.4;;
                "1.6.1.1") ./remediation.sh 1.6.1.1;;
                "1.6.1.2") ./remediation.sh 1.6.1.2;;
                "1.6.1.3") ./remediation.sh 1.6.1.3;;
                "1.6.1.4") ./remediation.sh 1.6.1.4;;
                "1.7.1") ./remediation.sh 1.7.1;;
                "1.7.2") ./remediation.sh 1.7.2;;
                "1.7.3") ./remediation.sh 1.7.3;;
                "1.7.4") ./remediation.sh 1.7.4;;
                "1.7.5") ./remediation.sh 1.7.5;;
                "1.7.6") ./remediation.sh 1.7.6;;
                "1.8.1") ./remediation.sh 1.8.1;;
                "1.8.10") ./remediation.sh 1.8.10;;
		"3.1.1") ./remediation.sh 3.1.1 ;;
        "3.1.2") ./remediation.sh 3.1.2 ;;
        "3.2.1") ./remediation.sh 3.2.1 ;;
        "3.2.2") ./remediation.sh 3.2.2 ;;
        "3.3.1") ./remediation.sh 3.3.1 ;;
        "3.3.2") ./remediation.sh 3.3.2 ;;
        "3.3.3") ./remediation.sh 3.3.3 ;;
        "3.3.4") ./remediation.sh 3.3.4 ;;
        "3.3.5") ./remediation.sh 3.3.5 ;;
        "3.3.6") ./remediation.sh 3.3.6 ;;
        "3.3.7") ./remediation.sh 3.3.7 ;;
        "3.3.8") ./remediation.sh 3.3.8 ;;
        "3.3.9") ./remediation.sh 3.3.9 ;;
        "3.4.1") ./remediation.sh 3.4.1 ;;
        "3.4.2") ./remediation.sh 3.4.2 ;;
        "3.4.3") ./remediation.sh 3.4.3 ;;
        "3.4.4") ./remediation.sh 3.4.4 ;;
        "3.5.1.1") ./remediation.sh 3.5.1.1 ;;
        "3.5.1.2") ./remediation.sh 3.5.1.2 ;;
        "3.5.1.3") ./remediation.sh 3.5.1.3 ;;
        "3.5.1.4") ./remediation.sh 3.5.1.4 ;;
        "3.5.1.5") ./remediation.sh 3.5.1.5 ;;
        "3.5.1.6") ./remediation.sh 3.5.1.6 ;;
        "3.5.1.7") ./remediation.sh 3.5.1.7 ;;
        "3.5.2.1") ./remediation.sh 3.5.2.1 ;;
        "3.5.2.2") ./remediation.sh 3.5.2.2 ;;
        "3.5.2.3") ./remediation.sh 3.5.2.3 ;;
        "3.5.2.4") ./remediation.sh 3.5.2.4 ;;
        "3.5.2.5") ./remediation.sh 3.5.2.5 ;;
        "3.5.2.6") ./remediation.sh 3.5.2.6 ;;
        "3.5.2.7") ./remediation.sh 3.5.2.7 ;;
        "3.5.2.8") ./remediation.sh 3.5.2.8 ;;
        "3.5.2.9") ./remediation.sh 3.5.2.9 ;;
        "3.5.2.10") ./remediation.sh 3.5.2.10 ;;
        "3.5.3.1.1") ./remediation.sh 3.5.3.1.1 ;;
        "3.5.3.1.2") ./remediation.sh 3.5.3.1.2 ;;
        "3.5.3.1.3") ./remediation.sh 3.5.3.1.3 ;;
        "3.5.3.2.1") ./remediation.sh 3.5.3.2.1 ;;
        "3.5.3.2.2") ./remediation.sh 3.5.3.2.2 ;;
        "3.5.3.2.3") ./remediation.sh 3.5.3.2.3 ;;
        "3.5.3.2.4") ./remediation.sh 3.5.3.2.4 ;;
        "3.5.3.3.1") ./remediation.sh 3.5.3.3.1 ;;
        "3.5.3.3.2") ./remediation.sh 3.5.3.3.2 ;;
        "3.5.3.3.3") ./remediation.sh 3.5.3.3.3 ;;
        "3.5.3.3.4") ./remediation.sh 3.5.3.3.4 ;;
	"4.1.1.1") ./remediation.sh 4.1.1.1;;
                "4.1.1.2") ./remediation.sh 4.1.1.2;;
                "4.1.1.3") ./remediation.sh 4.1.1.3;;
                "4.1.1.4") ./remediation.sh 4.1.1.4;;
                "4.1.2.1") ./remediation.sh 4.1.2.1;;
                "4.1.2.3") ./remediation.sh 4.1.2.3;;
                "4.1.3.1") ./remediation.sh 4.1.3.1;;
                "4.1.3.2") ./remediation.sh 4.1.3.2;;
                "4.1.3.3") ./remediation.sh 4.1.3.3;;
                "4.1.3.4") ./remediation.sh 4.1.3.4;;
                "4.1.3.5") ./remediation.sh 4.1.3.5;;
                "4.1.3.6") ./remediation.sh 4.1.3.6;;
                "4.1.3.7") ./remediation.sh 4.1.3.7;;
                "4.1.3.8") ./remediation.sh 4.1.3.8;;
                "4.1.3.9") ./remediation.sh 4.1.3.9;;
                "4.1.3.10") ./remediation.sh 4.1.3.10;;
                "4.1.3.11") ./remediation.sh 4.1.3.11;;
                "4.1.3.12") ./remediation.sh 4.1.3.12;;
                "4.1.3.13") ./remediation.sh 4.1.3.13;;
                "4.1.3.14") ./remediation.sh 4.1.3.14;;
                "4.1.3.15") ./remediation.sh 4.1.3.15;;
                "4.1.3.16") ./remediation.sh 4.1.3.16;;
                "4.1.3.17") ./remediation.sh 4.1.3.17;;
                "4.1.3.18") ./remediation.sh 4.1.3.18;;
                "4.1.3.19") ./remediation.sh 4.1.3.19;;
                "4.1.3.20") ./remediation.sh 4.1.3.20;;
                "4.1.3.21") ./remediation.sh 4.1.3.21;;
                "4.1.4.1") ./remediation.sh 4.1.4.1;;
                "4.1.4.2") ./remediation.sh 4.1.4.2;;
                "4.1.4.3") ./remediation.sh 4.1.4.3;;
                "4.1.4.4") ./remediation.sh 4.1.4.4;;
                "4.1.4.5") ./remediation.sh 4.1.4.5;;
                "4.1.4.6") ./remediation.sh 4.1.4.6;;
                "4.1.4.7") ./remediation.sh 4.1.4.7;;
                "4.1.4.7") ./remediation.sh 4.1.4.7;;
                "4.1.4.8") ./remediation.sh 4.1.4.8;;
                "4.1.4.9") ./remediation.sh 4.1.4.9;;
                "4.1.4.10") ./remediation.sh 4.1.4.10;;
                "4.1.4.11") ./remediation.sh 4.1.4.11;;
                "4.2.1.1.1") ./remediation.sh 4.2.1.1.1;;
                "4.2.1.1.2") ./remediation.sh 4.2.1.1.2;;
                "4.2.1.1.3") ./remediation.sh 4.2.1.1.3;;
                "4.2.1.1.4") ./remediation.sh 4.2.1.1.4;;
                "4.2.1.2") ./remediation.sh 4.2.1.2;;
                "4.2.1.3") ./remediation.sh 4.2.1.3;;
                "4.2.1.4") ./remediation.sh 4.2.1.4;;
                "4.2.1.5") ./remediation.sh 4.2.1.5;;
                "4.2.2.1") ./remediation.sh 4.2.2.1;;
                "4.2.2.2") ./remediation.sh 4.2.2.2;;
                "4.2.2.4") ./remediation.sh 4.2.2.4;;
                "4.2.2.7") ./remediation.sh 4.2.2.7;;
		"5.1.1") ./remediation.sh 5.1.1 ;;
        "5.1.2") ./remediation.sh 5.1.2 ;;
        "5.1.3") ./remediation.sh 5.1.3 ;;
        "5.1.4") ./remediation.sh 5.1.4 ;;
        "5.1.5") ./remediation.sh 5.1.5 ;;
        "5.1.6") ./remediation.sh 5.1.6 ;;
        "5.1.7") ./remediation.sh 5.1.7 ;;
        "5.1.8") ./remediation.sh 5.1.8 ;;
        "5.1.9") ./remediation.sh 5.1.9 ;;
        "5.2.1") ./remediation.sh 5.2.1 ;;
        "5.2.2") ./remediation.sh 5.2.2 ;;
        "5.2.3") ./remediation.sh 5.2.3 ;;
        "5.2.4") ./remediation.sh 5.2.4 ;;
        "5.2.5") ./remediation.sh 5.2.5 ;;
        "5.2.6") ./remediation.sh 5.2.6 ;;
        "5.2.7") ./remediation.sh 5.2.7 ;;
        "5.2.8") ./remediation.sh 5.2.8 ;;
        "5.2.9") ./remediation.sh 5.2.9 ;;
        "5.2.10") ./remediation.sh 5.2.10 ;;
        "5.2.11") ./remediation.sh 5.2.11 ;;
        "5.2.12") ./remediation.sh 5.2.12 ;;
        "5.2.13") ./remediation.sh 5.2.13 ;;
        "5.2.14") ./remediation.sh 5.2.14 ;;
        "5.2.15") ./remediation.sh 5.2.15 ;;
        "5.2.16") ./remediation.sh 5.2.16 ;;
        "5.2.17") ./remediation.sh 5.2.17 ;;
        "5.2.18") ./remediation.sh 5.2.18 ;;
        "5.2.19") ./remediation.sh 5.2.19 ;;
        "5.2.20") ./remediation.sh 5.2.20 ;;
        "5.2.21") ./remediation.sh 5.2.21 ;;
        "5.2.22") ./remediation.sh 5.2.22 ;;
        "5.3.1") ./remediation.sh 5.3.1 ;;
        "5.3.2") ./remediation.sh 5.3.2 ;;
        "5.3.3") ./remediation.sh 5.3.3 ;;
        "5.3.4") ./remediation.sh 5.3.4 ;;
        "5.3.5") ./remediation.sh 5.3.5 ;;
        "5.3.6") ./remediation.sh 5.3.6 ;;
        "5.3.7") ./remediation.sh 5.3.7 ;;
        "5.4.1") ./remediation.sh 5.4.1 ;;
        "5.4.2") ./remediation.sh 5.4.2 ;;
        "5.4.3") ./remediation.sh 5.4.3 ;;
        "5.4.4") ./remediation.sh 5.4.4 ;;
        "5.4.5") ./remediation.sh 5.4.5 ;;
        "5.5.1.1") ./remediation.sh 5.5.1.1 ;;
        "5.5.1.2") ./remediation.sh 5.5.1.2 ;;
        "5.5.1.3") ./remediation.sh 5.5.1.3 ;;
        "5.5.1.4") ./remediation.sh 5.5.1.4 ;;
        "5.5.1.5") ./remediation.sh 5.5.1.5 ;;
        "5.5.2") ./remediation.sh 5.5.2 ;;
        "5.5.3") ./remediation.sh 5.5.3 ;;
        "5.5.4") ./remediation.sh 5.5.4 ;;
        "5.5.5") ./remediation.sh 5.5.5 ;;
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

# Audit Title 1.1.2.1

findmnt --kernel /tmp >> output.txt
if grep -E -q "/tmp   tmpfs  tmpfs  rw,nosuid,nodev,noexec,relatime,size=2097152k,inode64" output.txt;
then
        systemctl is-enabled tmp.mount >> output.txt
        if grep -q "enabled" output.txt;
        then
                echo -e "|1.1.2.1  | Ensure /tmp is a separate partition                                                                            |${GREEN} Pass${NC}              |"
                
                ((pass_count++))
        else
                echo -e "|${RED}1.1.2.1  | Ensure /tmp is a separate partition                                                                            | Fail             ${NC}|"
                
                ((fail_count++))
                failed_sections+="1.1.2.1 "
        fi
  else
          echo -e  "|${RED}1.1.2.1  | Ensure /tmp is a separate partition                                                                            | Fail             ${NC}|"
          
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.2.2  | Ensure nodev option set on /tmp partition                                                                      | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.2.3  | Ensure noexec option set on /tmp partition                                                                     | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.1.2.3 "
fi
sudo rm -f output.txt
((total++))

findmnt --kernel /tmp | grep nosuid >> output.txt
if grep -E -q "nosuid" output.txt;
then
        echo -e "|1.1.2.4  | Ensure nosuid option set on /tmp partition                                                                     |${GREEN} Pass${NC}             |"
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.2.4  | Ensure nosuid option set on /tmp partition                                                                     | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.1.2.4 "
fi
sudo rm -f output.txt
((total++))

# Section 1.1.3
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.3    | Configure /var                                                                                                 |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

findmnt --kernel /var >> output.txt
if grep -E -q "/var" output.txt;
then
        echo -e "|1.1.3.1  | Ensure separate partition exists for /var                                                                      |${GREEN} Pass${NC}             |"
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.3.1  | Ensure separate partition exists for /var                                                                      | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.3.2  | Ensure nodev option set on /var partition                                                                      | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.3.3  | Ensure nosuid option set on /var partition                                                                     | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.1.3.3 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files.

#Explanation: The nosuid opition has not been set, or has been set incorrectly on the /var mount

# Section 1.1.4

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.4    | Configure /var/tmp                                                                                             |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

findmnt --kernel /var/tmp >> output.txt
if grep -E -q "/var/tmp" output.txt;
then
        echo -e "|1.1.4.1  | Ensure separate partition exists for /var/tmp                                                                 |${GREEN} Pass${NC}              |"
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.4.1  | Ensure separate partition exists for /var/tmp                                                                  | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.4.2  | Ensure noexec option set on /var/tmp partition                                                                 | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.4.3  | Ensure nosuid option set on /var/tmp partition                                                                 | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.4.4  | Ensure nodev option set on /var/tmp partition                                                                  | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.1.4.4 "
fi
sudo rm -f output.txt


#Description: The nodev mount option specifies that the filesystem cannot contain special devices.
#Explanation: The nodev option has not been set, or has been set incorrectly on the /var/tmp mount
((total++))


# Section 1.1.5

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.5    | Configure /var/log                                                                                             |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
findmnt --kernel /var/log >> output.txt
if grep -E -q "/var/log" output.txt;
then
        echo -e "|1.1.5.1  | Ensure separate partition exists for /var/log                                                                 |${GREEN} Pass${NC}              |"
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.5.1  | Ensure separate partition exists for /var/log                                                                  | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.5.2  | Ensure nodev option set on /var/log partition                                                                  | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.5.3  | Ensure noexec option set on /var/log partition                                                                 | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.5.4  | Ensure nosuid option set on /var/log partition                                                                 | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.1.5.4 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files
#Explanation: The nosuid option has not been set, or has been set incorrectly on the /var/log mount


# Section 1.1.6

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.6    | Configure /var/log/audit                                                                                       |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

findmnt --kernel /var/log/audit >> output.txt
if grep -E -q "/var/log/audit" output.txt;
then
        echo -e "|1.1.6.1  | Ensure separate partition exists for /var/log/audit                                                            |${GREEN} Pass${NC}             |"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.6.2  | Ensure noexec option set on /var/log/audit partition                                                           | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.6.3  | Ensure nodev option set on /var/log/audit partition                                                            | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.6.4  | Ensure nosuid option set on /var/log/audit partition                                                           | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.1.6.4 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files.
#Explanation: The nosuid option has not been set, or has been set incorrectly.


# Section 1.1.7

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.7    | Configure /home                                                                                                |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

findmnt --kernel /home >> output.txt
if grep -E -q "/home" output.txt;
then
        echo -e "|1.1.7.1  | Ensure separate partition exists for /home                                                                     |${GREEN} Pass${NC}             |"
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.7.1  | Ensure separate partition exists for /home                                                                     | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.7.2  | Ensure nodev option set on /home partition                                                                     | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.7.3  | Ensure nosuid option set on /home partition\                                                                   | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.1.7.3 "
fi
sudo rm -f output.txt
((total++))

#Description: The nosuid mount option specifies that the filesystem cannot contain setuid files.
#Explanation: The nosuid opition has not been set, or has been set incorrectly on /home


# Section 1.1.8
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.1.8    | Configure /dev/shm                                                                                             |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

findmnt --kernel /dev/shm | grep nodev>> output.txt
if grep -E -q "/dev/shm.*nodev" output.txt;
then
        echo -e "|1.1.8.1  | Ensure nodev option set on /dev/shm partition                                                                  |${GREEN} Pass${NC}             |"
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.8.1  | Ensure nodev option set on /dev/shm partition                                                                  | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.8.2  | Ensure noexec option set on /dev/shm partition                                                                 | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.8.3  | Ensure nosuid option set on /dev/shm partition                                                                 | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.1.9    | Disable Automounting (Automated)                                                                               | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.1.9 "
fi
sudo rm -f output.txt
((total++))

#Description: autofs allows automatic mounting of devices, typically including CD/DVDs and USB drives.
#Explanation: As a preference autofs should not be installed unless other packages depend on it


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
grep "^set superusers" /boot/grub/grub.cfg >> output.txt
grep "^password" /boot/grub/grub.cfg >>output.txt
if grep -E -q "superusers=.*password_pbkdf2" output.txt;
then
                echo -e "|1.4.1    | Ensure bootloader password is set                                                                             |${GREEN} Pass${NC}              |"
                
                ((pass_count++))
        elif grep -q "password_pbkdf2" output.txt;
        then
                echo -e "|${RED}1.4.1    | Ensure bootloader password is set                                                                              | Fail             ${NC}|"
                
                ((fail_count++))
                failed_sections+="1.4.1 "
                #Explanation: Superusers is not set.
        elif grep -q "superusers=" output.txt;
        then
                echo -e "|${RED}1.4.1    | Ensure bootloader password is set                                                                              | Fail             ${NC}|"
                
                ((fail_count++))
                failed_sections+="1.4.1 "
                #Explanation: Encrypted password is not set
        else
                echo -e "|${RED}1.4.1    | Ensure bootloader password is set                                                                              | Fail             ${NC}|"
                
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.4.2    | Ensure permissions on bootloader config are configured                                                         | Fail             ${NC}|"
        
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
        
        ((fail_count++))
        failed_sections+="1.4.3 "
else
        echo -e "|1.4.3    | Ensure authentication required for single user mode                                                            |${GREEN} Pass${NC}             |"
        
        ((pass_count++))
fi
sudo rm -f output.txt
#Description: Single user mode is used for recovery when the system detects an issue during boot or by manual selection from the bootloader
#Explanation: root user password is not set
((total++))


#Section 1.5
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.5      | Additional Process Hardening                                                                                   |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
sysctl kernel.randomize_va_space >> output.txt
if grep -x -q "kernel.randomize_va_space = 2" output.txt;
then
        echo -e "|1.5.1    | Ensure address space layout randomization (ASLR) is enabled                                                    |${GREEN} Pass${NC}             |"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.5.2    | Ensure prelink is not installed (Automated)                                                                    | Fail             ${NC}|"
        
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

sudo rm -f output.txt
((total++))
#Description:Setting a hard limit on core dumps prevents users from overriding the soft variable


#Section 1.6
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.6      | Mandatory Access Control                                                                                       |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' apparmor >> output.txt
if grep -q -E "apparmor install ok installed    installed" output.txt;
then
        echo -e "|1.6.1.1  | Ensure AppArmor is installed (Automated)                                                                       |${GREEN} Pass${NC}             |"
        
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
sudo rm -f output.txt
((total++))

#Section 1.7
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.7      | Command Line Warning Banners                                                                                   |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


outputtxt=output.txt
grep -Eis "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd >> output.txt
if [ $(wc -l < "${outputtxt}") -eq 0 ]; then
    echo -e "|1.7.1    | Ensure message of the day is configured properly (Automated)                                                   |${GREEN} Pass${NC}             |"
    
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.7.2    | Ensure local login warning banner is configured properly (Automated)                                           | Fail             ${NC}|"
        
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
sudo rm -f output.txt
#Description: The contents of the /etc/issue.net file are displayed to users prior to login for remote connections from configured services. Warning messages inform users who are attempting to login to the system of their legal status regarding the system and must include the name of the organization that owns the system and any monitoring policies that are in place. Displaying OS and patch level information in login banners also has the side effect of providing detailed system information to attackers attempting to target specific exploits of a system.
((total++))




stat -L /etc/motd &> output.txt
if grep -q -E "stat: cannot statx '/etc/motd': No such file or directory|Access: (0644/-rw-r--r--) Uid: (0/     root)   Gid: (  0/      root)" output.txt;
then
        echo -e "|1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                                     |${GREEN} Pass${NC}             |"
        
        ((pass_count++))
else
        echo -e "|${RED}1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                                     | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.7.4 "
        #Explanation: Uid and/or Gid are not set to 0/root, and/or Access is not set to 644
fi
sudo rm -f output.txt
#Description:The contents of the /etc/motd file are displayed to users after login and function as a message of the day for authenticated users. If the /etc/motd file does not have the correct ownership it could be modified by unauthorized users with incorrect or misleading information.
((total++))

stat -L /etc/motd &> output.txt
if grep -q -E "stat: cannot statx '/etc/motd': No such file or directory|Access: (0644/-rw-r--r--) Uid: (0/     root)   Gid: (  0/      root)" output.txt;
then
        echo -e "|1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                                     |${GREEN} Pass${NC}             |"
        
        ((pass_count++))
else
        echo -e "|${RED}1.7.4    | Ensure permissions on /etc/motd are configured (Automated)                                                     | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.7.5    | Ensure permissions on /etc/issue are configured (Automated)                                                    | Fail             ${NC}|"
        
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
        
        ((pass_count++))
else
        echo -e "|${RED}1.7.6    | Ensure permissions on /etc/issue.net are configured (Automated)                                                | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.7.6 "
        #Explanation: Permissions have not been set, or have been set incorrectly for /etc/issue.net.
fi
sudo rm -f output.txt
#Description: The contents of the /etc/issue.net file are displayed to users prior to login for local terminals. If the /etc/issue.net file does not have the correct ownership it could be modified by unauthorized users with incorrect or misleading information.
((total++))



#Section 1.8
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|1.8      | GNOME Display Manager                                                                                          |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"



dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' gdm3 >> output.txt
if grep -q "gdm3        install ok not-installed        not-installed" output.txt
then
        echo -e "|1.8.1    | Ensure GNOME Display Manager is removed (Automated)                                                            |${GREEN} Pass             ${NC}|"
        
        ((pass_count++))
else
        echo -e "|${RED}1.8.1    | Ensure GNOME Display Manager is removed (Automated)                                                            | Fail             ${NC}|"
        
        ((fail_count++))
        failed_sections+="1.8.1 "
        #Explanation: The GNOME GUI is installed on the system.
fi
sudo rm -f output.txt
#Decription: If a Graphical User Interface (GUI) is not required, it should be removed to REDuce the attack surface of the system.
((total++))

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

grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm3/custom.conf >> output.txt
outputxdcmp=output.txt
if [ $(wc -l < "${outputxdcmp}") -eq 0 ]; then
    echo -e "|1.8.10   | Ensure XDCMP is not enabled (Automated)                                                                        |${GREEN} Pass${NC}             |"
    
    ((pass_count++))
else
    echo -e "|${RED}1.8.10   | Ensure XDCMP is not enabled (Automated)                                                                        | Fail             ${NC}|"
    
    ((fail_count++))
    failed_sections+="1.8.10 "
fi
sudo rm -f output.txt
((total++))


apt -s upgrade &> output.txt
outputupgrade=output.txt
if [ $(wc -l < "${outputupgrade}") -eq 0 ]; then
    echo -e "|1.9      | Ensure updates, patches, and additional security software are installed (Manual)                               |${GREEN} Pass${NC}             |"
    
    ((pass_count++))
else
    echo -e "|${RED}1.9      | Ensure updates, patches, and additional security software are installed (Manual)                               | Fail             ${NC}|"
    
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






#Section 3 -Javier
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                                 3 Network Configuration                                                     |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

# Section 3.1

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.1       | Disable unused network protocols and devices                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

{
        #3.1.1
# Function to check if IPv6 is enabled
function check_ipv6_enabled() {
        # Check if IPv6 is enabled through the GRUB2 config
        if grep -q "^\s*GRUB_CMDLINE_LINUX.*ipv6.disable=1" /etc/default/grub; then
                echo -e "|${red}3.1.1     | Ensure system is checked to determine if IPv6 is enabled (Manual)                                             | FAIL       ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.1.1 "
        else
                # Check if IPv6 is disabled through sysctl setting
                if sysctl -a | grep -q "net.ipv6.conf.all.disable_ipv6 = 1" || \
                sysctl -a | grep -q "net.ipv6.conf.default.disable_ipv6 = 1" || \
                sysctl -a | grep -q "net.ipv6.route.flush = 1"; then
                        echo -e "|${red}3.1.1     | Ensure system is checked to determine if IPv6 is enabled (Manual)                                             | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.1.1 "
                else
                        echo -e "|3.1.1     | Ensure system is checked to determine if IPv6 is enabled (Manual)                                             | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                fi
        fi
}
# Execute the check function
check_ipv6_enabled
}
((total++))

{
        #3.1.2
# Function to check if wireless interfaces are disabled
function check_wireless_interfaces_disabled() {
        # Check for active wireless interfaces using nmcli
        if nmcli radio all | grep -Eq '\s*\S+\s+enabled\s+\S+\s+enabled\b'; then
                echo -e "|${red}3.1.2     | Ensure wireless interfaces are disabled (Automated)                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.1.2 "
        else
                # Check for wireless interfaces in /sys/class/net/ directory
                if find /sys/class/net/*/ -type d -name wireless 2>/dev/null | grep -q .; then
                        echo -e "|${red}3.1.2 | Ensure wireless interfaces are disabled (Automated)                                                           | FAIL            ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.1.2 "
                else
                        echo -e "|3.1.2     | Ensure wireless interfaces are disabled (Automated)                                                           | ${green}PASS${normal}            |"
                        pass_count=$((pass_count + 1))
                fi
        fi
}
# Execute the check function
check_wireless_interfaces_disabled
}
((total++))

# Section 3.2

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.2       | Network Parameters (Host Only)                                                                                |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #3.2.1
# Function to check if packet redirect sending is disabled
function check_packet_redirect() {
        # Get the value of the `send_redirects` parameter in sysctl
        send_redirects=$(sysctl -n net.ipv4.conf.all.send_redirects)
        send_redirects_default=$(sysctl -n net.ipv4.conf.default.send_redirects)

        # Check if the value is set to 0, which means packet redirect sending is disabled
        if [[ "$send_redirects" && "$send_redirects_default" -eq 0 ]]; then
                echo -e "| 3.2.1     | Ensure packet redirect sending is disabled (Automated)                                                       | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 3.2.1     | Ensure packet redirect sending is disabled (Automated)                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.2.1 "
        fi
}
# Execute the check function
check_packet_redirect
}
((total++))

{
        #3.2.2
# Function to check if IP forwarding is disabled
function check_ip_forwarding() {
        # Get the values of net.ipv4.ip_forward and net.ipv6.conf.all.forwarding from sysctl
        ipv4_forward=$(sysctl -n net.ipv4.ip_forward)
        ipv6_forward=$(sysctl -n net.ipv6.conf.all.forwarding)

        # Check if both values are set to 0, indicating that IP forwarding is disabled
        if [ "$ipv4_forward" -eq 0 ] && [ "$ipv6_forward" -eq 0 ]; then
                echo -e "| 3.2.2     | Ensure IP forwarding is disabled (Automated)                                                             	   | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 3.2.2     | Ensure IP forwarding is disabled (Automated)                                                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.2.2 "
        fi
}
# Execute the check function
check_ip_forwarding
}
((total++))


# Section 3.3

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.3       | Network Parameters (Host and Router)                                                                          |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"

{
        #3.3.1
# Function to check if source routed packets are not accepted
function check_source_route() {
        # Get the values of the relevant sysctl settings
        ipv4_all_accept_source_route=$(sysctl -n net.ipv4.conf.all.accept_source_route)
        ipv4_default_accept_source_route=$(sysctl -n net.ipv4.conf.default.accept_source_route)
        ipv6_all_accept_source_route=$(sysctl -n net.ipv6.conf.all.accept_source_route)
        ipv6_default_accept_source_route=$(sysctl -n net.ipv6.conf.default.accept_source_route)

        # Check if all the settings are set to 0, indicating that source routed packets are not accepted
        if [ "$ipv4_all_accept_source_route" -eq 0 ] && \
        [ "$ipv4_default_accept_source_route" -eq 0 ] && \
        [ "$ipv6_all_accept_source_route" -eq 0 ] && \
        [ "$ipv6_default_accept_source_route" -eq 0 ]; then
        echo -e "|3.3.1     | Ensure source routed packets are not accepted (Automated)                                                     | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
    else
        echo -e "|${red}3.3.1     | Ensure source routed packets are not accepted (Automated)                                                     |  FAIL             ${normal}|"
        fail_count=$((fail_count + 1))
        failed_sections+="3.3.1 "
    fi
}
# Execute the check function
check_source_route
}
((total++))

{
        #3.3.2
# Function to check if ICMP redirects are not accepted
function check_icmp_redirects() {
        # Get the values of the relevant sysctl settings
        ipv4_all_accept_redirects=$(sysctl -n net.ipv4.conf.all.accept_redirects)
        ipv4_default_accept_redirects=$(sysctl -n net.ipv4.conf.default.accept_redirects)
        ipv6_all_accept_redirects=$(sysctl -n net.ipv6.conf.all.accept_redirects)
        ipv6_default_accept_redirects=$(sysctl -n net.ipv6.conf.default.accept_redirects)

        # Check if all the settings are set to 0, indicating that ICMP redirects are not accepted
        if [ "$ipv4_all_accept_redirects" -eq 0 ] && \
        [ "$ipv4_default_accept_redirects" -eq 0 ] && \
            [ "$ipv6_all_accept_redirects" -eq 0 ] && \
        [ "$ipv6_default_accept_redirects" -eq 0 ]; then
                echo -e "|3.3.2     | Ensure ICMP redirects are not accepted (Automated)                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.2     | Ensure ICMP redirects are not accepted (Automated)                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.2 "
        fi
}
# Execute the check function
check_icmp_redirects
}
((total++))

{
        #3.3.3
# Function to check if secure ICMP redirects are not accepted
function check_secure_icmp_redirects() {
    # Get the values of the relevant sysctl settings
    ipv4_default_secure_redirects=$(sysctl -n net.ipv4.conf.default.secure_redirects)
    ipv4_all_secure_redirects=$(sysctl -n net.ipv4.conf.all.secure_redirects)

    # Check if both settings are set to 0, indicating that secure ICMP redirects are not accepted
    if [ "$ipv4_default_secure_redirects" -eq 0 ] && [ "$ipv4_all_secure_redirects" -eq 0 ]; then
        echo -e "|3.3.3     | Ensure secure ICMP redirects are not accepted (Automated)                                                     | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
    else
        echo -e "|${red}3.3.3     | Ensure secure ICMP redirects are not accepted (Automated)                                                     | FAIL             ${normal}|"
        fail_count=$((fail_count + 1))
        failed_sections+="3.3.3 "
    fi
}
# Execute the check function
check_secure_icmp_redirects
}
((total++))


{
        #3.3.4
# Function to check if suspicious packets are logged
function check_suspicious_packets_logged() {
        # Check if net.ipv4.conf.all.log_martians is set to 1
        if [[ $(sysctl -n net.ipv4.conf.all.log_martians) -eq 1 ]]; then
                # Check if net.ipv4.conf.default.log_martians is set to 1
                if [[ $(sysctl -n net.ipv4.conf.default.log_martians) -eq 1 ]]; then
                        echo -e "|3.3.4     | Ensure suspicious packets are logged (Automated)                                                              | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
			echo -e "|${red}3.3.4     | Ensure suspicious packets are logged (Automated)                                                              | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.3.4 "
                fi
        else
                echo -e "|${red}3.3.4     | Ensure suspicious packets are logged (Automated)                                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.4 "
        fi
}
# Execute the check function
check_suspicious_packets_logged
}
((total++))

{
        #3.3.5
# Function to check if broadcast ICMP requests are ignored
function check_ignore_broadcast_icmp() {
        # Check if net.ipv4.icmp_echo_ignore_broadcasts is set to 1
        if [[ $(sysctl -n net.ipv4.icmp_echo_ignore_broadcasts) -eq 1 ]]; then
                echo -e "|3.3.5     | Ensure broadcast ICMP requests are ignored (Automated)                                                        | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 3.3.5     | Ensure broadcast ICMP requests are ignored (Automated)                                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.5 "
        fi
}
# Execute the check function
check_ignore_broadcast_icmp
}
((total++))

{
        #3.3.6
# Function to check if bogus ICMP responses are ignored
function check_ignore_bogus_icmp() {
        # Check if net.ipv4.icmp_ignore_bogus_error_responses is set to 1
        if [[ $(sysctl -n net.ipv4.icmp_ignore_bogus_error_responses) -eq 1 ]]; then
                echo -e "|3.3.6     | Ensure bogus ICMP responses are ignored (Automated)                                                           |${green} PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.6     | Ensure bogus ICMP responses are ignored (Automated)                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.6 "
        fi
}
# Execute the check function
check_ignore_bogus_icmp
}
((total++))

{
        #3.3.7
# Function to check if Reverse Path Filtering is enabled
function check_reverse_path_filter() {
        # Check if net.ipv4.conf.all.rp_filter and net.ipv4.conf.default.rp_filter are set to 1
        if [[ $(sysctl -n net.ipv4.conf.all.rp_filter) -eq 1 ]] && [[ $(sysctl -n net.ipv4.conf.default.rp_filter) -eq 1 ]]; then
                echo -e "|3.3.7     | Ensure Reverse Path Filtering is enabled (Automated)                                                          | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.7     | Ensure Reverse Path Filtering is enabled (Automated)                                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.7 "
        fi
}
# Execute the check function
check_reverse_path_filter
}
((total++))

{
        #3.3.8
# Function to check if TCP SYN Cookies are enabled
function check_tcp_syn_cookies() {
        # Check if net.ipv4.tcp_syncookies is set to 1
        if [[ $(sysctl -n net.ipv4.tcp_syncookies) -eq 1 ]]; then
                echo -e "|3.3.8     | Ensure TCP SYN Cookies is enabled (Automated)                                                                 | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.8     | Ensure TCP SYN Cookies is enabled (Automated)                                                                 | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.8 "
        fi
}
((total++))
# Execute the check function
check_tcp_syn_cookies
}

{
        #3.3.9
# Function to check if IPv6 router advertisements are not accepted
function check_ipv6_router_advertisements() {
        # Check if net.ipv6.conf.all.accept_ra is set to 0 and net.ipv6.conf.default.accept_ra is set to 0
        if [[ $(sysctl -n net.ipv6.conf.all.accept_ra) -eq 0 && $(sysctl -n net.ipv6.conf.default.accept_ra) -eq 0 ]]; then
                echo -e "|3.3.9     | Ensure IPv6 router advertisements are not accepted (Automated)                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.3.9     | Ensure IPv6 router advertisements are not accepted (Automated)                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.3.9 "
        fi
}
# Execute the check function
check_ipv6_router_advertisements
}
((total++))


# Section 3.4

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.4       | Uncommon Network Protocols                                                                                    |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #3.4.1
# Function to check if DCCP is disabled
function check_dccp_disabled() {
        # Check if DCCP kernel module is loaded
        if lsmod | grep -q '^dccp\s'; then
                echo -e "|${red}3.4.1     | Ensure DCCP is disabled (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.1 "
        else
                echo -e "|3.4.1     | Ensure DCCP is disabled (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_dccp_disabled
}
((total++))

{
        #3.4.2
# Function to check if SCTP is disabled
function check_sctp_disabled() {
        # Check if SCTP kernel module is loaded
           if lsmod | grep -q '^sctp\s'; then
		   echo -e "|${red}3.4.2     | Ensure SCTP is disabled (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.2 "
        else
                echo -e "|3.4.2     | Ensure SCTP is disabled (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_sctp_disabled
}
((total++))

{
        #3.4.3
# Function to check if RDS is disabled
function check_rds_disabled() {
        # Check if RDS kernel module is loaded
        if lsmod | grep -q '^rds\s'; then
                echo -e "|${red}3.4.3     | Ensure RDS is disabled (Automated)                                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.3 "
        else
                echo -e "|3.4.3     | Ensure RDS is disabled (Automated)                                                                            | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_rds_disabled
}
((total++))

{
        #3.4.4
# Function to check if TIPC is disabled
function check_tipc_disabled() {
        # Check if TIPC kernel module is loaded
        if lsmod | grep -q '^tipc\s'; then
                echo -e "|${red}3.4.4     | Ensure TIPC is disabled (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.4.4 "
        else
                echo -e "|3.4.4     | Ensure TIPC is disabled (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_tipc_disabled
}
((total++))



# Section 3.5

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5       | Firewall Configuration                                                                                        |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"



    {
        #3.5.1.1
# Function to check if ufw is installed
function check_ufw_installed() {
        # Check if ufw package is installed
        if dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' ufw | grep -q '^ufw\s*install\s*ok\s*installed'; then
                echo -e "|3.5.1.1   | Ensure ufw is installed (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.1.1   | Ensure ufw is installed (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.1 "
        fi
}
# Execute the check function
check_ufw_installed
}
((total++))

{
        #3.5.1.2
# Function to check if iptables-persistent is installed
function check_iptables_persistent() {
        # Check if iptables-persistent package is not installed
        if ! dpkg-query -s iptables-persistent &>/dev/null; then
		echo -e "|3.5.1.2   | Ensure iptables-persistent is not installed with ufw (Automated)                                              | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.1.2   | Ensure iptables-persistent is not installed with ufw (Automated)                                              | FAIL       ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.2 "
        fi
}
# Execute the check function
check_iptables_persistent
}
((total++))

{
        #3.5.1.3

# Function to check if ufw service is enabled and active
function check_ufw_status() {
        # Check if ufw service is enabled
        if systemctl is-enabled ufw.service | grep -q 'enabled'; then
                # Check if ufw service is active
                if systemctl is-active ufw | grep -q 'active'; then
                        # Check if ufw is active
                        if ufw status | grep -q 'Status: active'; then
                                echo -e "|3.5.1.3   | Ensure ufw service is enabled (Automated)                                                                     | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
                                echo -e "|${red}3.5.1.3   | Ensure ufw service is enabled (Automated)                                                                     | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="3.5.1.3 "
                        fi
                else
                        echo -e "|${red}3.5.1.3   | Ensure ufw service is enabled (Automated)                                                                     | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.1.3 "
                fi
        else
                echo -e "|${red}3.5.1.3   | Ensure ufw service is enabled (Automated)                                                                     | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.3 "
        fi
}
# Execute the check function
check_ufw_status
}
((total++))

{
        #3.5.1.4
# Function to check ufw loopback traffic configuration
function check_ufw_loopback_traffic() {
        ufw_status=$(ufw status verbose)

        # Check if the required loopback rules are present in the ufw status output
        if echo "$ufw_status" | grep -q "Anywhere on lo\s*ALLOW IN\s*Anywhere" &&
        echo "$ufw_status" | grep -q "Anywhere DENY IN 127.0.0.0/8" &&
        echo "$ufw_status" | grep -q "Anywhere \(v6\) on lo\s*ALLOW IN\s*Anywhere \(v6\)" &&
        echo "$ufw_status" | grep -q "Anywhere \(v6\) DENY IN ::1" &&
        echo "$ufw_status" | grep -q "Anywhere ALLOW OUT Anywhere on lo" &&
        echo "$ufw_status" | grep -q "Anywhere \(v6\) ALLOW OUT Anywhere \(v6\) on lo"; then
                echo -e "|3.5.1.4   | Ensure ufw loopback traffic is configured (Automated)                                                         | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
		echo -e "|${red}3.5.1.4   | Ensure ufw loopback traffic is configured (Automated)                                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.4 "
        fi
}
# Execute the check function
check_ufw_loopback_traffic
}
((total++))

{
        #3.5.1.5
# Function to check if ufw outbound connections are configured
function check_ufw_outbound_connections() {
        ufw_status=$(ufw status numbered)

        if echo "$ufw_status" | grep -q "Status: active"; then
                if echo "$ufw_status" | grep -q "allow out on all"; then
                        echo -e "|3.5.1.5   | Ensure ufw outbound connections are configured (Manual)                                                       | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red}3.5.1.5   | Ensure ufw outbound connections are configured (Manual)                                                       | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.1.5 "
                fi
        else
                echo -e "|${red}3.5.1.5   | Ensure ufw outbound connections are configured (Manual)                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.5 "
        fi
}
# Execute the check function
check_ufw_outbound_connections
}
((total++))

{
        #3.5.1.6
function check_ufw_open_ports() {
        ufw_out="$(ufw status verbose)"
        open_ports=$(ss -tuln | awk '($5!~/%lo:/ && $5!~/127.0.0.1:/ && $5!~/::1/) {split($5, a, ":"); print a[2]}')
        missing_rules=0

        while read -r lpn; do
                if ! grep -Pq "^\h*$lpn\b" <<< "$ufw_out"; then
                        missing_rules=$((missing_rules + 1))
                fi
        done <<< "$open_ports"

        if [ $missing_rules -eq 0 ]; then
                echo -e "|3.5.1.6   | Ensure ufw firewall rules exist for all open ports (Automated)                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.1.6   | Ensure ufw firewall rules exist for all open ports (Automated)                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.6 "
        fi
}
# Execute the check function
check_ufw_open_ports
}
((total++))


{
        #3.5.1.7
# Function to check ufw default deny firewall policy
function check_ufw_default_deny_policy() {
        ufw_status=$(ufw status verbose | grep Default:)

        if echo "$ufw_status" | grep -q "Default: deny (incoming)"; then
                if echo "$ufw_status" | grep -q "Default: reject (outgoing)"; then
                        if echo "$ufw_status" | grep -q "Default: disabled (routed)"; then
                                echo -e "|3.5.1.7   | Ensure ufw default deny firewall policy (Automated)                                                           | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
                                echo -e "|${red}3.5.1.7   | Ensure ufw default deny firewall policy (Automated)                                                           | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="3.5.1.7 "
                        fi
                else
                        echo -e "|${red}3.5.1.7   | Ensure ufw default deny firewall policy (Automated)                                                           | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.1.7 "
                fi
        else
                echo -e "|${red}3.5.1.7   | Ensure ufw default deny firewall policy (Automated)                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.1.7 "
        fi
}
# Execute the check function
check_ufw_default_deny_policy
}
((total++))





# Section 3.5.2

    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.2     | Configure nftables                                                                                            |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #3.5.2.1
# Function to check if nftables is installed
function check_nftables_installed() {
        if dpkg-query -s nftables 2>/dev/null | grep -q 'Status: install ok installed'; then
                echo -e "|3.5.2.1   | Ensure nftables is installed (Automated)                                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.1   | Ensure nftables is installed (Automated)                                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.1 "
        fi
}
# Execute the check function
check_nftables_installed
}
((total++))

{
        #3.5.2.2
# Function to check if ufw is uninstalled or disabled with nftables
function check_ufw_disabled_with_nftables() {
        # Check if ufw is installed
        if dpkg-query -s ufw 2>/dev/null | grep -q 'Status: install ok installed'; then
                # Check if ufw is disabled
                ufw_status=$(ufw status 2>/dev/null)
                if grep -q 'Status: inactive' <<< "$ufw_status"; then
                        echo -e "|3.5.2.2   | Ensure ufw is uninstalled or disabled with nftables (Automated)                                               | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red}3.5.2.2   | Ensure ufw is uninstalled or disabled with nftables (Automated)                                               | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.2 "
                fi
        else
                echo -e "|3.5.2.2   | Ensure ufw is uninstalled or disabled with nftables (Automated)                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_ufw_disabled_with_nftables
}
((total++))

{
        #3.5.2.3
# Function to check if iptables are flushed with nftables
function check_iptables_flushed_with_nftables() {
        # Check iptables rules
        iptables_rules=$(iptables -L)
        if [[ -z "$iptables_rules" ]]; then
                # Check ip6tables rules
                ip6tables_rules=$(ip6tables -L)
                if [[ -z "$ip6tables_rules" ]]; then
                        echo -e "|3.5.2.3   | Ensure iptables are flushed with nftables (Manual)                                                            | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red}3.5.2.3   | Ensure iptables are flushed with nftables (Manual)                                                            | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.3 "
                fi
        else
                echo -e "|${red}3.5.2.3   | Ensure iptables are flushed with nftables (Manual)                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.3 "
        fi
}
# Execute the check function
check_iptables_flushed_with_nftables
}
((total++))

{
        #3.5.2.4
# Function to check if a nftables table exists
function check_nftables_table_exists() {
        # Define the name of the table to check
        table_name="my_table"  # Replace "my_table" with the actual table name

        # Check if the table exists using nft list tables command
        nft_list_tables=$(nft list tables)

        if grep -q "table $table_name" <<< "$nft_list_tables"; then
                echo -e "|3.5.2.4   | Ensure a nftables table exists (Automated)                                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.4   | Ensure a nftables table exists (Automated)                                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.4 "
        fi
}
# Execute the check function
check_nftables_table_exists
}
((total++))


{
        #3.5.2.5
# Function to check if base chains exist in nftables
function check_nftables_base_chains() {
        # Check if base chains exist for INPUT, FORWARD, and OUTPUT
        if nft list ruleset | grep -q 'hook input'; then
                if nft list ruleset | grep -q 'hook forward'; then
                        if nft list ruleset | grep -q 'hook output'; then
                                echo -e "|3.5.2.5   | Ensure nftables base chains exist (Automated)                                                                 | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
                                echo -e "|${red}3.5.2.5   | Ensure nftables base chains exist (Automated)                                                                 | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="3.5.2.5 "
                        fi
                else
                        echo -e "|${red}3.5.2.5   | Ensure nftables base chains exist (Automated)                                                                 | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.5 "
                fi
        else
                echo -e "|${red}3.5.2.5   | Ensure nftables base chains exist (Automated)                                                                 | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.5 "
        fi
}
# Execute the check function
check_nftables_base_chains
}
((total++))

{
        #3.5.2.6
# Function to check if nftables loopback traffic is configured
function check_nftables_loopback_config() {
        # Check for loopback interface configuration
        if nft list ruleset | awk '/hook input/,/}/' | grep -q 'iif "lo" accept' &&
        nft list ruleset | awk '/hook input/,/}/' | grep -q 'ip saddr 127.0.0.0/8 counter packets 0 bytes 0 drop'; then
                echo -e "|3.5.2.6   | Ensure nftables loopback traffic is configured (Automated)                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.6   | Ensure nftables loopback traffic is configured (Automated)                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.6 "
    fi
}
# Execute the check function
check_nftables_loopback_config
}
((total++))

{
        #3.5.2.7
# Function to check if nftables outbound and established connections are configured
function check_nftables_outbound_config() {
        # Check for outbound established connections
        local outbound_established_rules=(
                "ip protocol tcp ct state established accept"
                "ip protocol udp ct state established accept"
                "ip protocol icmp ct state established accept"
        )

        # Check for outbound established, related, new connections
        local outbound_established_related_new_rules=(
                "ip protocol tcp ct state established,related,new accept"
                "ip protocol udp ct state established,related,new accept"
                "ip protocol icmp ct state established,related,new accept"
        )

        # Check outbound rules
        local outbound_rules=$(nft list ruleset | awk '/hook output/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state')

        for rule in "${outbound_established_rules[@]}"; do
                if ! grep -q "$rule" <<< "$outbound_rules"; then
                        echo -e "|${red}3.5.2.7   | Ensure nftables outbound and established connections are configured (Manual)                                  | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.7 "
                return 1
                fi
        done

        # Check outbound related new rules
        local outbound_related_new_rules=$(nft list ruleset | awk '/hook output/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state')

        for rule in "${outbound_established_related_new_rules[@]}"; do
                if ! grep -q "$rule" <<< "$outbound_related_new_rules"; then
                        echo -e "|${red}3.5.2.7   | Ensure nftables outbound and established connections are configured (Manual)                                  | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.7 "
                        return 1
                fi
        done

        echo -e "|3.5.2.7   | Ensure nftables outbound and established connections are configured (Manual)                                  | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
        return 0
}
# Execute the check function
check_nftables_outbound_config
}
((total++))

{
        #3.5.2.8
# Function to check if nftables has a default deny firewall policy
function check_nftables_default_deny() {
        # Check base chains for policy DROP
        local base_chains=("input" "forward" "output")

        for chain in "${base_chains[@]}"; do
                local policy=$(nft list ruleset | grep "hook $chain" | grep "policy drop")
                if [ -z "$policy" ]; then
                        echo -e "|${red}3.5.2.8   | Ensure nftables default deny firewall policy (Automated)                                                      | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.2.8 "
                        return 1
                fi
        done

        echo -e "|3.5.2.8   | Ensure nftables default deny firewall policy (Automated)                                                      | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
        return 0
}
# Execute the check function
check_nftables_default_deny
}
((total++))

{
        #3.5.2.9
# Function to check if nftables service is enabled
function check_nftables_service_enabled() {
        if systemctl is-enabled nftables | grep -q "enabled"; then
                echo -e "|3.5.2.9   | Ensure nftables service is enabled (Automated)                                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.9   | Ensure nftables service is enabled (Automated)                                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.9 "
        fi
}
# Execute the check function
check_nftables_service_enabled
}
((total++))

{
        #3.5.2.10
# Function to check if nftables rules are permanent
function check_nftables_rules_permanent() {
        if [ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook input/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$" &&
            [ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook forward/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$" &&
        [ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook output/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$"; then
                echo -e "|3.5.2.10  | Ensure nftables rules are permanent (Automated)                                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.2.10  | Ensure nftables rules are permanent (Automated)                                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.2.10 "
        fi
}
# Execute the check function
check_nftables_rules_permanent
}
((total++))



# Section 3.5.3
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.3     | Configure iptables                                                                                            |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.3.1   | Configure iptables software                                                                                   |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #3.5.3.1.1
# Function to check if iptables and iptables-persistent packages are installed
function check_iptables_installed() {
        if apt list iptables iptables-persistent 2>/dev/null | grep -q "installed"; then
                echo -e "|3.5.3.1.1 | Ensure iptables packages are installed (Automated)                                                            | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.1.1 | Ensure iptables packages are installed (Automated)                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.1.1"
        fi
}
# Execute the check function
check_iptables_installed
}
((total++))

{
        #3.5.3.1.2
# Function to check if nftables is not installed with iptables
function check_nftables_not_installed() {
        if ! dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' nftables 2>/dev/null | grep -q "installed"; then
                echo -e "|3.5.3.1.2 | Ensure nftables is not installed with iptables (Automated)                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.1.2 | Ensure nftables is not installed with iptables (Automated)                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.1.2 "
        fi
}
# Execute the check function
check_nftables_not_installed
}
((total++))


{
        #3.5.3.1.3
# Function to check if ufw is uninstalled or disabled with iptables
function check_ufw_not_installed_disabled() {
        # Check if ufw is not installed
        if ! dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' ufw 2>/dev/null | grep -q "installed"; then
                # Check if ufw status shows it as disabled
                if ufw status | grep -q "Status: inactive"; then
                        # Check if ufw service is masked
                        if systemctl is-enabled ufw | grep -q "masked"; then
                                echo -e "|3.5.3.1.3 | Ensure ufw is uninstalled or disabled with iptables (Automated)                                               | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
				echo -e "|${red}3.5.3.1.3 | Ensure ufw is uninstalled or disabled with iptables (Automated)                                               | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="3.5.3.1.3 "
                        fi
                else
                        echo -e "|${red}3.5.3.1.3 | Ensure ufw is uninstalled or disabled with iptables (Automated)                                               | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.3.1.3 "
                fi
        else
                echo -e "|${red}3.5.3.1.3 | Ensure ufw is uninstalled or disabled with iptables (Automated)                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.1.3 "
        fi
}
# Execute the check function
check_ufw_not_installed_disabled
}
((total++))


echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.3.2   | Configure IPv4 iptables                                                                                       |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


{
        #3.5.3.2.1
# Function to check iptables default deny firewall policy
function check_iptables_default_policy() {
        # Check the default policy for INPUT chain
        iptables -L INPUT | grep -E -q "Policy: (DROP|REJECT)"
        input_policy_status=$?

        # Check the default policy for OUTPUT chain
        iptables -L OUTPUT | grep -E -q "Policy: (DROP|REJECT)"
        output_policy_status=$?

        # Check the default policy for FORWARD chain
        iptables -L FORWARD | grep -E -q "Policy: (DROP|REJECT)"
        forward_policy_status=$?

        if [[ $input_policy_status -eq 0 && $output_policy_status -eq 0 && $forward_policy_status -eq 0 ]]; then
                echo -e "|3.5.3.2.1 | Ensure iptables default deny firewall policy (Automated)                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.2.1 | Ensure iptables default deny firewall policy (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.2.1 "
        fi
}
# Execute the check function
check_iptables_default_policy
}
((total++))

{
        #3.5.3.2.2
# Function to check iptables loopback traffic configuration
function check_iptables_loopback_traffic() {
        # Check if the loopback traffic is configured in INPUT chain
        iptables -L INPUT -v -n | grep -E -q "ACCEPT\s+all\s+--\s+lo\s+\*\s+0.0.0.0/0\s+0.0.0.0/0"

        # Check if the loopback traffic is configured in OUTPUT chain
        iptables -L OUTPUT -v -n | grep -E -q "ACCEPT\s+all\s+--\s+\*\s+lo\s+0.0.0.0/0\s+0.0.0.0/0"

        # Check if the rule to drop loopback traffic from other addresses is configured in INPUT chain
        iptables -L INPUT -v -n | grep -E -q "DROP\s+all\s+--\s+\*\s+\*\s+127.0.0.0/8\s+0.0.0.0/0"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.2.2 | Ensure iptables loopback traffic is configured (Automated)                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.2.2 | Ensure iptables loopback traffic is configured (Automated)                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.2.2 "
        fi
}
# Execute the check function
check_iptables_loopback_traffic
}
((total++))

{
        #3.5.3.2.3
# Function to check iptables outbound and established connections configuration
function check_iptables_outbound_connections() {
        # Check if outbound TCP, UDP, and ICMP connections are configured
        iptables -L -v -n | grep -E -q "(tcp|udp|icmp)\s+all\s+--\s+\*\s+\*\s+0.0.0.0/0\s+0.0.0.0/0\s+state\s+(NEW,ESTABLISHED|ESTABLISHED)"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.2.3 | Ensure iptables outbound and established connections are configured (Manual)                                  | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.2.3 | Ensure iptables outbound and established connections are configured (Manual)                                  | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.2.3 "
        fi
}
# Execute the check function
check_iptables_outbound_connections
}
((total++))

{
        #3.5.3.2.4
# Function to check iptables firewall rules for all open ports
function check_iptables_open_ports() {
        # Get a list of open ports using ss
        open_ports=$(ss -4tuln | awk 'NR>1 {print $5}' | awk -F':' '{print $NF}')

        # Check if iptables has rules for all open ports
        for port in $open_ports; do
                iptables -L INPUT -v -n | grep -q ":$port\s"
                if [[ $? -ne 0 ]]; then
                        echo -e "|${red}3.5.3.2.4 | Ensure iptables firewall rules exist for all open ports (Automated)                                           | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.3.2.4 "
                        return
                fi
        done

        echo -e "|3.5.3.2.4 | Ensure iptables firewall rules exist for all open ports (Automated)                                           | ${green}PASS${normal}       |"
        pass_count=$((pass_count + 1))
}
# Execute the check function
check_iptables_open_ports
}
((total++))


echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|3.5.3.3   | Configure IPv6 ip6tables                                                                                      |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"



{
        #3.5.3.3.1
# Function to check ip6tables default deny firewall policy
function check_ip6tables_default_policy() {
        # Check if ip6tables has default deny policy for INPUT, OUTPUT, and FORWARD chains
        ip6tables -L INPUT | grep -q "Chain INPUT (policy DROP)"
        ip6tables -L OUTPUT | grep -q "Chain OUTPUT (policy DROP)"
        ip6tables -L FORWARD | grep -q "Chain FORWARD (policy DROP)"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.3.1 | Ensure ip6tables default deny firewall policy (Automated)                                                     | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.3.1 | Ensure ip6tables default deny firewall policy (Automated)                                                     | FAIL             ${normal}|"  
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.3.1 "
        fi
}
# Execute the check function
check_ip6tables_default_policy
}
((total++))

{
        #3.5.3.3.2
# Function to check ip6tables loopback traffic configuration
function check_ip6tables_loopback() {
        # Check if ip6tables has rules for loopback traffic in INPUT and OUTPUT chains
        ip6tables -L INPUT -v -n | grep -q "ACCEPT.*lo"
        ip6tables -L OUTPUT -v -n | grep -q "ACCEPT.*lo"
        ip6tables -L INPUT -v -n | grep -q "DROP.*::1"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.3.2 | Ensure ip6tables loopback traffic is configured (Automated)                                                   | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.3.2 | Ensure ip6tables loopback traffic is configured (Automated)                                                   | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.3.2 "
        fi
}
# Execute the check function
check_ip6tables_loopback
}
((total++))

{
        #3.5.3.3.3
# Function to check ip6tables outbound and established connections configuration
function check_ip6tables_outbound() {
        # Check if ip6tables has rules for outbound and established connections
        ip6tables -L -v -n | grep -q "ACCEPT.*tcp.*state NEW,ESTABLISHED"
        ip6tables -L -v -n | grep -q "ACCEPT.*udp.*state NEW,ESTABLISHED"
        ip6tables -L -v -n | grep -q "ACCEPT.*icmp.*state NEW,ESTABLISHED"
        ip6tables -L -v -n | grep -q "ACCEPT.*tcp.*state ESTABLISHED"
          ip6tables -L -v -n | grep -q "ACCEPT.*udp.*state ESTABLISHED"
        ip6tables -L -v -n | grep -q "ACCEPT.*icmp.*state ESTABLISHED"

        if [[ $? -eq 0 ]]; then
                echo -e "|3.5.3.3.3 | Ensure ip6tables outbound and established connections are configured (Manual)                                 | ${green}PASS${normal}              |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red}3.5.3.3.3 | Ensure ip6tables outbound and established connections are configured (Manual)                                 | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="3.5.3.3.3 "
        fi
}
# Execute the check function
check_ip6tables_outbound
}
((total++))

{
        #3.5.3.3.4
# Function to check if ip6tables firewall rules exist for all open ports
function check_ip6tables_open_ports() {
        # Get open ports from ss command
        open_ports=$(ss -6tuln | awk 'NR>1 {print $5}' | cut -d':' -f2 | sort -u)

        # Check if ip6tables has rules for each open port
        for port in $open_ports; do
              ip6tables -L INPUT -v -n | grep -q -E "ACCEPT.*tcp.*dpt:$port.*state NEW"
                if [[ $? -ne 0 ]]; then
                        echo -e "|${red}3.5.3.3.4 | Ensure ip6tables firewall rules exist for all open ports (Automated)                                          | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="3.5.3.3.4 "
                        return
                fi
        done

        echo -e "|3.5.3.3.4 | Ensure ip6tables firewall rules exist for all open ports (Automated)                                         | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
}
# Execute the check function
check_ip6tables_open_ports
}
((total++))





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


# Section 5
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
echo "|                                                           5 Access, Authentication and Authorization                                        |"
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
{
        #5.1.1
# Function to check if cron daemon is enabled and running
if systemctl is-enabled cron | grep -q "enabled"; then
                # Check if cron daemon is running
        if systemctl status cron | grep -q "Active: active (running)"; then
                echo -e "| 5.1.1   | Ensure cron daemon is enabled and running (Automated)                                                          | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.1     | Ensure cron daemon is enabled and running (Automated)                                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.1 "
        fi
else
        echo -e "|${red} 5.1.1     | Ensure cron daemon is enabled and running (Automated)                                                          | FAIL             ${normal}|"
        fail_count=$((fail_count + 1))
        failed_sections+="5.1.1 "
fi
}
((total++))

{
        #5.1.2
# Function to check permissions on /etc/crontab directory
function check_crontab_permissions() {
        local expected_permissions="600"
        local crontab_file="/etc/crontab"

    # Check permissions on /etc/crontab
        actual_permissions=$(stat -c "%a" "$crontab_file")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.2   | Ensure permissions on /etc/crontab are configured (Automated)                                                  | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.2   | Ensure permissions on /etc/crontab are configured (Automated)                                                  | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.2 "
        fi
}
# Execute the check function
check_crontab_permissions
}
((total++))


{
        #5.1.3
# Function to check permissions on /etc/cron.hourly directory
function check_cron_hourly_permissions() {
        local expected_permissions="700"
        local cron_hourly_dir="/etc/cron.hourly"

        # Check permissions on /etc/cron.hourly
        actual_permissions=$(stat -c "%a" "$cron_hourly_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.3   | Ensure permissions on /etc/cron.hourly are configured (Automated)                                              | ${green}PASS${normal}       |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.3   | Ensure permissions on /etc/cron.hourly are configured (Automated)                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.3 "
        fi
}
# Execute the check function
check_cron_hourly_permissions
}
((total++))

{
        #5.1.4
# Function to check permissions on /etc/cron.daily directory
function check_cron_daily_permissions() {
        local expected_permissions="700"
        local cron_daily_dir="/etc/cron.daily"

        # Check permissions on /etc/cron.daily directory
        actual_permissions=$(stat -c "%a" "$cron_daily_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.4   | Ensure permissions on /etc/cron.daily are configured (Automated)                                               | ${green}PASS${normal}                    |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.4   | Ensure permissions on /etc/cron.daily are configured (Automated)                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.4 "
        fi
}
# Execute the check function
check_cron_daily_permissions
}
((total++))

{
        #5.1.5
# Function to check permissions on /etc/cron.weekly directory
function check_cron_weekly_permissions() {
        local expected_permissions="700"
        local cron_weekly_dir="/etc/cron.weekly"

        # Check permissions on /etc/cron.weekly directory
        actual_permissions=$(stat -c "%a" "$cron_weekly_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.5     | Ensure permissions on /etc/cron.weekly are configured (Automated)                                              | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.5   | Ensure permissions on /etc/cron.weekly are configured (Automated)                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.5 "
        fi
}
# Execute the check function
check_cron_weekly_permissions
}
((total++))


{
        #5.1.6
# Function to check permissions on /etc/cron.monthly directory
function check_cron_monthly_permissions() {
        local expected_permissions="700"
        local cron_monthly_dir="/etc/cron.monthly"

        # Check permissions on /etc/cron.monthly directory
        actual_permissions=$(stat -c "%a" "$cron_monthly_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.6   | Ensure permissions on /etc/cron.monthly are configured (Automated)                                             | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.6   | Ensure permissions on /etc/cron.monthly are configured (Automated)                                             | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.6 "
        fi
}
# Execute the check function
check_cron_monthly_permissions
}
((total++))

{
        #5.1.7
# Function to check permissions on /etc/cron.d directory
function check_cron_d_permissions() {
        local expected_permissions="700"
        local cron_d_dir="/etc/cron.d"

        # Check permissions on /etc/cron.d directory
        actual_permissions=$(stat -c "%a" "$cron_d_dir")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.1.7   | Ensure permissions on /etc/cron.d are configured (Automated)                                                   | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.1.7   | Ensure permissions on /etc/cron.d are configured (Automated)                                                   | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.7 "
        fi
}

# Execute the check function
check_cron_d_permissions
}
((total++))


{
        #5.1.8
# Function to check if cron is restricted to authorized users
function check_cron_access() {
        local cron_allow="/etc/cron.allow"
        local cron_deny="/etc/cron.deny"

        if [ -f "$cron_allow" ]; then
                echo -e "| 5.1.8   | Ensure cron is restricted to authorized users (Automated)                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        elif [ -f "$cron_deny" ]; then
                echo -e "|${red} 5.1.8   | Ensure cron is restricted to authorized users (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.8 "
        else
                echo -e "|${red} 5.1.8   | Ensure cron is restricted to authorized users (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.8 "
        fi
}

# Execute the check function
check_cron_access
}
((total++))

{
        #5.1.9
# Function to check if 'at' command is restricted to authorized users
function check_at_access() {
        local at_allow="/etc/at.allow"
        local at_deny="/etc/at.deny"

        if [ -f "$at_allow" ]; then
                echo -e "| 5.1.9   | Ensure 'at' is restricted to authorized users (Automated)                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        elif [ -f "$at_deny" ]; then
                echo -e "|${red} 5.1.9   | Ensure 'at' is restricted to authorized users (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.9 "
        else
                echo -e "|${red} 5.1.9   | Ensure 'at' is restricted to authorized users (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.1.9 "
        fi
}

# Execute the check function
check_at_access
}
((total++))


#section 5.2
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.2      | Configure SSH Server                                                                                           |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #5.2.1
# Function to check permissions on /etc/ssh/sshd_config
function check_sshd_config_permissions() {
        local expected_permissions="600"
        local sshd_config="/etc/ssh/sshd_config"

        # Check permissions on /etc/ssh/sshd_config
        actual_permissions=$(stat -c "%a" "$sshd_config")

        if [ "$actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.2.1   | Ensure permissions on /etc/ssh/sshd_config are configured (Automated)                                          | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.1   | Ensure permissions on /etc/ssh/sshd_config are configured (Automated)                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.1 "
        fi
}

# Execute the check function
check_sshd_config_permissions
}
((total++))

{
        #5.2.2
# Function to check permissions on SSH private host key files
function check_ssh_key_permissions() {
        local expected_permissions="600"
        local rsa_key_file="/etc/ssh/ssh_host_rsa_key"
        local ecdsa_key_file="/etc/ssh/ssh_host_ecdsa_key"

        # Check permissions on ssh_host_rsa_key file
        rsa_actual_permissions=$(stat -c "%a" "$rsa_key_file")

        # Check permissions on ssh_host_ecdsa_key file
        ecdsa_actual_permissions=$(stat -c "%a" "$ecdsa_key_file")

        if [ "$rsa_actual_permissions" == "$expected_permissions" ] && [ "$ecdsa_actual_permissions" == "$expected_permissions" ]; then
                echo -e "| 5.2.2   | Ensure permissions on SSH private host key files are configured (Automated)                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.2   | Ensure permissions on SSH private host key files are configured (Automated)                                    | FAIL                ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.2 "
        fi
}
# Execute the check function
check_ssh_key_permissions
}
((total++))


{
        #5.2.3
# Function to check permissions on SSH public host key files
function check_ssh_public_key_permissions() {
        local expected_permissions="644"

        # Find SSH public key files in /etc/ssh
        public_key_files=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub')

        # Loop through the public key files and check their permissions
        for file in $public_key_files; do
                actual_permissions=$(stat -c "%a" "$file")

                if [ "$actual_permissions" != "$expected_permissions" ]; then
                        echo -e "|${red} 5.2.3     | Ensure permissions on SSH public host key files are configured (Automated)                                     | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.2.3 "
                return
                fi
        done

        echo -e "| 5.2.3   | Ensure permissions on SSH public host key files are configured (Automated)                                     | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
}

# Execute the check function
check_ssh_public_key_permissions
}
((total++))

{
        #5.2.4
# Function to check if SSH access is limited
function check_ssh_access_limit() {
        local sshd_config="/etc/ssh/sshd_config"
        local allow_users_configured=0
        local allow_groups_configured=0

        # Check if the SSHd configuration contains AllowUsers or AllowGroups directives
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -Pi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$'; then
                allow_users_configured=1
        fi

        if grep -rPi -q '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$' "$sshd_config"; then
                allow_groups_configured=1
        fi

        if [ "$allow_users_configured" -eq 1 ] || [ "$allow_groups_configured" -eq 1 ]; then
                echo -e "| 5.2.4   | Ensure SSH access is limited (Automated)                                                                       | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.4   | Ensure SSH access is limited (Automated)                                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.4 "
        fi
}
# Execute the check function
check_ssh_access_limit
}
((total++))


{
        #5.2.5
        output=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep loglevel)

        if [[ "$output" == "loglevel INFO" ]]; then
                echo -e "| 5.2.5   | Ensure SSH LogLevel is appropriate (Automated)                                                                 | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        elif [[ "$output" == "loglevel VERBOSE" ]]; then
echo -e "| 5.2.5   | Ensure SSH LogLevel is appropriate (Automated)                                                                                 | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
echo -e "|${red} 5.2.5   | Ensure SSH LogLevel is appropriate (Automated)                                                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))\
                failed_sections+="5.2.5 "
        fi
}

((total++))

{
        #5.2.6
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "usepam\s*yes"; then
                echo -e "| 5.2.6   | Ensure SSH PAM is appropriate (Automated)                                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.6   | Ensure SSH PAM is appropriate (Automated)                                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.6 "
        fi
}
((total++))

{
        #5.2.7
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "permitrootlogin\s*no"; then
                echo -e "| 5.2.7     | Ensure SSH root login is disabled (Automated)                                                                  | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.7   | Ensure SSH root login is disabled (Automated)                                                                  | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.7 "
        fi
}
((total++))

{
        #5.2.8
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "hostbasedauthentication\s*no"; then
		echo -e "| 5.2.8   | Ensure SSH HostbasedAuthentication is disabled (Automated)                                                     | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.8   | Ensure SSH HostbasedAuthentication is disabled (Automated)                                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.8 "
        fi
}
((total++))

{
        #5.2.9
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "permitemptypasswords\s*no"; then
                echo -e "| 5.2.9   | Ensure SSH PermitEmptyPasswords is disabled (Automated)                                                        | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.9   | Ensure SSH PermitEmptyPasswords is disabled (Automated)                                                        | FAIL            ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.9 "

        fi
}
((total++))


{
        #5.2.10
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "permituserenvironment\s*no"; then
                echo -e "| 5.2.10  | Ensure SSH PermitUserEnvironment is disabled (Automated)                                                       | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.10  | Ensure SSH PermitUserEnvironment is disabled (Automated)                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.10 "
        fi
}
((total++))

{
        #5.2.11
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "ignorerhosts\s*no"; then
                echo -e "| 5.2.11  | Ensure SSH IgnoreRhosts is disabled (Automated)                                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.11  | Ensure SSH IgnoreRhosts is disabled (Automated)                                                                | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.11 "
        fi
}
((total++))

{
        #5.2.12
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "x11forwarding\s*no"; then
                echo -e "| 5.2.12  | Ensure SSH X11 forwarding is disabled (Automated)                                                             | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.12  | Ensure SSH X11 forwarding is disabled (Automated)                                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.12 "
        fi
}
((total++))

{
        #5.2.13
function check_strong_ciphers() {
        local sshd_config="/etc/ssh/sshd_config"
        local benchmark_ciphers="chacha20-poly1305@openssh.com|aes256-gcm@openssh.com|aes128-gcm@openssh.com|aes256-ctr|aes192-ctr|aes128-ctr"

        # Check if the SSHd configuration uses only strong ciphers
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -E "ciphers\s+$benchmark_ciphers"; then
                echo -e "| 5.2.13  | Ensure only strong Ciphers are used (Automated)                                                                | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.13  | Ensure only strong Ciphers are used (Automated)                                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.13 "
        fi
        }
check_strong_ciphers
}
((total++))


{
        #5.2.14
function check_macs_algo() {
        local sshd_config="/etc/ssh/sshd_config"
        local benchmark_macs="hmac-sha2-512-etm@openssh.com|hmac-sha2-256-etm@openssh.com|hmac-sha2-512|hmac-sha2-256"

        # Check if the SSHd configuration uses only strong MACs Algo
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -E "MACs\s+$benchmark_macs"; then
                echo -e "| 5.2.14  | Ensure only strong MAC algorithms are used (Automated)                                                         | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.14  | Ensure only strong MAC algorithms are used (Automated)                                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.14 "
        fi
        }
check_macs_algo
}
((total++))

{
        #5.2.15
function check_keyx_algo() {
        local sshd_config="/etc/ssh/sshd_config"
        local benchmark_keyx="curve25519-sha256|curve25519-sha256@libssh.org|diffie-hellman-group14-sha256|diffie-hellman-group16-sha512|diffie-hellman-group18-sha512|ecdh-sha2-nistp521|ecdh-sha2-nistp384|ecdh-sha2-nistp256|diffie-hellman-group-exchangg
e-sha256"

        # Check if the SSHd configuration uses only strong Key Exchange Algo
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q -E "kexalgorithms\s+$benchmark_keyx"; then
                echo -e "| 5.2.15  | Ensure only strong Key Exchange are used (Automated)                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.15  | Ensure only strong Key Exchange are used (Automated)                                                           | FAIL       ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.15 "
        fi
        }
check_keyx_algo
}
((total++))


{
        #5.2.16
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "allowtcpforwarding\s*no"; then
                echo -e "| 5.2.16  | Ensure SSH AllowTcpForwarding is disabled (Automated)                                                          | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.16  | Ensure SSH AllowTcpForwarding is disabled (Automated)                                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.16 "
        fi
}
((total++))

{
        #5.2.17
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "banner\s*/etc/issue.net"; then
                echo -e "| 5.2.17  | Ensure SSH warning banner is configured (Automated)                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.17  | Ensure SSH warning banner is configured (Automated)                                                            | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.17 "
        fi
}
((total++))

{
        #5.2.18
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "maxauthtries\s*4"; then
                echo -e "| 5.2.18  | Ensure SSH MaxAuthTries is set to 4 or less (Automated)                                                         | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.18  | Ensure SSH MaxAuthTries is set to 4 or less (Automated)                                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.18 "
        fi
}
((total++))

{
        #5.2.19
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "maxstartups\s*10:30:60"; then
                echo -e "| 5.2.19  | Ensure SSH MaxStartups is configured (Automated)                                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.19  | Ensure SSH MaxStartups is configured (Automated)                                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.19 "
        fi
}
((total++))

{
        #5.2.20
        if sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "maxsessions\s*10"; then
                echo -e "| 5.2.20  | Ensure SSH MaxSessions is set to 10 or less (Automated)                                                        | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.20  | Ensure SSH MaxSessions is set to 10 or less (Automated)                                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.20 "
        fi
}
((total++))


{
        #5.2.21
# Function to check SSH LoginGraceTime setting
function check_ssh_login_grace_time() {
        local expected_min_login_grace_time=1
        local expected_max_login_grace_time=60
        local sshd_config="/etc/ssh/sshd_config"

        # Get the current LoginGraceTime setting from sshd_config
        login_grace_time=$(sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -Ei "logingracetime\s*[0-9]+[m]?" | awk '{print $2}' | tr -d 'm')

        # Check if the LoginGraceTime is numeric and within the allowed range
        if [[ "$login_grace_time" =~ ^[0-9]+$ ]] && ((login_grace_time >= expected_min_login_grace_time)) && ((login_grace_time <= expected_max_login_grace_time)); then
                echo -e "| 5.2.21  | Ensure SSH LoginGraceTime is set to one minute or less (Automated)                                            | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.21  | Ensure SSH LoginGraceTime is set to one minute or less (Automated)                                             | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.21 "
        fi
}
# Execute the check function
check_ssh_login_grace_time
}
((total++))

{
        #5.2.22
        if sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -q "clientaliveinterval\s*15" && sshd -T -C "user=root" -C "host=$(hostname)" -C "addr=$(grep $(hostname) /etc/hosts | awk '{prinn
t $1}')" | grep -q "clientalivecountmax\s*3"; then
                echo -e "| 5.2.22  | Ensure SSH Idle Timeout Interval is configured (Automated)                                                    | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.2.22  | Ensure Idle Timeout Interval is configured (Automated)                                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.2.22 "
        fi
}
((total++))




#section 5.3
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.3      | Configure privilege escalation                                                                                 |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


    {
        #5.3.1
# Function to check if sudo is installed
function check_sudo_installed() {
        # Check if sudo package is installed
        if dpkg-query -W sudo sudo-ldap > /dev/null 2>&1; then
                # Package is installed
                echo -e "| 5.3.1   | Ensure sudo is installed (Automated)                                                                           | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # Package is not installed
                echo -e "|${red} 5.3.1   | Ensure sudo is installed (Automated)                                                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.1 "
        fi
}
# Execute the check function
check_sudo_installed
}
((total++))

{
        #5.3.2
# Function to check if sudo commands use pty
function check_sudo_use_pty() {
        # Check if use_pty option is set in the sudoers configuration
        if grep -rPi -q '^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*; then
                # use_pty option is set
                echo -e "| 5.3.2   | Ensure sudo commands use pty (Automated)                                                                       | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # use_pty option is not set
                echo -e "|${red} 5.3.2   | Ensure sudo commands use pty (Automated)                                                                       | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.2 "
        fi
}
# Execute the check function
check_sudo_use_pty
}
((total++))


{
        #5.3.3
# Function to check if sudo log file exists and is configured
function check_sudo_logfile() {
        # Check if sudo log file is configured in sudoers
        if grep -rPsi -q "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|')?\H+(\"|')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers*; then
                # sudo log file is configured
                echo -e "| 5.3.3   | Ensure sudo log file exists and is configured (Automated)                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # sudo log file is not configured
                echo -e "|${red} 5.3.3   | Ensure sudo log file exists and is configured (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.3 "
        fi
}

# Execute the check function
check_sudo_logfile
}
((total++))

{
        #5.3.4
# Function to check if users must provide password for privilege escalation
function check_users_password_required() {
        # Check if any users have been granted NOPASSWD privilege escalation
        if grep -r "^[^#].*NOPASSWD" /etc/sudoers*; then
                # Users have NOPASSWD privilege escalation
                echo -e "|${red} 5.3.4   | Ensure users must provide password for privilege escalation (Automated)                                        | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.4 "
        else
                # Users must provide password for privilege escalation
                echo -e "| 5.3.4   | Ensure users must provide password for privilege escalation (Automated)                                        | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_users_password_required
}
((total++))

{
        #5.3.5
# Function to check if re-authentication for privilege escalation is not disabled globally
function check_reauth_enabled() {
        # Check if re-authentication is disabled globally in sudoers configuration
        if grep -r "^[^#].*\!authenticate" /etc/sudoers*; then
                # Re-authentication is disabled globally
                echo -e "|${red} 5.3.5   | Ensure re-authentication for privilege escalation is not disabled                                              | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.5 "
        else
                # Re-authentication is not disabled globally
                echo -e "| 5.3.5   | Ensure re-authentication for privilege escalation is not disabled                                              | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        fi
}
# Execute the check function
check_reauth_enabled
}
((total++))


{
        #5.3.6 (buggy)
function check_sudo_auth_timeout() {
        # Get the configured authentication timeout from sudoers file
        local sudo_timeout=$(grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers* | sort -n | head -1)

        # Check if sudo_timeout is empty (when timestamp_timeout is not found)
        if [[ -z "$sudo_timeout" ]]; then
                # Timeout is not found in sudoers
                echo -e "|${red} 5.3.6   | Ensure sudo authentication timeout is configured correctly (Automated)                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.6 "
        else
                # Check if the timeout is no more than 15 minutes (900 seconds)
                if [[ $sudo_timeout =~ ^[0-9]+$ && $sudo_timeout -le 900 ]]; then
                        # Timeout is configured correctly
                        echo -e "| 5.3.6    | Ensure sudo authentication timeout is configured correctly (Automated)                                         | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        # Timeout is not configured correctly
                        echo -e "|${red} 5.3.6   | Ensure sudo authentication timeout is configured correctly (Automated)                                         | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.3.6 "
                fi
        fi
}
# Execute the check function
check_sudo_auth_timeout
}
((total++))

{
        #5.3.7
# Function to check if access to su command is restricted
function check_su_restrictions() {
        # Check if the pam_wheel.so configuration restricts access to su
        if grep -Pi -q '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su; then
                # Access to su command is restricted
                echo -e "| 5.3.7   | Ensure access to the su command is restricted (Automated)                                                      | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # Access to su command is not restricted
                echo -e "|${red} 5.3.7   | Ensure access to the su command is restricted (Automated)                                                      | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.3.7 "
        fi
}

# Execute the check function
check_su_restrictions
}
((total++))




#section 5.4
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.4      | Configure PAM                                                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"




    {
        #5.4.1
# Function to check if password creation requirements are configured
function check_password_requirements() {
        # Check minlen in pwquality.conf
        local minlen=$(grep '^\s*minlen\s*' /etc/security/pwquality.conf | awk '{print $3}')
        # Check minclass in pwquality.conf
        local minclass=$(grep '^\s*minclass\s*' /etc/security/pwquality.conf | awk '{print $3}')

        # Check if minlen is set to 14 and minclass is set to 4
        if [[ "$minlen" -eq 14 && "$minclass" -eq 4 ]]; then
                # Password creation requirements are configured correctly
                echo -e "| 5.4.1   | Ensure password creation requirements are configured (Automated)                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # Password creation requirements are not configured correctly
                echo -e "|${red} 5.4.1   | Ensure password creation requirements are configured (Automated)                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.1 "
        fi
}
# Execute the check function
check_password_requirements
}
((total++))

{
        #5.4.2
# Function to check if lockout for failed password attempts is configured
function check_password_lockout() {
        # Check if pam_faillock.so is configured in common-auth
        if grep -q "pam_faillock.so" /etc/pam.d/common-auth &&
                grep -q "pam_faillock.so" /etc/pam.d/common-account; then
                # Check faillock configuration in faillock.conf
                local deny=$(awk '/^ *deny *=/{print $3}' /etc/security/faillock.conf)
                local fail_interval=$(awk '/^ *fail_interval *=/{print $3}' /etc/security/faillock.conf)
                local unlock_time=$(awk '/^ *unlock_time *=/{print $3}' /etc/security/faillock.conf)

                # Check if settings follow local site policy
                if [[ "$deny" -le 4 && "$fail_interval" -le 900 && "$unlock_time" -eq 0 || "$unlock_time" -ge 600 ]]; then
                        # Lockout for failed password attempts is configured correctly
                        echo -e "| 5.4.2   | Ensure lockout for failed password attempts is configured (Automated)                                          | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        # Lockout for failed password attempts is not configured correctly
                        echo -e "|${red} 5.4.2   | Ensure lockout for failed password attempts is configured (Automated)                                          | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.4.2 "
                fi
        else
                # pam_faillock.so is not configured in common-auth or common-account
                echo -e "|${red} 5.4.2   | Ensure lockout for failed password attempts is configured (Automated)                                          | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.2 "
        fi
}
# Execute the check function
check_password_lockout
}
((total++))


{
        #5.4.3
# Function to check if password reuse is limited
function check_password_reuse() {
        # Check if password reuse is limited in common-password
        if grep -Pq '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?remember=([5-9]|[1-9][0-9]+)\b' /etc/pam.d/common-password; then
                # Password reuse is limited, check the value of remember option
                local remember_value=$(grep -Po '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\h+([^#\n\r]+\h+)?remember=\K([5-9]|[1-9][0-9]+)' /etc/pam.d/common-password)

                # Check if the remember option is 5 or more
                if [[ "$remember_value" -ge 5 ]]; then
                        # Password reuse is limited correctly
                        echo -e "| 5.4.3   | Ensure password reuse is limited (Automated)                                                                   | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        # Password reuse is not limited correctly
                        echo -e "|${red} 5.4.3   | Ensure password reuse is limited (Automated)                                                                   | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.4.3 "
                fi
        else
                # Password reuse is not limited
                echo -e "|${red} 5.4.3   | Ensure password reuse is limited (Automated)                                                                   | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.3 "
        fi
}
# Execute the check function
check_password_reuse
}
((total++))


{
        #5.4.4
# Function to check if password hashing algorithm is up to date
function check_password_hashing_algorithm() {
        # Check if the password hashing algorithm is up to date in common-password
        local common_password_output=$(grep -v '^#' /etc/pam.d/common-password | grep -E "(yescrypt|md5|bigcrypt|sha256|sha512|blowfish)")

        # Check if there is no output for the first code
        if [[ -z "$common_password_output" ]]; then
                # Check if the ENCRYPT_METHOD is set to yescrypt in /etc/login.defs
                if grep -qi "^\s*ENCRYPT_METHOD\s*yescrypt\s*$" /etc/login.defs; then
                        # Password hashing algorithm is up to date
                        echo -e "| 5.4.4   | Ensure password hashing algorithm is up to date (Automated)                                                    | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        # ENCRYPT_METHOD is not set to yescrypt in /etc/login.defs
                        echo -e "|${red} 5.4.4   | Ensure password hashing algorithm is up to date (Automated)                                                    | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.4.4 "
                fi
        else
                # Output is present for the first code
                echo -e "|${red} 5.4.4   | Ensure password hashing algorithm is up to date (Automated)                                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.4 "
        fi
}

# Execute the check function
check_password_hashing_algorithm
}
((total++))


{
        #5.4.5
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

for MY_USER in $(sed -n "s/^\(.*\):\\$.*/\1/p" /etc/shadow); do
        CURRENT_HASH=$(sed -n "s/${MY_USER}:\\$\(.\).*/\1/p" /etc/shadow)
        if [[ "${HASH_MAP["${CURRENT_HASH}"]^^}" != "${CONFIGURED_HASH^^}" ]]; then
                echo -e "|${red} 5.4.5   | Ensure all current passwords uses the configured hashing algorithm (Manual)                                    | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.4.5 "
                has_mismatch=true
        fi
done

if ! $has_mismatch; then
        echo -e "| 5.4.5   | Ensure all current passwords uses the configured hashing algorithm (Manual)                                    | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
fi
}
((total++))





#section 5.5
echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.5      | User Accounts and Environment                                                                                  |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"
    echo "|5.5.1    | Set Shadow Password Suite Parameters                                                                           |                  |"
    echo "|---------------------------------------------------------------------------------------------------------------------------------------------|"


{
        #5.5.1.1
# Function to check and remediate minimum days between password changes
function check_min_days_password_change() {
        # Check /etc/login.defs for PASS_MIN_DAYS
        local min_days=$(grep -Ei "^\s*PASS_MIN_DAYS\s+" /etc/login.defs | awk '{print $2}')

        if [[ -z "$min_days" ]]; then
                # PASS_MIN_DAYS is not found in /etc/login.defs
                echo -e "|${red} 5.5.1.1 | Ensure minimum days between password changes is configured (Automated)                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.1 "
        elif [[ "$min_days" -ge 1 ]]; then
                # PASS_MIN_DAYS is configured correctly
                echo -e "| 5.5.1.1 | Ensure minimum days between password changes is configured (Automated)                                         | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # PASS_MIN_DAYS is not configured correctly
                echo -e "|${red} 5.5.1.1 | Ensure minimum days between password changes is configured (Automated)                                         | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.1 "
        fi
}
# Execute the check function
check_min_days_password_change
}
((total++))


{
        #5.5.1.2
# Function to check and remediate minimum days between password changes
function check_max_days_password_change() {
        # Check /etc/login.defs for PASS_MIN_DAYS
        local max_days=$(grep -Ei "^\s*PASS_MAX_DAYS\s+" /etc/login.defs | awk '{print $2}')

        if [[ -z "$max_days" ]]; then
                # PASS_MAX_DAYS is not found in /etc/login.defs
                echo -e "|${red} 5.5.1.2 | Ensure password expiration is 365 days or less (Automated)                                                     | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.2 "
        elif [[ "$max_days" -le 365 && "$max_days" -gt 0 ]]; then
                # PASS_MAX_DAYS is configured correctly
                echo -e "| 5.5.1.2 | Ensure password expiration is 365 days or less (Automated)                                                     | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # PASS_MAX_DAYS is not configured correctly
                echo -e "|${red} 5.5.1.2 | Ensure password expiration is 365 days or less (Automated)                                                     | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.2 "
        fi
}
# Execute the check function
check_max_days_password_change
}
((total++))

{
        #5.5.1.3
# Function to check and remediate password expiration warning days
function check_password_warn_age() {
        # Check /etc/login.defs for PASS_WARN_AGE
        local warn_age=$(grep -Ei "^\s*PASS_WARN_AGE\s+" /etc/login.defs | awk '{print $2}')

        if [[ -z "$warn_age" ]]; then
                # PASS_WARN_AGE is not found in /etc/login.defs
                echo -e "|${red} 5.5.1.3 | Ensure password expiration warning days is 7 or more (Automated)                                               | FAIL             |${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.3 "
        elif [[ "$warn_age" -ge 7 ]]; then
                # PASS_WARN_AGE is 7 or more
                echo -e "| 5.5.1.3 | Ensure password expiration warning days is 7 or more (Automated)                                               | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # PASS_WARN_AGE is less than 7
                echo -e "|${red} 5.5.1.3 | Ensure password expiration warning days is 7 or more (Automated)                                               | FAIL             |${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.3 "
        fi
}
# Execute the check function
check_password_warn_age
}
((total++))


{
        #5.5.1.4
# Function to check and remediate inactive password lock
function check_inactive_password_lock() {
        # Check useradd default for INACTIVE
        local inactive_default=$(useradd -D | grep INACTIVE | awk -F'=' '{print $2}')

        # Check /etc/shadow for users with INACTIVE set
        local users_with_inactive=$(awk -F: '($7~/^\s*$|-1/ || $7>30) && /^[^:]+:[^!*]/ {print $1 " " $7}' /etc/shadow)

        if [[ -z "$inactive_default" ]]; then
                # INACTIVE not found in useradd defaults
                echo -e "|${red} 5.5.1.4 | Ensure inactive password lock is 30 days or less (Automated)                                                   | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.4 "
        elif [[ "$inactive_default" -le 30 && -z "$users_with_inactive" ]]; then
                # INACTIVE is 30 days or less, and no users have INACTIVE set
                echo -e "| 5.5.1.4 | Ensure inactive password lock is 30 days or less (Automated)                                                   | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                # INACTIVE is more than 30 or users have INACTIVE set
                echo -e "|${red} 5.5.1.4 | Ensure inactive password lock is 30 days or less (Automated)                                                   | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.1.4 "
        fi
}
# Execute the check function
check_inactive_password_lock
}
((total++))


{
        #5.5.1.5
# Function to check if users' last password change date is in the past
function check_users_password_change_date() {
        # Get the current date in seconds since epoch
        local current_date=$(date +%s)

        # Get a list of all users
        local users_list=$(cut -d: -f1 /etc/passwd)

            # Loop through each user and check their password change date
        for user in $users_list; do
                # Get the password change date for the user in seconds since epoch
                local password_change_date=$(chage -l "$user" | grep "Last password change" | awk '{print $NF}')
                local password_change_date_in_seconds=$(date -d "$password_change_date" +%s)

                if [[ $password_change_date_in_seconds -ge $current_date ]]; then
                        # Password change date is in the future or today
                        echo -e "|${red} 5.5.1.5 | Ensure all users last password change date is in the past (Automated)                                          | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.5.1.5 "
                        return
                fi
        done

        # If we reach here, all users' password change dates are in the past
        echo -e "| 5.5.1.5 | Ensure all users last password change date is in the past (Automated)                                          | ${green}PASS${normal}             |"
        pass_count=$((pass_count + 1))
}
# Execute the check function
check_users_password_change_date
}
((total++))


{
        #5.5.2
# Function to check if system accounts are secured
function check_system_accounts_secured() {
        local uid_min=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)

        # Check if system accounts have a valid shell and UID
        local invalid_accounts=$(awk -F: '$1!~/(root|sync|shutdown|halt|^\+)/ && $3<'"$uid_min"' && $7!~/((\/usr)?\/sbin\/nologin)/ && $7!~/(\/bin)?\/false/ {print}' /etc/passwd)

        if [[ -z "$invalid_accounts" ]]; then
                # Check if system accounts are not locked
                local locked_accounts=$(awk -F: '($1!~/(root|^\+)/ && $3<'"$uid_min"') {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!~/LK?/) {print $1}')

                if [[ -z "$locked_accounts" ]]; then
                        echo -e "| 5.5.2   | Ensure system accounts are secured (Automated)                                                                 | ${green}PASS${normal}             |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red} 5.5.2   | Ensure system accounts are secured (Automated)                                                                 | FAIL             ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.5.2 "
                fi
        else
                echo -e "|${red} 5.5.2   | Ensure system accounts are secured (Automated)                                                                 | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.2 "
        fi
}
# Execute the check function
check_system_accounts_secured
}
((total++))


{
        #5.5.3
# Function to check if the default group for the root account is GID 0
function check_default_root_group() {
        local root_group=$(grep "^root:" /etc/passwd | cut -f4 -d:)

        if [[ "$root_group" -eq 0 ]]; then
                echo -e "| 5.5.3   | Ensure default group for the root account is GID 0 (Automated)                                                 | ${green}PASS${normal}             |"
                pass_count=$((pass_count + 1))
        else
                echo -e "|${red} 5.5.3   | Ensure default group for the root account is GID 0 (Automated)                                                 |  FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.3 "
        fi
}
# Execute the check function
check_default_root_group
}
((total++))


{
        #5.5.4
# Function to check default user umask and enforce directory and file permissions
function check_default_user_umask() {
        # Check if the default user umask is 027 or more restrictive
        if grep -Eiq '^\s*UMASK\s+(0[0-7][2-7]7|[0-7][2-7]7)\b' /etc/login.defs; then
                # Check if newly created directories have permissions 750
                if [ "$(umask)" == "0027" ]; then
                        mkdir -p /tmp/umask_test_dir
                        touch /tmp/umask_test_file
                        dir_perms="$(stat -c '%a' /tmp/umask_test_dir)"
                        file_perms="$(stat -c '%a' /tmp/umask_test_file)"

                        if [ "$dir_perms" == "750" ] && [ "$file_perms" == "640" ]; then
                                echo -e "| 5.5.4   | Ensure default user umask is 027 or more restrictive (Automated)                                               | ${green}PASS${normal}             |"
                                pass_count=$((pass_count + 1))
                        else
                                echo -e "|${red} 5.5.4   | Ensure default user umask is 027 or more restrictive (Automated)                                               | FAIL             ${normal}|"
                                fail_count=$((fail_count + 1))
                                failed_sections+="5.5.4 "
                        fi

                        rm -rf /tmp/umask_test_dir /tmp/umask_test_file
                else
                        echo -e "|${red} 5.5.4   | Ensure default user umask is 027 or more restrictive (Automated)                path_to_fails="./fails.sh"
    echo
    display_failed_sections "$path_to_fails"  | FAIL       ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.5.4 "
                fi
        else
                echo -e "|${red} 5.5.4   | Ensure default user umask is 027 or more restrictive (Automated)                                               | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.4 "
        fi
}
# Execute the check function
check_default_user_umask
}
((total++))


{
        #5.5.5
# Function to check default user shell timeout (TMOUT)
function check_default_shell_timeout() {
        # Check if TMOUT is configured in /etc/profile or /etc/bash.bashrc
        if grep -qE '^\s*export\s+TMOUT\s*=\s*[0-9]+\s*$' /etc/profile /etc/bash.bashrc; then
                # Get the value of TMOUT
                tmout_value=$(grep -E '^\s*export\s+TMOUT\s*=\s*[0-9]+\s*$' /etc/profile /etc/bash.bashrc | awk -F= '{print $2}')

                # Check if TMOUT is 900 seconds or less
                if [[ "$tmout_value" -le 900 ]]; then
                        echo -e "| 5.5.5   | Ensure default user shell timeout is 900 seconds or less (Automated)                                           | ${green}PASS${normal}            |"
                        pass_count=$((pass_count + 1))
                else
                        echo -e "|${red} 5.5.5   | Ensure default user shell timeout is 900 seconds or less (Automated)                                           | FAIL            ${normal}|"
                        fail_count=$((fail_count + 1))
                        failed_sections+="5.5.5 "
                fi
        else
		echo -e "|${red} 5.5.5   | Ensure default user shell timeout is 900 seconds or less (Automated)                                           | FAIL             ${normal}|"
                fail_count=$((fail_count + 1))
                failed_sections+="5.5.5 "
        fi
}
# Execute the check function
check_default_shell_timeout
}
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
#if [ "$fail_count" -eq 0 ]; then
#    exit 0  # Exit the script if all sections are compliant
#fi

#./fails2.sh "$1"
# Prompt user for more details on failures
#read -p "                                       Do you want to see more details on the failed sections? (y/n): " choice
#if [[ $choice == "y" ]]; then
#    path_to_fails="./fails.sh"
#    echo
#    display_failed_sections "$path_to_fails"
#else 
#    echo -e "\nYou have decided to not see more details on the failed sections."
#    echo -e "\nThank you for utilizing our audit tool to enhance your system's security and adherence to standards."
#    echo -e "\nClosing..."
#fi
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
