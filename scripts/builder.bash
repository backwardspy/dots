#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
export PATH="$coreutils/bin"
mkdir -p $out/bin
cp $source $out/bin/$name
