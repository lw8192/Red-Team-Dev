# Debugging a C Program on Windows with WinDbg     
# WinDBG Cheatsheet   
https://github.com/nextco/windbg-readable-theme     
[Customizing WinDbg](https://www.zachburlingame.com/2011/12/customizing-your-windbg-workspace-and-color-scheme/)     
[WinDbg Common Commands](http://windbg.info/doc/1-common-cmds.html)       
[Breakpoints Documentations](https://learn.microsoft.com/en-us/windows-hardware/drivers/debuggercmds/bp--bu--bm--set-breakpoint-0)   
Breakpoints:  

    bp <address>      #set a breakpoint   
    bp 0x401000   
    bp kernel32!recv   
       

    bl     #list breakpoints  
    be     #enable a breakpoint   
    bd     #disable a breakpoint   
  
    .bpcmds      #list breakpoint commands   
Execution Flow:      
> g   #continue    

Registers:       
> r    #view the register values   
> r @eax    #check the value of a specific register    

Debug kernel using WinDBG:     
```
bcdedit.exe –debug on     #enable debugging mode
#create a snapshot and reboot VM
Start WinDBG(sysinternals) as administrator.  
```

## PEB   
> lm   #list loaded modules   
> !peb   #summary view of the PEB          
> dt _peb     #dump the peb   
> dt nt!_TEB    #get offset of the PEB struct   
> r $peb     #get the memory address of the PEB    
> dt _peb @$peb    #view struct members and the values the PEB points to       
+0x018 Ldr              : 0x00007fff`10e7a4c0 _PEB_LDR_DATA        
> dt _PEB_LDR_DATA   
> dt _peb @$peb ldr->InMemoryOrderModuleList*     #Linked list of pointers to the loaded modules in the process   

Export Address Table:      
> lm    #find the base address of kernel32.dll    
> !dh 00007fff`10100000 -f        #dump the header for kernel32.dll    
   99070 [    DF0C] address [size] of Export Directory    
