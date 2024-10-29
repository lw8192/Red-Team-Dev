# Programming in Go    
Compiles fast, includes runtime and garbage collection, simple static type system, dynamic interfaces, good standard library. Omits OOP - no classes, objects or inheritance. Mixins: embed structs anonymously.     
Testing with benchmarks: using the framework for unit tests.   
> go test -bench . package_name    
Concurrent access in Go - threading    
goroutines: building blocks for concurrency, lightweight threads managed by the Go runtime (not by the OS).    
Add explicit mutex or read-write lock    
Channels - comm routines between goroutines, "goroutine safe", unbuffered channels. Better to pass plain values instead of pointers.    
Interface: set of methods signatures.    
Basic Go program:  
```
package main 
import "fmt"
func main(){
    fmt.Println("test")
}
```

> go version   
> go run hello.go    #run directly    
> go mod init .      #choose mod path and create go.mod file   
> go mod init example/user/hello     
> go install example/user/hello      #build and install   
> go run .     #run the module    

Enviromental Variables:   
[GOPATH](https://medium.com/learn-go/go-path-explained-cab31a0d90b9)     
> echo $GOROOT     
> echo $GOPATH   
If GOROOT is empty / wrong:
> which go       # ex: /usr/bin   
> export GOROOT=/usr/bin        

If GOPATH is empty / wrong: create any directory anywhere on your computer for go projects. Ex: ~/projects
> export GOPATH=~/projects


## Working with Files   
os package: OS features like file system    
```
import os 
    filepath := "data.txt" 
    data.err := os.readFile(filepath)
```


[Go Cheatsheet - devhints](https://devhints.io/go)     
[Getting Started with Go](https://go.dev/doc/tutorial/getting-started)      
[Go Cheatsheet](https://github.com/a8m/golang-cheat-sheet)     
[Card cheatsheet](https://cheatsheets.zip/go)