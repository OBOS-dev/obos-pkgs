#!/bin/bash
repo_directory=$1
prefix=$2
target_triplet=$3
target_architecture=${target_triplet%%-*}

if [ $target_architecture = 'x86_64' ]
then
    year2038status=enable
elif [ $target_architecture = 'm68k' ]
then
    year2038status=disable
fi

"$repo_directory/tar-1.35/configure" "--prefix" "$prefix" "--host=$target_triplet" "--$year2038status-year2038"
