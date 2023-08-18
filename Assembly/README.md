# Notes on Intel x86 Assembly    
[Notes from SANS Poster](https://sansorg.egnyte.com/dl/pHqHxaLC5M)   
[The Faker's Guide to Assembly](https://www.timdbg.com/posts/fakers-guide-to-assembly/)   
## Reverse Engineering Resources    
[Machine-Level and Systems Programming](https://courses.ics.hawaii.edu/ReviewICS312/modules/)    
[Linux Kernel Book](https://0xax.gitbooks.io/linux-insides/content/)    
Low level programming language. Converted into executable machine code by an assembler. Represents instructions in symbolic code. Main syntaxes: AT&T syntax and Intel syntax. AT&T (% and $ before everything).               
Addressing:       
Older Intel x86 processors use a 32-bit addressing scheme, while newer ones use a 64-bit one. 64-bit processors can run in 32-bit compatibility mode, which allows them to run 32-bit code quickly.     
Shellcode: hex representation of machine code bytes. Can be translated back to Assembly or loaded directly into memory as binary instructions to be executed.        

# Common 32-Bit Registers and Uses     
Registers: internal variables for the processor. First four registers: general purpose. EAX, ECX, EDX, EBX (Accumulator, Counter, Data, Base). Acts as temporary variables for the CPU when executing machine instructions.            
2nd four general purpose: ESP, EBP, ESI, EDI. General purposes - pointers and indexes. Stack Pointer, Base Pointer, Source Index, Destination Index. ESP and EDP - pointers. Store 32 bit addresses. Last 2 - pointers often pointed to source and destination where data needs to be read from or written to. Load and store instructions: can be thought of as simply general purpose.       
EIP - Instruction Pointer. Points to next current instruction the processor is reading. Used a lot when debugging.        
EFLAGS register - several bit flags used for comparisons and memory segmentations.     
16 bit registers: corresponding IP, RSP and BP.   
64 bit registers: corresponding RIP, RSP, RBP.   
     
| Register      | Full Name   | Description |
| -----------   | ----------- | ----------- |
| EAX     | Primary Accumulator       | Addition, multiplication, function results  |
| ECX     | Counter Register  | Used by LOOP and others   |
| EBP     | Extended Base Pointer  | Baseline/frame pointer for referencing function arguments (EBP+offset) and local variables (EBP-offset)     |
| ESP     | Extended Stack Pointer | Points to the current “top” of the stack; changes via PUSH, POP, and others |     
| EIP     | Extended Instruction pointer | Points to the next instruction; shellcode gets it via call/pop    |
| EFLAGS  | Flags Register | Contains flags that store outcomes of computations (e.g., Zero and Carry flags)    |
| FS      | F segment register  | FS:[0] points to SEH chain, FS:[0x30] points to the PEB.   |     

# Common x86 Assembly Instructions     
operation <dest>, <src>      #values - register, memory address or a value. Operations: mov from src to dest, sub, inc (increment), decrement.     
| Syntax      | Description |
| ----------- | ----------- |
| mov EAX,0xB8      | Put the value 0xB8 in EAX.      |  
| push EAX |  Put EAX contents on the stack.   |
| pop EAX | Remove contents from top of the stack and put them in EAX.   |
| lea EAX,[EBP-4] | Put the address of variable EBP-4 in EAX.   |
| call EAX |  Call the function whose address resides in the EAX register.   |  
| add esp,8 | Increase ESP by 8 to shrink the stack by two 4-byte arguments.    |
| sub esp,0x54 |  Shift ESP by 0x54 to make room on the stack for local variable(s).   | 
| xor EAX,EAX | Set EAX contents to zero.   |
| test EAX,EAX |  Check whether EAX contains zero, set the appropriate EFLAGS bits.  | 
| cmp EAX,0xB8 |  Compare EAX to 0xB8, set the appropriate EFLAGS bits.   |

# Understanding 64-Bit Registers
EAX→RAX, ECX→RCX, EBX→RBX, ESP→RSP, EIP→RIP      
Additional 64-bit registers are R8-R15.     
RSP is often used to access stack arguments and local variables, instead of EBP.     

# Conditional Jumps
JA / JG Jump if above/jump if greater.   
JB / JL Jump if below/jump if less.   
JE / JZ Jump if equal; same as jump if zero.   
JNE / JNZ Jump if not equal; same as jump if not zero.   
JGE/ JNL Jump if greater or equal; same as jump if not less.   

## Disassembling a C Program     
[GDB Cheatsheet](https://gabriellesc.github.io/teaching/resources/GDB-cheat-sheet.pdf)        
[GDB Command Reference](https://visualgdb.com/gdbreference/commands/x)   

    gcc -g example.c -o example     #-g: include extra debugging info while compiling a C program      
    gdb -q example      #run gdb in quiet mode    
    (gdb) list       #view source code (if extra debugging info is included)    
    (gdb) set disassembly-flavor intel     #set assembly language to Intel     
    (gdb) break main     #set a breakpoint at main     
    (gdb) break 6       #set a breakpoint at line 6    
    (gdb) run          #run program until breakpoint (will set up function prologues)    
    #Use gdb to examine memory with -x. Args: mem location, how to display. Display formats: o (octal), x (hex), u (unsigned base 10), t (binary). 
    (gdb) info register eip    #see address of EIP (Instruction Pointer)    
    (gdb) x/x $eip    #see address EIP contains in hex. This is the next instruction to be executed.        
    (gdb) disas main      #Dump assembler code for function main    
    (gdb) nexti      #view next instruction. Read EIP, execute it, then move EIP to the next instruction.   

Default size of a single unit - 4 byte unit - word. You can change size display with region symbols, appended to end of a format letter.   
2 bytes - short / halfword. 4 bytes - double word / DWORD.       

    b A single byte
    h A halfword or short, which is two bytes in size
    w A word, which is four bytes in size
    g A giant, which is eight bytes in size 
Examples:    

     (gdb) x/4xb $eip       #View memory starting at EIP in 4 groupings of 1 byte, all in hex.            
     (gdb) x/8xb $eip       #View memory starting at EIP in 8 groupings of 1 byte, all in hex.    
     (gdb) x/2xh $eip       #View memory starting at EIP in 2 groupings of a halfword, all in hex.     
cmp / jle / jmp: make up a if-then-else control structure.    

GDB examine: use 'c' to automatically look up a byte in the ASCII table. 's' displays string of char data.   

    (gdb) x/gcb 0x08000000   #view chars at memory address    
    (gdb) x/s 0x...    #view string at memory address   
    (gdb) x/2i $eip    #view corresponding instruction    
    (gdb) continue    #continue until end of program / next breakpoint   
Stack: stores chain of function calls. Use bt to backtrace the stack.   

    (gdb) break main   
    (gdb) run  
    (gdb) bt      #backtrace the stack   
