#!/usr/bin/bash
OLDWD=$PWD
cd $1
rm configure
autoreconf -fi
cd $OLDWD