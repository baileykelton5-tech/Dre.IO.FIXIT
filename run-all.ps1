<#
run-all.ps1
Purpose: Convenience runner to execute each module in safe (dry-run) mode where applicable.
This script is intentionally local-only and does not contact external backends.
#>

Write-Host "Running Dre.IO.FIXiT modules (safe mode where supported)" -ForegroundColor Cyan

$modulesPath = "$PSScriptRoot\modules"

Write-Host "1) Initialize (dry-run)"
pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -File "$modulesPath\01-Initialize.ps1" -DryRun

Write-Host "2) Audit"
pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -File "$modulesPath\02-Audit.ps1"

Write-Host "3) Install (dry-run)"
pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -File "$modulesPath\03-Install.ps1" -DryRun

Write-Host "4) Lockdown (dry-run)"
pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -File "$modulesPath\04-Lockdown.ps1" -DryRun

Write-Host "5) Visuals (dry-run)"
pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -File "$modulesPath\05-Visuals.ps1" -DryRun

Write-Host "6) Verify"
pwsh -NoLogo -NoProfile -ExecutionPolicy Bypass -File "$modulesPath\06-Verify.ps1"

Write-Host "Run complete. Check the 'logs' directory for outputs." -ForegroundColor Green
