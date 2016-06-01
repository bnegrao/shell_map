# shell_map
Implementation of a Map in Shell Script

usage

source shell_map.sh

# instantiate a new Map
shell_map new users

# put: add key value pairs
users put jdavis "John Davis"
users put bnegrao "Bruno Negrao" 
users put msilva "Mariana Silva"

# get: retrieves values from keys
users get jdavis # returns "John Davis"

# keys: return all keys 
for $username in `users keys`; do
	name=`users get $key`
	echo "user $username, name: $name"
done


