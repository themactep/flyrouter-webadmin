#!/bin/sh

confirmed="${FORM_confirmed}"

case "$FORM_do" in
	flash_save)
		if [ $REQUEST_METHOD = POST -a "x${confirmed}x" = x1x ]; then
			echo "<h3>Saving...</h3>"
			echo "<pre>"
			/sbin/flash save
			echo "</pre>"
		else
			cat <<EOT
<h3>Do you really want to save?</h3>
<form action="$SCRIPT_NAME" method="POST">
<input type=hidden name="confirmed" value="1">
<input type=hidden name="do" value="flash_save">
<input type=hidden name="page" value="$page">
<input type=submit value="Yes">
<input type=reset value="No">
</form>
EOT
		fi
		;;
	backup_startup)
		cat <<EOT
<form action="/cgi-bin/config.cgi" method="POST">
<input type=hidden name="action" value="backup_startup">
<input type=submit value="Backup">
</form>
EOT
		;;
	backup_running)
		cat <<EOT
<form action="/cgi-bin/config.cgi" method="POST">
<input type=hidden name="action" value="backup_running">
<input type=submit value="Backup">
</form>
EOT
		;;
	restore)
		cat <<EOT
<form action="/cgi-bin/config.cgi" method="POST" enctype="multipart/form-data">
<input type=hidden name="action" value="restore">
<input type=file name=uploadfile>
<input type=submit value="Restore">
</form>
EOT
		;;
esac
