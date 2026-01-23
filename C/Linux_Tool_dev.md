# Linux Tool Development   
## Linux Offensive Tooling   
Syscalls:    
Searchable Linux syscall table (x86_64) https://filippo.io/linux-syscall-table/     
https://syscall.sh/   

linux process injection:   
https://www.outflank.nl/blog/2025/12/09/seccomp-notify-injection/      

## Linux OS Dev     
Study osdev theory and existing operating systems:    
- https://pages.cs.wisc.edu/~remzi/OSTEP/ READ THIS
- https://www.studytonight.com/operating-system/round-robin-scheduling
- http://www.rohitab.com/discuss/topic/31139-tutorial-paging-memory-mapping-with-a-recursive-page-directory/
- https://0xax.gitbooks.io/linux-insides/content/
- https://github.com/openbsd/src/tree/master/sys sys is the kernel
- https://github.com/NetBSD/src/tree/trunk/sys sys is also the kernel here
- https://elixir.bootlin.com/ Linux source code browser
Limine template for x86_64:   
- https://github.com/limine-bootloader/limine-c-template-x86-64     

### ESXi   
The ESXi kernel (VMkernel) is a customised kernel with several open source applications bundled on top of it. The shell itself is based on BusyBox. It is not based on Linux itself, but in some parts it resembles a Linux kernel (folder structure, process initiation, driver support). It is a minimal enviroment with limited access to standard Linux binaries.         
Datastore - basically separate layer that sits between a physical device/disk and a virtual disk. A datastore can max the storage of a physical disk, or not. A datastore can have many virtual disks. Virtual disks are what a virtual machine will stores files on. In other words Physical Disk > Datastore > Virtual Disks > Your filesystem e.g. EXT4    
https://microage.com/wp-content/uploads/2016/02/ESXi_architecture.pdf    
vim-cmd and localcli / esxcli   
> vim-cmd vmsvc/getallvms    #list VMs  
> vim-cmd vmsvc power.on <VM ID>    #power on VM   
> localcli vm process list          #list all running VMS on a host, get world ID  
> localcli network ip neighbor list    
> esxcli network vm list         #VM networking list     
> esxicli vms vm list   
https://gist.github.com/rollwagen/0efbc1aee51c0d91aa3824d73012397b      
http://kenumemoto.blogspot.com/2018/03/how-to-mount-iso-to-esxi-host.html    
https://gist.github.com/deepaknverma/9733611      
https://www.iblue.team/esxi-forensics/understanding-esxi/esxi-console-shell        
> vmdumper -l   #info on virtual machines which are present on the host and currently running
> vm-support --listvms       #list all configured VMs, regardless of powered state      

[ESXi Commands](https://vdan.cz/esxcli-commands-for-esxi-8-0/)   
[More ESXi Commands](https://willeysingh.wordpress.com/2020/01/22/55/)

kernel debugging with esxi and 2 Windows guests:   
https://www.reddit.com/r/esxi/comments/8pcq5r/kernel_debugging_with_esxi_and_vms/     
http://web.archive.org/web/20200926215551/https://communities.vmware.com/docs/DOC-15691      
https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/setting-up-a-null-modem-cable-connection     
The default settings for COM should be correct, as if you were using a physical nullmodem cable.      
Steps to setup:  
- Add serial port to debuggee VM (Add > Hardware > Serial Port > Connect to named pipe > Near end: 'server', Far end: 'VM') > Connect at Power On > Yield CPU on Poll   
> bcdedit /set debug on    #connect to accept connections from a debugger   
> bcdedit /dbgsettings     #verify settings    
- Add serial port to debugger VM (Add > Hardware > Serial Port > Connect to named pipe > Near end: 'client', Far end: 'VM')
- Start WinDbg, then select File > Kernel debug    

Running binaries on esxi:   
need to compile statically or use libraries available on esxi. cross compile or use precompiled software packages.    
binary not suitable for esxi: error message for missing shared libraries / generated segmentation faults.  
Binaries that use /proc, /sys, /dir won't work due to the esxi file system structure.        

Developement for esxi:    
need GCC, GLIBC, VMKernel files tool chain. Compile for esxi: statically linked version of tool.      
vmkernel - can run some Linux kernel modules.    
can attach gdb to esxi kernel   
vmkload - native binary on esxi to load modules   
> vmkload -u   #unload   
> dmesg   #view kernel messages    

https://blogs.vmware.com/arm/2020/11/14/a-nerds-adventure-how-to-write-a-native-driver-for-esxi-on-arm/     

compiling for esxi:      
https://www.vm-help.com/esx40i/esx41/developing-for-vmware-esxi    

Security Features:   
ESXi 8.0+ - execInstalledOnly. By default, prevents the execution of binary files not installed as signed VIB packages. Prevents unauthorized code execution.   
Temporarily turn off feature (until reboot):   
> esxcli system settings advanced set -o /User/execInstalledOnly -i 0     