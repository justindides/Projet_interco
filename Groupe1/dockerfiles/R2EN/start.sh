#!/bin/bash
ip addr flush dev eth0
ip addr add 120.0.21.4/24 dev eth0
