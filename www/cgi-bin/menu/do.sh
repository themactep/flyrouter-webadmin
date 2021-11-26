#!/bin/sh
s() { echo "<dl><dt>$1</dt>"; }
e() { echo "</dl>"; }
ss() { echo "<dd><dl><dt>$1</dt>"; }
se() { echo "</dl></dd>"; }
i() { echo "<dd><a data-command=\"$2\">$1</a></dd>"; }

s "system"
ss "ipkg"
i "ipkg update" "/usr/bin/ipkg update"
i "ipkg list" "/usr/bin/ipkg list"
i "ipkg install" "/usr/bin/ipkg install PACKAGE"
se
i "flash save" "/sbin/flash save"
i "helpdesk" "/sbin/helpdesk"
i "nslookup" "/usr/bin/nslookup 127.0.0.1"
i "reboot" "/sbin/reboot"
i "upgrade" "/sbin/upgrade URL"
e
s "network"
i "arping" "/usr/bin/arping -I eth0 -c 3 127.0.0.1"
i "etherdump" "/usr/bin/etherdump --time 3 -i eth0"
i "ping" "/bin/ping -c 3 -s 100 127.0.0.1"
i "traceroute" "/usr/bin/traceroute -n 127.0.0.1"
[ -x /usr/sbin/tcpdump ] && i "tcpdump" "/usr/sbin/tcpdump -i eth0 -n & pid=\${!}; sleep 5; kill \$pid"
ifaces=`cat /etc/network/interfaces | grep ^iface | awk '{print $2}'`
ss "ifaces"
i "test: ifup -an" "/sbin/ifup -a -n"
for i in $ifaces; do
ss "$i"
i "ifup $i" "/sbin/ifup -v $i"
i "ifdown $i" "/sbin/ifdown -v $i"
i "restart $i" "/sbin/ifdown -v $i; /sbin/ifup -v $i"
se
done
se
ss "fw"
i "restart fw" "/etc/network/fw"
ss "iptables"
i "iptables -nvxL" "/usr/sbin/iptables -nvxL"
i "disable fw" "/usr/sbin/iptables -P INPUT ACCEPT; /usr/sbin/iptables -P FORWARD ACCEPT; /usr/sbin/iptables -F; /usr/sbin/iptables -X"
se
se
ss "bridge"
i "brctl addbr" "/usr/sbin/brctl addbr BRIDGE"
i "brctl addif" "/usr/sbin/brctl addif BRIDGE DEV"
i "brctl showmacs" "/usr/sbin/brctl showmacs BRIDGE"
i "brctl delif" "/usr/sbin/brctl delif BRIDGE DEV"
i "brctl delbr" "/usr/sbin/brctl delbr BRIDGE"
se
ss "ip"
ss "addr"
i "add" "/bin/ip addr add IPADDR/MASK dev IFACE"
i "del" "/bin/ip addr del IPADDR/MASK dev IFACE"
i "list" "/bin/ip addr list"
se
ss "link"
i "list" "/bin/ip link list"
i "set up" "/bin/ip link set DEV up"
i "set down" "/bin/ip link set DEV down"
i "set mtu" "/bin/ip link set DEV mtu 1400"
se
ss "route"
i "add gw" "/bin/ip route add NET/MASK via GW"
i "add dev" "/bin/ip route add NET/MASK dev DEV"
i "list" "/bin/ip route list"
i "list table" "/bin/ip route list table TABLE"
i "del" "/bin/ip route del NET/MASK"
se
ss "rule"
i "add from" "/bin/ip rule add from NET/MASK table TABLE"
i "add dev" "/bin/ip rule add dev DEV table TABLE"
i "list" "/bin/ip rule list"
se
ss "neigh"
i "flush" "/bin/ip neigh flush dev DEV"
i "list" "/bin/ip neigh list"
se
se
ss "tc"
i "action" "/usr/sbin/tc -s action"
i "class" "/usr/sbin/tc -s class"
i "filter" "/usr/sbin/tc -s filter"
i "qdisc" "/usr/sbin/tc -s qdisc"
se
e
s "software"
if [ -d /etc/bluetooth ]; then
ss "bluepoint"
#i "devices" "bluepoint_devices"
#i "log" "bluepoint_log"
se
fi
if [ -x /usr/bin/mpcs ]; then
ss "mpcs"
#i "status" "mpcs_status"
#i "log" "mpcs_log"
se
fi
e
