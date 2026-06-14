# Corpus: six_vertex_dwbc_determinant

## Scope

Curated first-pass metadata for determinant-formula and closely related finite-symbol results around the six-vertex model with domain wall boundary conditions.

This is raw material for `outputs/maps/001_six_vertex_dwbc_determinant_seed_map.md`. Do not treat `not included here` as `open`; this corpus only covers the first anchored slice.

## Coverage Axes

- `standard_dwbc`: Izergin-Korepin determinant and equivalent determinant constructions.
- `reflecting_end`: Tsuchiya determinant and reflecting-end correlation extensions.
- `partial_dwbc`: Foda-Wheeler / Kostov-style partial DWBC determinants and asymptotics.
- `symmetry_class`: ASM and half-turn / U-turn symmetry classes connected to six-vertex partition functions.
- `correlation_extension`: boundary correlations, emptiness formation probability, and arctic-curve inputs derived from determinant/integral formulas.

## Records

```yaml
id: korepin-1982-bethe-norms
title: Calculation of norms of Bethe wave functions
authors: [V. E. Korepin]
year: 1982
source: Communications in Mathematical Physics 86(3), 391-418
arxiv_id:
doi: 10.1007/BF01212176
url: https://doi.org/10.1007/BF01212176
abstract: Establishes recursion and determinant-method background for Bethe wave-function norms and the six-vertex/DWBC lineage.
model_hints: [six-vertex, XXZ]
operation_hints: [recursion_relation, determinant_formula, qism]
source_available: doi_metadata
coverage_axis: [standard_dwbc]
metadata_sources: [canonical-papers]
notes: Anchor-level precursor for Izergin-Korepin determinant cells.
```

```yaml
id: izergin-1987-finite-volume
title: Partition function of a six-vertex model in a finite volume
authors: [A. G. Izergin]
year: 1987
source: Doklady Akademii Nauk SSSR 297(2), 331-333
arxiv_id:
doi:
url: https://www.mathnet.ru/eng/dan7902
abstract: Announces the finite-volume six-vertex partition function determinant formula.
model_hints: [six-vertex]
operation_hints: [determinant_formula, domain_wall_boundary]
source_available: metadata_page
coverage_axis: [standard_dwbc]
metadata_sources: [canonical-papers, MathNet]
notes: Original Izergin determinant announcement; use with 1992 detailed paper.
```

```yaml
id: izergin-coker-korepin-1992-determinant
title: Determinant formula for the six-vertex model
authors: [A. G. Izergin, D. A. Coker, V. E. Korepin]
year: 1992
source: "Journal of Physics A: Mathematical and General 25(16), 4315-4334"
arxiv_id:
doi: 10.1088/0305-4470/25/16/010
url: https://doi.org/10.1088/0305-4470/25/16/010
abstract: Solves Korepin-type recursion for the finite six-vertex DWBC partition function by a determinant formula using QISM.
model_hints: [six-vertex]
operation_hints: [determinant_formula, domain_wall_boundary, recursion_relation, qism]
source_available: doi_metadata
coverage_axis: [standard_dwbc]
metadata_sources: [SUNY Research Connect, DOI]
notes: Primary known cell for standard DWBC determinant formulas.
```

```yaml
id: kuperberg-1997-asm-conjecture
title: Another proof of the alternating sign matrix conjecture
authors: [Greg Kuperberg]
year: 1996
source: International Mathematics Research Notices 1996, 139-150
arxiv_id: math/9712207
doi:
url: https://arxiv.org/abs/math/9712207
abstract: Uses the six-vertex/square-ice model and Yang-Baxter methods to reprove the alternating-sign matrix enumeration formula.
model_hints: [six-vertex, square ice, alternating-sign matrices]
operation_hints: [yang_baxter, determinant_formula, enumeration]
source_available: arxiv_source
coverage_axis: [standard_dwbc, symmetry_class]
metadata_sources: [arXiv]
notes: Connects DWBC six-vertex determinants to ASM enumeration.
```

