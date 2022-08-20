#!/usr/bin/env bash
set -e

p=$(pwd)/$1
sym_link_path=/usr/local/bin/vscode-$1

echo "# remove vscode folder $p"
rm -rf "$p"
echo "# remove symbolic link $sym_link_path"
sudo rm -rf "$sym_link_path"