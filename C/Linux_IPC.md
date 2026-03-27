# Linux IPC   
IPC methods: message passing or shared memory categories.     
message passing: easier to implement, managed by OS, slower, more overhead. Message queues, pipes, sockets, signals,    
shared memory: faster but dev needs to synchronize access.      

SystemV vs POSIX   
POSIX: thread safe, newer, modern standard. System V: legacy applications.    

[Beej's Guide to Interprocess Communication](https://beej.us/guide/bgipc/html/)   

## Message Passing IPC Methods  
### POSIX Message Queues   
asynchronous communication with message prioritization and fixed-size messages  
Message Queue functions:    
```  
#include <mqueue.h>  //need to also link with -lrt 
//best practice for IPC - unlink the resource name before creating a new object
mq_open()   
mqd_t mq = mq_open(name, O_WRONLY); 
mq_getattr()        
mq_setattr()   
mq_send()   
mq_receive()  
ssize_t mq_receive(mqd_t mqdes, char *msg_ptr, size_t msg_len, unsigned int *msg_prio); 
mq_notify()       

mq_close()           //close a message queue descriptor   
mq_unlink()       //remove message queue from system once process closes them


#define QUEUE_NAME "/name"   //must start with a slash 
// best practice for IPC - unlink the resource name before creating a new object
if (mq_unlink(QUEUE_NAME) < 0) {   //unable to unlink message queue or message queue doesn't exist 
    fprintf(stderr,"Unable to unlink message queue %s\n", QUEUE_NAME);
}
struct mq_attr attr;
attr.mq_maxmsg = 10;
attr.mq_msgsize = 1024;
attr.mq_flags = 0;
//attr required when calling mq_open with O_CREAT 
mqd_t mq = mq_open(QUEUE_NAME, O_CREAT | O_RDWR, 0666, &attr); 
if (mq == (mqd_t)-1){
    fprintf(stderr,"Unable to create message queue %s\n", QUEUE_NAME);
    return -1; 
}
```
see created message queues in /dev/mqueue/   
Message queues needs to be unlinked or they will exist until the next system reboot.   

[Linux for DEV #17](https://olehslabak.medium.com/linux-for-dev-17-1dda8b3fc3b9)   
[Message Queues](https://github.com/ANSANJAY/ipc-message-queue)

## Shared Memory IPC Methods   
### POSIX Shared Memory      
Kernel sets up a shared region of memory between unrelated process, without creating a traditional file. Pass large amounts of memory with minimal overhead.     
Have to use synchronization variables to control access.       
see created shared memory segments in /dev/shm/       
Functions   
```
#include <sys/mman.h>
//best practice for IPC - unlink the resource name before creating a new object
int shm_fd = shm_open(name, flags, mode);   //open / create connection to SHM object 
shm_fd = shm_open(name, O_CREAT | O_RDWR, 0666);   
//FLAGS: O_CREAT, O_EXCL, O_RDONLY, O_RDWR, O_TRUNC   
ftruncate(shm_fd, 4096);   //config size of shm object in bytes   
mmap()   //map shared object    
void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
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
Example:  
```
#include <sys/mman.h>
#define SHM_NAME "/shm_name" 
  void *shm_ptr; 
  if (shm_unlink(SHM_NAME) < 0) {   //unable to unlink shm or shm doesn't exist 
    if (errno != ENOENT){
      fprintf(stderr,"Unable to unlink message queue %s\n", QUEUE_NAME);
    }
  }
  int shm_fd = shm_open(SHM_NAME, O_CREAT | O_RDWR, 0666);  
  //  ftruncate to set size of segment to segsize 
  ftruncate(shm_fd, segsize); 
  // void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);   
  shm_ptr = mmap(0, segsize, PROT_WRITE, MAP_SHARED, shm_fd, 0);  
```

[POSIC Shared Memory API](https://www.geeksforgeeks.org/linux-unix/posix-shared-memory-api/)    
[POSIX Shared Memory](https://logan.tw/posts/2018/01/07/posix-shared-memory/)

### POSIX Semaphores    
Integer maintained inside kernel, can never go below zero.       
Blocking primitive. Protect shared memory / shared resource. Named (independent) and unnamed (embedded in shared memory) semaphores.         
Named semaphores: synchronize across processes.      
```
#include <semaphore.h>
sem_t *m_sem;
//sem_open() 
m_sem = sem_open (SEM_MUTEX_NAME, O_CREAT, 0660, 1);      
sem_wait()   //decrement by 1. before accessing shared memory.   
sem_post()   //increment by 1. After accessing shared memory.     
int sem_getvalue ( sem_t * sem , int * sval);  //get current value of semaphore  
int sem_close (sem_t * sem);  
sem_unlink()   
int sem_unlink (const char *name); 
```
Unnamed semaphores: synchronize across threads.        
```
# include <semaphore.h>
//Compile either with -lrt or -lpthread
int sem_init ( sem_t * sem , int pshared , unsigned int value ) ;  //pshared - semaphore is shared among threads or processes  
sem_init(semp, 1, 2), 
sem_init(semp, pshared, value);  //initialize semaphore   
sem_post(semp);     //add 1 to value  
sem_wait(semp);     //subtract 1 from value  
sem_destroy(semp);   //free semaphore, release resources back to system. 
```

Named semaphores - producer / consumer model example:    
Producer:   
```
  sem_wait(sem_empty);  //wait until coordination object (ie queue) is empty   
  //lock mutex 
  //remove items from queue, do operation   
  //unlock mutex 
  sem_post(sem_wait); //publish queue is full, producer done.  
```
Consumer:   
```
  sem_wait(sem_full);  //wait until coordination object (ie queue) is full   
  //lock mutex 
  //remove items from queue, do operation   
  //unlock mutex 
  sem_post(sem_empty); //publish queue is empty, consumer done.  
```

## Cleaning up IPC Resources   
If a process unexpectedly dies, certain IPC mechanisms won't.   
Register a signal handler using sigaction(), signal handler sets a global flag that the main loop checks.   