#!/bin/bash

APP_ID=$(basename $(readlink -f .))
LL_DIR='/var/lib/linglong/entries'

function log_error() {
    echo -e "\033[31mError: $@ \033[0m"
}

while read desktop; do
    while read icon; do
        found=$(find "$LL_DIR/share/icons" -path "$LL_DIR/share/icons/*/apps/*" \( -name "${icon}.png" -o -name "${icon}.svg" \) -print -quit)
        if [ ! -e "$found" ]; then
            log_error "$desktop: Icon not found: $icon"
        else
            echo "[Icon OK] $icon"
        fi
    done <<<$(grep -oP "^Icon.*?=\K.*$" "$desktop")

    while read cmd; do
        eval "CMDLINE=($cmd)"
        MAIN=${CMDLINE[0]}
        if ! ll-builder run --exec "which '${MAIN}'" >/dev/null; then
            log_error "$desktop: Exec not found: main=$MAIN, cmd=$cmd"
        else
            echo "[CMD OK] $cmd"
        fi
    done <<<$(grep -oP "^Exec.*?=.*?--\s*\K.*$" "$desktop")
done <<<$(find "${LL_DIR}/share/applications" -name "${APP_ID}*.desktop")
