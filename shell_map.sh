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
        eval "${_/shell_map/$NEW_MAP}"
    ;;
    put)
        local KEY="$2"
        [ -z "$KEY" ] && { carp "put() KEY cannot be empty."; return; }
        [[ "$KEY" =~ [^a-zA-Z0-9_] ]] && { carp "put() KEY '$KEY' isn't valid. Valid KEY names can be letters, digits and underscores."; return; } 
        
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
        while read var; do  
            unset $var
        done < <(compgen -v ${FUNCNAME}_DATA_)
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
        [ -z "$KEY" ] && { carp "put_increment() KEY cannot be empty."; return; }
        [[ "$KEY" =~ [^a-zA-Z0-9_] ]] && { carp "put_increment() KEY '$KEY' isn't valid. Valid KEY names can be letters, digits and underscores."; return; } 
        
        local NUMBER="$3" 
        [ -z "$NUMBER" ] && { carp "put_increment() NUMBER cannot be empty."; return; }
        [[ "$NUMBER" =~ [^0-9] ]] && { carp "pub_increment() NUMBER '$NUMBER' must be digits."; return; }

        ((${FUNCNAME}_DATA_${KEY}+=$NUMBER))

        return 0
    ;;
    *)
        carp "unsupported operation '$1'."
        return 1
    ;;
    esac
}
