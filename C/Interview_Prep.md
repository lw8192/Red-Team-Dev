# Software Development Interview Prep Notes     
## Concepts          
Software Development Lifecycle Steps:   
- Planning   
- Requirements gathering and analysis   
- Design 
- Coding and Implementation   
- Testing   
- Deployment   
- Maintenance    

Agile software development: iterative, stages: ideation, development, testing, deployment, and operations     

Cross compiler: compile code for a different architechure / system then it is being developed on.    
Toolchain: set of compiler + linker + any tools needed to produce an exe for a target.    

Stack: LIFO, pop / push operations. Each function has a stack frame storing its local arguments, stored after the return address. When a function is returned, the stack pointer points to the return address and the that value is put into the instruction pointer (ret operation).         
Heap: memory managed by the programmer, allocated using malloc() / free() and derivative functions.         
Calling conventions: describes how args are passed to fctns, how values are ret'd, how caller / callee cleans up the stack, function prologue / epilogue.      
cdecl, fastcall, standardcall: 

Object oriented programming: model that centers on data fields w/ attributes (variables) and behaviors (functions). C is not object oriented, Python is.        
Polymorphism: 

OSI model layers: physical, data link, network, transport, session, presentation, application.    

Big O notation - complexity of an algorithim, how long it takes to run. Algorithims are usually in these general classes (best to worst speed): constant time, logarithmic, linear, polynomial, exponential, factorial.            

Data Structures     
Singly linked list: each node has a data piece and a pointer to the next node in the list. Need to start with the head of the list and iterate through it to find a certain data variable, easy to pop / push items.     
Doubly linked list: common with Windows software, each node has a data variable, pointer to the previous node, and pointer to the next node. Uses head and tail variables to start.           
Queue: FIFO, stores elements sequentially. Often used for multithreading.       
Binary trees:       

Checksum: divide buffer into binary string of a block size, add the strings together. Checksum = 1s complement of that value.  

## Bitwise Operations      
1 byte = 8 bits, 2 bytes = 16 bits, 4 bytes = 32 bits, 8 bytes = 64 bits      
Signed / unsigned numbers. Signed: highest bit is the signed bit, 1 = negative, 0 = non negative. Unsigned - all digits are used, can't represent negative numbers, can rep 2x the value of a signed int. C - default is signed.         
Binary representation of a number - machine number is signed number.        
Inverse of a number - flipped bits if negative, except for the sign bit.    
2s complement of a number = flipped bits + 1      
Bitwise operators:       
AND - & (true if both bits are set)       
OR - | (true if 1 of the bits is set)     
XOR - ^ (true if the bits are not the same)     
NOT - ~ (flips bits)     
Shifts: arithmatic and logical shifts.         
Left shift: << shifts to the left, high bits are discarded and low bits are 0. Arithmatic and logical shifts are the same. Shift to left by k - like computing 2^k, but still need to be aware of overflow.               
Right shift: >> shifts to the right. Arithmatic: filled in bits are the highest bit. Logically: filled in bits are 0. In C - signed types shift arithmatic right, unsigned types shift logical right. Like division - arithmatic right by k = num / 2^k.                  


# Reverse Engineering Interview Prep          
Process injection: CreateRemoteThread        
Process migration:      
Process hollowing:    
Reflective DLL injection:       
Shellcoding     
Anti debugging techniques:   