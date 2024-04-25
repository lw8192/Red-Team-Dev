# Debugging a C Program on Windows with WinDbg     
# WinDBG Cheatsheet   
https://github.com/nextco/windbg-readable-theme     
[Customizing WinDbg](https://www.zachburlingame.com/2011/12/customizing-your-windbg-workspace-and-color-scheme/)     
[WinDbg Common Commands](http://windbg.info/doc/1-common-cmds.html)       
[Breakpoints Documentations](https://learn.microsoft.com/en-us/windows-hardware/drivers/debuggercmds/bp--bu--bm--set-breakpoint-0)      
[WinDBG quick start tutorial](https://codemachine.com/articles/windbg_quickstart.html)    
[Windbg Cheatsheet](https://github.com/repnz/windbg-cheat-sheet)     
[Windbg Cheatsheet](https://dblohm7.ca/pmo/windbgcheatsheet.html)    
[DEFCON27 WinDbg Workshop](https://github.com/hugsy/defcon_27_windbg_workshop)     
## Install     
https://github.com/yanglr/advDotnetDebugging/blob/main/README.md          
Windbg for Windows 7           
x86: http://download.microsoft.com/download/A/6/A/A6AC035D-DA3F-4F0C-ADA4-37C8E5D34E3D/setup/WinSDKDebuggingTools/dbg_x86.msi         
x64: http://download.microsoft.com/download/A/6/A/A6AC035D-DA3F-4F0C-ADA4-37C8E5D34E3D/setup/WinSDKDebuggingTools_amd64/dbg_amd64.msi         
Windbg for windows 10 (WinDbg 10.0.18362.1)            
x86: https://download.microsoft.com/download/4/2/2/42245968-6A79-4DA7-A5FB-08C0AD0AE661/windowssdk/Installers/X86%20Debuggers%20And%20Tools-x86_en-us.msi        
x64: https://download.microsoft.com/download/4/2/2/42245968-6A79-4DA7-A5FB-08C0AD0AE661/windowssdk/Installers/X64%20Debuggers%20And%20Tools-x64_en-us.msi       

Windbg preview (WindbgX) from Microsoft Store:             
https://www.microsoft.com/store/p/windbg/9pgjgd53tn86          


Windows calling conventions:   
x86 - args are passed on the stack.    
x64 - 1st 4 args are passed in registers, shadow store space is allocated on the call stack to save those values. The registers depend on the type and position of the args. Int args - passed in RCX, RDX, R8, and R9. The remaining args get pushed on the stack in right-to-left order.              

Modules:        
> lm                           # print a list of loaded modules, shows start / ending addr of where they are loaded in memory           
> x MyDllName!FunctionName     # prints loaded symbols   

Breakpoints:  
> bp <address>      #set a breakpoint   
> bp 0x401000   
> bp kernel32!recv   
> x notepad!*main     #if notepad was the process - examine symbol. 
> bp notepad!wWinMain  #set bp on main  

> bl     #list breakpoints  
> be     #enable a breakpoint   
> bd     #disable a breakpoint   
> bc *   #clear all breakpoints or specify a breakpoint   
> .bpcmds      #list breakpoint commands   

Execution Flow:      
> g   #continue    
> k   #dump the call stack   
> u   #un/disassemble   
> ub @rip    #disass 8 instructions before rip    

Registers:       
> r    #view the register values   
> r @eax    #check the value of a specific register    

Dump memory:       
> dd esp L3      #dump stack as DWORDS       
> dt             #view data types   
> da             #dump as ASCII   
> dp @rsp     #dump x64 stack - displays 64 bit values in 2 columns   

Display strings:   
> x /a /d ntdll!*    #search for string symbols   
> dc ntdll!SlashSystem32SlashString    #dump strings   

Setup symbols:       
To make the enviromental variable _NT_SYMBOL_PATH: srv*c:\symbols\sym*http://msdl.microsoft.com/download/symbols"        
> setx _NT_SYMBOL_PATH SRV*C:\symsrv*http://msdl.microsoft.com/download/symbols    #set env var in an admin cmd.exe   
In WinDbg:   
> .sympath    #view the syympath  
> .sympath srv*c:\symbols\sym*http://msdl.microsoft.com/download/symbols"       #set sympath  
> !lmi process   #parse PE headers for a process and look for the path to the symbol file   

Create a new folder c:\symbols for symbols provided by Microsoft.      
> .symfix+ c:\symbols
> .reload       #(or .reload -f if necessary)

Process and Thread Status:    
> |    #process status cmd - see PID and process name   
> ~    #thread state - shows info for all threads in the current process when in user-mode   

## User Mode Debugging    
### User Level Structs (PEB and TEB)   
PEB (Process Enviroment Block): use mode struct, info on if the process is being debugged, modules loaded into memory, command line used to invoke the process.       
PEB - at fs:[0x30] for x86 processes, gs:[60] for x64    
> !wow64exts.info   #view SYSWOW64 proc info     
> !process      #dump current process info   
> lm   #list loaded modules   
> !peb   #summary view of the PEB          
> db <base address of the process> L100
> dt _peb     #dump the peb     
> dt nt!_TEB    #get offset of the PEB struct   
> r $peb     #get the memory address of the PEB    
> dt _peb @$peb    #view struct members and the values the PEB points to       
+0x018 Ldr              : 0x00007fff`10e7a4c0 _PEB_LDR_DATA        
> dt _PEB_LDR_DATA   
> dt _peb @$peb ldr->InMemoryOrderModuleList*     #get the InMemoryOrderModuleList - Linked list of pointers to the loaded modules in the process   
> dt _peb @$peb ProcessParameters    #view the ProcessParameters struct   

Export Address Table:      
> lm    #find the base address of kernel32.dll    
> !dh 00007fff`10100000 -f        #dump the header for kernel32.dll    
   99070 [    DF0C] address [size] of Export Directory    


## Kernel Debugging    
### Setup    
[System setup for kernel development and debugging](https://codemachine.com/articles/system_setup_for_kernel_development.html)      
Debug kernel using WinDBG:     
```
bcdedit.exe –debug on     #enable debugging mode
#create a snapshot and reboot VM
Start WinDBG(sysinternals) as administrator.  
```

### Kernel Level Structs   
[Configuring Kernel Debugging Environment with kdnet and WinDBG Preview](https://www.ired.team/miscellaneous-reversing-forensics/windows-kernel-internals/configuring-kernel-debugging-environment-with-kdnet-and-windbg-preview)
> !pcr 0    #view KPCR struct of process 0    
> !process 0 0    #shows info like _EPROCESS
> nt!_EPROCESS    
