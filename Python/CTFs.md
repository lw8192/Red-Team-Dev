# Using Python to Solve CTF Problems    
Pwntools: Python library specifically created for CTFs.     

[Pwntools Documentation](https://docs.pwntools.com/en/stable/)      
[Pwntools Intro](https://guyinatuxedo.github.io/02-intro_tooling/pwntools/index.html#pwntools-intro)     
[Pwntools Cheatsheet](https://gist.github.com/anvbis/64907e4f90974c4bdd930baeb705dedf)    

Install:    

    sudo pip install pwn    
Usage:   

    from pwn import *     
With a remote target:   

    target = remote(10.10.10.10, 8000)     #connect to a target with IP or URL. Target can be a remote connection or a process.     
    target.send("string")   #send data to a target   
    target.sendline("stuff")     #send data with a newline   
    print(target.recvline().decode().strip())    #print a line of data received from a target - decoded from a byte string and without spaces      
    print(target.recvuntil("end"))    #print data until the string "end"       
    print(target.recvall())    #print all data recieved   
    target.clean()    #remove all buffered data   
    target.interactive()    #interactive mode      
 
With a process:   

    target_proc = process("./binary")     #run a binary      
    target_proc = process(['./target', '--arg1', 'some data'], env={'env1': 'some data'})    #pass enviromental variables and command line args to binary at runtime    
    gdb.attach(target_proc)    #attach a debugger     
