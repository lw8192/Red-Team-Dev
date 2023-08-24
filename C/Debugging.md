# GDB    
gcc -g program.c -o program     #compile a program using debugging symbols    
sudo gdb -q --pid=1234 --symbols=./program       #attach gdb to an already running program using the PID and load symbols from the executable      
(gdb) list       #view source code, if program is compiled with debugging symbols    
(gdb) bt         #backtrace the stack   
