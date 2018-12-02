
# OpenPHT AppImage Build Tool

## About

This build tool will convert an [OpenPHT](https://github.com/RasPlex/OpenPHT) binary release, packaged in the Debian format, into an [AppImage](https://appimage.org/) package. The tool will source all the library dependencies required to run OpenPHT and bundle them into the same AppImage package. Repackaging OpenPHT this way will allow the app to run on most Linux distributions without the need for rebuilding the entire app. 

Unfortunately, OpenPHT is not actively maintained these days, and [binary releases of the app](https://github.com/RasPlex/OpenPHT/releases/tag/v1.8.0.148-573b6d73) is limited to just a few Linux distributions. Rebuilding OpenPHT from sources was also quite challenging, as the project leans on a lot of library dependencies, some of which are no longer compatible with OpenPHT 1.8.0.

## Project Structure


## Building an AppImage

Simply run `./make_appimage.sh` utility and 