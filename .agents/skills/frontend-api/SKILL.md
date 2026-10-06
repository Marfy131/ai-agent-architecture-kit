---
name: frontend-api
description: Use when frontend code calls backend APIs, uses generated OpenAPI clients/types, handles API errors, or manages server data.
---
# Frontend API Integration

## Contracts
Prefer generated OpenAPI clients/types. Generated output is read-only; fix the contract or generator configuration and regenerate.

## Boundary
Raw HTTP calls should not be scattered through React components. Keep API access in the owning feature's API/infrastructure boundary and expose application-friendly operations upward.

## Data and State Handling
- Distinguish transport DTOs from richer frontend domain models when useful.
- Validate/narrow genuinely untrusted runtime data at the boundary.
- Manage server state through dedicated asynchronous caches (e.g. TanStack Query / SWR); do not duplicate server data into global client stores (Zustand/Redux) or manual `useEffect` synchronization.
- Keep server state strictly separated from local UI state.

## Errors
- Standardize on parsing backend RFC 7807 / RFC 9457 `ProblemDetail` payloads to drive user-friendly form validations and alerts.
- Distinguish validation/business rejection, authentication/authorization, network failure, server failure and unexpected client errors where UX differs. Do not expose raw backend internals directly to users.

## Verification
Run typecheck, affected API/component tests using MSW or repository-standard mocking, and contract-generation checks when contracts changed.
