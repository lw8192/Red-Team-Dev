# C    
## Intro   
Lower level language then Python (meaning the developer can control the program at a more granular level - allows for more speed / flexibility but also harder to program in). Compiled. Widely used in OS / embedded environments - "system development language". Variables - need to define type and name. Strongly typed language: can't change later on. Procedural - code follows an order in execution. Not object oriented language - variables don't have an access modifier (can be static or constants). Static var: valid in a global scope. 
C is fast due to: compiling, strongly typed, no garbage collection.           
[Codeblocks IDE](https://www.codeblocks.org/)    
[Codeblocks Install](https://www.digitalocean.com/community/tutorials/c-compiler-windows-gcc)   

## Data Types       
[Reference Chart for Data Types in C](https://www.geeksforgeeks.org/data-types-in-c/#)     
Variable types: char, int, float, double. Modifiers: signed, unsigned, short, long.   
char: 1 byte / 1 char of data. float: single precision floating point. double: double precision floating point.          
Pointer, struct, evaluation strategy.   
Array: continous block of memory. Acessing memory outside the bounds of an array can corrupt stored date.         

    int arr[5] = {1, 2, 3, 4, 5};
    int* ptr = &arr[0];    
    for(int i = 0; i < 5; i++){
        printf("%i\n", *ptr);    //dereference the pointer and print out each integer  
        ptr++;
    }

    atoi(char * string);    //convert string to an int    
String: array of chars      

    char s[] = "words and stuff";
    printf("%s",s);

    char *ptr = &s[0];
    for (int i=0; i < strlen(s); i++){     //loop to replace all chars in the array with .
        *ptr = '.';
        ptr++;
    } 
Pointer: contains address of a storage location of a variable, where the data is in memory (not the actual value of the data). Stores address. Allows direct access and manipulation of a byte in memory.        

    int y = 20;
    int *ptr;    //create a integer pointer   
    ptr = &y;    //Set ptr equal to the memory address of a variable    
    printf("%p", ptr);    //Prints out pointer - address of the variable in hex.    
    printf("%i",*ptr);    //print out data pointer "points to" 
    *ptr = 25;    //change data of pointer 

    int x = *ptr;  //use dereference operator to assign integer data pointer "points to" to x 
    printf("%i", x);     //print out integer x

    ptr +=3;    //increases address by 3*(size of the data type in bytes)
    ptr -= 2;   //decrement address by 2 

Double pointer: pointer to a pointer   

    int **p;   //create a double pointer  
Structure: groups variables under a single defined type. Similar to a Python object. Custom data type.        

## Memory in C     
C / C++ allows you to interact with memory on a lower level than languages like Python. Misusing memory - can cause segfaults. A common problem: trying to access memory that has already been freed.    
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
A program explicitly requests the allocation of a block of memory via a system call. Used to optimize program memory, when variable memory sizes are needed, etc. Functions are defined in <stdlib.h>.       
malloc(size); //direct call to allocate memory on the heap, size in bytes as an argument     
calloc(num, size); //given fixed number of objects of a given fixed size    
free(); //release memory   
realloc(ptr, new_size); //extend or shrink previously allocated memory. Extends existing block or allocates a new section of memory as needed.       
sizeof(type), sizeof expression: returns size in bytes (size_t) of a variable

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
built in C functions: strcpy(), strlwr(), strcmp(), strlen(), strcat()    

#include <Windows.h>      //Windows API calls     
<stdlib.h>       //memory functions   

## Compiling   
### Linux   

    gcc .cprogram.c -o cprogram.out     
### Windows   
 
Can compile in a WSL shell using gcc    
[Visual Studio Install](https://visualstudio.microsoft.com/vs/older-downloads/) - recommend VS 2019 because it is less resource intensive then newer versions.     
Run VS Code Installer > Modify or More > Ensure C++ Applications is selected (maybe Python as well for dev things)      
VSCode > create a new project > Project Template: Console Application C++, rename file to Main.c > Local Windows debugger (choose x64 or x86) -> Compile and run    
         
Using [MingW](https://www.mingw-w64.org/)    
