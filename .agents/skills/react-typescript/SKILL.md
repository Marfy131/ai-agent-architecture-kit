---
name: react-typescript
description: Use for ordinary React, Vite, and TypeScript implementation work.
---
# React and TypeScript

## TypeScript
Strict mode is mandatory. Do not weaken `tsconfig` to fix code.

- Avoid `any`; prefer `unknown` plus explicit narrowing when data is not trusted.
- Avoid unjustified type assertions (`as X`) used only to silence the compiler.
- Use `import type` for type-only imports to prevent circular dependency traps and optimize bundler tree-shaking.
- Keep domain/business types in the owning feature.
- Treat external API data as boundary data, not automatically trustworthy runtime values.

## React
- Keep components focused and prefer composition over boolean prop explosion.
- Move complex orchestration to application/hooks/services inside the feature rather than giant components.
- Effects are strictly for synchronization with external systems, not data fetching or general control flow.
- Follow Hooks rules; do not suppress dependency warnings casually.
- Keep server state in dedicated query hooks (TanStack Query/SWR), completely separate from local UI state.

## Feedback loop
After each logical change run formatter, ESLint, `tsc --noEmit` (or project equivalent), and affected Vitest/RTL tests. Before completion, run the production Vite build.
