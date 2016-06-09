#!/bin/bash

carp () {
    echo "shell_map.sh: ERROR: $1" 1>&2
    return 1
}

shell_map () {
    local METHOD="$1"
    [ -z "$METHOD" ] && { carp "argument <METHOD> cannot be empty. Usage: shell_map <METHOD> [arg1] [arg2]." ; return; }
    
    
    case $METHOD in
    
    new)
        local NEW_MAP="$2"
        [ -z "$NEW_MAP" ] && { carp "new(): argument <MAP_NAME> cannot be empty. Usage: shell_map new <MAP_NAME>."; return; } 
        
        # loads function declaration
        test -n "$(declare -f shell_map)" || return
        # declares in the Global Scope a copy of this function with a new name.
        eval "${_/shell_map/$2}"
    ;;
    put)
        local KEY="$2"
        [ -z "$KEY" ] && { carp "put() KEY cannot be empty."; return; }
        
        echo "$KEY" | grep -qPo '[^a-zA-Z0-9_]' && { carp "put() KEY '$KEY' isn't valid. Valid KEY names can be letters, digits and underscores."; return; } 
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
        [ -z "$KEY" ] && { carp "contains_key() KEY cannot be empty."; return; }
        compgen -v ${FUNCNAME}_DATA_${KEY} > /dev/null && return 0 || return 1
    ;;
    clear_all)

        echo "TODO clears all elements from this map"
    ;;
    remove)
        local KEY="$2"
        [ -z "$KEY" ] && { carp "remove() KEY cannot be empty."; return; }
        unset ${FUNCNAME}_DATA_${KEY}
    ;;
    size)
        compgen -v ${FUNCNAME}_DATA_${KEY} | wc -l
    ;;
    put_increment)
        local KEY="$2"
        [ -z "$KEY" ] && { "put_increment() KEY cannot be empty."; return; }
        local NUMBER="$3"
        [ -z "$NUMBER" ] && { carp "put_increment() NUMBER cannot be empty."; return; }
        echo $NUMBER | grep -qPo '[^0-9]' && { carp "pub_increment() NUMBER '$NUMBER' must be digits."; return; }

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
        carp "unsupported operation '$1'."
        return 1
    ;;
    esac
}
