#!/bin/bash

mkdir Build; cd Build

wget -c https://raw.githubusercontent.com/AppImage/AppImages/master/pkg2appimage

chmod 766 pkg2appimage

./pkg2appimage ../Recipe/OpenPHT.yml

# ./out/OpenPHT-1.8.0.148.glibc2.15-x86_64.AppImage