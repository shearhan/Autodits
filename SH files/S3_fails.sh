#!/bin/bash

# Colour of compliance
yellow='\033[0;33m'
red='\033[01;41m'
rednh='\033[01;31m'
green='\033[01;32m'
normal='\033[0m'
bold='\033[01;37m'

section=$1

	# 3.1.1
if [[ $section == "3.1.1" ]]; then
	benchmark_title="3.1.1 Ensure system is checked to determine if IPv6 is enabled (Manual)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}IPV6 ${normal}is the most recent version of ${bold}Internet Protocol (IP)${normal}. It's designed to supply IP addressing and additional security to support the predicted growth of connected devices. It is recommended that ${bold}IPV6 ${normal}be enabled and configured in accordance with Benchmark recommendations.\n\nWhen performing the audit, the output that should be shown is ${bold}IPV6 is enabled on the system${normal}."
	
	if grep -q "^\s*GRUB_CMDLINE_LINUX.*ipv6.disable=1" /etc/default/grub; then
		echo -e "\n${yellow}Output:${normal} "; grep "^\s*GRUB_CMDLINE_LINUX.*ipv6.disable=1" /etc/default/grub
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}/etc/default/grub ${normal}file does not meet\nthe required criteria by having ${bold}"ipv6.disable=1" ${normal}set in the ${bold}/etc/default/grub${normal} file, which is not recommended\nas it is recommended that ${bold}IPv6${normal} be enabled and configured in accordance with Benchmark recommendations.\n\nDisabling IPv6 on the system may cause some applications to fail or have unexpected behavior.\n\n${yellow}Remidation: ${normal}\n1. Access the grub file by using the command ${bold}vim /etc/default/grub ${normal}\n2. Scroll down until you see the ${bold}GRUB_CMDLINE_LINUX ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Remove the ${bold}"ipv6.disable=1" ${normal}portion in the parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Type in ${bold}update-grub${normal} to update the grub2 configuration.\n7. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		# Check if IPv6 is disabled through sysctl setting
		if sysctl -a | grep -q "net.ipv6.conf.all.disable_ipv6 = 1" || \
		sysctl -a | grep -q "net.ipv6.conf.default.disable_ipv6 = 1" || \
		sysctl -a | grep -q "net.ipv6.route.flush = 1"; then
			echo -e "\n${yellow}Output:${normal} ";
			sysctl -a | grep -E "net.ipv6.conf.(all|default).disable_ipv6 = 1|net.ipv6.route.flush = 1"
		
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the ${bold}systctl ${normal}settings does not meet\nthe required criteria by having ${bold}"net.ipv6.conf.all.disable_ipv6", "net.ipv6.conf.default.disable_ipv6"${normal} and ${bold}"net.ipv6.route.flush" ${normal}set 1 ${bold}1${normal} instead of ${bold}0${normal}, which is not recommended\nas it is recommended that ${bold}IPv6${normal} be enabled and configured in accordance with Benchmark recommendations.\n\nDisabling IPv6 on the system may cause some applications to fail or have unexpected behavior.\n\n${yellow}Remidation: ${normal}\n1. Type out this command in terminal:\nprintf "net.ipv6.conf.all.disable_ipv6 = 1net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.d/60-disable_ipv6.conf.\n2. Next, type this command in terminal:\n{\nsysctl -w net.ipv6.conf.all.disable_ipv6=0\nsysctl -w net.ipv6.conf.default.disable_ipv6=0\nsysctl -w net.ipv6.route.flush=0\n}\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		else
			echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
		fi
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 3.1.2
elif [[ $section == "3.1.2" ]]; then
	benchmark_title="3.1.2 Ensure wireless interfaces are disabled (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Wireless networking is used when wired networks are unavailable. Debian contains a wireless tool kit to allow system administrators to configure and use wireless networks.\n\nWhen performing the audit, the output that should be shown is ${bold}Wireless is not enabled${normal}."
	
	if nmcli radio all | grep -Eq '\s*\S+\s+enabled\s+\S+\s+enabled\b'; then
		echo -e "\n${yellow}Output:${normal} "; nmcli radio all
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL${normal}\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the wireless interfaces are enabled, which does not meet the required criteria.\n\nHowever, many if not all laptop workstations and some desktop workstations that connect via wireless requiring these interfaces be enabled.\n\nDisabling IPv6 on the system may cause some applications to fail or have unexpected behavior.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 287 as shown:"
	echo '
#!/bin/bash
if command -v nmcli >/dev/null 2>&1 ; then
	nmcli radio all off
else
	if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then
		mname=$(for driverdir in $(find /sys/class/net/*/ -type d -name wireless | xargs -0 dirname); do basename "$(readlink -f "$driverdir"/device/driver/module)";done | sort -u)
		for dm in $mname; do
			echo "install $dm /bin/true" >> /etc/modprobe.d/disable_wireless.conf
		done
	fi
fi'
	echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	else
		# Check for wireless interfaces in /sys/class/net/ directory
		if find /sys/class/net/*/ -type d -name wireless 2>/dev/null | grep -q .; then
			echo -e "\n${yellow}Output:${normal} "; find /sys/class/net/*/ -type d -name wireless 2>/dev/null | grep -E .
		
			echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the wireless interfaces are enabled, which does not meet the required criteria.\n\nHowever, many if not all laptop workstations and some desktop workstations that connect via wireless requiring these interfaces be enabled.\n\nDisabling IPv6 on the system may cause some applications to fail or have unexpected behavior.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 287 as shown:"
			echo '
#!/bin/bash
if command -v nmcli >/dev/null 2>&1 ; then
	nmcli radio all off
else
	if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then
		mname=$(for driverdir in $(find /sys/class/net/*/ -type d -name wireless | xargs -0 dirname); do basename "$(readlink -f "$driverdir"/device/driver/module)";done | sort -u)
		for dm in $mname; do
			echo "install $dm /bin/true" >> /etc/modprobe.d/disable_wireless.conf
		done
	fi
