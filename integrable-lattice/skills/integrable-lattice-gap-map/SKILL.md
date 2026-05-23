---
name: integrable-lattice-gap-map
description: Project-specific gap-map construction for integrable-lattice. Use when Codex needs to build model × boundary × parameter × operation × statement maps that separate known cells, probably known cells, unknown cells, impossible cells, and review-needed cells.
---

# Integrable Lattice Gap Map

## Goal

Build a map of solved and missing cells. The map is the bridge between literature extraction and unresolved statement generation.

## Required Context

Read:

- `integrable-lattice/docs/schemas.md`
- current classified fragments
- relevant seed axes in `integrable-lattice/inputs/seeds/axes.md`

## Workflow

1. Choose a bounded map scope: model family, operation type, or paper cluster.
2. Define the cell key:

```text
model_family × model × boundary_condition × parameter_regime × operation_type × statement_type
```

3. Fill cells from classified fragments.
4. Assign cell status:
   - `known`: directly evidenced.
   - `probably_known`: likely covered by a cited/general result but not yet verified.
   - `unknown`: no evidence found in the scoped corpus.
   - `impossible`: definition or compatibility appears to fail.
   - `needs_review`: classification or literature coverage is weak.
5. For each unknown cell, record the nearest known anchor.
6. Save curated maps under `integrable-lattice/outputs/maps/`.

## Output Shape

```yaml
cell_id:
model_family:
model:
boundary_condition:
parameter_regime:
operation_type:
statement_type:
status:
known_anchors:
missing_generalization:
evidence_papers:
coverage_notes:
review_notes:
```

## Guardrails

- Do not equate "not found" with "open"; use `unknown` until verification.
- Keep the map scope explicit, because a gap depends on corpus coverage.
- Prefer small reliable maps over broad maps with hidden uncertainty.

