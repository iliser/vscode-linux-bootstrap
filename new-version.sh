#!/bin/bash

set -e # stop on first error

scriptDir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
p=$(pwd)/$1
exec_path=$p/launch.sh
sym_link_path=/usr/local/bin/vscode-$1
arch_path=$scriptDir/code-stable.tar.gz

# download latest vscode if does't download earlier exist
if [ -f "$arch_path" ]; then
    echo ""
else
    wget https://update.code.visualstudio.com/latest/linux-x64/stable -O "$arch_path"
fi

if [ "$2" = "--update" ]; then
    # store old user and extension data
    mv "$p/data" /tmp/code-update-data-"$1"
    mv "$exec_path" /tmp/code-update-data-launch.sh

    rm -rf "$p"

    tar -xf "$arch_path" VSCode-linux-x64
    mv VSCode-linux-x64 ./"$1"

    mv /tmp/code-update-data-"$1" "$p/data" 
    mv /tmp/code-update-data-launch.sh "$exec_path" 
elif [ "$2" = "--delete" ]; then
    echo "Remove vscode folder $p"
    rm -rf "$p"
    echo "Remove symbolic link $sym_link_path"
    sudo rm -rf "$sym_link_path"
else
    echo "$exec_path"
    tar -xf "$arch_path" VSCode-linux-x64
    mv VSCode-linux-x64 ./"$1"

    mkdir ./"$1"/data

    echo "
#!/bin/sh
$p/bin/code \"\$@\"
" >"$exec_path"
    chmod +x "$exec_path"
    sudo ln "$exec_path" "$sym_link_path"


    "$scriptDir"/install-extensions.sh "$1"
    mkdir -p "$p"/data/user-data/User/
    curl https://gist.githubusercontent.com/iliser/ff944aeb2fcb868fd274e70c3b57bb62/raw/dff78df391b47f04aaf08427b52dd4880546b875/vscode_settings.json -o "$p"/data/user-data/User/settings.json
fi
