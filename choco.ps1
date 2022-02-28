# Requires -RunAsAdministrator

Set-ExecutionPolicy Bypass -Scope Process -Force

# install chocolatey if not installed

if (!(Test-Path -Path "$env:ProgramData\Chocolatey")) {
  Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# prompt for confirmation in scripts or bypass

choco feature enable -n=allowGlobalConfirmation

# for each package in the list run install
Get-Content ".\packages" | ForEach-Object{($_ -split "\r\n")[0]} | ForEach-Object{choco install -y $_}

# casio bell

while (1) {
      1..2 | % { [console]::beep(3900, 225) }
      Start-Sleep -Milliseconds 450
      }