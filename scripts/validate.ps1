# Deterministic validation script for ai-agent-architecture-kit
$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$SkillsDir = Join-Path $Root ".agents\skills"
$AgentsMdPath = Join-Path $Root "AGENTS.md"
$ManifestMdPath = Join-Path $Root "MANIFEST.md"
$ReadmeMdPath = Join-Path $Root "README.md"

$errors = @()

Write-Host "Validating ai-agent-architecture-kit..." -ForegroundColor Cyan

# 1. Discover filesystem skills
$skillDirs = Get-ChildItem -Directory -Path $SkillsDir
Write-Host "Found $($skillDirs.Count) skills in $SkillsDir"

foreach ($dir in $skillDirs) {
    $skillFile = Join-Path $dir.FullName "SKILL.md"
    if (-not (Test-Path $skillFile)) {
        $errors += "Missing SKILL.md in $($dir.FullName)"
        continue
    }

    $rawContent = Get-Content -Path $skillFile -Raw
    if ($rawContent -notmatch "(?s)^---\r?\n(.*?)\r?\n---") {
        $errors += "Invalid or missing YAML frontmatter in $($skillFile)"
        continue
    }

    $frontmatter = $Matches[1]
    if ($frontmatter -notmatch "(?m)^name:\s*([^\r\n]+)") {
        $errors += "Missing 'name' in frontmatter of $($skillFile)"
    } else {
        $nameVal = $Matches[1].Trim()
        if ($nameVal -ne $dir.Name) {
            $errors += "Skill name mismatch in $($skillFile): expected '$($dir.Name)', got '$nameVal'"
        }
    }

    if ($frontmatter -notmatch "(?m)^description:\s*([^\r\n]+)") {
        $errors += "Missing 'description' in frontmatter of $($skillFile)"
    }
}

# 2. Check synchronization with AGENTS.md, MANIFEST.md, and README.md
$agentsContent = Get-Content -Path $AgentsMdPath -Raw
$manifestContent = Get-Content -Path $ManifestMdPath -Raw
$readmeContent = Get-Content -Path $ReadmeMdPath -Raw

$tick = [char]96

foreach ($dir in $skillDirs) {
    $skillName = $dir.Name

    $skillInTicks = "$tick$skillName$tick"
    if (-not $agentsContent.Contains($skillInTicks)) {
        $errors += "Skill '$skillName' ($skillInTicks) is missing from AGENTS.md"
    }

    $manifestEntry = "- $skillInTicks"
    if (-not $manifestContent.Contains($manifestEntry)) {
        $errors += "Skill '$skillName' ($manifestEntry) is missing from MANIFEST.md"
    }

    $readmeEntry = "$skillName/SKILL.md"
    if (-not $readmeContent.Contains($readmeEntry)) {
        $errors += "Skill '$skillName' ($readmeEntry) is missing from README.md"
    }
}

# 3. Check templates
$templates = @(
    "templates\backend\AGENTS.md",
    "templates\backend\ARCHITECTURE.md",
    "templates\frontend\AGENTS.md",
    "templates\frontend\ARCHITECTURE.md"
)

foreach ($tmpl in $templates) {
    $tmplPath = Join-Path $Root $tmpl
    if (-not (Test-Path $tmplPath)) {
        $errors += "Missing template file: $tmpl"
    } elseif ((Get-Item $tmplPath).Length -eq 0) {
        $errors += "Empty template file: $tmpl"
    }
}

if ($errors.Count -gt 0) {
    Write-Host "`nValidation failed with $($errors.Count) errors:" -ForegroundColor Red
    foreach ($err in $errors) {
        Write-Host "  - $err" -ForegroundColor Red
    }
    exit 1
}

Write-Host "All skills, templates, and documentation cross-references verified successfully!" -ForegroundColor Green
exit 0
