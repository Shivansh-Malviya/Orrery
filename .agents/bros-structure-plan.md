> **Historical note:** This is the BROS directory manifest + hardened
> execution prompt v2, migrated from `F:\BROS_SYSTEM\.agents\bros-structure-plan.md`
> on 2026-06-07. It is the canonical plan that built `F:\BROS_SYSTEM\`.
> It is preserved here as a **historical reference** for the structure
> plan that produced the BROS tree. It is NOT the current Orrery structure
> plan. For the current Orrery structure, see
> `F:\Orrery\system\manifest\structure\current.manifest.md` and
> `F:\Orrery\AGENTS.md`.
>
> Note: the execution prompt in this file targets `F:\BROS_SYSTEM\` as
> the build root. It should NOT be executed against `F:\Orrery\` directly
> — the Orrery tree is a different surface with different naming and
> different rules.

# BROS Directory Manifest + Hardened Execution Prompt (v2)

This version fixes the brittle points from the prior draft:

- idempotent create operations
- deterministic controller and hook file naming
- guaranteed parent directory creation (including `lib/`)
- symlink creation with junction fallback
- explicit verification gates

## 1) Final Manifest (Dir Tree)

```text
F:\BROS_SYSTEM\
├── AGENTS.md
├── README.md
├── .gitignore
├── .safe\
├── .obsidian\
├── .agents\
│   ├── AGENTS.md
│   ├── MANIFEST.md
│   ├── rules\
│   │   ├── workspace-doctrine.md
│   │   ├── commit-contract.md
│   │   ├── verification-gates.md
│   │   ├── enforcer-hooks.py
│   │   └── commit-hook.py
│   ├── skills\
│   ├── workflows\
│   └── vscode\
│       ├── copilot-instructions.md
│       └── hooks\
├── SECOND_BRAIN\
│   ├── AGENTS.md
│   ├── raw\assets\
│   ├── wiki\
│   │   ├── sources\
│   │   ├── entities\
│   │   ├── concepts\
│   │   ├── synthesis\
│   │   ├── index.md
│   │   └── log.md
│   └── output\
├── governance\
│   ├── policy\
│   │   ├── workspace-doctrine.md
│   │   ├── commit-contract.md
│   │   ├── verification-gates.md
│   │   ├── execution-controls.md
│   │   ├── planning-contract.md
│   │   ├── context-checkpoints.md
│   │   ├── session-handoff.md
│   │   ├── OUTPUT_PATH_POLICY.md
│   │   ├── README.md
│   │   ├── decisions\
│   │   ├── gates\
│   │   └── registry\
│   ├── enforcer\
│   │   ├── orchestrator\Enforcer.ps1
│   │   └── controllers\
│   │       ├── brain-dump\ (2)
│   │       ├── consistency\ (5)
│   │       ├── file-integrity\ (3)
│   │       ├── lifecycle\ (4)
│   │       ├── registry\ (5)
│   │       ├── semantic\ (4)
│   │       ├── sentinel\ (3)
│   │       └── workflow\ (4)
│   ├── hooks\
│   │   ├── pre-commit\ (6)
│   │   ├── triggers\ (7)
│   │   ├── scheduled\ (3)
│   │   ├── install\ (2)
│   │   └── state\file-locks.json
│   ├── scheduler\
│   │   ├── dispatcher.ps1
│   │   └── skill-registry.yaml
│   ├── learner\requirements.txt
│   ├── start\
│   │   ├── profile-loader.ps1
│   │   ├── log-rotation.ps1
│   │   └── adapters\
│   ├── context\brain_dump.md
│   ├── state\
│   │   ├── backlog.md
│   │   ├── todo.md
│   │   ├── ideas_tracker.md
│   │   ├── feedback_log.md
│   │   ├── failure_log.md
│   │   ├── coherence_log.md
│   │   ├── enforcer_health.md
│   │   ├── enforcer_orchestration_log.md
│   │   └── metrics.yaml
│   └── admission\
├── workspace\
│   ├── personal\
│   │   ├── projects\
│   │   │   ├── dashboard\
│   │   │   ├── quant-wealth\
│   │   │   ├── life-calendar\
│   │   │   ├── portfolio\bu1ld-recreation\
│   │   │   └── en-dash\
│   │   ├── health\
│   │   ├── documents\imp\
│   │   ├── documents\scans\
│   │   ├── misc\apocalypse-survival\
│   │   ├── misc\misfit\
│   │   └── profile.md
│   ├── career\
│   │   ├── _acos\
│   │   ├── projects\planck25\
│   │   ├── learning\
│   │   ├── study-notes\gate-physics\
│   │   ├── study-notes\cdse-pyqs\
│   │   ├── exams\
│   │   ├── pet-projects\
│   │   └── archive\
│   ├── ina\
│   │   ├── admin\
│   │   │   ├── daily-logs\
│   │   │   ├── finances\
│   │   │   ├── logos\
│   │   │   ├── third-ray\
│   │   │   ├── timesheets\
│   │   │   └── positions\
│   │   └── projects\
│   │       ├── annealing\
│   │       ├── cybersec\
│   │       ├── power-grid\
│   │       ├── pqc\
│   │       ├── q2dm\ (link/junction -> ..\..\academic\projects\q2dm)
│   │       ├── qbit\
│   │       ├── qml-fraud\
│   │       ├── quantum-materials\
│   │       ├── quantum-education\
│   │       ├── quantum-workforce\
│   │       ├── qb-batches\
│   │       └── vqe\
│   └── academic\
│       ├── projects\q2dm\
│       │   ├── ModelA\
│       │   ├── ModelB\
│       │   ├── ModelC\
│       │   ├── references\
│       │   ├── docs\
│       │   └── rebuild-plan\
│       ├── iiser-pune\
│       ├── books\physics\
│       ├── books\chemistry\
│       ├── books\maths\
│       ├── certificates\
│       └── school-projects\
├── inbox\
│   ├── new\
│   ├── docs\scienceclaw\
│   ├── code\q2dm-final\
│   ├── misc\proxima\
│   ├── exports\
│   │   ├── second-brain.SKILL.md
│   │   ├── second-brain-ingest.SKILL.md
│   │   ├── second-brain-query.SKILL.md
│   │   ├── second-brain-lint.SKILL.md
│   │   ├── wiki\
│   │   │   ├── sources\
│   │   │   ├── entities\
│   │   │   ├── concepts\
│   │   │   ├── synthesis\
│   │   │   ├── index.md
│   │   │   └── log.md
│   │   └── output\
│   ├── attachments\
│   └── archive\
├── ref\papers\system-architecture\
├── ref\prompts\
├── tools\scripts\
├── tools\templates\
├── tools\mcp\
├── vaults\dendron\
├── data\raw\
├── archive\
├── etc\
├── lib\
│   ├── butler-helpers.ps1
│   └── path-resolver.ps1
└── .github\hooks\
```

## 2) Execution Prompt (for another agent)

Send this prompt and script to the executing agent.

```text
Task: Build the BROS structure under F:\BROS_SYSTEM exactly as defined in the manifest.

