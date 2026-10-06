---
name: backend-testing
description: Use when adding/fixing Java backend tests, choosing unit vs integration tests, Testcontainers, ArchUnit, coverage, or mutation testing.
---
# Backend Testing

## Test pyramid
Choose the lowest-cost test that proves the behavior.

- Plain JUnit for domain/application logic where Spring is unnecessary.
- ArchUnit/Spring Modulith tests for architecture.
- Focused Spring tests when framework wiring is the subject.
- Testcontainers for PostgreSQL/Kafka/infrastructure semantics.
- End-to-end tests only for flows that require them.

## Test quality
- Test observable behavior and boundary conditions.
- Avoid brittle assertions on implementation details.
- Avoid unnecessary mocks; mock true boundaries, not the entire object graph.
- Preserve Spring Context caching: avoid `@DirtiesContext` as it forces full context restarts and destroys test suite velocity.
- Prefer focused test slicing (`@WebMvcTest`, `@DataJpaTest`, `@RestClientTest`) over monolithic `@SpringBootTest` when verifying adapters.
- Use injectable `java.time.Clock` or `InstantSource` rather than static `Instant.now()` to ensure deterministic, non-flaky time assertions.
- Do not write tests solely to increase coverage.
- A passing test must make a meaningful assertion.

## Mutation testing
Use PIT for critical domain code, risky changed modules, or scheduled/deep validation; it need not run on every local edit.

## Failure policy
Never delete/disable a failing test merely to make a change pass. Determine whether the behavior or the test expectation is wrong.
