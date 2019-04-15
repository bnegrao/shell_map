# shell_map
A full featured Map implementation in bash script, providing de functionality of a HashMap. Developed using bash 3.  


See the file [test_shell_map.sh](https://github.com/bnegrao/shell_map/blob/master/test_shell_map.sh) for more usage examples.  


If you want to understand how shell_map is implemented, take a look at [IMPLEMENTATION_NOTES.md](https://github.com/bnegrao/shell_map/blob/master/IMPLEMENTATION_NOTES.md)

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

# retrieving values from the map 
users get jdavis      # returns "John Davis"

# test if a key exists
users contains_key msilva && echo "msilva's name is `users get msilva`" 

# iterating through all keys in 'users' shell_map 
for username in `users keys`; do
	name=`users get $username`
	echo "user $username, name: $name"
done
```
#### Constructor
- `new <mymap>`: instantiates a new shell_map instance named as `<mymap>`
	
#### Methods
- `clear_all`: remove all the key value pairs from the map
- `contains_key <key>`: returns true if the `<key>` exists in the map, returns false otherwise. 
- `get <key>`: retrieves the value associated with `<key>`
- `keys`: retrieves a list of key names, separated by new line characters.
- `put <key> <value>`: stores `<value>` associated with `<key>`. valid key name must be a string consisting solely of letters, numbers, and underscores.
- `put_append <key> <value>`: convenience method that appends `<value>` to an existing key value. Creates a new key if it didn't exist.
- `put_increment <key> <value>`: convenience method that stores a numeric `<value>` incrementing the existing value.
- `remove <key>`: removes a key from the map. 
- `size`: return the number of keys contained in the map
