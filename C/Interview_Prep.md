# Software Development Interview Prep Notes     
- [Software Development Interview Prep Notes](#software-development-interview-prep-notes)
  * [Concepts](#concepts)
  * [Data Structures](#data-structures)
  * [Calling conventions](#calling-conventions)
    + [x64 Calling Conventions](#x64-calling-conventions)
  * [Assembly](#assembly)
  * [C Programming](#c-programming)
    + [Allocating Memory](#allocating-memory)
  * [Networking](#networking)
  * [Crypto for data at rest / data in transit](#crypto-for-data-at-rest---data-in-transit)
    + [How do processes communicate?](#how-do-processes-communicate-)
  * [Multithreading](#multithreading)
    + [Pthreads](#pthreads)
    + [Mutex vs Critical Section in Windows](#mutex-vs-critical-section-in-windows)
  * [Bitwise Operations](#bitwise-operations)
  * [Debugging](#debugging)
  * [Stack and heap attacks](#stack-and-heap-attacks)
    + [Buffer overflows](#buffer-overflows)
    + [Off by one vulnerabilities](#off-by-one-vulnerabilities)
    + [Memory leaks](#memory-leaks)
    + [Format string attacks](#format-string-attacks)
    + [Stack Canaries](#stack-canaries)
  * [Memory Protections](#memory-protections)
    + [DEP](#dep)
    + [K/ASLR](#k-aslr)
    + [PIE](#pie)
    + [CFG](#cfg)
    + [PatchGuard / KPP (kernel Patch Protection)](#patchguard---kpp--kernel-patch-protection-)
    + [SMEP / SMAP:](#smep---smap-)
  * [Portable Executable (PE) Files](#portable-executable--pe--files)
  * [Windows Internals](#windows-internals)
    + [Windows Kernel](#windows-kernel)
  * [Windows Offensive Tooling](#windows-offensive-tooling)
    + [Native API](#native-api)
    + [Windows API](#windows-api)
    + [Common Techniques](#common-techniques)

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

Object oriented programming: model that centers on data fields w/ attributes (variables) and behaviors (functions). OOP groups variables and methods, model and group complex data in a reusable way that allows us to structure software into reusable blueprints (classes). C is not object oriented, Python is.        
OOP Fundamentals:     
Leverage existing structs (inheritance). Enable class specific behavior (polymorphism). Bundle data with methods that work on that data (encapsulation). Extendible and modular (overloading). Classes: creates a format / outline that can be used to create a object with assigned values and properties. Class data = attribute, class functions = methods.     

Scope: block of code for each object, use objects without any prefix. Ie local scope - scope of a function.     

Big O notation - complexity of an algorithim, how long it takes to run. Algorithims are usually in these general classes (best to worst speed): constant time, logarithmic, linear, polynomial, exponential, factorial.        

## Data Structures   
Stack: LIFO, pop / push operations. Each function has a stack frame storing its local arguments, stored after the return address. When a function is returned, the stack pointer points to the return address and the that value is put into the instruction pointer (ret operation).         
Heap: memory managed by the programmer, allocated using malloc() / free() and derivative functions.    
Singly linked list: each node has a data piece and a pointer to the next node in the list. Need to start with the head of the list and iterate through it to find a certain data variable, easy to pop / push items.     
Doubly linked list: common with Windows software, each node has a data variable, pointer to the previous node, and pointer to the next node. Uses head and tail variables to start.           
Queue: FIFO, stores elements sequentially. Often used for multithreading.       
Binary trees:     

## Calling conventions   
Describes how args are passed to fctns, how values are ret'd, how caller / callee cleans up the stack, function prologue / epilogue.      
stdcall: standard call, args of a function are pushed onto the stack from right to left. Callee cleans the stack.        
cdecl: C declaration, args of a function are pushed onto the stack from left to right. Caller cleans the stack.      
Windows C++ programs: usually stdcall calling convention. Can be changed.       
x86 function prologue: pushes ebp onto the stack, esp into ebp. Not necessary, used by the compiler for security.        
Function prologue: incrementing the stack pointer to make room on the stack. function epilogue: clean up      
### x64 Calling Conventions        
- Arguments are passed using registers instead of the stack. Windows - RCX, RDX, R8, R9 etc from left to right, shadow store space is allocated on the call stack for callees to save those registers to restore after fctn call. Linux - RDI, RSI, RDX, RCX       
- Caller cleans the stack (like cdecl)      
- The stack is aligned to a 16 bytes boundary.  

## Assembly   
mov vs lea:      
mov eax, [ebx]     ;mov - copies data at address into dest.        
lea eax, [ebx]     ; lea - copies address at ebx into eax   

xor eax, eax       ; zero a register    

cmp vs test: cmp - subtracts 1 operand from another, sets status flags. Test - computes logical AND and sets SF, ZF and PF flags.     

Global vs local vars looking at asm:     
Mostly global variable are allocated or declared in .data or .rdata sections of the program. So, they are called directly by their address. For ex: mov eax, 0x80903030.     
Local variable are allocated in stack and usually called using offset of ebp or esp. For ex: mov eax, [esp-10]. 

## C Programming   
Pointers: variable that holds an address in memory.     
Pointer arithmatic: ptr++, increases by the size of the data type. Incrementing an int ptr - increases by 4 bytes.    
Struct vs union: struct - can have diff variables, can set values for each variable, allocated mem is sum of variable sizes. Union - can only set the value of 1 variable at a time from the present variables.   
### Allocating Memory    
malloc() / calloc() - allocate dynamic memory on the heap. Wrapper around brk/sbrk(default mem allocator)  system call in linux and VirtualAlloc api call on Windows. Uses brk to allocate memory and store the chunk meta info.       
free() - adds chunk to free memory link list. Can cause "use after free" errors.      
"use after free" - pointer is freed then code tries to use the variable.  

## Networking   
OSI model layers: physical, data link, network, transport, session, presentation, application.    

Types of sockets: raw (specially crafted packet), datagram (UDP), stream (TCP)    

Checksum: divide buffer into binary string of a block size, add the strings together. Checksum = 1s complement of that value. Commonly used to check integrity of a packet.     
## Crypto for data at rest / data in transit         
At rest: different libraries you can use depending on the platform / OS like Crypto++, Libsodium.      
In transit: use a library like OpenSSL (used for HTTPS often) or liblithium, download appropriate packages, read documentation and get to work.              
Unless you are a professional w/ a large code base - don't implement your own encryption.  
### How do processes communicate?      
Windows - COM object, pipes (anonymous pipes and named pipes).       
Named pipes: transfer data between unrelated processes (not parent/child) and processes on different computers.     
RPC - function level interface, support to communicate w/ other OS.     
Messaging queues: system passes info to a process using a messaging queue.  

## Multithreading       
Creating a thread: creates a peer (not child to a parent process like in multiprocessing).    
Thread safety: a function is thread safe when it has correct results when it is invoked by multiple concurrent threads at the same time. Functions called from a thread must also be thread safe.         
Synchronization primitives: mutexes, semaphores     
Mutex (mutual exceptions): protects a section of code from being run at the same time by different threads. Used to protected a shared resource (ie a file) from being accessed and modified by multiple threads at the same time. Can be accquired or released.           
Conditional variables: a condition to be checked that allows for threads to go to sleep until an event on another thread occurs. Can be used to send a signal between threads.    
### Pthreads           
Pthread mutexes: provides mechanism to solve mutual exclusion, ensure threads access shared state in a controlled way.       
### Mutex vs Critical Section in Windows       
Mutex needs kernel level permission to work. Mutexes can be shared between processes. Critical section: only 1 process, but only switches to kernel mode in case of contention.  

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

## Debugging   
.pdb file - symbol file, used for debugging. Can be loaded in WinDbg    
breakpoints: software (int 3 /0xcc), hardware (using the debug registers), memory (guard pages), conditional (debugger specific)       

## Stack and heap attacks         
### Buffer overflows     
Buffer bounds are not checked allowing an attacker beyond the variables location on the stack - to overwrite the stored return address, allowing control over EIP/RIP and program execution.          
### Off by one vulnerabilities     
[Off-by-One exploitation tutorial](https://www.exploit-db.com/docs/english/28478-linux-off-by-one-vulnerabilities.pdf)
program will write one byte outside the bounds of the space allocated to hold this input. Either an adjacent variable to the input buffer will be modified or the saved frame pointer (EBP) stored on the stack.     
when a buffer overflow is executed once more then it should be.            
Ex -     
```
for (i = 0; i <= 128; i++){}        //using this instead of below loop. 
for (i = 0; i < 128; i++){}       
//If working with little-endian format, we will overwrite the least significant byte of the saved EBP with a null byte by entering as payload 128 A’s.    
//EBP could change from  0xbffff542 to 0xbffff500. 
//we should set the address of the shellcode and must be in the corrupted EBP – 4 address
```
### Memory leaks        
### Format string attacks     
Format parameter: Escape sequences - begins with a %, uses a single char shorthand. Common format parameters: %d, %u, %x, %p.           
Is user input passed to printf, scanf or similiar functions in a way you can control?          
### Stack Canaries       
Stack Canary / stack cookie / stack smashing protector: adds a value in front of the instruction pointer, this value will be checked before returning. Is generated per-process, first byte is usually a null byte so you can't easily leak it.
Work around stack canaries: if you have a relative or absolute write to memory you don't need to write the canary. You may be able to leak the canary, if you can read memory. If the return is not immediately or never called, you might be able to overwrite the null byte and leak the canary.         
/GS: Windows compiler option that enables a stack canary / security cookie. /GS-: to disable.        

## Memory Protections    
### DEP      
NX/DEP: Non execution / data execution prevention. Usually done at the hardware level, marks a region of memory as not executable. You can use ROP techniques to bypass it or find a memory region that is RWX.
NX: Nonexecutable Stack, Linux. Defines memory regions as instructions or data - your input gets stored as data and can't be executed. ret2libc - Linux NX bypass.
DEP: Data Execution Prevention, Windows version of NX, the CPU will not execute code in the heap or stack.     
Common DEP bypass - ROP (return orinted programming), find a memory region that is RWX.       
### K/ASLR      
ASLR: address space layer randomization. Instead of preventing execution on the stack - randomize the stack memory layout. Attacker won't know where the waiting shellcode is to return execution into it. ASLR takes a segment which is going to exist in the new process, checks if it has a fixed address requirement - if it doesn't ASLR applies a random page offset.                   
ASLR is a setting of the OS. When a program or library is loaded, ASLR will apply to every memory segment it can. The stack / heap will always be random. The randomization happens at load time - to perform an address leak it needs to be as the same program is running.        
Windows - randomizes addresses on system level programs at boot time.       
Memory pages need to be aligned, so you know the lowest 12 bits. x86: restricted address space (PIE base only has 8 bits of randomization).       
Defeating ASLR: info leak vulnerability (ie format string vulnerability that can leak an address), brute force an address (possible on 32 bit since the address space is limited), find a DLL without ASLR enabled.           
### PIE    
PIE - Position Independent Executables (PIE), protects against ROP attacks. The binary and it's dependancies are loaded into random locations in virtual memory each time the program is executed. The binary stores rip-relative offsets and relocations instead of any pointers. PIE generates code that finds things by offset, instead of by hardcoded memory addresses. Compile with PIC (Position Independent Code) to generate a PIE (Position Independent Executable). Once you know the base of a PIE - you know where all the functions are.
PIE is a setting of the binary code section in the program file. It is used mostly for building shared libraries where the runtime lcoation of the library depends on outside factors.
### CFG       
Control Flow Guard (CFG): Windows protection, implements control flow integrity. Validates indirect code branching.           
### PatchGuard / KPP (kernel Patch Protection)       
[Bypassing PatchGuard at runtime](https://hexderef.com/patchguard-bypass)   
PatchGuard / KPP (Kernel Patch Protection): x64 Windows memory protection that protects critical areas of the kernel, in use since Windows Vista. Protects the SSDT, GDT, IDT, system images, processor MSRs. Restricts software from making extensions to the Windows kernel. Unable to completely prevent patching - device drivers have the same privilege level as the kernel and are able to bypass and patch. Attack scenario - use a vulnerable kernel driver with a valid EV certificate to get low level execution privileges.           
Protects against hooking IDT, SSDT, GDT, LDT.    
NULL Dereference Protection: cannot alloc the null page.      
### SMEP / SMAP:        
[Windows SMEP Bypass](https://www.coresecurity.com/sites/default/files/2020-06/Windows%20SMEP%20bypass%20U%20equals%20S_0.pdf) 
Kernel exploit mitigations    
SMAP: allow pages to be protected from supervisor-mode data accesses, prevents kernelmode from executing on user mode addresses. If SMAP is 1, software in supervisor mode can't access data at linear addresses that are accessible in user mode.       
SMEP: Supervisor Mode Execution Prevention. Protects pages from supervisor-mode instruction fetches. If SMEP is 1, software in supervisor mode can't fetch instructions at linear addresses that are accessible in user mode. Detects Ring - code running in user space, enabled by default since Windows 8. Relevant to local privilege escalation.               
SMEP bypass techniques: jump to code in user space, jump to the kernel heap (doesn't work on x64), use a ROP chain in kernel space to bypass, ROP to unprotecting hal.dll heap to write shellcode in that area and jump to that code, disable flags in the CR4 register to turn off SMEP / SMAP: 20th bit for SMEP.     

## Portable Executable (PE) Files       
DOS header, NT header, File Header (in NT header), Optional (not really optional - in the NT header) Header, Section Header (1 for each section).         
DOS hdr - legacy, e_magic          
NT hdr - Signature (should be PE in hex). File header - number of sections, file characteristics.       
Optional hdr - ImageBase, AddressOfEntryPoint, Data Directory w/ pointers to directory structs. Magic - field to identify type of PE (PE32 or PE32+ - x64)            
Section header: 1 for each section like .text, .rdata, .bss     
.reloc section - relocation info, modify addresses that assume the image is loaded at the preferred base address.     
.rsrc section - common place for malware, perms of any section can be changed to make RWX.      
Imports > what exe could be doing.     
[PE32 Cheatsheet](https://www.openrce.org/reference_library/files/reference/PE%20Format.pdf)       

Virtual memory: each process gets a virtual address space which gets translated to a physical address.    
RVA - offset of a value in the header.     
Virtual Address = Relative Virtual Address + image base       

IAT (Import Address Table) - base address, name and info of DLLs that need to be imported.     
INT points to array of names of functions, IAT - array of addresses of functions. IAT intially points to the INT, then the IAT is resolved by the loader.      
Export table - functions that the image exports to use from DLLs.    

TLS Callbacks:    
Address of Callbacks, executed when a process / thread is started or stopped. Code runs before the function even reaches the entry point. Commonly used by malware.          

## Windows Internals    
1:3 memory is allocated to kernel space vs user space.     
TEB - Thread Enviroment Block - 
PEB - Process Enviroment Block - user mode struct, store data on a running process. If the process is being debugged, which modules are loaded into memory, command line invoking the process. Isn't fully documented.      
### HAL - Hardware Abstraction Layer   
### Windows Kernel     
Kernel objects: used for things like process scheduling, I/O management. Virtual placeholder for a resource, each one is given a handle (index number).             
EPROCESS, KPCR, KINTERRUPT, IRP    
EPROCESS - kernel level view of a process. User level struct - PEB.   
KPRCB - Kernel Processor Control Block, embedded in KPCR (per CPU info). 
SSDT (System Service Descriptor Table) - allows the kernel to handle calls to the Native API.    
Common rootkit technique - perform DKOM(Direct Kernel Object Manipulation) to hide. Changes are done directly in the kernel. Hide a process, drivers, ports, elevate privileges, etc. Able to do this because kernel modules / loadable drivers hav direct access to kernel memory.               

## Windows Offensive Tooling     
### Native API   
Most calls are implemented in ntoskrnl.exe and exposed to user mode by ntdll.dll. Some kernel32 functions call ntdll.dll lower level functions.  
Includes system calls, many C runtime library functions, client-server functions, debugging, up calls from kernel mode, loader functions, etc.    
### Windows API   
Located in kernel32.dll, KernelBase.dll, advapi32.dll, user32.dll etc      
Provides OS functionality - userland and kernel land. APIs with Ex on the end are heavily modified.
Naming: PrefixVerbTarget[Ex] / VerbTarget[Ex]        
Create* APIs: help a user application create a system object, usually returns a handle.    
Common malware APIs: OpenProcess, VirtualAllocEx, WriteProcessMem, CreateRemoteThread   
### Common Techniques   
Process injection / hooking methods: code injection, DLL injection, DLL search order hijacking, IAT/EAT hooking, inline hooking.             
Process migration:      
Process hollowing: process is loaded on the system as a container for hostile code.     
Reflective DLL injection:       
Shellcoding: creating Position Independant Code (PIC).              
Anti debugging techniques:   