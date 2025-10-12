#!/usr/bin/bash
OLDWD=$PWD
cd $1
autoreconf -vfi
cd $OLDWD