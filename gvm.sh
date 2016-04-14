#!/bin/bash

GVM_DIR=${GVM_DIR:-$HOME/gvm}
GVM_CURRENT_VFILE=$GVM_DIR/version

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
    
    local v=${1:?'must give a specific version'}
    local dir=$GVM_DIR/sources/$v

    if has_go "$dir"; then
        echo $1 already exists!
        return 0
    else
        mkdir -p $dir
        wget -qO - https://storage.googleapis.com/golang/go$v.linux-amd64.tar.gz | tar -xvz -C $dir 
    fi
}

remove_go() {
    
    local v=${1:?'must give a specific version'}
    local dir=$GVM_DIR/sources/$v

    if [ $v = `cat $GVM_CURRENT_VFILE` ]; then
        echo can\'t remove current golang version!!
        return 1
    fi

    if has_go "$dir"; then
        rm $dir -r
        return $?
    fi
} 

use_go() {
    
    local v=${1:?'must give a specific version'}
    local dir=$GVM_DIR/sources/$v

    if has_go $dir; then
        echo $v > $GVM_CURRENT_VFILE
        ln -sf $dir/go ${GOROOT%/*}
        env_go
        return $?
    else
        echo please load $1 before use
        return 1
    fi
}

env_go() {
    echo -e "\033[32m"GVM_DIR=$GVM_DIR, v=`cat $GVM_CURRENT_VFILE`"\033[m"
    go version
    go env
}

case $1 in
list) list_go_version;;
install) load_go "$2";;
uninstall) remove_go "$2";;
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
