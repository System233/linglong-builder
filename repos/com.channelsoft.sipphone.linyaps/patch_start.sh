#!/bin/bash

echo '#!/bin/bash' >$PREFIX/RunCPFCcodSipPhone.sh
echo "exec $PREFIX/CPFCcodSipPhone" | tee -a $PREFIX/RunCPFCcodSipPhone.sh

chmod +x $PREFIX/RunCPFCcodSipPhone.sh