# Debugging a C Program on Windows with WinDbg     
WinDbg: x86 and x86-64 versions. Can debug in both user and kernel mode.    
# WinDBG Cheatsheet   
https://github.com/nextco/windbg-readable-theme     
[Customizing WinDbg](https://www.zachburlingame.com/2011/12/customizing-your-windbg-workspace-and-color-scheme/)     
[WinDbg Common Commands](http://windbg.info/doc/1-common-cmds.html)       
[Breakpoints Documentations](https://learn.microsoft.com/en-us/windows-hardware/drivers/debuggercmds/bp--bu--bm--set-breakpoint-0)      
[WinDBG quick start tutorial](https://codemachine.com/articles/windbg_quickstart.html)    
[Windbg Cheatsheet](https://github.com/repnz/windbg-cheat-sheet)     
[Windbg Cheatsheet](https://dblohm7.ca/pmo/windbgcheatsheet.html)    
[Another cheatsheet](https://blog.lamarranet.com/wp-content/uploads/2021/09/WinDbg-Cheat-Sheet.pdf)         
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
x86 - args are passed on the stack. The return value of a function is stored in EAX.        
x64 - 1st 4 args are passed in registers, shadow store space is allocated on the call stack to save those values. The registers depend on the type and position of the args. Int args - passed in RCX, RDX, R8, and R9. The remaining args get pushed on the stack in right-to-left order. A function's return value is stored in RAX (or XMM0 if it is a float, double, or vector type)                    

Setup symbols:       
Symbols: reference internal functions, structs and global vars with names. No PDB file - WinDbg defaults to the export symbols table.       
To make the enviromental variable _NT_SYMBOL_PATH: srv*c:\symbols\sym*http://msdl.microsoft.com/download/symbols"        
> setx _NT_SYMBOL_PATH SRV*C:\symsrv*http://msdl.microsoft.com/download/symbols    #set env var in an admin cmd.exe   
In WinDbg:   
> .sympath    #view the syympath  
> .sympath srv*c:\symbols\sym*http://msdl.microsoft.com/download/symbols"       #set sympath  
> !lmi process   #parse PE headers for a process and look for the path to the symbol file     
Create a new folder c:\symbols for symbols provided by Microsoft.      
> .symfix+ c:\symbols
> .reload /f    #force a symbol reload         

Modules:        
> lm                           # print a list of loaded modules, shows start / ending addr of where they are loaded in memory           
> lm m kernel*                 # list all modules starting with kernel  
> x MyDllName!FunctionName     # prints loaded symbols   
> x kernelbase!Name*           # print loaded symbol, searching for part of the name.  

Check memory protections:     
> .load narly    #load extension that generates a list of all loaded modules and their protections.  
> !nmod    #view all loaded modules and memory protections. No DEP / ASLR displayed - means they are disabled.      
> !vprot eip     #show memory protections of a given addr            
Breakpoints:    
2 types of breakpoints: hardware and software. Software: controlled by debugger, INT 3 asm instruction. Hardware: controlled by processor using debug registers, debugger sets, allows you to monitor changes of / access data in memory.          
> bp <address>      #set a breakpoint   
> bp 0x401000   
> bp kernel32!recv   
> x notepad!*main     #if notepad was the process - examine symbol. 
> bp notepad!wWinMain  #set bp on main  
> bu   #set a breakpoint on an unresolved function - not loaded yet in the process memory space. Like a function from a loaded DLL.  

Breakpoints:     
> bl     #list breakpoints  
> be     #enable a breakpoint   
> bd     #disable a breakpoint   
> bc *   #clear all breakpoints or specify a breakpoint   
> .bpcmds      #list breakpoint commands   
> bp kernel32!WriteFile ".printf \"breakpoint hit, esp points to: %p\", poi(esp);.echo;g"    #print out data when a breakpoint is hit then continue execution   

Execution Flow:      
> g   #continue    
> p   #step over. exec 1 instruction at a time, step over function calls.    
> t   #step in. exec 1 instruction at a time, step into function calls.   
> pt  #exec function until return. step until next return         
> ph  #exec code until a branching instruction is reached    
> k   #dump the call stack   
> u   #un/disassemble   
> ub @rip    #disass 8 instructions before rip    

Registers:       
> r    #view the register values   
> r @eax    #check the value of a specific register    
> r ecx=42424242       #change the value of a register  

Dump memory:       
db: display bytes, dd: display DWORD, dw: display WORD, dq: display QWORD    
default length - 0x80 bytes. Change using L     
> dd esp L3      #dump stack as DWORDS       
> dt <name of struct> [source mem addr]     #dump a struct, must be provided by a loaded symbol file      
> da             #dump as ASCII   
> dp @rsp     #dump x64 stack - displays 64 bit values in 2 columns   
> db, dw, dd, dq   #dump as bytes, word, dword, qword    
> ? 5 - 4    #do math in WinDbg, assumes input is in hex. 0n: decimal format. 0y: binary format  
> .formats 41414141   #view multiple formats at once, hex/dec/binary/chars     

Display strings:   
dW, dc      
da: display ASCII, du: display Unicode        
> x /a /d ntdll!*    #search for string symbols   
> dc ntdll!SlashSystem32SlashString    #dump strings   
> dW     #display ascii and hex     
  
poi: display data referenced from a memory address.     
> dd poi(esp)       #display the data ESP points to    

Process and Thread Status:    
> |    #process status cmd - see PID and process name   
> ~    #thread state - shows info for all threads in the current process when in user-mode   

Edit memory:   
e\* - edit command     
> ed esp 41414141    #edit DWORD esp points to   
> ea esp "test"   #write asci to esp  
> eu esp "test"   #write unicode to esp    

Search memory:       
Search memory for a pattern. s - returns the memory address of found strings in loaded processes / modules.   
> s <mem type to search for> <starting point of mem to search> <length of mem> <pattern to look for>     
-d: search for DWORD, -q: search for QWORD    
> s -u 0 L?80000000 "hello"   #search entire address space for a Unicode string   

## User Mode Debugging    
### User Level Structs (PEB and TEB)   
PEB (Process Enviroment Block): use mode struct, info on if the process is being debugged, modules loaded into memory, command line used to invoke the process.       
PEB - at fs:[0x30] for x86 processes, gs:[60] for x64    
> !wow64exts.info   #view SYSWOW64 proc info     
> !process      #dump current process info   
> lm   #list loaded modules   
> !peb   #summary view of the PEB          
> db <base address of the process> L100     
dt: display type. Display structure / dump structure from a memory address.    
> dt _peb     #dump the peb     
> dt nt!_TEB    #get offset of the PEB struct   
> dt -r ntdll!_TEB @$teb    #dump the TEB and display nested structs     
> r $peb     #get the memory address of the PEB    
> dt _peb @$peb    #view struct members and the values the PEB points to       
> dt _PEB_LDR_DATA   
> dt _peb @$peb ldr->InMemoryOrderModuleList*     #get the InMemoryOrderModuleList - Linked list of pointers to the loaded modules in the process   
> dt _peb @$peb ProcessParameters    #view the ProcessParameters struct   
get the size of a structure using sizeof():     
> ?? sizeof(ntdll!_TEB)      

Export Address Table:      
> lm    #find the base address of kernel32.dll    
> !dh 00007fff`10100000 -f        #dump the header for kernel32.dll    
   99070 [    DF0C] address [size] of Export Directory    

Exception handlers:      
> !exchain   #list the current thread exception handler chain.  
> !teb    #view TEB, see ExceptionList value    
> dt _EXCEPTION_REGISTRATION_RECORD <ExceptionList value from the TEB> 
Struct members: Next, Handler    

Scripting:   
> !py C:\Tools\script.py   