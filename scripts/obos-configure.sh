#!/bin/bash
export target_triplet="$1"
rm -rf *
touch $2/config/initrd.tar
cmake \
-B . \
--toolchain=$2/src/build/${target_triplet%%-*}/toolchain.cmake \
-DCMAKE_BUILD_TYPE=RelWithDebInfo \
-DOBOS_USE_OBOS_GCC=1 \
-DOBOS_COMPILE_USER_EXAMPLES=1 \
-DOBOS_ENABLE_UBSAN=ON \
-S$2 -GNinja
if [ $target_triplet = 'x86_64-obos' ]
then
    chmod +x ${repo_directory}/obos/dependencies/hyper/hyper_install-linux-x86_64
fi
