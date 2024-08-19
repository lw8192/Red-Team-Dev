# Programming in Go    
Compiles fast, includes runtime and garbage collection, simple static type system, dynamic interfaces, good standard library. Omits OOP - no classes, objects or inheritance. Mixins: embed structs anonymously.     
Testing with benchmarks: using the framework for unit tests.   
> go test -bench . package_name    
Concurrent access in Go - threading    
goroutines: building blocks for concurrency, lightweight threads amanged by the Go runtime (not by the OS).    
Add explicit mutex or read-write lock    
Channels - comm routines between goroutines, "goroutine safe", unbuffered channels. Better to pass plain values instead of pointers/ Interface: set of methods signatures.    

> go version   
> go run hello.go    #run directly    
> go mod init .      #choose mod path and create go.mod file   
> go mod init example/user/hello     
> go install example/user/hello      #build and install   
> go run .     #run the module   

[Go Cheatsheet - devhints](https://devhints.io/go)     
[Getting Started with Go](https://go.dev/doc/tutorial/getting-started)      
[Go Cheatsheet](https://github.com/a8m/golang-cheat-sheet)     
[Card cheatsheet](https://cheatsheets.zip/go)