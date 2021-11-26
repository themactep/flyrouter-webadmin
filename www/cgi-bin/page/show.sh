#!/bin/sh

cmd="$FORM_cmd"
[ -n "$FORM_params" ] && params="$FORM_params"

echo "<div id=\"out\"><pre id=\"code\">"
[ -n "$cmd" ] && $cmd
echo "</pre></div>"
