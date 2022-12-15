#!/bin/sh

echo 'Firewall installer on Raspberry Pi Linux Raspbian'

echo 'This script will install and configure the firewall'

# Install the firewall depictions

if [ $1 -eq 'install' ]; then

echo 'Installing the firewall'

sudo apt-get install iptables-persistent

cd /opt

sudo git clone https://github.com/unixabg/RPI-Wireless-Hotspot.git

cd RPI-Wireless-Hotspot

sudo ./install

# Choose DNS prefetching and OPENDNS and not enable Unblock-US

else

echo 'Configure the firewall'

# Flush the rules

sudo iptables -F

# Add DROP rules for iptables HTTP will be disabled
# To delete the rule write up : sudo iptables -D FORWARD -p tcp --dport 80 -j DROP

sudo iptables -A FORWARD -p tcp --dport 80 -j DROP


# Here we configure the basic rules for the firewall

# Allow all traffic on the loopback interface

sudo iptables -A INPUT -i lo -j ACCEPT

sudo iptables -A OUTPUT -o lo -j ACCEPT

# Allow all traffic on the internal network

sudo iptables -A INPUT -s



# DNS SERVER

sudo apt install bind9

sudo mv /etc/bind/named.conf.options /etc/bind/named.conf.options.old

# write the following file into /etc/bind/named.conf.options

echo 

"
acl "localnetwork" { 127.0.0.1/32; 192.168.42.0/24; };
options {
    directory "/var/cache/bind";
    forwarders {
        208.67.222.222;
    };
    allow-query { localnetwork; };
    dnssec-validation auto;
    auth-nxdomain no; # conform to RFC1035
    listen-on-v6 { any; };
};
" >> /etc/bind/named.conf.options

sudo service bind9 restart

# replace 'opt dns 208.67.222.222 208.67.220.220' by 'opt dns 192.168.42.1' in /etc/dhcpcd.conf

fi



