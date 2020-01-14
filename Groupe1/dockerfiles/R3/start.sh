#!/bin/bash
ip addr flush dev eth1
ip addr flush dev eth2
ip addr add 120.0.23.3/24 dev eth1
ip addr add 120.0.22.1/24 dev eth2
ip route add 120.0.21.0/24 via 120.0.23.2
# à décommenter au besoin
# route vers le réseau de box1
# ip route add 120.0.30.0/24 via 120.0.22.4
# route vers le réseau de box2
# ip route add 120.0.31.0/24 via 120.0.22.3
