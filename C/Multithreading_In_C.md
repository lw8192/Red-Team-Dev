# Implementing Threading in C    
## Threading Concepts    
[Beej's Guide to C - Multithreading](https://beej.us/guide/bgc/html/split/multithreading.html)
Creating a thread: creates a peer (not child to a parent process like in multiprocessing).    
Thread safety: a function is thread safe when it has correct results when it is invoked by mumtiple concurrent threads at the same time. Functions called from a thread must also be thread safe.         
Synchronization primitives: mutexes, semaphores     
Mutex (mutual exceptions): protects a section of code from being run at the same time by different threads. Used to protected a shared resource (ie a file) from being accessed and modified by multiple threads at the same time. Can be accquired or released.          
Semaphores: similiar to a mutex, can be locked / unlocked by any part of the program.        
Conditional variables: a condition to be checked that allows for threads to go to sleep until an event on another thread occurs.     

## Pthreads - Threading on Unix / Linux 
Threading: using Pthreads (POSIX thread) interface on Unix/ Linux.      
[POSIX Threads Programming](https://hpc-tutorials.llnl.gov/posix/)     
[Pthreads tutorial](https://www.cs.cmu.edu/afs/cs/academic/class/15492-f07/www/pthreads.html)     
[POSIX Threads](http://www.csc.villanova.edu/~mdamian/threads/posixthreads.html)     

    #include <pthread.h>   
    //to compile: gcc -pthread or -lpthread    depending on the platform    
Create and reap threads:        

    pthread_t thread[2];    
    //int  pthread_create(pthread_t  * thread, pthread_attr_t * attr, void *(*start_routine)(void *), void * arg);
    //args: return pointer to the thread ID, thread args (NULL unless you want the thread to have a specific priority), thread routine, thread args as a (void *p)  
    pthread_create(&thread[0],NULL,&fctn1,NULL);
    //pthread_join();     
    pthread_join(thread[0],NULL);   //thread id, return value as a (void **p)
Determine your thread ID     

    pthread_self();     
Terminating threads:      

    pthread_cancel();    
    pthread_exit();   
    exit();     //terminates all threads    
    RET    //terminates current thread   
Synchronize access to variables:      

    pthread_mutex_init();   
    pthread_mutex_lock; 
    pthread_mutex_unlock;   

### Pthread Mutexes   
Pthread mutexes: provides mechanism to solve mutual exclusion, ensure threads access shared state in a controlled way.      
```
pthread_mutex_t aMutex = PTHREAD_MUTEX_INTIALIZER;   //mutex type    
pthread_mutex_lock(&aMutex);    //explicit lock    
//critical section code - protected by the mutex      
pthread_mutex_unlock(&aMutex);   //explicit unlock   

pthread_mutex_init(&mutex, &attr);   //attr - mutex behavior. NULL is default. Mutex is shared among processes.   
pthread_mutex_trylock(&mutex);   //check mutex - return if in use and notify calling thread. If free - will lock the mutex. Gives calling thread option to do something else while waiting     
pthread_mutex_destroy(&mutex);   //clean up and destroy the mutex object 
```
Mutex safety tips:     
- Shared data should always be accessed through a single mutex.       
- Mutex scope must be visible to all threads.      
- Globally scope locks.     
- For all threads - lock mutexes in order. Ensure deadlocks don't happen.    
- Always unlock the correct mutex.      

### Pthread Conditional Variables     
Pthread conditional variables: notify thread when a specific condition occurs.     
```
pthread_cond_t cond = PTHREAD_COND_INTIALIZER;   //type of cond var      
pthread_cond_wait(&cond, &mutex);      //wait        
pthread_cond_signal(&cond);    //notify 1 thread    
pthread_cond_broadcast(&cond);     //notify all threads       
pthread_cond_init(&cond, &attr);   //set attrs - like if shared    
pthread_cond_destroy(&cond);    
```
Conditional Variable safety tips:      
- Don't forget to notify waiting threads. Predict change - signal / broadcast correct condition variable.    
- When in doubt - broadcast instead of signal (note this could mean performance loss).     
- You don't need a mutex to signal / broadcast.    