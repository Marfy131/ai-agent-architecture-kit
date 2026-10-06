---
name: kafka-avro
description: Use for Spring Kafka producers/consumers, single/batch listeners, retries, DLTs, Avro schemas, or messaging security/observability.
---
# Kafka and Avro

## Shared platform boundary
Use the company Kafka starter for listener factories, producer/consumer technical defaults, serialization, logging/tracing/metrics, TLS/SASL, technical error-handling defaults, and common headers.

Do not create another proprietary messaging framework that hides Spring Kafka.

## Local business ownership
Keep these local to the service/module:
- topic ownership and naming semantics;
- event meaning and schema;
- retryability decisions;
- ordering requirements and partition key strategy (grouping by aggregate ID);
- compensation behavior;
- business-specific DLT handling.

## Reliability and Atomicity
- **Dual-write prevention**: Never write to the database and publish directly to Kafka within the same flow without an Outbox Pattern (e.g. Spring Modulith Event Publication Registry or transactional outbox table).
- **Consumer Idempotency**: Assume at-least-once delivery. Consumers must enforce idempotency using event IDs or aggregate version numbers.
- **DLT Strategy**: Exhausted retries must route failed events to dedicated Dead Letter Topics (`<topic>.DLT`) with error headers preserved.

## Consumption modes
Use the platform's explicit SINGLE or BATCH listener configuration. Batch processing must define partial-failure semantics deliberately.

## Avro
- Edit schemas, never generated Avro classes.
- Respect Schema Registry compatibility.
- Prefer additive compatible evolution; use defaults/optional fields intentionally.

## Logging/security
Never log credentials or whole sensitive payloads. Preserve correlation/trace information using platform conventions.

## Testing
Test serialization compatibility and relevant consumer behavior with real Kafka/Testcontainers when semantics matter.
