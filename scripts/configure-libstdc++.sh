#!/bin/bash
cd $1/libstdc++-v3/
rm aclocal.m4
rm ../config/override.m4
autoreconf