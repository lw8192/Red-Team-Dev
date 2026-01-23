# Docker Notes        
tmp container with a shell   
> docker run -it --rm <image name> sh 
> docker exec -it  

## Setting up a cross compile toolchain in Docker          
https://medium.com/meseta-robots/set-up-cross-compile-toolchains-in-docker-to-save-time-openwrt-build-system-for-ar9331-1744629164c8   
Steps:   
1. Install the dependencies you need in the container.    
2. Set up toolchain with a config file.   
3. Insert code into container and manually exec to test.  