Constraints:
- NEVER touch F:\BUTLER_ROOT.
- This script must only create AGENTS.md in: root, .agents, SECOND_BRAIN.
- No 00-bros- prefixes in rule filenames.
- Keep portfolio\bu1ld-recreation nested.
- Do not create publications/.
- Keep prompts under ref\prompts.
- Do not create inbox\exports\raw.
- Make workspace\ina\projects\q2dm a link/junction to workspace\academic\projects\q2dm.

After running the script, return:
1) summary of created paths/files
2) verification output
3) whether symbolic link or junction fallback was used
```

```powershell
$ErrorActionPreference = 'Stop'
$Root = 'F:\BROS_SYSTEM'
$DryRun = $false  # set to $true for preview mode

if (-not (Test-Path -LiteralPath $Root)) {
  throw "Root path does not exist: $Root"
}

$ActionLog = [System.Collections.Generic.List[string]]::new()

function Invoke-Step([string]$Message, [scriptblock]$Action) {
  $ActionLog.Add($Message) | Out-Null
  if ($DryRun) {
    Write-Host "[DRY-RUN] $Message"
    return
  }
  & $Action
}

function Ensure-Dir([string]$Path) {
  if (Test-Path -LiteralPath $Path) { return }
  Invoke-Step -Message "Create directory: $Path" -Action {
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
  }
}

