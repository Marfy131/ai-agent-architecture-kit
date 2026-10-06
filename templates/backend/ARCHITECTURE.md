# Backend Architecture Blueprint

This document defines the architectural principles, boundaries, and conventions for the backend service.

## Core Architectural Style

The backend is built around **Capability-Oriented Modularity** (Modular Monolith via Spring Modulith, or Domain-Driven Microservices) using **Hexagonal (Ports and Adapters)** structure inside each business capability.

## Capability Organization and Layers

Each business module is structured by capability first, technical concerns second:

```text
com.company.<service>.<capability>/
├── api/             # Inbound public interfaces and DTOs exposed to other modules
├── application/     # Use case orchestrators, application services, incoming/outgoing ports
├── domain/          # Pure domain models, value objects, business rules, domain events
└── adapter/
    ├── in/          # Inbound adapters: REST controllers, Kafka listeners, scheduled jobs
    └── out/         # Outbound adapters: JPA repositories, Kafka producers, external clients
```

### Dependency Rules

1. **Domain Isolation**: `domain` depends on nothing outside itself. It contains no Spring annotations (except standard JSpecify), no JPA annotations, no Kafka dependencies, and no HTTP abstractions.
2. **Application Layer**: `application` depends on `domain` and defines interfaces (ports) for persistence and external messaging.
3. **Adapters**: Adapters implement application ports or invoke application use cases. Adapters never contain domain business logic.
4. **Cross-Module Access**: Modules must interact strictly through `api/` interfaces or asynchronous domain events. Never import another module's `domain`, `application`, or `adapter` packages.

## Database Ownership and Transactions

- **Single Owner**: A service/module owns its schema and tables. No cross-service database access.
- **Transactional Consistency**: Aggregate operations must complete within a single transaction boundary managed in the application layer.
- **Outbox Pattern for Events**: To avoid dual-write distributed transaction failures between PostgreSQL and Kafka, domain events intended for Kafka publication must be saved atomically via an Outbox table or Spring Modulith's Event Publication Registry.
- **Read-Only Paths**: Mark query-only application operations with `@Transactional(readOnly = true)` to avoid Hibernate dirty-checking overhead.

## Messaging and Events (Kafka)

- **Domain Events vs Integration Events**: Internal module events are published via Spring Modulith. Events intended for other microservices are serialized with Apache Avro and published to Kafka.
- **Idempotent Consumers**: Every consumer must implement deduplication via unique event/business keys.
- **DLT Strategy**: Failures after configured retry attempts are routed to dedicated Dead Letter Topics (`<topic>.DLT`).

## Platform Starters vs Local Semantics

- **Shared Platform (Centralized)**: Dependency versions (BOM), parent POM, security authentication filters (JWT validation), Logbook HTTP masking, Kafka producer/consumer factories, and OpenTelemetry instrumentation.
- **Local Application (Decentralized)**: Business authorization roles (`order:approve`), Kafka topic names, Avro schemas, domain entities, use cases, and business exceptions.