```yaml
id: kuperberg-2002-asm-symmetry-classes
title: Symmetry classes of alternating-sign matrices under one roof
authors: [Greg Kuperberg]
year: 2002
source: Annals of Mathematics 156(3), 835-866
arxiv_id: math/0008184
doi: 10.2307/3597283
url: https://annals.math.princeton.edu/2002/156-3/p03
abstract: Extends six-vertex/ASM determinant and Pfaffian methods to multiple ASM symmetry classes, including U-turn and half-turn variants.
model_hints: [six-vertex, square ice, alternating-sign matrices]
operation_hints: [determinant_formula, pfaffian_formula, symmetry_class_enumeration]
source_available: arxiv_source_and_journal_page
coverage_axis: [symmetry_class, reflecting_end]
metadata_sources: [Annals of Mathematics, arXiv]
notes: Strong anchor for symmetry-class boundary variants.
```

```yaml
id: tsuchiya-1998-reflecting-end-determinant
title: Determinant formula for the six-vertex model with reflecting end
authors: [O. Tsuchiya]
year: 1998
source: Journal of Mathematical Physics 39(11), 5946-5951
arxiv_id: solv-int/9804010
doi: 10.1063/1.532606
url: https://arxiv.org/abs/solv-int/9804010
abstract: Derives a determinant formula for six-vertex partition functions with a reflecting end using open-boundary XXZ/QISM.
model_hints: [six-vertex, XXZ, open boundary]
operation_hints: [determinant_formula, reflection_equation, qism]
source_available: arxiv_source
coverage_axis: [reflecting_end]
metadata_sources: [arXiv, CiNii, DOI]
notes: Primary known cell for reflecting-end determinant formulas.
```

```yaml
id: yang-chen-feng-hao-hou-shi-zhang-2011-nondiagonal-reflecting
title: Determinant formula for the partition function of the six-vertex model with a non-diagonal reflecting end
authors: [Wen-Li Yang, Xi Chen, Jun Feng, Kun Hao, Bo-Yu Hou, Kang-Jie Shi, Yao-Zhong Zhang]
year: 2011
source: arXiv preprint
arxiv_id: 1107.5627
doi:
url: https://arxiv.org/abs/1107.5627
abstract: Gives a determinant representation for DWBC six-vertex partition functions with a non-diagonal reflecting end, using an F-basis for open XXZ chains.
model_hints: [six-vertex, open XXZ, non-diagonal boundary]
operation_hints: [determinant_formula, reflecting_end, f_basis]
source_available: arxiv_source
coverage_axis: [reflecting_end]
metadata_sources: [arXiv]
notes: Important boundary deformation of the Tsuchiya cell; publication status should be verified before final bibliography use.
```

```yaml
id: passos-ribeiro-2019-reflecting-boundary-correlations
title: Boundary correlations for the six-vertex model with reflecting end boundary condition
authors: [I. R. Passos, G. A. P. Ribeiro]
year: 2019
source: "Journal of Statistical Mechanics: Theory and Experiment"
arxiv_id: 1904.06383
doi: 10.1088/1742-5468/AB3113
url: https://arxiv.org/abs/1904.06383
abstract: Computes reflecting-end boundary correlations and expresses them via recursion relations and determinant forms built from Tsuchiya's formula.
model_hints: [six-vertex, reflecting end]
operation_hints: [correlation_function, recursion_relation, determinant_formula]
source_available: arxiv_source
coverage_axis: [reflecting_end, correlation_extension]
metadata_sources: [arXiv, MaRDI]
notes: Useful when gap cells shift from partition functions to boundary observables.
```

```yaml
id: foda-wheeler-2012-partial-dwpf
title: Partial domain wall partition functions
authors: [O. Foda, M. Wheeler]
year: 2012
source: Journal of High Energy Physics 2012(7), 186
arxiv_id: 1205.4400
doi: 10.1007/JHEP07(2012)186
url: https://arxiv.org/abs/1205.4400
abstract: Defines partial DWBC on n by N lattices and gives equivalent N by N and n by n determinant formulas; relates these determinants to discrete KP tau-functions.
model_hints: [six-vertex, partial domain wall boundary]
operation_hints: [determinant_formula, partial_domain_wall_boundary, discrete_kp_tau_function]
source_available: arxiv_source
coverage_axis: [partial_dwbc]
metadata_sources: [arXiv]
notes: Primary known cell for partial DWBC determinant formulas.
```

