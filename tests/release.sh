#!/bin/sh
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

# Version comparison greater or equal
# See: https://www.shivering-isles.com/helpful-shell-snippets-for-docker-testing-and-bootstrapping/
version_ge() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || test "$1" = "$2"; }

# GitHub get latest release tag
# See: https://www.shivering-isles.com/helpful-shell-snippets-for-docker-testing-and-bootstrapping/
github_latest_release() { wget -qO- "https://api.github.com/repos/$1/releases/latest" | jq .tag_name | sed -e 's/"//g'; }  


DOCKERCONTAINER=$(docker run -d clamav:testing)

CLAMD_VERSION=$(docker exec -it "${DOCKERCONTAINER}" clamd --version  |  cut -d" " -f2 | cut -d. -f1-3 | sed -e "s/\/.*//g")

command_exists wget
command_exists jq

if version_ge "$CLAMAV_VERISON" "$CLAMD_VERSION"; then
    echo "ClamAV version ($CLAMAV_VERISON) is correct! Test successful."
else
    echo >&2 "Installed version doesn't match \$CLAMAV_VERISON. Installed version is $CLAMD_VERSION"
    exit 1
fi
