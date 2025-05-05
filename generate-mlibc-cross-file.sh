#/bin/bash
target_triplet=$1
compiler_prefix=$2
echo "[binaries]
c = '$compiler_prefix-gcc'
cpp = '$compiler_prefix-g++'
ar = '$compiler_prefix-ar'
windres = '$compiler_prefix-windres'
strip = '$compiler_prefix-strip'

[host_machine]
system = '${target_triplet##*-}'
cpu_family = '${target_triplet%-*}'
cpu = '${target_triplet%-*}'
endian = 'little'
" > cross-file.txt
