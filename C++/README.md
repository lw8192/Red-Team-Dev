# C++     
C vs C++: C++ extends C with Object Oriented Programming (OOP) Support.    
Most of the notes in my C section are also applicable to C++.    
## Links   
Mal dev examples: https://github.com/cocomelonc/meow/tree/master   
[Basic Windows Kernel Programming](https://github.com/raminfp/basicwindowskernelprogramming)     
[Windows Exploitaion Resources](https://github.com/FULLSHADE/WindowsExploitationResources)       

Compiling a DLL on Kali:        
> x86_64-w64-mingw32-gcc -shared -o script.dll script.cpp -fpermissive    
Compile exe on Kali (you might need to adjust these flags):     
> x86_64-w64-mingw32-g++ -O2 bad.cpp -o nothing_to_see_here.exe -mconsole -I/usr/share/mingw-w64/include/ -s -ffunction-sections -fdata-sections -Wno-write-strings -fno-exceptions -fmerge-all-constants -static-libstdc++ -static-libgcc -fpermissive

## Variables    

  var1= 20; 
  var1_addr = &var1;     //variable = the address of var1, "address of" operator   
  //Pointer: stores the address of another variable.    
  data_of_a_pointer = *var1_addr; //dereference operator, access data "pointer to by" a pointer. Will be 20. 

## The Windows API    
[Direct Syscalls](https://github.com/VirtualAlllocEx/Direct-Syscalls-A-journey-from-high-to-low/tree/main) - use low level direct syscalls to evade AV / EDR software.         
[Windows API Programming](https://caiorss.github.io/C-Cpp-Notes/WindowsAPI-cpp.html#orge9d5c6d)        
[The Forger's Win32API Tutorial](http://slav0nic.org.ua/static/books/C_Cpp/theForger's_Win32APITutorial.pdf)    

## C / C++ Runtime on Windows   
Usually a C / C++ runtime, the C runtime is used for C++ programs when C functions are used. C++ runtime - usually on top of the C runtime, often uses the C runtime for memory management.       
C++ has official support from Microsoft and more modern features (which is why it is often used over C on Windows).     

## Multithreading   
[Thread Safety Using c++](https://medium.com/@pauljlucas/advanced-thread-safety-in-c-4cbab821356e#:~:text=C++%20supports%20writing%20programs%20where%20parts%20of,locking%20takes%20a%20significant%20percentage%20of%20time)     

Mutexes in C++    
Don't manually call .lock() and .unlock() - forgetting to unlock leads to deadlocks or an issue if exception is thrown while a mutex is locked. Use RAII (Resource Acquisition Is Initialization) wrappers, with std::lock_guard or std::unique_lock.    
```
#include <mutex>
std::mutex mtx;

std::lock_guard<std::mutex> lock(mtx);  //locks mutex in its constructor and unlocks mutex in its destructor
```

Kinds of thread locks:    
```
std::mutex
std::shared_mutex
std::lock_guard
std::unique_lock
std::shared_lock
```

File locks: must use OS standard libaries, not provided by C++.   

[c++ thread reference](https://en.cppreference.com/cpp/thread)    
[c++ mutex reference](https://en.cppreference.com/cpp/thread/mutex)     
[Multithreading in C++: Mutexes](https://www.ramtintjb.com/blog/Mutexes)     
