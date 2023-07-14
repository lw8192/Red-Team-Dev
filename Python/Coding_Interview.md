# Python Coding Interview Review     
Practice: leetcode, hackerrank, Cracking the coding interview    

### Ints    
Operations    

    round(int, 2)    #round to the 2nd decimal place     
    abs(-2)     #return absolute value     
    a+=1   #increment    

### Strings    
Can think of as an array of chars     
Operations:    

    string.split(" ")  #split on a value    
    string.strip()     #strip off whitespace or a specified char(s)        
    string.upper()     #to all uppercase    
    string.lower()     #to all lowercase     
    s="".join(c for c in s if c.isalnum()) #remove non alphanumeric chars     
Substrings:    

    if "ace" in "trace"      
    string[start:end:step]    #end - not included     
    s.find("hi")   #searches string s for a substring and returns starting index    
    
## Lists    
Common interview questions: reversing a linked list, operations on a list with a given critera, modifying a list in place    

remove items from a list:      
pop, remove, del, clear     
list.pop()	  #removes an item at an index position and returns it      
list.remove()	#removes the first item matching a value       
slicing: Can be used to delete non-matching ranges of data        
del statement	 #removes an item at an index position and doesn’t return it       
list.clear()	#removes all items in a Python list        

Sorting in-place:     
Modify the input in place, without creating a separate copy of the data structure. An algorithm which is not in-place is sometimes called not-in-place or out-of-place.  

### Dicts   

    print(dict.get("key"))    
    dict.keys()    
    dict.values()    
### Conditionals   

    if True:  
        print("True")    
    elif False:     
        print("False")    
    else:  
        print("False")    
### Loops    
while loops:    

    a = 1    
    while a < 5:    
        a += 1    
        print(a)    
for:    

    for i in range(0,5):
        print(i)            #prints 0,1,2,3,4
    for i in range(0,len(list)):
        print(list[i])              #prints all elements in a list     

## Object Oriented Programming Concepts   
Classes: creates a format / outline that can be used to create a object with assigned values and properties.    
Instantiation: creating an instance of a class. Ie - class car, creating bobs_car with color blue and year 2010   
Polymorphism: Use a common interface for different types - ie use same function and pass in different variable types.    
Operator overloading: Change meaning of an operator depending on the operator's use. Ex - + for string concat and to add integers. Controls what happens when you compare different objects from the same class. Can overload: plus, minus, multiplication, bitwise operations, mathematical comparisons (greater then, less then).   

