#!/bin/sh
s() { echo "<dl><dt>$1</dt>"; }
e() { echo "</dl>"; }
ss() { echo "<dd><dl><dt>$1</dt>"; }
se() { echo "</dl></dd>"; }
i() { echo "<dd><a href=\"?page=config&do=$2\">$1</a></dd>"; }

s "config"
i "flash save" "flash_save"
i "backup startup" "backup_startup"
i "backup running" "backup_running"
i "restore" "restore"
e
