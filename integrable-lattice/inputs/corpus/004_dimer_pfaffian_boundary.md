# Corpus: dimer_pfaffian_boundary

## Scope

Curated first-pass (cycle 0, thin) metadata for dimer / Pfaffian finite-domain and boundary results.

This is raw material for a thin `outputs/maps/00X_dimer_pfaffian_boundary_seed_map.md`. Do not treat `not included here` as `open`. Entries record retrieval facts + coarse relevance only; novelty is not judged. Fields marked `verify` are unhardened.

## Coverage Axes

- `square_lattice_pfaffian`: square-lattice dimer Pfaffian/determinant (Kasteleyn, Temperley-Fisher, Fisher).
- `planar_graph_pfaffian`: general planar-graph Pfaffian orientation.
- `finite_domain_enumeration`: Aztec diamond / domino-tiling exact product & determinant formulas.
- `boundary_defect_weighted`: boundary defects, weighted finite domains, free/Robin boundary dimers.
- `local_correlations_inverse_kasteleyn`: finite-region dimer correlations via inverse Kasteleyn matrix.

## Records

```yaml
id: kasteleyn-1961-dimers
title: The statistics of dimers on a lattice. I. The number of dimer arrangements on a quadratic lattice
authors: [P. W. Kasteleyn]
year: 1961
source: Physica 27(12), 1209-1225
arxiv_id:
doi: 10.1016/0031-8914(61)90063-5
url: https://doi.org/10.1016/0031-8914(61)90063-5
abstract: Counts dimer coverings of a finite quadratic lattice as a Pfaffian/determinant of a signed adjacency (Kasteleyn) matrix.
model_hints: [square lattice dimer]
operation_hints: [pfaffian_formula, kasteleyn_orientation, determinant_formula]
source_available: doi_metadata
coverage_axis: [square_lattice_pfaffian]
metadata_sources: [canonical-papers]
notes: Anchor: square-lattice dimer Pfaffian known cell.
```

```yaml
id: temperley-fisher-1961-dimer
title: Dimer problem in statistical mechanics - an exact result
authors: [H. N. V. Temperley, M. E. Fisher]
year: 1961
source: Philosophical Magazine 6(68), 1061-1063
arxiv_id:
doi: 10.1080/14786436108243366
url: https://doi.org/10.1080/14786436108243366
abstract: Exact enumeration of square-lattice dimers via determinant methods (parallel to Kasteleyn).
model_hints: [square lattice dimer]
operation_hints: [exact_formula, determinant_formula]
source_available: doi_metadata
coverage_axis: [square_lattice_pfaffian]
metadata_sources: [canonical-papers]
notes: Anchor; FKT lineage with Kasteleyn.
```

```yaml
id: fisher-1961-plane-lattice-dimers
title: Statistical Mechanics of Dimers on a Plane Lattice
authors: [M. E. Fisher]
year: 1961
source: Physical Review 124, 1664-1672
arxiv_id:
doi: 10.1103/PhysRev.124.1664
url: https://doi.org/10.1103/PhysRev.124.1664
abstract: Finite plane-lattice dimer exact formula; boundary/shape dependence of the determinant.
model_hints: [plane lattice dimer, square lattice dimer]
operation_hints: [exact_formula, determinant_formula]
source_available: doi_metadata
coverage_axis: [square_lattice_pfaffian, finite_domain_enumeration]
metadata_sources: [canonical-papers]
notes: Anchor; finite-domain shape variations.
```

```yaml
id: kasteleyn-1967-graph-theory-crystal-physics
title: Graph theory and crystal physics
authors: [P. W. Kasteleyn]
year: 1967
source: "Graph Theory and Theoretical Physics (ed. F. Harary), Academic Press, 43-110"
arxiv_id:
doi:
url: https://cir.nii.ac.jp/crid/1574231875423659392
abstract: Extends Pfaffian-orientation dimer enumeration to general planar graphs.
model_hints: [planar graph dimer, Pfaffian orientation]
operation_hints: [pfaffian_formula, pfaffian_orientation, planar_graph]
source_available: metadata_page
coverage_axis: [planar_graph_pfaffian]
metadata_sources: [canonical-papers]
notes: Anchor: planar-graph Pfaffian orientation.
```

```yaml
id: kenyon-1997-local-statistics-dimers
title: Local statistics of lattice dimers
authors: [Richard Kenyon]
year: 1997
source: Annales de l'I.H.P. Probabilites et statistiques 33(5), 591-618
arxiv_id:
doi:
url: https://eudml.org/doc/77583
abstract: Computes local dimer statistics from the (inverse) Kasteleyn matrix; finite-region correlations as minors/Pfaffians of the inverse Kasteleyn matrix.
model_hints: [lattice dimer, planar graph dimer]
operation_hints: [kasteleyn_matrix, inverse_matrix, local_statistics, pfaffian_formula]
source_available: journal_page
coverage_axis: [local_correlations_inverse_kasteleyn]
metadata_sources: [canonical-papers]
notes: Anchor: inverse-Kasteleyn correlation cell.
```

