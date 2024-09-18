#!/bin/bash
$(grep -oP "Exec=.*--\s*\K.*$" /opt/apps/*/files/share/applications/*.desktop|sed 's#%\w##g'|xargs)
