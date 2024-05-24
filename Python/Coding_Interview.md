# Python Coding Interview Review     
[Python Coding Interview Review Videos](https://realpython.com/lessons/python-coding-interview-tips-overview/ )    
Practice: leetcode, hackerrank, Cracking the coding interview    
Before the interview: know what language you will program in (ask if you can pick / if a certain language is required), what resources you can use (the Internet?, official documentation?, questions from the interviewers?). These things will guide your preparation.    
[Example Practice Questions](https://blog.finxter.com/wp-content/uploads/2019/02/CheatSheet-Python-6_-Coding-Interview-Questions.pdf)    

During the interview: make pseudocode, ask questions if you get stuck, feel free to narrate your thought process (show your problem solving ability)      
### Ints    
Operations    

    round(int, 2)    #round to the 2nd decimal place     
    num // 2     #round down   
    num % 2    #remainder of number / 2    
    abs(-2)     #return absolute value     
    a+=1   #increment    
    print("{:.6f}".format(value))      #print out value to the 6th decimal place    
    isinstance(a, int)     #return True if a is an interger    
    list(str(int_var))    #convert int to a list of digits   
Boolean Expressions   

    NOR: If a and b equal 0, return True. Else return False.    
    XOR: returns True when a/b are different. Example - a=1, b=0, return True    
    (a and not b) or (not a and b)    #Python XOR    
Binary Numbers   

    binary = bin(int_decimal)    #get binary representation of a number, format 0b1000   
    
### Strings    
Can think of as an array of chars     
Operations:    

    string.split(" ")  #split on a value    
    ''.join(strings)   #join a list of strings   
    string.strip()     #strip off whitespace or a specified char(s)        
    string.upper()     #to all uppercase    
    string.lower()     #to all lowercase     
    s="".join(c for c in s if c.isalnum()) #remove non alphanumeric chars     
    new_string = s.replace(i,"",1)   #remove char from a string, only remove 1 instance     
    a = sorted(s)     #return string sorted       
Substrings:    

    if "ace" in "trace"      
    string[start:end:step]    #end - not included     
    s.find("hi")   #searches string s for a substring and returns starting index    
fstrings: formatted string literals. Easy way to print out strings.   

    f"words and stuff {string_variable} and {age +5}"    
    "words and stuff {} and {}".format(string_variable, age)    #older way of inserting vars    
Check if 2 strings are a palindrome:    

    return string_a == string_b[::-1]    
Strings module:   

    import string    
    string.digits    #returns string of digits only   
    string.ascii_lowercase    #only lowercase chars. See docs for more.     
## Lists    
Common interview questions: reversing a linked list, operations on a list with a given critera, modifying a list in place, testing if 2 words are palindromes        

remove items from a list: pop, remove, del, clear      
Treating a list as a stack: pop(), append(). Queue: pop(), insert()    

    list.pop()	  #removes an item at an index position and returns it, removes last item by default             
    list.remove("item")	#removes the first item matching a value     
    [value for value in nums if value != val]     #remove all occurences of a value        
    slicing: Can be used to delete non-matching ranges of data        
    del statement	 #removes an item at an index position and doesn’t return it       
    del list[0]   #delete element of list   
    list.clear()	#removes all items in a Python list        
Adding to a list:   

    list[0]= 'a'   #update list    
    list.insert(0, "A")   #insert at index of 0      
    list.append("last")   #add to end   Built in functions: max, min, index, count, pop, extend     
    list.push()     #add item to a list  
    new_list = list(range(1,101))      #generate a list from 1 to 100    
    list = [0] * 100    #make a list containing only 0s.    

Enumerating a list:   

    for i in range(len(list)):   #range 0 to len(list), (start,stop)    
        print(i)  

    for count, value in enumerate(values):    #index and value of a list   
        print(count, value)  
Operations:   

    sum(list)      #sum ints in a list    
    max(list)      #return max number in a list     
    max(list, key=square)    #outputs item with the largest square       
    max(list, key=lambda x: x * x)     #outputs item with the largest square using a lambda function   
    min(list)      #return minimum number in a list    
    any(list)      #returns if any of items in iterable are True    
    all(list)      #returns True if all elements in iterable are True    
    list(map(function, list))   #do function to a list without a for loop, returns values   

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
List Comprehensions    

    [<expr> for <elem> in <lst> if <cond>]     
    [function(num) for num in lst]      #return list of function output for each item in lst  
itertools modules: efficient looping   

    import itertools   
    repeat_ex = itertools.repeat(1)
    next(repeat_ex)   #prints 1  
    itertools.cycle   #cycle through iterables   
    itertools.permutations   #find all permutations   
    itertools.combinations   #find all combinations    

### Sorting Lists    
Sorting in-place:     
Modify the input in place, without creating a separate copy of the data structure. An algorithm which is not in-place is sometimes called not-in-place or out-of-place.  
[Comparison Based Sorting Algorithims](https://www.cs.cmu.edu/~avrim/451f11/lectures/lect0913.pdf)    

    list.sort()         #sort list, low to high. Sorts in place - mutates list.       
    sorted(list)       #sort list of ints, low to high. returns a new list    
    sorted(list, reverse=True)   #sort high to low    
    sorted(list, key=lambda list: list['key'])     #sort based on a certain criteria, useful with a list of dicts       
    arr.sort()      #sorts in place, can be finicky      
    my_list = sorted(set(my_list))  #sort unique, only works on hashable types     
    rev_list = list(reverse(list))    

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
Reverse a Linked List: Can use recursion as well       

    #Include LinkedList class   
    prev = None   
    curr_node = self.head    #start at beginning node  
    while (curr_node != NULL):   
        next = curr_node.next      #save next node       
        curr_node.next = prev      #assign current node pointer to previous pointer   
        prev = curr               
        curr_node = next          #look at the next node   
              
Binary tree:    

Graph:    

### Dicts   
Ordered, changeable, does not allow duplicates. Insert and retrieve key-value pairs in constant time.         

    print(dict.get("key"))    
    dict.keys()    
    dict.values()    
    dict.items()     #access key/value pairs     
    max = max(dict.values())
Create a dict using dict() function:    

    nums = dict(one="1", two="2")
    print(nums["one"]) # => "1"   
Get key for the first instance of a certain value:    

        for k, v in counts.items():
            if max_val in v or max_val == v:
                return k   
Loop through items in a dict:   

    for key,val in dict.items():
        print(key + " " + val)   
collections.defaultdict: allows for default values even if the key does not exist in the dict:     

    from collections import default dict   
    dict_ex = defaultdict(lambda = 5)    #if key doesn't exist, value is 10      
collections.Counter    

    from collections import Counter      
    count = Counter("string")
    count['s']    #refers to how many times s occures in the string     
collections.deque: allow for appending to and popping from both left / right in constant time:   

    from collections import deque   
    ex = deque([1,2,3,4])
    ex.appendleft(0)
    ex.append(5)
    ex.popleft()     #returns 0   
    ex.pop() #returns 5      
collections.namedtuple: create tuple-like objects   

    from collections import namedtuple   
    Car = namedtuple("car",["make", "model"])
    a_car = Car(make="Mazda", model="CX")  
    a_car.make    #returns Mazda   
Hash map: unordered collection of key-value pairs stored in a hash table where keys are unique - Java construct, but can use dicts in Python.    

### Set and Tuples    
Set: must have unique items   

     myset = {"a", "b", "c"}   #can be ints, strings or mixed types     

     s = set()    #create a set and add a variable  
     s.add("item")    
Tuple: can't be modified (immutable)    

    zip_tuple = zip(list_1, list2)    #take 2 iertables, put them together in a tuple, and returns    
    #output     [('list 1 item 0', 'list 2 item 0'), ('list 2 item 1', 'list 2 item 1')] etc 

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
### Debugging    
You will have limited debugging ability if you are doing an interview using HackerRank or another online IDE. An interviewer may ask how you could debug code.    

    breakpoint()     #use pdb to set breakpoints    
    #print statement or logging   

## Python Programming Concepts      
OOP - group variables and methods, model and group complex data in a reusable way. This allows us to structure software into reusable blueprints (classes).   
Dynamically typed language: data types are checked during execution.    
Scope: block of code for each object, use objects without any prefix. Ie local scope - scope of a function.    
Leverage existing structs (inheritance). Enable class specific behavior (polymorphism).  (encapsulation). Extendible and modular (overloading). 
Classes: creates a format / outline that can be used to create a object with assigned values and properties. Class data = attribute, class functions = methods.       

    class Car:                      #defining an instance of a class    
       def __init__(self, model, color):
           self.model = model
           self.color = color
Instantiation: creating an instance of a class. Ie - class car, creating bobs_car with color blue and year 2010   
Polymorphism: enable class specific behavior. Use a common interface for different types - ie use same function and pass in different variable types. 

    print(len("string"))   #Example of polymorphism - using different variable types / the same function.    
    print(len(['1','2']))           
Operator overloading: Change meaning of an operator depending on the operator's use. Ex: + can be used for string concatenation and to add integers. Controls what happens when you compare different objects from the same class. You can overload: plus, minus, multiplication, bitwise operations, mathematical comparisons (greater then, less then).     
Function overloading: used in Python and C++, C does not support it. Functions with the same name but different parameters, different behavior based on the arguments passed.     
Inheritance: lets us leverage existing structs allowing reusability of code. A derived / child class inherits attributes and methods from a parent class.          
Method overriding: method in a child class takes priority of a method with the same name in a parent class. Allows for customization with inherited classes / code reuse.     
Encapsulation: Secures and protect attributes and methods. Organize data / methods in 1 unit (the object). Using classes to restrict direct access to methods and variables, which creates private variables and methods. Then use get or set methods to change or access any private data.       
Modularity: can import and use code written by other people. Makes Python more powerful.    
Memory management: built in garbage collection. Handled by the Python Memory Manager. Allocates a private heap space.     

Decorators: add "syntactic sugar", modify behavior of a function without changing the function itself.    
*args and **kwargs: lets you pass an unspecified amount of arguments to a function. kwargs: handle named arguments in a function. Common use case: function decorators.             
Generators: use instead of list comprehensions to conserve memory.        

    gen = (x for x in [1, 2, 3])     
    next(g)   #print out first element, run again to get next  

    #generate using a function   
    def gen(): 
        yield 1
        yield 2

Deconstructors and constructors:    
Deconstructor: called when an object is destroyed. Used more in C++ since Python has a garbage collector that handles memory.      
```
def __del__(self):            #deconstructor declaration. calling 'del obj' will call this function   
    #destroy stuff here   
```
Constructor: instantiating an object. Assigns data to members of the class when an instance is created.     
```
def __init__(self):
    #assign stuff here  
```

lambda function: quickly defined an inline function, like filters.     
