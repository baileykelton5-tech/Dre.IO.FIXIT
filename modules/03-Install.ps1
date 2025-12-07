<#
03-Install.ps1
Purpose: Prompted installation workflow with safety checks.
Note: This template never performs installs without explicit approval.
#>
[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [switch]$DryRun
)

$projectRoot = Resolve-Path "$PSScriptRoot\.."
$logsDir = Join-Path $projectRoot 'logs'
if (-not (Test-Path $logsDir)) { New-Item -Path $logsDir -ItemType Directory | Out-Null }
$logFile = Join-Path $logsDir ("install_{0}.log" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
function Log { param($Message,$Level='INFO') $entry = "$(Get-Date -Format s) [$Level] $Message"; $entry | Tee-Object -FilePath $logFile -Append }

Log "Install module started"

# Example app list - modify to suit your policy
$appsToConsider = @(
    @{Name='7zip'; Id='org.7zip.7zip'},
    @{Name='Visual Studio Code'; Id='Microsoft.VisualStudioCode'},
    @{Name='Notepad++'; Id='Notepad++.Notepad++'}
)

foreach ($app in $appsToConsider) {
    Write-Host "Consider installing: $($app.Name)" -ForegroundColor Cyan
    $answer = Read-Host "Install $($app.Name)? (y/N)"
    if ($answer -match '^[Yy]') {
        if ($DryRun) { Log "Dry-run: would install $($app.Name)"; Write-Host "Dry-run: skipping install of $($app.Name)" -ForegroundColor Yellow; continue }
        # Example using winget (commented for safety). Uncomment after review.
        # if ($PSCmdlet.ShouldProcess("Install $($app.Name)", "Run installer via winget")) {
        #     winget install --id $($app.Id) --accept-package-agreements --accept-source-agreements
        # }
        Log "User approved install for $($app.Name)"
    } else {
        Log "User declined install for $($app.Name)" 'WARN'
    }
}

Log "Install module completed"
Write-Host "Install routine finished (check logs)." -ForegroundColor Green
