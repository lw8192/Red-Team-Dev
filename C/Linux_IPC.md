# Linux IPC   
IPC methods: message passing or shared memory categories.     
message passing: easier to implement, managed by OS, slower.    
shared memory: faster but dev needs to synchronize access.      
sockets, pipes, message queues, signals, shared memory, RPC.      

SystemV vs POSIX   
POSIX: thread safe.          

POSIX Message queues   
```  
#include <mqueue.h>  //need to also link with -lrt 
mq_open()   
mq_unlink()   
mq_getattr()        
mq_setattr()   
mq_send()   
mq_receive()   
mq_notify()       
    
mq_close()           //close a message queue descriptor   

see created message queues in /dev/mqueue/
```

Shared Memory:     
Share memory between unrelated process, without creating a traditional file.   
Have to use synchronization variables to control access.       
see created shared memory segments in /dev/shm/       
```
int fd = shm_open(name, flags, mode);   //open / create SHM object    
//FLAGS: O_CREAT, O_EXCL, O_RDONLY, O_RDWR, O_TRUNC   
mmap()   //map shared object    
shm_unlink()    // remove SHM object pathname   
```


Semaphores    
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