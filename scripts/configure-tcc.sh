RET=$(pwd)
cd $1
./configure --prefix=/ --cross-prefix=$2- --enable-cross
cd $RET
