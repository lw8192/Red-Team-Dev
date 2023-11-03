# Socket Programming in C      
[Beej's Guide to Network Programming](https://beej.us/guide/bgnet/)   
Sockets are treated like files in C, so you use file descriptors to access them. You can use read() and write() to send / rx data. Functions for sockets are defined in /usr/include/sys/sockets.h.    
Stream sockets: tcp, 2 way connection, packets without errors and in sequence.   
Datagram sockets: 1 way, UDP, unreliable. Basic and lightweight.    
## Common Socket Functions    

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
Define a sockaddr struct:    
```
  struct sockaddr_in host_addr; 
  host_addr.sin_family = AF_INET;   //host byte order   
  host_addr.sin_port = htons(80);   //short, converting port to network byte order.    
  host_addr.sin_addr.s_addr = 0;  //auto fills with my ip  
  memset(&(host_addr.sin_zero), '\0', 8);  //zero the rest of the struct
```
