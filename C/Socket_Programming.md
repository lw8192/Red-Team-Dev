# Socket Programming in C      
[Simple Socket Tutorial](http://www.cs.rpi.edu/~moorthy/Courses/os98/Pgms/socket.html)     
[Beej's Guide to Network Programming](https://beej.us/guide/bgnet/)    
[Socket Programming Tutorial In C For Beginners | Part 1 | Eduonix](https://www.youtube.com/watch?v=LtXEMwSG5-8&t=1355s)        
Sockets: 1 end of a network connection, IP:port pair.    
Sockets are treated like files in C, so you use file descriptors to access them. You can use read() and write() to send / rx data. Functions for sockets are defined in /usr/include/sys/sockets.h.    
Stream sockets: TCP, 2 way connection, packets without errors and in sequence.   
Datagram sockets: 1 way, UDP, unreliable. Basic and lightweight.    
## Common Socket Functions    
### Setting up a simple socket on the client side:      
socket() - application buffer allocation. Create a client file descriptor.    

        int socket(int domain, int type, int protocol);  
        int file_descriptor = socket(AF_INET, SOCK_STREAM, 0);    //set up a ipv4 TCP socket    

connect() - set up a connection to the server. 

        int connect(int clientfd, SA *addr, socklen_t addrlen);    

Send and receive data - can use read()/write() or send()/recv()     
send() - transmit a message. Flag 0 = default behavior.    

        ssize_t send(int sockfd, const void buf[.len], size_t len, int flags); 

recv() - print the message received from the server to stdout. Flag 0 = default behavior.    

        ssize_t recv(int sockfd, void *buf, size_t len, int flags); 

Close the socket when done  

        close(file_descriptor); 

### Setting up a simple socket on the server side steps: 
socket() - application buffer allocation. Create a socket file descriptor.     

        int socket(int domain, int type, int protocol);   
setsockopt(SO_REUSEADDR) - allow the socket to reuse the local addresses and port (if you stop and restart the program).    

        setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &(int){1}, sizeof(int);   

bind() - kernel binds socket to service  

        int bind(int sockfd, SA *addr, socklen_t addrlen);    

listen() - puts the server socket in a listening state to receive connections from clients    

        int listen(int sockfd, int backlog);    

accept() - receive connection request, returns a new file descriptor for the connection.    

        int accept(int listenfd, SA *addr, int *addrlen);  
recv() - receive a message from a connected socket, returns length of the message sent in bytes. Flag 0 = default behavior.      

        ssize_t recv(int socket, void *buffer, size_t length, int flags);
        recv(sockfd, buf, buflen, FLAG | FLAG | FLAG);    //recv with custom behavior  

send() - send a message, returns number of bytes sent. Flag 0 = default behavior.     

        ssize_t send(int sockfd, const void *buf, size_t len, int flags); 

close() - close the socket file descriptor when done.   

      close(file_descriptor); 


## Sockaddr Structs    
A sockaddr struct is used to pass info that defines a host. It gives the address family and length.    
Netwokr byte order: the port number and IP address in the AF_INET socket addr struct needs to follow network byte ordering (big endian). Use conversion functions to do this.      
Conversion functions:   
```
htonl(long value);  //host to network long, converts 32 bit int from host byte order to network byte order   
htons(short);   //16 bit int from host to network byte order   
ntohl(long);  //32 bit int from network to host byte order   
ntohs(long);  //16 but int from network to host byte order 
```
### Manually defining a sockaddr struct:    
```
  struct sockaddr_in host_addr; 
  host_addr.sin_family = AF_INET;   //host byte order   
  host_addr.sin_port = htons(80);   //short, converting port to network byte order.    
  host_addr.sin_addr.s_addr = 0;  //auto fills with my ip  
  memset(&(host_addr.sin_zero), '\0', 8);  //zero the rest of the struct
```
### Using getaddrinfo() to dynamically get socket address info
Using getaddrinfo() to dynamically get ipv4 and ipv6 host details to be compatible with both.
Call getaddrinfo() - which returns a linked list socket addresses. Need to free with freeaddrinfo()     
Client connection code:     
```
  int sockfd;  
  struct addrinfo hints, *res, *p;   //p will be linked list with ipv4 / ipv6 connection info
  memset(&hints, 0, sizeof(hints));    //zero hints. 
  hints.ai_family = AF_UNSPEC;   //ipv4 or ipv6  
  hints.ai_socktype = SOCK_STREAM;  
  hints.ai_flags = 0;    //0 for client connection 
  if (getaddrinfo("localhost", "8080" ,&hints, &res) < 0){
    fprintf(stderr, "%s @ %d: unable to get host info\n", __FILE__, __LINE__);   
    return -1;    
  }      //get address info of localhost to be ipv6 compatible. 

  sockfd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);         //use results from getaddrinfo
  if (sockfd < 0){
      fprintf(stderr, "%s @ %d: unable to create socket\n", __FILE__, __LINE__);   
      freeaddrinfo(res);
      return -1; 
  }
  for (p = res; p != NULL; p = p->ai_next) {
    sockfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol);
    if (sockfd < 0) continue;
    if (connect(sockfd, p->ai_addr,p->ai_addrlen) == 0) {
        break; 
    }
    close(sockfd);
  }
  if (p == NULL){
    fprintf(stderr, "%s @ %d: unable to connect to server\n", __FILE__, __LINE__);   
    freeaddrinfo(res);
    return -1;    
  }
```
Getaddrinfo() - server connection code:   

## Networking on Windows using WinSock   