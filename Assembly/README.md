# Notes on Assembly    
Low level programming language. Converted into executable machine code by an assembler. represents instructions in symbolic code.       

# Common 32-Bit Registers and Uses   
| Register      | Full Name   | Description |
| -----------   | ----------- | ----------- |
| EAX     | Primary Accumulator       | Addition, multiplication, function results  |
| ECX     | Counter Register  | Used by LOOP and others   |
| EBP     | Extended Base Pointer  | Baseline/frame pointer for referencing function arguments (EBP+offset) and local variables (EBP-offset)     |
| ESP     | Extended Stack Pointer | Points to the current “top” of the stack; changes via PUSH, POP, and others |     
| EIP     | Extended Instruction pointer | Points to the next instruction; shellcode gets it via call/pop    |
| EFLAGS  | Flags Register | Contains flags that store outcomes of computations (e.g., Zero and Carry flags)    |
| FS      | F segment register  | FS:[0] points to SEH chain, FS:[0x30] points to the PEB.   |     

16 bit registers: corresponding IP, SP and BP.   

# Common x86 Assembly Instructions   
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


