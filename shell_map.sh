#!/bin/bash

shell_map () {
    case $1 in
    new)
	# loads function declaration
        test -n "$(declare -f shell_map)" || return
	# declares in the Global Scope a copy of this function with a new name.
        eval "${_/shell_map/$2}"
    ;;
    put)
        KEY=$2
        VALUE=$3
	# declares a variable in the global scope
        eval ${FUNCNAME}_DATA_${KEY}=$VALUE
    ;;
    get)
        KEY=$2
        DATA=${FUNCNAME}_DATA_${KEY}
        echo ${!DATA}
    ;;
    keys)
        declare | grep -Po "(?<=${FUNCNAME}_DATA_)\w+((?=\=))"
    ;;
    name)
        echo $FUNCNAME
    ;;    
    contains)
        echo "TODO returns true if this map contains de given key"
    ;;
    clear)
        echo "TODO clears all elements from this map"
    ;;
    delete)
        echo "TODO removes the key from the map"
    ;;
    size)
        echo "TODO returns the number of key-value pairs contained in this map"
    ;;
    put_increment)
    	echo "TODO utility method to set a key and incrementing it's current value"
    ;;
    *)
        echo unsupported operation $1; exit 1
    esac
}