```yaml
id: bleher-liechty-2014-partial-dwbc-ferroelectric
title: "Six-vertex model with partial domain wall boundary conditions: ferroelectric phase"
authors: [Pavel Bleher, Karl Liechty]
year: 2015
source: Journal of Mathematical Physics 56(2)
arxiv_id: 1407.8483
doi: 10.1063/1.4908227
url: https://arxiv.org/abs/1407.8483
abstract: Studies asymptotics of the partial DWBC partition function in the ferroelectric phase using a mixed Vandermonde/Hankel determinant and discrete orthogonal polynomials.
model_hints: [six-vertex, partial domain wall boundary]
operation_hints: [determinant_formula, asymptotics, orthogonal_polynomials]
source_available: arxiv_source
coverage_axis: [partial_dwbc]
metadata_sources: [arXiv, DOI]
notes: Converts partial DWBC from exact determinant cell to asymptotic-analysis cell.
```

```yaml
id: hietala-2022-partially-reflecting-end
title: Exact results for the six-vertex model with domain wall boundary conditions and a partially reflecting end
authors: [Linnea Hietala]
year: 2022
source: Letters in Mathematical Physics 112, article 41
arxiv_id: 2104.05389
doi: 10.1007/s11005-022-01530-5
url: https://arxiv.org/abs/2104.05389
abstract: Treats trigonometric DWBC six-vertex models with one partially reflecting end, computes the partition function by Izergin-Korepin methods, and relates specializations to ASM-like matrices.
model_hints: [six-vertex, partially reflecting end, ASM-like matrices]
operation_hints: [determinant_formula, reflecting_end, izergin_korepin_method]
source_available: arxiv_source
coverage_axis: [reflecting_end, partial_dwbc, symmetry_class]
metadata_sources: [arXiv, Springer]
notes: Sits directly between Foda-Wheeler partial DWBC and Tsuchiya reflecting-end cells.
```

```yaml
id: bogoliubov-pronko-zvonarev-2002-boundary-correlations
title: Boundary correlation functions of the six-vertex model
authors: [N. M. Bogoliubov, A. G. Pronko, M. B. Zvonarev]
year: 2002
source: "Journal of Physics A: Mathematical and General 35(27)"
arxiv_id: math-ph/0203025
doi: 10.1088/0305-4470/35/27/301
url: https://arxiv.org/abs/math-ph/0203025
abstract: Expresses boundary one-point correlation functions for DWBC six-vertex models as determinant formulas, extending the partition-function determinant.
model_hints: [six-vertex, domain wall boundary]
operation_hints: [determinant_formula, boundary_correlation]
source_available: arxiv_source
coverage_axis: [correlation_extension, standard_dwbc]
metadata_sources: [arXiv, DOI]
notes: First correlation-extension cell for determinant-based gap mapping.
```

```yaml
id: colomo-pronko-2003-fredholm-dwbc
title: On the partition function of the six-vertex model with domain wall boundary conditions
authors: [Filippo Colomo, Andrei Pronko]
year: 2004
source: "Journal of Physics A: Mathematical and General 37(6), 1987"
arxiv_id: math-ph/0309064
doi: 10.1088/0305-4470/37/6/003
url: https://arxiv.org/abs/math-ph/0309064
abstract: Provides a Fredholm determinant representation for the DWBC partition function with an integrable kernel involving classical orthogonal polynomials.
model_hints: [six-vertex, domain wall boundary]
operation_hints: [fredholm_determinant, orthogonal_polynomials, partition_function]
source_available: arxiv_source
coverage_axis: [standard_dwbc, correlation_extension]
metadata_sources: [arXiv, DOI]
notes: Alternative determinant representation; useful for finite-symbol process variants.
```

```yaml
id: colomo-pronko-2007-efp-dwbc
title: Emptiness formation probability in the domain-wall six-vertex model
authors: [F. Colomo, A. G. Pronko]
year: 2008
source: Nuclear Physics B 798(3), 340-362
arxiv_id: 0712.1524
doi: 10.1016/j.nuclphysb.2007.12.016
url: https://arxiv.org/abs/0712.1524
abstract: Computes DWBC emptiness formation probability using QISM, giving determinant and multiple-integral forms that support limit-shape analysis.
model_hints: [six-vertex, domain wall boundary]
operation_hints: [emptiness_formation_probability, determinant_formula, multiple_integral]
source_available: arxiv_source
coverage_axis: [correlation_extension, standard_dwbc]
metadata_sources: [arXiv, ScienceDirect]
notes: Strong bridge from determinant formulas to observable/correlation gap cells.
```

