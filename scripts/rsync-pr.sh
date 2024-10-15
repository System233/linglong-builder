#!/bin/bash

source $(dirname $0)/setenv-pr.sh

if [ -d $APP_ID ]; then
    git pull
else
    gh repo clone $ORG_REPO
fi

cd $APP_ID

cp -r $SRC_REPO/* $SRC_REPO/.* .
rm -f .trigger
git add .
if git commit -m "$2"; then
    git push
fi
