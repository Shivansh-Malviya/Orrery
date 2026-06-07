> **Historical note:** This is the BROS Butler Root → BROS migration
> manifest, migrated from `F:\BROS_SYSTEM\.agents\MANIFEST.md` on 2026-06-07.
> It is preserved here as a **historical reference** for the original
> Butler Root → BROS migration. It is NOT a current map of the Orrery
> workspace. For the current Orrery structure, see
> `F:\Orrery\system\manifest\structure\current.manifest.md` and
> `F:\Orrery\AGENTS.md`.

# BROS Workspace Manifest

Canonical mapping from Butler Root (`F:\BUTLER_ROOT`) to BROS (`F:\BROS_SYSTEM`).
This is a **reference manifest** — no migration scripts, manual migration only.

Category key:
- **Code** = standalone project with own repo/tests/build
- **Docs** = reference documents, not code
- **Life** = personal records, health, finance
- **Admin** = administrative records (timesheets, finances, contracts)
- **Archive** = historical, no longer actively used

---

## `01_PERSONAL/` → `workspace/personal/`

| Butler Root path | Type | BROS destination | Notes |
|---|---|---|---|
| `01_PERSONAL/AI_Prompts/` | Docs | `workspace/personal/ai-prompts/` | Prompt libraries and templates |
| `01_PERSONAL/Apocalypse_Survival/` | Docs | `workspace/personal/life/apocalypse-survival/` | Interest/notes |
| `01_PERSONAL/bu1ld_recreation/` | Code | `projects/bu1ld-recreation/` | Appears to be a tool/project |
| `01_PERSONAL/Documents/IMP/` | Docs | `workspace/personal/documents/imp/` | Legal certificates, marksheets |
| `01_PERSONAL/Documents/Imp_Scans/` | Docs | `workspace/personal/documents/scans/` | Scanned documents |
| `01_PERSONAL/En_Dash/` | Code | `projects/en-dash/` | Appears to be a project |
| `01_PERSONAL/Health/` | Life | `workspace/personal/health/` | Health records |
| `01_PERSONAL/Life Calendar/` | Life | `workspace/personal/life/calendar/` | Life calendar tool |
| `01_PERSONAL/Misc/` | Misc | `inbox/processing/` | Needs triage — contains C-Camp Hackathon |
| `01_PERSONAL/Misfit/` | Misc | `workspace/personal/life/misfit/` | Unclear purpose, keep as-is |
| `01_PERSONAL/Personal_Dashboard/` | Code | `projects/personal-dashboard/` | Next.js app (src, node_modules, .next) |
| `01_PERSONAL/planck25_project/` | Code | `projects/planck25/` | C/embedded research (firmware, verification, paper) |
| `01_PERSONAL/Publications/` | Docs | `workspace/personal/publications/` | System Architecture Paper |
| `01_PERSONAL/Quant_Wealth_Model/` | Code | `projects/quant-wealth-model/` | Python project (src, tests, docs) |
| `01_PERSONAL/user_profile.md` | Life | `workspace/personal/profile.md` | Personal profile doc |

---

## `02_INA/` → `workspace/ina/`

