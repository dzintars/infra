#!/bin/sh

# Author: Dzintars Klavins
# This script will setup bridge connection to enable KVM bridge networking
# Before runing, delete all devices and connections
# nmcli connection delete <connection-name>
# nmcli device delete <device-name>
# Don't forget to make this file executable

export NETWORK_ETHERNET_DEVICE="eno1"
export NETWORK_ETHERNET_CONNECTION="eno1"
export NETWORK_BRIDGE_CONNECTION="virbr0"
export NETWORK_GW_ADDRESS="192.168.1.1"
export NETWORK_IP_ADDRESS="192.168.1.2"
export NETWORK_DNS_ADDRESES="192.168.1.254,1.1.1.1"

# General cleanup

# # Delete all existing connections
# for i in `nmcli c | \
# grep -o -- "[0-9a-fA-F]\{8\}-[0-9a-fA-F]\{4\}-[0-9a-fA-F]\{4\}-[0-9a-fA-F]\{4\}-[0-9a-fA-F]\{12\}"` ; \
# do nmcli connection delete uuid $i ; \
# done

# # Delete all devices (optional/not sure)
# for i in `nmcli d | \
# grep -o -- "[0-9a-fA-F]\{8\}-[0-9a-fA-F]\{4\}-[0-9a-fA-F]\{4\}-[0-9a-fA-F]\{4\}-[0-9a-fA-F]\{12\}"` ; \
# do nmcli device delete uuid $i ; \
# done

# Create new bridge connection
nmcli connection add type bridge autoconnect yes con-name ${NETWORK_BRIDGE_CONNECTION} ifname ${NETWORK_BRIDGE_CONNECTION}
# Modify bridge connection properties
nmcli connection modify ${NETWORK_BRIDGE_CONNECTION} ipv4.address ${NETWORK_IP_ADDRESS}/24
nmcli connection modify ${NETWORK_BRIDGE_CONNECTION} ipv4.method manual
nmcli connection modify ${NETWORK_BRIDGE_CONNECTION} ipv4.gateway ${NETWORK_GW_ADDRESS}
nmcli connection modify ${NETWORK_BRIDGE_CONNECTION} ipv4.dns ${NETWORK_DNS_ADDRESES}
# Bring bridged connection up
nmcli connection up ${NETWORK_BRIDGE_CONNECTION}
# Add slave for bridged connection
nmcli connection add type bridge-slave autoconnect yes con-name ${NETWORK_ETHERNET_CONNECTION} ifname ${NETWORK_ETHERNET_DEVICE} master ${NETWORK_BRIDGE_CONNECTION}
nmcli connection reload
# Bring up slave connection
nmcli connection down ${NETWORK_ETHERNET_CONNECTION} && nmcli connection up ${NETWORK_ETHERNET_CONNECTION}
# View bridge details
nmcli connection show ${NETWORK_BRIDGE_CONNECTION}
# ping google.com
# Ping will not work immediately!
