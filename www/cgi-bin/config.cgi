#!/usr/bin/haserl --upload-limit=4096 --upload-dir=/tmp
<%
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin
action=$FORM_action
uploadfile=$FORM_uploadfile
. /etc/midge.conf

case $action in
  backup_*)
    echo "Content-type: application/octet-stream"
    echo "Content-Disposition: attachment; filename=\"`hostname`-${action}-`date +%Y%m%d%H%M`.tar.gz\"\r\n"
    case $action in
      "backup_startup")
        dd if=$DATAFS_PARTITION 2>/dev/null | gunzip | gzip
        ;;
      "backup_running")
        tar czf - `cat $SAVE_LIST` 2>/dev/null
        ;;
      esac
        ;;

  restore)
    echo "Content-type: text/html\r\n"
    echo "<!DOCTYPE html><html><body>"
    if [ -r $uploadfile ]; then
      header=`hexdump $uploadfile | head -n 1 | awk '{print $2}'`
      if [ "$header" != 8b1f ]; then
        echo "<h1>Error: not tar.gz a file.</h1>"
      else
        fsize="`wc -c $uploadfile | awk '{print $1}'`"
        if [ $fsize -gt "$DATAFS_PARTITION_SIZE" ]; then
          echo "<h1>Error: file is larger than config partition.</h1>"
        else
          if tar tzf $uploadfile | grep ^etc/midge.conf >/dev/null 2>/dev/null; then
            if dd if=$uploadfile of=$DATAFS_PARTITION 2>/dev/null; then
              ok=1
              echo "<h1>Done</h1><h2>Please reboot!</h2>"
            else
              echo "<h1>Error: writing to flash failed.</h1>"
            fi
          else
            echo "<h1>Error: corrupted file.</h1>"
          fi
        fi
      fi
    else
      echo "<h1>Error: file not found.</h1>"
    fi
    [ $ok ] && echo "<script>setTimeout('window.location=\"/\"',3000);</script>"
    echo "</body></html>"
    rm $uploadfile
    ;;
esac
%>
