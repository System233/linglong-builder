#!/bin/bash

NAME=patch_${1}.sh
if [ ! -e "$NAME" ]; then
    echo '#!/bin/bash' >"$NAME"
    chmod -v +x "$NAME"
    echo -e "\n./$NAME" | tee -a "./install_patch.sh"
    chmod +x "./install_patch.sh"

fi
