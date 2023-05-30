Function hostenum {
    Write-Output "===== Start time of script ====="
    Get-Date
    Write-Output "===== PID of script ====="
    $PID
    Write-Output "===== User info ====="
    whoami
    Write-Output "User has admin privs:"
    ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
    Write-Output "===== System info ====="
    Get-ComputerInfo | select CsSystemType, OsName, OsVersion, OsHotFixes, CsDomain, CsDomainRole

    Write-Output "===== TCP Connections ====="
    Get-NetTCPConnection | select LocalAddress,LocalPort,RemoteAddress,RemotePort,State,OwningProcess | Format-Table
    Write-Output "===== UDP Connections ====="
    Get-NetUDPEndpoint | select LocalAddress,State,OwningProcess | Format-Table

    Write-Output "===== Network Configuration ====="
    Get-NetIPConfiguration
    Get-NetAdapter | select Name,InterfaceDescription, MacAddress
    Get-DnsClientServerAddress | select InterfaceAlias, ServerAddresses

    Get-NetIPAddress -AddressFamily ipv4
    Get-NetIPAddress -AddressFamily ipv6

    Write-Output "===== SMB Shares ====="
    Get-SmbShare
    Write-Output "===== Drives ===== "
    Get-PSDrive
    fsutil fsinfo drives

    Write-Output "===== Sessions ===== "
    Query session 

    Write-Output "===== Processes ===== "
    Get-CimInstance win32_process | select name, ProcessId, ParentProcessId, sessionid, Priority, ThreadCount, HandeCount, CreationDate | Format-Table

    Write-Output "===== Services ===== "
    Get-Service | where-object {$_.Status -eq "running"}

    Write-Output "===== End time of script ====="
    Get-Date
}
Write-Host "===== Basic Host Enumeration Script ====="
$outFile="C:\Windows\Temp\basic_host_enum.txt"
if ($args.count -eq 1) {
    $outFile= $args[0]
}
hostenum > $outfile
Write-Host "Basic host enumeration done, check"$outFile
