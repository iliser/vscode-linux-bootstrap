#!/usr/bin/env bash
set -e

scriptDir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
p=$(pwd)/$1

echo "# copy user data to tmp and remove old files"
mv "$p/data" /tmp/code-update-data-"$1"

"$scriptDir"/delete.sh "$1"

"$scriptDir"/install.sh "$1" --update