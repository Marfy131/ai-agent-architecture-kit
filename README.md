# AI Agent Architecture Kit

Portable project instructions and task-specific skills for the architecture described in this repository:

- Java 25 / Maven / Spring Boot 4.1.x
- Spring Security / Spring Modulith / Spring Data JPA / Spring Kafka
- PostgreSQL / Liquibase
- OpenAPI / Apache Avro
- shared platform BOM + Maven parent + Logbook/Kafka/Security starters
- React / Vite / TypeScript strict
- deterministic static-analysis, architecture, security and test feedback loops

The kit is designed around a small always-loaded `AGENTS.md` plus on-demand `SKILL.md` files.

## Layout

```text
AGENTS.md
install.sh
install.ps1
scripts/
  validate.sh
  validate.ps1
.agents/
  skills/
    architecture-boundaries/SKILL.md
    maven-quality-loop/SKILL.md
    generated-contracts/SKILL.md
    dependency-upgrades/SKILL.md
    java-spring/SKILL.md
    spring-modulith/SKILL.md
    persistence-jpa-postgres/SKILL.md
    liquibase/SKILL.md
    kafka-avro/SKILL.md
    security-keycloak/SKILL.md
    rest-openapi/SKILL.md
    logbook/SKILL.md
    backend-testing/SKILL.md
    frontend-modularity/SKILL.md
    react-typescript/SKILL.md
    frontend-api/SKILL.md
    frontend-testing/SKILL.md
    frontend-security-accessibility/SKILL.md

templates/
  backend/
    AGENTS.md
    ARCHITECTURE.md
  frontend/
    AGENTS.md
    ARCHITECTURE.md
```

## Recommended installation: project-local and portable

You can install manually or use the provided cross-platform installation scripts.

### Automated installation

Linux / macOS (Bash):
```bash
# Standard copy:
./install.sh /path/to/your-repo

# Or create symbolic links to track kit updates dynamically:
./install.sh --symlink /path/to/your-repo
```

Windows (PowerShell):
```powershell
# Standard copy:
.\install.ps1 C:\path\to\your-repo

# Or create junctions to track kit updates dynamically:
.\install.ps1 -TargetDir C:\path\to\your-repo -Symlink
```

Use `--force` / `-Force` if you want to overwrite an existing `AGENTS.md` in the destination repository.

### Manual copy

```bash
cp /path/to/ai-agent-architecture-kit/AGENTS.md /path/to/your-repo/AGENTS.md
cp -R /path/to/ai-agent-architecture-kit/.agents /path/to/your-repo/.agents
```

If the repository already has an `AGENTS.md`, merge the non-negotiable rules rather than overwriting project-specific instructions.

Commit these files with the repository so developers and agents use the same rules.

## Dirac

Dirac reads project `AGENTS.md` and discovers agent/skill configuration from `.agents` (as well as compatible `.ai`/`.claude` locations).

Recommended layout:

```text
your-repo/
  AGENTS.md
  .agents/
    skills/
      <skill>/SKILL.md
```

Start Dirac from the repository as usual. Open a new session after adding or renaming skills so discovery starts from a clean context.

No Dirac-specific copy is necessary for this kit.

## OpenCode

OpenCode V2 uses project `AGENTS.md` for persistent repository instructions. Its native project skill location is `.opencode/skills/<name>/SKILL.md`, and it also supports compatible `.agents/skills/<name>/SKILL.md` skills.

Therefore the portable layout in this kit works directly:

```text
your-repo/
  AGENTS.md
  .agents/
    skills/
      <skill>/SKILL.md
```

If you prefer OpenCode's native path, copy the same skill directories instead of maintaining different content:

```bash
mkdir -p .opencode/skills
cp -R .agents/skills/. .opencode/skills/
```

Do **not** maintain divergent copies. Pick one canonical location. The package defaults to `.agents/skills` for cross-tool portability.

OpenCode skill definitions use `SKILL.md` with YAML frontmatter containing at least `name` and `description`; this kit follows that format.

## Oh My Pi (OMP)

OMP discovers standalone `AGENTS.md` files and supports skills in `.agents/skills/<name>/SKILL.md`. Its native project location is `.omp/skills/<name>/SKILL.md`, with native `.omp` skills taking higher precedence when duplicate names exist.

The portable package therefore works directly:

```text
your-repo/
  AGENTS.md
  .agents/
    skills/
      <skill>/SKILL.md
```

If you deliberately prefer OMP-native placement:

```bash
mkdir -p .omp/skills
cp -R .agents/skills/. .omp/skills/
```

