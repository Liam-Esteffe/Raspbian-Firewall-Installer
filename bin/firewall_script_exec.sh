#!/bin/sh

iptables -F

# WHITELIST MODE

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# ALLOW PING FOR EVERYWONE

iptables -A FORWARD -p tcp --dport 80 -j ACCEPT

# ALLOW HTTP/HTTPS for Wifi client

iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -p tcp --dport 443 -j ACCEPT

# ALLOW POP/IMAP/SMTP for Wifi client
iptables -A FORWARD -p tcp --dport 25 -j ACCEPT
iptables -A FORWARD -p tcp --dport 110 -j ACCEPT
iptables -A FORWARD -p tcp --dport 993 -j ACCEPT

# ALLOW PING FOR Wifi client

iptables -A FORWARD -p icmp -j ACCEPT

# persist the rules

iptables-save > /etc/iptables/rules.v4