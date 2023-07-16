# C    
## Intro   
Lower level language then Python (meaning the developer can control the program at a more granular level - allows for more speed / flexibility but also harder to program in). Compiled. Widely used in OS / embedded environments - "system development language". Variables - need to define type and name. Strongly typed language: can't change later on. Procedural, not object oriented language - variables don't have an access modifier (can be static or constants). Static var: valid in a global scope.       
[Codeblocks IDE](https://www.codeblocks.org/)    

## Variables   
Structs: define variables that belong together.   
pointers: directly access areas in memory   


## Memory in C     
C / C++ allows you to interact with memory on a lower level then languages like Python. Misusing memory - can cause segfaults. A common problem: trying to access memory that has already been freed.    
Unlike other languages, C has no garbage collector to deallocate / free memory, so the developer must do so manually.        

Memory Structure (high to low address, going down):     
    Command Line Arguments 
    Stack 
    Heap 
    Uninitialized Data Segment (BSS)   
    Initialized Data Segment   
    Text/Code Segment   
Stack: Last In First Out data structure, ordered insertion, where program data is stored (functions called, created variables).                       
Heap: allocate big amounts of memory for dev usage, "dynamic memory".     

malloc() - direct call to allocate memory on the heap     
free() - release memory   
## C Libraries    
stdio.h - library for input / output functions. printf(), scanf()     
#include <Windows.h>      //Windows API calls     
write to the console - use printf(), %d or %i for integer types, %f for floating-point numbers, %s for strings   
Include Windows API functions: 

    
