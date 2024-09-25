#!/bin/bash

APP_ID=$(basename $(readlink -f .))
rm -r linglong/sources/* linglong/output ~/.cache/linglong-builder/layers/main/$APP_ID
ll-cli uninstall $APP_ID

ostree refs "--repo=$HOME/.cache/linglong-builder/repo" --delete $$APP_ID
