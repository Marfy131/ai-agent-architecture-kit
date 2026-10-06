---
name: frontend-testing
description: Use for Vitest, React Testing Library, MSW, Playwright, frontend test design, or test failures.
---
# Frontend Testing

## Tools
Use Vitest for unit/application logic, React Testing Library for user-observable component behavior, MSW for network-boundary mocking, and Playwright for critical user journeys.

## Rules
- Prefer queries by role, label and visible text (`getByRole`, `getByLabelText`).
- Use `@testing-library/user-event` instead of `fireEvent` for realistic simulation of user clicks, typing, and tab navigation.
- Colocate MSW handlers with feature API modules rather than in one giant global mock server file.
- Test observable behavior, not internal component state or implementation details.
- Mock the network boundary (MSW) instead of deeply mocking child components when practical.
- Keep E2E tests focused on critical flows; do not move every behavior to Playwright.
- Do not write assertions that only prove a component rendered when stronger behavioral assertions exist.

## Failure policy
Do not delete assertions, skip tests, or add brittle waits merely to get green. Find the underlying timing, contract or behavioral issue.

## Verification
Run affected unit/component tests first, then the relevant Playwright subset for critical workflows.
