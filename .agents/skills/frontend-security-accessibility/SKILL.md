---
name: frontend-security-accessibility
description: Use for frontend authorization, authentication UX, token handling, security-sensitive UI, forms, keyboard behavior, or accessibility.
---
# Frontend Security and Accessibility

## Security
Frontend authorization is a UX optimization, not a security boundary. The backend must independently enforce permissions.

- Do not log access/refresh tokens, Authorization headers, passwords or client secrets.
- Avoid unnecessary persistence of tokens in browser storage; follow the established authentication architecture.
- Permission-aware UI may hide/disable actions but must not be treated as authoritative authorization.
- Do not render raw backend technical errors containing sensitive details.

## Accessibility
- Prefer semantic HTML (`button`, `label`, `input`, `nav`, `main`, etc.).
- Interactive controls must support keyboard use and appropriate accessible names.
- Use ARIA only when native semantics are insufficient.
- Prefer RTL queries by role/label; this helps keep accessibility testable.

## Verification
For security-sensitive interactions, test both visible/hidden UI states and rely on backend tests for real authorization. For UI changes, include keyboard/accessibility assertions where relevant.
