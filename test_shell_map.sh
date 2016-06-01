#!/bin/bash

source shell_map.sh

die () {
    echo "$0: ${1:-"Unknown Error"}" 1>&2
    exit 1
}


# test instance creation
shell_map new map1
instance=$(compgen -A function "map1")
[ -z "$instance" ] || [ "$instance" != "map1" ] && die "map1 instance wasn't created"

# test adding/retrieving KEY VALUE pairs
map1 put John hired
[ `map1 get John` == hired ] || die "Test failed"

# key names with spaces aren't supported currently
#map1 put "Camila Anderson" hired
#[ `map1 get "Camila Anderson"` == hired ] || die "Test failed"

# values with spaces aren't supported currently
#map1 put Rodrigo "not hired"
#[ `map1 get Rodrigo` == "not hired" ] || die "Test failed"
