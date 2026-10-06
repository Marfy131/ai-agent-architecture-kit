---
name: security-keycloak
description: Use for Spring Security, JWT, Keycloak, authorities, roles/permissions, authentication, authorization, or service-to-service security.
---
# Security and Keycloak

## Boundary
The shared security starter owns authentication infrastructure: JWT validation, Keycloak claim parsing, authority mapping, authentication failures, common security headers, and service-to-service auth.

The owning business module owns authorization meaning: permissions such as `order:cancel` or `payment:refund` must not live in the common platform.

> Platform knows how authorization works. Domain knows what authorization means.

## Keycloak
Infrastructure may understand `realm_access.roles` and `resource_access.<client>.roles`, but domain/application code should work with logical Spring authorities rather than parse token structure.

## Rules
- Enforce authorization on the backend even when the frontend hides an action.
- Keep permissions close to the owning module.
- Prefer readable local authorization annotations when they clarify intent.
- Do not log JWTs, bearer tokens, credentials or sensitive claims.
- Do not weaken CSRF/CORS/session/resource-server rules to fix unrelated application behavior.

## Tests
Add positive and negative authorization tests for security-sensitive behavior.
