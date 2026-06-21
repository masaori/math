# Query Log: dimer_pfaffian_boundary

## Scope

First-pass (cycle 0, thin) harvest for dimer / Pfaffian finite-domain & boundary cells around:

- square-lattice dimer Pfaffian / determinant (Kasteleyn, Temperley-Fisher, Fisher)
- planar-graph Pfaffian orientation (general graph class)
- finite-domain exact enumeration (Aztec diamond, domino tilings) as determinant/product formulas
- boundary defects / weighted finite domains / free (Robin) boundary dimers
- finite-region dimer correlations via the inverse Kasteleyn matrix

Continuum scaling-limit (massive holomorphicity, SLE, arctic-curve analysis) is only coarsely touched; the anchored cells are the finite-symbol Pfaffian/determinant enumeration and inverse-Kasteleyn correlation formulas.

## Seed Queries Used

```text
dimer model Pfaffian Kasteleyn finite domain boundary Aztec diamond exact enumeration determinant arXiv
dimer boundary correlations inverse Kasteleyn matrix finite region Temperley bijection spanning tree arXiv
"Aztec diamond" "domino tilings" alternating sign matrices determinant product formula
"free boundary" dimers Kasteleyn finite region correlation
```

## Noisy / Deferred Queries

```text
"massive SLE" near-critical dimers scaling limit (continuum-only)
"imaginary geometry" dimers (continuum-only)
"doubly periodic" Aztec dimer spectral curve (asymptotic-only)
```

These are deferred: they pull toward continuum/scaling-limit analysis rather than the finite-symbol Pfaffian/determinant enumeration and finite-region correlation cells.

## Harvest Decision

Save a small curated metadata file (`inputs/corpus/004_dimer_pfaffian_boundary.md`). Per cycle 0 (thin), records carry retrieval facts + coarse relevance only; several arxiv_id / venue / author fields are marked `verify`. Next step is a thin gap map.
