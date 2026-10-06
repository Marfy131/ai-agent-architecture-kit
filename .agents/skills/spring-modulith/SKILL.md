---
name: spring-modulith
description: Use when creating/changing Spring Modulith modules, module APIs, inter-module events, or module dependencies.
---
# Spring Modulith

## Module model
Each business capability is a module with an explicit boundary. Internal packages are implementation details.

## Rules
- Other modules interact through public API types/events only.
- Do not inject repositories/services from another module's internal package.
- Prefer domain/application events when temporal decoupling is appropriate; do not use events merely to avoid a clean synchronous API.
- Avoid cycles between modules.
- Keep module dependencies directional and understandable.

## Architecture verification
Use Spring Modulith verification and ArchUnit rules to reject forbidden access and cycles. If a rule fails, fix the dependency or explicitly redesign the architecture; do not weaken the test for convenience.

## Tests
Use module-scoped tests where they provide faster isolation than full application tests.
