Function New-WinpeWim
{
    [CmdletBinding()]
    param
    (
        [System.String] $WorkingDirectory  
    )

    $null = md "$WorkingDirectory\fwfiles"
    $null = md "$WorkingDirectory\scratch"
    $null = md "$WorkingDirectory\logs"
    $null = md "$WorkingDirectory\mount"
    $null = md "$WorkingDirectory\media\sources"

    $Verbose = $MyInvocation.BoundParameters.ContainsKey('Verbose')
    $Confirm = $MyInvocation.BoundParameters.ContainsKey('Confirm')
    $WinPERoot = "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment"
    $OscdimgRoot = "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\AMD64\Oscdimg"
    $WinPESourcePath = "$WinPERoot\amd64\en-us\winpe.wim"
    $WinPEDestinationPath = "$WorkingDirectory\media\sources\boot.wim"

    $env:Path = ($env:Path + ";C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM")

    if (![System.IO.Directory]::Exists($WinPERoot))
    {
        throw "Windows Assessment and Deployment Toolkit needs to be installed. Include 'Windows Preinstallation Environment' when installing."
    }

    if (![System.IO.Directory]::Exists($OscdimgRoot))
    {
        throw "Windows Assessment and Deployment Toolkit needs to be installed. Include 'Deployment Tools' when installing."
    }



    Copy-Item -Path $WinPESourcePath -Destination $WinPEDestinationPath -Verbose:$Verbose
    
    $MediaDirectory = "$WorkingDirectory\media"
    $SourcesDirectory = "$MediaDirectory\source"
    $FWFilesDirectory = "$WorkingDirectory\fwfiles"
    $MountDirectory = "$WorkingDirectory\mount"
    $LogDirectory = "$WorkingDirectory\logs"
    $ScratchDirectory = "$WorkingDirectory\scratch"
    $BootWimPath = "$SourcesDirectory\boot.wim"

   
    $LogFile = "$LogDirectory\winpe_builder_dism_log.log"
    $PackageDirectory = "$WinPERoot\amd64\WinPE_OCs"
    $CopyPEScript = "$WinPERoot\copype.cmd"

    $ArchRoot = "$WinPERoot\amd64"
    $MediaRoot = "$ArchRoot\Media"
    $BootRoot = "$MediaRoot\boot"
    $EFIRoot = "$MediaRoot\efi"

    #Start-Process cmd.exe -ArgumentList "/c `"$CopyPEScript`" amd64 $WorkingDirectory`"" -Wait

    Copy-Item -Path $BootRoot -Recurse -Destination $MediaDirectory -Verbose:$Verbose
    Copy-Item -Path $EFIRoot -Recurse -Destination $MediaDirectory -Verbose:$Verbose
    Copy-Item -Path "$MediaRoot\bootmgr" -Destination "$MediaDirectory\bootmgr" -Verbose:$Verbose
    Copy-Item -Path "$MediaRoot\bootmgr.efi" -Destination "$MediaDirectory\bootmgr.efi" -Verbose:$Verbose
    

    Mount-WindowsImage  -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -ImagePath $WinPEDestinationPath -Index 1 -Path $MountDirectory 

    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\WinPE-WMI.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\en-us\WinPE-WMI_en-us.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\WinPE-NetFX.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\en-us\WinPE-NetFX_en-us.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\WinPE-Scripting.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\en-us\WinPE-Scripting_en-us.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\WinPE-PowerShell.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\en-us\WinPE-PowerShell_en-us.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\WinPE-StorageWMI.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\en-us\WinPE-StorageWMI_en-us.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\WinPE-DismCmdlets.cab"
    Add-WindowsPackage -Verbose:$Verbose -LogPath $LogFile -ScratchDirectory $ScratchDirectory -Path $MountDirectory -PackagePath "$PackageDirectory\en-us\WinPE-DismCmdlets_en-us.cab"

    Dismount-WindowsImage -LogPath $LogFile -Verbose:$Verbose -ScratchDirectory $ScratchDirectory -Path $MountDirectory -Save

}

Remove-Item -Path "C:\WinPEx64" -Recurse

New-WinpeWim -WorkingDirectory "C:\WinPEx64" -Verbose