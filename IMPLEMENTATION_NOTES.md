
#### How does `shell_map` work? Is this a real HashMap object?
`shell_map` is a normal function. The trick is when you call `shell_map new my_map` shell_map will copy itself to a new function named `my_map`, so, instead of having an *object instance*, what you have is a *function instance*.  

When you add data to your map using `my_map put "somekey" "somevalue"`, a variable will be added to the global scope under the name of `my_map_DATA_somekey`, for this reason, key strings can only be made of letters, digits and underscores.  

When retrieving data with `my_map get somekey` the value from the global variable `my_map_DATA_somekey` will be returned, this way the resulting functionallity works pretty much like a HashMap.  

Each method name is actually the "$1" argument given to shell_map function, method arguments are the $2, $3...
