#!/bin/bash
ip addr flush dev eth1
ip addr flush dev eth2
ip addr add 120.0.21.3/24 dev eth1
ip addr add 120.0.27.1/24 dev eth2
ip route add 120.0.23.0/24 via 120.0.21.1
