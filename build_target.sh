#!/bin/bash

for pkg in $@;do
    ROOT=repos/${pkg}
    if [ -e "${ROOT}/linglong.yaml" ];then
        date +%Y%m%d%H%M%S >"${ROOT}/.trigger"
    else
        echo Skip ${pkg}
    fi
done
