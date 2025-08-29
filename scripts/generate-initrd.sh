#!/bin/bash
cd $2/oboskrnl/tar
tar -Hustar -cf "$1/obos/config/initrd.tar" *
