#!/bin/bash
set -e
cd "$(dirname "$0")"

mkdir -p output
rm -f ./output/ue4-module.tar.gz
echo Generating ue4-module.tar.gz...
tar -zcvf ./output/ue4-module.tar.gz module
echo Done
