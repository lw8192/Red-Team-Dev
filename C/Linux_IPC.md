# Linux IPC   
IPC methods: message passing or shared memory categories.     
message passing: easier to implement, managed by OS, slower, more overhead. Message queues, pipes, sockets, signals,    
shared memory: faster but dev needs to synchronize access.      

SystemV vs POSIX   
POSIX: thread safe, newer, modern standard. System V: legacy applications.             

## Message Passing IPC Methods  
### POSIX Message Queues   
asynchronous communication with message prioritization and fixed-size messages  
Message Queue functions:    
```  
#include <mqueue.h>  //need to also link with -lrt 
mq_open()   
mq_getattr()        
mq_setattr()   
mq_send()   
mq_receive()   
mq_notify()       

mq_close()           //close a message queue descriptor   
mq_unlink()       //remove message queue from system once process closes them
```
see created message queues in /dev/mqueue/   
Message queues needs to be unlinked or they will exist until the next system reboot.   

[Linux for DEV #17](https://olehslabak.medium.com/linux-for-dev-17-1dda8b3fc3b9)   

## Shared Memory IPC Methods   
### POSIX Shared Memory      
Kernel sets up a shared region of memory between unrelated process, without creating a traditional file. Pass large amounts of memory with minimal overhead.     
Have to use synchronization variables to control access.       
see created shared memory segments in /dev/shm/       
Functions   
```
int shm_fd = shm_open(name, flags, mode);   //open / create SHM object 
shm_fd = shm_open(name, O_CREAT | O_RDWR, 0666);   
//FLAGS: O_CREAT, O_EXCL, O_RDONLY, O_RDWR, O_TRUNC   
ftruncate(shm_fd, 4096);   //config size of shm object in bytes   
mmap()   //map shared object    
shm_unlink()    // remove SHM object pathname   
```

Producer / consumer model:   
```
Producer:   
shm_fd  
create object O_CREATE | O_RDWR   
ftruncate() - config size of object   
mmap()   
write to shared memory   

Consumer: 
shm_fd   
open object O_RDONLY   
mmap()   
read from shared memory  
unlink - shared memory space will be destroyed  
```

[POSIC Shared Memory API](https://www.geeksforgeeks.org/linux-unix/posix-shared-memory-api/)

### POSIX Semaphores    
Integer maintained inside kernel   
Blocking primitive. Protect shared memory / shared resource. Named (independent) and unnamed (embedded in shared memory) semaphores.         
```
sem_post()   //increment by 1   
sem_wait()   //decrement by 1  
```
Unnamed semaphores:     
```
sem_init(semp, pshared, value);  //initialize semaphore   
sem_post(semp);     //add 1 to value  
sem_wait(semp);     //subtract 1 from value  
sem_destroy(semp);   //free semaphore, release resources back to system. 
```

## Cleaning up IPC Resources   
If a process unexpectedly dies, certain IPC mechanisms won't.   
Register a signal handler using sigaction(), signal handler sets a global flag that the main loop checks.   