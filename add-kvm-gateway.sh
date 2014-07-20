#!/usr/bin/env bash
#
# Update resolv.conf with qemu-kvm gateway IP
#

GATEWAY='192.168.122.1'
nameserver_file='/etc/resolv.conf'

if head -n 1 ${nameserver_file} | grep -i "nameserver ${GATEWAY}" >/dev/null; then
    echo "Gateway IP (${GATEWAY}) already present!"
else
    if [ "$(whoami)" = 'root' ]; then
        resolv_conf="$(cat "${nameserver_file}")"
        echo "nameserver ${GATEWAY}" > "${nameserver_file}"
        echo "${resolv_conf}" >> "${nameserver_file}"
        echo "Qemu-kvm gateway IP (${GATEWAY}) added in ${nameserver_file}"
    else
        echo "$0: Need to be root"
        echo "    Try sudo: 'sudo $0'"
        exit 1
    fi
fi
