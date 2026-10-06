# Backend Agent Scope

Use the repository root `AGENTS.md` plus the relevant backend skills and `ARCHITECTURE.md`.

- Backend: Java 25, Maven, Spring Boot 4.1.x, Spring Security, Spring Modulith, Spring Data JPA, Spring Kafka, PostgreSQL, Liquibase, OpenAPI, Avro.
- Organize code by business capability, then by `api`, `application`, `domain`, and `adapter`.
- Domain code must not depend on HTTP, Kafka, persistence implementations, or external SDKs.
- Use module public APIs; never reach into another module's internals.
- Business roles/permissions remain local to their owning module. Shared security code only maps identity/claims to Spring authorities.
- Use the shared platform starters for Logbook, Kafka, and security; do not create parallel abstractions.
- Use the Maven wrapper and the repository's quick/full verification profiles.
- Load task-specific skills before implementation.
