#!/usr/bin/bash
repo_directory=$1
name=$2
version=$3
target_triplet=$4
prefix=$5

arch=`echo $target_triplet | cut -d '-' -f 1`

CROSS=$target_triplet- ${repo_directory}/${name}-${version}/configure --target=generic-gnu --prefix=${prefix} --disable-static --enable-shared