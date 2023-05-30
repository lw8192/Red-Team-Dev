Function hostenum{
  Write-Output "========== Basic Enumeration =========="
  Get-Date
  Write-Output "===== PID of script ====="
  $PID
  Write-Output "===== User info ====="
  whoami 

  Write-Output "===== System info ====="
  Get-ComputerInfo

  Write-Output "===== Network Interfaces ====="
  Get-NetIPConfiguration

  Write-Output "===== Network Connections ====="
  netstat -ano

  Write-Output "===== Network Host Has Connected To ====="
  Get-ChildItem 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles' | findstr /i Profilename

  Write-Output "===== Processes ====="
  Get-Process | select Id, Name, SessionId, Threads

  Write-Output "===== Shares ====="
  Get-smbshare

  Write-Output "========== Security Checks =========="

  Write-Output "===== Hotfixes ====="
  Get-Hotfix

  Write-Output "===== Anti-Virus Products Installed ====="
  Get-WmiObject -Namespace root\SecurityCenter2 -Class AntiVirusProduct | Format-List DisplayName,PathToSignedProductExe,PathToSignedReportingExe

  Write-Output "===== Malware History (Kernel 6+) ====="
  Get-MpThreatDetection

  Write-Output "===== Admin Users ====="
  net localgroup Administrators

  Write-Output "===== Auto Admin Logon Check ====="
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoAdminLogon 

  Write-Output "===== Is anon access restricted? ====="
  Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\control\LSA'

  Write-Output "===== Guest account disabled? ====="
  Get-WmiObject win32_UserAccount -Filter "Name='Guest'" | select __SERVER,Disabled

  Write-Output "===== Auditing Checks ====="
  Get-LogProperties -Name security | select enabled 
  auditpol /get /category:*


  Write-Output "========== Malware Persistence Checks =========="
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
  Write-Output "===== Installed Drivers ====="
  Get-WindowsDriver -online | select-object Driver,OriginalFileName,DriverSignature,ProviderName,Date,Logpath

  Get-Date
}

Write-Host "===== Blue Team Host Enumeration Script ====="
$outFile="C:\Windows\Temp\blue_team_host_enum.txt"
if ($args.count -eq 1) {
    $outFile= $args[0]
}

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
if (-Not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Host "Please run this script as administrator"
  exit
}

hostenum > $outfile
Write-Host "Blue team host enumeration done, check"$outfile
