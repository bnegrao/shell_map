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

# Testing contains_key()
map1 contains_key Rodrigo || die "contains_key() test failed. Key 'Rodrigo' should exist." $LINENO
map1 contains_key AADummy && die "contains_key() test failed. Key 'AADummy' should not exist." $LINENO

# test an invalid key name
map1 put "tt%" string 2>/dev/null && die "put() should not accept key tt%"
map1 put_increment "tt%" 5 2>/dev/null && die "put_increment() should not accept key tt%"

# Testing size()
shell_map new map2
[ `map2 size` == 0 ] || die "size() test failed. size should be 0." $LINENO

map2 put 1 Joana
map2 put 2 Carla
map2 put 3 Fernando
[ `map2 size` -eq 3 ] || die "size() test failed. size should be 3." $LINENO

# Testing keys()
keys="$(map2 keys)"
[ "$keys" != "1 2 3" ] && die "keys() test failed. keys should be '1 2 3'." $LINENO

# Testing remove()
map2 remove 1
map2 contains_key 1 && die "remove() test failed. the map should not contain key 1 at this point." $LINENO
[ `map2 size` == 2 ] || die "remove() test failed. the map size should be 2, but was `map2 size`." $LINENO 

# Testing put_increment()
shell_map new word_count
word_count put_increment hello 1
word_count put_increment hello 1
word_count put_increment hello 1
[ `word_count get hello` == 3 ] || die "put_increment() test failed. key 'hello' should have value '3'." $LINENO

word_count put_increment hello asdf 2>/dev/null && die "put_increment should return error for a value that is not numeric." $LINENO

# testing put_append()
shell_map new string_map
string_map put_append str bruno
string_map put_append str daniel
mystr=`string_map get str`
[ "$mystr" == "brunodaniel" ] || die "put_append() test failed. mystr should be 'brunodaniel' but is '$mystr'." $LINENO

# testing clear_all
shell_map new map3
map3 put var1 asdf
map3 put var2 asdf
map3 clear_all
keys=`map3 keys`
[ ! -z "$keys" ] && die "clear_all() did not clear all keys". $LINENO

echo All tests were successful 

exit 0

