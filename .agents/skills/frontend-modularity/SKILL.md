---
name: frontend-modularity
description: Use for React frontend module organization, shared code, cross-feature imports, public feature APIs, or architecture boundary changes.
---
# Frontend Modularity

## Structure
Organize by business capability, for example `modules/orders`, `modules/customers`, with local `api`, `domain`, `application`, `ui`, and tests as useful.

Avoid global dumping grounds such as broad `components`, `hooks`, `services`, `models`, or `utils` folders that mix domains.

## Rules
- Feature internals stay private.
- Cross-feature access goes through an explicit public API.
- `shared` must be domain-neutral and must not depend on feature modules.
- Keep feature-specific hooks/components/types inside their owning feature.
- Promote code to shared only after real cross-feature reuse and semantic neutrality are clear.
- Frontend domain code should not depend directly on React, routing, fetch/Axios, browser storage, or UI libraries.

## Verification
Use ESLint boundary rules/dependency-cruiser or equivalent to enforce imports. Do not bypass with deep relative paths.
