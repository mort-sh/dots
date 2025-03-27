# $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
# $ErrorActionPreference = 'SilentlyContinue'
$InformationPreference = 'SilentlyContinue'

# Initialize Oh-My-Posh with specified theme
# oh-my-posh init pwsh --config 'C:\Users\Atlas\AppData\Local\Programs\oh-my-posh\themes\personal-single-long.json' | Invoke-Expression


$ENV:EZA_CONFIG_DIR = "$env:USERPROFILE\Documents\PowerShell\themes\eza\theme.yml"
$ENV:STARSHIP_CONFIG = "$env:USERPROFILE\Documents\PowerShell\themes\starship\starship.toml"
$env:Path += ";C:\Users\Atlas\Documents\PowerShell\bin;C:\Users\Atlas\AppData\Local\Microsoft\WinGet\Links"
Invoke-Expression (& 'C:\Program Files\starship\bin\starship.exe' init powershell --print-full-init | Out-String)


# Import necessary modules
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Import-Module -Name Terminal-Icons
Import-Module PSReadLine
# Import-Module eza

# Import CommandNotFound Module
Import-Module -Name Microsoft.WinGet.CommandNotFound

# Enable PowerType if not already enabled
try {
    Enable-PowerType -ErrorAction Stop
} catch [System.InvalidOperationException] {
    # PowerType is already enabled, silently continue
}

# Configure PSReadLine options
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -MaximumHistoryCount 2000
Set-PSReadLineOption -CompletionQueryItems 30
Set-PSReadLineOption -ExtraPromptLineCount 20
Set-PSReadLineOption -BellStyle Visual
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -ViModeIndicator Cursor

Set-PSReadLineKeyHandler -Key UpArrow -Function PreviousHistory
Set-PSReadLineKeyHandler -Key DownArrow -Function NextHistory


$env:EDITOR = 'subl -w'




Function act
{
    .\.venv\Scripts\activate
}

# Color Display Function
Function colors
{
    $colorMap = @{
        0  = 'Black'
        1  = 'DarkRed'
        2  = 'DarkGreen'
        3  = 'DarkYellow'
        4  = 'DarkBlue'
        5  = 'DarkMagenta'
        6  = 'DarkCyan'
        7  = 'Gray'
        8  = 'DarkGray'
        9  = 'Red'
        10 = 'Green'
        11 = 'Yellow'
        12 = 'Blue'
        13 = 'Magenta'
        14 = 'Cyan'
        15 = 'White'
    }

    foreach ($i in $colorMap.Keys)
    {
        $colorName = $colorMap[$i]
        Write-Host ('{0,2} - {1}' -f $i, $colorName) -ForegroundColor $colorName
    }
}

Function which 
{
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Command
    )
    
    Get-Command $Command | Select-Object -ExpandProperty Source
}

# Remove Function
Function rm
{
    param ([string]$path = '')
    Remove-Item -Recurse -Force $path
}



if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\scripts\Functions.Aider.ps1") {
    . "$env:USERPROFILE\Documents\PowerShell\scripts\Functions.Aider.ps1"
}

if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\scripts\Shortcuts.ps1") {
    . "$env:USERPROFILE\Documents\PowerShell\scripts\Shortcuts.ps1"
}

if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\scripts\EZAliases.ps1") {
    . "$env:USERPROFILE\Documents\PowerShell\scripts\EZAliases.ps1"
}

# Load Completion Scripts
if (Test-Path -Path "$env:USERPROFILE\Documents\PowerShell\scripts\Completions.Starship.ps1") {
    . "$env:USERPROFILE\Documents\PowerShell\scripts\Completions.Starship.ps1"
}


# Load environment variables from .env file
try {
    . loadENV.ps1
}
catch {}
Function shell { Set-Location 'C:\Users\Atlas\Documents\PowerShell' }
