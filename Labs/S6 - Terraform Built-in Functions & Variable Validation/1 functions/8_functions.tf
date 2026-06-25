/*
A demonstration of some of the Terraform built-in 

# lookup() function - deals with map data types
# usage : lookup(map, key, default)

lookup({a="animal", b="bird"}, "a", "not an option")
animal

lookup({a="ay", b="bee"}, "c", "not an option")
not an option


## element() function - deals with list data types
# Usage: element([list], index)

element(["a", "b", "c"], 1)
b

## file() function - reads and prints a file content
# Usage: file("path/filename")

file("${path.module}/test.txt")
Hello World


## timestamp() function - prints date and time

timestamp()
2018-05-13T07:44:12Z


## formatdate() function - formats the timestamp
# Usage: formatdate("format", timestamp)

formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
02 April 2024 23:12 UTC


# cidrsubnets() function 
Usage : cidrsubnets(prefix, newbits...)
cidrsubnets("10.1.0.0/16", 4, 4, 8, 4)


# substr() function
Usage : substr(string, offset, length)
substr("hello world", 6, 3)

# length() function
Usage : length(string)
length("hello world")

# contains() function
contains(list, value)
contains(["a", "b", "c"], "a") 

*/






