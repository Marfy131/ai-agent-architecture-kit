# Frontend Agent Scope

Use the repository root `AGENTS.md` plus the relevant frontend skills and `ARCHITECTURE.md`.

- Frontend: React, Vite, TypeScript strict mode.
- Organize code by business capability; do not create global `components`, `hooks`, `services`, or `models` dumping grounds.
- Feature internals stay private. Cross-feature access must use explicit public APIs.
- `shared` must stay domain-neutral and must not depend on feature modules.
- Generated API clients/types are read-only; fix the OpenAPI source or generator configuration instead.
- Frontend authorization is UX only; backend authorization remains authoritative.
- Prefer semantic HTML and accessible user interactions.
- Run formatter, ESLint, `tsc --noEmit`, affected tests, and the production build as appropriate.
- Load task-specific skills before implementation.
