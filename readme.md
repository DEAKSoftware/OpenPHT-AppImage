
## OpenPHT `.deb` to `.AppImage` Conversion Tool


### About

This project will attempt to convert an [OpenPHT](https://github.com/RasPlex/OpenPHT) binary release, packaged in the `.deb` format, into an [`.AppImage` package](https://appimage.org/).

The OpenPHT project is not actively maintained these days, and its [binary releases](https://github.com/RasPlex/OpenPHT/releases/tag/v1.8.0.148-573b6d73) target only a few old Linux distributions, which may no longer install on newer distributions. Rebuilding OpenPHT from sources is also quite challenging, as the project depends on a lot of third-party libraries, some of which are no longer backwards compatible with OpenPHT 1.8.0.

We will be using the [`pkg2appimage`](https://docs.appimage.org/packaging-guide/converting-binary-packages/pkg2appimage.html) script, provided by the AppImage project, to perform the conversion. The tools provided here will automatically download `pkg2appimage` and then use it to source all the library dependencies required to run OpenPHT and bundle them into the same `.AppImage` package. Repackaging this way will allow OpenPHT to run on most Linux distributions without the need for rebuilding OpenPHT from sources.

Programming knowledge is not a requirement for getting the conversion to work, unless you plan to modify or develop this project yourself. In that case, check out the official [AppImage documentation pages](https://docs.appimage.org/); the information therein might be useful.


### Project Structure

The following files or directories should be of interest:

File or Directory | Description
--- | ---
[`Build`](./Build) | Location where the AppImage will be built. All intermediate files will be generated and stored in there.
[`Recipe/OpenPHT.yml`](./Recipe/OpenPHT.yml) | The recipe file used by `pkg2appimage` to perform the converion. The recipe is hard coded to source only one of the OpenPHT 1.8.0 `.deb` packages. See the `OpenPHT.yml` file for details.
[`Recipe/openpht`](./Recipe/openpht) | Custom `openpht` shell script that will be bundled in the `.AppImage`, at location `./usr/bin` (relative inside the package). This is a modified version of the original shell script; the changes will allow `openpht` to resolve the `plexhometheater` binary using relative paths.
[`make_appimage.sh`](./make_appimage.sh) | Convenience utility that performs the conversion.


### Making an `.AppImage` Package

1. Run the `./make_appimage.sh` utility to fetch the OpenPHT `.deb` package and its dependencies. Hopefully all dependencies can be resolved.

2. Find the output file at `./Build/out/OpenPHT*.AppImage` and copy it to a [location of your choice](https://docs.appimage.org/user-guide/faq.html#question-where-do-i-store-my-appimages).

3. As a test, run the `OpenPHT*.AppImage` executable from a terminal, and watch the terminal output for error messages. If the app does not run, the most likely reason will be related to a library missing from the `.AppImage` package. Make an issue on this repo, and we'll see what we can do about it.

### OpenPHT Configuration

If OpenPHT runs without issues, it will automatically create its default configuration data at the path `~/.plexht`. One can also migrate an existing OpenPHT configuration data over by completely replacing the contents of `~/.plexht` with the other one.

Once the configuration files were copied over, edit the file `~/.plexht/userdata/guisettings.xml` and create a new device name and a new UUID for the OpenPHT instance. Search for the `<devicename>` tags and change it to whatever appropriate; the computer name is usually sufficient:

```xml
<devicename>Foobar</devicename>
```

Likewise, one must search for the `<uuid>` tags, as shown below (where `X` denotes hex digits), and change it to something unique.

```xml
<uuid>XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</uuid>
```
**Note:** The UUID must never clash with any of the other Plex compatible devices on the network; hence the reason why it must be changed. New IDs can be created with the [Online UUID Generator](https://www.uuidgenerator.net/version4).

### Disclaimers and Legal

DEAK Software is not the maintainer of OpenPHT, which means any bugs or issues related to the app should be reported on the [official OpenPHT GitHub page](https://github.com/RasPlex/OpenPHT/issues).

This project is released under the [MIT License](./license.md).
