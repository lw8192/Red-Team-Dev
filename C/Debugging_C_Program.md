# Debugging a C Program Using GDB      
[GDB Cheatsheet](https://gabriellesc.github.io/teaching/resources/GDB-cheat-sheet.pdf)        
[GDB Command Reference](https://visualgdb.com/gdbreference/commands/x)     
[GEF (GDB Enhanced Features)](https://github.com/hugsy/gef)    
[Debuggign with GDB](https://azeria-labs.com/debugging-with-gdb-introduction/)    

Opening GDB    
```
gcc -g program.c -o program     #compile a program using debugging symbols    
sudo gdb -q --pid=1234 --symbols=./program       #attach gdb to an already running program using the PID and load symbols from the executable      
gdb -q ./a.out    #open gdb using quiet mode
gdb -c ./core.1111       #inspect a coredump using gdb
```
Common GDB Commands   
```
(gdb) set dis intel      #view Assembly code in Intel format
(gdb) set disassembly-flavor intel     #set assembly language to Intel, different syntax 
(gdb) list       #view source code, if program is compiled with debugging symbols  
 #shows diassessmbly of main, value of EIP (memory address that points to an instruction in main). Instructions before: function prologue.   
(gdb) list main  #view source code of a function  
(gdb) break 9    #set a breakpoint at line 9
(gdb) break main  #set a breakpoint at main  
(gdb) run          #run program until breakpoint (will set up function prologues if the breakpoint is main)   
(gdb) cont       #continue the program   
(gdb) bt         #backtrace the stack
(gdb) info register eip    #view the address and value of EIP/RIP (the instruction pointer)     
(gdb) disas main      #Dump assembler code for function main    
(gdb) nexti      #view next instruction. Read the IP, execute it, then move EIP/RIP to the next instruction.
#Use gdb to examine memory with -x. Args: mem location, how to display. Display formats: o (octal), x (hex), u (unsigned base 10), t (binary). 
(gdb) x/x $eip    #see address EIP/RIP contains in hex. This is the next instruction to be executed.   
```
 
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
Parent / Child Processes:    

    (gdb) set follow-fork-mode child       #follow a child process    
View the start / end addresses of mapped memory regions:     

    (gdb) info proc mappings   
Use GDB scripting to set a breakpoint and print $rip :    

    gdb binary -x script.gdb   

    #script.gdb  
    break main+30 
    commands 
     p $rip  
    end 
    run    

Run a binay with a text file as input:       
```
gdb --args ./bin input.txt
b main
run

gdb ./bin
b main
run input.txt
```
