# Query Log: rsos_character_identity

## Scope

First-pass (cycle 0, thin) harvest for RSOS / ABF / face-model character-identity cells around:

- finitized Virasoro characters of unitary minimal models M(ν,ν+1) (ABF regime III/IV)
- finitized characters of non-unitary Forrester-Baxter minimal models M(p,p')
- boson = fermion polynomial (q-) identities and corner-transfer-matrix configuration sums
- Bailey pair / Bailey lemma constructions of character identities
- branching functions of su(2) coset models as finite fermionic forms
- higher-rank / affine A_{n-1}^{(1)} one-dimensional configuration sums and affine Lie algebra characters
- root-of-unity / representation-theoretic (Hecke, Jantzen-Seitz) descriptions of RSOS spaces

Off-critical elliptic weights and full TBA/dilogarithm asymptotics are only coarsely touched in this first pass; the anchored cells are the finite q-polynomial (finitized character) identities.

## Seed Queries Used

```text
"RSOS model" finitized Virasoro character fermionic bosonic polynomial identity arXiv
"one-dimensional configuration sums" RSOS branching functions Date Jimbo Kuniba Miwa Okado
"Bailey pair" "Bailey lemma" Rogers-Ramanujan RSOS character identity Foda Quano arXiv
"Fermionic counting of RSOS-states" Virasoro character "unitary minimal" Berkovich
"Forrester-Baxter" finitized character boson fermion polynomial identity
"branching functions" "su(2)" coset fermionic form polynomial supernomial
"A-D-E" polynomial Rogers-Ramanujan identity RSOS character
```

## Noisy / Deferred Queries

```text
"elliptic" RSOS one-point function off-critical regime III configuration sum
"dilogarithm" TBA central charge RSOS character asymptotics
"eight-vertex SOS" elliptic Boltzmann weight character
```

These are deferred: they pull toward off-critical elliptic / asymptotic analysis rather than the finite q-polynomial character-identity cells that the current anchors directly support.

## Harvest Decision

Save a small curated metadata file (`inputs/corpus/002_rsos_character_identity.md`) rather than a bulk corpus. Per cycle 0 (thin), records carry only retrieval facts and coarse relevance; novelty is not judged here. Next step is a thin gap map, not full-text extraction. Several venue/author attributions are marked `verify` and must not be hardened until a later cycle.
