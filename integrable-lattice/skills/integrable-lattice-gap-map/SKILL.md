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
2. Define the cell key (Λ ladder + four axes; NOT the literature operation-type taxonomy):

```text
model × direction(A–F) × target_quantity × home × complexity × solvability × decidable × formal_verifiable
```

where `home ∈ {ℤ[x], Λ, ℚ̄, ℝ-escape}`, `complexity ∈ {poly, #P, unknown}`, `solvability ∈ {closed, none, unknown}`, `decidable ∈ {yes, schanuel, no}`, `formal_verifiable ∈ {yes, partial, no}`. Vocabulary: `inputs/seeds/lambda-statement-program.md`.

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
model:
direction:            # A–F (lambda-statement-program)
target_quantity:      # 例: Fisher zeros, transfer matrix T(x), Massieu Φ_N
home:                 # ℤ[x] / Λ / ℚ̄ / ℝ-escape
complexity:           # poly / #P / unknown
solvability:          # closed / none / unknown
decidable:            # yes / schanuel / no
formal_verifiable:    # yes / partial / no
status:               # known / probably_known / unknown / impossible / needs_review
known_anchors:
missing_generalization:
coverage_notes:
review_notes:
```

## Guardrails

- Do not equate "not found" with "open"; use `unknown` until verification.
- Keep the map scope explicit, because a gap depends on corpus coverage.
- Prefer small reliable maps over broad maps with hidden uncertainty.

