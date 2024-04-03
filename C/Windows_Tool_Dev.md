# Developing Windows Tools       
## Resources    
[Windows API Index](https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-api-list)     
[Windows API Tutorial](https://zetcode.com/gui/winapi/)     
[Malapi.io](https://malapi.io/)    
## Setting up a Testing Enviroment     
Recommend: Windows 10 /11 x64 VM with Visual Studio 2019 “Desktop development with c++” and “.NET desktop development” packages       
[Commando](https://github.com/mandiant/commando-vm)     

[Red Team Ops: Windows Tool Dev preview](https://www.sans.org/webcasts/sec670-red-team-ops-windows-tool-dev-preview/)    
Source video: https://www.youtube.com/watch?v=yJzpHxc1meI       

First step after initial access: host survey. 
Red team tasks: persist, exfil data, pivot.    
Military: destroy, disrupt, deny degrade, deceive.     
Nation state: espionage, disinfo, ransomware etc.   
Enhance implants: manually load image into memory, re-implement API hooks, C2 callbacks, shellcode exec   
Testing tools: 32 arch still needed, 64 bit compatible. Build and test Debug versions. Build and test release versions. Replicate target enviroment and test.     
Test and break tools - see where they fail. Know Windows OS / Windows API      

DLLs: Windows, supply common functionality to applications. PE32/PE32+ format. Designed to be shared. Extensions: .lib, .dll. Like shared objects (Linux).        
Shared Objects: Linux - ELF format. No specific export syntax. .so or .a Dynamically loaded / unloaded with dlopen / dlclose. Resolve symbols with dlsym.             
C data types: int, long, unsigned long, double, float     
Windows provided data types: BOOL, BOOLEAN, INT, DWORD, VOID, PVOID, LPVOID, HINSTANCE, HANDLE       
Most windows functions are called from: NTDLL.DLL, Kernel32.DLL and Kernelbase.DLL      
Socket functions - ws2_32.dll     
Windows header files: Windows.h, Windef.h, WinNt.h, WinReg.h, WinSvc.h    

Windows API: provide critical functionality. Best practice: always use Windows APIs vs standard C functions.          

WORD, DWORD, LPDWORD, QWORD - defined in the WinDef.h header file.    

    DWORD ProcessId = GetCurrentProcessId();
    PDWORD pProcessId = &ProcessId;      //create pointer to processId value   
    LPDWORD lpProcessId = &ProcessId;
    DWORD pPeb32 = __readfsdword(0x30);
    QWORD pPeb64 = __readgsqword(0x60);    

VOID, PVOID, LPVOID, LPCVOID     
Declared in WinDef.h and WinNt.h header files.    

    VOID GiveGreeting()
    {
    printf(“I don’t return anything!\n”);
    }
    PVOID baseEntry = (PVOID)pimgOptionalHeader->AddressOfEntryPoint;
    LPCVOID pConstant = &SomeConstant;
    VOID OverflowMe(PCHAR Buffer)
    {
    strcpy(Buffer, “some words”);
    }   

Handles: reference system objects, used by an application to modify the object. Entered into a internal handle table that hold the addresses of the resources and the resource type.     
LPHANDLE, HKEY, HRSRC, HINSTANCE     
WINAPI, APIENTRY, CALLBACK: used when defining a function. From WinDef.h    

    BOOL WINAPI EnumProcesses( 
    _Out_writes_bytes_(cb) DWORD* lpidProcess,
    _In_ DWORD cb,
    _Out_ LPDWORD lpcbNeeded );
    WINADVAPI LSTATUS APIENTRY RegCreateKeyA ( 
    _In_ HKEY hKey,
    _In_opt_ LPCSTR lpSubKey,
    _Out_ PHKEY phkResult );
    typedef UINT (CALLBACK *LPFNPSPCALLBACKA)( 
    HWND hwnd, 
    UINT uMsg, 
    struct _PROPSHEETPAGEA *ppsp );

Defensive Tools:   
[PESieve](https://github.com/hasherezade/pe-sieve)   

## Syscalls   
API hooking: AV products inspect Win32 API calls before they are executed, decide if they are suspicious/malicious, and either block or allow the call to proceed. Evade this by using syscalls.   
Every native Windows API call has a number to present it (syscall). Differ between versions of Windows (find num using debugger or with public lists). Make a syscall: move number to a register. In x64, syscall instruction will then enter kernel mode. Direct syscalls in assembly: remove any Windows DLL imports, set up call ourselves (not using ntdll).      
Make syscall: set up args on the stack, move into EAX, use syscall CPU instruction (causing syscall to be executed in kernel mode).     
Syscall tables online: https://github.com/j00ru/windows-syscalls   

## The Native API    
Basic API for user-mode applications. Exported from ntdll.dll      
Kernel mode functions: have prefix Zw    
User mode functions: Nt prefix     

## The Windows API (WinAPI / Win32API)      
Easier and more secure to use then the Native API but slower. Many of these functions are wrappers to the Native API.          
Located on kernel32.dll, KernelBase.dll, advapi32.dll, user32.dll etc      

Provides OS functionality - userland and kernel land. APIs with Ex on the end are heavily modified.        
Naming: PrefixVerbTarget[Ex] / VerbTarget[Ex]     
Create* APIs: help a user application create a system object, usually returns a handle.      
CreateProcess, CreateFile, CreateThread, CreateDirectory, etc          
CreateProcess: returns a BOOL, creates a new process.   

    STARTUPINFO start_info = { sizeof start_ingo};
    PROCESSINFORMATION proc_info; 
    WCHAR command[] = L"whoami"
    CreateProcess(NULL,
        command, 
        NULL,
        NULL,
        FALSE,
        0, 
        NULL,
        NULL, 
        &start_info,
        &proc_info); 

### Windows API Calls    
Code injection: CreateRemoteThread, OpenProcess, VirtualAllocEx, WriteProcessMemory, EnumProcesses   
Dynamic DLL loading: LoadLibrary, GetProcAddress   
Memory scraping: CreateToolhelp32Snapshot, OpenProcess, ReadProcessMemory, EnumProcesses   
Data stealing: GetClipboardData, GetWindowText     
Keylogging: GetAsyncKeyState, SetWindowsHookEx   
Embedded resources: FindResource, LockResource   
Unpacking/self-injection: VirtualAlloc, VirtualProtect   
Query artifacts: CreateMutex, CreateFile, FindWindow, GetModuleHandle, RegOpenKeyEx   
Execute a program: WinExec, ShellExecute, CreateProcess   
Web interactions: InternetOpen, HttpOpenRequest, HttpSendRequest, InternetReadFile  

API Calls     
LoadLibraryA - Maps a specified DLL  into the address space of the calling process        

    HINSTANCE lib = LoadLibrary("example.dll");    //load a DLL    
    if((unsigned)lib<=HINSTANCE_ERROR)
    {
        /* error handler if the library refuses to load */
        return 1;
    }
GetUserNameA
	Retrieves the name of the user associated with the current thread
GetComputerNameA
	Retrieves a NetBIOS or DNS  name of the local computer
GetVersionExA
	Obtains information about the version of the operating system currently running
GetModuleFileNameA
	Retrieves the fully qualified path for the file of the specified module and process
GetStartupInfoA
	Retrieves contents of STARTUPINFO structure (window station, desktop, standard handles, and appearance of a process)
GetModuleHandle
	Returns a module handle for the specified module if mapped into the calling process's address space
GetProcAddress - Returns the address of a specified exported DLL function or variable.    

    addr_of_exported_symbol = GetProcAddress(dll_handle, function_name);    //Returns NULL if unsuccessful    

    static int (WINAPIV *DllFunction)(char*, ...);   //function pointer definition     
    HMODULE hLib = LoadLibraryA("ex.dll");      //load a dll  
    DllFunction = (void *()) GetProcAddress(lib, "DllFunction");     //map function pointers from the dll
    if (DllFunction == NULL){
        //handle error if the function is not found     
    }
    else{
        //use the function  
    }
VirtualProtect
	Changes the protection on a region of memory in the virtual address space of the calling process   

### Dynamically Import a Function from a DLL    
- Call LoadLibrary() to load the DLL in the process.       
- Call GetProcAddress() with the DLL and name of the function to get a function pointer.    
- Call and use the function.    
- Call FreeLibrary() to unload the DLL when finished.    

Use GetModuleHandle and GetProcAddress      

## Windows Process Injection    
[Process Injection Methods](https://github.com/odzhan/injection)    
[Windows - 10 Common Process Injection Techniques](https://www.elastic.co/blog/ten-process-injection-techniques-technical-survey-common-and-trending-process)    

## Windows Internals       
[Portable Executable File Format](https://blog.kowalczyk.info/articles/pefileformat.html)      

### Process Overview    
EPROCESS - 
TEB / PEB - created when the OS executes an exe. 
TEB (Thread Enviromental Block) - contains info related to a thread.            
PEB / LDR (Process Enviromental Block) - contains info related to a process including process name, PID and loaded modules. PEB_LDR_DATA - struct inside the PEB, contains linked lists InLoadOrderModuleList, InMemoryOrderModuleList, InMemoryOrderModuleList        
PEB - at offset fs[:0x30] in the TEB for x86 processes and GS:[0x60] for x64 processes.     
You can use intrinsics to get the address of the PEB / TEB - which requires <windows.h> to be included     
```
printf("The PEB is at address %p\n", (PEB*)__readgsqword(0x60));    //64 bit windows. Needs <intrin.h>   
```               

## Windows Shellcoding   
### Including ASM in C/C++ Code    
[x86] __readfsbyte __readfsdword __readfsqword __readfsword           
[x64] __readgsbyte __readgsdword __readgsqword __readgsword      
x86 - you can use asm() or __asm{} block - in line assembly. This only works on 32-bit systems. Ref: [Inline Assembler](https://learn.microsoft.com/en-us/cpp/assembler/inline/inline-assembler?view=msvc-170)                 
x86 inline assembly:      
```
   __asm
   {
      mov eax, ecx     ; do some assembly stuff here 
   }
```
x64 - no inline assembly. If unable to use intrinsics - you will most likely need to write a seperate .asm file, assemble using MASM, and then link it in to include the code in your program build. Other option: write the asm as shellcode, extract the bytes, include it in a buffer with RWX in your code and then use it.        
[How to build a mixed-source x64-project with a x64 assembly file in Visual Studio](https://stackoverflow.com/questions/33751509/external-assembly-file-in-visual-studio/33757749#33757749)        
[Using Assembly in C programs ](https://sonictk.github.io/asm_tutorial/#usingassemblyinc/c++programs)      
Asm file ex:  
```
PUBLIC test_func
test_func PROC
    mov rax, rcx   ; move rcx into rax, rax will be the return value of the function  
    ret
test_func ENDP
```
In your C/C++ code:  
```
extern int test_func(int x);    //define header for the function and then use it 
int main(){
    int value = test_func();   //test_func will return the value that was in rax   
}
```