fi'
			echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
		else
			echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
		fi
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.2.1
elif [[ $section == "3.2.1" ]]; then
	benchmark_title="3.2.1 Ensure packet redirect sending is disabled (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	send_redirects=$(sysctl -n net.ipv4.conf.all.send_redirects)
	send_redirects_default=$(sysctl -n net.ipv4.conf.default.send_redirects)

	# Description
	echo -e "\n${yellow}Description: ${normal}ICMP Redirects are used to send routing information to other hosts. As a host itself does not act as a router (in a host only configuration), there is no need to send redirects.\n\nWhen performing the audit, the output that should be shown is ${bold}"net.ipv4.conf.all.send_redirects = 0"${normal} and ${bold}"net.ipv4.conf.default.send_redirects = 0"${normal}."
	
	if [[ "$send_redirects" && "$send_redirects_default" -eq 0 ]]; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.conf.all.send_redirects net.ipv4.conf.default.send_redirects
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL${normal}\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.conf.all.send_redirects"${normal} and ${bold}"net.ipv4.conf.default.send_redirects"${normal} are both set to 1, which does not meet the required criteria.\n\nAn attacker could use a compromised host to send invalid ICMP redirects to other router devices in an attempt to corrupt routing and have users access a system set up by the attacker as opposed to a valid system.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 291 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output="" l_output2=""
	l_parlist="net.ipv4.conf.all.send_redirects=0 net.ipv4.conf.default.send_redirects=0"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print '$2'}' /etc/default/ufw)"
	l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"
	
	KPF()
	{ 
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"
		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done
		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi
		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters" 
			sysctl -w "$l_kpname=$l_kpvalue" sysctl -w "$(awk -F'.' '{print '$1'"."'$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	} 
	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")" 
		KPF 
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.2.2
elif [[ $section == "3.2.2" ]]; then
	benchmark_title="3.2.2 Ensure IP forwarding is disabled (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	ipv4_forward=$(sysctl -n net.ipv4.ip_forward)
   	ipv6_forward=$(sysctl -n net.ipv6.conf.all.forwarding)

	# Description
	echo -e "\n${yellow}Description: ${normal}The net.ipv4.ip_forward and net.ipv6.conf.all.forwarding flags are used to tell the system whether it can forward packets or not.\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv4.ip_forward = 0"${normal} and\n${bold}"net.ipv6.conf.all.forwarding = 0"${normal}."

	# Check if both values are set to 0, indicating that IP forwarding is disabled
	if [[ "$ipv4_forward" -eq 0 ]] && [[ "$ipv6_forward" -eq 0 ]]; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.ip_forward net.ipv6.conf.all.forwarding
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.ip_forward"${normal} and ${bold}"net.ipv6.ip_forward"${normal} are both set to 1, which does not meet the required criteria.\n\nThis ensures that a system with multiple interfaces (for example, a hard proxy), will never be able to forward packets, and therefore, never serve as a router.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 296 and 297 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output=""
	l_output2=""
	l_parlist="net.ipv4.ip_forward=0 net.ipv6.conf.all.forwarding=0"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= ''/^\s*IPT_SYSCTL=/ {print ''$2''}' '/etc/default/ufw)''"

	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"

 		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done

		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi

		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1'"."'$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}

	IPV6F_CHK() {
		l_ipv6s=""
		grubfile=$(find /boot -type f \( -name ''grubenv'' -o -name ''grub.conf'' -o -name ''grub.cfg'' \) -exec grep -Pl -- ''^\h*(kernelopts=|linux|kernel)'' {} \;)

		if [ -s "$grubfile" ]; then
			! grep -P -- "^\h*(kernelopts=|linux|kernel)" "$grubfile" | grep -vq -- ipv6.disable=1 && l_ipv6s="disabled"
		fi

		if grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\h*(#.*)?$" $l_searchloc && \
			grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\h*(#.*)?$" $l_searchloc && \
			sysctl net.ipv6.conf.all.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\h*(#.*)?$" && \
			sysctl net.ipv6.conf.default.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\h*(#.*)?$"; then
			l_ipv6s="disabled"
		fi

		if [ -n "$l_ipv6s" ]; then
			echo -e "\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
		else
			KPF
		fi
	}

	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"

		if grep -q ''^net.ipv6.'' <<< "$l_kpe"; then
			l_kpfile="/etc/sysctl.d/60-netipv6_sysctl.conf"
			IPV6F_CHK
		else
			l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"
			KPF
		fi
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.3.1
elif [[ $section == "3.3.1" ]]; then
	benchmark_title="3.3.1 Ensure source routed packets are not accepted (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	ipv4_all_accept_source_route=$(sysctl -n net.ipv4.conf.all.accept_source_route)
  	ipv4_default_accept_source_route=$(sysctl -n net.ipv4.conf.default.accept_source_route)
  	ipv6_all_accept_source_route=$(sysctl -n net.ipv6.conf.all.accept_source_route)
	ipv6_default_accept_source_route=$(sysctl -n net.ipv6.conf.default.accept_source_route)

	# Description
	echo -e "\n${yellow}Description: ${normal}In networking, source routing allows a sender to partially or fully specify the route packets take through a network. In contrast, non-source routed packets travel a path determined by routers in the network. In some cases, systems may not be routable or reachable from some locations (e.g. private addresses vs. Internet routable), and so source routed packets would need to be used.\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv4.conf.all.accept_source_route = 0"${normal}, \n${bold}"net.ipv4.conf.default.accept_source_route = 0"${normal},\n${bold}"net.ipv6.conf.all.accept_source_route = 0"${normal} and\n${bold}"net.ipv6.conf.default.accept_source_route = 0"${normal}."
	
	if [[ "$ipv4_all_accept_source_route" -eq 0 ]] && \
	[[ "$ipv4_default_accept_source_route" -eq 0 ]] && \
	[[ "$ipv6_all_accept_source_route" -eq 0 ]] && \
	[[ "$ipv6_default_accept_source_route" -eq 0 ]]; then
        	echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
    	else
       		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.conf.all.accept_source_route net.ipv4.conf.default.accept_source_route net.ipv6.conf.all.accept_source_route net.ipv6.conf.default.accept_source_route
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.conf.all.accept_source_route"${normal}, ${bold}"net.ipv4.conf.default.accept_source_route"${normal}, ${bold}"net.ipv6.conf.all.accept_source_route"${normal} and${bold}"net.ipv6.conf.default.accept_source_route"${normal} are all set to 1, which does not meet the required criteria.\n\nUnder normal routing circumstances, an attacker from the Internet routable addresses could not use the system as a way to reach the private address systems. If, however, source routed packets were allowed, they could be used to gain access to the private address systems as the route could be specified, rather than rely on routing protocols that did not allow this routing.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 303 and 304 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output=""
	l_output2=""
	l_parlist="net.ipv4.conf.all.accept_source_route=0 net.ipv4.conf.default.accept_source_route=0 net.ipv6.conf.all.accept_source_route=0 net.ipv6.conf.default.accept_source_route=0"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= /^\s*IPT_SYSCTL=/ {print $2}'' /etc/default/ufw)"

	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"

		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done

		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi

		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1'"."'$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}

	IPV6F_CHK() {
		l_ipv6s=""
		grubfile=$(find /boot -type f \( -name ''grubenv'' -o -name ''grub.conf'' -o -name ''grub.cfg'' \) -exec grep -Pl -- ''^\h*(kernelopts=|linux|kernel)'' {} \;)

		if [ -s "$grubfile" ]; then
			! grep -P -- "^\h*(kernelopts=|linux|kernel)" "$grubfile" | grep -vq -- ipv6.disable=1 && l_ipv6s="disabled"
		fi

		if grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\h*(#.*)?$" $l_searchloc && \
			grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\h*(#.*)?$" $l_searchloc && \
			sysctl net.ipv6.conf.all.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\h*(#.*)?$" && \
			sysctl net.ipv6.conf.default.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\h*(#.*)?$"; then
			l_ipv6s="disabled"
		fi

		if [ -n "$l_ipv6s" ]; then
			echo -e "\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
		else
			KPF
		fi
	}

	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"

		if grep -q ''^net.ipv6.'' <<< "$l_kpe"; then
			l_kpfile="/etc/sysctl.d/60-netipv6_sysctl.conf"
			IPV6F_CHK
		else
			l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"
			KPF
		fi
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 3.3.2
elif [[ $section == "3.3.2" ]]; then
	benchmark_title="3.3.2 Ensure ICMP redirects are not accepted (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	ipv4_all_accept_redirects=$(sysctl -n net.ipv4.conf.all.accept_redirects)
	ipv4_default_accept_redirects=$(sysctl -n net.ipv4.conf.default.accept_redirects)
	ipv6_all_accept_redirects=$(sysctl -n net.ipv6.conf.all.accept_redirects)
	ipv6_default_accept_redirects=$(sysctl -n net.ipv6.conf.default.accept_redirects)
	
	# Description
	echo -e "\n${yellow}Description: ${normal}ICMP redirect messages are packets that convey routing information and tell your host (acting as a router) to send packets via an alternate path. It is a way of allowing an outside routing device to update your system routing tables.\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv4.conf.all.accept_redirects = 0"${normal}, \n${bold}"net.ipv4.conf.default.accept_redirects = 0"${normal},\n${bold}"net.ipv6.conf.all.accept_redirects = 0"${normal} and\n${bold}"net.ipv6.conf.default.accept_redirects = 0"${normal}."
	
	if [[ "$ipv4_all_accept_redirects" -eq 0 ]] && \
	[[ "$ipv4_default_accept_redirects" -eq 0 ]] && \
	[[ "$ipv6_all_accept_redirects" -eq 0 ]] && \
	[[ "$ipv6_default_accept_redirects" -eq 0 ]]; then
        	echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
    	else
       		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.conf.all.accept_redirects net.ipv4.conf.default.accept_redirects net.ipv6.conf.all.accept_redirects net.ipv6.conf.default.accept_redirects
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\nExplaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.conf.all.accept_redirects"${normal}, ${bold}"net.ipv4.conf.default.accept_redirects"${normal}, ${bold}"net.ipv6.conf.all.accept_redirects"${normal} and${bold}"net.ipv6.conf.default.accept_redirects"${normal} are all set to 1, which does not meet the required criteria.\n\nAttackers could use bogus ICMP redirect messages to maliciously alter the system routing tables and get them to send packets to incorrect networks and allow your system packets to be captured.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 309 and 310 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output=""
	l_output2=""
	l_parlist="net.ipv4.conf.all.accept_redirects=0 net.ipv4.conf.default.accept_redirects=0 net.ipv6.conf.all.accept_redirects=0 net.ipv6.conf.default.accept_redirects=0"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= ''/^\s*IPT_SYSCTL=/ {print $2}'' /etc/default/ufw)"

	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"

		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done

		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi

		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1"."$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}

	IPV6F_CHK() {
		l_ipv6s=""
		grubfile=$(find /boot -type f \( -name ''grubenv'' -o -name ''grub.conf'' -o -name ''grub.cfg'' \) -exec grep -Pl -- ''^\h*(kernelopts=|linux|kernel)'' {} \;)

		if [ -s "$grubfile" ]; then
			! grep -P -- "^\h*(kernelopts=|linux|kernel)" "$grubfile" | grep -vq -- ipv6.disable=1 && l_ipv6s="disabled"
		fi

		if grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\h*(#.*)?$" $l_searchloc && \
			grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\h*(#.*)?$" $l_searchloc && \
			sysctl net.ipv6.conf.all.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\h*(#.*)?$" && \
			sysctl net.ipv6.conf.default.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\h*(#.*)?$"; then
			l_ipv6s="disabled"
		fi

		if [ -n "$l_ipv6s" ]; then
			echo -e "\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
		else
			KPF
		fi
	}

	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"

		if grep -q ''^net.ipv6.'' <<< "$l_kpe"; then
			l_kpfile="/etc/sysctl.d/60-netipv6_sysctl.conf"
			IPV6F_CHK
		else
			l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"
			KPF
		fi
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 3.3.3
elif [[ $section == "3.3.3" ]]; then
	benchmark_title="3.3.3 Ensure secure ICMP redirects are not accepted (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	ipv4_default_secure_redirects=$(sysctl -n net.ipv4.conf.default.secure_redirects)
	ipv4_all_secure_redirects=$(sysctl -n net.ipv4.conf.all.secure_redirects)

	
	# Description
	echo -e "\n${yellow}Description: ${normal}Secure ICMP redirects are the same as ICMP redirects, except they come from gateways listed on the default gateway list. It is assumed that these gateways are known to your system, and that they are likely to be secure.\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv4.conf.default.secure_redirects = 0"${normal} and\n${bold}"net.ipv4.conf.all.secure_redirects = 0"${normal}."
	
	if [[ "$ipv4_default_secure_redirects" -eq 0 ]] && [[ "$ipv4_all_secure_redirects" -eq 0 ]]; then
        	echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
    	else
       		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.conf.default.secure_redirects net.ipv4.conf.all.secure_redirects
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.conf.default.secure_redirects"${normal} and${bold}"net.ipv4.conf.all.secure_redirects"${normal} are all set to 1, which does not meet the required criteria.\n\nIt is still possible for even known gateways to be compromised and protecting the system from routing table updates by possibly compromised known gateways.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 314 as shown"
		echo '
#!/usr/bin/env bash
kernel_parameter_fix() {
	l_output=""
	l_output2=""
	l_parlist="net.ipv4.conf.default.secure_redirects=0 net.ipv4.conf.all.secure_redirects=0"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= ''/^\s*IPT_SYSCTL=/ {print $2}'' /etc/default/ufw)"
	l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"

	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"
        
		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done
        
		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi
        
		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1"."$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}

	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"
		KPF
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 3.3.4
elif [[ $section == "3.3.4" ]]; then
	benchmark_title="3.3.4 Ensure suspicious packets are logged (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	ipv4_log_martians=$(sysctl -n net.ipv4.conf.all.log_martians)
	ipv4_default_log_martians=$(sysctl -n net.ipv4.conf.default.log_martians)

	
	# Description
	echo -e "\n${yellow}Description: ${normal}When enabled, this feature logs packets with un-routable source addresses to the kernel log.\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv4.conf.all.log_martians = 1"${normal} and\n${bold}"net.ipv4.conf.default.log_martians = 1"${normal}."
	
	if [[ "$ipv4_log_martians" -eq 1 ]] && [[ "$ipv4_default_log_martians" -eq 1 ]]; then
        	echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
    	else
       		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.conf.all.log_martians net.ipv4.conf.default.log_martians
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.conf.default.secure_redirects"${normal} and${bold}"net.ipv4.conf.all.secure_redirects"${normal} are all set to 0, which does not meet the required criteria.\n\nThis allows an administrator to investigate the possibility that an attacker is sending spoofed packets to their system.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 318 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output=""
	l_output2=""
	l_parlist="net.ipv4.conf.all.log_martians=1 net.ipv4.conf.default.log_martians=1"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= ''/^\s*IPT_SYSCTL=/ {print $2}'' /etc/default/ufw)"
	l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"

	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"
        
		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done
        
		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi
        
		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1"."$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}

	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"
		KPF
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
  	# 3.3.5
elif [[ $section == "3.3.5" ]]; then
	benchmark_title="3.3.5 Ensure broadcast ICMP requests are ignored (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	ipv4_icmp=$(sysctl -n net.ipv4.icmp_echo_ignore_broadcasts)

	
	# Description
	echo -e "\n${yellow}Description: ${normal}Setting ${bold}net.ipv4.icmp_echo_ignore_broadcasts = 1${normal} will cause the system to ignore all ICMP echo and timestamp requests to broadcast and multicast addresses.\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv4.icmp_echo_ignore_broadcasts = 1"${normal}"
	
	if [[ "$ipv4_icmp" -eq 1 ]]; then
        	echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
    	else
       		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.icmp_echo_ignore_broadcasts
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.icmp_echo_ignore_broadcasts"${normal} is set to 0, which does not meet the required criteria.\n\nAccepting ICMP echo and timestamp requests with broadcast or multicast destinations for your network could be used to trick your host into starting (or participating) in a Smurf attack. A Smurf attack relies on an attacker sending large amounts of ICMP broadcast messages with a spoofed source address. All hosts receiving this message and responding would send echo-reply messages back to the spoofed address, which is probably not routable. If many hosts respond to the packets, the amount of traffic on the network could be significantly multiplied.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 322 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output=""
	l_output2=""
	l_parlist="net.ipv4.icmp_echo_ignore_broadcasts=1"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= ''/^\s*IPT_SYSCTL=/ {print $2}'' /etc/default/ufw)"
	l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"

	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"
        
		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done
        
		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi
        
		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1"."$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}

	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"
		KPF
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
   	# 3.3.6
elif [[ $section == "3.3.6" ]]; then
	benchmark_title="3.3.6 Ensure bogus ICMP responses are ignored (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	ipv4_icmp_ignore=$(sysctl -n net.ipv4.icmp_ignore_bogus_error_responses)
	
	# Description
	echo -e "\n${yellow}Description: ${normal}Setting ${bold}icmp_ignore_bogus_error_responses = 1${normal} prevents the kernel from logging bogus responses (RFC-1122 non-compliant) from broadcast reframes, keeping file systems from filling up with useless log messages.\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv4.icmp_ignore_bogus_error_responses = 1"${normal}"
	
	if [[ "$ipv4_icmp_ignore" -eq 1 ]]; then
        	echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
    	else
       		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.icmp_ignore_bogus_error_responses
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.icmp_ignore_bogus_error_responses"${normal} is set to 0, which does not meet the required criteria.\n\nSome routers (and some attackers) will send responses that violate RFC-1122 and attempt to fill up a log file system with many useless error messages.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 326 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output=""
	l_output2=""
	l_parlist="icmp_ignore_bogus_error_responses=1"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= ''/^\s*IPT_SYSCTL=/ {print $2}'' /etc/default/ufw)"
	l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"

	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"
		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done
        
		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi
        
		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1"."$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}

	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"
		KPF
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
    	# 3.3.7
elif [[ $section == "3.3.7" ]]; then
	benchmark_title="3.3.7 Ensure Reverse Path Filtering is enabled (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	
	# Description
	echo -e "\n${yellow}Description: ${normal}Setting ${bold}net.ipv4.conf.all.rp_filter${normal} and ${bold}net.ipv4.conf.default.rp_filter${normal} to 1 forces the Linux kernel to utilize reverse path filtering on a received packet to determine if the packet was valid. Essentially, with reverse path filtering, if the return packet does not go out the same interface that the corresponding source packet came from, the packet is dropped (and logged if log_martians is set).\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv4.conf.all.rp_filter = 1"${normal} and\n${bold}"net.ipv4.conf.default.rp_filter = 1"${normal}"
	
	if [[ $(sysctl -n net.ipv4.conf.all.rp_filter) -eq 1 ]] && [[ $(sysctl -n net.ipv4.conf.default.rp_filter) -eq 1 ]]; then
        	echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
    	else
       		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.conf.all.rp_filter net.ipv4.conf.default.rp_filter
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.conf.all.rp_filter"${normal} and ${bold}"net.ipv4.conf.default.rp_filter"${normal} is set to 2, which does not meet the required criteria.\n\nThis is to deter attackers from sending your system bogus packets that cannot be responded to. One instance where this feature breaks down is if asymmetrical routing is employed.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 330 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output=""
	l_output2=""
	l_parlist="net.ipv4.conf.all.rp_filter=1 net.ipv4.conf.default.rp_filter=1"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= ''/^\s*IPT_SYSCTL=/ {print $2}'' /etc/default/ufw)"
	l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"

	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"
		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done
        
		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi
        
		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1"."$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}

	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"
		KPF
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.3.8
elif [[ $section == "3.3.8" ]]; then
	benchmark_title="3.3.8 Ensure TCP SYN Cookies is enabled (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	
	# Description
	echo -e "\n${yellow}Description: ${normal}When ${bold}tcp_syncookies${normal} is set, the kernel will handle TCP SYN packets normally until the half-open connection queue is full, at which time, the SYN cookie functionality kicks in. SYN cookies work by not using the SYN queue at all. Instead, the kernel simply replies to the SYN with a SYN|ACK, but will include a specially crafted TCP sequence number that encodes the source and destination IP address and port number and the time the packet was sent.\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv4.tcp_syncookies = 1:"${normal}"
	
	if [[ $(sysctl -n net.ipv4.tcp_syncookies) -eq 1 ]]; then
        	echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
    	else
       		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv4.tcp_syncookies
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv4.tcp_syncookies"${normal} is set to 1, which does not meet the required criteria.\n\nAttackers use SYN flood attacks to perform a denial of service attacked on a system by sending many SYN packets without completing the three way handshake. This will quickly use up slots in the kernel's half-open connection queue and prevent legitimate connections from succeeding.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 334 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output=""
	l_output2=""
	l_parlist="net.ipv4.tcp_syncookies=1"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= ''/^\s*IPT_SYSCTL=/ {print $2}'' /etc/default/ufw)"
	l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"

	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"
		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done
        
		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi
        
		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1"."$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}

	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"
		KPF
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
     	# 3.3.9
