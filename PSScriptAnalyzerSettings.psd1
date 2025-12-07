@{
    # PSScriptAnalyzer settings for Dre.IO.FIXiT
    Severity = "Warning"
    Rules = @{
        # Enforce approved verbs and other basic rules
        PSUseApprovedVerbs = @{ Enable = $true }
        PSAvoidUsingCmdletAliases = @{ Enable = $true }
        PSUseDeclaredVarsMoreThanAssignments = @{ Enable = $true }
    }
    # You can add exclusions per-file or per-rule below if needed.
    ExcludeRules = @()
}
@{
    # PSScriptAnalyzer settings for this repository
    Rules = @{
        PSUseApprovedVerbs = @{ Enable = $true }
        # Keep default rules enabled; customize here as needed.
    }
}
