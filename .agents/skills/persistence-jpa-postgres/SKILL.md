---
name: persistence-jpa-postgres
description: Use for PostgreSQL, Spring Data JPA, repositories, persistence adapters, queries, entities, or transaction/persistence behavior.
---
# Persistence: JPA and PostgreSQL

## Ownership
Persistence belongs in the owning module's outbound adapter. A microservice owns its database; other services must not access it directly.

## Rules
- Do not expose JPA entities as public API contracts.
- Keep repository interfaces/ports aligned with application/domain needs rather than generic CRUD leakage.
- Be deliberate about identifier strategies: prefer time-ordered UUIDv7/TSID or sequence-based IDs for PostgreSQL B-tree indexing efficiency.
- Protect mutable aggregate roots against lost updates using `@Version` optimistic locking.
- Mark read-only query operations with `@Transactional(readOnly = true)` to disable Hibernate dirty-checking snapshots.
- Be deliberate about lazy loading, fetch joins/entity graphs, cascade behavior and aggregate size.
- Do not switch relationships to EAGER merely to hide lazy-loading/N+1 problems.
- Treat `equals`/`hashCode` for JPA entities carefully (avoid relying on generated mutable IDs).
- Use PostgreSQL/Testcontainers with Spring Boot `@ServiceConnection` for behavior that depends on real database semantics; do not rely only on H2 substitutes.
- Keep transaction boundaries in application orchestration where possible.

## Performance review
For query changes, consider cardinality, indexes, locking, N+1 behavior, pagination (prefer keyset/cursor over large offset), and transaction duration.

## Verification
Run affected repository/service tests against PostgreSQL Testcontainers and migration validation when schema is involved.
