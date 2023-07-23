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
[MalAPI.io](https://malapi.io/)    
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
