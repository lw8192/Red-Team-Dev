# Windows Kernel Programming in C     
[Kernel-Mode Driver Architecture Design Guide](https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/)      
[Write your first driver](https://learn.microsoft.com/en-us/windows-hardware/drivers/gettingstarted/writing-your-first-driver)       
[Kernel Cactus](https://spikysabra.gitbook.io/kernelcactus)   
[Win-Kernel Resources](https://github.com/NullArray/WinKernel-Resources)    
[Getting Started Writing Windows Drivers ](http://www.osronline.com/article.cfm%5Earticle=20.htm)     
  
Blogs:   
[OSR Online](https://community.osr.com/c/ntdev/7)  
[CodeMachine Articles](https://codemachine.com/articles.html)   
[Pavel Yosifovich](https://scorpiosoftware.net/)  
[secret.club](https://secret.club/)    
[back.engineering](https://back.engineering/blog)    
[Windows Internals Training](https://www.alex-ionescu.com/)   

## Kernel Concepts   
Kernel vs user mode programming: working with low level existing OS / hardware abstractions and services instead of high level application ones. Computer time and memory might have more restrictions. Kernel level APIs: most have C interfaces, no C++ runtime in the kernel.             

[Catalog of key kernel data structures](https://codemachine.com/articles/kernel_structures.html)        
KPROCESS / EPROCESS: kernel representation of a process object, info on a process running on a system. At fixed offset from other elements, which changes based on the OS build / version. GS[0x188] - KTHREAD of the process itself. Can save in R9 register for later usage.      
PsGetCurrentProcess() - get EPROCESS of current proc. PsLookupProcessByProcessId() - get EPROCESS of a different process.       
EPROCESS members:   
- ActiveProcessLinks: doubly linked list of the current processes
- Token: process access token. PsReferencePrimaryToken(PEPROCESS) - get pointer to token member of an EPROCESS struct.        

## Kernel Programming Setup   
Driver signing: needs to be signed so driver loads. Can turn on test signing for dev purposes.   

Turning off secure boot: VM Settings > Options > Advanced > UEFI > Uncheck "Enable secure boot"   
Turn off driver signing until reboot      

Use [Osr Loader](https://www.osronline.com/article.cfm%5Earticle=157.htm) (Win 7-10) to load a driver.   
Installing a driver with sc.exe (run in an admin prompt):    
> sc.exe create proc test type= kernel binPath= <path to .sys file>    #install driver as service   
> sc.exe start test    #start service, driver needs to be signed or TestSigning enabled     
Confirm the driver is loaded by opening WinObj and looking for device name + symbolic link.    

## Kernel Debugging      
[Debugging a Kernel Mode Driver Tutorial](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/debug-universal-drivers--kernel-mode-)    
Errors in the driver can cause the system to crash / BSOD.     
Load the dumpfile and look at the call stack    
[Debugging a crash dump](https://whitehatlab.eu/en/blog/windows/kernel-crash-dump/)   
[Setup remote kernel debugging](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/setting-up-a-network-debugging-connection-automatically)      
[WinDbg for Kernel Debugging](https://www.apriorit.com/dev-blog/kernel-driver-debugging-with-windbg)
Setup remote kernel debugging (host = debugger, guest = machine being debugged)    
Copy kdnet.exe and VerifiedNICList.xml to the guest machine from "C:\Program Files (x86)\Windows Kits\10\Debuggers\x64" (On Win10+ x64)                   
> kdnet.exe <host_IP> <Port>        #on guest    
copy the output WinDbg command, then run on the debugger VM to open WinDbg, reboot guest to connect    
When a kernel debugger is connected, driver signing is disabled by default.    
Path to source code symbols:    
> .sympath + <path to folder with PDB>      

DbgView: SysInternals tool. Can be buggy, but useful for seeing messages.     
Make sure to compile in Debug mode and run DebugView as admin.       
Run as admin > Capture > Enable 4 options: Capture Win32 & Capture Global Win32 & Capture Kernel & Enable Verbose Kernel Output    
KdPrint - won't print out messages if compiled in release mode. DbgPrint 

### Debugging a BSOD (Blue Screen of Death)  
[BSOD Method and Tips](https://www.sysnative.com/forums/threads/bsod-method-and-tips.284/)      
[How the BSOD actually 'works'](https://www.sysnative.com/forums/threads/how-the-bsod-actually-works-why-etc.10262/)    
BSOD: generates a crash dump.    
    
### WinDBG Commands    
[WinDbg - Kernel Programming Cheatsheet](https://github.com/repnz/windbg-cheat-sheet)    
[Configuring Kernel Debugging Environment with kdnet and WinDBG Preview](https://www.ired.team/miscellaneous-reversing-forensics/windows-kernel-internals/configuring-kernel-debugging-environment-with-kdnet-and-windbg-preview)   
[Windows Kernel Debugging](https://idafchev.github.io/research/2023/06/28/Windows_Kernel_Debugging.html)    
[WinDbg-kd cheat sheet](https://fishilico.github.io/generic-config/windows/windbg-kd.html)    
[DEFCON 27 WinDbg Cheatsheet](https://github.com/hugsy/defcon_27_windbg_workshop/blob/main/windbg_cheatsheet.md)     
[windbg cheatsheet](https://github.com/alex-ilgayev/windbg-kernel-debug-cheat-sheet)     
[System Setup for Kernel Debugging](https://codemachine.com/articles/system_setup_for_kernel_development.html)     
x64 function arguements - 1st four are stored in rcx, rdx, r8, r9      

> .hh             #view help manual   
Symbols:   
> !sym noisy      #make symbol loading more verbose   
> .symfix         #set symbol path tot he Microsoft symbol store  
> .reload /f      #force reload of symbols  
> .reload /u      #unload symbols (WinDbg won't close handles to pdb files) 
> ld <module name>   #load symbols for a module   
> ld kernel32    
KdPrintEx():     
Increase the kernel verbosity level from calls to KdPrintEx() temporarily during runtime from WinDbg (lost once session is closed):         
> kd> ed nt!Kd_Default_Mask 0xf      
OR   
permanently from registry hive (in Admin prompt on Debuggee):   
> C:\> reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Debug Print Filter" /v DEFAULT /t REG_DWORD /d 0xffff

Enviroment Info:   
lm - list loaded modules    
> lmv m kernel32         #detailed info about kernel32 module
> lm m nt                #info about the kernel (ntoskrnl.exe) module
> !analyze -v     #info on debugging status - debug a crash dump   
> !pcr 0          #view KPCR struct of process 0    
> !process 0 0    #list all current processes, shows info like _EPROCESS
> dt nt!_EPROCESS  #view the EPROCESS struct for a specific process    
> dt _DRIVER_OBJECT    #view the DRIVER_OBJECT  
Execution flow:   
> bu DriverName!DriverEntry      #set a breakpoint on the entry point     
Search:      
> s -[option] <start_addr> <end_addr> <data_to_search>  #search in memory      
> s-b <start addr> <endaddr> 4d 5a 90 00                #search MZ in a region 

Useful NTOSKRNL Symbols:      
nt!PsInitialSystemProcess - SYSTEM EPROCESS pointer         
nt!PsLoadedModuleList - Loaded modules in kernel (_LIST_ENTRY)         
nt!PspNotifyEnableMask - Flag which can disable kernel notify routines      

## Kernel Programming   
ntddk.h: header used by the kernel.     
Rtl - kernel API functions. Real time library from kernel32.dll     

NTSTATUS - signed 32 bit int for success / failure.   
```
NTSTATUS sucess = someKernelFunc(); 
if (!NT_SUCCESS(status)){  //macro to check MSB   
    DbgPrint("some error\n"); 
    return status; 
}
```

Macros:    
CONTAINING_RECORD()   
CONTAINS()   

### Timers   
[Using Timer Objects - Docs](https://github.com/MicrosoftDocs/windows-driver-docs/blob/staging/windows-driver-docs-pr/kernel/using-timer-objects.md)   
KTIMER timer;        
KeInitializeTimer(&timer);    //intialize a timer object.   
KeInitializeTimerEx(&timer);   //initialize a timer object for a repeating timer.    
KeSetTimer - set interval for when the timer will expire.       
KeReadStateTimer(&timer);  //query a timer's signaled state   
KeCancelTimer(&timer);   //cancel timer   

"watchdog timer": I/O timer. For every device object (just 1 per driver) - run a callback at IRQL_DISPATCH_LEVEL every second.   
IoInitializeTimer   

### Multithreading    
dispatcher object: kernel defined object threads can use to sync operations. State of signaled / non-signaled.   
threads can synchronize operations with:   
- KeWaitForSingleObject - wait for a dispatcher object to expire. Rets STATUS_SUCCESS when object satisifed wait.   
- KeWaitForMutexOperation  
- KeWaitForMultipleObjects  


### Driver Hooking       
Use filter drivers to intercept requests to almost any devices. Hooking driver: save old function pointers and replace major function arrays in the driver object with it's own functions. A request to the driver will invoke the hooking driver's dispatch routines.    
Patchguard / Kernel Patch Protection (KPP): hashes important data structures to prevent unauthorized modifications to the kernel. Can be triggered at any random time and crashes the system if changes are detected. Ex - SSDT pointing to system services (system calls)        
To hook a driver: locate driver object pointer (DRIVER_OBJECT) using an undocumented exported function that can locate any object given its name - ObReferenceObjectByName      
Hooking driver: lets you replace major function pointers, unload routine, add device routine.     
Save previous function pointers for unhooking when desired and for forwarding the request to the real driver.     
