# Developing Windows Tools       
## Resources    
[Windows API Index](https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-api-list)     
[Windows API Tutorial](https://zetcode.com/gui/winapi/)     
[Malapi.io](https://malapi.io/)    
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
   
## The Windows API    
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

API Call	Explanation
LoadLibraryA
	Maps a specified DLL  into the address space of the calling process
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
GetProcAddress
	Returns the address of a specified exported DLL  function
VirtualProtect
	Changes the protection on a region of memory in the virtual address space of the calling process   

## Windows Process Injection    
[Process Injection Methods](https://github.com/odzhan/injection)    
[Windows - 10 Common Process Injection Techniques](https://www.elastic.co/blog/ten-process-injection-techniques-technical-survey-common-and-trending-process)    

## Syscalls   
API hooking: AV products inspect Win32 API calls before they are executed, decide if they are suspicious/malicious, and either block or allow the call to proceed. Evade this by using syscalls.   
Every native Windows API call has a number to present it (syscall). Differ between versions of Windows (find num using debugger or with public lists). Make a syscall: move number to a register. In x64, syscall instruction will then enter kernel mode. Direct syscalls in assembly: remove any Windows DLL imports, set up call ourselves (not using ntdll).      
Make syscall: set up args on the stack, move into EAX, use syscall CPU instruction (causing syscall to be executed in kernel mode).     
Syscall tables online: https://github.com/j00ru/windows-syscalls   
Table for below code (Win 10 x64): https://j00ru.vexillium.org/syscalls/nt/64/       
