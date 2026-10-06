---
name: rest-openapi
description: Use for REST controllers, HTTP endpoints, OpenAPI contracts, request/response DTOs, or API compatibility.
---
# REST and OpenAPI

## Contract
OpenAPI is the source of truth for contract-first HTTP APIs.

## Controller rules
- Controllers are inbound adapters: validate/translate transport input and call application use cases.
- Do not put business logic or persistence logic in controllers.
- Do not expose JPA entities directly.
- Standardize error responses using RFC 7807 / RFC 9457 `ProblemDetail` structures via `@RestControllerAdvice`.
- For state-mutating POST operations (e.g. order/payment creation), support `Idempotency-Key` headers to ensure safe client retries.

## Compatibility
For public/internal independently consumed APIs, check breaking changes to paths, methods, parameters, required fields, response shapes and status behavior.

## Generation
Generated models/clients/interfaces are read-only. Fix OpenAPI or generator settings, then regenerate.

## Security/logging
Ensure security requirements are represented where useful and sensitive headers/body fields are covered by central Logbook rules.

## Verification
Run OpenAPI validation, generation consistency and breaking-change checks where configured.
