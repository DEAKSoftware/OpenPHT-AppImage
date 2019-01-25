
## OpenPHT `.deb` to `.AppImage` Conversion Tool


### Releases

* [OpenPHT 1.8.0.148](https://github.com/DEAKSoftware/OpenPHT-AppImage/releases/tag/1.8.0.148)

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
[`Recipes`](./Recipes) | Collection of recipes used by `pkg2appimage` to perform the conversion. The recipe is hard coded to source only one of the OpenPHT 1.8.0 `.deb` packages. See each respective `.yml` file for details.
[`make_appimage.sh`](./make_appimage.sh) | Convenience utility that performs the conversion.

### Prerequisites

In order to process some of the OpenPHT icons, we need to install ImageMagick:

```sh
sudo apt-get install imagemagick
```
Installation of ImageMagick is optional. If missing, the icon conversion stage will be skipped.


### Making an `.AppImage` Package

1. Run the utility `./make_appimage.sh --xenial` to fetch the OpenPHT `.deb` package for Ubuntu 16.04 LTS (Xenial Xerus) distribution and its dependencies. You can specify other distributions, see the `--help` option for details.

2. Find the output file at `./Build/OpenPHT*.AppImage` and copy it to a [location of your choice](https://docs.appimage.org/user-guide/faq.html#question-where-do-i-store-my-appimages).

3. As a test, run the `OpenPHT*.AppImage` executable from a terminal, and watch the terminal output for error messages. The OpenPHT log file at `~/.plexht/temp/plexhometheater.log` might also give you clues for errors. If the app does not run, the most likely reason will be related to a library missing from the `.AppImage` package. Make an issue on this repo, and we'll see what we can do about it. Better still, create a pull request if you have solution for a fix.

### Migrating OpenPHT Configuration

This section might be useful to you if you plan to migrate OpenPHT configuration data to your Linux platform. Otherwise, you can skip this section and run OpenPHT with default settings.

1. If OpenPHT was first run without issues, it will automatically create its default configuration data at the path `~/.plexht`. To migrate an existing OpenPHT configuration data over, close OpenPHT, then simply copy and replace the contents of `~/.plexht` with the other one. The source configuration could be obtained from a Windows, or a macOS installation, it doesn't really matter.

2. Once the configuration files were copied over, edit the file `~/.plexht/userdata/guisettings.xml` and create a new device name for the OpenPHT instance. Search for the `<devicename>` tags and change it to whatever appropriate; the computer name is usually sufficient:

	```xml
	<devicename>Foobar</devicename>
	```

3. Likewise the UUID for the OpenPHT instance must be also changed. Search for the `<uuid>` tags, as shown below (where `X` denotes hex digits), and change it to something unique. New IDs can be created with the [Online UUID Generator](https://www.uuidgenerator.net/version4).

	```xml
	<uuid>XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX</uuid>
	```
	**Note:** The UUID must never clash with any of the other Plex compatible devices on the network; hence the reason why we must change it.

### Disclaimers and Legal

DEAK Software is not the maintainer of OpenPHT, which means any bugs or issues related to the app should be reported on the [official OpenPHT GitHub page](https://github.com/RasPlex/OpenPHT/issues).

This project is released under the [MIT License](./license.md).
