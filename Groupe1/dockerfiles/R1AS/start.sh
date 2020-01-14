#!/bin/bash
ip addr flush dev eth1
ip addr add 120.0.23.1/24 dev eth1
ip route add 120.0.21.0/24 via 120.0.23.2
ip route add 120.0.22.0/24 via 120.0.23.3