elif [[ $section == "3.3.9" ]]; then
	benchmark_title="3.3.9 Ensure IPv6 router advertisements are not accepted (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	
	# Description
	echo -e "\n${yellow}Description: ${normal}This setting disables the system's ability to accept IPv6 router advertisements.\n\nWhen performing the audit, the output that should be shown is\n${bold}"net.ipv6.conf.all.accept_ra = 0"${normal} and\n${bold}"net.ipv6.conf.default.accept_ra = 0"${normal}"
	
	if [[ $(sysctl -n net.ipv6.conf.all.accept_ra) -eq 0 && $(sysctl -n net.ipv6.conf.default.accept_ra) -eq 0 ]]; then
        	echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
    	else
       		# Output
		echo -e "\n${yellow}Output:${normal} ";
		sysctl net.ipv6.conf.all.accept_ra net.ipv6.conf.default.accept_ra
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}"net.ipv6.conf.all.accept_ra"${normal} and ${bold}"net.ipv6.conf.default.accept_ra"${normal} is set to 1, which does not meet the required criteria.\n\nIt is recommended that systems do not accept router advertisements as they could be tricked into routing traffic to compromised machines. Setting hard routes within the system (usually a single default route to a trusted router) protects the system from bad routes.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 339 and 340 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_output=""
	l_output2=""
	l_parlist="net.ipv6.conf.all.accept_ra=0 net.ipv6.conf.default.accept_ra=0"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= ''/^\s*IPT_SYSCTL=/ {print $2}'' /etc/default/ufw)"
    
	KPF() {
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s -- "^\s*$l_kpname" $l_searchloc | grep -Pv -- "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print '$1'}')"
		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done
        
		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq -- "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi
        
		# Set correct parameter in active kernel parameters
		l_krp="$(sysctl "$l_kpname" | awk -F= '{print '$2'}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			sysctl -w "$l_kpname=$l_kpvalue"
			sysctl -w "$(awk -F'.' '{print '$1"."$2'".route.flush=1"}' <<< "$l_kpname")"
		fi
	}
    
	IPV6F_CHK() {
		l_ipv6s=""
		grubfile=$(find /boot -type f \( -name ''grubenv'' -o -name ''grub.conf'' -o -name ''grub.cfg'' \) -exec grep -Pl -- ''^\h*(kernelopts=|linux|kernel)'' {} \;)
		if [ -s "$grubfile" ]; then
			! grep -P -- "^\h*(kernelopts=|linux|kernel)" "$grubfile" | grep -vq -- ipv6.disable=1 && l_ipv6s="disabled"
		fi
        
		if grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\h*(#.*)?$" $l_searchloc && \ grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\h*(#.*)?$" $l_searchloc && \
		sysctl net.ipv6.conf.all.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\h*(#.*)?$" && \
		sysctl net.ipv6.conf.default.disable_ipv6 | grep -Pqs -- "^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\h*(#.*)?$"; then
			l_ipv6s="disabled"
		fi
        
		if [ -n "$l_ipv6s" ]; then
			echo -e "\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
		else
			KPF
		fi
	}
    
	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print '$1'}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print '$2'}' <<< "$l_kpe")"
		if grep -q ''^net.ipv6.'' <<< "$l_kpe"; then
			l_kpfile="/etc/sysctl.d/60-netipv6_sysctl.conf"
			IPV6F_CHK
		else
			l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"
			KPF
		fi
	done
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.4.1
elif [[ $section == "3.4.1" ]]; then
	benchmark_title="3.4.1 Ensure DCCP is disabled (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	
	# Description
	echo -e "\n${yellow}Description: ${normal}The Datagram Congestion Control Protocol (DCCP) is a transport layer protocol that supports streaming media and telephony. DCCP provides a way to gain access to congestion control, without having to do it at the application layer, but does not provide in-sequence delivery.\n\nWhen performing the audit, there should be no output shown."
	
	if lsmod | grep -q '^dccp\s'; then
		# Output
		echo -e "\n${yellow}Output:${normal} ";
		lsmod | grep '^dccp\s'
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}dccp${normal}is installed, which does not meet the required criteria.\n\nIf the protocol is not required, it is recommended that the drivers not be installed to reduce the potential attack surface.outes within the system (usually a single default route to a trusted router) protects the system from bad routes.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 345 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_mname="dccp" # set module name
    
	if ! modprobe -n -v "$l_mname" | grep -P -- ''i^\h*install \/bin\/(true|false)''; then
		echo -e " - setting module: \"$l_mname\" to be not loadable"
		echo -e "install $l_mname /bin/false" >> /etc/modprobe.d/"$l_mname".conf
	fi
    
	if lsmod | grep "$l_mname" > /dev/null 2>&1; then
		echo -e " - unloading module \"$l_mname\""
		modprobe -r "$l_mname"
	fi
    
	if ! grep -Pq -- "^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*; then
		echo -e " - deny listing \"$l_mname\""
		echo -e "blacklist $l_mname" >> /etc/modprobe.d/"$l_mname".conf
	fi
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
    	else
    		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.4.2
