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
    contains)
        echo TODO
    ;;
    delete)
        echo TODO
    ;;
    name)
        echo $FUNCNAME
    ;;
    *)
        echo unsupported operation $1; exit 1
    esac
}
