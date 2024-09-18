#!/bin/bash

NAME=patch_${1}.sh
if [ ! -e "$NAME" ];then
    echo '#!/bin/bash'> "$NAME"
    chmod -v +x "$NAME"
    echo "./$NAME" >> "./install_patch.sh"

fi