elif [[ $section == "3.4.2" ]]; then
	benchmark_title="3.4.2 Ensure SCTP is disabled (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	
	# Description
	echo -e "\n${yellow}Description: ${normal}The Stream Control Transmission Protocol (SCTP) is a transport layer protocol used to support message oriented communication, with several streams of messages in one connection. It serves a similar function as TCP and UDP, incorporating features of both. It is message-oriented like UDP, and ensures reliable in-sequence transport of messages with congestion control like TCP.\n\nWhen performing the audit, there should be no output shown."
	
	if lsmod | grep -q '^sctp\s'; then
		# Output
		echo -e "\n${yellow}Output:${normal} ";
		lsmod | grep '^sctp\s'
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}sctp${normal}is installed, which does not meet the required criteria.\n\nIf the protocol is not being used, it is recommended that kernel module not be loaded, disabling the service to reduce the potential attack surface.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 348 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_mname="sctp" # set module name
    
	if ! modprobe -n -v "$l_mname" | grep -P -- ''i^\h*install \/bin\/(true|false)''; then
		echo -e " - setting module: \"$l_mname\" to be not loadable"
		echo -e "install $l_mname /bin/false" >> /etc/modprobe.d/"$l_mname".conf
	fi
    
	if lsmod | grep "$l_mname" > /dev/null 2>&1; then
		echo -e " - unloading module \"$l_mname\""
		modprobe -r "$l_mname"
	fi
    
	if ! grep -Pq -- "^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*; then
		echo -e " - deny listing \"$l_mname\""
		echo -e "blacklist $l_mname" >> /etc/modprobe.d/"$l_mname".conf
	fi
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
    	else
    		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.4.3
elif [[ $section == "3.4.3" ]]; then
	benchmark_title="3.4.3 Ensure RDS is disabled (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	
	# Description
	echo -e "\n${yellow}Description: ${normal}The Reliable Datagram Sockets (RDS) protocol is a transport layer protocol designed to provide low-latency, high-bandwidth communications between cluster nodes. It was developed by the Oracle Corporation.\n\nWhen performing the audit, there should be no output shown."
	
	if lsmod | grep -q '^rds\s'; then
		# Output
		echo -e "\n${yellow}Output:${normal} ";
		lsmod | grep '^rds\s'
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}rds${normal}is installed, which does not meet the required criteria.\n\nIf the protocol is not being used, it is recommended that kernel module not be loaded, disabling the service to reduce the potential attack surface.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 351 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_mname="rds" # set module name
    
	if ! modprobe -n -v "$l_mname" | grep -P -- ''i^\h*install \/bin\/(true|false)''; then
		echo -e " - setting module: \"$l_mname\" to be not loadable"
		echo -e "install $l_mname /bin/false" >> /etc/modprobe.d/"$l_mname".conf
	fi
    
	if lsmod | grep "$l_mname" > /dev/null 2>&1; then
		echo -e " - unloading module \"$l_mname\""
		modprobe -r "$l_mname"
	fi
    
	if ! grep -Pq -- "^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*; then
		echo -e " - deny listing \"$l_mname\""
		echo -e "blacklist $l_mname" >> /etc/modprobe.d/"$l_mname".conf
	fi
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
    	else
    		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.4.4
elif [[ $section == "3.4.4" ]]; then
	benchmark_title="3.4.4 Ensure TIPC is disabled (Automated)"
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"
	
	# Description
	echo -e "\n${yellow}Description: ${normal}The Transparent Inter-Process Communication (TIPC) protocol is designed to provide communication between cluster nodes.\n\nWhen performing the audit, there should be no output shown."
	
	if lsmod | grep -q '^tipc\s'; then
		# Output
		echo -e "\n${yellow}Output:${normal} ";
		lsmod | grep '^tipc\s'
		
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}tipc${normal}is installed, which does not meet the required criteria.\n\nIf the protocol is not being used, it is recommended that kernel module not be loaded, disabling the service to reduce the potential attack surface.\n\n${yellow}Remidation: ${normal}\n1. Run the remediation script found in the CIS Benchmark Ubuntu Linux 22.04 LTS Page 345 as shown:"
		echo '
