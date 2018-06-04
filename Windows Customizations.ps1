<#

    Windows Customization Script

#>

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'ShowSecondsInSystemClock' -Value 1 -Force -Verbose


Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name 'DisableLogonBackgroundImage' -Value 1 -Force -Verbose



Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name 'AppsUseLightTheme' -Value 0 -Force -Verbose

if (!(Test-Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC"))
{
    New-Item "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" -Force -Verbose

}


Set-ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC\" -Name 'EnableMtcUvc' -Value 0 -Force -Verbose


Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\TestHooks" -Name 'Threshold' -Value 1 -Force -Verbose


# Set-ItemProperty "HKLM:\Software\Microsoft\WindowsUpdate\UX" -Name 'IsConvergedUpdateStackEnabled' -Value 0 -Force -Verbose







