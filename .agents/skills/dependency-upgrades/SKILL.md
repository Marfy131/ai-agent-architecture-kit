---
name: dependency-upgrades
description: Use for dependency, framework, Spring Boot, Java, build-plugin, or library upgrades.
---
# Dependency and Framework Upgrades

## Strategy
Prefer deterministic migration automation before free-form AI edits.

Recommended flow:
1. Renovate (or equivalent) proposes the version change.
2. OpenRewrite applies available mechanical migrations.
3. Compile and run static analysis.
4. Run tests and architecture checks.
5. Use AI only for remaining semantic migration failures.

## Rules
- Do not bundle unrelated dependency upgrades into feature work.
- Do not override BOM-managed versions locally without justification.
- Review release/migration notes for breaking behavior.
- Upgrade shared platform BOM/parent centrally when the change should apply organization-wide.
- Preserve reproducible builds and Maven Enforcer constraints.
