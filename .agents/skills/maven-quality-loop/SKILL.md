---
name: maven-quality-loop
description: Use for backend implementation, Maven build changes, static analysis, formatting, compilation, or when deciding the fastest verification loop.
---
# Maven Quality Loop

## Standard
- Use `./mvnw`, not an arbitrary system Maven.
- Dependency versions come from the company BOM unless explicitly justified.
- Build behavior comes from the company parent POM.
- Do not lower or bypass quality gates to fix implementation failures.

## Expected tooling
The parent should standardize Java 25 plus Maven Enforcer, compiler configuration, Surefire/Failsafe, Spotless, Checkstyle, Error Prone, NullAway/JSpecify, SpotBugs, JaCoCo, ArchUnit/Spring Modulith verification, Sonar configuration, and CycloneDX generation as applicable.

## Inner loop
After each logical change, run the narrowest useful checks. Prefer the repository-defined quick profile, for example:

```bash
./mvnw verify -Pquick
```

The quick profile should favor: formatting/check, compile, Error Prone/NullAway, architecture tests, affected unit tests.

## Full loop
Before completion, use the repository's full verification, typically:

```bash
./mvnw verify
```

Full verification may include integration tests, Testcontainers, contracts, Liquibase validation, coverage, SpotBugs and security checks.

## Failure policy
When a check fails: read the exact failure, fix root cause, rerun the smallest failing check, then broaden verification. Never skip phases, disable tests, add blanket suppressions, or change thresholds merely to get green.
