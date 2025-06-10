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

if (Test-Path -Path $repoRoot\VMSetup) {
	if (-not (Test-Path $repoRoot\VMSetup\*)) {
		Remove-Item $repoRoot\VMSetup -Recurse -Force
	}
}

if (-not (Test-Path -Path $repoRoot\VMSetup)) 
{
	Set-Location -Path $repoRoot
   	& git clone "https://Dynamics365Assistant@dev.azure.com/Dynamics365Assistant/AIBot/_git/VMSetup"
}
else
{
    Set-Location -Path $repoRoot\VMSetup
    & git pull
}

Start-Process -wait powershell.exe -ArgumentList "& $repoRoot\VMSetup\VMSetup.ps1"
