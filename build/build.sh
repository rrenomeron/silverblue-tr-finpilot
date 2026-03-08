#!/usr/bin/bash

set -eou pipefail

echo "Building ${IMAGE_NAME}:${TAG}"

/ctx/build/custom.sh

for scriptname in /ctx/oci/tr-osforge/build/*.sh; do
    echo "========================================* $scriptname start *========================================"
    $scriptname
    echo "========================================* $scriptname end *========================================"
done
