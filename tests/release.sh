#!/bin/sh

set -e

echo "
         ######################################
         ###           Release test          ##
         ######################################
"

if [ "$CLAMAV_VERSION" = "" ]; then
    echo "\$CLAMAV_VERSION is not set. Useless test... Exiting."
    exit 0
fi


# Check for command existence
# See: https://www.shivering-isles.com/helpful-shell-snippets-for-docker-testing-and-bootstrapping/
command_exists() { command -v "$1" >/dev/null 2>&1 || { echo >&2 "I require $1 but it's not installed.  Aborting."; exit 1; }; }

# Version comparison equal
# See: https://www.shivering-isles.com/helpful-shell-snippets-for-docker-testing-and-bootstrapping/
version_eq() { test "$1" = "$2"; }  

DOCKERCONTAINER=$(docker run -d clamav:testing)

CLAMD_VERSION=$(docker exec "${DOCKERCONTAINER}" clamd --version  |  cut -d" " -f2 | cut -d. -f1-3 | sed -e "s/\/.*//g")

if version_eq "$CLAMAV_VERSION" "$CLAMD_VERSION"; then
    echo "ClamAV version ($CLAMAV_VERSION) is correct! Test successful."
else
    echo >&2 "Installed version doesn't match \$CLAMAV_VERSION. Installed version is $CLAMD_VERSION"
    exit 1
fi

# Clean up
docker stop "$DOCKERCONTAINER" && docker rm "$DOCKERCONTAINER"
