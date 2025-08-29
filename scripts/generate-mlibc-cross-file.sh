#/bin/bash
target_triplet=$1
compiler_prefix=$2

echo "[binaries]
c = '$compiler_prefix-$target_triplet-gcc'
cpp = '$compiler_prefix-$target_triplet-g++'
ar = '$target_triplet-ar'
windres = '$target_triplet-windres'
strip = '$target_triplet-strip'

[host_machine]
system = '${target_triplet##*-}'
cpu_family = '${target_triplet%-*}'
cpu = '${target_triplet%-*}'
endian = 'little'
" > ../cross-file.txt
