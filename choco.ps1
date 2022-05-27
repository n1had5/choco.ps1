Start-Transcript -Path choco.log -UseMinimalHeader

# Save the current execution policy...
$currPolicy = Get-ExecutionPolicy

# Temporarily set the policy to 'Bypass' for this process.
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Install Chocolatey if not installed
if (!(Test-Path -Path "$env:ProgramData\Chocolatey")) {
  Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Fixes autocomplete error if no profile was found while installing chocolatey.
Import-Module “$env:ChocolateyInstall\helpers\chocolateyProfile.psm1” -Force

# Bypass package confirmation prompt
choco feature enable -n=allowGlobalConfirmation

# For each package in the list run install
Get-Content ".\$args" | ForEach-Object{($_ -split "\r\n")[0]} | ForEach-Object{choco install $_}

# Restore the previous execution policy for this process.
Set-ExecutionPolicy -Scope Process -ExecutionPolicy $currPolicy -Force

# Stop
Stop-Transcript