function Ensure-Dirs([string[]]$Paths) {
  foreach ($p in $Paths) { Ensure-Dir $p }
}

function Ensure-File([string]$Path, [string]$Content = '# stub') {
  $parent = Split-Path -Parent $Path
  if ($parent) { Ensure-Dir $parent }
  if (-not (Test-Path -LiteralPath $Path)) {
    Invoke-Step -Message "Create file: $Path" -Action {
      Set-Content -Path $Path -Value $Content -Encoding UTF8 -Force
    }
  }
}

function Ensure-Files([hashtable]$Map) {
  foreach ($entry in $Map.GetEnumerator()) {
    Ensure-File -Path $entry.Key -Content $entry.Value
  }
}

function Ensure-LinkOrJunction([string]$LinkPath, [string]$TargetPath) {
  Ensure-Dir (Split-Path -Parent $LinkPath)
  Ensure-Dir $TargetPath

  if (Test-Path -LiteralPath $LinkPath) {
    $existing = Get-Item -LiteralPath $LinkPath -Force
    if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) { return 'existing' }
    throw "Path exists and is not a link/junction: $LinkPath"
  }

  try {
    if ($DryRun) { return 'dry-run-symbolic-link' }
    New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath -ErrorAction Stop | Out-Null
    return 'symbolic-link'
  } catch {
    if ($DryRun) { return 'dry-run-junction' }
    New-Item -ItemType Junction -Path $LinkPath -Target $TargetPath -ErrorAction Stop | Out-Null
    return 'junction'
  }
}

# Chunk 1: directory groups
$coreDirs = @(
  "$Root\.safe",
  "$Root\.obsidian",
  "$Root\archive",
  "$Root\etc",
  "$Root\lib",
  "$Root\.github\hooks",
  "$Root\ref\papers\system-architecture",
  "$Root\ref\prompts",
  "$Root\tools\scripts",
  "$Root\tools\templates",
  "$Root\tools\mcp",
  "$Root\vaults\dendron",
  "$Root\data\raw"
)

$agentDirs = @(
  "$Root\.agents\rules",
  "$Root\.agents\skills",
  "$Root\.agents\workflows",
  "$Root\.agents\vscode\hooks",
  "$Root\SECOND_BRAIN\raw\assets",
  "$Root\SECOND_BRAIN\wiki\sources",
  "$Root\SECOND_BRAIN\wiki\entities",
  "$Root\SECOND_BRAIN\wiki\concepts",
  "$Root\SECOND_BRAIN\wiki\synthesis",
  "$Root\SECOND_BRAIN\output"
)

$governanceDirs = @(
  "$Root\governance\policy\decisions",
  "$Root\governance\policy\gates",
  "$Root\governance\policy\registry",
  "$Root\governance\enforcer\orchestrator",
  "$Root\governance\hooks\pre-commit",
  "$Root\governance\hooks\triggers",
  "$Root\governance\hooks\scheduled",
  "$Root\governance\hooks\install",
  "$Root\governance\hooks\state",
  "$Root\governance\scheduler",
  "$Root\governance\learner",
  "$Root\governance\start\adapters",
  "$Root\governance\context",
  "$Root\governance\state",
  "$Root\governance\admission"
)