| Butler Root path | Type | BROS destination | Notes |
|---|---|---|---|
| `02_INA/Admin/Daily_Logs/` | Admin | `workspace/ina/admin/daily-logs/` | Daily activity logs |
| `02_INA/Admin/Finances/` | Admin | `workspace/ina/admin/finances/` | Financial records |
| `02_INA/Admin/Logos/` | Admin | `workspace/ina/admin/logos/` | Brand assets |
| `02_INA/Admin/Third Ray/` | Admin | `workspace/ina/admin/third-ray/` | Consulting records |
| `02_INA/Admin/Timesheets/` | Admin | `workspace/ina/admin/timesheets/` | Time tracking |
| `02_INA/Projects/Annealing/` | Code | `workspace/ina/projects/annealing/` | Quantum annealing |
| `02_INA/Projects/CyberSec/` | Code | `workspace/ina/projects/cybersec/` | Cybersecurity research |
| `02_INA/Projects/Others/VQE/` | Code | `workspace/ina/projects/vqe/` | Variational Quantum Eigensolver |
| `02_INA/Projects/Position_Descriptions/` | Docs | `workspace/ina/admin/positions/` | Job descriptions |
| `02_INA/Projects/Power_Grid/` | Code | `workspace/ina/projects/power-grid/` | Power grid research |
| `02_INA/Projects/PQC/` | Code | `workspace/ina/projects/pqc/` | Post-Quantum Cryptography |
| `02_INA/Projects/Q2DM/` | Code | `workspace/ina/projects/q2dm/` | Cross-referenced from academic — see academic/q2dm |
| `02_INA/Projects/qb_batches/` | Code | `workspace/ina/projects/qb-batches/` | Quantum batches |
| `02_INA/Projects/QML-Fraud-Detection/` | Code | `workspace/ina/projects/qml-fraud/` | QML fraud detection |
| `02_INA/Projects/Quantum_Buzz/` | Code | `workspace/ina/projects/quantum-buzz/` | Quantum news monitoring |
| `02_INA/Projects/Quantum_Computation_on_Materials/` | Code | `workspace/ina/projects/quantum-materials/` | Materials computation |
| `02_INA/Projects/Quantum_Education_Review/` | Code | `workspace/ina/projects/quantum-education/` | Education review |
| `02_INA/Projects/Quantum_Workforce/` | Code | `workspace/ina/projects/quantum-workforce/` | Workforce analysis |
| `02_INA/README.md` | Docs | `workspace/ina/README.md` | Domain overview |

---

## `03_CAREER/` → `workspace/career/`

| Butler Root path | Type | BROS destination | Notes |
|---|---|---|---|
| `03_CAREER/_application_campaign_os/` | Code | `workspace/career/application-campaign/` | Agent-managed campaign system (has own .agents/) |
| `03_CAREER/ARCHIVE/` | Archive | `workspace/career/archive/` | CV snapshots, study materials, legacy CVs |
| `03_CAREER/CV/` | Docs | `workspace/career/cv/` | Current CV + external analyses |
| `03_CAREER/Exams/` | Archive | `workspace/career/exams/` | AFCAT, CAT, GATE, JEE, NET — mostly 2019–2024 |
| `03_CAREER/Internships-Courses/` | Docs | `workspace/career/learning/` | Coursera, Qiskit, Womanium, ISRO, Kaggle |
| `03_CAREER/Interviews/` | Docs | `workspace/career/interviews/` | QClairvoyance, UElement |
| `03_CAREER/Pet_Projects/` | Code | `projects/pet-projects/` or `workspace/career/pet-projects/` | Side projects |
| `03_CAREER/PhD_Search/` | Docs | `workspace/career/phd-search/` | Research proposals, materials, tracker |
| `03_CAREER/Portfolio/` | Code | `projects/portfolio/` | Website + content + own .agents/ |
| `03_CAREER/Study_Notes/` | Docs | `workspace/career/study-notes/` | GATE Physics, CDSE PYQs |

---

## `04_ACADEMIC/` → `workspace/academic/`

| Butler Root path | Type | BROS destination | Notes |
|---|---|---|---|
| `04_ACADEMIC/Books (Academia)/` | Docs | `workspace/academic/books/` | Physics, Chemistry, Maths reference books |
| `04_ACADEMIC/Certificates/` | Docs | `workspace/academic/certificates/` | Course/completion certificates |
| `04_ACADEMIC/IISER_Pune/` | Docs | `workspace/academic/iiser-pune/` | Coursework, thesis, notes, transcript |
| `04_ACADEMIC/Q2DM/` | Code | `workspace/academic/q2dm/` | **Canonical** Q2DM location. Symlink from `workspace/ina/projects/q2dm/` |
| `04_ACADEMIC/Q2DM_REBUILD_PLAN/` | Docs | `workspace/academic/q2dm/rebuild-plan/` | Q2DM rebuild documentation |
| `04_ACADEMIC/School_Projects/` | Archive | `workspace/academic/school-projects/` | C++ school projects |

