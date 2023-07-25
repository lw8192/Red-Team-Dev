# Using Python to Solve CTF Problems    
pwntools for Python3    
[Pwntools Intro](https://guyinatuxedo.github.io/02-intro_tooling/pwntools/index.html#pwntools-intro)     
Install:    

    sudo pip install pwn    
Usage:   

    from pwn import *     
    target = remote(10.10.10.10, 8000)     #connect to a target with IP or URL. Target can be a remote connection or a process.     
    target.send("string")   #send data to a target   
    target.sendline("stuff")     #send data with a newline   
    print(target.recvline().decode().strip())    #print a line of data received from a target - decoded from a byte string and without spaces      
    print(target.recvuntil(b"end"))    #print data until the string "end"       
    print(target.recvall())    #print all data recieved   
    target.clean()    #remove all buffered data   
    target.interactive()    #interact with a target    
 
    target = process("./binary")     #run a binary   
    gdb.attach(target)    #attach a debugger    
