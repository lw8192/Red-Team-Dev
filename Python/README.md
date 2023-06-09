# Python for Purple Teamers    
## Dev Enviroments     
Windows: use Visual Studio Code and install Pylance and Python (IntelliSense (Pylance) extensions.     
Install Python on Windows:    

    C> python -V #check if already installed   
    #Go to python.org, download latest version for Windows. Make sure to add to path.   
    C> pip -V #error with pip - download pip bootstrap file   
    C> python get-pip.py  #install Pip (package manager)     
Pip    

    pip list   #installed libraries    
    pip freeze   #libraries and versions   
    pip install -r requirements.txt   #install project dependancies   
   
## Useful Python Libraries for Red / Blue Teams     
Argparse: parse and use command line arguments.     

   import argparse     
Pycryptdome    

    pip install pycryptodome

Pwntools: exploit dev and CTFs      

    python3 -m pip install --upgrade pwntools      
    apt install python3-pwntools   
### Web Libraries   
Requests: HTTP and HTTPS requests         

    import requests      
BeautifulSoup: useful for web scaping, converts complex HTML structure into Python objects     

    pip install beautiful soup4    
    from bs4 import beautifulsoup     
### Networking Libraries   
Socket: create a bidirectional comms channel between process or different systems on a network.      

    import socket   #already part of standard Python install     
Twisted: event driven networking engine     
Impacket: working with network protocols    
Paramiko: secure SSH and SCP connections.       
Scapy: packet manipulation library use to forge, decode, send and capture packets at a low level.   

    pip install scapy    
    from scapy.all import *     
pylibnet: API for libnet, send packets, sniff frames, display libpcap traces.     
Rawsocketpy: low level layer comms at layer 2 using MAC addrs.     
### Process Libraries   
Threading: create threads of a process to improve speed, shares process memory space. Note: you may need to synchronize your threads using a data lock to prevent race conditions         

    import threading    
Subprocess: create and work with subprocesses to connect to standard pipes, obtain process error codes. Note: be careful how you make a call with subprocess (passing user entered input can cause vulnerabilities)      

    import subprocess   #no need to install, part of standard Python lib      
### Windows Specific Libraries    
[Ctypes](https://docs.python.org/3/library/ctypes.html): wrap Python around C to interface with the Windows API     
Py2exe: Turn Python into standalone packages     

    pip install py2exe   
    from py2exe import freeze 

## Python Virtual Enviroments    
Isolated Python enviroment, independant of other enviroments and installed packages. Allows for multiple dependancies and versions.     

    pip install virtualenv     
    mkdir virtual-demo    
    cd virtual-demo      
    python3 -m venv env     #start virtual env     
    source env/bin/activate     #activate virtual env    
    which python3   #in virtual env, check python used      
    pip install pwntools    #install package in virtual env     
    deactivate    #deactivate virtual env     
    
## Compiling Python Executables     
Using Pyinstaller    
[Docker Images to Compile With](https://hub.docker.com/r/cdrx/pyinstaller-linux): compile using older libraries since Linux is backwards compatible    

    pip install pyinstaller    #install    
    pyinstaller --version   #if version is not current you may need to uninstall then reinstall (common problem on Kali)        
    sudo apt remove python3-pyinstaller   #then reinstall using Pip    
    
    pyinstaller entrypoint.py --onefile    #compile into 1 file    
    pyinstaller cli.py --hiddenimport=requests  #force a package to be included if not auto detected            
    --add-data    --add-binary    #force config or binary files to be included    
    
    pyinstaller entrypoint.py #compile - by default creates a *.spec, build and dist folder             
    #*.spec - used to build future versions of the exe faster and further customize         
    #build folder: metadata, useful for debugging (warn-*.txt file) or add --log-level=DEBUG              
    #dist folder: contains executable in a nested folder with .so, .pyd and .dll dependancies   
    pyinstaller --log-level=DEBUG cli.py 2> build.txt      #best for debugging    
 
 Using Py2exe Library    
 
    #make compressed exe     
    from py2exe import freeze 
    freeze(
	    console = [{'script':'script.py'}]'
	    options = {'py2exe':{'bundle_files':1,'compressed':True}},
	    zipfile = None 
    )
