$Directory = "${env:ProgramFiles(x86)}\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\"

$File = [System.IO.Path]::Combine($Directory, 'ssms.pkgundef')

$Lines = [System.IO.File]::ReadAllLines($File)

$NewLines = @()

$i = 0;
$l = 0

$Lines | ForEach-Object -Process { 
    $Line = $_
    
    $i++

    if ($Line -eq '// Remove Dark theme')
    {
        $l = $i + 1
    }
    
    
    if ($i -eq $l)
    {
        $Line = "//" + $Line
    }
    
    $NewLines += $Line
 }
 

Set-Content -Path $File -Value $NewLines -Force -Verbose
