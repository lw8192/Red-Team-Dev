# Implementing Threading in C    
Synchronization primitives: mutexes, semaphores    
Threading: using Pthreads (POSIX thread) interface on Unix/ Linux.      
[POSIX Threads Programming](https://hpc-tutorials.llnl.gov/posix/)     
[Pthreads tutorial](https://www.cs.cmu.edu/afs/cs/academic/class/15492-f07/www/pthreads.html)     

    #include <pthread.h>   
    //to compile: gcc -pthread  
Create and reap threads:        

    pthread_t thread[2];    
    //int  pthread_create(pthread_t  * thread, pthread_attr_t * attr, void *(*start_routine)(void *), void * arg);
    //args: return pointer to the thread ID, thread args (NULL unless you want the thread to have a specific priority), function to be executed, arg to the thread fctn when exec'd  
    pthread_create(&thread[0],NULL,fctn1,NULL);
    //pthread_join();     
    pthread_join(thread[0],NULL);
Determine your thread ID     

    pthread_self();     
Terminating threads:      

    pthread_cancel();    
    pthread_exit();   
    exit();     //terminates all threads    
    RET    //terminates current thread   
Synchronize access to variables:      

    pthread_mutex_init()   
    pthread_mutex_[un]lock   
