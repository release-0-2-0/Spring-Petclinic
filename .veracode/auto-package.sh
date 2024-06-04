#!/bin/bash
set -e

# Download latest CLI to current working directory.
if ! [ -e "./veracode" ]; then
    curl -fsS https://tools.veracode.com/veracode-cli/install | sh
fi

# Determine source and target directories.
pushd $(dirname "$0") >/dev/null 2>&1
repo_root=`git rev-parse --show-toplevel`
output_dir="$repo_root/.veracode/output/auto"
popd

# Run the packager based on OS-Type.
case "$OSTYPE" in
    darwin*)  ./veracode package --source $repo_root --type directory --output $output_dir --trust;;
    linux*)   ./veracode package --source $repo_root --type directory --output $output_dir --trust;;
    msys*)    veracode package --source $repo_root --type directory --output $output_dir --trust;;
    cygwin*)  veracode package --source $repo_root --type directory --output $output_dir --trust;;
esac
