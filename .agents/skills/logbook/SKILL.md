---
name: logbook
description: Use when changing HTTP request/response logging, Logbook configuration, correlation IDs, structured logging, or sensitive-data masking.
---
# HTTP Logging with Logbook

## Principle
The company Logbook starter provides secure defaults. Applications may add stricter filtering; weakening mandatory protections requires explicit platform-level justification.

## Never log
- `Authorization` / `Proxy-Authorization`;
- bearer/access/refresh tokens;
- passwords and client secrets;
- API keys;
- authentication cookies;
- configured sensitive payload fields.

## Defaults
Prefer structured logs, correlation/trace IDs, bounded body sizes, and exclusions for health/readiness endpoints where appropriate.

## Rules
- Do not dump entire domain objects or raw security contexts for debugging.
- Temporary debug logging must follow the same masking policy.
- Keep masking/filtering in reusable platform configuration when it is organization-wide.
- Business-specific sensitive fields may add local filters.

## Verification
Add tests for newly introduced masking/filtering rules and verify representative request/response logs contain no secrets.
