---
name: integrable-lattice-extract
description: Project-specific extraction of statement fragments from integrable-lattice papers. Use when Codex needs to extract model names, boundary conditions, theorem/conjecture/open-problem text, formula labels, and finite-symbol operation hints from harvested lattice-model literature.
---

# Integrable Lattice Extract

## Goal

Turn harvested papers into statement fragments. A fragment is evidence for a possible known result, open problem, or operation type.

## Required Context

Before extraction, read:

- `integrable-lattice/docs/schemas.md`
- `integrable-lattice/inputs/seeds/models.md`
- `integrable-lattice/inputs/seeds/operations.md`
- `integrable-lattice/inputs/seeds/open_problem_collections.md`
- the relevant harvested records in `integrable-lattice/inputs/corpus/`

## Workflow

1. Prefer arXiv LaTeX source over PDF text. Use abstract text only for coarse extraction.
2. Search for section headers and environments: theorem, proposition, lemma, corollary, conjecture, problem, open problem, future work.
3. Run an **open-problem pattern pass** (see below) and emit fragments with `status_hints: open`.
4. Extract model names, boundary conditions, parameter regimes, algebraic objects, and operation names.
5. Extract formula labels and nearby prose for finite-symbol relations: Yang-Baxter, star-triangle, reflection equation, fusion, T-system, Y-system, determinant, Pfaffian, character identity.
6. Capture enough local context to support classification without copying long passages.
7. Preserve uncertainty. Use `unknown` rather than forcing a classification.

## Open-problem pattern pass

Phrases that mark an author-declared open statement. Match case-insensitively in
source text and the surrounding sentence; record the matched span in
`raw_short_quote` and set `status_hints: open`.

- `open problem`, `open question`, `remains open`, `still open`, `is open`
- `we conjecture`, `our conjecture`, `we expect`, `we believe`
- `it would be interesting to`, `it would be desirable`, `it is natural to ask`
- `future work`, `future direction`, `further work`, `next step`
- `not yet known`, `is not known`, `to the best of our knowledge`
- `leave ... for future`, `is left open`, `we leave`

After matching, attach nearby model/operation/boundary hints from the same
paragraph so the fragment can be placed on the gap map.

## Output Shape

```yaml
fragment_id:
paper_id:
location:
text_summary:
raw_short_quote:
model_hints:
boundary_hints:
parameter_hints:
operation_hints:
statement_hints:
status_hints:
equation_labels:
notes:
```

## Guardrails

- Do not infer an open problem from absence alone; extract explicit evidence or mark as unknown.
- Do not collapse different boundary conditions or parameter regimes.
- Keep formulas tied to their source location, because later novelty checks depend on traceability.

