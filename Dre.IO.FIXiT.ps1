# Dre.IO.FIXiT.ps1 - Master Launcher Script

# Import modules
$modulesPath = "$PSScriptRoot\modules"

Import-Module "$modulesPath\01-Initialize.ps1"
Import-Module "$modulesPath\02-Audit.ps1"
Import-Module "$modulesPath\03-Install.ps1"
Import-Module "$modulesPath\04-Lockdown.ps1"
Import-Module "$modulesPath\05-Visuals.ps1"
Import-Module "$modulesPath\06-Verify.ps1"

# Display banner
Write-Host "`nWelcome to Dre.IO.FIXiT Setup Script" -ForegroundColor Cyan

# Simple menu interface
function Show-Menu {
    Write-Host "`nSelect an option:`n1) Initialize Environment
2) Run Security Audit
3) Install Applications
4) Apply Lockdown
5) Customize Visuals
6) Verify Changes
7) Exit"
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Enter your choice (1-7)"
    switch ($choice) {
        '1' { . "$modulesPath\01-Initialize.ps1" }
        '2' { . "$modulesPath\02-Audit.ps1" }
        '3' { . "$modulesPath\03-Install.ps1" }
        '4' { . "$modulesPath\04-Lockdown.ps1" }
        '5' { . "$modulesPath\05-Visuals.ps1" }
        '6' { . "$modulesPath\06-Verify.ps1" }
        '7' { break }
        default { Write-Host "Invalid selection, please try again." -ForegroundColor Red }
    }
}

Write-Host "Exiting Dre.IO.FIXiT. Goodbye!" -ForegroundColor Green
