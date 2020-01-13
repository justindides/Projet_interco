#!/bin/bash
#sed -i 's/""/"eth1"/g' etc/default/isc-dhcp-server

# Config du fichier isc-dhcp-server pour avoir le service sur eth1
echo INTERFACES=\"eth1\" > ../etc/default/isc-dhcp-server

# COnfig de dhcp.conf
echo -e "default-lease-time 3600;
max-lease-time 7200;
authoritative;

subnet 192.168.1.0 netmask 255.255.255.0 {
range 192.168.1.2 192.168.1.125;
#option domain-name-servers 120.6.251.196;
#option routers 192.168.105.1;
}" > ../etc/dhcp/dhcpd.conf

#Attribution des ses addresses ip
ip addr flush dev eth0
ip addr add 120.0.26.2/24 dev eth0
ip addr flush dev eth1
ip addr add 192.168.1.1/24 dev eth1

#Lancement de DHCP
service isc-dhcp-server start

#echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
