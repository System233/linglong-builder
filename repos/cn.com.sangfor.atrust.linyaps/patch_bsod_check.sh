#!/bin/bash

echo Patch bsod_checker.js
sed -i -e 's#,err#,new Error("finally Error")#g' "$PREFIX/share/sangfor/aTrust/resources/app/src/service/bsod_checker.js"