---

## `99_INBOX/` → `inbox/`

| Butler Root path | Type | BROS destination | Notes |
|---|---|---|---|
| `99_INBOX/*.pdf` | Docs | `inbox/docs/` | Contracts, interview invites, profiles, timesheets |
| `99_INBOX/*.txt` | Docs | `inbox/exports/` | Brain dumps, git logs, extracted text |
| `99_INBOX/*.zip` (extracted) | Code/Docs | Extract to `inbox/code/` or `inbox/docs/`, then process | awesome-agent-skills, second-brain, Curated Content |
| `99_INBOX/*.py` | Code | `inbox/code/` | Python scripts |
| `99_INBOX/*.ipynb` | Code | `inbox/code/` | Jupyter notebooks |
| `99_INBOX/*.jpeg/.jpg/.png/.webp` | Attachment | `inbox/attachments/` | Images, screenshots |
| `99_INBOX/ChatGPT Plus Exports/` | Export | `inbox/exports/chatgpt/` | ChatGPT history |
| `99_INBOX/Notion_Claude_Export/` | Export | `inbox/exports/notion/` | Notion export |
| `99_INBOX/scienceclaw_reports/` | Docs | `inbox/docs/scienceclaw/` | ScienceClaw reports |
| `99_INBOX/Q2DM Final/` | Code | `inbox/code/q2dm-final/` | Q2DM submission artifacts |
| `99_INBOX/QB Companies/` | Docs | `workspace/career/phd-search/` or `inbox/docs/` | Quantum company research |
| `99_INBOX/archive/` | Archive | `inbox/archive/` | Already sorted archive |

---

## Root-level projects → `projects/`

| Butler Root path | Type | BROS destination | Notes |
|---|---|---|---|
| `proxima_edit/` | Code | `projects/proxima/edit/` | Proxima Electron app edits |
| `proxima_original/` | Code | `projects/proxima/original/` | Original asar content |
| `proxima_asar_extracted/` | Code | (merge into proxima/) | Extracted asar |
| `.proxima_test_output/` | Code | `projects/proxima/test-output/` | Test artifacts |
| `nim-prototype/` | Code | `projects/nim-prototype/` | Nim language prototype |
| `dendron/` | Vault | `vaults/dendron/` | Dendron notes |
| `fix_*.js` (5 files) | Tool | `tools/scripts/fix/` | JS fix scripts |
| `Butler-Profile.ps1` | Tool | `tools/scripts/butler-profile.ps1` | PowerShell profile |
| `app.asar` | Asset | `projects/proxima/original/` | Original Electron app |
| `node_modules/` | Deps | (regenerate on demand) | NPM dependencies |
| `package.json` | Config | `projects/proxima/package.json` | NPM config |

---

## Dotfiles (stay in Butler Root — tools hardcode paths)

| Path | Purpose | Notes |
|---|---|---|
| `.agent/` | Antigravity config | Tools expect this at workspace root — keep in `F:\BUTLER_ROOT` |
| `.vscode/` | VS Code settings | Keep in `F:\BUTLER_ROOT` |
| `.obsidian/` | Obsidian config | Keep in `F:\BUTLER_ROOT` |
| `.sisyphus/` | Sisyphus agent | Keep in `F:\BUTLER_ROOT` |
| `.safe/` | Safe config | Keep in `F:\BUTLER_ROOT` |
| `.failsafe/` | Failsafe config | Keep in `F:\BUTLER_ROOT` |
| `.commandcode/` | CommandCode config | Keep in `F:\BUTLER_ROOT` |
| `.maraudersmapmd/` | MaraudersMap config | Keep in `F:\BUTLER_ROOT` |
| `.dendron.*` | Dendron workspace config | Keep in `F:\BUTLER_ROOT` or migrate to `vaults/dendron/` |

---

## Cross-references

| Item | Canonical location | Symlink from |
|---|---|---|
| Q2DM | `workspace/academic/q2dm/` | `workspace/ina/projects/q2dm/` → `../academic/q2dm/` |
