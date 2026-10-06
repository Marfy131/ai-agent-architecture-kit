---
name: java-spring
description: Use for Java 25 and Spring Boot backend implementation that is not primarily Kafka, persistence, security, or contract work.
---
# Java and Spring Implementation

## Design
- Prefer explicit, small classes with clear ownership.
- Put business rules in domain/application code, not controllers/configuration/mappers.
- Keep domain code framework-light where practical.
- Use constructor injection.
- Keep transaction boundaries explicit in the application layer.
- Prefer immutable value objects and explicit invariants.

## Java
- Follow project JSpecify/NullAway conventions.
- Prefer Java `record`s for immutable data carriers (DTOs, domain events, projections).
- Prefer sealed interfaces/types for modeling closed domain hierarchies and operation results.
- Avoid broad `Optional` usage as fields/parameters unless the project intentionally allows it.
- Avoid `null` ambiguity; model absence explicitly.
- Do not use exceptions for normal control flow.
- Keep public APIs narrow.

## Concurrency and Virtual Threads
- When Virtual Threads are enabled, avoid carrier thread pinning: never execute blocking I/O inside `synchronized` blocks or methods; prefer `java.util.concurrent.locks.ReentrantLock`.
- Keep transaction boundaries explicit; do not spread transactions across uncoordinated async threads.

## Lombok
Use Lombok only for intentional boilerplate reduction. Avoid blanket `@Data` on aggregates, JPA entities, or security-sensitive objects.

## MapStruct
Use MapStruct for deterministic structural mapping, not business decisions. Mapping code must not become a hidden domain-service layer.

## Verification
Compile, static-analyze, run affected unit tests, and run architecture checks before broad verification.
