---
name: architecture-boundaries
description: Use when creating or changing modules, dependencies, public module APIs, shared platform code, or cross-service boundaries.
---
# Architecture Boundaries

## Goal
Preserve capability-oriented modularity and prevent accidental coupling.

## Rules
- Organize by business capability first, technical layer second.
- Preferred backend layers inside a capability: `api`, `application`, `domain`, `adapter/in`, `adapter/out`.
- Domain must not depend on controllers, Kafka listeners/producers, JPA repositories, HTTP clients, AWS SDKs, or other infrastructure implementations.
- Application code depends on domain and ports, not outbound adapter implementations.
- Cross-module calls use the target module's explicit public API.
- Never import another module's internal/domain/persistence implementation directly.
- A service owns its database; another service must not query it directly.
- Share infrastructure/policy aggressively; share business/runtime models conservatively.

## Shared platform test
Centralize something only when:
1. most services need essentially the same behavior because of infrastructure/security/organizational policy;
2. it contains no service-specific business semantics; and
3. sharing it does not force unrelated services into coordinated releases.

Good platform candidates: dependency versions, build rules, logging policy, security infrastructure, Kafka infrastructure, observability.

Keep local: domain DTOs, events, roles/permissions, business exceptions, JPA entities, repositories, domain services.

## Verification
Run architecture tests (ArchUnit/Spring Modulith or frontend boundary tooling) after any boundary change.
