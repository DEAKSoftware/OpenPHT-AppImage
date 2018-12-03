#!/bin/bash

mkdir Build; cd Build

wget -c https://raw.githubusercontent.com/AppImage/AppImages/master/pkg2appimage || exit 1

chmod 766 pkg2appimage || exit 1

./pkg2appimage ../Recipe/OpenPHT.yml
