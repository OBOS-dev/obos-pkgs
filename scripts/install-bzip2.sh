# Thanks Astral

dest_dir=$1

make install DESTDIR=$dest_dir
cp -av libbz2.so.* ${dest_dir}/lib
ln -sv libbz2.so.1.0.8 ${dest_dir}/lib/libbz2.so
cp -v bzip2-shared ${dest_dir}/bin/bzip2
for i in ${dest_dir}/bin/{bzcat,bunzip2}; do
    ln -sfv bzip2 $i
done
rm -fv ${dest_dir}/lib/libbz2.a