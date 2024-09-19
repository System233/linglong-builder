#!/bin/bash
REPO=--repo=$HOME/.cache/linglong-builder/repo
ostree refs "$REPO" | grep -vP "deepin|foundation" | xargs -r ostree refs "$REPO" --delete
sudo ostree prune --repo=/var/lib/linglong/repo --refs-only
sudo ostree prune "--repo=$HOME/.cache/linglong-builder/repo" --refs-only