$workspaceDirs = @(
  "$Root\workspace\personal\projects\dashboard",
  "$Root\workspace\personal\projects\quant-wealth",
  "$Root\workspace\personal\projects\life-calendar",
  "$Root\workspace\personal\projects\portfolio\bu1ld-recreation",
  "$Root\workspace\personal\projects\en-dash",
  "$Root\workspace\personal\health",
  "$Root\workspace\personal\documents\imp",
  "$Root\workspace\personal\documents\scans",
  "$Root\workspace\personal\misc\apocalypse-survival",
  "$Root\workspace\personal\misc\misfit",
  "$Root\workspace\career\_acos",
  "$Root\workspace\career\projects\planck25",
  "$Root\workspace\career\learning",
  "$Root\workspace\career\study-notes\gate-physics",
  "$Root\workspace\career\study-notes\cdse-pyqs",
  "$Root\workspace\career\exams",
  "$Root\workspace\career\pet-projects",
  "$Root\workspace\career\archive",
  "$Root\workspace\ina\admin\daily-logs",
  "$Root\workspace\ina\admin\finances",
  "$Root\workspace\ina\admin\logos",
  "$Root\workspace\ina\admin\third-ray",
  "$Root\workspace\ina\admin\timesheets",
  "$Root\workspace\ina\admin\positions",
  "$Root\workspace\ina\projects\annealing",
  "$Root\workspace\ina\projects\cybersec",
  "$Root\workspace\ina\projects\power-grid",
  "$Root\workspace\ina\projects\pqc",
  "$Root\workspace\ina\projects\qbit",
  "$Root\workspace\ina\projects\qml-fraud",
  "$Root\workspace\ina\projects\quantum-materials",
  "$Root\workspace\ina\projects\quantum-education",
  "$Root\workspace\ina\projects\quantum-workforce",
  "$Root\workspace\ina\projects\qb-batches",
  "$Root\workspace\ina\projects\vqe",
  "$Root\workspace\academic\projects\q2dm\ModelA",
  "$Root\workspace\academic\projects\q2dm\ModelB",
  "$Root\workspace\academic\projects\q2dm\ModelC",
  "$Root\workspace\academic\projects\q2dm\references",
  "$Root\workspace\academic\projects\q2dm\docs",
  "$Root\workspace\academic\projects\q2dm\rebuild-plan",
  "$Root\workspace\academic\iiser-pune",
  "$Root\workspace\academic\books\physics",
  "$Root\workspace\academic\books\chemistry",
  "$Root\workspace\academic\books\maths",
  "$Root\workspace\academic\certificates",
  "$Root\workspace\academic\school-projects"
)

$inboxDirs = @(
  "$Root\inbox\new",
  "$Root\inbox\docs\scienceclaw",
  "$Root\inbox\code\q2dm-final",
  "$Root\inbox\misc\proxima",
  "$Root\inbox\exports\wiki\sources",
  "$Root\inbox\exports\wiki\entities",
  "$Root\inbox\exports\wiki\concepts",
  "$Root\inbox\exports\wiki\synthesis",
  "$Root\inbox\exports\output",
  "$Root\inbox\attachments",
  "$Root\inbox\archive"
)

Ensure-Dirs $coreDirs
Ensure-Dirs $agentDirs
Ensure-Dirs $governanceDirs
Ensure-Dirs $workspaceDirs
Ensure-Dirs $inboxDirs

# Chunk 2: required files
$rootFiles = @{
  "$Root\AGENTS.md" = "# BROS Workspace"
  "$Root\README.md" = "# BROS"
  "$Root\.gitignore" = "node_modules/`n.env"
}

$agentFiles = @{
  "$Root\.agents\AGENTS.md" = "# Agent Resource Index"
  "$Root\.agents\MANIFEST.md" = "# Manifest`n`nReference only"
  "$Root\.agents\rules\workspace-doctrine.md" = "# workspace-doctrine"
  "$Root\.agents\rules\commit-contract.md" = "# commit-contract"
  "$Root\.agents\rules\verification-gates.md" = "# verification-gates"
  "$Root\.agents\rules\enforcer-hooks.py" = "# stub"
  "$Root\.agents\rules\commit-hook.py" = "# stub"
  "$Root\.agents\vscode\copilot-instructions.md" = "# Copilot Instructions"
  "$Root\SECOND_BRAIN\AGENTS.md" = "# Second Brain - Librarian Instructions"
  "$Root\SECOND_BRAIN\wiki\index.md" = "# Wiki Index"
  "$Root\SECOND_BRAIN\wiki\log.md" = "# Chronology"
}

