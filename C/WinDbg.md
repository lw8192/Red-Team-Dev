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
> !peb   #get address of the LDR (PEB struct)        
> dt _peb     #dump the peb   
> dt nt!_TEB    #get offset of the PEB struct   

