#!/bin/bash
#
ipaddr=`ifconfig eth0 | awk '/inet addr:/{print $2}' | awk -F: '{print $2}'`
brctl addbr br0
ifconfig eth0 0 up
brctl addif br0 eth0
ifconfig br0 ${ipaddr}/16 up
brctl stp br0 on
