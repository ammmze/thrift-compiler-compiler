#!/usr/bin/env sh

set -e

WORKDIR="$(pwd)/thrift"
VERSION="${VERSION:-v0.14.1}"

_cleanup() {
    echo 'Clean up'
    # rm -fr "${WORKDIR}"
}

trap _cleanup EXIT

if [ ! -d "${WORKDIR}" ]; then
    git clone https://github.com/apache/thrift.git "${WORKDIR}"
fi
cd thrift
git checkout "${VERSION}"
./bootstrap.sh
# exclude ruby it needs an older version of bundler and i don't wanna take the time to figure out how to make that work
./configure  --without-ruby
make
make check
