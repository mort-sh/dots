# EZA Aliases for PowerShell
# Based on Linux .bashrc aliases but adapted for PowerShell syntax

# Check if eza command exists
if (-not (Get-Command eza -ErrorAction SilentlyContinue)) {
    Write-Warning "eza command not found. Please install eza before using these aliases."
    return
}

# Common parameters for EZA - stored as an array for proper parameter passing
$EzaCommonParams = @('--group-directories-last', '--icons=always', '--color=always')

# Basic file listing aliases
# -1: One entry per line
Function Get-EzaBasic { & eza @EzaCommonParams @args }

# -a: Show all files (including hidden)
Function Get-EzaAll { & eza -a @EzaCommonParams @args }

# -l: Long format with details, -a: All files
Function Get-EzaLong { & eza -la @EzaCommonParams @args }

# Long format with all files
Function Get-EzaLongAll { & eza -la @EzaCommonParams @args }

# Tree view with different levels
# -T: Tree view, -a: All files
Function Get-EzaTree
{
    param (
        [Parameter(Position = 0)]
        [int]$Level = 1,
        
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza -Ta @EzaCommonParams --level=$Level @Args
}

# Additional useful aliases
# Long format with git status
Function Get-EzaLongGit { & eza -a @EzaCommonParams --git --git-repos --sort=modified --reverse --color-scale-mode=gradient --color-scale=age @args }

# Sort by modification time (newest first)
Function Get-EzaModified { & eza -la @EzaCommonParams --sort=modified --reverse @args }

# Sort by file size (largest first)
Function Get-EzaSize { & eza -la @EzaCommonParams --sort=size --reverse @args }

# Directory navigation shortcuts
Function Set-LocationUp { Set-Location .. }
Function Set-LocationUp2 { Set-Location ..\.. }

# Tree View Aliases
Function Get-EzaTreeView
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --tree @EzaCommonParams @Args
}

Function Get-EzaTreeAll
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --tree --all @EzaCommonParams @Args
}

Function Get-EzaTreeView1 { & eza --tree --level=1 @EzaCommonParams @args }
Function Get-EzaTreeView2 { & eza --tree --level=2 @EzaCommonParams @args }
Function Get-EzaTreeView3 { & eza --tree --level=3 @EzaCommonParams @args }


Function Get-EzaTreeGit
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --tree --git @EzaCommonParams @Args
}

Function Get-EzaTreeDepth
{
    param (
        [Parameter(Position = 0)]
        [int]$Level = 2,
        
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --tree --level=$Level @EzaCommonParams @Args
}

# Special Purpose Aliases
Function Get-EzaDirectories
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --only-dirs @EzaCommonParams @Args
}

Function Get-EzaFiles
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --only-files @EzaCommonParams @Args
}

Function Get-EzaSortSize
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --sort=size @EzaCommonParams @Args
}

Function Get-EzaRecent
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --sort=modified --reverse @EzaCommonParams @Args
}

# Developer-Focused Aliases
Function Get-EzaGitIgnore
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --git --git-ignore @EzaCommonParams @Args
}

Function Get-EzaHeader
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --header @EzaCommonParams @Args
}

Function Get-EzaModifiedTime
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --modified --time-style=relative @EzaCommonParams @Args
}

# System Admin Aliases
Function Get-EzaNumeric
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --numeric --header @EzaCommonParams @Args
}

Function Get-EzaInode
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --inode --header @EzaCommonParams @Args
}

Function Get-EzaPermissions
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --octal-permissions @EzaCommonParams @Args
}

Function Get-EzaBlockSize
{
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )
    & eza --long --binary --blocksize @EzaCommonParams @Args
}

Function Show-Eza
{
    & Get-Command -Name *Eza*
}

# Function to display all EZA alias names
Function Get-EzaAliases
{
    # Get the content of the script file
    $scriptContent = Get-Content $PSScriptRoot\EZAliases.ps1
    
    # Find all lines containing Set-Alias
    $aliasLines = $scriptContent | Where-Object { $_ -match "Set-Alias" }
    
    # Extract the alias names
    $aliasNames = @()
    foreach ($line in $aliasLines)
    {
        if ($line -match '-Name\s+(\S+)')
        {
            $aliasNames += $Matches[1]
        }
    }
    
    # Display the alias names in two columns
    Write-Host "EZA Aliases:" -ForegroundColor Cyan
    $columnWidth = ($aliasNames | Measure-Object Length -Maximum).Maximum + 4
    for ($i = 0; $i -lt $aliasNames.Count; $i += 2)
    {
        $col1 = $aliasNames[$i].PadRight($columnWidth)
        $col2 = if ($i + 1 -lt $aliasNames.Count) { $aliasNames[$i + 1] } else { "" }
        Write-Host "  $col1$col2"
    }
    Write-Host "`nTotal aliases: $($aliasNames.Count)" -ForegroundColor Green
}

# Set aliases for the functions
# -Force: Override existing aliases
# -Option AllScope: Make aliases available in all scopes
Set-Alias -Name ls -Value Get-EzaBasic -Force -Option AllScope
Set-Alias -Name la -Value Get-EzaAll -Force -Option AllScope
Set-Alias -Name ll -Value Get-EzaLong -Force -Option AllScope
Set-Alias -Name lg -Value Get-EzaLongGit -Force -Option AllScope
Set-Alias -Name lsa -Value Get-EzaAll -Force -Option AllScope
Set-Alias -Name lst -Value Get-EzaTree -Force -Option AllScope
Set-Alias -Name lt -Value Get-EzaModified -Force -Option AllScope
Set-Alias -Name lsize -Value Get-EzaSize -Force -Option AllScope

# Directory navigation
Set-Alias -Name .. -Value Set-LocationUp -Force -Option AllScope
Set-Alias -Name ... -Value Set-LocationUp2 -Force -Option AllScope

# Tree view aliases
Set-Alias -Name ltv -Value Get-EzaTreeView -Force -Option AllScope
Set-Alias -Name lst -Value Get-EzaTreeView1 -Force -Option AllScope
Set-Alias -Name lst1 -Value Get-EzaTreeView1 -Force -Option AllScope
Set-Alias -Name lst2 -Value Get-EzaTreeView2 -Force -Option AllScope
Set-Alias -Name lst3 -Value Get-EzaTreeView3 -Force -Option AllScope
Set-Alias -Name lta -Value Get-EzaTreeAll -Force -Option AllScope
Set-Alias -Name ltg -Value Get-EzaTreeGit -Force -Option AllScope
Set-Alias -Name ltd -Value Get-EzaTreeDepth -Force -Option AllScope

# Special purpose aliases
Set-Alias -Name lld -Value Get-EzaDirectories -Force -Option AllScope
Set-Alias -Name llf -Value Get-EzaFiles -Force -Option AllScope
Set-Alias -Name lls -Value Get-EzaSortSize -Force -Option AllScope
Set-Alias -Name llr -Value Get-EzaRecent -Force -Option AllScope
Set-Alias -Name llgi -Value Get-EzaGitIgnore -Force -Option AllScope
Set-Alias -Name llh -Value Get-EzaHeader -Force -Option AllScope
Set-Alias -Name llm -Value Get-EzaModifiedTime -Force -Option AllScope
Set-Alias -Name lln -Value Get-EzaNumeric -Force -Option AllScope
Set-Alias -Name lli -Value Get-EzaInode -Force -Option AllScope
Set-Alias -Name llp -Value Get-EzaPermissions -Force -Option AllScope
Set-Alias -Name llb -Value Get-EzaBlockSize -Force -Option AllScope
