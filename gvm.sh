#!/bin/bash

GVM_DIR=${GVM_DIR:-$HOME/gvm}

has_go() {
    test -d "$1" > /dev/null 2>&1
    return $?
}

list_go_version() {
    for v in `ls $GVM_DIR/sources`; do
        echo $v
    done
}

load_go() {
    
    local dir=$GVM_DIR/sources/$1

    if has_go "$dir"; then
        echo $1 already exists!
        return 0
    else
        mkdir -p $dir
        wget -qO - https://storage.googleapis.com/golang/go${1}.linux-amd64.tar.gz | tar -xvz -C $dir 
    fi
}

use_go() {
    local dir=$GVM_DIR/sources/$1
    if has_go $dir; then
        ln -sf $dir/go $GOROOT
        env_go
        return $?
    else
        echo please load $1 before use
        return 1
    fi
}

env_go() {
    echo -e "\033[32m"GVM_DIR=$GVM_DIR"\033[m"
    go env
}

case $1 in
list) list_go_version;;
install) load_go "$2";;
use) use_go "$2";;
env) env_go;;
*) echo Usage: ${0} [SUB-COMMAND] [ARGS];;
esac

#if type "$1" >> /dev/null ; then
#    cmd=$1
#    shift 1
#    $cmd $@
#    exit $?
#fi
