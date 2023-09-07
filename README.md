# Autodits
TAKE NOTE: For the remediation feature, it only covers section 4 and 6 of the CIS benchmark, thank you :)

This is the source code for my group's tool named Autodits. This is an automated audit tool for Linux.

Linux Distribution:
The system is built upon the Ubuntu Linux Server version 22.04.2 (ubuntu-22.04.2-live-server-amd64.iso).

Benchmark Used:
The compliance checks are based on the CIS Ubuntu Linux 22.04 LTS Benchmark v1.0.0, ensuring that the system adheres to industry-standard security and configuration guidelines. This benchmark serves as a reliable reference for evaluating the system's alignment with established best practices.

NOTE: To avoid errors/disruption, all files should be in the same directory!
Before using the source code, please install nodejs on your own Linux Distribution
Command: apt install nodejs

To start the web browser/GUI, run this command in your linux terminal:
Command: node server.js

Please install a web browser in order to access the GUI/Tool:
apt install <browser>

On the web browser type in this URL: http://localhost:3000/

SH Files:
The "SH Files" are sets of special scripts that check if things are up to standard. They also have fixes for things that aren't right. The file includes compliance check scripts, failed sections scripts and remediation scripts.

HTML Files:
"HTML Files" are like building blocks for the website, making it look good and work well alongside the scripts.

Server Files:
"Server.js" is the brain behind the scenes. It handles requests and keeps everything running smoothly on the website.

