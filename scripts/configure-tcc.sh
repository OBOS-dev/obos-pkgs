RET=$(pwd)
cd $1
./configure --prefix=$3 --cross-prefix=$2- --enable-cross
cd $RET
