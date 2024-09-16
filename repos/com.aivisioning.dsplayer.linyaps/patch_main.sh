#!/bin/bash

TARGET="$PREFIX/opt/com.aivisioning.dsplayer/files/main2/start.sh"
echo '#!/bin/bash'> $TARGET

echo "cd $PREFIX/opt/com.aivisioning.dsplayer/files/main2" | tee -a $TARGET
echo 'exec ./main2' | tee -a $TARGET

chmod +x "$TARGET"