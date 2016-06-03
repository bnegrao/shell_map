# shell_map
A full featured Map implementation in bash. Tested with bash 3. It's like OOO programming in Shell.
```
# Usage

# importing shell_map.sh
source shell_map.sh

# instantiating a new shell_map with the name 'users'
shell_map new users

# storing key value pairs
users put jdavis "John Davis"
users put bnegrao "Bruno Negrao" 
users put msilva "Mariana Silva"

# test if a key exists
users contains msilva && echo "msilva's name is `users get msilva`" 

# retrieving values from keys. 
users get jdavis      # returns "John Davis"

# iterating through all keys in 'users' shell_map 
for $username in `users keys`; do
	name=`users get $username`
	echo "user $username, name: $name"
done
```
#### Constructor
- `new <name>`: instantiates a new shell_map instance named as <name>
	
#### Methods
- `contains <key>`: returns true if the <key> exists in the map, returns false otherwise. (see also: man true)
- `delete <key>`: deletes a key from the map. 
- `get <key>`: retrieves the value associated with <key>
- `keys`: retrieves a list of key names, separated by new line characters.
- `put <key> <value>`: stores <value> associated with <key>. valid key name must be a string consisting solely of letters, numbers, and underscores.
- `put_increment <key> <value>`: convenience method that stores a numeric <value> incrementing the existing number.
- `size`: return the number of keys contained in the map