#!/usr/bin/env bash
{
	l_mname="tipc" # set module name
    
	if ! modprobe -n -v "$l_mname" | grep -P -- ''i^\h*install \/bin\/(true|false)''; then
		echo -e " - setting module: \"$l_mname\" to be not loadable"
		echo -e "install $l_mname /bin/false" >> /etc/modprobe.d/"$l_mname".conf
	fi
    
	if lsmod | grep "$l_mname" > /dev/null 2>&1; then
		echo -e " - unloading module \"$l_mname\""
		modprobe -r "$l_mname"
	fi
    
	if ! grep -Pq -- "^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*; then
		echo -e " - deny listing \"$l_mname\""
		echo -e "blacklist $l_mname" >> /etc/modprobe.d/"$l_mname".conf
	fi
}'
		echo -e "\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
    	else
    		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
  	# 3.5.1.1
elif [[ $section == "3.5.1.1" ]]; then
	benchmark_title="3.5.1.1 Ensure ufw is installed (Automated)"
	audit=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' ufw)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}Uncomplicated Firewall (ufw)${normal} is a frontend for iptables and is particularly well-suited for host-based firewalls. ufw provides a framework for managing netfilter, as well as a command-line interface for manipulating the firewall.\n\nWhen performing the audit, the output that should be shown is\n${bold}ufw	install ok installed	installed ${normal}to show that ${bold}ufw${normal} is installed."

	# Output
	echo -e "\n${yellow}Output:${normal} $audit"

	if dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' ufw | grep -q '^ufw\s*install\s*ok\s*installed'; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}ufw${normal} is not installed, which it does not meet the required criteria.\n\nA firewall utility is required to configure the Linux kernel's netfilter framework via the iptables or nftables back-end.\n\nThe Linux kernel's netfilter framework host-based firewall can protect against threats originating from within a corporate network to include malicious mobile code and poorly configured software on a host.\n\n${yellow}Remidation: ${normal}\n1. Type ${bold}apt install ufw${normal} into terminal to install ${bold}ufw${normal}\n2. Type 'Y' to complete the installation\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
  	# 3.5.1.2
elif [[ $section == "3.5.1.2" ]]; then
	benchmark_title="3.5.1.2 Ensure iptables-persistent is not installed with ufw (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The ${bold}iptables-persistent${normal} is a boot-time loader for netfilter rules, iptables plugin.\n\nWhen performing the audit, the output that should be shown is\n${bold}package 'iptables-persistent' is not installed and no information is available ${normal}to show that ${bold}iptables-persistent${normal} is not installed."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	dpkg-query -s iptables-persistent

	if ! dpkg-query -s iptables-persistent &>/dev/null; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}iptables-persistent${normal} is installed, which it does not meet the required criteria.\n\nRunning both ufw and the services included in the iptables-persistent package may lead to conflict.\n\n${yellow}Remidation: ${normal}\n1. Type ${bold}apt purge iptables-persistent${normal} into terminal to uninstall ${bold}iptables-persistent${normal}\n2. Type 'Y' to complete the uninstallation\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
   	# 3.5.1.3
elif [[ $section == "3.5.1.3" ]]; then
	benchmark_title="3.5.1.3 Ensure ufw service is enabled (Automated)"
	
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}Uncomplicated Firewall (ufw)${normal} is a frontend for iptables. ufw provides a framework for managing netfilter, as well as a command-line and available graphical user interface for manipulating the firewall.\n\nWhen performing the audit, the output that should be shown for \n${bold}systemctl is-enabled ufw.service${normal} is ${bold}enabled ${normal}, \n${bold}systemctl is-active ufw${normal} is ${bold}active${normal} and \n${bold}ufw status${normal} is ${bold}Status: active${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	systemctl is-enabled ufw.service
	systemctl is-active ufw
	ufw status

	if systemctl is-enabled ufw.service | grep -q 'enabled' && systemctl is-active ufw | grep -q 'active' && ufw status | grep -q 'Status: active'; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}ufw${normal} is not enabled, which it does not meet the required criteria.\n\nThe ufw service must be enabled and running in order for ufw to protect the system.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to verify that the ufw daemon is enabled:\n\n${bold}systemctl is-enabled ufw.service${normal}\n\n2. Run the following command to verify that the ufw daemon is active:\n\n${bold}systemctl is-active ufw${normal}\n\n3. Run the following command to verify ufw is active:\n\n${bold}ufw status${normal}\n\n4. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.5.1.4
elif [[ $section == "3.5.1.4" ]]; then
	benchmark_title="3.5.1.4 Ensure ufw loopback traffic is configured (Automated)"
	
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure the loopback interface to accept traffic. Configure all other interfaces to deny traffic to the loopback network (127.0.0.0/8 for IPv4 and ::1/128 for IPv6).\n\nWhen performing the audit, the output that should be be as such:\n${bold}
To			Action		From
--			------		----
Anywhere on lo		ALLOW IN 	Anywhere
Anywhere		DENY IN		127.0.0.0/8
Anywhere (v6) on lo	ALLOW IN	Anywhere (v6)
Anywhere (v6)		DENY IN		::1

