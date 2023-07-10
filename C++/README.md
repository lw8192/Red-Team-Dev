# C++ 
Mal dev examples: https://github.com/cocomelonc/meow/tree/master   

Compiling a DLL on Kali:        

  x86_64-w64-mingw32-gcc -shared -o script.dll script.cpp -fpermissive    
Compile exe on Kali (you might need to adjust these flags):     

  x86_64-w64-mingw32-g++ -O2 bad.cpp -o nothing_to_see_here.exe -mconsole -I/usr/share/mingw-w64/include/ -s -ffunction-sections -fdata-sections -Wno-write-strings -fno-exceptions -fmerge-all-constants -static-libstdc++ -static-libgcc -fpermissive
   
  
