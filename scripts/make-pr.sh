#!/bin/bash

source $(dirname $0)/setenv-pr.sh

if gh repo view $ORG_REPO; then
    if [ -d $APP_ID ]; then
        cd $APP_ID
        git pull
    else
        gh repo clone $ORG_REPO
        cd $APP_ID
    fi
else
    gh repo fork $REPO --org $ORG_ID --clone
    cd $APP_ID
fi

cp -r $SRC_REPO/* $SRC_REPO/.* .
rm -f .trigger
git add .
if git commit -m "初始化"; then
    git push
fi

PR_LIST=$(gh pr list)
if [ -z "$PR_LIST" ]; then
    gh pr create -f
fi
