$Directory = "${env:ProgramFiles(x86)}\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\"

$File = [System.IO.Path]::Combine($Directory, 'ssms.pkgundef')

$Content = [System.IO.File]::ReadAllText($File)

$Content = [Regex]::Replace($Content, '.*\[$RootKey$\\Themes\\{1ded0138-47ce-435e-84ef-9ec1f439b749}\]', '//[$RootKey$\Themes\{1ded0138-47ce-435e-84ef-9ec1f439b749}]')

Set-Content -Path $File -Value $Content -Force -Verbose
