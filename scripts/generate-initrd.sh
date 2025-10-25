#!/bin/bash
cd $2
tar -Hustar -cf "$1/obos/config/initrd.tar" *
