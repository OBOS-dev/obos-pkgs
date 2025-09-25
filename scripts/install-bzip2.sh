# Thanks Astral

dest_dir=$1
prefix=$2

make install PREFIX=${dest_dir}/${prefix}
cp -av libbz2.so.* ${dest_dir}/${prefix}/lib
ln -sv libbz2.so.1.0.8 ${dest_dir}${prefix}/lib/libbz2.so
cp -v bzip2-shared ${dest_dir}/${prefix}/bin/bzip2
for i in ${dest_dir}/${prefix}/bin/{bzcat,bunzip2}; do
    ln -sfv bzip2 $i
done
rm -fv ${dest_dir}/${prefix}/lib/libbz2.a