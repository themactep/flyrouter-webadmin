#!/bin/sh

cmd="$FORM_cmd"

cat <<EOT
<p id="cmd"><b>~#</b><input type="text" value="$cmd" autofocus><button>⏎</button></p>
<pre id="code">
EOT
#if [ "$REQUEST_METHOD = POST" -a -n "$cmd" ]; then
#  echo $REQUEST_METHOD
#  [ -n "$FORM_params" ] && params="$FORM_params"
#  echo "[$(whoami)@$(hostname) ~]# $cmd"
#  cd "$HOME"
#  eval "${cmd}"
#fi
echo "</pre>"
