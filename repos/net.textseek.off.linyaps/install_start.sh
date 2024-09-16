#!/bin/bash
# generated by ll-helper

echo Setting Application Entrypoint

PATCH_APP_PATH="s#/opt/apps/\S+/files#${PREFIX}#g"
PATCH_USR_PATH="s#/usr#$PREFIX#g"

DESKTOP_LIST=$(dpkg --contents linglong/sources/$LINGLONG_RAW_ID*.deb|grep -oP "[^\/]+.desktop$"|paste -sd :)

while read FILE;do
    NAME=`basename "$FILE"`
    DIR=`dirname "$FILE"`
    NAME_NO_EXT=${NAME%.*}

    if  [[ ! ":$DESKTOP_LIST:" == *":$NAME:"* ]];then
        rm -v "$FILE"
        continue
    fi

    TO="$PREFIX/share/applications/${LINGLONG_APP_ID}_$NAME_NO_EXT.desktop"
    mv -v "$FILE" "$TO"
done <<< `find "$PREFIX/share/applications/" -name "*.desktop"`


STARTUP=$(cat $PREFIX/share/applications/*.desktop | grep '^Exec=' | head -n 1 | sed 's/^Exec=//g' | xargs -n 1 echo 2>/dev/null | head -n 1)
REBASED_STARTUP=$(echo $STARTUP | sed -E -e "$PATCH_APP_PATH" -e "$PATCH_USR_PATH")
REBASED_STARTUP_RAW=$REBASED_STARTUP

PATCH_STARTUP="s#$REBASED_STARTUP#$LINGLONG_COMMAND#"

if [ ! -e "$REBASED_STARTUP" ];then
    if  [ -e "$PREFIX/$REBASED_STARTUP" ];then
        REBASED_STARTUP="$PREFIX/$REBASED_STARTUP"
        echo "Try $REBASED_STARTUP"
    fi
    if  [ ! -e "$REBASED_STARTUP" ];then
        REBASED_STARTUP=$(find $PREFIX -type f -executable -name "$(basename "$REBASED_STARTUP")"|head -n1)
        echo "Try $REBASED_STARTUP"
    fi

    if  [ ! -e "$REBASED_STARTUP" ];then
        echo "Error: $REBASED_STARTUP does not exists." >&2
        REBASED_STARTUP=$REBASED_STARTUP_RAW
    fi
fi


echo STARTUP: ${STARTUP}
echo REBASED_STARTUP: ${REBASED_STARTUP}
echo BOOT: ${LINGLONG_COMMAND}


sed -i -E $PREFIX/share/applications/*.desktop -e "/Exec=/ $PATCH_APP_PATH" -e "/Exec=/ $PATCH_USR_PATH" -e "/Exec=/ $PATCH_STARTUP" 
perl -pe "s#/opt/(?!apps)#$PREFIX/opt/#g" -i $PREFIX/share/applications/*.desktop

if [ "$STARTUP" != "sh" ];then
    if od "$REBASED_STARTUP" -An -N2 -tx2 | grep -q "2123"; then
        echo Patch Script: ${STARTUP}
        sed -i -E -e "$PATCH_APP_PATH" "$REBASED_STARTUP"
    fi
fi

echo "exec ${REBASED_STARTUP} \$@" >>$LINGLONG_COMMAND
chmod -v +x $LINGLONG_COMMAND
