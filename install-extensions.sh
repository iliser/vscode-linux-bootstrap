#!/bin/bash
set -e

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
old_path=$(pwd)
if ! command -v "vscode-$1" &> /dev/null
then
    echo "vscode-$1 is not installed"
    exit
else
    echo 'version exists install extensions'
    cd $parent_path
    awk '{print $0}' ./versions/default.extension-list ./versions/$1.extension-list 2>/dev/null | xargs -I{} vscode-$1 --install-extension {} --force
    cd $old_path
fi
