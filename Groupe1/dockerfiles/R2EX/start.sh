#!/bin/bash
ip addr flush dev eth0
ip addr add 120.0.21.3/24 dev eth0
