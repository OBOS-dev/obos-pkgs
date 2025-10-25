#!/bin/bash
cp -r $1/distro-files/* $2/
rm $2/bin
rm $2/sbin
rm $2/lib
ln -s /usr/bin $2/bin
ln -s /usr/sbin $2/sbin
ln -s /usr/lib $2/lib
mkdir -p $2/tmp