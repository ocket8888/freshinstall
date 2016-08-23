#!/bin/sh

BASE=true

while getopts ":wpbvlfh" ARG; do
	case $ARG in
		w)
			WEB=true;;
		p)
			PROG=true;;
		v)
			VERBOSE=true;;
		b)
			BASE=false;;
		l)
			LIST=true;;
		f)
			FORCE=true;;
		h)
			echo "Usage: freshinstall.sh [-wpblvh]\n
\t-w: Also installs components for hosting a webserver\n
\t-p: Also installs extra programming utilities (compilers etc.)\n
\t-b: Does NOT install the base system that is included by default.\n
\t-l: Installs nothing, but instead lists the packages that would be installed\n
\t-f: Forces the install of (only) packages that don't depend on a package manager\n
\t-v: Display verbose output detailing what operations are being done.\n
\t-h: Displays this help text.";
			exit 0;;
		\?)
			echo "Invalid option: -$OPTARG, try '-h' for help" >&2;
			exit 1;;
	esac
done

if [ $LIST ]; then
	echo "List of packages goes here";
	exit 0;
fi

if [ $VERBOSE ]; then
	echo "Searching for package manager...";
fi
if [ $(which apt) ]; then
	PKG="apt";
	INSTALL="apt install ";
	UPDATE="apt update";
elif [ $(which apt-get) ]; then
	PKG="apt-get";
	INSTALL="apt-get install ";
	UPDATE="apt-get update"
elif [ $(which pacman) ]; then
	PKG="pacman";
	INSTALL="pacman -I ";
	UPDATE="pacman -Syy"
fi


if [ $VERBOSE ] && [ $PKG ]; then
	echo "Package manager found. Using $PKG provided by $(which $PKG).";
fi

if ! [ $PKG ] && ! [ $FORCE ]; then
	echo "Package manager could not be found and '-f' flag not given. Exiting." >&2;
	exit 2;
fi