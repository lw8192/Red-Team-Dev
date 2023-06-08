# Python for Purple Teamers 
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

    pip install pyinstaller    #install    
    pyinstaller entrypoint.py --onefile    #compile into 1 file    
    pyinstaller cli.py --hiddenimport=requests  #force a package to be included if not auto detected            
    --add-data    --add-binary    #force config or binary files to be included    
    
    pyinstaller entrypoint.py #compile - by default creates a *.spec, build and dist folder             
    #*.spec - used to build future versions of the exe faster and further customize         
    #build folder: metadata, useful for debugging (warn-*.txt file) or add --log-level=DEBUG              
    #dist folder: contains executable in a nested folder with .so, .pyd and .dll dependancies   
    pyinstaller --log-level=DEBUG cli.py 2> build.txt      #best for debugging    
    
