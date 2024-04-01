# #!/bin/bash

# Script defines commands that are run by proxmox on boot

sleep 10
/sbin/iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-ports 8006
# modprobe alx ## optional, specify if alx ethernet drivers are needed
sysctl -w vm.swappiness=1
