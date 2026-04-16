# Linux RPC   
Remote Procedure Calls: 
Server / client stubs:   
Marshalling / unmarshalling: encode function args.   
Interface Definition Language (IDL): specify function behaviors.    

different APIs / methods to make RPCs.   
gRPC - C++   
REST - JavaScript    

## gRPC    
Protocol buffers: simple language-neutral and platform-neutral Interface Definition Language (IDL). Defined in the .proto file: methods and request / reply fields.     

C++ Structure for a DFS Streaming RPC Call on the client side:    
```
//in Public class of the client: 
void Fetch(const std::string& filename){
    //create request object  
    //set filename for request object  
    //create reply object   
    //create context object
    //make RPC call 
    //check status, return appropriate value   
}
```
C++ Structure for a DFS Streaming RPC Call on the server side:    
```
    //parse filename from request, get local file path. 
    //check file exists, open file 
    //read from file, send file bytes in chunks   
    //close file, return status  
```

Using Inotify: monitor file system events.          
```
#include <sys/inotify.h>
inotify_init();   
inotify_add_watch(fd, pathname, mask); 
inotify_rm_watch(fd, wd); 
```
[Inotify Demo Code](https://man7.org/tlpi/code/online/dist/inotify/demo_inotify.c.html)

## Resources    
[ Distributed Systems 1.3: RPC (Remote Procedure Call)] (https://www.youtube.com/watch?v=S2osKiqQG9s)   