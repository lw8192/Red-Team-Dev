# Software Development Interview Prep Notes     
- [Software Development Interview Prep Notes](#software-development-interview-prep-notes)
  * [Study Resources](#study-resources)
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
  * [Exploit Protections](#exploit-protections)
    + [DEP](#dep)
    + [K/ASLR](#k-aslr)
    + [PIE](#pie)
    + [CFG](#cfg)
    + [PatchGuard / KPP (Kernel Patch Protection)](#patchguard---kpp--kernel-patch-protection-)
    + [SafeSEH](#safeseh)
    + [SMEP / SMAP](#smep---smap)
    + [Code Integrity Guard (CIG), Arbitrary Code Guard (ACG)](#code-integrity-guard--cig---arbitrary-code-guard--acg-)
  * [Portable Executable (PE) Files](#portable-executable--pe--files)
  * [Windows Internals](#windows-internals)
  * [User Level](#user-level)
    + [Kernel Level](#kernel-level)
    + [HAL - Hardware Abstraction Layer](#hal---hardware-abstraction-layer)
  * [Windows Offensive Tooling](#windows-offensive-tooling)
    + [Native API](#native-api)
    + [Windows API (WinAPI / Win32API)](#windows-api--winapi---win32api-)
    + [Syscalls](#syscalls)
    + [Common Techniques](#common-techniques)
  * [Reverse Engineering](#reverse-engineering)
    + [Static Analysis](#static-analysis)
    + [Dynamic Analysis](#dynamic-analysis)
    + [Automation](#automation)
    
## Study Resources   
[Coding Interview University](https://github.com/jwasham/coding-interview-university)         
[Data Structrues and Algorithms](https://github.com/Avinash987/Coding/tree/master)    

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

CI/CD (Continuous Integration / Continuous Deployment): incremental software code changes are made frequently and reliably. CI: regularly merging code changes into a central repo and automated testing. CD: automatically deplying all code changes to a production enviroment after test and build stage.    

Cross compiler: compile code for a different architechure / system then it is being developed on.    
Toolchain: set of compiler + linker + any tools needed to produce an exe for a target.   

Object oriented programming: model that centers on data fields w/ attributes (variables) and behaviors (functions). OOP groups variables and methods, model and group complex data in a reusable way that allows us to structure software into reusable blueprints (classes). C is not object oriented, Python is.        
OOP Fundamentals:     
Leverage existing structs (inheritance). Enable class specific behavior (polymorphism). Bundle data with methods that work on that data (encapsulation). Extendible and modular (overloading). Classes: creates a format / outline that can be used to create a object with assigned values and properties. Class data = attribute, class functions = methods.     

Scope: block of code for each object, use objects without any prefix. Ie local scope - scope of a function.     

Big O notation - complexity of an algorithim, how long it takes to run. Algorithims are usually in these general classes (best to worst speed): constant time, logarithmic, linear, polynomial, exponential, factorial.        

Preprocessor: processes input to output data that is used as input in another program. Ex - #include tells the preprocessor to insert the contents of a header file in a C program.       

Macro vs a function: preprocessor goes through and repalces in line text with the macro. Function: moves to another lcoation in code.    

### Hypervisors   
Type 1 / bare metal hypervisor: runs directly on a host's physical hardware. OS designed to run virtual machines. Exs - Microsoft Hyper-V, VMWare ESXi, VMWare vSphere, KVM (built into Linux)                      
Type 2 / hosted hypervisors: software installed on top of an OS. Ex - VirtualBox, VMWare workstation. OS layer between hypervisor / hardware - gives a larger surface to attackers.                

## Data Structures   
Stack: LIFO, pop / push operations. Each function has a stack frame storing its local arguments, stored after the return address. When a function is returned, the stack pointer points to the return address and that value is put into the instruction pointer (ret operation).         
Heap: memory managed by the programmer, allocated using malloc() / free() and derivative functions.    
Singly linked list: each node has a data piece and a pointer to the next node in the list. Need to start with the head of the list and iterate through it to find a certain data variable, easy to pop / push items.     
Doubly linked list: common with Windows software, each node has a data variable, pointer to the previous node, and pointer to the next node. Uses head and tail variables to start.           
Queue: FIFO, stores elements sequentially. Often used for multithreading.       
Binary trees:     

## Calling conventions   
Describes how args are passed to fctns, how values are ret'd, how caller / callee cleans up the stack, function prologue / epilogue.      
stdcall: standard call, args of a function are pushed onto the stack from right to left (1st param is nearest to the top of the stack). Callee cleans the stack. Function names have a leading underscore.           
cdecl: C declaration, args of a function are pushed onto the stack in reverse order, from right to left. Caller cleans the stack.      
Windows C++ programs: usually stdcall calling convention. Can be changed. Win32 API functions - use __stdcall calling conventions, C runtime functions used the __cdecl calling convention.          
x86 function prologue: pushes ebp onto the stack, esp into ebp. Not necessary, used by the compiler for security.        
Function prologue: incrementing the stack pointer to make room on the stack. function epilogue: clean up.            
Return address w/ function's parameters and local variables get stored on the stack for each function for x86. Params / local vars - make up a function's stack frame. x64: return address and local variables get stored, params are passed in registers.    
Big endian - was Sparc and PowerPC. Little endian - most widely used format by x86 and AMD64, low order byte of the number is stored in memory at the lowest addr, high order byte at the highest addr.   
Windows x86: EAX, ECX, EDX are volatile. Might change during the execution of an API function. Other registers - nonvolatile, caller must preserve.       
### x64 Calling Conventions        
- Arguments are passed using registers instead of the stack. Windows - RCX, RDX, R8, R9 etc from left to right, shadow store space is allocated on the call stack for callees to save those registers to restore after fctn call. Linux - RDI, RSI, RDX, RCX       
- Caller cleans the stack (like cdecl).       
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
### x86 CPU Registers   
General purpose registers: EAX, EBX, ECX, EDX, ESI, EDI. Store temp data.     
EAX: accumulator, for arithmatic and logical instructions.    
EBX: base pointer for memory addresses.     
EDX: counter, loop / shift/ rotation counter.     
EDX: data, I/O port addressing, multiplication and division.    
ESI: source index, pointer addressing of data and source in string copy operations.     
EDI: destination index, pointer addressing of data and destination in string copy operations.     
ESP: stack pointer. Stack: stores data, pointers and arguments. Dynamic and constantly changes during program execution. ESP keeps track of the "top" of the stack. Ptr: reference to an addr in memory.    
EBP: base pointer. stores a pointer to the top of the stack, allows function to easily reference info from its stack frame via offsets.     
EIP: instruction pointer, next code instruction to be executed. directs the flow of a program. Target for memory corruption vulns like buffer overflows.     

## C Programming   
Pointers: variables that holds an address in memory.     
Pointer arithmatic: ptr++, increases by the size of the data type. Incrementing an int ptr - increases by 4 bytes.    
Struct vs union: struct - can have diff variables, can set values for each variable, allocated mem is sum of variable sizes. Union - can only set the value of 1 variable at a time from the present variables.   
### Allocating Memory    
malloc() / calloc() - allocate dynamic memory on the heap. Wrapper around brk/sbrk(default mem allocator) system call in linux and VirtualAlloc api call on Windows. Uses brk to allocate memory and store the chunk meta info.       
malloc vs calloc - both allocate memory, calloc can allocate chunks of multiple memory blocks (takes in as an argument) and zeroes the memory.    
```
calloc(num_mem_blocks, size);   //allocates n memory blocks of size              
malloc(size);    //allocate memory of size, returns a void pointer, NULL if unsuccessful           
```
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
Thread - each thread has its own stack for functions, local variables, and program control info.       
Creating a thread: creates a peer (not child to a parent process like in multiprocessing).    
Thread safety: a function is thread safe when it has correct results when it is invoked by multiple concurrent threads at the same time. Functions called from a thread must also be thread safe.         
Synchronization primitives: mutexes, semaphores     
Mutex (mutual exceptions): protects a section of code from being run at the same time by different threads. Used to protected a shared resource (ie a file) from being accessed and modified by multiple threads at the same time. Can be accquired or released.           
Conditional variables: a condition to be checked that allows for threads to go to sleep until an event on another thread occurs. Can be used to send a signal between threads.    
### Pthreads           
Pthread mutexes: provides mechanism to solve mutual exclusion, ensure threads access shared state in a controlled way.       
### Multithreading on Windows    
Mutex vs Critical Section in Windows       
Mutex needs kernel level permission to work. Mutexes can be shared between processes. Critical section: only 1 process, but only switches to kernel mode in case of contention.  

## Bitwise Operations      
1 byte = 8 bits, 2 bytes = 16 bits, 4 bytes = 32 bits, 8 bytes = 64 bits      
Signed / unsigned numbers. Signed: highest bit is the signed bit, 1 = negative, 0 = non negative. Unsigned - all digits are used, can't represent negative numbers, can rep 2x the value of a signed int. C - default is signed.         
Binary representation of a number - machine number is signed number.        
Inverse of a number - flipped bits if negative, except for the sign bit.    
2s complement of a number = flip bits + 1      
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
breakpoints: software (int 3 /0xcc), hardware (handled by the processor using the debug registers), memory (guard pages), conditional (debugger specific)       
Op code: binary sequence interpreted by the CPU as a specific instruction, in debugger as hex.    

## Stack and heap attacks         
Fuzzing: feeding an app with malformed input and forcing it to generate an access violation.   
### Buffer overflows     
Buffer bounds are not checked allowing an attacker beyond the variables location on the stack - to overwrite the stored return address, allowing control over EIP/RIP and program execution.     
Common C vulnerable functions: strcpy(), stpcpy(), gets(), strcat(), strcmp(), sprintf().       
Bad chars: depends on app, vuln type and protocols used - might be certain bad chars in a buffer, return addr or shellcode, could prevent or change the nature of the crash.      
Common bad chars: \x00, \x0a, \x0d. Check for bad chars: all possible chars from 0x00 - 0xFF as part of the buffer and check the result.       

Why not hardcode the address of the stack to overwrite EIP/RIP?     
This would not be reliable. Stack addrs often change, especially in threaded apps. Instead - find address of a JMP ESP instruction.        

Egghunters: only small amount of space that can be used after a memory corruption. Might be able to store a larger payload somewhere in the address space of the process. Small first-stage payload that can search the process virtual address space (VAS) for an egg, a unique tag that prepends the payload we want to execute. Once egg is found - egghunter transfers execution to the final shellcode by jumping to the found addr.        
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
Vuln functions: fprintf, printf, sprintf, snprintf, vfprintf, vprintf, vsprintf, vsnprintf.        
Format string exploit: when the submitted data of an input string is evaluated as a cmd by the app.     
Might be able to leak an address and bypass ASLR.    
### Stack Canaries       
Stack Canary / stack cookie / stack smashing protector: adds a value in front of the instruction pointer, this value will be checked before returning. Is generated per-process, first byte is usually a null byte so you can't easily leak it.    
Work around stack canaries: if you have a relative or absolute write to memory you don't need to write the canary. You may be able to leak the canary, if you can read memory. If the return is not immediately or never called, you might be able to overwrite the null byte and leak the canary.         
/GS: Windows compiler option that enables a stack canary / security cookie. /GS-: to disable.        

## Exploit Protections    
### DEP      
NX/DEP: Non execution / data execution prevention. Usually done at the hardware level, marks a region of memory as not executable. You can use ROP techniques to bypass it or find a memory region that is RWX.
NX: Nonexecutable Stack, Linux. Defines memory regions as instructions or data - your input gets stored as data and can't be executed. ret2libc - Linux NX bypass.     
DEP: Data Execution Prevention, Windows version of NX, the CPU will not execute code in the heap or stack.     
Common DEP bypass - ROP (return orinted programming), find a memory region that is RWX. Can be used to disable DEP on Windows by calling NtSetInformation, then executing shellcode.             

ROP:    
Gadget: byte sequence in a program of instruction + ret. Chain together several gadgets to make the program do what you want. You can extract patterns from different parts of the instruction set.     
Chain together small snippets of useful assembly code in the binary (or others loaded by it). ASLR can limit this.        
### K/ASLR      
ASLR: address space layer randomization. Instead of preventing execution on the stack - randomize the stack memory layout. Attacker won't know where the waiting shellcode is to return execution into it. ASLR takes a segment which is going to exist in the new process, checks if it has a fixed address requirement - if it doesn't ASLR applies a random page offset.      
Goal of ASLR: mitigate exploits that defeat DEP with ROP                
ASLR is a setting of the OS. When a program or library is loaded, ASLR will apply to every memory segment it can. The stack / heap will always be random. The randomization happens at load time - to perform an address leak it needs to be as the same program is running.        
Windows - randomizes addresses on system level programs at boot time.       
Memory pages need to be aligned, so you know the lowest 12 bits. x86: restricted address space (PIE base only has 8 bits of randomization).       
Defeating ASLR: info leak vulnerability (ie format string vulnerability that can leak an address), brute force an address (possible on 32 bit since the address space is limited), partially overwrite the return address to the shellcode location, find a DLL without ASLR enabled to exploit.           
### PIE    
PIE - Position Independent Executables (PIE), protects against ROP attacks. The binary and it's dependancies are loaded into random locations in virtual memory each time the program is executed. The binary stores rip-relative offsets and relocations instead of any pointers. PIE generates code that finds things by offset, instead of by hardcoded memory addresses. Compile with PIC (Position Independent Code) to generate a PIE (Position Independent Executable). Once you know the base of a PIE - you know where all the functions are.
PIE is a setting of the binary code section in the program file. It is used mostly for building shared libraries where the runtime lcoation of the library depends on outside factors.
### CFG       
Control Flow Guard (CFG): Windows protection, implements control flow integrity. Validates indirect code branching to prevent the overwrite of function pointers in exploits. Extends /GS, DEP and ASLR.   
Bypass CFG:              
### PatchGuard / KPP (Kernel Patch Protection)       
[Bypassing PatchGuard at runtime](https://hexderef.com/patchguard-bypass)   
PatchGuard / KPP (Kernel Patch Protection): x64 Windows memory protection that protects critical areas of the kernel, in use since Windows Vista. Protects the SSDT, GDT, IDT, system images, processor MSRs. Restricts software from making extensions to the Windows kernel. Unable to completely prevent patching - device drivers have the same privilege level as the kernel and are able to bypass and patch. Attack scenario - use a vulnerable kernel driver with a valid EV certificate to get low level execution privileges.           
Protects against hooking the IDT, SSDT, GDT, LDT.    
NULL Dereference Protection: cannot alloc the null page.      
### SafeSEH    
Exceptions: unexpected events that occur during normal program execution. Windows OS: _try/_except tries to leverage Structure Exception Handling (SEH).    
When a thread fault occurs, OS calls designated set of functions (exception handlers) which can fix or give more info about the error. Exception handlers: user defined, given by _try/_except.    
SEH overwrite: using a stack-based buffer overflow to overwrite an exception registration record that has been stored on a thread’s stack. Overwrite 1 or more sets of handlers - take control of IP after triggering an exception.        
SEHOP: prevent SEH overwrites, dynamic checks to the exception dispatcher that don't rely on metadata from a binary, verifies thread’s exception handler list is intact before allowing any of the registered exception handlers to be called. Enabled by default on Windows Server 2008+.         
SAFESEH: /SAFESEH compiler option. Exe has metadata that platform uses to mitigate.     
SAFESEH bypass:     
### SMEP / SMAP        
[Windows SMEP Bypass](https://www.coresecurity.com/sites/default/files/2020-06/Windows%20SMEP%20bypass%20U%20equals%20S_0.pdf) 
Kernel exploit mitigations    
SMAP: allow pages to be protected from supervisor-mode data accesses, prevents kernel mode from executing on user mode addresses. If SMAP is 1, software in supervisor mode can't access data at linear addresses that are accessible in user mode.       
SMEP: Supervisor Mode Execution Prevention. Protects pages from supervisor-mode instruction fetches. If SMEP is 1, software in supervisor mode can't fetch instructions at linear addresses that are accessible in user mode. Detects Ring - code running in user space, enabled by default since Windows 8. Relevant to local privilege escalation.               
SMEP bypass techniques: jump to code in user space, jump to the kernel heap (doesn't work on x64), use a ROP chain in kernel space to bypass, ROP to unprotecting hal.dll heap to write shellcode in that area and jump to that code, disable flags in the CR4 register to turn off SMEP / SMAP: 20th bit for SMEP.     
### Code Integrity Guard (CIG), Arbitrary Code Guard (ACG)    
CIG - only allows properly signed images to load. ACG: code can't be dynamically generated or modified.  

## Portable Executable (PE) Files       
PE format - how exe info is stored.    
COFF (Common Object File Format) - legacy.    
DOS header, NT header, File Header (in NT header), Optional (not really optional - in the NT header) Header, Section Header (1 for each section).         
DOS hdr - type of file, e_magic          
NT hdr - Signature (should be PE in hex). File header - number of sections, file characteristics.       
Optional hdr - ImageBase, AddressOfEntryPoint, Data Directory w/ pointers to directory structs. Magic - field to identify type of PE (PE32 or PE32+ - x64)            
Section header: 1 for each section like .text, .rdata, .bss. Perms of any section can be changed to make RWX.        
Sections:   
- .text: exe code and entry point
- .data: initialized data (strings, variables, etc.)
- .rdata or .idata: imports (Windows API) and DLLs.
- .reloc: relocation information, modify addresses that assume the image is loaded at the preferred base address. 
- .rsrc: application resources (images, etc.), common place for malware.  
- .debug: debug information  
Imports > what exe could be doing.     
For 32 bits apps that are not ASLR-enabled, 0x400000 is the prefererred load address (ImageBase) for a PE.    
[PE32 Cheatsheet](https://www.openrce.org/reference_library/files/reference/PE%20Format.pdf)       
[PE Structure](https://tech-zealots.com/malware-analysis/pe-portable-executable-structure-malware-analysis-part-2/)      

Virtual memory: each process gets a private virtual address space which gets translated to a physical address. Each proc has executable code, open handles to system objects, a security context, a PID, environment variables, a priority class, minimum and maximum working set sizes, and 1+ threads.       
RVA - offset of a value in the header.     
Virtual Address = Relative Virtual Address + image base       
Preferred Base Address: compiler accepts a field that sets the base memory address of the exe when loaded. If ASLR is not enabled and there's no collisions - exe will be loaded at the preferred base address.     
REBASE: option to let the loading process use a different base address, important when DLLs are compiled with the same base address and loaded into the same process.        

IAT (Import Address Table) - base address, name and info of DLLs that need to be imported.     
INT points to array of names of functions, IAT - array of addresses of functions. IAT intially points to the INT, then the IAT is resolved by the loader.      
Export Directory Table - info for functions that the image exports to use from DLLs.    

TLS Callbacks:    
Address of Callbacks, executed when a process / thread is started or stopped. Code runs before the function even reaches the entry point. Commonly used by malware.          

## Windows Internals    
Ring 0 vs Ring 3. Ring 3: user mode processes, some services, applications and system owned processes, enviroment subsystem. Ring 0: Windows executive, kernel, drivers, Hardware abstraction layer.     
Processor switches between ring 3 / user mode and ring 0 / kernel mode. Normal user mode app: can't interact with the kernel or modify physical hardware. When a system call is made - app switches modes.          
### User Level  
1:3 memory is allocated to kernel space vs user space.     
TEB / PEB - created when the OS executes an exe. 
TEB (Thread Enviromental Block) - contains info related to the currently running thread.             
PEB / LDR (Process Enviromental Block) - user mode struct, store data on a running process. Process name, PID, if the process is being debugged, which modules are loaded into memory, command line invoking the process. Isn't fully documented.      
PEB_LDR_DATA - struct inside the PEB, info about the process's loaded modules. Contains doubly linked lists InLoadOrderModuleList, InMemoryOrderModuleList, InMemoryOrderModuleList with info on the DLLs loaded into the process. Always: ntdll.dll, kernel32.dll, kernelbase.dll.           
TEB - saved to FS on x86 systems, GS on x64.       
PEB - at offset fs[:0x30] in the TEB for x86 processes and GS:[0x60] for x64 processes. 
### Kernel Level       
Kernel objects: used for things like process scheduling, I/O management. Virtual placeholder for a resource, each one is given a handle (index number).             
EPROCESS, KPCR, KINTERRUPT, IRP    
ETHREAD - kernel level view of a thread. User level struct - TEB. KTHREAD - inside ETHREAD, has info on thread stacks, scheduling, APCs, system calls, priority, execution times.    
EPROCESS - kernel level view of a process. User level struct - PEB. KPROCESS - inside EPROCESS. EPROCESS attacks: use for process hiding or token stealing.        
KPRCB - Kernel Processor Control Block, embedded in KPCR (per CPU info). 
SSDT (System Service Descriptor Table) - allows the kernel to handle calls to the Native API.    
Common rootkit technique - perform DKOM(Direct Kernel Object Manipulation) to hide. Changes are done directly in the kernel. Hide a process, drivers, ports, elevate privileges, etc. Able to do this because kernel modules / loadable drivers have direct access to kernel memory.               
### HAL - Hardware Abstraction Layer   
### Heap Manager   
Software layer that resides on top of the virtual memory interfaces provided by the Windows OS.    
It allows apps to dynamically request and release through a set of Windows APIs (VirtualAllocEx, VirtualFreeEx, HeapAlloc and HeapFree). Those APIs call into their native functions in ntdll.dll (RtlAllocateHeap and RtlFreeHeap). 
When a process starts - heap manager makes a new heap called the default process heap. Might create additional heaps using HeapCreate to isolate parts of the application.        

## Windows Offensive Tooling     
### Native API   
Most calls are implemented in ntoskrnl.exe and exposed to user mode by ntdll.dll. Some kernel32 functions are wrappers to ntdll.dll lower level functions.  
Includes system calls, many C runtime library functions, client-server functions, debugging, up calls from kernel mode, loader functions, etc.    
Kernel mode functions: have prefix Zw     
User mode functions: Nt prefix    
### Windows API (WinAPI / Win32API)  
Easier and more secure to use then the Native API but slower. Located in kernel32.dll, KernelBase.dll, advapi32.dll, user32.dll etc      
Provides OS functionality - userland and kernel land, interact with physical hardware and memory. APIs with Ex on the end are heavily modified.
Naming: PrefixVerbTarget[Ex] / VerbTarget[Ex]        
Common malware APIs: OpenProcess, VirtualAllocEx, WriteProcessMem, CreateRemoteThread      
Include windows.h or use P/Invoke to use Windows API calls.     
[Quick Intro to the Win32 API](https://users.physics.ox.ac.uk/~Steane/cpp_help/winapi_intro.htm)    
### Syscalls   
System call - interface between a user mode process and the kernel. Invoking a system call - done through a dedicated asm instruction or interrupt (also known as a trap or exception).    
API hooking: AV products inspect Win32 API calls before they are executed, decide if they are suspicious/malicious, and either block or allow the call to proceed. Evade this by using syscalls.   
Every native Windows API call has a number to present it (syscall). Differ between versions of Windows (find num using debugger or with public lists). Make a syscall: move number to a register. In x64, syscall instruction will then enter kernel mode. Direct syscalls in assembly: remove any Windows DLL imports, set up call ourselves (not using ntdll).      
Make syscall on x86: set up args on the stack, move into EAX, use syscall CPU instruction (causing syscall to be executed in kernel mode).        
Put the syscall number in EAX, can then invoke a syscall using 'int 0x2e' - results in a trap.    
Change on different versions of Windows - use Win32 APIs if you want your exploit to be more robust.   
[Windows Syscall Numbers](https://github.com/j00ru/windows-syscalls)      
### Common Techniques   
Process injection / hooking methods: code injection, DLL injection, DLL search order hijacking, IAT/EAT hooking, inline hooking.             
Basic process injection: OpenProcess, VirtualAllocExm, WriteProcessMemory, CreateRemoteThread, CloseHandle. Get a handle to another process, allocate memory, write shellcode, create a thread to execute that code, close the handle.    
Process migration:      
Process hollowing: process is loaded on the system as a container for hostile code.     
Process Masquerading:       

Process Hooking   
Hooks: alter behavior of component by intercepting API calls, messages or events passed between processes. Some AV products, and monitoring tools use hooking. Can be used by malicious processes to hide from a process list or intercept keypress events as a keylogger.      
API hooks - local (only specific apps) or global (all system processes). 

DLL (Dynamic Link Library): can be loaded in a program with load time or run-time linking.     
DLL Hijacking:   
DLL Side-loading:   
DLL injection:   
Reflective DLL injection: DLLs loads itself. DLL has a ReflectiveLoader function that is intially called: this function finds the location of the DLL itself in a buffer, allocates memory using VirtualAlloc SizeOfImage, check the DLL fields to make sure it is a valid PE file, copies over section headers (NT, Optional, File), copies over the sections, relocates if unable to to allocate memory at the given BaseAddress, loads / stores the required libs / functions needed for the DLL, runs any needed TLS callbacks, then calls DllMain to attach the DLL. After that any function from the DLL can be called using GetProcAddress / an equivalent. Common technique used in malware to help obfuscate.                    
Shellcoding: creating Position Independant Code (PIC). For Windows: this involves finding the base address of ntdll.dll or kernel32.dll to use Native API or Win32 API functions from.                 
Anti debugging techniques: checking PEB->BeingDebugged      
PE patching: change addresses in a binary. Can inject new code.Can get the address of a function you want to call from the list of imported functions.      
- NOP an address, inject assembly into a binary, hook an entry point so it calls the address. 
- Replace a function. 
### Kernel Programming    
Interrupts   
page tables    
processes    
paged vs non-paged memory     
locking, deadlocking issues     
Is Windows is a real-time os? (if not how to design a RT extension?)
Locking, deadlocking issues (difference with single/smp/HT systems)
What is a windows subsystem? (Native vs Win32 ? why does it exist?) can lead
to discussion with Virtual machines.
Recursion removal strategy (why is it bad in drivers)
memory access optimization (tiling…)
C compilation steps.
Security (token, SID…)
Cache Manager/VM interactions.
Boot process description, Exec load process (what is the c-runtime, pagefault handling),
Shared library (imports, rva…)
Give your debugging strategies/support.(Bsod debug howto)
Give 3 examples of filter drivers.
Give n links to internet/blog related sites.
Describe advanced Data structure implementation (B-tree, …), give O() properties.  

## Reverse Engineering    
REMnux: network analysis platform.      
Flare: host based indicators / analysis.   
Inetsim: Internet Simulator    
For ELF binaries: GDB / GEF       
PE files: SysInternals suite, PEview, PE bear, TCPView, ProcMon, WinDbg /x32dbg        
Decompile / disassemble: Ghidra, Ida Pro, Cutter      
Tips:   
- Use dynamic analysis (debugging) for code that's hard to understand statically.    
- Pay attention to jmps and calls to see code flow.   
- API calls: know official API names and associated native APIs.    
### Static Analysis    
Hash the sample and lookup using tools like VirusTotal    
Static string analysis - look  for weird strings and API calls usings strings.exe, FLOSS         
Open in PE View / Cff Explorer / PE Bear - look at the IAT to see what functions / DLLs are imported.    
 SECTION.rdata -> IMPORT.Address_Table, API calls PE is making. Search 'Windows API call name' to find details.     
Compression - make exe look different. Packer / compression stub: compresses code after it then expands at runtime. Fool AV, obfuscate purpose.    
3 sections: original PE header, compression stub, code.   
Disassemble / decompile with Ghidra or Ida. Look for the logical execution flow, what program can do, look at API calls and how they are being used.        
### Dynamic Analysis    
Heuristic / behavioral analysis. Look for host / network indicators.        
Host indicators: persistence methods, files created / deleted. Procmon - look for created files 
Network indicators: execute in a sandbox, run with and without INetSim to simulate the Internet, WireShark to capture network traffic, step through using a debugger. Look for TCP requests - follow TCP / HTTP stream.          
De-chaining / de-coupling: tactic, download of web resource (mal.exe) and writing to file system (normal.exe) - can be different name.     
Set breakpoints on interesting instructions, step into them and see how they are executing.     
### Automation   
YARA Rules - detect malware based on IOCs. Yet Another Ridicolous Acronym      
Jupyter notebooks - Python to automate analysis, ie hash and VT look up.    
