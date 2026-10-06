# Agent Rules

This repository uses modular, capability-oriented architecture and deterministic verification.

## Non-negotiable rules

1. Identify the owning business module before changing code.
2. Make the smallest architecture-compliant change.
3. Do not bypass module boundaries or reach into another module's internals.
4. Keep business knowledge, permissions, events, and domain models in the owning module/service.
5. Do not modify generated code; change the source contract or generator configuration instead.
6. Do not modify released database migrations; create a new migration.
7. Do not weaken tests, architecture rules, static analysis, security rules, coverage gates, or CI to make a change pass.
8. Do not add suppressions (`@SuppressWarnings`, `NOSONAR`, `eslint-disable`, exclusions) without a narrow, documented justification.
9. Load the relevant skills from `.agents/skills/` before implementation.
10. After each logical change, run the smallest relevant deterministic verification; before completion, run the required broader verification.

## Skill selection

Load only the skills relevant to the task. Typical mappings:

- Java/Spring implementation: `java-spring`
- Maven/static-analysis/build feedback: `maven-quality-loop`
- Module/boundary changes: `architecture-boundaries`, `spring-modulith`
- REST/API changes: `rest-openapi`, `generated-contracts`
- Kafka/event changes: `kafka-avro`, `generated-contracts`
- PostgreSQL/JPA changes: `persistence-jpa-postgres`
- Schema migrations: `liquibase`
- Authentication/authorization: `security-keycloak`
- HTTP logging: `logbook`
- Backend tests: `backend-testing`
- React/TypeScript: `react-typescript`, `frontend-modularity`
- Frontend API integration: `frontend-api`, `generated-contracts`
- Frontend tests: `frontend-testing`
- Frontend auth/accessibility: `frontend-security-accessibility`
- Dependency/framework upgrades: `dependency-upgrades`

## Completion rule

AI output is not evidence of correctness. Compiler/typechecker results, static analysis, architecture checks, contract validation, tests, and security tooling are the evidence.
