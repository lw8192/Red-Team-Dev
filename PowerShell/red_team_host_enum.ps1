
Function hostenum{
    Write-Output "========== Basic Enumeration =========="
    Write-Output "===== Start time of script ====="
    Get-Date
    Write-Output "===== PID of script ====="
    $PID
    Write-Output "===== User info ====="
    whoami 
    query session

    Write-Output "===== System info ====="
    Get-ComputerInfo

    Write-Output "===== Network Interfaces ====="
    ipconfig
    Get-WmiObject -Class win32_NetworkAdapterConfiguration | where-object {$_.IPAddress} | Format-Table

    Write-Output "===== Network Connections ====="
    netstat -ano

    Write-Output "===== Processes ====="
    tasklist 
    Get-Process | select Id, Name, SessionId

    Write-Output "===== Services ====="
    Get-Service | where-object {$_.Status -eq "running"}

    Write-Output "===== Drives ====="
    Get-WmiObject -Class win32_LogicalDisk -Filter "DriveType=3" | Format-Table DeviceID, Size, FreeSpace
    fsutil fsinfo drives

    Write-Output "===== Processor Load ====="
    Get-WmiObject -Class win32_processor | select-object name, LoadPercentage

    Write-Output "===== Memory Load ====="
    Get-WmiObject -Class win32_OperatingSystem


    Write-Output "========== Security Checks =========="
    Write-Output "===== Security Logging Checks ====="
    Get-LogProperties Security | Format-List enabled
    auditpol.exe /get /category:*
    Get-EventLog Security -Newest 20


    Write-Output "===== PowerShell Logging Checks ====="
    if (Get-itemproperty HKLM:\software\Policies\Microsoft\Windows\Powershell -Name ModuleLogging -ea SilentlyContinue){
        Write-Output "PowerShell Module Logging is enabled"
    }
    if (Get-itemproperty HKLM:\software\Policies\Microsoft\Windows\Powershell\ScriptBlockLogging -Name EnableScriptBlockLogging -ea silentlycontinue){
        Write-Output "PowerShell Script Block Logging is enabled"
    }
    if (Get-itemproperty HKLM:\software\Policies\Microsoft\Windows\Powershell\Transcription -Name EnableTranscripting -ea silentlycontinue){
        Write-Output "PowerShell Transcription Logging is enabled"
    }


    Write-Output "===== Anti-Virus Product Checks ====="
    #Windows Defender
    Get-Service | findstr /i "WinDefend"
    Get-Item HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend | findstr /i "ImagePath"
    Get-Process | select ProcessName, Id | findstr /i "MsMpEng"       
    Get-Process | select ProcessName, Id | findstr /i "NisSrv"
    Get-Process | select ProcessName, Id | findstr /i "Msseces"

    Write-Output "===== Firewall Status ====="
    get-service | findstr /i "mpssvc"
    Get-NetFirewallSetting -PolicyStore activestore

    Write-Output "===== VM Checks ====="
    Get-Item HKLM:\HARDWARE\DESCRIPTION\System\BIOS
    Get-Process | select ProcessName,Id |findstr /i "vm"
    Get-Process | select ProcessName,Id |findstr /i "virtual"
    Get-Process | select ProcessName,Id |findstr /i "qemu"
    Get-Process | select ProcessName,Id |findstr /i "vbox"



    Write-Output "========== Persistence Checks =========="
    #Registry
    Write-Output "===== Registry ====="
    Get-Item 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' | findstr "Userinit"

    Get-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run 
    Get-Item HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce 
    Get-Item HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run 
    Get-Item HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce 


    #At (pre Windows 7 scheduled tasks)
    Write-Output "===== Scheduled Tasks ====="
    at jobs - at
    schtasks /query /v /FO list


    Write-Output "===== Startup Folders ====="
    Get-ChildItem "C:\AppData\Microsoft\Windows\Start Menu\Programs\Startup" -ea SilentlyContinue
    Get-ChildItem "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"


    #Services
    Write-Output "===== Services ====="
    Get-wmiobject win32_service | where-object { $_.StartMode -eq "Auto" }

    #WMI Permanent events, SCM Event Log Consumer is default 
    Write-Output "===== WMI Events ====="
    Get-wmiobject -Namespace root\Subscription -Class __FilterToConsumerBinding


    Write-Output "========== Final Checks =========="
    Write-Output "===== Files Updated in the Last Hour ====="
    Get-ChildItem -Path C:\ -recurse -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -ge (Get-Date).AddMinutes( -60) } 
    Get-Date
}

Write-Host "===== Red Team Host Enumeration Script ====="
$outFile="C:\Windows\Temp\red_team_host_enum.txt"
if ($args.count -eq 1) {
    $outFile= $args[0]
}

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
if (-Not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Host "Please run this script as administrator"
  exit
}

hostenum > $outfile
Write-Host "Red team host enumeration done, check"$outFile
