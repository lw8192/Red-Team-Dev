# Python for Purple Teamers    
## Python2 vs Python3   
Some legacy code is still Python2, but most modern scripts are written in Python3.    
Main differences: older libraries, strings are stored as ASCII (Python3 - unicode), calculations are rounded down to the nearest whole number (ie 5/2 = 2), no () needed for print statements.   
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
    pip search package    #search for a package    
Manually Install a Package:    

    #git clone package from Github, upload to target then install using setup.py (standard for most packages)    
    python3 setup.py install     
## Python Standards        
PEP8 Python style guide: https://peps.python.org/pep-0008/, [clean code notes](https://github.com/JuanCrg90/Clean-Code-Notes)             
Good to avoid generic variable names.         
General program order:    

    package imports, in alphabetical order          
    module imports, alphabetical order      
    functions    
    class definitions     
    main function       
Prevent code from being accidentally executed when imported:    

	# things to always run like class and function definitions   
	def main():
    		pass    
	if __name__ == "__main__":
  		# only ran when called directly (not via 'import') 
   		main()
## Useful Python Libraries for Red / Blue Teams         
Any Python file can be a module. When a module is imported (even if it's just a function), statements in the module execute until the end of the file. Contents of the module namespace - all of the global names still defined at the end of the execution process.    

	import module                     #import an entire module     
	a = module.function(stuff)        #use a function from the module     
	from package.module import function     #keep namespace tidier and only import what you need    
	a = function(stuff)    
	from package import module      #import module from a package     
 
 	from math import sin, cos    #make symbols available locally after importing a module    
  	from module import *    #all symbols from a module into local scope, considered bad style      
Main modules: os, sys, math, random, re, datetime, JSON    

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
Pickle: serialize / deserialize objects - store for later use or transfer across a network.      

    import pickle     
### Networking Libraries   
Socket: create a bidirectional comms channel between process or different systems on a network.      
[Socket Programming- How To](https://docs.python.org/3/howto/sockets.html)    

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
[Ctypes usage](https://stephenscotttucker.medium.com/interfacing-python-with-c-using-ctypes-classes-and-arrays-42534d562ce7)      

    from ctypes import *
    from ctypes import wintypes 
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
    pyinstaller file.spec  #*.spec - used to build future versions of the exe faster and further customize         
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

## Object Oriented Programming Concepts  
Allows data to be reused and grouped.    
Classes: structures software into reusable blueprints. Class 
Attributes: data fields in a class. 
Class Methods: class functions.     
Instantation: creating an instance of a class.     
Inheritance: leverage existing objects / structures by creating a new class using details of an already existing class. Parent / child classes.     
Polymorphism: enable class specific behavior.    
Encapsulation: secure and protect attributes / methods.     
Overloading: customize methods depending on paramaters, making code extensible and modular.     
Mutable objects: allow you to change their value or data in place without affecting the object's identity.    
Immutable: can't change an object's state after creating it.    

## Debugging    
IdentationError: use tabnanny to check for mixed tabs / spaces in your script:     

    python -m tabnanny script.py  
Logging Library      

	import logging     
	log.info("log some stuff")    
  	level=Logging.DEBUG    
  	fmt = '[% (Levelname)s] %(asctime)s - %(message)s'     
    logging.basicConfig(Level=level, format=fmt)      
Doctest Module: parse code for expected results and executable code, test and compare results           

    python3 -m doctest script.py    
    #no output - passes all the tests   
breakpoint() function        
