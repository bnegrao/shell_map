# shell_map
A full featured Map implementation in bash script, providing de functionality of a HashMap.     
Developed using bash 3.   
See the file [test_shell_map.sh](https://github.com/bnegrao/shell_map/blob/master/test_shell_map.sh) for more usage examples.

#### How does `shell_map` work? Is this a real HashMap object?
`shell_map` is a normal function. The trick is when you call `shell_map new my_map` shell_map will copy itself to a new function named `my_map`, so, instead of having an *object instance*, what you have is a *function instance*.  

When you add data to your map using `my_map put "somekey" "somevalue"`, a variable will be added to the global scope under the name of `my_map_DATA_somekey`, for this reason, key strings can only be made of letters, digits and underscores.  

When retrieving data with `my_map get somekey` the value from the global variable `my_map_DATA_somekey` will be returned, this way the resulting functionallity works pretty much like a HashMap.  

Each method name is actually the "$1" argument given to shell_map function, methods arguments are the $2, $3...

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
users contains_key msilva && echo "msilva's name is `users get msilva`" 

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
- `contains_key <key>`: returns true if the `<key>` exists in the map, returns false otherwise. 
- `remove <key>`: removes a key from the map. 
- `get <key>`: retrieves the value associated with `<key>`
- `keys`: retrieves a list of key names, separated by new line characters.
- `put <key> <value>`: stores `<value>` associated with `<key>`. valid key name must be a string consisting solely of letters, numbers, and underscores.
- `put_increment <key> <value>`: convenience method that stores a numeric `<value>` incrementing the existing number.
- `size`: return the number of keys contained in the map

