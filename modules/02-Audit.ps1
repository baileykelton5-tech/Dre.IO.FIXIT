<#
02-Audit.ps1
Purpose: Run non-destructive audits (accounts, services, ports, installed apps)
#>
[CmdletBinding()]
param(
    [switch]$VerboseOutput
)

$projectRoot = Resolve-Path "$PSScriptRoot\.."
$logsDir = Join-Path $projectRoot 'logs'
if (-not (Test-Path $logsDir)) { New-Item -Path $logsDir -ItemType Directory | Out-Null }
$logFile = Join-Path $logsDir ("audit_{0}.log" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
function Log { param($Message, $Level = 'INFO') $entry = "$(Get-Date -Format s) [$Level] $Message"; $entry | Tee-Object -FilePath $logFile -Append }

Log "Audit started"

# Sample non-destructive checks
Log "Collecting local users"
Get-LocalUser | Select-Object Name,Enabled,SID | Out-String | ForEach-Object { Log $_ }

Log "Collecting running services"
Get-Service | Where-Object {$_.Status -eq 'Running'} | Select-Object Name,DisplayName,Status | Out-String | ForEach-Object { Log $_ }

Log "Collecting listening TCP ports (requires admin)"
try { netstat -ano | Out-String | ForEach-Object { Log $_ } } catch { Log "netstat failed: $_" 'WARN' }

Log "Audit completed"
Write-Host "Audit complete. Logs: $logFile" -ForegroundColor Cyan
