<#
01-Initialize.ps1
Purpose: Prepare environment, create logs, set branding placeholders.
#>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [switch]$DryRun
)

$projectRoot = Resolve-Path "$PSScriptRoot\.."
$logsDir = Join-Path $projectRoot 'logs'
if (-not (Test-Path $logsDir)) {
    if ($DryRun) { Write-Host "DryRun: would create $logsDir" -ForegroundColor Yellow } else { New-Item -Path $logsDir -ItemType Directory | Out-Null }
}
$logFile = Join-Path $logsDir ("initialize_{0}.log" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
function Log { param($Message, $Level = 'INFO') $entry = "$(Get-Date -Format s) [$Level] $Message"; $entry | Tee-Object -FilePath $logFile -Append }

Log "Initialize started"

if ($PSCmdlet.ShouldProcess('Local machine','Initialize environment')) {
    if ($DryRun) { Log "Dry-run: no changes applied"; Write-Host "Dry-run: skipping changes" -ForegroundColor Yellow; return }

    # Example safe actions (commented) - replace with desired initialization steps
    # Set computer name, create required folders, verify permissions, etc.
    # New-Item -Path 'C:\SomeFolder' -ItemType Directory -Force

    Log "Initialize completed"
    Write-Host "Initialization completed." -ForegroundColor Green
}
else {
    Log "User declined Initialize"; Write-Host "Initialize canceled." -ForegroundColor Yellow
}
