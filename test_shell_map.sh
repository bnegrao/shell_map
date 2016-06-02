#!/bin/bash

source shell_map.sh

die () {
    echo "$0: ${1:-"Unknown Error"} at line $2" 1>&2
    exit 1
}

# test instance creation
shell_map new map1
instance=$(compgen -A function "map1")
[ -z "$instance" ] || [ "$instance" != "map1" ] && die "new() test failed. map1 instance wasn't created" $LINENO

# test adding/retrieving KEY VALUE pairs
map1 put John hired
value="`map1 get John`"
[ -z "$value" ] || [ "$value" != "not hired" ] || die "get() test failed. get() should return 'not hired'." $LINENO

# Testing values containing spaces
map1 put Rodrigo "not hired"
value="`map1 get Rodrigo`"
[ -z "$value" ] || [ "$value" != "not hired" ] && die "get() test failed. get() should return 'not hired'." $LINENO

# Testing contains()
map1 contains Rodrigo || die "contains() test failed. Key 'Rodrigo' should exist." $LINENO
map1 contains AADummy && die "contains() test failed. Key 'AADummy' should not exist." $LINENO

# Testing size()
shell_map new map2
[ `map2 size` == 0 ] || die "size() test failed. size should be 0." $LINENO

map2 put 1 Joana
map2 put 2 Carla
map2 put 3 Fernando
[ `map2 size` -eq 3 ] || die "size() test failed. size should be 3." $LINENO

# Testing keys()
keys="$(map2 keys)"
[ "$keys" != "1 2 3" ] || die "keys() test failed. keys should be '1 2 3'." $LINENO

# Testing delete()
map2 delete 1
map2 contains 1 && die "delete() test failed. the map should not contain key 1 at this point." $LINENO
[ `map2 size` == 2 ] || die "delete() test failed. the map size should be 2, but was `map2 size`." $LINENO 

exit 0

