﻿<#  
.SYNOPSIS  
    Execute PowerShell script form URL.
.DESCRIPTION  
    Create Windows 10 task that will executer script publish over URL, not on local disk.
 
    
.NOTES  
    File Name  : Windows10-taskScheduler-register-executescript-url.ps1 
    Author     : Michal Machniak  
    Requires   : PowerShell V5.1
.LINK

    Github: https://github.com/mimachniak/sysopslife-scripts
    Site: https://sysopslife.sys4ops.pl/
    Modules links:
#>

#------------------------------------ Input parameters  ------------------------------------------------- #

$LogLocation = 'C:\Users\Public\Documents\' # Location of lgs generated by execution of the script
$LogFileName = 'IntunePowerShell.log' # log file name

$storageAccountNameScriptUrl = 'https://dofficetemplate.blob.core.windows.net/scripts/Intune-DocumentTemplateStorageAccount.ps1' # Azure Storage Acccount Url

Start-Transcript -Path  $LogLocation$LogFileName # Create log each run script

$argumentSring = '-ExecutionPolicy Unrestricted -WindowStyle Hidden -NonInteractive -NoLogo'+' "'+'iex ((New-Object System.Net.WebClient).DownloadString('+"'"+$storageAccountNameScriptUrl+"'"+'))'+'"'
$argumentSring
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument $argumentSring
$trigger = New-ScheduledTaskTrigger -AtLogon -User $env:USERNAME
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Intune Office Template" -User $env:USERNAME -Description "Refreshe Office Templates"

Stop-Transcript # End logging