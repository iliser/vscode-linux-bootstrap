#!/usr/bin/env bash
set -e

scriptDir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
p=$(pwd)/$1
exec_path=$p/launch.sh
sym_link_path=/usr/local/bin/vscode-$1
arch_path=$scriptDir/code-stable.tar.gz

if [ -f "$arch_path" ]; then
    echo ""
else
    echo "# fetch archive"
    wget https://update.code.visualstudio.com/latest/linux-x64/stable -O "$arch_path"
fi

echo "# extract files and create directory"
echo "$exec_path"
tar -xf "$arch_path" VSCode-linux-x64
mv VSCode-linux-x64 ./"$1"


echo "
#!/bin/sh
$p/bin/code \"\$@\"
" >"$exec_path"
chmod +x "$exec_path"

sudo ln "$exec_path" "$sym_link_path"

if [ "$2" = "--update" ]; then
    echo '# copy old user data from tmp'
    mv /tmp/code-update-data-"$1" "$p/data" 
else
    echo '# install extension and config'
    mkdir -p ./"$1"/data
    "$scriptDir"/install-extensions.sh "$1"
    mkdir -p "$p"/data/user-data/User/
    curl https://gist.githubusercontent.com/iliser/ff944aeb2fcb868fd274e70c3b57bb62/raw/dff78df391b47f04aaf08427b52dd4880546b875/vscode_settings.json -o "$p"/data/user-data/User/settings.json
fi