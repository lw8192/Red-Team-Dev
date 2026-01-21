# Working with Files in C    
## Working with files using integer file descriptors (on a Linux system):    
The Linux kernel uses int file descriptors to describe files, allowing you to use them in programs written on Linux systems.      
open() - open a file with read / write permissions. Returns a new integer file descriptor to the file.      

    int open(const char *pathname, int flags);    
    int fd = open(filename, O_RDONLY);     //open as readonly   
    int fd = open(filename, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);    //open as write / create with the needed permisisons. 

read() - read from a file. Returns the number of bytes read.     

    ssize_t read(int fd, void buf[.count], size_t count);  
    ssize_t bytes_read = read(fd, buffer, sizeof(buffer)); 

write() - write a buffer to a file. Returns the number of bytes written.      

     ssize_t write(int fd, const void buf[.count], size_t count);
    write(file_fd, buffer, buffer_length);    
close() - close a file descriptor. Returns 0 on success.           

    int close(int fd);
    close(file_fd);    

If you need more information about the stream you can use a file pointer (FILE *). This has info like the current location in the file, end of file marker and error info.     

## Working with files using file pointers on Linux:      
[Basics of File Handling in C](https://www.geeksforgeeks.org/basics-file-handling-c/)      
FILE * file_pointer;     //define a file pointer    
fopen() - open a file. Returns a pointer to the file.    

    file_pointer = fopen("file.txt", "r");       

fread() - read bytes from a file into a buffer. Returns the number of bytes read.     

    size_t bytes_read = fread(buffer, 1, sizeof(buffer), file_pointer);      //read in 1 byte chunks    

fwrite() - write to a file. Returns the number of bytes read.    

    size_t bytes_written = fwrite(buffer, 1, bytes_read, stdout);   //write to stdout      

fseek() - sets the file position of a stream to start + offset. Constants - SEEK_SET(start of file), SEEK_CUR (current file position), SEEK_END (EOF)             

    int fseek(FILE *stream, long int offset, int start);    

ferror() - allows error handling for a file pointer.     

    if(ferror(file_pointer)){
        //do stuff if there's an error. 
    }       
    
fclose() - close a file.     

    fclose(file_pointer);     

### Working with Files on Windows         
Windows uses file pointers to work with files on C.       
