#!/bin/sh
s() { echo "<dl><dt>$1</dt>"; }
e() { echo "</dl>"; }
ss() { echo "<dd><dl><dt>$1</dt>"; }
se() { echo "</dl></dd>"; }
i() { echo "<dd><a data-command=\"$2\">$1</a></dd>"; }

s "system"
i "date" "/bin/date"
i "df" "/bin/df -h"
i "free" "/usr/bin/free"
i "ipkg list" "/usr/bin/ipkg list"
i "ipkg list_installed" "/usr/bin/ipkg list_installed"
i "lsmod" "/sbin/lsmod"
i "mount" "/bin/mount"
i "ps" "/bin/ps"
i "sysctl" "/sbin/sysctl -a"
i "uname -a" "/bin/uname -a"
ss "log"
i "main log" "/sbin/logread"
i "kernel log" "/bin/dmesg"
se
e
s "network"
i "switch" "cat /proc/sys/net/adm5120sw/status"
i "active interfaces" "/sbin/ifconfig"
i "all interfaces" "/sbin/ifconfig -a"
i "connection tracking" "cat /proc/net/ip_conntrack"
i "interface usage" "/usr/bin/bwm --one"
ss "firewall"
ss "filter"
i="/usr/sbin/iptables -nvxL"
i "all" "$i"
i "INPUT" "$i INPUT"
i "OUTPUT" "$i OUTPUT"
i "FORWARD" "$i FORWARD"
i "ACCOUNT-SRC" "$i ACCOUNT-SRC"
i "ACCOUNT-DST" "$i ACCOUNT-DST"
se
ss "nat"
i="/usr/sbin/iptables -t nat -nvxL"
i "all" "$i"
i "PREROUTING" "$i PREROUTING"
i "POSTROUTING" "$i POSTROUTING"
i "OUTPUT" "$i OUTPUT"
se
ss "mangle"
i="/usr/sbin/iptables -t mangle -nvxL"
i "all" "$i"
i "PREROUTING" "$i PREROUTING"
i "INPUT" "$i INPUT"
i "FORWARD" "$i FORWARD"
i "OUTPUT" "$i OUTPUT"
i "POSTROUTING" "$i POSTROUTING"
se
se
ss "ip"
i "addr" "/bin/ip addr"
i "link" "/bin/ip -s link"
i "route" "/bin/ip route"
i "rule" "/bin/ip rule"
i "neigh" "/bin/ip -s neigh"
i "tunnel" "/bin/ip -s tunnel"
i "maddr" "/bin/ip -s maddr"
i "mroute" "/bin/ip -s mroute"
se
ss "netstat"
i "all sockets" "/bin/netstat -an"
i "listening sockets" "/bin/netstat -ln"
i "routing" "/bin/netstat -rn"
se
ss "bridge"
i "show" "/usr/sbin/brctl show"
se
e
s "software"
if [ -d /etc/bluetooth ]; then
ss "bluepoint"
i "devices" "$basedir/cmd/bluepoint_devices"
i "log" "$basedir/cmd/bluepoint_log"
se
fi
if [ -x /usr/bin/mpcs ]; then
ss "mpcs"
i "status" "$basedir/cmd/mpcs_status"
i "log" "$basedir/cmd/mpcs_log"
se
fi
e
