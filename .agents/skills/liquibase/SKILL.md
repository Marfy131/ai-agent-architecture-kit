---
name: liquibase
description: Use whenever database schema/data migrations or Liquibase changelogs are changed.
---
# Liquibase

## Non-negotiable rule
Released/applied migrations are immutable. Never edit an old migration to make a new implementation pass; create a new migration.

## Migration design
- Keep changes small and reviewable.
- Use project naming/order conventions.
- Consider backward/forward compatibility for rolling deployments.
- Avoid destructive changes in the same deployment that still has old application instances running unless the rollout explicitly permits it.
- Separate expand/migrate/contract phases when necessary.
- For data migrations, consider volume, locking, batching and rollback strategy.

## Validation
At minimum verify:
1. `liquibase validate` or repository equivalent;
2. an empty PostgreSQL database can apply the complete history;
3. application integration tests pass against the migrated schema.

For risky changes, also test upgrade from the previous production schema state.
