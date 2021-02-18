#!/bin/bash

set -e # stop on first error

scriptDir=$(dirname "$0")
p=$(pwd)/$1
exec_path=$p/launch.sh
sym_link_path=/usr/local/bin/vscode-$1
arch_path=$scriptDir/code-stable.tar.gz

# download latest vscode if does't download earlier exist
if [ -f "$arch_path" ]; then
    echo ""
else
    wget https://update.code.visualstudio.com/latest/linux-x64/stable -O $arch_path
fi

if [ "$2" = "--delete" ]; then
    echo "Remove vscode folder $p"
    rm -rf $p
    echo "Remove symbolic link $sym_link_path"
    sudo rm -rf $sym_link_path
else
    echo $exec_path
    tar -xf $arch_path VSCode-linux-x64
    mv VSCode-linux-x64 ./$1

    mkdir ./$1/data

    echo "
#!/bin/sh
$p/bin/code \"\$@\"
" >$exec_path
    chmod +x $exec_path
    sudo ln $exec_path $sym_link_path

fi
