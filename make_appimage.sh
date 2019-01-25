#!/bin/bash

makeAppImage() {

	distroName=${1}
	recipePath=${2}

	clear

	mkdir Build; cd Build
	mkdir ${distroName}; pushd ${distroName}

	wget -c https://raw.githubusercontent.com/AppImage/pkg2appimage/master/pkg2appimage || exit 1

	chmod 766 pkg2appimage || exit 1

	./pkg2appimage ${recipePath} || exit 1

	pushd out
	rename "s/glibc\\d+\\.\\d+/${distroName}/g" *.AppImage
	popd

	mv -f out/*.AppImage ..

	popd
}


scriptPath="$( cd "$(dirname "${0}")" ; pwd -P )"

#Paths are always relative to script location
jessieRecipePath="${scriptPath}/Recipes/OpenPHT-Jessie.yml"
trustyRecipePath="${scriptPath}/Recipes/OpenPHT-Trusty.yml"
xenialRecipePath="${scriptPath}/Recipes/OpenPHT-Xenial.yml"

if [ "${1}" = "--help" ] || [ "${1}" = "-h" ]; then

	printf "NAME\n\t${0} - Build an OpenPHT AppImage\n\n"
	printf "SYNOPSIS\n\t${0} [OPTION]\n\n"
	printf "DESCRIPTION\n\tBuild an OpenPHT AppImage using a deb package for specific Linux distribution.\n\n\tSpecifying a distribution is mandatory.\n\n"
	printf "\t-h, --help\n\tDisplay this help message.\n\n"
	printf "\t--jessie\n\tMake an AppImage using the 'Jessie' deb package.\n\n"
	printf "\t--trusty\n\tMake an AppImage using the 'Trusty' deb package. Note, support for this is limited and may not run on some platforms.\n\n"
	printf "\t--xenial\n\tMake an AppImage using the 'Xenial' deb package.\n\n"
	printf "\t--all\n\tMake an AppImage for all distributions.\n"

	exit 0

elif [ "${1}" = "--jessie" ]; then

	makeAppImage "Jessie" ${jessieRecipePath}

elif [ "${1}" = "--trusty" ]; then

	makeAppImage "Trusty" ${trustyRecipePath}

elif [ "${1}" = "--xenial" ]; then

	makeAppImage "Xenial" ${xenialRecipePath}

elif [ "${1}" = "--all" ]; then

	makeAppImage "Jessie" ${jessieRecipePath}
	makeAppImage "Trusty" ${trustyRecipePath}
	makeAppImage "Xenial" ${xenialRecipePath}

else

	echo "error: Bad or unknown option. Run with '--help' option for details."
	exit 1

fi
