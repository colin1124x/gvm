#!/bin/bash

Usage() {
    echo "Usage: ${0} [GOLANG-VERSION=go1.6.1.linux-amd64.tar.gz] [CUSTOM-BIN-DIR]"
}

if [ 3 -ne $# ] ; then
    Usage && exit 1
fi

VERSION=${1}
CUSTOM_BIN_DIR=${2}
# TODO check writable


wget https://storage.googleapis.com/golang/${VERSION}


