---
name: integrable-lattice-rank
description: Project-specific ranking for integrable-lattice paper targets. Use when Codex needs to rank verified unresolved statement candidates by novelty, finite-symbol clarity, proof feasibility, experimentability, literature risk, and paper scope.
---

# Integrable Lattice Rank

## Goal

Prioritize candidates by their usefulness for writing papers. Ranking is about our paper pipeline, not abstract mathematical importance alone.

## Required Context

Read:

- candidate records from `integrable-lattice/outputs/candidates/`
- verification records or notes
- `integrable-lattice/docs/schemas.md`

## Workflow

1. Exclude candidates marked solved, ill-defined, or counterexample unless the task is to turn them into a negative result.
2. Score each remaining candidate on:
   - novelty
   - proof feasibility
   - finite-symbol clarity
   - small-case experimentability
   - literature risk
   - paper scope
3. Prefer candidates with a clear known anchor and a single explainable generalization.
4. Group related candidates into possible paper bundles.
5. Emit both a ranking and a short reason for each rank.
6. Promote strong bundles into `integrable-lattice/outputs/paper-plans/`.

## Output Shape

```yaml
candidate_id:
rank_bucket: high | medium | low | discard
novelty:
proof_feasibility:
finite_symbol_clarity:
experimentability:
literature_risk:
paper_scope:
recommended_next_step:
paper_bundle:
notes:
```

## Guardrails

- Do not rank by excitement alone. Tie every score to evidence.
- Do not overvalue broad candidates; paper-sized specificity is better.
- When several weak candidates share a proof method, propose a bundle rather than discarding them individually.

