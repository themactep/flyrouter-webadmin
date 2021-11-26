#!/bin/sh
s() { echo "<dl><dt>$1</dt>"; }
e() { echo "</dl>"; }
ss() { echo "<dd><dl><dt>$1</dt>"; }
se() { echo "</dl></dd>"; }
i() { echo "<dd>$1</dd>"; };

s "ssh"
i "<a href=\"?page=$page&do=ssh_ext\">Java SSH</a>";
i "<a href=\"http://kitty.9bis.com/\">Download KiTTy</a>";
i "<a href=\"http://the.earth.li/~sgtatham/putty/latest/x86/putty.exe\">Download PuTTY</a>";
e
s "help"
i "<a href=\"http://flyrouter.net/flyrouter:news\">News</a>";
i "<a href=\"http://flyrouter.net/flyrouter:help\">FAQ</a>";
e
s "links"
i "<a href=\"http://flyrouter.net/downloads/software/flyrouter/packages/\">Available packages</a>";
i "<a href=\"http://flyrouter.net/downloads/software/flyrouter/upgrade/\">Available firmware</a>";
e
