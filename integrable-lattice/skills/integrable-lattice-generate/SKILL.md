---
name: integrable-lattice-generate
description: Project-specific unresolved statement generation for integrable-lattice. Use when Codex needs to turn unknown gap-map cells into concrete candidate theorems, conjectures, or paper-sized finite-symbol statements in integrable lattice models.
---

# Integrable Lattice Generate

## Goal

Convert gap-map cells into concrete unresolved statement candidates that could become paper results.

## Required Context

Read:

- `integrable-lattice/docs/schemas.md`
- relevant gap-map entries from `integrable-lattice/outputs/maps/`
- nearest known anchors from the classified literature

## Workflow

1. Start from unknown or needs-review gap cells with a nearby known anchor.
2. Write the candidate as a mathematical statement, not just a topic.
3. State the finite-symbol process expected to prove it: local relation, transfer-matrix algebra, determinant/Pfaffian reduction, T-system recurrence, q-series identity, or small-size extrapolation.
4. Identify the exact shift from known work: boundary, rank, representation, root of unity, elliptic/trigonometric/rational regime, finite-size truncation, defect, or model family.
5. Add a small-case experiment plan when possible.
6. Save candidates under `integrable-lattice/outputs/candidates/`.

## Output Shape

Use `StatementCandidate` from `integrable-lattice/docs/schemas.md`.

Minimum required fields:

```yaml
id:
title:
model_family:
model:
operation_type:
statement_type:
known_result_anchor:
missing_generalization:
candidate_statement:
finite_symbol_process:
expected_proof_strategy:
small_case_experiment:
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: unknown
references:
```

## Guardrails

- Do not generate candidates from unsupported gaps; every candidate needs a known anchor.
- Avoid vague statements like "study X". Use theorem-shaped statements.
- Mark speculative candidates as speculative rather than laundering them into open problems.