Avoid installing the same skill name in both `.omp/skills` and `.agents/skills` unless you intentionally want the `.omp` version to override it.

Restart/reopen OMP after adding or removing skill directories so discovery is refreshed.

## Google Antigravity (AGY)

Antigravity natively loads workspace customizations from `.agents/skills/<name>/SKILL.md` and repository instructions from `AGENTS.md`.

No transformation or relocation is needed:

```text
your-repo/
  AGENTS.md
  .agents/
    skills/
      <skill>/SKILL.md
```

## Claude Code and Cursor

- **Claude Code**: Natively reads `CLAUDE.md` and looks for skills in `.claude/skills/`. You can link to this portable kit:
  ```bash
  ln -s AGENTS.md CLAUDE.md
  mkdir -p .claude && ln -s ../.agents/skills .claude/skills
  ```
- **Cursor**: Discovers instructions from `.cursor/rules/` or `.cursorrules`. You can symlink or reference `AGENTS.md`.

## Optional backend/frontend scoped AGENTS.md and ARCHITECTURE.md files

`templates/backend/` and `templates/frontend/` contain scoped agent instructions and architecture blueprints. Copy them when your repository has distinct backend/frontend roots:

```bash
# Backend scope:
cp templates/backend/AGENTS.md backend/AGENTS.md
cp templates/backend/ARCHITECTURE.md backend/ARCHITECTURE.md

# Frontend scope:
cp templates/frontend/AGENTS.md frontend/AGENTS.md
cp templates/frontend/ARCHITECTURE.md frontend/ARCHITECTURE.md
```

Keep critical repository-wide rules in the root `AGENTS.md`. Tools differ in exactly when nested `AGENTS.md` files are discovered:

- OpenCode layers directory-specific `AGENTS.md` guidance as workspaces/paths are explored.
- OMP discovers standalone `AGENTS.md` by walking ancestors from its working directory, so launching it from a backend/frontend subtree is the safest way to guarantee that scoped file applies.
- Dirac and Antigravity support project `AGENTS.md`; use the root file as the guaranteed baseline and treat nested scope files as convenience context.

## How the skills are intended to be used

The root `AGENTS.md` tells the agent to load only relevant skills. Examples:

### Kafka consumer change

```text
architecture-boundaries
java-spring
kafka-avro
backend-testing
maven-quality-loop
```

### Liquibase/JPA change

```text
java-spring
persistence-jpa-postgres
liquibase
backend-testing
maven-quality-loop
```

### REST contract change

```text
architecture-boundaries
rest-openapi
generated-contracts
java-spring
backend-testing
maven-quality-loop
```

### React feature

```text
frontend-modularity
react-typescript
frontend-api
frontend-testing
frontend-security-accessibility   # when auth/a11y is relevant
```

## What stays in AGENTS.md vs skills

Keep in `AGENTS.md`:

- module-boundary prohibition
- generated-code prohibition
- released-migration immutability
- business knowledge stays local
- no weakening tests/static analysis/security/CI
- no unjustified suppressions
- deterministic verification requirement

Keep in skills:

- framework-specific implementation guidance
- Kafka behavior
- JPA/PostgreSQL rules
- Liquibase workflow
- Keycloak mapping rules
- OpenAPI/Avro workflow
- detailed testing approach
- frontend React/TypeScript conventions
- exact feedback-loop guidance

This keeps the permanent context small while preserving specialized guidance on demand.

## Suggested repository architecture docs

Keep architecture separate from agent operating instructions:

```text
ARCHITECTURE.md          # authoritative system-wide principles/boundaries
AGENTS.md                # short non-negotiable operating rules
.agents/skills/          # task-specific implementation guidance
docs/adr/                # decisions and rationale
```

`ARCHITECTURE.md` explains what the system is and why. `AGENTS.md` says what an agent must never violate. Skills explain how to perform a specific class of work.

## Sources checked for tool installation behavior

Current behavior was checked against documentation/search results available on 2026-10-01:

- OpenCode instructions: https://opencode.ai/v2/docs/instructions
- OpenCode skills: https://opencode.ai/docs/skills
- Dirac repository: https://github.com/dirac-run/dirac
- Oh My Pi skills: https://github.com/can1357/oh-my-pi/blob/main/docs/skills.md
- Oh My Pi configuration/discovery: https://github.com/can1357/oh-my-pi/blob/main/docs/config-usage.md

Agent tooling evolves quickly. If a future version changes discovery paths, keep `.agents/skills` as the canonical source and adapt with a symlink/copy into the tool's native directory rather than maintaining divergent skill contents.
