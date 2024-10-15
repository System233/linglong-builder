#!/bin/bash

set -e
APP_ID=$1

if [ -z "$APP_ID" ]; then
    echo 参数错误：$0 "[APP_ID]" >&2
    exit 1
fi
SRC_REPO=$(readlink -f repos/$APP_ID)

if [ ! -d $SRC_REPO ]; then
    echo 路径不存在：$SRC_REPO
    exit 1
fi

REMOTE_BRANCH=main
REMOTE=upstream/$APP_ID
PATCH=repos/$APP_ID
REPO=linglongdev/$APP_ID
ORG_ID=linyaps-lab
ORG_REPO=$ORG_ID/$APP_ID

mkdir rsync | true
cd rsync
