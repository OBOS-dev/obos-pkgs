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

old_pwd=$PWD
cd "$repo_directory/coreutils-9.5"
# "$repo_directory/coreutils-9.5/bootstrap" "--gnulib-srcdir=$repo_directory/gnulib" --no-git --force
autoreconf -fi
cd $old_pwd
"$repo_directory/coreutils-9.5/configure" "--prefix" "$prefix" "--host=$target_triplet" "CPPFLAGS=-DSLOW_BUT_NO_HACKS=1 -DUSE_STATVFS=1" "CFLAGS=-USE_STATVFS=1" "--$year2038status-year2038"
