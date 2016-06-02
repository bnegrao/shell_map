# shell_map
A Map implementation in bash. Tested with bash 3. It's like having a Map object in Shell.

### Usage

###### importing shell_map.sh
`source shell_map.sh`

###### instantiating a new shell_map with the name 'users'
`shell_map new users`

###### storing key value pairs
```
users put jdavis "John Davis"
users put bnegrao "Bruno Negrao" 
users put msilva "Mariana Silva"
```

###### retrieving values from keys. 
`users get jdavis      # returns "John Davis"`

###### iterating through all keys in 'users' shell_map 
```
for $username in `users keys`; do
	name=`users get $username`
	echo "user $username, name: $name"
done
```
	
### Methods
```
	new <name>: instantiates a new shell_map instance named as <name>
	put <key> <value>: stores <value> associated with <key>. valid key name must be a string consisting solely of letters, numbers, and underscores.
	get <key>: retrieves the value associated with <key>
	keys: retrieves a list of key names, separated by new line characters.
	size: return the number of keys contained in the map
	contains <key>: returns true if the <key> exists in the map, returns false otherwise. (see also: man true)
	delete <key>: deletes a key from the map. 
```