```yaml
id: colomo-pronko-2009-arctic-curve
title: The arctic curve of the domain-wall six-vertex model
authors: [F. Colomo, A. G. Pronko]
year: 2010
source: Journal of Statistical Physics 138, 662-700
arxiv_id: 0907.1264
doi: 10.1007/s10955-009-9902-2
url: https://arxiv.org/abs/0907.1264
abstract: Uses multiple-integral representations of emptiness formation probability to analyze the arctic curve for DWBC six-vertex models.
model_hints: [six-vertex, domain wall boundary]
operation_hints: [multiple_integral, saddle_point, arctic_curve]
source_available: arxiv_source
coverage_axis: [correlation_extension, standard_dwbc]
metadata_sources: [arXiv, DOI]
notes: Not a determinant formula itself, but important for observable and asymptotic descendants.
```

```yaml
id: bleher-liechty-2017-half-turn
title: Domain wall six-vertex model with half-turn symmetry
authors: [Pavel Bleher, Karl Liechty]
year: 2017
source: arXiv preprint / repository full text
arxiv_id: 1702.01190
doi:
url: https://arxiv.org/abs/1702.01190
abstract: Derives asymptotic formulas for DWBC six-vertex partition functions with half-turn symmetry, based on Izergin-Korepin-Kuperberg determinant reductions.
model_hints: [six-vertex, half-turn symmetry, domain wall boundary]
operation_hints: [determinant_formula, symmetry_class, asymptotics]
source_available: arxiv_source
coverage_axis: [symmetry_class]
metadata_sources: [arXiv, institutional repository]
notes: Use for half-turn symmetry-class cells; publication details should be verified before final citation.
```

```yaml
id: lyberg-korepin-ribeiro-viti-2018-variety-boundaries
title: Phase separation in the six-vertex model with a variety of boundary conditions
authors: [Ivar Lyberg, Vladimir Korepin, G. A. P. Ribeiro, Jacopo Viti]
year: 2018
source: Journal of Mathematical Physics 59(5), 053301
arxiv_id: 1711.07905
doi: 10.1063/1.5018324
url: https://arxiv.org/abs/1711.07905
abstract: Numerically studies phase separation for DWBC variants including partial DWBC, reflecting ends, and half-turn boundary conditions.
model_hints: [six-vertex, partial domain wall boundary, reflecting end, half-turn boundary]
operation_hints: [numerical_simulation, phase_separation, boundary_condition_comparison]
source_available: arxiv_source
coverage_axis: [partial_dwbc, reflecting_end, symmetry_class]
metadata_sources: [arXiv, SUNY Research Connect]
notes: Not a proof anchor; useful for prioritizing boundary variants that have been explored numerically.
```

```yaml
id: minin-pronko-tarasov-2023-determinant-construction
title: Construction of determinants for the six-vertex model with domain wall boundary conditions
authors: [Mikhail D. Minin, Andrei G. Pronko, Vitaly O. Tarasov]
year: 2023
source: arXiv preprint
arxiv_id: 2304.01824
doi:
url: https://arxiv.org/abs/2304.01824
abstract: Replaces the usual recursion-relation route to DWBC determinants with an algebraic system in spectral parameters, recovering Izergin-Korepin and Kostov/Foda-Wheeler determinant bases.
model_hints: [six-vertex, domain wall boundary]
operation_hints: [determinant_formula, algebraic_equations, polynomial_basis]
source_available: arxiv_source
coverage_axis: [standard_dwbc, partial_dwbc]
metadata_sources: [arXiv]
notes: Modern determinant-construction method; likely useful for generating proof-strategy variants.
```

## Immediate Map Hints

- `known`: standard DWBC determinant, reflecting-end determinant, partial DWBC determinant, ASM symmetry-class determinant/Pfaffian formulas.
- `needs_review`: non-diagonal reflecting end, partially reflecting end, half-turn asymptotics, boundary correlations.
- `unknown_candidate_source`: combinations not directly covered by the first-pass anchors, especially correlation formulas under partial/reflecting/symmetry-class boundaries.
- `not_in_scope_yet`: elliptic DWBC, higher-spin DWBC, eight-vertex DWBC.

