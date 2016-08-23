#!/bin/sh

LIST=false
VERBOSE=false
WEB=false
PROG=false
BASE=true

while getopts ":wpbvlh" ARG; do
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
		h)
			echo "Usage: freshinstall.sh [-wpblvh]\n
\t-w: Also installs components for hosting a webserver\n
\t-p: Also installs extra programming utilities (compilers etc.)\n
\t-b: Does NOT install the base system that is included by default.\n
\t-l: Installs nothing, but instead lists the packages that would be installed\n
\t-v: Display verbose output detailing what operations are being done.\n
\t-h: Displays this help text.";;
		\?)
			echo "Invalid option: -$OPTARG, try '-h' for help" >&2;;
	esac
done