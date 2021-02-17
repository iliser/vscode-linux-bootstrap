#!/bin/bash

$(dirname "$0")/new-version.sh ts
vscode-ts --install-extension loiane.ts-extension-pack --force
vscode-ts --install-extension mhutchie.git-graph --force