#!/bin/sh

i() { echo "<dt>$1</dt><dd>$2</dd>"; }
m() { cat /proc/meminfo | grep "$1" | awk '{print $2 " " $3}'; }

echo "<h2>"
cat /etc/banner
echo "</h2>"

echo "<dl class='lines'>"
i "Hostname:" $(hostname)
i "CPU:" $(uname -m)
i "Uptime:" $(uptime)
i "CPU usage:" $(/sbin/cpu)
i "Total memory:" $(m MemTotal)
i "Free memory:" $(m MemFree)
i "Cached memory:" $(m ^Cached)
i "Buffers:" $(m Buffers)
echo "</dl>"
