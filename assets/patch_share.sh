#!/bin/bash

echo "ln -sf $PREFIX/share/* /usr/share 2>/dev/null" | tee -a $LINGLONG_COMMAND
