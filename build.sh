#!/bin/bash

set -eux -o pipefail

docker build . -f vulkan.Dockerfile -t tabby-builder:local

mkdir -p build

docker run -it --rm \
    -v "$(pwd):$(pwd)" \
    -w "$(pwd)" \
    -u "$(id -u):$(id -g)" \
    -e "CARGO_HOME=$(pwd)/.cargo-home" \
    tabby-builder:local \
    cargo build --features vulkan --release --package tabby
