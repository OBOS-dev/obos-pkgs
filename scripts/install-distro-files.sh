#!/usr/bin/bash
_mkdir()
{
    mkdir -p $1
    touch $1/.keep
}
cp -r $1/distro-files/* $2/
rm -f $2/bin
rm -f $2/sbin
rm -f $2/lib
rm -f $2/var/run
ln -s /usr/bin $2/bin
ln -s /usr/sbin $2/sbin
ln -s /usr/lib $2/lib
_mkdir "$2/var"
_mkdir "$2/var/lib"
_mkdir "$2/var/log"
_mkdir "$2/var/spool"
_mkdir "$2/var/lock"
_mkdir "$2/var/cache"
_mkdir "$2/var/tmp"
ln -s /run $2/var/run
_mkdir "$2/run"
_mkdir "$2/dev"
_mkdir "$2/tmp"
