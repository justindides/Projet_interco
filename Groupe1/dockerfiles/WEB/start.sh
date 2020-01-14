#!/bin/bash
ip addr flush dev eth1
ip addr add 120.0.27.2/24 dev eth1
ip route add 120.0.21.0/24 via 120.0.27.1

python3 -m http.server 8000
