#!/usr/bin/bash
$2/$4-$5/configure \
    --host=$3 \
    --disable-pciaccess \
    --disable-ipv6 \
    --disable-libdrm \
    --disable-glx \
    --disable-int10-module \
    --disable-vgahw \
    --disable-glamor \
    --disable-dri3 \
    --disable-dri2 \
    --disable-dri \
    --disable-xephyr \
    --disable-xnest \
    --disable-xwayland \
    --disable-config-udev \
    --disable-systemd-logind \
    --prefix=$1 \
    --without-systemd-daemon \
    --disable-selective-werror \
    --disable-strict-compilation \
    --with-sysroot=$6 \
    --disable-static --enable-shared \
    ac_cv_func_epoll_create1=no
