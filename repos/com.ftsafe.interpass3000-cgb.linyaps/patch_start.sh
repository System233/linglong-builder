#!/bin/bash
rm -r $PREFIX/arch/aarch64
FROM=/opt/apps/com.ftsafe.interpass3000-cgb/files/lib/libInterPass3000_CGB_p11_skf.so
TO='libInterPass3000_CGB_p11_skf.so.1.0.0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
grep -l $FROM $PREFIX -r|xargs  perl -i -pe "s#$FROM#$TO#g"
