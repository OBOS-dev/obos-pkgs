#!/usr/bin/bash
OLDWD=$PWD
cd $1
autoupdate
autoreconf -vfi
cd $OLDWD