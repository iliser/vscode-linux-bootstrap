# vscode-linux-bootsrap
Set of script to install and manage standalone vscode instances, with different extensions set

# Motivation
Single instance of vscode with multiple extensions for different workflows start to work very slow, and get unexpected bugs in interaction.
So there is simple solution that allow to manage multiple vscode instances.

# Getting started

Vscode binaries installs to `pwd`, and script expects to launch from directory where instances has been installed

## Install 
Install all binaries and extension from `versions/$version.extension-list` and `versions/_default.extension-list`.
Create symlinks `/usr/local/bin/vscode-$version` to launch this instance and fetch config

```sh
# scripts need wget for fetch vscode executables
sudo apt install wget 
mkdir -p ~/tools/vscodes

cd tools
git clone git@github.com:iliser/vscode-linux-bootstrap.git

cd vscodes
../vscode-linux-bootsrap/install.sh $version
```

## Update
Preserve current user data and installed extensions and update vscode binaries

```sh
cd ~/tools/vscode/
../vscode-linux-bootsrap/update.sh $version
```

## Delete
Delete binaries and symlink
```sh
cd ~/tools/vscode/
../vscode-linux-bootsrap/delete.sh $version
```