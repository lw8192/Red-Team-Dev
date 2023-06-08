# Python for Purple Teamers 

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
    
