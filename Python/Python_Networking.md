# Networking in Python    
sockets: standard Python3 built in lib.     

    import socket   
## Other Networking Libraries   
Twisted: event driven networking engine     
Impacket: working with network protocols    
Paramiko: secure SSH and SCP connections.       
[Scapy](https://github.com/secdev/scapy): packet manipulation library use to forge, decode, send and capture packets at a low level.   

    pip install scapy    
    from scapy.all import *     
pylibnet: API for libnet, send packets, sniff frames, display libpcap traces.     
Rawsocketpy: low level layer comms at layer 2 using MAC addrs. 

Address family: AF_INET - IPV4, AF_INET6 - IPv6.    
Protocol: SOCK_STREAM - TCP socket, communications occur until terminated. SOCK_DGRAM - UDP socket. SOCK_RAW - raw socket, no TCP/IP/UDP headers so you need to craft the packet yourself.        
Server
```
socket.socket(addr_family, protocol)       #generate a socket handler    
socket.bind((host_ip, host_port))          #bind to a local address
socket.listen()                           #put socket into listening mode    
client_sock, client_ip = socket.accept()       #accept a connection 
socket.close()         #closes SOCK_STREAM socket
socket.send("data".encode())  #sends data across the channel. Need to encode since a socket transfers bytes, not strings.  
socket.recv(1024).decode()          #receive data from the channel and decode from bytes  
```
Client functions:     
```
socket.connect((server_ip, server_port))       #bind to a remote address
socket.close()         #closes SOCK_STREAM socket
socket.send("data")  #sends data across the channel
socket.recv          #receive data from the channel
```

### Raw Sockets   
[Layer 2 Raw Socket Programming](https://iplab.naist.jp/class/2018/materials/hands-on/layer-2-raw-socket/)