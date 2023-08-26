# GDB    
[GEF (GDB Enhanced Features)](https://github.com/hugsy/gef)    
Common GDB Commands   
```
gcc -g program.c -o program     #compile a program using debugging symbols    
sudo gdb -q --pid=1234 --symbols=./program       #attach gdb to an already running program using the PID and load symbols from the executable      
gdb -q ./a.out    #open gdb   
(gdb) list       #view source code, if program is compiled with debugging symbols  
(gdb) list main  #view source code of a function  
(gdb) break 9    #set a breakpoint at line 9   
(gdb) run        #run program   
(gdb) cont       #continue the program   
(gdb) bt         #backtrace the stack   
```
