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

# Reverse Engineering Interview Prep          
Process injection: CreateRemoteThread        
Process migration:      
Process hollowing:    
Reflective DLL injection:       
Shellcoding     
Anti debugging techniques:   