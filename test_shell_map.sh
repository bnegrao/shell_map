#!/bin/bash

source shell_map.sh

die () {
    echo "$0: ${1:-"Unknown Error"} at line $2" 1>&2
    exit 1
}

# test instance creation
shell_map new map1
instance=$(compgen -A function "map1")
[ -z "$instance" ] || [ "$instance" != "map1" ] && die "map1 instance wasn't created" $LINENO

# test adding/retrieving KEY VALUE pairs
map1 put John hired
value="`map1 get John`"
[ -z "$value" ] || [ "$value" != "not hired" ] || die "Test failed" $LINENO

# key names with spaces aren't supported currently
#map1 put "Camila Anderson" hired
#[ `map1 get "Camila Anderson"` == hired ] || die "Test failed"

# values with spaces aren't supported currently
map1 put Rodrigo "not hired"
value="`map1 get Rodrigoo`"
[ -z "$value" ] || [ "$value" != "not hired" ] && die "Test failed" $LINENO
