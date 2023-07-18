# C    
## Intro   
Lower level language then Python (meaning the developer can control the program at a more granular level - allows for more speed / flexibility but also harder to program in). Compiled. Widely used in OS / embedded environments - "system development language". Variables - need to define type and name. Strongly typed language: can't change later on. Procedural, not object oriented language - variables don't have an access modifier (can be static or constants). Static var: valid in a global scope.       
[Codeblocks IDE](https://www.codeblocks.org/)    

## Variables   
Variable types: char, int, float, double. Modifiers: signed, unsigned, short, long.   
Pointer, struct, evaluation strategy.   
Pointer: containers address of a storage location of a variable, where the data is in memory (not the actual value of the data). Stores address.    
Structure: groups variables under a single defined type. Similiar to a Python object.     

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
Stack: Last In First Out data structure, ordered insertion, where program data is stored (functions called, created variables). Grows down (towards heap).                          
Heap: allocate big amounts of memory for dev usage, dynamic memory that the programmer can change. Grows up (towards stack). Changes in size.           
Permanent storage / Static memory: segments, copied to program memory on execution.    

Allocating Dynamic Memory    
A program explicitly requests the allocation of a block of memory via a system call. Used to optimize program memory, when variable memory sizes are needed, etc.   
malloc(size); //direct call to allocate memory on the heap, size in bytes as an argument     
calloc(num, size); //given fixed number of objects of a given fixed size    
free(); //release memory   
realloc(ptr, new_size); //extend or shrink previously allocated memory   

Use a Pointer to refer to dynamically allocated memory   

    struct ex *ptr = (struct ex *) malloc (sizeof (struct ex));   //allocated space to hold struct ex    
Example of allocating and freeing memory:   

    #include <stdio.h>   
    #include <stdlib.h> 
    int main(void) 
    {
        int *pointr = malloc(4*sizeof(int));  // allocates memory - array of 4 ints   
    
        if(pointr) {
            for(int n=0; n<4; ++n) // populate the array
                pointr[n] = n*n;
            for(int n=0; n<4; ++n) // print it back out
                printf("[%d] == %d\n", n, pointr[n]);
        }
    
        free(pointr); //free allocated memory   
    }

## C Libraries    
stdio.h - library for input / output functions. printf(), scanf()     
write to the console - use printf(), %d or %i for integer types, %f for floating-point numbers, %s for strings   

#include <Windows.h>      //Windows API calls     
<stdlib.h>       //memory functions   

    