Anywhere		ALLOW OUT	Anywhere on lo
Anywhere (v6)		ALLOW OUT	Anywhere (v6) on lo${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	ufw status verbose

	if echo "$ufw_status" | grep -q "Anywhere on lo\s*ALLOW IN\s*Anywhere" &&
	echo "$ufw_status" | grep -q "Anywhere DENY IN 127.0.0.0/8" &&
	echo "$ufw_status" | grep -q "Anywhere \(v6\) on lo\s*ALLOW IN\s*Anywhere \(v6\)" &&
	echo "$ufw_status" | grep -q "Anywhere \(v6\) DENY IN ::1" &&
	echo "$ufw_status" | grep -q "Anywhere ALLOW OUT Anywhere on lo" &&
	echo "$ufw_status" | grep -q "Anywhere \(v6\) ALLOW OUT Anywhere \(v6\) on lo"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the loopback traffic is not confirgured properly, which it does not meet the required criteria.\n\nLoopback traffic is generated between processes on machine and is typically critical to operation of the system. The loopback interface is the only place that loopback network (127.0.0.0/8 for IPv4 and ::1/128 for IPv6) traffic should be seen, all other interfaces should ignore traffic on this network as an anti-spoofing measure.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to implement the loopback rules:\n\n${bold}ufw allow in on lo\nufw allow out on lo\nufw deny in from 127.0.0.0/8\nufw deny in from ::1${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
    	# 3.5.1.5
elif [[ $section == "3.5.1.5" ]]; then
	benchmark_title="3.5.1.5 Ensure ufw outbound connections are configured (Manual)"
	ufw_status=$(ufw status numbered)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure the firewall rules for new outbound connections.\n\nWhen performing the audit, the output that should be shown is\n${bold}Status: active${normal} and \n${bold}allow out on all${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	ufw status numbered

	if echo "$ufw_status" | grep -q "Status: active" && secho "$ufw_status" | grep -q "allow out on all"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ufw outbound connection is not configured properly, which it does not meet the required criteria.\n\nIf rules are not in place for new outbound connections all packets will be dropped by the default policy preventing network usage.\n\n${yellow}Remidation: ${normal}\n1. Configure ufw in accordance with site policy. The following commands will implement a policy to allow all outbound connections on all interfaces:\n\n${bold}ufw allow out on all${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
    	# 3.5.1.6
elif [[ $section == "3.5.1.6" ]]; then
	benchmark_title="3.5.1.6 Ensure ufw firewall rules exist for all open ports (Automated)"
	open_ports=$(ufw status verbose | awk '/^  [0-9]+\/(tcp|udp)/ {print $2}')
	missing_rules=false

	# Check if there are any open ports without ufw rules
	for port in $open_ports; do
		if ! ufw status verbose | grep -qE "^[[:space:]]+$port\/(tcp|udp)[[:space:]]"; then
			missing_rules=true
		fi
	done
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure the firewall rules for new outbound connections.\n\nWhen performing the audit, there should be no output shown."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	ufw status verbose | grep -E "^[[:space:]]+$port\/(tcp|udp)[[:space:]]"

	if [[ "$missing_rules" = false ]]; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ufw firewall rules is not configured properly, which it does not meet the required criteria.\n\nWithout a firewall rule configured for open ports default firewall policy will drop all packets to these ports.\n\n${yellow}Remidation: ${normal}\n1. For each port identified in the audit which does not have a firewall rule, add rule for accepting or denying inbound connections:\n\n${bold}ufw allow in <port>/<tcp or udp protocol>${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
     	# 3.5.1.7
elif [[ $section == "3.5.1.7" ]]; then
	benchmark_title="3.5.1.7 Ensure ufw default deny firewall policy (Automated)"
	ufw_status=$(ufw status verbose | grep Default:)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}A default deny policy on connections ensures that any unconfigured network usage will be rejected.\n\nWhen performing the audit, the output that should be shown for\n${bold}ufw status verbose | grep Default:${normal} is ${bold}Default: deny (incoming), deny (outgoing), disabled (routed)${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	ufw status verbose | grep Default:

	if echo "$ufw_status" | grep -q "Default: deny (incoming)" && echo "$ufw_status" | grep -q "Default: reject (outgoing)" && echo "$ufw_status" | grep -q "Default: disabled (routed)"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ufw default deny firewall policy is not configured properly, which it does not meet the required criteria.\n\nWith a default accept policy the firewall will accept any packet that is not configured to be denied. It is easier to white list acceptable usage than to black list unacceptable usage.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to implement a default deny policy:\n\n${bold}ufw default deny incoming\nufw default deny outgoing\nufw default deny routed${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.5.2.1
elif [[ $section == "3.5.2.1" ]]; then
	benchmark_title="3.5.2.1 Ensure nftables is installed (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}nftables${normal} provides a new in-kernel packet classification framework that is based on a network-specific Virtual Machine (VM) and a new nft userspace command line tool. nftables reuses the existing Netfilter subsystems such as the existing hook infrastructure, the connection tracking system, NAT, userspace queuing and logging subsystem.\n\nWhen performing the audit, the output that should be shown is\n${bold}Status: install ok installed ${normal}to show that ${bold}nftables${normal} is installed."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	dpkg-query -s nftables 2>/dev/null | grep 'Status: install ok installed'

	if dpkg-query -s nftables 2>/dev/null | grep -q 'Status: install ok installed'; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}nftables${normal} is not installed, which it does not meet the required criteria.\n\n${bold}nftables${normal} is a subsystem of the Linux kernel that can protect against threats originating from within a corporate network to include malicious mobile code and poorly configured software on a host.\n\n${yellow}Remidation: ${normal}\n1. Type ${bold}apt install nftables${normal} into terminal to install ${bold}nftables${normal}\n2. Type 'Y' to complete the uninstallation\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.5.2.2
elif [[ $section == "3.5.2.2" ]]; then
	benchmark_title="3.5.2.2 Ensure ufw is uninstalled or disabled with nftables (Automated)"
	ufw=$(dpkg-query -s ufw 2>/dev/null | grep -q 'Status: install ok installed')
	ufw_status=$(ufw status 2>/dev/null)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}Uncomplicated Firewall (UFW)${normal} is a program for managing a netfilter firewall designed to be easy to use.\n\nWhen performing the audit, the output that should be shown is\n${bold}package 'ufw' is not installed and no information is available${normal}to show that ${bold}ufw${normal} is uninstalled."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	dpkg-query -s ufw 2>/dev/null | grep 'Status: install ok installed'
	ufw status

	if ! dpkg-query -s ufw 2>/dev/null | grep -q 'Status: install ok installed' && grep -q 'Status: inactive' <<< "$ufw_status"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}nftables${normal} is not installed, which it does not meet the required criteria.\n\nRunning both the ${bold}nftables${normal} service and ${bold}ufw${normal} may lead to conflict and unexpected results.\n\n${yellow}Remidation: ${normal}\n1. Run one of the following commands to either remove ufw or disable ufw\n\nRun the following command to remove ufw:\n${bold}apt purge ufw${normal}\n\nRun the following command to disable ufw:\n${bold}ufw disable${normal}\n\n2. Type 'Y' to complete the uninstallation\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 3.5.2.3
elif [[ $section == "3.5.2.3" ]]; then
	benchmark_title="3.5.2.3 Ensure iptables are flushed with nftables (Manual)"
	iptables_rules=$(iptables -L)
	ip6tables_rules=$(ip6tables -L)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}nftables${normal} is a replacement for ${bold}iptables${normal}, ${bold}ip6tables${normal}, ${bold}ebtables${normal} and ${bold}arptables${normal}\n\nWhen performing the audit, there should be no output shown."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	echo -e "${bold}IPv4${normal}"
	iptables -L
	echo
	echo -e "${bold}IPv6${normal}"
	ip6tables -L

	if [[ -z "$iptables_rules" ]] && [[ -z "$ip6tables_rules" ]]; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}nftables${normal} is not installed, which it does not meet the required criteria.\n\nRunning both the ${bold}nftables${normal} service and ${bold}ufw${normal} may lead to conflict and unexpected results.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to flush iptables:\n\nFor iptables:\n${bold}iptables -F${normal}\n\nFor ip6tables:\n${bold}iptables -F${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 3.5.2.4
elif [[ $section == "3.5.2.4" ]]; then
	benchmark_title="3.5.2.4 Ensure a nftables table exists (Automated)"
	nft_list_tables=$(nft list tables)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Tables hold chains. Each table only has one address family and only applies to packets of this family. Tables can have one of five families.\n\nWhen performing the audit, the output that should be shown is ${bold}table <table name> ${normal}to show that nftables table exists."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	nft list tables

	if ! [[ -z "$nft_list_tables" ]]; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because there's no nftables tables that exists, which it does not meet the required criteria.\n\n${bold}nftables${normal} doesn't have any default tables. Without a table being build, nftables will not filter network traffic.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to create a table in nftables:\n${bold}nft create table inet <table name>${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
  	# 3.5.2.5
elif [[ $section == "3.5.2.5" ]]; then
	benchmark_title="3.5.2.5 Ensure nftables base chains exist (Automated)"
	nft_list_tables=$(nft list tables)
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Chains are containers for rules. They exist in two kinds, base chains and regular chains. A base chain is an entry point for packets from the networking stack, a regular chain may be used as jump target and is used for better rule organization.\n\nWhen performing the audit, the output that should be shown are\n${bold}type filter hook input priority 0; ${normal},\n${bold}type filter hook forward priority 0; ${normal} and\n${bold}type filter hook output priority 0;${normal}\nto show that nftables base chains exists."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	nft list ruleset | grep 'hook input'
	nft list ruleset | grep 'hook forward'
	nft list ruleset | grep 'hook output'

	if nft list ruleset | grep -q 'hook input' && nft list ruleset | grep -q 'hook forward' && nft list ruleset | grep -q 'hook output'; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because there's no nftables base chains that exists, which it does not meet the required criteria.\n\nIf configuring nftables over ssh, creating a base chain with a policy of drop will cause loss of connectivity.\n\nEnsure that a rule allowing ssh has been added to the base chain prior to setting the base chain's policy to drop.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to create the base chains:\n${bold}nft create chain inet <table name> <base chain name> { type filter hook <(input|forward|output)> priority 0 \; }${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.5.2.6
elif [[ $section == "3.5.2.6" ]]; then
	benchmark_title="3.5.2.6 Ensure nftables loopback traffic is configured (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure the loopback interface to accept traffic. Configure all other interfaces to deny traffic to the loopback network.\n\nWhen performing the audit, the output that should be shown are\n${bold}iif "'lo'" accept${normal},\n${bold}ip saddr 127.0.0.0/8 counter packets 0 bytes 0 drop${normal} and\n${bold}ip6 saddr ::1 counter packets 0 bytes 0 drop${normal}\nto show that nftables loopback traffic is configured."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	nft list ruleset | awk '/hook input/,/}/' | grep 'iif "lo" accept'
	nft list ruleset | awk '/hook input/,/}/' | grep 'ip saddr 127.0.0.0/8 counter packets 0 bytes 0 drop'
	nft list ruleset | awk '/hook input/,/}/' | grep 'ip6 saddr'

	if nft list ruleset | grep -q 'hook input' && nft list ruleset | grep -q 'hook forward' && nft list ruleset | grep -q 'hook output' && nft list ruleset | awk '/hook input/,/}/' | grep -q 'ip6 saddr'; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because nftables loopback traffic is not configured, which it does not meet the required criteria.\n\nLoopback traffic is generated between processes on machine and is typically critical to operation of the system. The loopback interface is the only place that loopback network traffic should be seen, all other interfaces should ignore traffic on this network as an anti-spoofing measure.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to implement the loopback rules:\n${bold}nft add rule inet filter input iif lo accept\nnft create rule inet filter input ip saddr 127.0.0.0/8 counter drop${normal}\n\n2. IF IPv6 is enabled on the system:\nRun the following command to implement the IPv6 loopback rule:\n${bold}nft add rule inet filter input ip6 saddr ::1 counter drop${normal}\n\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 3.5.2.7
elif [[ $section == "3.5.2.7" ]]; then
	benchmark_title="3.5.2.7 Ensure nftables outbound and established connections are configured (Manual)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure the firewall rules for new outbound, and established connections.\n\nWhen performing the audit, the output that should be shown are\n${bold}ip protocol tcp ct state established accept\nip protocol udp ct state established accept\nip protocol icmp ct state established accept${normal} \nand\n${bold}ip protocol tcp ct state established,related,new accept\nip protocol udp ct state established,related,new accept\nip protocol icmp ct state established,related,new accept${normal}\nto show that nftables outbound and established connections are configured."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	nft list ruleset | awk '/hook input/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state established accept'
	nft list ruleset | awk '/hook output/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state established,related,new accept'

	if nft list ruleset | awk '/hook input/,/}/' | grep -qE 'ip protocol (tcp|udp|icmp) ct state established accept' && nft list ruleset | awk '/hook output/,/}/' | grep -qE 'ip protocol (tcp|udp|icmp) ct state established,related,new accept'; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because nftables outbound and established connections are not configured, which it does not meet the required criteria.\n\nIf rules are not in place for new outbound, and established connections all packets will be dropped by the default policy preventing network usage.\n\n${yellow}Remidation: ${normal}\n1. Configure nftables in accordance with site policy. The following commands will implement a policy to allow all outbound connections and all established connections:\n${bold}nft add rule inet filter input ip protocol tcp ct state established accept\nnft add rule inet filter input ip protocol udp ct state established accept\nnft add rule inet filter input ip protocol icmp ct state established accept\nnft add rule inet filter output ip protocol tcp ct state new,related,established accept\nnft add rule inet filter output ip protocol udp ct state new,related,established accept\nnft add rule inet filter output ip protocol icmp ct state new,related,established accept${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
  	# 3.5.2.8
elif [[ $section == "3.5.2.8" ]]; then
	benchmark_title="3.5.2.8 Ensure nftables default deny firewall policy (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Base chain policy is the default verdict that will be applied to packets reaching the end of the chain.\n\nWhen performing the audit, the output that should be shown are\n${bold}type filter hook input priority 0; policy drop;\ntype filter hook forward priority 0; policy drop;${normal} \nand\n${bold}type filter hook output priority 0; policy drop;${normal}\nto show that nftables default deny firewall policy."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	nft list ruleset | grep 'hook input'
	nft list ruleset | grep 'hook forward'
	nft list ruleset | grep 'hook output'

	if nft list ruleset | grep 'hook input' | grep "policy: drop" && nft list ruleset | grep "policy: drop" | grep 'hook forward' && nft list ruleset | grep 'hook output' | grep "policy: drop"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because nftables default did not deny firewall policy, which it does not meet the required criteria.\n\nThere are two policies: accept (Default) and drop. If the policy is set to accept, the firewall will accept any packet that is not configured to be denied and the packet will continue transversing the network stack.\n\nIt is easier to white list acceptable usage than to black list unacceptable usage.\n\n${yellow}Remidation: ${normal}\n1. Run the following command for the base chains with the input, forward, and output hooks to implement a default DROP policy:\n${bold}nft chain <table family> <table name> <input/forward/output> { policy drop \; }${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
   	# 3.5.2.9
elif [[ $section == "3.5.2.9" ]]; then
	benchmark_title="3.5.2.9 Ensure nftables service is enabled (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}The nftables service allows for the loading of nftables rulesets during boot, or starting on the nftables service.\n\nWhen performing the audit, the output that should be shown is ${bold}enabled${normal} to show that nftables service is enabled."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	systemctl is-enabled nftables

	if systemctl is-enabled nftables | grep -q "enabled"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because nftables service is not enabled, which it does not meet the required criteria.\n\nThe nftables service restores the nftables rules from the rules files referenced in the ${bold}/etc/nftables.conf${normal} file during boot or the starting of the nftables service\n\n${yellow}Remidation: ${normal}\n1. Run the following command to enable the nftables service:\n${bold}systemctl enable nftables${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 3.5.2.10
elif [[ $section == "3.5.2.10" ]]; then
	benchmark_title="3.5.2.10 Ensure nftables rules are permanent (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}nftables${normal} is a subsystem of the Linux kernel providing filtering and classification of network packets/datagrams/frames.\n\nThe nftables service reads the ${bold}/etc/nftables.conf${normal} file for a nftables file or files to include in the nftables ruleset.\n\nA nftables ruleset containing the input, forward, and output base chains allow network traffic to be filtered.\n\nWhen performing the audit, there will be an output that'll ensure nftables rules are permanent."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	[ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook input/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$"
	[ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook forward/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$"
	[ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook output/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$"

	if [ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook input/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$" &&
	[ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook forward/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$" &&
	[ -n "$(grep -E '^\s*include' /etc/nftables.conf)" ] && awk '/hook output/,/}/' $(awk '$1 ~ /^\s*include/ { gsub("\"","",$2);print $2 }' /etc/nftables.conf) | grep -q "^\s*ip\s+protocol\s+(tcp|udp|icmp)\s+ct\s+state\s+(established\s+accept|related\s+accept|new\s+accept)\s*$"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because the nftables rules are not permanent, which it does not meet the required criteria\n\nChanges made to nftables ruleset only affect the live system, you will also need to configure the nftables ruleset to apply on boot.\n\n${yellow}Remidation: ${normal}\n1. Access the nftables.conf file by using the command ${bold}vim /etc/nftables.conf ${normal}\n2. Scroll down until you see the ${bold}include ${normal}parameter\n3. Click on ${bold}I ${normal}on your keyboard to enter insert mode\n4. Type in ${bold}'/etc/nftables.rules'${normal} to appropriate the ${bold}include ${normal}parameter\n5. Save the file by pressing the ${bold}esc ${normal}key and typing ${bold}:wq ${normal}to save and quit editing the file\n6. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
    	# 3.5.3.1.1
elif [[ $section == "3.5.3.1.1" ]]; then
	benchmark_title="3.5.3.1.1 Ensure iptables packages are installed (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}iptables${normal} is a utility program that allows a system administrator to configure the tables provided by the Linux kernel firewall, implemented as different Netfilter modules, and the chains and rules it stores. Different kernel modules and programs are used for different protocols; iptables applies to IPv4, ip6tables to IPv6, arptables to ARP, and ebtables to Ethernet frames.\n\nWhen performing the audit, the output that should be shown is\n${bold}iptables-persistent/<version> [installed,automatic]\niptables/<version> [installed,automatic]${normal}\nto show that iptables packages are installed."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	apt list iptables iptables-persistent 2>/dev/null | grep installed

	if apt list iptables 2>/dev/null | grep -q "installed" && apt install iptables-persistent 2>/dev/null | grep -q "installed"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because iptables packages are not installed, which it does not meet the required criteria.\n\nA method of configuring and maintaining firewall rules is necessary to configure a Host Based Firewall.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to install ${bold}iptables${normal} and ${bold}iptables-persistent${normal}\n${bold}apt install iptables iptables-persistent${normal}\n\n2. Type 'Y' to complete the installation\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
     	# 3.5.3.1.2
elif [[ $section == "3.5.3.1.2" ]]; then
	benchmark_title="3.5.3.1.2 Ensure nftables is not installed with iptables (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}nftables${normal} is a subsystem of the Linux kernel providing filtering and classification of network packets/datagrams/frames and is the successor to iptables.\n\nWhen performing the audit, the output that should be shown is\n${bold}nftables	unknown ok not-installed	not-installed${normal}\nto show that nftables is not installed with iptables."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' nftables

	if ! dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' nftables 2>/dev/null | grep -q "installed"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because nftables is installed with iptables, which it does not meet the required criteria.\n\nRunning both ${bold}iptables${normal} and ${bold}nftables${normal} may lead to conflict.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to remove ${bold}nftables${normal}:\n${bold}apt purge nftables${normal}\n\n2. Type 'Y' to complete the uninstallation\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
	# 3.5.3.1.3
elif [[ $section == "3.5.3.1.3" ]]; then
	benchmark_title="3.5.3.1.3 Ensure ufw is uninstalled or disabled with iptables (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}${bold}Uncomplicated Firewall (UFW)${normal} is a program for managing a netfilter firewall designed to be easy to use. Uses a command-line interface consisting of a small number of simple commands and uses iptables for configuration.\n\nWhen performing the audit, the output that should be shown are\n${bold}nftables	unknown ok not-installed	not-installed${normal},\n${bold}Status: inactive${normal}\nand\n${bold}masked${normal}\nto show that ufw is uninstalled or disabled with iptables."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' ufw
	ufw status
	systemctl is-enabled ufw

	if ! dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' ufw 2>/dev/null | grep -q "installed" && ufw status | grep -q "Status: inactive" && systemctl is-enabled ufw | grep -q "masked"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ufw is installed or enabled with iptables, which it does not meet the required criteria.\n\nRunning iptables.persistent with ufw enabled may lead to conflict and unexpected results.\n\n${yellow}Remidation: ${normal}\n1. Run the following command to remove ${bold}ufw${normal}:\n${bold}apt purge ufw${normal}\n\n2. Type 'Y' to complete the uninstallation\n3. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
 	# 3.5.3.2.1
elif [[ $section == "3.5.3.2.1" ]]; then
	benchmark_title="3.5.3.2.1 Ensure iptables default deny firewall policy (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}A default deny all policy on connections ensures that any unconfigured network usage will be rejected.\n\nWhen performing the audit, the output should be shown as such:\n${bold}Chain INPUT (policy DROP)\nChain FORWARD (policy DROP)\nChain OUTPUT (policy DROP)${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	iptables -L

	if iptables -L INPUT | grep -E -q "policy (DROP|REJECT)" && iptables -L OUTPUT | grep -E -q "policy (DROP|REJECT)" && iptables -L FORWARD | grep -E -q "policy (DROP|REJECT)"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}iptables${normal} default did not deny firewall policy, which it does not meet the required criteria.\n\nWith a default accept policy the firewall will accept any packet that is not configured to be denied. It is easier to white list acceptable usage than to black list unacceptable usage.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to implement a default DROP policy:\n\n${bold}iptables -P INPUT DROP\niptables -P OUTPUT DROP\niptables -P FORWARD DROP${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
  	# 3.5.3.2.2
elif [[ $section == "3.5.3.2.2" ]]; then
	benchmark_title="3.5.3.2.2 Ensure iptables loopback traffic is configured (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure the loopback interface to accept traffic. Configure all other interfaces to deny traffic to the loopback network (127.0.0.0/8).\n\nWhen performing the audit, the output should be shown to be\n${bold}INPUT${normal} to ${bold}ACCEPT all lo${normal} and ${bold}DROP all 127.0.0.0/8${normal}\nwhile\n${bold}OUTPUT${normal} to ${bold}ACCEPT all lo${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	iptables -L INPUT -v -n
	iptables -L OUTPUT -v -n

	if iptables -L INPUT -v -n | grep -E -q "ACCEPT\s+all\s+--\s+lo\s+\*\s+0.0.0.0/0\s+0.0.0.0/0" && iptables -L OUTPUT -v -n | grep -E -q "ACCEPT\s+all\s+--\s+\*\s+lo\s+0.0.0.0/0\s+0.0.0.0/0" && iptables -L INPUT -v -n | grep -E -q "DROP\s+all\s+--\s+\*\s+\*\s+127.0.0.0/8\s+0.0.0.0/0"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}iptables${normal} loopback traffic is not configured properly, which it does not meet the required criteria.\n\nLoopback traffic is generated between processes on machine and is typically critical to operation of the system. The loopback interface is the only place that loopback network (127.0.0.0/8) traffic should be seen, all other interfaces should ignore traffic on this network as an anti-spoofing measure.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to implement the loopback rules:\n\n${bold}iptables -A INPUT -i lo -j ACCEPT\niptables -A OUTPUT -o lo -j ACCEPT\niptables -A INPUT -s 127.0.0.0/8 -j DROP${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
   	# 3.5.3.2.3
elif [[ $section == "3.5.3.2.3" ]]; then
	benchmark_title="3.5.3.2.3 Ensure iptables outbound and established connections are configured (Manual)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure the firewall rules for new outbound, and established connections.\n\nWhen performing the audit, the output should be shown to verify all rules for new outbound, and established connections match site policy."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	iptables -L -v -n

	if iptables -L -v -n | grep -E -q "(tcp|udp|icmp)\s+all\s+--\s+\*\s+\*\s+0.0.0.0/0\s+0.0.0.0/0\s+state\s+(NEW,ESTABLISHED|ESTABLISHED)"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}iptables${normal} outbound and established connections are not configured properly, which it does not meet the required criteria.\n\nIf rules are not in place for new outbound, and established connections all packets will be dropped by the default policy preventing network usage.\n\n${yellow}Remidation: ${normal}\n1. Configure iptables in accordance with site policy. The following commands will implement a policy to allow all outbound connections and all established connections:\n\n${bold}iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT\niptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT\niptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT\niptables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT\niptables -A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT\niptables -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
    	# 3.5.3.2.4
elif [[ $section == "3.5.3.2.4" ]]; then
	benchmark_title="3.5.3.2.4 Ensure iptables firewall rules exist for all open ports (Automated)"

	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Any ports that have been opened on non-loopback addresses need firewall rules to govern traffic.\n\nWhen performing the audit, the output should be shown to verify the determine open ports and firewall rules."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	ss -4tuln
	echo
	iptables -L INPUT -v -n

	if iptables -L INPUT -v -n | grep -q "(state NEW)"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}iptables firewall rules${normal} does not exist for all open ports, which it does not meet the required criteria.\n\nWithout a firewall rule configured for open ports default firewall policy will drop all packets to these ports.\n\n${yellow}Remidation: ${normal}\n1. For each port identified in the audit which does not have a firewall rule establish a proper rule for accepting inbound connections:\n\n${bold}iptables -A INPUT -p <protocol> --dport <port> -m state --state NEW -j ACCEPT${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
    	# 3.5.3.3.1
elif [[ $section == "3.5.3.3.1" ]]; then
	benchmark_title="3.5.3.3.1 Ensure ip6tables default deny firewall policy (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}CA default deny all policy on connections ensures that any unconfigured network usage will be rejected.\n\nWhen performing the audit, the output should be shown with\n${bold}Chain INPUT (policy DROP)\nChain FORWARD (policy DROP)\nChain OUTPUT (policy DROP)${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	ip6tables -L INPUT | grep "Chain INPUT (policy DROP)"
	ip6tables -L OUTPUT | grep "Chain OUTPUT (policy DROP)"
	ip6tables -L FORWARD | grep "Chain FORWARD (policy DROP)"

	if ip6tables -L INPUT | grep "Chain INPUT (policy DROP)" && ip6tables -L OUTPUT | grep "Chain INPUT (policy DROP)" && ip6tables -L FORWARD | grep "Chain INPUT (policy DROP)"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}ip6tables${normal} default did not deny firewall policy, which it does not meet the required criteria.\n\nWith a default accept policy the firewall will accept any packet that is not configured to be denied. It is easier to white list acceptable usage than to black list unacceptable usage.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to implement a default DROP policy:\n\n${bold}ip6tables -P INPUT DROP\nip6tables -P OUTPUT DROP\nip6tables -P FORWARD DROP${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
   	# 3.5.3.3.2
elif [[ $section == "3.5.3.3.2" ]]; then
	benchmark_title="3.5.3.3.2 Ensure ip6tables loopback traffic is configured (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure the loopback interface to accept traffic. Configure all other interfaces to deny traffic to the loopback network (::1).\n\nWhen performing the audit, the output should be shown to be\n${bold}INPUT${normal} to ${bold}ACCEPT all lo ::/0${normal} and ${bold}DROP all ::1${normal}\nwhile\n${bold}OUTPUT${normal} to ${bold}ACCEPT all lo ::/0${normal}."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	ip6tables -L INPUT -v -n
	ip6tables -L OUTPUT -v -n

	if ip6tables -L INPUT -v -n | grep -q "ACCEPT.*lo" && ip6tables -L OUTPUT -v -n | grep -q "ACCEPT.*lo" && ip6tables -L INPUT -v -n | grep -q "DROP.*::1"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}ip6tables${normal} loopback traffic is not configured properly, which it does not meet the required criteria.\n\nLoopback traffic is generated between processes on machine and is typically critical to operation of the system. The loopback interface is the only place that loopback network (::1) traffic should be seen, all other interfaces should ignore traffic on this network as an anti-spoofing measure.\n\n${yellow}Remidation: ${normal}\n1. Run the following commands to implement the loopback rules:\n\n${bold}ip6tables -A INPUT -i lo -j ACCEPT\nip6tables -A OUTPUT -o lo -j ACCEPT\nip6tables -A INPUT -s ::1 -j DROP${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
    	# 3.5.3.3.3
elif [[ $section == "3.5.3.3.3" ]]; then
	benchmark_title="3.5.3.3.3 Ensure ip6tables outbound and established connections are configured (Manual)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Configure the firewall rules for new outbound, and established IPv6 connections.\n\nWhen performing the audit, the output should be shown to verify all rules for new outbound, and established connections match site policy."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	ip6tables -L -v -n

	if ip6tables -L -v -n | grep -E -q "(tcp|udp|icmp)\s+all\s+--\s+\*\s+\*\s+0.0.0.0/0\s+0.0.0.0/0\s+state\s+(NEW,ESTABLISHED|ESTABLISHED)"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}ip6tables${normal} outbound and established connections are not configured properly, which it does not meet the required criteria.\n\nIf rules are not in place for new outbound, and established connections all packets will be dropped by the default policy preventing network usage.\n\n${yellow}Remidation: ${normal}\n1. Configure iptables in accordance with site policy. The following commands will implement a policy to allow all outbound connections and all established connections:\n\n${bold}ip6tables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT\nip6tables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT\nip6tables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT\nip6tables -A INPUT -p tcp -m state --state ESTABLISHED -j ACCEPT\nip6tables -A INPUT -p udp -m state --state ESTABLISHED -j ACCEPT\nip6tables -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi
 	echo "|--------------------------------------------------------------------------------------------------------|"
     	# 3.5.3.3.4
elif [[ $section == "3.5.3.3.4" ]]; then
	benchmark_title="3.5.3.3.4 Ensure ip6tables firewall rules exist for all open ports (Automated)"
	
	echo -e "\n${yellow}Title: ${normal}$benchmark_title"

	# Description
	echo -e "\n${yellow}Description: ${normal}Any ports that have been opened on non-loopback addresses need firewall rules to govern traffic.\n\nWhen performing the audit, the output should be shown to verify the determine open ports and firewall rules."

	# Output
	echo -e "\n${yellow}Output:${normal} ";
	ss -6tuln
	echo
	ip6tables -L INPUT -v -n

	if ip6tables -L INPUT -v -n | grep -q "(state NEW)"; then
		echo -e "\n${rednh}ERROR:${normal} This audit is executed correctly\n"
	else
		echo -e "\n${yellow}Compliance: ${rednh}FAIL\n\n${yellow}Explaination: ${normal}The compliance for this benchmark failed because ${bold}ip6tables firewall rules${normal} does not exist for all open ports, which it does not meet the required criteria.\n\nWithout a firewall rule configured for open ports default firewall policy will drop all packets to these ports.\n\n${yellow}Remidation: ${normal}\n1. For each port identified in the audit which does not have a firewall rule establish a proper rule for accepting inbound connections:\n\n${bold}ip6tables -A INPUT -p <protocol> --dport <port> -m state --state NEW -j ACCEPT${normal}\n\n2. Rerun the main.sh program to verify if it is compliant to the benchmark\n"
	fi

else
	exit 0
fi
