# C    
## Intro   
Lower level language then Python (meaning the developer can control the program at a more granular level - allows for more speed / flexibility but also harder to program in). Compiled. Widely used in OS / embedded environments - "system development language". Variables - need to define type and name. Strongly typed language: can't change later on. Procedural - code follows an order of execution. Not object oriented language - variables don't have an access modifier (can be static or constants).      
C is fast due to: compiling, strongly typed, no garbage collection.      
[Codeblocks IDE](https://www.codeblocks.org/)    
[Codeblocks Install](https://www.digitalocean.com/community/tutorials/c-compiler-windows-gcc)      
[Cdecl: C gibberish to English](https://cdecl.org/)    
[C Cheatsheet](https://quickref.me/c.html)    
[Codeacademy C cheatsheets](https://www.codecademy.com/resources/cheatsheets/language/c)   
[Beej's Guide to C programming](https://beej.us/guide/bgc/)      
[C Programming Notes](https://www.eskimo.com/~scs/cclass/cclass.html)   

## Variables          
[Reference Chart for Data Types in C](https://www.geeksforgeeks.org/data-types-in-c/#)     
C - must declare variables and give them a type before use. Static var: valid in a global scope.         
Variable types: char, int, float, double, pointer, struct, evaluation strategy, no "string" data type (instead an array of chars). Modifiers: signed, unsigned, short, long.       
C- no boolean operators. Nonzero - true. 0: false.

sizeof(type);  //determines the size of a variable declared with that data type for the target architechure   
int: 4 bytes. float: 4 bytes, single precision floating point. char: 1 byte / 1 char of data. double: double precision floating point.        

### Numbers    
By default: numbers in C are signed (can be both positive and negative). Unsigned: doesn't allow negative numbers. Extend or shorten size of variables using: long or short.           
Operations: +, -, *, /, % (remainder)      
Shorthand: i++ or ++i  increment. i-- or --i : decrement.      
i++: Increment the value of i by 1 after evaluating the arithmetic operation     
++i: Increment the value of i by 1 before evaluating the arithmetic operation.    
Modify variable in place:    

  i = i + 13    i+=13   Add some value to the variable.   
  i = i - 13    i-=13   Subtract some value from the variable.
  i = i * 13    i*=13   Multiply some value by the variable.
  i = i / 13    i/=13   Divide some value from the variable. 
Comparison operators: <, >, <=, >=, ==, !=        

Chain operators:     
OR       ||        ((a < b) || (a < c))       
AND      &&        ((a < b) && !(a < c)   



### Array / Buffers   
Array / buffers: continous block of memory. Acessing memory outside the bounds of an array can corrupt stored date. List of n elements of a specific data type.            

    int arr[5] = {1, 2, 3, 4, 5};
    int* ptr = &arr[0];    
    for(int i = 0; i < 5; i++){
        printf("%i\n", *ptr);    //dereference the pointer and print out each integer in the array    
        ptr++;
    }

    atoi(char * string);    //convert string to an int    
    char array[] = "2007";    //convert int to a array  

    //determine size of an array and how many elements it can contain  
    int arr[5];
    size_t num_of_elements = sizeof(arr)/sizeof(arr[0]);       //numbers of elements array can contain      
### Strings  
String: array of chars. Char: 1 byte.           

    char s[] = "words and stuff";
    printf("%s",s);

    char *ptr = &s[0];
    for (int i=0; i < strlen(s); i++){     //loop to replace all chars in the array with .
        *ptr = '.';
        ptr++;
    } 
String comparisons:   

    //need to use strcmp, == or != will only compare base addresses   
    strcmp(check,input) != 0   
### Pointers   
Pointer: contains address of a storage location of a variable, where the data is in memory (not the actual value of the data). Stores address. Allows direct access and manipulation of a byte in memory.                   
x86 arch: 32-bit memory address, pointers are 4 bytes. Define using: *. Points to data of a type. The compiler will increment a pointer by the size of it's data types(ie incrementing an int pointer will add 4 bytes to the memory address).             
Dereference operator(*): returns the data found in the address the pointer is pointing to, instead of the address itself       
Generic typeless pointer - void pointer, just holds a memory address. Limits: pointers can't be derefenced unless they have a type (compiler needs to know data type to retrieve stored value at memory address), must be typecast before doing pointer arithmatic.    
Pointer examples:   

    int y = 20;
    int *ptr;    //create a integer pointer   
    ptr = &y;    //Set ptr equal to the memory address of a variable. Uses & - the address of operator       
    printf("%p", ptr);    //Prints out pointer - address of the variable in hex.    
    printf("%i",*ptr);    //print out the data the memory address stored in the pointer resolves to  
    *ptr = 25;    //change data of pointer 

    int x = *ptr;  //use dereference operator (*) to assign integer data pointer "points to" to x 
    printf("%i", x);     //print out integer x
Pointer arithmatic: will increase or decrease a pointer by the size of the declared data type. Ex - increase an int pointer by 1 will increase it by 1 x 4 bytes.    

    ptr +=3;    //increases address by 3*(size of the data type in bytes)
    ptr -= 2;   //decrement address by 2    

    #incrementing a pointer - increments by the size of the data type the pointer is   
    int int_array[2]= {1,2}; 
    int *int_pointer; 
    int_pointer = int_array;   //pointer now resolves to the memory address of the start of the array   
    int_pointer++;   //increments pointer by 4 bytes, resolving to the memory address of the next integer in the array     

Double pointer: pointer to a pointer   

    int **p;   //create a double pointer  
### Struct  
Structure: groups variables under a single defined type. Similar to a Python object. Custom data type.      

    struct ex {
        int x;
        char a;
        ex;
    }
    struct ex e;
    e.x = 3;
    e.a = 'd'; 
### Typecasting    
Typecasting: temporarily change a variable’s data type, despite how it was originally defined.      

        (typecast_data_type) variable   
Typecasting: helpful with pointers. C compiler needs a data type for every pointer to try and limit programming errors. Int pointer: should only point to int data. Char pointer should only point to char data.         
Generic typeless pointer - void pointer, that just holds a memory address. Limits: pointers can't be derefenced unless they have a type (compiler needs to know data type to retrieve stored value at memory address), must be typecast before doing pointer arithmatic. Typecasting is helpful in those situations.        

### Format Strings   
Format strings: char string with an escape sequence that printf() uses to insert vars in a specific format. Escape sequences / format parameters, begins with a %, uses a single char shorthand.      
write to the console - use printf(), %d or %i for integer types, %f for floating-point numbers, %s for strings       

    %[flags][width][.precision][length]specifier        
printf() using format strings:   
```
%x or %X           Hex   
%p                 Pointer   
%s                 String        
%c                 Char   
%d                 Signed int 
%f                 floats
```
Format parameters that expect pointers:   

    %s    string          #prints data at a given memory address until a null byte is encountered. Expects pointer to string, pass by reference
    %n    number of bytes written so far      #expects to be given a memory address, and it writes the number of bytes that have been written so far into that memory address   
Using format strings to write to a pointer or array by using sprintf or snprintf. Snprintf is safer because it requires a max limit of chars to write:      

    snprintf(buffer, 15, "%s", x);   //write string s to a buffer 
Command Line Arguments:     

    int main(int argc, char *argv[]){
      // passed into main. argc - args count, argv - list of args. argv[0] is the program name       
    }

## Functions    
Function needs to be defined or a function prototype used so the compiler can locate it. No return value: void function.       

    int math_func(it);    //Function prototype: name, return data type, data types as functional arguments.         

    int main(){
        //example main function   
        return 0; 
    }
Pass by reference: pass address of a variable into a function, then functions modifies the data at the address.    

### Common C Functions and Libraries   
Libraries:   

    #include <stdio.h> - library for input / output functions. printf(), scanf()      
    #include <Windows.h>      //Windows API calls     
    #include <stdlib.h>       //memory functions   
Functions:   

    //Unsafe C functions: strcpy() & stpcpy(), gets(), strcat() & strcmp(), sprintf().    
    //built in C functions: strcpy(), strlwr(), strcmp(), strlen(), strcat()     
    strcpy(dest, src);  //copy a string from a source to a destination, copying each byte to the destination (stopping after it copies the null termination byte).      
    sizeof() - determine size of a variable declared with that data type for the target architechure.     
    scanf(); //used for input, expects all args to be pointers      
    malloc();  //allocate memory on the heap, returns void pointer (need to typecast), null if not sucessful. Every malloc call - error check to see if successful.   
### Using Command Line Arguments   
Access command line args in C by including an int and a array of strings - int is the count of the arguments, array is the actual args passed. argv[0] = name of executing binary.   
Using command line arguments: 

        int main(int argc, char *argv[]){
            if (argc < 2){         //error checking if the program execution depends on args. 
                printf("usage message here"); 
            }
            arg = atoi(argv[1]);   //convert the 2nd arg to an int   
        }
### Function Variable Scoping  
Scoping: context of variables within functions. Each function has its own set of local variables, which are independent of everything else (including multiple calls to the same function).     

## Memory in C     
Little Endian architechure: x86 processors stores values in little endian byte order (the least significant byte is stored first).    
Memory of a program is divided into five segments: text, data, bss, heap, and stack.    
```
Higher memory addresses 
--- Kernel ---
--- Stack ---  
--- Heap ---
--- BSS --- 
--- Data ---
--- Text ---
Lower memory addresses  
```
### Registers     
EIP / RIP (x86 / x64)- Instruction Pointer: pointer that points to the current instruction, contains memory address.     
First four registers: general purpose. EAX, ECX, EDX, EBX (Accumulator, Counter, Data, Base). Acts as temporary variables for the CPU when executing machine instructions.    
2nd four general purpose: ESP, EBP, ESI, EDI (Stack Pointer, Base Pointer, Source Index, Destination Index). General purposes - pointers and indexes.    
ESP: points to the "top of the stack." EBP: points to the base of the current stack frame.    
### Interacting with Memory in C   
C / C++ allows you to interact with memory on a lower level than languages like Python. Misusing memory - can cause segfaults. A common problem in C: trying to access memory that has already been freed. Not freeing memory - can lead to a memory leak.       
Unlike other languages, C has no garbage collector to deallocate / free memory, so the developer must do so manually using memory allocation functions.         
Memory addresses: 32 bits / 8 bytes on a x86 system    
Memory Structure (high to low address, going down):     
    Command Line Arguments    
    Stack    
    Heap       
    Uninitialized Data Segment (BSS)       
    Initialized Data Segment      
    Text/Code Segment        
Stack: First In Last Out data structure, ordered insertion, where program data is stored (functions called, created variables). It maintains execution flow and local variable context for function calls. It grows down (towards the heap and lower memory addresses). The stack allows the instruction pointer (EIP or RIP) to return through long chains of function calls, using stack frames. Stack frame: built for a function, contains it's local variables and a return address so the instruction pointer can be restored.       

    #typical stack frame can vary with different compilers but below is a general outline      
    High memory address ("base of stack")
    -- Main()'s stack frame -- 
    -- Arguments --   
    -- Return address -- 
    -- EBP (base pointer for the current stack frame) -- 
    -- Local variables -- 
    Low memory address ("top of the stack" - ESP)    
Function prologue: saves the frame pointer on the stack and saves stack memory for the local function variables. Each prologue instructions varies depending on the compiler and compiler options.     
Heap: allocate big amounts of memory for dev usage, dynamic memory that the programmer can change. Grows up (towards stack). Changes in size.           
Permanent storage / Static memory: segments, copied to program memory on execution.    

Allocating Dynamic Memory    
A program explicitly requests the allocation of a block of memory via a system call. Used to optimize program memory, when variable memory sizes are needed, etc. Functions are defined in <stdlib.h>.       

    char *ptr = malloc(sizeof(int)); //direct call to allocate memory on the heap, size in bytes as an argument     
    calloc(num, size); //allocate memory given fixed number of objects of a given fixed size    
    free(); //release memory   
    realloc(ptr, new_size); //extend or shrink previously allocated memory. Extends existing block or allocates a new section of memory as needed.       
    sizeof(type);    //sizeof expression: returns size in bytes (size_t) of a variable

Use a Pointer to refer to dynamically allocated memory   

    struct ex *ptr = (struct ex *) malloc(sizeof(struct ex));   //allocated space to hold struct ex    
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
     

## Compiling   
GCC (GNU Compiler Collection): free compiler translating C into machine language.     
### Linux   

    gcc cprogram.c -o cprogram.out     
### Windows   
 
Can compile in a WSL shell using gcc    
[Visual Studio Install](https://visualstudio.microsoft.com/vs/older-downloads/) - recommend VS 2019 because it is less resource intensive then newer versions.     
Run VS Code Installer > Modify or More > Ensure C++ Applications is selected (maybe Python as well for dev things)      
VSCode > create a new project > Project Template: Console Application C++, rename file to Main.c > Local Windows debugger (choose x64 or x86) -> Compile and run    
         
Using [MingW](https://www.mingw-w64.org/)    