$governanceFiles = @{
  "$Root\governance\enforcer\orchestrator\Enforcer.ps1" = "# stub"
  "$Root\governance\hooks\state\file-locks.json" = "{}"
  "$Root\governance\scheduler\dispatcher.ps1" = "# stub"
  "$Root\governance\scheduler\skill-registry.yaml" = "# empty"
  "$Root\governance\learner\requirements.txt" = "# stub"
  "$Root\governance\start\profile-loader.ps1" = "# stub"
  "$Root\governance\start\log-rotation.ps1" = "# stub"
  "$Root\governance\context\brain_dump.md" = "# Brain Dump"
  "$Root\governance\policy\workspace-doctrine.md" = "# workspace-doctrine"
  "$Root\governance\policy\commit-contract.md" = "# commit-contract"
  "$Root\governance\policy\verification-gates.md" = "# verification-gates"
  "$Root\governance\policy\execution-controls.md" = "# execution-controls"
  "$Root\governance\policy\planning-contract.md" = "# planning-contract"
  "$Root\governance\policy\context-checkpoints.md" = "# context-checkpoints"
  "$Root\governance\policy\session-handoff.md" = "# session-handoff"
  "$Root\governance\policy\OUTPUT_PATH_POLICY.md" = "# OUTPUT_PATH_POLICY"
  "$Root\governance\policy\README.md" = "# Policy README"
  "$Root\governance\state\backlog.md" = "# backlog"
  "$Root\governance\state\todo.md" = "# todo"
  "$Root\governance\state\ideas_tracker.md" = "# ideas_tracker"
  "$Root\governance\state\feedback_log.md" = "# feedback_log"
  "$Root\governance\state\failure_log.md" = "# failure_log"
  "$Root\governance\state\coherence_log.md" = "# coherence_log"
  "$Root\governance\state\enforcer_health.md" = "# enforcer_health"
  "$Root\governance\state\enforcer_orchestration_log.md" = "# enforcer_orchestration_log"
  "$Root\governance\state\metrics.yaml" = "# empty"
}

$workspaceFiles = @{
  "$Root\workspace\personal\profile.md" = "# profile"
}

$inboxFiles = @{
  "$Root\inbox\exports\second-brain.SKILL.md" = "# second-brain"
  "$Root\inbox\exports\second-brain-ingest.SKILL.md" = "# second-brain-ingest"
  "$Root\inbox\exports\second-brain-query.SKILL.md" = "# second-brain-query"
  "$Root\inbox\exports\second-brain-lint.SKILL.md" = "# second-brain-lint"
  "$Root\inbox\exports\wiki\index.md" = "# Exports Wiki Index"
  "$Root\inbox\exports\wiki\log.md" = "# Exports Log"
}

$supportFiles = @{
  "$Root\lib\butler-helpers.ps1" = "# stub"
  "$Root\lib\path-resolver.ps1" = "# stub"
}

Ensure-Files $rootFiles
Ensure-Files $agentFiles
Ensure-Files $governanceFiles
Ensure-Files $workspaceFiles
Ensure-Files $inboxFiles
Ensure-Files $supportFiles

# Chunk 3: generated stubs
$controllerCounts = [ordered]@{
  'brain-dump'     = 2
  'consistency'    = 5
  'file-integrity' = 3
  'lifecycle'      = 4
  'registry'       = 5
  'semantic'       = 4
  'sentinel'       = 3
  'workflow'       = 4
}

