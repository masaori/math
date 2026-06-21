# Corpus: rsos_character_identity

## Scope

Curated first-pass (cycle 0, thin) metadata for character-identity and finitized-character results around RSOS / ABF / face models.

This is raw material for a thin `outputs/maps/00X_rsos_character_identity_seed_map.md`. Do not treat `not included here` as `open`; this corpus only covers the first anchored slice. Per harvest guardrails, entries record retrieval facts and coarse relevance only; novelty is not judged. Fields marked `verify` (venue, year, attribution) are unhardened and must be confirmed in a later cycle before any bibliography use.

## Coverage Axes

- `unitary_minimal_finitized`: finitized Virasoro characters of unitary minimal M(ν,ν+1) (ABF regime), boson=fermion finite identities.
- `nonunitary_forrester_baxter`: finitized characters of non-unitary Forrester-Baxter M(p,p') models.
- `bailey_construction`: Bailey pair / (higher-level) Bailey lemma routes from RSOS paths to character identities.
- `branching_coset`: finite fermionic/bosonic forms for su(2)_M × su(2)_N / su(2)_{M+N} branching functions.
- `rank_affine_generalization`: A_{n-1}^{(1)} (higher rank / affine) one-dimensional configuration sums and affine Lie algebra characters.
- `representation_root_of_unity`: Hecke / Jantzen-Seitz / quantum-group descriptions of RSOS state spaces at roots of unity.

## Records

```yaml
id: andrews-baxter-forrester-1984-rsos
title: Eight-vertex SOS model and generalized Rogers-Ramanujan-type identities
authors: [G. E. Andrews, R. J. Baxter, P. J. Forrester]
year: 1984
source: Journal of Statistical Physics 35(3-4), 193-266
arxiv_id:
doi: 10.1007/BF01014383
url: https://doi.org/10.1007/BF01014383
abstract: Solves the eight-vertex SOS (ABF) model via corner transfer matrices; local height probabilities give Rogers-Ramanujan-type character/q-series identities.
model_hints: [RSOS, ABF, eight-vertex SOS, hard-hexagon]
operation_hints: [corner_transfer_matrix, character_identity, q_series_identity, star_triangle]
source_available: doi_metadata
coverage_axis: [unitary_minimal_finitized]
metadata_sources: [canonical-papers]
notes: Primary RSOS/ABF anchor; base solved cell for character identities.
```

```yaml
id: forrester-baxter-1985-further-rsos
title: Further exact solutions of the eight-vertex SOS model and generalizations of the Rogers-Ramanujan identities
authors: [P. J. Forrester, R. J. Baxter]
year: 1985
source: Journal of Statistical Physics 38, 435-472
arxiv_id:
doi: 10.1007/BF01010471
url: https://doi.org/10.1007/BF01010471
abstract: Extends ABF to the full M(p,p') family; configuration sums give generalized Rogers-Ramanujan / Virasoro-character q-series.
model_hints: [RSOS, eight-vertex SOS, non-unitary minimal]
operation_hints: [character_identity, q_series_identity, corner_transfer_matrix]
source_available: doi_metadata
coverage_axis: [nonunitary_forrester_baxter, unitary_minimal_finitized]
metadata_sources: [canonical-papers]
notes: Anchor for the non-unitary M(p,p') character cells.
```

```yaml
id: jimbo-miwa-okado-1988-local-state-probabilities
title: "Local state probabilities of solvable lattice models: An A_{n-1}^{(1)} family"
authors: [M. Jimbo, T. Miwa, M. Okado]
year: 1988
source: Nuclear Physics B 300, 74-108
arxiv_id:
doi: 10.1016/0550-3213(88)90587-1
url: https://doi.org/10.1016/0550-3213(88)90587-1
abstract: Computes local state probabilities / branching functions for the A_{n-1}^{(1)} face-model family, giving higher-rank character cells.
model_hints: [IRF, RSOS, A_n affine]
operation_hints: [character_identity, local_state_probability, branching_function]
source_available: doi_metadata
coverage_axis: [rank_affine_generalization]
metadata_sources: [canonical-papers]
notes: Anchor for rank / affine-type generalization of character cells.
```

```yaml
id: melzer-1994-fermionic-character-sums
title: Fermionic Character Sums and the Corner Transfer Matrix
authors: [Ezer Melzer]
year: 1994
source: International Journal of Modern Physics A 9(7), 1115-1136
arxiv_id: hep-th/9305114
doi: 10.1142/S0217751X94000510
url: https://arxiv.org/abs/hep-th/9305114
abstract: Proposes a natural finitization of fermionic q-series conjectured to equal Virasoro characters and CTM configuration sums of the ABF/RSOS model (Melzer polynomial identities).
model_hints: [RSOS, ABF, Virasoro minimal model]
operation_hints: [finitized_character, q_series_identity, corner_transfer_matrix]
source_available: arxiv_source
coverage_axis: [unitary_minimal_finitized]
metadata_sources: [canonical-papers, arXiv]
notes: Anchor; the finitized-character (boson=fermion) template for candidate generation.
```

```yaml
id: warnaar-1995-abf-melzer-polynomial-identities
title: "Fermionic solution of the Andrews-Baxter-Forrester model II: proof of Melzer's polynomial identities"
authors: [S. O. Warnaar]
year: 1996
source: Journal of Statistical Physics 84(1-2), 49-83
arxiv_id: hep-th/9508079
doi: 10.1007/BF02179577
url: https://arxiv.org/abs/hep-th/9508079
abstract: Proves Melzer's finitized-character polynomial identities via one-dimensional configuration sums / recurrences for the ABF model.
model_hints: [ABF, RSOS, Virasoro minimal model]
operation_hints: [configuration_sum, finitized_character, q_series_identity]
source_available: arxiv_source
coverage_axis: [unitary_minimal_finitized]
metadata_sources: [canonical-papers, arXiv]
notes: Anchor; turns RSOS path sums into proven finite identities.
```

```yaml
id: berkovich-1994-fermionic-counting-rsos
title: "Fermionic counting of RSOS-states and Virasoro character formulas for the unitary minimal series M(nu, nu+1). Exact results"
authors: [Alexander Berkovich]
year: 1994
source: Nuclear Physics B 431, 315-348
arxiv_id: hep-th/9403073
doi: 10.1016/0550-3213(94)90108-2
url: https://arxiv.org/abs/hep-th/9403073
abstract: Counts RSOS states fermionically and proves boson=fermion Virasoro character formulas for the unitary minimal series M(nu,nu+1).
model_hints: [RSOS, Virasoro minimal model]
operation_hints: [finitized_character, fermionic_sum, character_identity]
source_available: arxiv_source
coverage_axis: [unitary_minimal_finitized]
metadata_sources: [web_search, arXiv]
notes: Companion proof line to Warnaar for the unitary series. doi verify.
```

```yaml
id: foda-welsh-1995-combinatorics-forrester-baxter
title: On the Combinatorics of Forrester-Baxter Models
authors: [Omar Foda, Trevor A. Welsh]
year: 1995
source: "Physical Combinatorics (Progress in Mathematics 191), Birkhauser; Univ. Melbourne preprint"
arxiv_id: hep-th/9408086
doi:
url: https://arxiv.org/abs/hep-th/9408086
abstract: Derives boson-fermion q-polynomial identities for the finitized Virasoro characters of the (non-unitary) Forrester-Baxter minimal models from weighted lattice paths.
model_hints: [RSOS, Forrester-Baxter, non-unitary minimal]
operation_hints: [finitized_character, lattice_path, q_series_identity]
source_available: arxiv_source
coverage_axis: [nonunitary_forrester_baxter]
metadata_sources: [web_search, arXiv]
notes: Extends finitized-character identities to all M(p,p'). arxiv_id/venue verify.
```

```yaml
id: welsh-2005-fermionic-expressions-minimal
title: Fermionic expressions for minimal model Virasoro characters
authors: [Trevor A. Welsh]
year: 2005
source: Memoirs of the American Mathematical Society 175(827)
arxiv_id: math/0212154
doi: 10.1090/memo/0827
url: https://arxiv.org/abs/math/0212154
abstract: States and proves fermionic expressions for all minimal model Virasoro characters, with finitized (polynomial) versions from Forrester-Baxter paths.
model_hints: [RSOS, Forrester-Baxter, Virasoro minimal model]
operation_hints: [finitized_character, fermionic_sum, q_series_identity]
source_available: arxiv_source
coverage_axis: [nonunitary_forrester_baxter, unitary_minimal_finitized]
metadata_sources: [web_search, arXiv]
notes: Most complete proof of fermionic forms for all minimal characters. doi verify.
```

```yaml
id: foda-quano-1996-virasoro-character-bailey
title: Virasoro character identities from the Andrews-Bailey construction
authors: [Omar Foda, Yas-Hiro Quano]
year: 1996
source: International Journal of Modern Physics A 12, 1651-1675
arxiv_id: hep-th/9408086
doi: 10.1142/S0217751X97001146
url: https://doi.org/10.1142/S0217751X97001146
abstract: Uses Bailey-pair / Andrews-Bailey machinery to derive Virasoro (RSOS) character identities, an alternative to CTM configuration sums.
model_hints: [RSOS, Virasoro minimal model]
operation_hints: [bailey_pair, bailey_lemma, character_identity, q_series_identity]
source_available: doi_metadata
coverage_axis: [bailey_construction]
metadata_sources: [web_search]
notes: Bailey-construction route. arxiv_id is a placeholder collision; arxiv_id/year/venue verify.
```

```yaml
id: berkovich-mccoy-schilling-1998-branching-fermionic-forms
title: "Polynomial Fermionic Forms for the Branching Functions of the Rational Coset Conformal Field Theories su(2)_M x su(2)_N / su(2)_{M+N}"
authors: [Alexander Berkovich, Barry M. McCoy, Anne Schilling]
year: 1996
source: Nuclear Physics B 480, 397-409
arxiv_id: hep-th/9508050
doi: 10.1016/S0550-3213(96)00455-8
url: https://arxiv.org/abs/hep-th/9508050
abstract: Gives polynomial (finite) fermionic forms for su(2) coset branching functions, generalizing minimal-model finitized characters to higher level / coset cells.
model_hints: [RSOS, coset model, su(2) WZW]
operation_hints: [branching_function, finitized_character, fermionic_sum]
source_available: arxiv_source
coverage_axis: [branching_coset]
metadata_sources: [web_search, arXiv]
notes: Coset-level extension of the character-identity cells. doi/year verify.
```

```yaml
id: schilling-warnaar-1998-supernomial-branching
title: Multinomials and Polynomial Bosonic Forms for the Branching Functions of the su(2)_M x su(2)_N / su(2)_{M+N} Conformal Coset Models
authors: [Anne Schilling, S. Ole Warnaar]
year: 1997
source: Nuclear Physics B 508, 487-512
arxiv_id: hep-th/9510168
doi: 10.1016/S0550-3213(97)80021-1
url: https://arxiv.org/abs/hep-th/9510168
abstract: Constructs bosonic (multinomial / supernomial) polynomial forms for the same su(2) coset branching functions, the boson side of the coset finitized identities.
model_hints: [RSOS, coset model, su(2) WZW]
operation_hints: [branching_function, supernomial, bosonic_form, q_series_identity]
source_available: arxiv_source
coverage_axis: [branching_coset]
metadata_sources: [web_search, arXiv]
notes: Boson-side partner to berkovich-mccoy-schilling. doi/year verify.
```

```yaml
id: date-jimbo-kuniba-miwa-okado-1989-config-sums
title: One-dimensional configuration sums in vertex models and affine Lie algebra characters
authors: [E. Date, M. Jimbo, A. Kuniba, T. Miwa, M. Okado]
year: 1989
source: Letters in Mathematical Physics 17, 69-77
arxiv_id:
doi: 10.1007/BF00420015
url: https://doi.org/10.1007/BF00420015
abstract: Identifies one-dimensional configuration sums of RSOS/vertex models with affine Lie algebra (string-function/branching) characters, giving the rank/affine character cells.
model_hints: [RSOS, vertex model, affine Lie algebra]
operation_hints: [configuration_sum, character_identity, branching_function]
source_available: doi_metadata
coverage_axis: [rank_affine_generalization]
metadata_sources: [web_search]
notes: Anchor-strength for affine-character / higher-rank cells. doi verify.
```

```yaml
id: foda-leclerc-okado-thibon-welsh-rsos-jantzen-seitz
title: RSOS Models and Jantzen-Seitz Representations of Hecke Algebras at Roots of Unity
authors: [O. Foda, B. Leclerc, M. Okado, J.-Y. Thibon, T. Welsh]
year: 1998
source: Letters in Mathematical Physics 43, 273-292
arxiv_id: q-alg/9706018
doi: 10.1023/A:1007316705535
url: https://arxiv.org/abs/q-alg/9706018
abstract: Relates RSOS path/state spaces to Jantzen-Seitz representations of Hecke algebras at roots of unity, a representation-theoretic description of the character cells.
model_hints: [RSOS, Hecke algebra, root of unity]
operation_hints: [representation_theory, character_identity, crystal_basis]
source_available: arxiv_source
coverage_axis: [representation_root_of_unity]
metadata_sources: [web_search]
notes: Representation/root-of-unity axis. authors/arxiv_id/year verify.
```

## Immediate Map Hints

- `known`: finitized Virasoro characters of unitary minimal M(ν,ν+1) (boson=fermion) — Melzer conjecture proved by Warnaar / Berkovich; non-unitary M(p,p') finitized characters — Forrester-Baxter, Foda-Welsh, Welsh; su(2) coset branching functions as finite fermionic+bosonic forms; A_{n-1}^{(1)} configuration sums = affine characters (JMO, DJKMO).
- `needs_review`: Bailey-construction derivations (Foda-Quano) — overlap vs CTM route to be checked; root-of-unity / Hecke (Jantzen-Seitz) description — relation to character identities to be confirmed.
- `unknown_candidate_source`: finitized-character identities for boundary/defect-modified RSOS (open / integrable boundary configuration sums); higher-rank (A_{n-1}^{(1)}, n>2) finitized boson=fermion polynomial identities beyond level-1; coset branching finitizations outside su(2)_M × su(2)_N.
- `not_in_scope_yet`: off-critical elliptic SOS one-point functions; TBA/dilogarithm asymptotic (non-finite) character limits.
