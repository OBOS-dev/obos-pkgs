# Thanks Astral

dest_dir=$1
prefix=$2

make install PREFIX=$dest_dir
cp -av libbz2.so.* ${dest_dir}/lib
ln -sv libbz2.so.1.0.8 ${dest_dir}/lib/libbz2.so
cp -v bzip2-shared ${dest_dir}/bin/bzip2
for i in ${dest_dir}/bin/{bzcat,bunzip2}; do
    ln -sfv bzip2 $i
done
rm -fv ${dest_dir}/lib/libbz2.a
rm -f ${dest_dir}/bin/bzcmp ${dest_dir}/bin/bzless ${dest_dir}/bin/bzegrep ${dest_dir}/bin/bzfgrep
ln -s ${prefix}/bin/bzdiff ${dest_dir}/bin/bzcmp
ln -s ${prefix}/bin/bzmore ${dest_dir}/bin/bzless
ln -s ${prefix}/bin/bzgrep ${dest_dir}/bin/bzegrep
ln -s ${prefix}/bin/bzgrep ${dest_dir}/bin/bzfgrep
