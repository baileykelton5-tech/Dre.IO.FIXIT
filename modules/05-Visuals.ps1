<#
05-Visuals.ps1
Purpose: Apply branding and UI changes (wallpapers, icons). Actions are non-destructive by default.
#>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [switch]$DryRun
)

$projectRoot = Resolve-Path "$PSScriptRoot\.."
$assetsDir = Join-Path $projectRoot 'assets'
$logsDir = Join-Path $projectRoot 'logs'
if (-not (Test-Path $logsDir)) { New-Item -Path $logsDir -ItemType Directory | Out-Null }
$logFile = Join-Path $logsDir ("visuals_{0}.log" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
function Log { param($Message,$Level='INFO') $entry = "$(Get-Date -Format s) [$Level] $Message"; $entry | Tee-Object -FilePath $logFile -Append }

Log "Visuals started"

# Example: list available backgrounds
$bgDir = Join-Path $assetsDir 'backgrounds'
if (Test-Path $bgDir) { Get-ChildItem -Path $bgDir -File | ForEach-Object { Write-Host "Found background: $($_.Name)" } }

# Prompt user for applying a wallpaper (example only)
$choice = Read-Host "Apply a background from assets/backgrounds? (y/N)"
if ($choice -match '^[Yy]') {
    if ($DryRun) { Log "Dry-run: would apply selected background"; Write-Host "Dry-run: skipping" -ForegroundColor Yellow } else { Log "User chose to apply background - implement specific set-wallpaper code here"; Write-Host "Applying background (placeholder)" -ForegroundColor Green }
}

Log "Visuals completed"
