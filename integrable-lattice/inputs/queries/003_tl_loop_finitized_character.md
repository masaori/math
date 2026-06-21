# Query Log: tl_loop_finitized_character

## Scope

First-pass (cycle 0, thin) harvest for Temperley-Lieb / dense-loop finitized-character cells around:

- finitized Kac characters of logarithmic minimal models LM(p,p') on the strip (link-state sectors)
- critical dense polymers (principal series LM(1,2)) finite-strip spectra
- boundary-sector finitized characters: Robin / Neveu-Schwarz / Ramond, extended Kac labels, defects
- one-boundary / two-boundary Temperley-Lieb and blob-algebra link-state sectors
- boundary loop-model correlation combinatorics (O(1) loop, qKZ) as finite-symbol input
- TL algebra relation + quantum-group/root-of-unity structure as anchors

Full continuum logarithmic-CFT analysis and pure asymptotic free energies are only coarsely touched; the anchored cells are the finite-size (finitized) character polynomials and the TL/blob link-state algebra.

## Seed Queries Used

```text
Temperley-Lieb dense loop model logarithmic minimal model finitized character finite-size spectrum Pearce arXiv
blob algebra boundary Temperley-Lieb loop model link states character generating function arXiv
"critical dense polymers" finitized character strip Robin boundary Kac label
"logarithmic minimal models" link state transfer matrix finitized Kac character
```

## Noisy / Deferred Queries

```text
"logarithmic conformal field theory" indecomposable module fusion (continuum-only)
"O(n) loop model" Coulomb gas critical exponent (non-finite-symbol)
```

These are deferred: they pull toward continuum LCFT / Coulomb-gas asymptotics rather than the finite-size character polynomials and TL/blob link-state cells the current anchors support.

## Harvest Decision

Save a small curated metadata file (`inputs/corpus/003_tl_loop_finitized_character.md`). Per cycle 0 (thin), records carry retrieval facts + coarse relevance only. Several arxiv_id / venue / author fields are marked `verify` and must be confirmed in a later cycle. Next step is a thin gap map.
