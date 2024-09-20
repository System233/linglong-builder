#!/bin/bash

echo -e "#!/bin/bash\nexec $PREFIX//himirage \$@"> $PREFIX/himirage.sh  
chmod +x $PREFIX/himirage.sh  
