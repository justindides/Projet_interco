#!/bin/bash
ip addr flush dev eth0
ip addr flush dev eth1
ip addr add 120.0.21.1/24 dev eth0
ip addr add 120.0.23.2/24 dev eth1
