$existingPath = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$newGitPath = "C:\Program Files\Git\bin"
if ($existingPath -split ";" -notcontains $newGitPath)
{
	$newpath = $existingPath + ";" + $newGitPath
	[Environment]::SetEnvironmentVariable("Path", $newpath, "Machine")

    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

$repoRoot = (Join-Path -Path "C:\" -ChildPath "Enlistment")
if (-not (Test-Path -Path $repoRoot)) {
	New-Item -Path $repoRoot -ItemType Directory
}

Set-Location -Path $repoRoot

if (-not (Test-Path -Path $repoRoot\VMSetup)) 
{
   & git clone "https://Dynamics365Assistant@dev.azure.com/Dynamics365Assistant/AIBot/_git/VMSetup"
}
else
{
   & git pull
}

if (Test-Path -Path $repoRoot\VMSetup) 
{
    cd VMSetup
    Start-Process -wait powershell.exe -ArgumentList "& .\VMSetup.ps1 nopause"
}
