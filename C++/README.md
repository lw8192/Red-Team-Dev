# C++     
## Links   
Mal dev examples: https://github.com/cocomelonc/meow/tree/master   
[Basic Windows Kernel Programming](https://github.com/raminfp/basicwindowskernelprogramming)     
[Windows Exploitaion Resources](https://github.com/FULLSHADE/WindowsExploitationResources)   

Compiling a DLL on Kali:        

  x86_64-w64-mingw32-gcc -shared -o script.dll script.cpp -fpermissive    
Compile exe on Kali (you might need to adjust these flags):     

  x86_64-w64-mingw32-g++ -O2 bad.cpp -o nothing_to_see_here.exe -mconsole -I/usr/share/mingw-w64/include/ -s -ffunction-sections -fdata-sections -Wno-write-strings -fno-exceptions -fmerge-all-constants -static-libstdc++ -static-libgcc -fpermissive
   
## Variables    

  var1= 20; 
  var1_addr = &var1;     //variable = the address of var1, "address of" operator   
  //Pointer: stores the address of another variable.    
  data_of_a_pointer = *var1_addr; //dereference operator, access data "pointer to by" a pointer. Will be 20. 

## The Windows API    
[Direct Syscalls](https://github.com/VirtualAlllocEx/Direct-Syscalls-A-journey-from-high-to-low/tree/main) - use low level direct syscalls to evade AV / EDR software.         
[Windows API Programming](https://caiorss.github.io/C-Cpp-Notes/WindowsAPI-cpp.html#orge9d5c6d)        
[The Forger's Win32API Tutorial](http://slav0nic.org.ua/static/books/C_Cpp/theForger's_Win32APITutorial.pdf)    