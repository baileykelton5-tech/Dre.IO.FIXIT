# Dre.IO.FIXiT

A small, modular PowerShell-based setup and lockdown toolkit.

Usage

- Open PowerShell (recommended `pwsh.exe` / PowerShell 7+) in the project root.
- Run the launcher interactively:

```powershell
pwsh -File .\Dre.IO.FIXiT.ps1
```

Structure

- `modules/` — step modules (01-Initialize through 06-Verify).
- `assets/` — artwork and branding (icons, backgrounds, banners).
- `logs/` — generated logs and reports.

Notes

- Module scripts are placeholders; customize actions before running in production.
- The launcher dot-sources module scripts when you select a menu option.