```yaml
id: elkies-kuperberg-larsen-propp-1992-aztec
title: Alternating-sign matrices and domino tilings
authors: [Noam Elkies, Greg Kuperberg, Michael Larsen, James Propp]
year: 1992
source: Journal of Algebraic Combinatorics 1, 111-132 & 219-234
arxiv_id:
doi: 10.1023/A:1022420103267
url: https://doi.org/10.1023/A:1022420103267
abstract: Proves the Aztec diamond theorem: the number of domino tilings of the order-n Aztec diamond is 2^{n(n+1)/2}, with several finite-symbol (determinant/product) proofs.
model_hints: [Aztec diamond, domino tilings, dimer]
operation_hints: [exact_formula, determinant_formula, enumeration]
source_available: doi_metadata
coverage_axis: [finite_domain_enumeration]
metadata_sources: [web_search]
notes: Foundational finite-domain enumeration cell (Aztec). doi verify.
```

```yaml
id: kenyon-2003-introduction-dimer-model
title: An introduction to the dimer model
authors: [Richard Kenyon]
year: 2003
source: arXiv preprint (lecture notes)
arxiv_id: math/0310326
doi:
url: https://arxiv.org/abs/math/0310326
abstract: Lecture notes on the dimer model: Kasteleyn theory, partition functions as determinants, inverse Kasteleyn correlations, finite-domain examples.
model_hints: [lattice dimer, planar graph dimer, Aztec diamond]
operation_hints: [pfaffian_formula, determinant_formula, inverse_matrix]
source_available: arxiv_source
coverage_axis: [square_lattice_pfaffian, local_correlations_inverse_kasteleyn, finite_domain_enumeration]
metadata_sources: [web_search, arXiv]
notes: Survey anchor tying the finite-symbol cells together.
```

```yaml
id: giuliani-mastropietro-toninelli-2017-exact-2d-dimer
title: "Exact solution of the 2d dimer model: corner free energy, correlation functions and combinatorics"
authors: [Alessandro Giuliani, Vieri Mastropietro, Fabio Lucio Toninelli]
year: 2017
source: arXiv preprint / Nuclear Physics B
arxiv_id: 1410.4131
doi:
url: https://arxiv.org/abs/1410.4131
abstract: Exact finite-size results for the 2D dimer model including corner free energy and dimer-dimer correlation functions on finite domains.
model_hints: [square lattice dimer, finite domain]
operation_hints: [determinant_formula, correlation_function, corner_free_energy]
source_available: arxiv_source
coverage_axis: [finite_domain_enumeration, local_correlations_inverse_kasteleyn]
metadata_sources: [web_search, arXiv]
notes: Finite-domain corner / correlation results. venue/year verify.
```

```yaml
id: berestycki-laslier-ray-2021-free-boundary-dimers
title: "Free boundary dimers: random walk representation and scaling limit"
authors: [Nathanael Berestycki, Benoit Laslier, Gourab Ray]
year: 2021
source: arXiv preprint / Probability Theory and Related Fields
arxiv_id: 2102.12873
doi:
url: https://arxiv.org/abs/2102.12873
abstract: Studies dimers with free (Robin-type) boundary conditions, giving a random-walk representation of the inverse Kasteleyn matrix on finite regions.
model_hints: [lattice dimer, free boundary]
operation_hints: [inverse_matrix, kasteleyn_matrix, boundary_condition]
source_available: arxiv_source
coverage_axis: [boundary_defect_weighted, local_correlations_inverse_kasteleyn]
metadata_sources: [web_search, arXiv]
notes: Free/Robin boundary cell. authors/venue verify.
```

## Immediate Map Hints

- `known`: square-lattice dimer Pfaffian/determinant (Kasteleyn, Temperley-Fisher, Fisher); planar-graph Pfaffian orientation (Kasteleyn 1967); Aztec diamond finite-domain enumeration (Elkies-Kuperberg-Larsen-Propp); inverse-Kasteleyn finite-region correlations (Kenyon).
- `needs_review`: free/Robin boundary inverse Kasteleyn on finite regions (Berestycki-Laslier-Ray) — finite-symbol (vs scaling-limit) content to be separated; finite-domain corner/correlation results (Giuliani-Mastropietro-Toninelli).
- `unknown_candidate_source`: closed finite-symbol Pfaffian/determinant formulas for dimers on domains with prescribed boundary defects / monomers; weighted finite-domain partition functions with boundary-parameter dependence; non-square graph-class restrictions with explicit product formulas.
- `not_in_scope_yet`: continuum massive-holomorphicity / SLE scaling limits; doubly-periodic spectral-curve asymptotics.
