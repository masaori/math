# Corpus: tl_loop_finitized_character

## Scope

Curated first-pass (cycle 0, thin) metadata for Temperley-Lieb / dense-loop finitized-character and link-state-algebra results.

This is raw material for a thin `outputs/maps/00X_tl_loop_finitized_character_seed_map.md`. Do not treat `not included here` as `open`. Entries record retrieval facts + coarse relevance only; novelty is not judged. Fields marked `verify` (arxiv_id, venue, year, attribution) are unhardened.

## Coverage Axes

- `strip_finitized_character`: LM(p,p') finitized Kac characters on the strip; critical dense polymers finite-strip spectra.
- `boundary_sector_character`: Robin / NS-R / extended-Kac-label / defect boundary finitized characters.
- `boundary_tl_algebra`: one-/two-boundary TL and blob algebra, link-state sectors / representation theory.
- `loop_correlation_combinatorics`: boundary correlations of dense loop models, O(1) loop / qKZ combinatorics.
- `tl_relation_anchor`: original TL algebra + transfer matrix; quantum-group / root-of-unity structure.
- `loop_critical_context`: O(n) loop critical-point context (weak, non-finite-symbol).

## Records

```yaml
id: temperley-lieb-1971-percolation-colouring
title: "Relations between the percolation and colouring problem ...: some exact results for the percolation problem"
authors: [H. N. V. Temperley, E. H. Lieb]
year: 1971
source: Proc. R. Soc. Lond. A 322, 251-280
arxiv_id:
doi: 10.1098/rspa.1971.0067
url: https://doi.org/10.1098/rspa.1971.0067
abstract: Introduces the Temperley-Lieb algebra relations and transfer-matrix equivalences for planar lattice models.
model_hints: [Temperley-Lieb algebra, planar lattice, ice-type model]
operation_hints: [algebra_relation, transfer_matrix, temperley_lieb_relation]
source_available: doi_metadata
coverage_axis: [tl_relation_anchor]
metadata_sources: [canonical-papers]
notes: Anchor: original TL relation / transfer-matrix algebra.
```

```yaml
id: pasquier-saleur-1990-quantum-groups
title: Common structures between finite systems and conformal field theories through quantum groups
authors: [V. Pasquier, H. Saleur]
year: 1990
source: Nuclear Physics B 330(2-3), 523-556
arxiv_id:
doi: 10.1016/0550-3213(90)90122-t
url: https://doi.org/10.1016/0550-3213(90)90122-t
abstract: Relates finite TL/loop spin chains to CFT via quantum groups at roots of unity, including character/representation truncation.
model_hints: [finite integrable lattice, quantum group, root of unity, Temperley-Lieb]
operation_hints: [quantum_group_relation, representation_truncation, character_identity]
source_available: doi_metadata
coverage_axis: [tl_relation_anchor, boundary_tl_algebra]
metadata_sources: [canonical-papers]
notes: Anchor: root-of-unity representation structure of TL/loop chains.
```

```yaml
id: nienhuis-1982-on-loop
title: Exact critical point and critical exponents of O(n) models in two dimensions
authors: [B. Nienhuis]
year: 1982
source: Physical Review Letters 49(15), 1062-1065
arxiv_id:
doi: 10.1103/PhysRevLett.49.1062
url: https://doi.org/10.1103/PhysRevLett.49.1062
abstract: Gives the exact critical point and exponents of 2D O(n) loop models via Coulomb gas.
model_hints: [O(n) loop model, honeycomb loop model]
operation_hints: [coulomb_gas, critical_point, loop_model]
source_available: doi_metadata
coverage_axis: [loop_critical_context]
metadata_sources: [canonical-papers]
notes: Weak context anchor; not a finite-symbol identity.
```

```yaml
id: pearce-rasmussen-zuber-2006-logarithmic-minimal
title: Logarithmic minimal models
authors: [P. A. Pearce, J. Rasmussen, J.-B. Zuber]
year: 2006
source: "J. Stat. Mech. (2006) P11017"
arxiv_id: hep-th/0607232
doi: 10.1088/1742-5468/2006/11/P11017
url: https://arxiv.org/abs/hep-th/0607232
abstract: Builds Yang-Baxter integrable TL models LM(p,p') on the strip acting on link states; Hamiltonian limits give logarithmic CFTs and finitized Kac characters.
model_hints: [Temperley-Lieb loop model, logarithmic minimal model, dense loop model]
operation_hints: [yang_baxter, temperley_lieb_relation, transfer_matrix, finitized_character]
source_available: arxiv_source
coverage_axis: [strip_finitized_character, tl_relation_anchor]
metadata_sources: [canonical-papers, arXiv]
notes: Anchor: LM(p,p') finitized Kac characters on the strip / link-state sectors.
```

```yaml
id: pearce-rasmussen-2007-critical-dense-polymers
title: Solvable Critical Dense Polymers
authors: [Paul A. Pearce, Jorgen Rasmussen]
year: 2007
source: "J. Stat. Mech. (2007) P02015"
arxiv_id: hep-th/0610273
doi: 10.1088/1742-5468/2007/02/P02015
url: https://arxiv.org/abs/hep-th/0610273
abstract: Solves critical dense polymers (first principal LM(1,2)) exactly on finite strips; defect sectors via extended Kac label s; finite-size corrections from Euler-Maclaurin.
model_hints: [critical dense polymers, Temperley-Lieb loop model, logarithmic minimal model]
operation_hints: [transfer_matrix, finitized_character, link_state, functional_equation]
source_available: arxiv_source
coverage_axis: [strip_finitized_character, boundary_sector_character]
metadata_sources: [web_search, arXiv]
notes: Cleanest worked example of finitized characters in extended-Kac defect sectors. doi verify.
```

```yaml
id: pearce-villani-2014-critical-dense-polymers-robin
title: "Critical dense polymers with Robin boundary conditions, half-integer Kac labels and Z4 fermions"
authors: [Paul A. Pearce, Alessandra Vittorini-Orgeas]
year: 2014
source: arXiv preprint / J. Stat. Mech.
arxiv_id: 1405.0550
doi:
url: https://arxiv.org/abs/1405.0550
abstract: Obtains finitized characters for critical dense polymers with Robin boundary conditions, related to Z4-fermion coinvariant spaces, via patterns-of-zeros classification of double-row transfer-matrix eigenvalues.
model_hints: [critical dense polymers, Temperley-Lieb, Robin boundary]
operation_hints: [finitized_character, double_row_transfer_matrix, patterns_of_zeros]
source_available: arxiv_source
coverage_axis: [boundary_sector_character, strip_finitized_character]
metadata_sources: [web_search, arXiv]
notes: Boundary-sector (Robin / half-integer Kac) finitized characters. authors/venue verify.
```

```yaml
id: pearce-tartaglia-2014-logarithmic-superconformal
title: Logarithmic Superconformal Minimal Models
authors: [Paul A. Pearce, Elena Tartaglia, ...]
year: 2014
source: arXiv preprint / J. Stat. Mech.
arxiv_id: 1312.6763
doi:
url: https://arxiv.org/abs/1312.6763
abstract: Studies finite-size strip spectra in NS/Ramond sectors and proposes finitized Kac character formulas for logarithmic superconformal minimal models.
model_hints: [logarithmic superconformal minimal model, Temperley-Lieb, fused loop model]
operation_hints: [finitized_character, transfer_matrix, fusion_relation]
source_available: arxiv_source
coverage_axis: [boundary_sector_character, strip_finitized_character]
metadata_sources: [web_search, arXiv]
notes: NS/R-sector finitized Kac characters; touches fused-TL variants. authors/venue verify.
```

```yaml
id: martin-saleur-1994-blob-algebra
title: The blob algebra and the periodic Temperley-Lieb algebra
authors: [P. P. Martin, H. Saleur]
year: 1994
source: Letters in Mathematical Physics 30, 189-206
arxiv_id: hep-th/9302094
doi: 10.1007/BF00805852
url: https://arxiv.org/abs/hep-th/9302094
abstract: Introduces the blob algebra (one-boundary TL) and periodic TL for boundary statistical-mechanics models; representation structure for boundary link states.
model_hints: [Temperley-Lieb, blob algebra, periodic TL, loop model]
operation_hints: [algebra_relation, representation_theory, link_state]
source_available: arxiv_source
coverage_axis: [boundary_tl_algebra]
metadata_sources: [web_search, arXiv]
notes: Anchor for boundary link-state sectors (blob = one-boundary TL). doi verify.
```

```yaml
id: degier-nichols-2009-one-boundary-tl
title: One-boundary Temperley-Lieb algebras in the XXZ and loop models
authors: [Jan de Gier, Alexander Nichols]
year: 2009
source: Journal of Algebra 321(4), 1132-1167
arxiv_id: math/0703338
doi: 10.1016/j.jalgebra.2008.10.023
url: https://arxiv.org/abs/math/0703338
abstract: Representation theory of the one-boundary TL (blob) algebra and its role in boundary XXZ / loop models and link-state sectors.
model_hints: [Temperley-Lieb, blob algebra, XXZ, loop model]
operation_hints: [algebra_relation, representation_theory, link_state]
source_available: arxiv_source
coverage_axis: [boundary_tl_algebra]
metadata_sources: [web_search, arXiv]
notes: Boundary-sector representation structure. arxiv_id/venue verify.
```

```yaml
id: jacobsen-saleur-2008-conformal-boundary-loop
title: Conformal boundary loop models
authors: [Jesper L. Jacobsen, Hubert Saleur]
year: 2008
source: Nuclear Physics B 788, 137-166
arxiv_id: math-ph/0611078
doi: 10.1016/j.nuclphysb.2007.06.029
url: https://arxiv.org/abs/math-ph/0611078
abstract: Classifies conformal boundary conditions of dense loop models and the corresponding boundary (blob) sectors and spectra.
model_hints: [dense loop model, Temperley-Lieb, blob algebra, boundary CFT]
operation_hints: [boundary_condition, character_identity, transfer_matrix]
source_available: arxiv_source
coverage_axis: [boundary_tl_algebra, boundary_sector_character]
metadata_sources: [web_search, arXiv]
notes: Bridges boundary TL/blob sectors to boundary spectra. doi/year verify.
```

```yaml
id: morin-duchesne-saleur-2018-two-point-boundary-loop
title: Two-point boundary correlation functions of dense loop models
authors: [Alexi Morin-Duchesne, Hubert Saleur, ...]
year: 2018
source: SciPost / arXiv preprint
arxiv_id: 1712.08657
doi:
url: https://arxiv.org/abs/1712.08657
abstract: Computes two-point boundary correlation functions of dense loop models using one-boundary TL / blob algebra and conformal characters.
model_hints: [dense loop model, Temperley-Lieb, blob algebra]
operation_hints: [boundary_correlation, character_identity, link_state]
source_available: arxiv_source
coverage_axis: [loop_correlation_combinatorics, boundary_tl_algebra]
metadata_sources: [web_search, arXiv]
notes: Finite-symbol boundary observables on the loop side. authors/venue verify.
```

## Immediate Map Hints

- `known`: LM(p,p') finitized Kac characters on the strip (Pearce-Rasmussen-Zuber); critical dense polymers finite-strip finitized characters incl. extended-Kac defect sectors (Pearce-Rasmussen); one-/two-boundary TL & blob algebra link-state representation theory (Martin-Saleur, de Gier-Nichols); conformal boundary loop sectors (Jacobsen-Saleur).
- `needs_review`: Robin / half-integer-Kac and NS-R superconformal finitized characters (Pearce et al, recent, attribution verify) — coverage vs standard Kac characters to be checked; two-point boundary loop correlations as finite-symbol identities.
- `unknown_candidate_source`: finitized characters in two-boundary / blob sectors with general boundary parameters; fused-TL (higher fusion level) finitized characters beyond superconformal; finitized boundary correlation determinants/formulas on the loop side.
- `not_in_scope_yet`: continuum LCFT indecomposable-module fusion; O(n) Coulomb-gas asymptotics.
