# Python Coding Interview Review     
Practice: leetcode, hackerrank, Cracking the coding interview    
Before the interview: know what language you will program in (ask if you can pick / if a certain language is required), what resources you can use (the Internet?, official documentation?, questions from the interviewers?). These things will guide your preparation.    
[Example Practice Questions](https://blog.finxter.com/wp-content/uploads/2019/02/CheatSheet-Python-6_-Coding-Interview-Questions.pdf)    

During the interview: make pseudocode, ask questions if you get stuck, feel free to narrate your thought process (show your problem solving ability)      
### Ints    
Operations    

    round(int, 2)    #round to the 2nd decimal place     
    abs(-2)     #return absolute value     
    a+=1   #increment    
    print("{:.6f}".format(value))      #print out value to the 6th decimal place    
Boolean Expressions   

    NOR: If a and b equal 0, return True. Else return False.    
    XOR: returns True when a/b are different. Example - a=1, b=0, return True    

### Strings    
Can think of as an array of chars     
Operations:    

    string.split(" ")  #split on a value    
    string.strip()     #strip off whitespace or a specified char(s)        
    string.upper()     #to all uppercase    
    string.lower()     #to all lowercase     
    s="".join(c for c in s if c.isalnum()) #remove non alphanumeric chars     
    new_string = s.replace(i,"",1)   #remove char from a string, only remove 1 instance     
    a = s.sorted()     #return string sorted       
Substrings:    

    if "ace" in "trace"      
    string[start:end:step]    #end - not included     
    s.find("hi")   #searches string s for a substring and returns starting index    
    
## Lists    
Common interview questions: reversing a linked list, operations on a list with a given critera, modifying a list in place, testing if 2 words are palindromes        

remove items from a list: pop, remove, del, clear      
Treating a list as a stack: pop(), append(). Queue: pop(), insert()    

    list.pop()	  #removes an item at an index position and returns it, removes last item by default             
    list.remove("item")	#removes the first item matching a value       
    slicing: Can be used to delete non-matching ranges of data        
    del statement	 #removes an item at an index position and doesn’t return it       
    del list[0]   #delete element of list   
    list.clear()	#removes all items in a Python list        
Adding to a list:   

    list[0]= 'a'   #update list    
    list.insert(0, "A")   #insert at index of 0      
    list.append("last")   #add to end   Built in functions: max, min, index, count, pop, extend     
    list.push()     #add item to a list   
Operations:   

    sum(list)      #sum ints in a list    
    max(list)      #return max number a list     
    min(list)      #return minimum number in a list    
Remove duplicates from a list:   

    a_list = ["a", "b", "a", "c", "c"]
    a_list = list( dict.fromkeys(a_list) )  #make a dict which removes duplicates, then covert back into a list    
    new_list = list(set(lst))       #remove duplicates from a list using set, then convert back into a list          

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
### Sorting Lists    
Sorting in-place:     
Modify the input in place, without creating a separate copy of the data structure. An algorithm which is not in-place is sometimes called not-in-place or out-of-place.  
[Comparison Based Sorting Algorithims](https://www.cs.cmu.edu/~avrim/451f11/lectures/lect0913.pdf)    

    list.sort()         #sort list, low to high. Sorts in place, can be finicky.   
    sorted(list)       #sort list of ints, low to high. returns a new list    
    sorted(list, reverse=True)   #sort high to low    
    arr.sort()      #sorts in place, can be finicky      
    my_list = sorted(set(my_list))  #sort unique, only works on hashable types     
    rev_list = list(reverse(list))

Enumerating a list:   

    for count, value in enumerate(values):    #has index and value of a list   
        print(count, value)      

Counting sort:      
Create an integer array whose index range covers the entire range of values in your array to sort. Each time a value occurs in the original array, you increment the counter at that index.     

    freq_arr = []    
    for x in range(0,100):    #freq array of 100    
        freq_arr.append(0)   
    for i in list:    
        freq_arr[i]+=1   

    my_list.index(item, start, end)    #return index of first occurence of item in list. optional: start / end index       

Linked List:     
Stores data in the form of a chain, each node stores data and the address of the next node. Head: first node, tail: last node. Single-linked list: links 1 way (head to tail), double: links both ways. Circular: tail points back to head.        
Insert a node at the front:   

    new_head = Node(stuff)
    #Make next of new Node as head
    new_head.next = self.head     
    #Move the head to point to new Node     
    self.head = new_head     
Insert after a given node:   

    #Check to see that the node isn't 0    
    #Make a new node    
    new_node = Node(data)
    new_node.next = prev_node.next        #new node know links to the node after previous         
    prev_node.next = new_node             #previous node now points to the inserted node    

Binary tree:    

Graph:    

### Dicts   
Ordered, changeable, does not allow duplicates.     

    print(dict.get("key"))    
    dict.keys()    
    dict.values()    
    max = max(dict.values())
Hash map: unordered collection of key-value pairs stored in a hash table where keys are unique - Java construct, but can use dicts in Python.    
Create a dict using dict() function:    

    nums = dict(one="1", two="2")
    print(nums["one"]) # => "1"   
Get key for the first instance of a certain value:    

        for k, v in counts.items():
            if max_val in v or max_val == v:
                return k

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

     myset = {"a", "b", "c"}   #can be ints, strings or mixed types     
Tuple: 

## Object Oriented Programming Concepts      
OOP - group variables and methods, model and group complex data in a reusable way. This allows us to structure software into reusable blueprints (classes).   
Leverage existing structs (inheritance). Enable class specific behavior (polymorphism).  (encapsulation). Extendible and modular (overloading). 
Classes: creates a format / outline that can be used to create a object with assigned values and properties. Class data = attribute, class functions = methods.       
Instantiation: creating an instance of a class. Ie - class car, creating bobs_car with color blue and year 2010   
Polymorphism: enable class specific behavior. Use a common interface for different types - ie use same function and pass in different variable types. 

    print(len("string"))   #Example of polymorphism - using different variable types / the same function.    
    print(len(['1','2']))           
Operator overloading: Change meaning of an operator depending on the operator's use. Ex: + can be used for string concatenation and to add integers. Controls what happens when you compare different objects from the same class. You can overload: plus, minus, multiplication, bitwise operations, mathematical comparisons (greater then, less then).   
Inheritance: lets us leverage existing structs allowing reusability of code. A derived / child class inherits attributes and methods from a parent class.          
Method overriding: method in a child class takes priority of a method with the same name in a parent class. Allows for customization with inherited classes / code reuse.     
Encapsulation: Secures and protect attributes and methods. Organize data / methods in 1 unit (the object). Using classes to restrict direct access to methods and variables, which creates private variables and methods. Then use get or set methods to change or access any private data.       
