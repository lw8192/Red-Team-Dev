# Python for Purple Teamers 

## Compiling Python Executables     
Using Pyinstaller     

    pip install pyinstaller    #install    
    pyinstaller entrypoint.py #compile - by default creates a *.spec, build and dist folder      
    #*.spec - used to build future versions of the exe faster     
    #build folder: metadata, useful for debugging    
    #dist folder: contains executable in a nested folder with .so, .pyd and .dll dependancies          
    pyinstaller entrypoint.py --onefile    #compile into 1 file    
    pyinstaller cli.py --hiddenimport=requests  #force a package to be included             
    
