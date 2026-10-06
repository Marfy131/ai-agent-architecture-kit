[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$TargetDir = $PWD,

    [switch]$Symlink,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$SourceDir = $PSScriptRoot
$TargetDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($TargetDir)

$targetAgentsDir = Join-Path $TargetDir ".agents"
$targetSkillsDir = Join-Path $targetAgentsDir "skills"
$sourceSkillsDir = Join-Path $SourceDir ".agents\skills"
$sourceAgentsMd  = Join-Path $SourceDir "AGENTS.md"
$targetAgentsMd  = Join-Path $TargetDir "AGENTS.md"

if (-not (Test-Path $targetAgentsDir)) {
    New-Item -ItemType Directory -Path $targetAgentsDir -Force | Out-Null
}

if ($Symlink) {
    if (Test-Path $targetSkillsDir) {
        Remove-Item -Path $targetSkillsDir -Recurse -Force
    }
    # Create Junction on Windows for directory without requiring Developer Mode admin rights
    New-Item -ItemType Junction -Path $targetSkillsDir -Target $sourceSkillsDir | Out-Null
    Write-Host "Linked skills: $targetSkillsDir -> $sourceSkillsDir"
} else {
    if (-not (Test-Path $targetSkillsDir)) {
        New-Item -ItemType Directory -Path $targetSkillsDir -Force | Out-Null
    }
    Copy-Item -Path "$sourceSkillsDir\*" -Destination $targetSkillsDir -Recurse -Force
    Write-Host "Copied portable skills under $targetSkillsDir"
}

if ((Test-Path $targetAgentsMd) -and (-not $Force)) {
    Write-Host "Kept existing $targetAgentsMd"
    Write-Host "Merge the non-negotiable rules from $sourceAgentsMd manually (or use -Force to overwrite)."
} else {
    Copy-Item -Path $sourceAgentsMd -Destination $targetAgentsMd -Force
    Write-Host "Installed AGENTS.md in $TargetDir"
}

Write-Host "Installation complete."
Write-Host "See $(Join-Path $SourceDir 'README.md') for Dirac, OpenCode, Oh My Pi, Antigravity, and scoped AGENTS.md setup."
