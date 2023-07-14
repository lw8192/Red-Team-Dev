# C    
## Intro   
Lower level language then Python (meaning the developer can control the program at a more granular level - allows for more speed / flexibility but also harder to program in). Compiled. Widely used in OS / embedded environments. Variables - need to define type and name. Strongly typed language: can't change later on. Not object oriented - variables don't have an access modifier (can be static or constants). Static var: valid in a global scope.       
[Codeblocks IDE](https://www.codeblocks.org/)    
## Variables   
Structs: define variables that belong together.   
write to the console - use printf(), %d or %i for integer types, %f for floating-point numbers, %s for strings     

## Memory in C     
C / C++ allows you to interact with memory on a lower level then languages like Python. Misusing memory - can cause segfaults. A common problem: trying to access memory that has already been freed.    
Memory is divided into segments - stack and heap. Stack: Last In First Out data structure, ordered insertion, where program data is stored (functions called, created variables).                       
Heap: allocate big amounts of memory for dev usage, "dynamic memory".     
malloc() - direct call to allocate memory on the heap       
