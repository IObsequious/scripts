<#

    Windows Customization Script

#>


# Show seconds when displaying time
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'ShowSecondsInSystemClock' -Value 1 -Force -Verbose

# Disable the logon background image
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name 'DisableLogonBackgroundImage' -Value 1 -Force -Verbose

# Use Dark Theme
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name 'AppsUseLightTheme' -Value 0 -Force -Verbose

if (!(Test-Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC"))
{
    New-Item "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" -Force -Verbose

}


Set-ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC\" -Name 'EnableMtcUvc' -Value 0 -Force -Verbose
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\TestHooks" -Name 'Threshold' -Value 1 -Force -Verbose


# Show Icons in TaskBar Context Menu
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ContextMenuConfig" -Value 2 -Force -Verbose

# Hide Unnecessary Folders:
$FolderDescriptions = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions"
# Pictures
Set-ItemProperty "$FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" -Name "ThisPCPolicy" -Value 'Hide' -Force -Verbose
# Videos
Set-ItemProperty "$FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" -Name "ThisPCPolicy" -Value 'Hide' -Force -Verbose
# Downloads
Set-ItemProperty "$FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" -Name "ThisPCPolicy" -Value 'Hide' -Force -Verbose
# Music
Set-ItemProperty "$FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" -Name "ThisPCPolicy" -Value 'Hide' -Force -Verbose
# Desktop
Set-ItemProperty "$FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" -Name "ThisPCPolicy" -Value 'Hide' -Force -Verbose
# Documents
Set-ItemProperty "$FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" -Name "ThisPCPolicy" -Value 'Hide' -Force -Verbose



