<#
04-Lockdown.ps1
Purpose: Provide safe, auditable lockdown actions. By default this script is conservative and requires explicit confirmation.
#>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [switch]$DryRun
)

$projectRoot = Resolve-Path "$PSScriptRoot\.."
$logsDir = Join-Path $projectRoot 'logs'
if (-not (Test-Path $logsDir)) { New-Item -Path $logsDir -ItemType Directory | Out-Null }
$logFile = Join-Path $logsDir ("lockdown_{0}.log" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
function Log { param($Message,$Level='INFO') $entry = "$(Get-Date -Format s) [$Level] $Message"; $entry | Tee-Object -FilePath $logFile -Append }

Log "Lockdown started"

# Example: show proposed firewall rule changes (safe preview)
Write-Host "This module proposes to harden firewall and disable unnecessary services." -ForegroundColor Yellow
$confirm = Read-Host "Proceed with suggested lockdown? (type 'CONFIRM' to proceed)"
if ($confirm -ne 'CONFIRM') { Log 'User declined lockdown'; Write-Host 'Lockdown canceled' -ForegroundColor Yellow; return }

if ($DryRun) { Log "Dry-run: would apply lockdown changes"; Write-Host "Dry-run: no changes applied" -ForegroundColor Yellow; return }

# Firewall hardening helper (applies only after explicit confirmation)
function Set-FirewallHardening {
    param(
        [switch]$WhatIf
    )

    if ($WhatIf) {
        Write-Host "Preview: Would set default inbound action to Block for all profiles" -ForegroundColor Yellow
        Log "Preview: Firewall hardening (WhatIf)"
        return
    }

    try {
        Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultInboundAction Block -DefaultOutboundAction Allow -Confirm:$false
        Log "Applied firewall hardening: DefaultInboundAction=Block, DefaultOutboundAction=Allow"
    } catch {
        Log "Failed to apply firewall hardening: $_" 'ERROR'
    }
}

# Confirm and apply firewall hardening
$preview = Read-Host "Preview firewall changes? (y/N)"
if ($preview -match '^[Yy]') { Set-FirewallHardening -WhatIf; Write-Host "Preview displayed." -ForegroundColor Cyan }

$apply = Read-Host "Apply firewall hardening now? (type 'CONFIRM' to apply)"
if ($apply -eq 'CONFIRM') {
    Set-FirewallHardening
} else {
    Log "User chose not to apply firewall hardening"
    Write-Host "No firewall changes applied." -ForegroundColor Yellow
}

Log "Lockdown completed"
Write-Host "Lockdown actions applied (or simulated)." -ForegroundColor Green
