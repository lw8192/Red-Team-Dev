# Windows Kernel Programming in C     
[Kernel-Mode Driver Architecture Design Guide](https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/)      
[OSR Online](https://community.osr.com/c/ntdev/7)  
[Write your first driver](https://learn.microsoft.com/en-us/windows-hardware/drivers/gettingstarted/writing-your-first-driver)       
[Kernel Cactus](https://spikysabra.gitbook.io/kernelcactus)   
[CodeMachine Articles](https://codemachine.com/articles.html)   
[Pavel Yosifovich](https://scorpiosoftware.net/)     

## Kernel Concepts   
Kernel vs user mode programming: working with low level existing OS / hardware abstractions and services instead of high level application ones. Computer time and memory might have more restrictions. Kernel level APIs: most have C interfaces, no C++ runtime in the kernel.             

EPROCESS: kernel representation of a process object. At fixed offset from other elements. GS[0x188] - KTHREAD of the process itself. Can save in R9 register for later usage.      

ntddk.h: header used by the kernel.    

Driver signing: needs to be signed so driver loads. Can turn on test signing for dev purposes.   

Installing a driver (run in an admin prompt):    
> sc.exe create proc test type= kernel binPath= <path to .sys file>    #install driver as service   
> sc.exe start test    #start service, driver needs to be signed or TestSigning enabled   


[Finding the Base of the Windows Kernel](https://wumb0.in/finding-the-base-of-the-windows-kernel.html)

## Kernel Debugging      
Errors in the driver can cause the system to crash / BSOD.     
Load the dumpfile and look at the call stack    

[Setup remote kernel debugging](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/setting-up-a-network-debugging-connection-automatically)      
Setup remote kernel debugging (host = debugger, guest = machine being debugged)    
Copy kdnet.exe and VerifiedNICList.xml to the guest machine from "C:\Program Files (x86)\Windows Kits\10\Debuggers\x64"                 
> kdnet.exe <host_IP> <Port>        #on guest    
copy the output WinDbg command, then run on the debugger VM to open WinDbg, reboot guest to connect    
Path to source code symbols:    
> .sympath + <path to folder with PDB>   

[Debugging a crash dump](https://whitehatlab.eu/en/blog/windows/kernel-crash-dump/)       

## Kernel Programming   
Macros:    
CONTAINING_RECORD()   
CONTAINS()   

### Driver Hooking       
Use filter drivers to intercept requests to almost any devices. Hooking driver: save old function pointers and replace major function arrays in the driver object with it's own functions. A request to the driver will invoke the hooking driver's dispatch routines.    
Patchguard / Kernel Patch Protection (KPP): hashes important data structures to prevent unauthorized modifications to the kernel. Can be triggered at any random time and crashes the system if changes are detected. Ex - SSDT pointing to system services (system calls)        
To hook a driver: locate driver object pointer (DRIVER_OBJECT) using an undocumented exported function that can locate any object given its name - ObReferenceObjectByName      
Hooking driver: lets you replace major function pointers, unload routine, add device routine.     
Save previous function pointers for unhokking when desired and for forwarding the request to the real driver.     
