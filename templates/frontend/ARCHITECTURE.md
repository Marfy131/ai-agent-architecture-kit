# Frontend Architecture Blueprint

This document defines the architectural principles, boundaries, and conventions for the frontend application.

## Core Architectural Style

The frontend is organized around **Feature Modularity** (Capability-driven architecture) using React, Vite, and strict TypeScript.

## Feature Organization

Features live under dedicated directories. Global "dumping grounds" (e.g. monolithic root `components/`, `hooks/`, `utils/`) are strictly avoided:

```text
src/
├── modules/
│   └── <feature>/
│       ├── api/          # Feature API clients, React Query hooks, MSW handlers
│       ├── application/  # Local client state, coordinate hooks, business workflows
│       ├── domain/       # TypeScript types, domain invariants, transformation functions
│       ├── ui/           # React presentation components private to this feature
│       └── index.ts      # Explicit public API for cross-feature consumption
├── shared/               # Domain-neutral design system tokens, primitives, utilities
└── app/                  # Application root, routing, authentication provider, layout
```

### Dependency Rules

1. **Feature Encapsulation**: Files inside `modules/<feature>/` are private by default. Other modules or pages can only import exports from `modules/<feature>/index.ts`.
2. **Shared Layer Boundaries**: `src/shared` must be strictly domain-neutral (e.g., UI buttons, date formatters, common HTTP client setup). It must never import from `modules/`.
3. **No Direct Inter-Feature State Coupling**: A feature must not directly mutate or access the internal state of another feature.

## State Management

1. **Server State**: Managed exclusively through dedicated asynchronous server caches (e.g., TanStack Query / RTK Query). Do not synchronize server responses into global client stores (Zustand/Redux) or manage them with ad-hoc `useEffect` + `useState`.
2. **Local UI State**: Transient UI state (modals, dropdowns, form inputs) stays within the local React component tree.
3. **Global Client State**: Reserved only for truly cross-cutting client-side state (e.g. user session metadata, active theme).

## API Integration & Contracts

- **OpenAPI Single Source of Truth**: All API clients and types are generated from backend OpenAPI contracts. Generated files are read-only.
- **Contract Boundary**: Map backend transport DTOs to rich frontend domain models within `modules/<feature>/api/` when transformation provides architectural value.
- **Error Representation**: Standardized around RFC 7807 / RFC 9457 `ProblemDetail` structures.

## Testing Architecture

- **Unit/Application**: Vitest for pure domain functions and hooks.
- **Component**: React Testing Library testing observable user behavior and accessibility semantics (`getByRole`, `userEvent`).
- **Network Boundary**: Mock Service Worker (MSW) with handlers colocated next to feature API modules.
- **Critical Journeys**: Playwright for end-to-end integration flows.
