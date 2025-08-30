#/bin/bash
target_triplet=$1
compiler_prefix=$2

echo "[binaries]
c = '$compiler_prefix$target_triplet-gcc'
cpp = '$compiler_prefix$target_triplet-g++'
ar = '$target_triplet-ar'
windres = '$target_triplet-windres'
strip = '$target_triplet-strip'

[host_machine]
system = '${target_triplet##*-}'
cpu_family = '${target_triplet%-*}'
cpu = '${target_triplet%-*}'" > ../cross-file.txt

target_architecture=${target_triplet%%-*}

if [ $target_architecture = 'x86_64' ]
then
echo "endian = 'little'" >> ../cross-file.txt
elif [ $target_architecture = 'm68k' ]
then
echo "endian = 'big'" >> ../cross-file.txt
fi
