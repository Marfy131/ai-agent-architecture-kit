---
name: generated-contracts
description: Use whenever OpenAPI, Avro, generated clients/models, schemas, or generated sources are involved.
---
# Generated Code and Contracts

## Rule
Generated code is read-only.

Do not manually patch OpenAPI-generated clients/models, Avro-generated classes, generated documentation, or other generated artifacts.

If generated output is wrong, change the source contract or generator configuration and regenerate.

## Compatibility
- OpenAPI changes must pass validation and breaking-change checks.
- Avro changes must respect configured Schema Registry compatibility.
- Previously published contracts are treated as external interfaces; do not silently make incompatible changes.

## Review questions
- Is this change additive or breaking?
- Are consumers/producers independently deployable?
- Are defaults/optional fields sufficient for compatibility?
- Are generated artifacts reproducible from source?

## Verification
Run the repository's contract validation and regeneration/check command before completion.