$expectedControllers = @()
foreach ($domain in $controllerCounts.Keys) {
  $domainDir = "$Root\governance\enforcer\controllers\$domain"
  Ensure-Dir $domainDir
  for ($i = 1; $i -le $controllerCounts[$domain]; $i++) {
    $name = "controller-$domain-$('{0:D2}' -f $i).ps1"
    $full = Join-Path $domainDir $name
    Ensure-File -Path $full -Content "# stub"
    $expectedControllers += $full
  }
}

$hookCounts = [ordered]@{
  'pre-commit' = 6
  'triggers'   = 7
  'scheduled'  = 3
  'install'    = 2
}

foreach ($bucket in $hookCounts.Keys) {
  $bucketDir = "$Root\governance\hooks\$bucket"
  Ensure-Dir $bucketDir
  for ($i = 1; $i -le $hookCounts[$bucket]; $i++) {
    $name = "hook-$bucket-$('{0:D2}' -f $i).ps1"
    Ensure-File -Path (Join-Path $bucketDir $name) -Content "# stub"
  }
}

# Chunk 4: q2dm mirror
$linkMode = Ensure-LinkOrJunction -LinkPath "$Root\workspace\ina\projects\q2dm" -TargetPath "$Root\workspace\academic\projects\q2dm"

if ($DryRun) {
  Write-Host "DRY-RUN complete. No filesystem changes were written." -ForegroundColor Yellow
  Write-Host "Planned actions: $($ActionLog.Count)"
  return
}

# Verification gates
$agents = Get-ChildItem -Path $Root -Recurse -Filter AGENTS.md -File
$agentPaths = $agents | ForEach-Object { [System.IO.Path]::GetFullPath($_.FullName) }
$requiredAgentPaths = @(
  [System.IO.Path]::GetFullPath("$Root\AGENTS.md"),
  [System.IO.Path]::GetFullPath("$Root\.agents\AGENTS.md"),
  [System.IO.Path]::GetFullPath("$Root\SECOND_BRAIN\AGENTS.md")
)
$missingRequiredAgents = $requiredAgentPaths | Where-Object { $_ -notin $agentPaths }
if ($missingRequiredAgents.Count -gt 0) {
  throw "Missing required AGENTS.md files: $($missingRequiredAgents -join ', ')"
}
$extraAgents = $agentPaths | Where-Object { $_ -notin $requiredAgentPaths }
if ($extraAgents.Count -gt 0) {
  Write-Host "INFO: Found $($extraAgents.Count) pre-existing AGENTS.md files outside required set." -ForegroundColor Yellow
}

if (Test-Path "$Root\inbox\exports\raw") {
  throw "Invalid path exists: $Root\inbox\exports\raw"
}

$missingControllers = $expectedControllers | Where-Object { -not (Test-Path -LiteralPath $_) }
if ($missingControllers.Count -gt 0) {
  throw "Missing controller files: $($missingControllers -join ', ')"
}

$generatedControllerTotal = (Get-ChildItem "$Root\governance\enforcer\controllers" -Recurse -Filter 'controller-*-*.ps1' -File).Count
if ($generatedControllerTotal -ne 30) { throw "Expected 30 generated controllers, found $generatedControllerTotal" }

foreach ($f in @("$Root\lib\butler-helpers.ps1", "$Root\lib\path-resolver.ps1")) {
  if (-not (Test-Path -LiteralPath $f)) { throw "Missing file: $f" }
}

$mirror = Get-Item -LiteralPath "$Root\workspace\ina\projects\q2dm" -Force
if (-not ($mirror.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
  throw "q2dm mirror is not a link/junction"
}

Write-Host "SUCCESS: scaffold created and verified. link-mode=$linkMode" -ForegroundColor Green
```

## 3) Quick Reviewer Checklist

- required `AGENTS.md` files exist at root, `.agents`, and `SECOND_BRAIN`
- no `inbox\exports\raw\` path exists
- `workspace\personal\projects\portfolio\bu1ld-recreation\` exists
- `workspace\career\exams\` exists
- `workspace\ina\projects\q2dm` is a reparse point
- `governance\enforcer\controllers` has exactly 30 `.ps1` files
