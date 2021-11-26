#!/usr/bin/haserl
Content-type: text/html

<%
basedir=$(pwd)
page=${FORM_page:-info}
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>FlyRouter</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="shortcut icon" href="/favicon.ico">
<link type="text/css" rel="stylesheet" href="/main.css">
<script src="/main.js"></script>
</head>
<body>
<header>
<h1><a href="/"><% echo -n $(whoami)@$(hostname) %></a></h1>
</header>
<nav>
<% for a in info show edit do config misc; do %>
<a href="?page=<% echo -n "$a" %>"<% [ "$page" = "$a" ] && echo -n " class=on" %>><% echo -n "$a" %></a>
<% done %>
<label id="refresh"><input type="checkbox" id="autocmd"> auto-refresh</label>
</nav>
<main>
<aside>
<% [ -f "$basedir/menu/${page}.html" ] && cat "$basedir/menu/${page}.html" %>
<% [ -x "$basedir/menu/${page}.sh" ] && . "$basedir/menu/${page}.sh" %>
</aside>
<article>
<div>
<% [ -n "$header" ] && echo "<h2>$header</h2>" %>
<% [ -x "${basedir}/page/$page.sh" ] && . ${basedir}/page/${page}.sh %>
</div>
</article>
</main>
<footer>
<p><a href="http://flyrouter.net/">flyrouter.net</a></p>
</footer>
</body>
</html>
