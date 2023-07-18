# Using Python to Interact with the Windows API   
Ctypes library wraps Python around C/C++ data structures to interact with the Windows API.            

## Resources    
https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-api-list      
MSDN - https://learn.microsoft.com/en-us/       
[Ctypes documentation](https://docs.python.org/3/library/ctypes.html)      
[Windows Data Types](https://learn.microsoft.com/en-us/windows/win32/winprog/windows-data-types)    
[Windows API Calls QUick Reference](https://github.com/snowcra5h/windows-api-function-cheatsheets)    
      
## C++ Data Types    
Types: char, int, float, double. Modifiers: signed, unsigned, short, long.    
Pointer: contains address of a storage location of a variable, where the data is in memory (not the actual value of the data).   
Structure: groups variables under a single defined type. Like a Python object.       

## The Windows API    
The Windows API is mostly described by MSDN (Microsoft Developer's Network). MSDN has: functions, structures and constants. The APU us a dynamic entity that changes and expands between releases. Official implementation on Windows machine in DLLs (ntdll.dll, kernel32.dll in C:\Windows dir).  
[System Error Codes](https://learn.microsoft.com/en-us/windows/win32/debug/system-error-codes--0-499-)     
Allows user written programs to interact with the underlying operating system.      
Unicode version of functions - w appendeded, ASCII version of functions -a appended.          
Display on a device (ie screen, printer) - interact with the device context.      
Handles - pointers to objects.       
Hacker focused API calls: OpenProcess, CreateRemoteThread, WriteProcessMemory.    
Injecting shellcode into a remote process: use Win32 APIs VirtualAllocEx, CreateRemoteThread, WriteProcessMemory, VirtualProtectEx, CreateProcessA, QueueUserAPC    


## Ctypes    
Usage:       

    from ctypes import *
    from ctypes wintypes      

## Syscalls   
API hooking: AV products inspect Win32 API calls before they are executed, decide if they are suspicious/malicious, and either block or allow the call to proceed. Evade this by using syscalls.   
Every native Windows API call has a number to present it (syscall). Differ between versions of Windows (find num using debugger or with public lists). Make a syscall: move number to a register. In x64, syscall instruction will then enter kernel mode. Direct syscalls in assembly: remove any Windows DLL imports, set up call ourselves (not using ntdll).      
Make syscall: set up args on the stack, move into EAX, use syscall CPU instruction (causing syscall to be executed in kernel mode).     
Syscall tables online: https://github.com/j00ru/windows-syscalls   
Table for below code (Win 10 x64): https://j00ru.vexillium.org/syscalls/nt/64/   
