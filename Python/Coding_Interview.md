# Python Coding Interview Review     
Practice: leetcode, hackerrank, Cracking the coding interview    
Before the interview: know what language you will program in (ask if you can pick / if a certain language is required), what resources you can use (the Internet?, official documentation?, questions from the interviewers?). These things will guide your preparation.    

During the interview: make pseudocode, ask questions if you get stuck, feel free to narrate your thought process (show your problem solving ability)   
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
    s.replace(i,"")   #remove char from a string   
    a = s.sorted()     #return string sorted from 
Substrings:    

    if "ace" in "trace"      
    string[start:end:step]    #end - not included     
    s.find("hi")   #searches string s for a substring and returns starting index    
    
## Lists    
Common interview questions: reversing a linked list, operations on a list with a given critera, modifying a list in place, testing if 2 words are palindromes        

remove items from a list:      
pop, remove, del, clear     
list.pop()	  #removes an item at an index position and returns it      
list.remove()	#removes the first item matching a value       
slicing: Can be used to delete non-matching ranges of data        
del statement	 #removes an item at an index position and doesn’t return it       
list.clear()	#removes all items in a Python list        

    list[0]= 'a'   #update list    
    del list[0]   #delete element of list   
    list.insert(0, "A")   #insert at index of 0      
    list.append("last")   #add to end   Buil in functions: max, min, index, count, pop, extend     
    list.push()     #add item to a list   

    list.pop()    #remove item from a list using index, removes last item by default   
    list.remove(index)      
    sum(list)      #sum ints in a list    

Sorting in-place:     
Modify the input in place, without creating a separate copy of the data structure. An algorithm which is not in-place is sometimes called not-in-place or out-of-place.  


Sorting    
[Comparison Based Sorting Algorithims](https://www.cs.cmu.edu/~avrim/451f11/lectures/lect0913.pdf)    

    list.sort()         #sort list, low to high. Sorts in place    
    sorted(list)       #sort list of ints, low to high. returns a new list    
    sorted(list, reverse=True)   #sort high to low    

    arr.sort()      #sorts in place, can be finicky      
    temp = sorted(arr)     #returns a new list    
    my_list = sorted(set(my_list))  #sort unique, only works on hashable types     

Enumerating a list:   

    for count, value in enumerate(values):    #has index and value of a list   
        print(count, value)      
Remove duplicates from a list:   

    a_list = ["a", "b", "a", "c", "c"]
    a_list = list( dict.fromkeys(a_list) )  #make a dict which removes duplicates, then covert back into a list    
Counting sort:      
Create an integer array whose index range covers the entire range of values in your array to sort. Each time a value occurs in the original array, you increment the counter at that index.     

    freq_arr = []    
    for x in range(0,100):    #freq array of 100    
        freq_arr.append(0)   
    for i in list:    
        freq_arr[i]+=1   

    my_list.index(item, start, end)    #return index of first occurence of item in list. optional: start / end index    

List slicing:     

    list[start:stop]     #stop not included  
    list[:4]     #start at beginning, print everything up to (not including) the 4th index
    list[1:]     #print list starting from index 1   
    n[::-1]  #start at the end; count down to the beginning, stepping backwards one step at a time    
    n[::3]   #beginning to end, increment by 3   
    n[2:10:3]  # start at 2, go upto 10, count by 3     
    n[4:0:-2]  #start at 4, go down to 0, decrement by 2    
Square matrix:   

    1 2 3   
    3 4 5   
    5 4 6       #0-2 down, 0-2 across. index[0][0] = start   []    
    a[1] #prints a row    


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
    for i in range(start, -1, -1):          #decrement by 1, end at 0      
        break   
### Set and Tuples    
Set: must have unique items   

     myset = {"a", "b", "c"}   
Tuple: 

## Object Oriented Programming Concepts      
OOP - group variables and methods, model and group complex data in a reusable way. This allows us to structure software into reusable blueprints (classes).   
Leverage existing structs (inheritance). Enable class specific behavior (polymorphism).  (encapsulation). Extendible and modular (overloading). 
Classes: creates a format / outline that can be used to create a object with assigned values and properties. Class data = attribute, class functions = methods.       
Instantiation: creating an instance of a class. Ie - class car, creating bobs_car with color blue and year 2010   
Polymorphism: enable class specific behavior. Use a common interface for different types - ie use same function and pass in different variable types.    
Operator overloading: Change meaning of an operator depending on the operator's use. Ex - + for string concat and to add integers. Controls what happens when you compare different objects from the same class. Can overload: plus, minus, multiplication, bitwise operations, mathematical comparisons (greater then, less then).   
Inheritance: lets us leverage existing structs allowing reusability of code. A derived / child class inherits attributes and methods from a parent class. 
Method overriding: method in a child class takes priority of a method with the same name in a parent class. Allows for customization with inherited classes / code reuse.     
Encapsulation: Secures and protect attributes and methods. Organization data / methods in 1 unit (the object).

