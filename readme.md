
## OpenPHT `.deb` to `.AppImage` Conversion Tool


### About

This project will attempt to convert an [OpenPHT](https://github.com/RasPlex/OpenPHT) binary release, packaged in the `.deb` format, into an [`.AppImage` package](https://appimage.org/). 

Unfortunately, OpenPHT is not actively maintained these days, and its [binary releases](https://github.com/RasPlex/OpenPHT/releases/tag/v1.8.0.148-573b6d73) are only limited to just a few old Linux distributions, which may no longer run on newer distributions. Rebuilding OpenPHT from sources was also quite challenging, as the project leans on a lot of library dependencies, some of which are no longer compatible with OpenPHT 1.8.0.

We will be using the [`pkg2appimage`](https://docs.appimage.org/packaging-guide/converting-binary-packages/pkg2appimage.html) script to perform the conversion. This tool will source all the library dependencies required to run OpenPHT and bundle them into the same `.AppImage` package. Repackaging OpenPHT this way will allow the app to run on most Linux distributions without the need for rebuilding the entire app. 

You don't need to know much about programming to get the conversion to work, unless you plan to modify or develop this project yourself. In that case, the official [AppImage documentation pages](https://docs.appimage.org/) might be useful.


### Project Structure

The following files or directories should be of interest:

File or Directory | Description
--- | ---
[`Build`](./Build) | Location where the AppImage will be built. All intermediate files will be generated and stored in there.
[`Recipe/OpenPHT.yml`](./Recipe/OpenPHT.yml) | The recipe file used by `pkg2appimage` to perform the converion. The recipe is hard coded to source only one of the OpenPHT 1.8.0 Debian packages. See file for details.
[`Recipe/openpht`](./Recipe/openpht) | Custom `openpht` shell script that will be bundled in the AppImage, at location `./usr/bin`. This is a modified version of the original, made to resolve the `plexhometheater` binary by using relative paths.
[`make_appimage.sh`](./make_appimage.sh) | Convenience utility that does the conversion.


### Converting to an `.AppImage`

1. Run the `./make_appimage.sh` utility and pray that all dependencies can be resolved.

2. Find the output file at `./Build/out/OpenPHT*.AppImage` and copy it to a [location of your choice](https://docs.appimage.org/user-guide/faq.html#question-where-do-i-store-my-appimages).

3. As a test, run the `OpenPHT*.AppImage` executable from a terminal, and watch the terminal output for error messages. If the app does not run, the most likely issue will be probably related to a library missing from the `.AppImage` package. Make an issue on this repo, and we'll see what we can do about it.

### Disclaimers and Legal

DEAK Software is not the maintainer of OpenPHT, which means any bugs or issues related to the app should be reported on the [official OpenPHT GitHub page](https://github.com/RasPlex/OpenPHT/issues).

This project is released under the [MIT License](./license.md).

