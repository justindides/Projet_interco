#!/bin/bash

ip addr flush eth0
# Appel de dhcp pour récupérer une addresse. 
dhclient eth0
