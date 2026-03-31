# Linux Signals    
Used to control process lifecycle.   

SIGINT(2): CTRL+C to interrupt process.     
SIGTERM (15): default signal to end a process. Allows process to cleanup before terminating.         
SIGKILL(9): forcefully terminate a process.   

> kill -<signal number> <pid> 
> kill -<signal name> <pid>   

Registering a signal handler:    
using signal() or sigaction(). sigaction provides more control       
sigprocmask()   set a signal mask to control what signals reach a process   
Using signal():   
```
#include <signal.h>
//void (*signal(int sig, void (*func)(int)))(int); 
void * signal_handler(){
    //actions using thread safe functions 
    return 0; 
}
signal(SIGINT, signal_handler);   //register signal handler  
```
```
#include <signal.h>

struct sigaction sa;
sa.sa_handler = signal_handler_function;
sigemptyset(&sa.sa_mask);  //no signal blocked 
sa.sa_flags = 0;   //set flags 
//int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact);
sigaction(SIGTERM, &sa, NULL);       //register signal handler 
```

Using signal handlers to cleanup while being thread safe:   
set volatile sig_atomic_t global variable flag in signal handler, main thread has a mechanism to check flag and call cleanup when set.    