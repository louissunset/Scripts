$existingPath = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$newGitPath = "C:\Program Files\Git\bin"
if ($existingPath -split ";" -notcontains $newGitPath)
{
	$newpath = $existingPath + ";" + $newGitPath
	[Environment]::SetEnvironmentVariable("Path", $newpath, "Machine")
}

$downloads = [System.Environment]::GetFolderPath('Downloads')
Set-Location -Path $downloads
& git clone https://yunguprivate@dev.azure.com/yunguprivate/Tools/_git/VMSetup

$VMSetupFolder = (Join-Path -Path $downloads -ChildPath "VMSetup")
Set-Location -Path $VMSetupFolder
Start-Process powershell.exe -ArgumentList "& VMSetup.ps1"
