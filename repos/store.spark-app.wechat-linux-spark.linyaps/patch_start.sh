#!/bin/bash

echo -e "#!/bin/bash\n$PREFIX/files/wechat \$@" >$PREFIX/launch.sh
chmod -v +x $PREFIX/launch.sh
