#!/bin/bash

function run() {
    [ -e "$1" ] && $2 $1 && echo
}

mkdir -p "$(dirname $LINGLONG_COMMAND)"
echo '#!/bin/bash' >$LINGLONG_COMMAND

run "./env.sh" source
run "./install_dep.sh"
run "./install_patch.sh"
run "./install_start.sh"
