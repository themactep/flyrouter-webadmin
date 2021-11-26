#!/bin/sh

filename="${FORM_filename:-none}"
text="${FORM_text}"

# . /bin/midge_functions

if [ "$REQUEST_METHOD" = "POST" -a -n "$filename" -a -n "$FORM_text" ]; then
	echo "<h3>Saving...</h3>"
	pre_edit_file "$filename"
	# [ -r "${filename}" ] && cp "${filename}" "${filename}.bak"
	echo -n "$FORM_text" | dos2unix >"$filename"
fi

if [ -n "$filename" -a "$filename" != "none" ]; then
	# [ -r "${filename}" ] && $(content=cat $filename)
	cat <<EOT
<h3>Edit ${filename}</h3>
<form action="$SCRIPT_NAME" method="POST">
<input type="hidden" name="filename" value="$filename">
<input type="hidden" name="page" value="$page">
<textarea name="text" cols="90" rows="30" wrap="off" spellcheck="false">$content</textarea>
<input type="submit" value="Save">
</form>
EOT
fi
