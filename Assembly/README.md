# Assembly Notes     
[Notes from SANS Poster](https://sansorg.egnyte.com/dl/pHqHxaLC5M)   
[The Faker's Guide to Assembly](https://www.timdbg.com/posts/fakers-guide-to-assembly/)   
[x86 Assembly Guide](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html)     
 
Assembly is a low level programming language. Converted into executable machine code by an assembler. Represents instructions in symbolic code. Main syntaxes: AT&T syntax and Intel syntax. AT&T (% and $ before everything).          
Intel: destination(s) <- source. Windows.      

    mov rbp, rsp      ; move rsp into rbp 
    add rsp, 0x15     ; (rsp = rsp + 0x15)    
AT&T: source(s) -> destination. *nix/GNU. registers = % prefix, immediates - $

    mov %rsp, %rbp    ; move rsp into rbp  
    add $0x15, %rsp   ; rsp = rsp+0x15   

Addressing:       
Older Intel x86 processors use a 32-bit addressing scheme, while newer ones use a 64-bit one. 64-bit processors can run in 32-bit compatibility mode, which allows them to run 32-bit code quickly.       
x32 vs x64: differences in how variable sare passed to a function. In x32 systems parameters are pushed to the stack before the function is called. x64 - the first 6 parameters are stored in RDI, RSI, RDX, RCX, R8 and R9 registers.      
x86: progression of intel chips from 8086, 80186, 80286 etc. Originally 16 bit, then 32 / bit bit keeping backwards compatibility. Starts up in x16 before software transitions to x32/x64.
Shellcode: hex representation of machine code bytes. Can be translated back to Assembly or loaded directly into memory as binary instructions to be executed.        

# Common 32-Bit Registers and Uses     
Registers: internal variables for the processor, small memory storage area built into the processor. First four registers: general purpose. EAX, ECX, EDX, EBX (Accumulator, Counter, Data, Base). Acts as temporary variables for the CPU when executing machine instructions.            
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

# 16-bit Registers     
16-bit registers called AX, BX, CX, DX, SI, DI, BP, and SP. 32 bit registers are extended versions of these. You can still use these with an x86 system to access the first 16 bits of each 32 bit register. Bytes of the AX, BX, CX and DX registers can be accessed using 8-bit registers AL, AH, BL, BH, CL, CH, DL, DH. L - low byte, H - high byte.       

# 64-bit Registers  
Used on a x64 system.   
EAX→RAX, ECX→RCX, EBX→RBX, ESP→RSP, EIP→RIP      
Additional 64-bit registers are R8-R15.     
RSP is often used to access stack arguments and local variables, instead of EBP.     

RAX - stores function return values.    
RBX - base pointer to the data section. 
RCX - counter for string and loop operations.    
RDX - I/O pointer.     
RSI - source index pointer for string operations.    
RDI - destination index pointer for string operations.     
RSP - stack(top) pointer.    
RBP - stack frame base pointer.    
RIP - pointer to the next instruction to execute, "instruction pointer".  

# Conditional Jumps
JA / JG Jump if above/jump if greater.   
JB / JL Jump if below/jump if less.   
JE / JZ Jump if equal; same as jump if zero.   
JNE / JNZ Jump if not equal; same as jump if not zero.   
JGE/ JNL Jump if greater or equal; same as jump if not less.   

# Assembly Instructions     
NOP: "No-operation": doesn't do anything. Used to pad or align bytes, delay time. Make simple exploits more reliable.   


## Asm Files  
```
nasm -f elf file.asm     #assemble file.asm into an object file ready to be linked as an ELF binary
ld file.o     #default object file name, use linker program to make an executable
./a.out     #default exe name  
```
