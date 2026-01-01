#!/usr/bin/bash
repo_directory=$1
name=$2
version=$3
target_triplet=$4
prefix=$5
destdir=$6

arch=`echo $target_triplet | cut -d '-' -f 1`

$repo_directory/$name-$version/configure --arch=$arch --target-os=obos --prefix=$prefix --sysroot=$destdir --extra-cflags='-D_DEFAULT_SOURCE=1' --cc=$target_triplet-gcc --cxx=$target_triplet-g++ --ld=$target_triplet-gcc --enable-cross-compile --enable-gpl --enable-version3 --enable-nonfree --disable-static --enable-shared  --disable-debug --enable-libaom --enable-libass --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-openssl --enable-libdav1d --enable-libsvtav1
