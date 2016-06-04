#!/bin/bash

croak () {
    echo "shell_map.sh: ERROR: $1" 1>&2
    return 1
}

shell_map () {
    case $1 in
    new)
        # loads function declaration
        test -n "$(declare -f shell_map)" || return
        # declares in the Global Scope a copy of this function with a new name.
        eval "${_/shell_map/$2}"
    ;;
    put)
        local KEY="$2"
        [ -z "$KEY" ] && return `croak "put() KEY cannot be empty."`
        echo "$KEY" | grep -qPo '[^a-zA-Z0-9_]' && return `croak "put() KEY '$KEY' isn't valid. Valid KEY names can be letters, digits and underscores."`
        local VALUE="$3"
        # declares a variable in the global scope
        eval ${FUNCNAME}_DATA_${KEY}='$VALUE'
    ;;
    get)
        local KEY="$2"
        local VALUE="${FUNCNAME}_DATA_${KEY}"
        echo "${!VALUE}"
    ;;
    keys)
        declare | grep -Po "(?<=${FUNCNAME}_DATA_)\w+((?=\=))"
    ;;
    name)
        echo $FUNCNAME
    ;;
    contains_key)
        local KEY="$2"
        [ -z "$KEY" ] && return `croak "contains_key() KEY cannot be empty."`
        compgen -v ${FUNCNAME}_DATA_${KEY} > /dev/null && return 0 || return 1
    ;;
    clear_all)

        echo "TODO clears all elements from this map"
    ;;
    remove)
        local KEY="$2"
        [ -z "$KEY" ] && return `croak "remove() KEY cannot be empty."`
        unset ${FUNCNAME}_DATA_${KEY}
    ;;
    size)
        compgen -v ${FUNCNAME}_DATA_${KEY} | wc -l
    ;;
    put_increment)
        local KEY="$2"
        [ -z "$KEY" ] && return `croak "put_increment() KEY cannot be empty."`
        local NUMBER="$3"
        [ -z "$NUMBER" ] && return `croak "put_increment() NUMBER cannot be empty."`
        echo $NUMBER | grep -qPo '[^0-9]' && return `croak "pub_increment() NUMBER '$NUMBER' must be digits."`

        if `$FUNCNAME contains_key $KEY`; then
            local TOTAL=`$FUNCNAME get $KEY`
            TOTAL=`expr $TOTAL + $NUMBER`
            $FUNCNAME put $KEY $TOTAL
        else
            $FUNCNAME put $KEY $NUMBER
        fi

        return 0
    ;;
    *)
        return `croak "unsupported operation '$1'."`
    esac
}

