# Canonical Papers

未解決ステートメント候補を作るための代表文献 seed。

ここでの役割は「網羅的な文献表」ではなく、gap map と候補生成で使う既知結果アンカーを固定すること。各レコードは、後段の `01_harvest` で関連論文を広げる出発点として使う。

## Scope

MVP では以下に絞る。

- six-vertex / XXZ
- RSOS / ABF
- loop / Temperley-Lieb / O(n)
- dimer / Pfaffian

## Records

```yaml
id: baxter-1982-exactly-solved-models
title: Exactly Solved Models in Statistical Mechanics
authors: [R. J. Baxter]
year: 1982
source_type: book
publisher: Academic Press
isbn: 0-12-083180-5
url: https://openlibrary.org/books/OL3790372M/Exactly_solved_models_in_statistical_mechanics
model_hints: [six-vertex, eight-vertex, hard-hexagon, RSOS, Ising]
operation_hints: [yang_baxter, star_triangle, transfer_matrix, corner_transfer_matrix]
anchor_for: survey anchor for local relation and transfer matrix methods
mvp_role: survey_context
operation_type: [yang_baxter, star_triangle, transfer_matrix_commutativity]
gap_axes: [model_family, boundary_condition, parameter_regime]
harvest_queries:
  - "\"Exactly Solved Models in Statistical Mechanics\" \"Yang-Baxter\""
  - "\"Baxter\" \"star-triangle\" \"lattice model\""
notes: General background anchor; not a candidate source by itself.
```

```yaml
id: lieb-1967-square-ice
title: Residual Entropy of Square Ice
authors: [E. H. Lieb]
year: 1967
source_type: article
journal: Physical Review
volume: 162
issue: 1
pages: 162-172
doi: 10.1103/PhysRev.162.162
url: https://doi.org/10.1103/PhysRev.162.162
model_hints: [six-vertex, ice model]
operation_hints: [transfer_matrix, exact_solution]
anchor_for: six-vertex exact solution and transfer-matrix baseline
mvp_role: known_cell_anchor
operation_type: [transfer_matrix_commutativity]
gap_axes: [model, boundary_condition, finite_size]
harvest_queries:
  - "\"Residual Entropy of Square Ice\""
  - "\"six-vertex\" \"square ice\" \"transfer matrix\""
notes: Use as the base six-vertex / ice-model solved cell.
```

```yaml
id: baxter-1972-eight-vertex-partition
title: Partition function of the eight-vertex lattice model
authors: [R. J. Baxter]
year: 1972
source_type: article
journal: Annals of Physics
volume: 70
pages: 193-228
doi: 10.1016/0003-4916(72)90335-1
url: https://doi.org/10.1016/0003-4916(72)90335-1
model_hints: [eight-vertex, XYZ]
operation_hints: [yang_baxter, transfer_matrix, elliptic_parameterization]
anchor_for: elliptic vertex-model transfer-matrix anchor
mvp_role: parameter_shift_anchor
operation_type: [yang_baxter, transfer_matrix_commutativity]
gap_axes: [elliptic_parameter, vertex_model_family, boundary_condition]
harvest_queries:
  - "\"Partition function of the eight-vertex lattice model\""
  - "\"eight-vertex\" \"domain wall boundary\" determinant"
notes: Useful as an elliptic-shift anchor from six-vertex/XXZ.
```

```yaml
id: korepin-1982-bethe-norms
title: Calculation of norms of Bethe wave functions
authors: [V. E. Korepin]
year: 1982
source_type: article
journal: Communications in Mathematical Physics
volume: 86
issue: 3
pages: 391-418
doi: 10.1007/BF01212176
url: https://doi.org/10.1007/BF01212176
model_hints: [XXZ, six-vertex, quantum nonlinear Schrodinger]
operation_hints: [bethe_ansatz, determinant_formula, domain_wall_boundary]
anchor_for: Korepin recursion / determinant-method precursor
mvp_role: primary_anchor
operation_type: [determinant_formula]
gap_axes: [domain_wall_boundary, finite_volume, recursion]
harvest_queries:
  - "\"Calculation of norms of Bethe wave functions\""
  - "\"Korepin\" \"domain wall boundary\" \"six vertex\""
notes: Use together with Izergin-Coker-Korepin for DWBC determinant cells.
```

```yaml
id: izergin-1987-finite-volume
title: Partition function of a six-vertex model in a finite volume
authors: [A. G. Izergin]
year: 1987
source_type: article
journal: Doklady Akademii Nauk SSSR
volume: 297
issue: 2
pages: 331-333
url: https://www.mathnet.ru/eng/dan7902
model_hints: [six-vertex]
operation_hints: [determinant_formula, domain_wall_boundary, recursion]
anchor_for: original Izergin determinant announcement
mvp_role: primary_anchor
operation_type: [determinant_formula]
gap_axes: [domain_wall_boundary, finite_volume, boundary_deformation]
harvest_queries:
  - "\"Partition function of a six-vertex model in a finite volume\""
  - "\"Izergin determinant\" \"six-vertex\""
notes: Seed for determinant formulas and boundary deformations.
```

```yaml
id: izergin-coker-korepin-1992-determinant
title: Determinant formula for the six-vertex model
authors: [A. G. Izergin, D. A. Coker, V. E. Korepin]
year: 1992
source_type: article
journal: "Journal of Physics A: Mathematical and General"
volume: 25
issue: 16
pages: 4315-4334
doi: 10.1088/0305-4470/25/16/010
url: https://doi.org/10.1088/0305-4470/25/16/010
model_hints: [six-vertex]
operation_hints: [determinant_formula, domain_wall_boundary, qism]
anchor_for: six-vertex DWBC determinant known cell
mvp_role: primary_anchor
operation_type: [determinant_formula]
gap_axes: [domain_wall_boundary, finite_volume, determinant_identity]
harvest_queries:
  - "\"Determinant formula for the six-vertex model\""
  - "\"six-vertex\" \"domain wall boundary\" \"determinant formula\""
notes: Primary anchor for determinant/Pfaffian-style candidate generation.
```

```yaml
id: sklyanin-1988-boundary
title: Boundary conditions for integrable quantum systems
authors: [E. K. Sklyanin]
year: 1988
source_type: article
journal: "Journal of Physics A: Mathematical and General"
volume: 21
issue: 10
pages: 2375-2389
doi: 10.1088/0305-4470/21/10/015
url: https://doi.org/10.1088/0305-4470/21/10/015
model_hints: [XXZ, XYZ, open spin chain]
operation_hints: [reflection_equation, boundary_transfer_matrix, transfer_matrix_commutativity]
anchor_for: reflecting/open-boundary integrability anchor
mvp_role: boundary_axis_anchor
operation_type: [transfer_matrix_commutativity]
gap_axes: [open_boundary, reflecting_boundary, boundary_k_matrix]
harvest_queries:
  - "\"Boundary conditions for integrable quantum systems\""
  - "\"reflection equation\" \"six-vertex\" \"domain wall boundary\" determinant"
notes: Use for boundary-axis gap cells.
```

```yaml
id: tsuchiya-1998-reflecting-end-determinant
title: Determinant formula for the six-vertex model with reflecting end
authors: [O. Tsuchiya]
year: 1998
source_type: article
journal: Journal of Mathematical Physics
volume: 39
issue: 11
pages: 5946-5951
doi: 10.1063/1.532606
arxiv_id: solv-int/9804010
url: https://arxiv.org/abs/solv-int/9804010
model_hints: [six-vertex, XXZ, open boundary]
operation_hints: [determinant_formula, reflection_equation, reflecting_end, qism]
anchor_for: six-vertex reflecting-end determinant known cell
mvp_role: primary_anchor
operation_type: [determinant_formula]
gap_axes: [reflecting_boundary, open_boundary, boundary_k_matrix]
harvest_queries:
  - "\"Determinant formula for the six-vertex model with reflecting end\""
  - "\"Tsuchiya determinant\" \"six-vertex\""
  - "\"six-vertex\" \"reflecting end\" determinant"
notes: Critical anchor before proposing reflecting-boundary determinant gaps.
```

```yaml
id: foda-wheeler-2012-partial-dwpf
title: Partial domain wall partition functions
authors: [O. Foda, M. Wheeler]
year: 2012
source_type: article
journal: Journal of High Energy Physics
volume: 2012
issue: 7
article: 186
doi: 10.1007/JHEP07(2012)186
arxiv_id: 1205.4400
url: https://arxiv.org/abs/1205.4400
model_hints: [six-vertex, partial domain wall boundary]
operation_hints: [determinant_formula, partial_domain_wall_boundary, discrete_kp_tau_function]
anchor_for: six-vertex partial DWBC determinant known cell
mvp_role: primary_anchor
operation_type: [determinant_formula]
gap_axes: [partial_domain_wall_boundary, rectangular_lattice, tau_function]
harvest_queries:
  - "\"Partial domain wall partition functions\""
  - "\"partial domain wall\" \"six-vertex\" determinant"
  - "\"partial DWPF\" \"six-vertex\""
notes: Prevents treating partial-DWBC determinant variants as open too early.
```

```yaml
id: kuperberg-2002-asm-symmetry-classes
title: Symmetry classes of alternating-sign matrices under one roof
authors: [Greg Kuperberg]
year: 2002
source_type: article
journal: Annals of Mathematics
volume: 156
issue: 3
pages: 835-866
doi: 10.2307/3597283
url: https://annals.math.princeton.edu/2002/156-3/p03
model_hints: [six-vertex, square ice, alternating-sign matrices]
operation_hints: [determinant_formula, pfaffian_formula, symmetry_class_enumeration]
anchor_for: ASM symmetry-class determinant/Pfaffian known cells
mvp_role: boundary_axis_anchor
operation_type: [determinant_formula, pfaffian_formula]
gap_axes: [symmetry_class, u_turn_boundary, pfaffian_specialization]
harvest_queries:
  - "\"Symmetry classes of alternating-sign matrices under one roof\""
  - "\"Izergin-Korepin determinant\" \"Tsuchiya determinant\" \"Kuperberg\""
  - "\"six-vertex\" \"ASM\" \"symmetry classes\""
notes: Bridges six-vertex partition functions to symmetry-class boundary variants.
```

```yaml
id: andrews-baxter-forrester-1984-rsos
title: Eight-vertex SOS model and generalized Rogers-Ramanujan-type identities
authors: [G. E. Andrews, R. J. Baxter, P. J. Forrester]
year: 1984
source_type: article
journal: Journal of Statistical Physics
volume: 35
issue: 3-4
pages: 193-266
doi: 10.1007/BF01014383
url: https://doi.org/10.1007/BF01014383
model_hints: [RSOS, ABF, eight-vertex SOS, hard-hexagon]
operation_hints: [star_triangle, corner_transfer_matrix, character_identity, q_series_identity]
anchor_for: ABF/RSOS character and local-height-probability known cells
mvp_role: primary_anchor
operation_type: [star_triangle, character_identity, q_series_identity]
gap_axes: [height_restriction, finite_size_truncation, ctm_sum]
harvest_queries:
  - "\"Eight-vertex SOS model\" \"Rogers-Ramanujan\""
  - "\"ABF model\" \"finitized character\""
notes: Main RSOS/ABF seed.
```

```yaml
id: forrester-baxter-1985-further-rsos
title: Further exact solutions of the eight-vertex SOS model and generalizations of the Rogers-Ramanujan identities
authors: [P. J. Forrester, R. J. Baxter]
year: 1985
source_type: article
journal: Journal of Statistical Physics
volume: 38
pages: 435-472
doi: 10.1007/BF01010471
url: https://doi.org/10.1007/BF01010471
model_hints: [RSOS, eight-vertex SOS]
operation_hints: [character_identity, q_series_identity, corner_transfer_matrix]
anchor_for: generalized ABF character identities
mvp_role: primary_anchor
operation_type: [character_identity, q_series_identity]
gap_axes: [finite_size_truncation, virasoro_character, rogers_ramanujan_identity]
harvest_queries:
  - "\"Further exact solutions\" \"eight-vertex SOS\""
  - "\"Rogers-Ramanujan\" \"RSOS\" \"finite size\""
notes: Good source for finite-size / character-identity generalization axes.
```

```yaml
id: jimbo-miwa-okado-1988-vector-representation
title: Solvable lattice models related to the vector representation of classical simple Lie algebras
authors: [M. Jimbo, T. Miwa, M. Okado]
year: 1988
source_type: article
journal: Communications in Mathematical Physics
volume: 116
pages: 507-525
doi: 10.1007/BF01229206
url: https://doi.org/10.1007/BF01229206
model_hints: [IRF, RSOS, affine Lie algebra face models]
operation_hints: [star_triangle, elliptic_weights, affine_type_generalization]
anchor_for: affine-type/rank generalization of face models
mvp_role: rank_axis_anchor
operation_type: [star_triangle]
gap_axes: [affine_type, rank, vector_representation]
harvest_queries:
  - "\"Solvable lattice models related to the vector representation\""
  - "\"affine Lie algebra\" \"RSOS\" \"star-triangle\""
notes: Use for rank and affine-type gap axes.
```

```yaml
id: jimbo-miwa-okado-1988-local-state-probabilities
title: "Local state probabilities of solvable lattice models: An A_{n-1}^{(1)} family"
authors: [M. Jimbo, T. Miwa, M. Okado]
year: 1988
source_type: article
journal: Nuclear Physics B
volume: 300
pages: 74-108
doi: 10.1016/0550-3213(88)90587-1
url: https://doi.org/10.1016/0550-3213(88)90587-1
model_hints: [IRF, RSOS, A_n_affine]
operation_hints: [character_identity, local_state_probability, branching_function]
anchor_for: local-state-probability and branching-function known cells
mvp_role: rank_axis_anchor
operation_type: [character_identity, q_series_identity]
gap_axes: [affine_type, branching_function, local_state_probability]
harvest_queries:
  - "\"Local state probabilities of solvable lattice models\""
  - "\"A_{n-1}^{(1)}\" \"local state probabilities\""
notes: Candidate source for finite-size character/gap-map rows.
```

```yaml
id: melzer-1994-fermionic-character-sums
title: Fermionic Character Sums and the Corner Transfer Matrix
authors: [Ezer Melzer]
year: 1994
source_type: article
journal: International Journal of Modern Physics A
volume: 9
issue: 7
pages: 1115-1136
doi: 10.1142/S0217751X94000510
arxiv_id: hep-th/9305114
url: https://arxiv.org/abs/hep-th/9305114
model_hints: [RSOS, ABF, Virasoro minimal model]
operation_hints: [finitized_character, q_series_identity, corner_transfer_matrix]
anchor_for: Melzer polynomial/finitized-character conjecture anchor
mvp_role: primary_anchor
operation_type: [character_identity, q_series_identity]
gap_axes: [finitized_character, fermionic_sum, ctm_sum]
harvest_queries:
  - "\"Fermionic Character Sums and the Corner Transfer Matrix\""
  - "\"Melzer\" \"finitized\" \"ABF\""
  - "\"fermionic character sums\" \"RSOS\""
notes: Gives the candidate-generation template for finite q-polynomial identities.
```

```yaml
id: warnaar-1995-abf-melzer-polynomial-identities
title: "Fermionic solution of the Andrews-Baxter-Forrester model II: proof of Melzer's polynomial identities"
authors: [S. O. Warnaar]
year: 1996
source_type: article
journal: Journal of Statistical Physics
volume: 84
issue: 1-2
doi: 10.1007/BF02179577
arxiv_id: hep-th/9508079
url: https://arxiv.org/abs/hep-th/9508079
model_hints: [ABF, RSOS, Virasoro minimal model]
operation_hints: [configuration_sum, finitized_character, q_series_identity]
anchor_for: proof of Melzer finitized Virasoro-character polynomial identities
mvp_role: primary_anchor
operation_type: [character_identity, q_series_identity]
gap_axes: [configuration_sum, finitized_character, bailey_lemma]
harvest_queries:
  - "\"Fermionic solution of the Andrews-Baxter-Forrester model II\""
  - "\"proof of Melzer's polynomial identities\""
  - "\"ABF\" \"one-dimensional configuration sums\" \"fermionic\""
notes: Strong anchor for turning RSOS path sums into theorem-shaped finite identities.
```

```yaml
id: nienhuis-1982-on-loop
title: Exact critical point and critical exponents of O(n) models in two dimensions
authors: [B. Nienhuis]
year: 1982
source_type: article
journal: Physical Review Letters
volume: 49
issue: 15
pages: 1062-1065
doi: 10.1103/PhysRevLett.49.1062
url: https://doi.org/10.1103/PhysRevLett.49.1062
model_hints: [O(n) loop model, honeycomb loop model]
operation_hints: [coulomb_gas, critical_point, loop_model]
anchor_for: O(n) loop critical point and exponent known cells
mvp_role: weak_context_anchor
operation_type: [algebra_relation]
gap_axes: [loop_weight, critical_point, honeycomb_lattice]
harvest_queries:
  - "\"Exact critical point\" \"O(n) models\" \"Nienhuis\""
  - "\"O(n) loop model\" \"Temperley-Lieb\""
notes: Loop-model seed; not all claims are finite-symbol proofs, so use carefully.
```

```yaml
id: pearce-rasmussen-zuber-2006-logarithmic-minimal
title: Logarithmic minimal models
authors: [P. A. Pearce, J. Rasmussen, J.-B. Zuber]
year: 2006
source_type: article
journal: "Journal of Statistical Mechanics: Theory and Experiment"
article: P11017
doi: 10.1088/1742-5468/2006/11/P11017
arxiv_id: hep-th/0607232
url: https://arxiv.org/abs/hep-th/0607232
model_hints: [Temperley-Lieb loop model, logarithmic minimal model, dense loop model]
operation_hints: [yang_baxter, temperley_lieb_relation, transfer_matrix, finitized_character]
anchor_for: TL loop finite-size character and strip-boundary known cells
mvp_role: primary_anchor
operation_type: [yang_baxter, character_identity, algebra_relation]
gap_axes: [strip_boundary, link_state_sector, finitized_character]
harvest_queries:
  - "\"Logarithmic minimal models\" \"Temperley-Lieb\""
  - "\"dense loop\" \"finitized character\" \"Temperley-Lieb\""
notes: Good loop/TL bridge to finite-size identities.
```

```yaml
id: temperley-lieb-1971-percolation-colouring
title: "Relations between the 'percolation' and 'colouring' problem and other graph-theoretical problems associated with regular planar lattices: some exact results for the 'percolation' problem"
authors: [H. N. V. Temperley, E. H. Lieb]
year: 1971
source_type: article
journal: Proceedings of the Royal Society of London. A. Mathematical and Physical Sciences
volume: 322
pages: 251-280
doi: 10.1098/rspa.1971.0067
url: https://doi.org/10.1098/rspa.1971.0067
model_hints: [Temperley-Lieb algebra, planar lattice, ice-type model]
operation_hints: [temperley_lieb_relation, transfer_matrix, algebra_relation]
anchor_for: original Temperley-Lieb relation and transfer-matrix algebra anchor
mvp_role: primary_anchor
operation_type: [algebra_relation, transfer_matrix_commutativity]
gap_axes: [planar_lattice, tl_generator_relation, transfer_matrix_trace]
harvest_queries:
  - "\"Temperley\" \"Lieb\" \"percolation\" \"colouring\""
  - "\"Temperley-Lieb\" \"regular planar lattices\""
  - "\"Temperley-Lieb algebra\" \"loop model\" \"transfer matrix\""
notes: Replaces weak loop context with a finite algebraic-relation anchor.
```

```yaml
id: pasquier-saleur-1990-quantum-groups
title: Common structures between finite systems and conformal field theories through quantum groups
authors: [V. Pasquier, H. Saleur]
year: 1990
source_type: article
journal: Nuclear Physics B
volume: 330
issue: 2-3
pages: 523-556
doi: 10.1016/0550-3213(90)90122-t
url: https://doi.org/10.1016/0550-3213(90)90122-t
model_hints: [finite integrable lattice system, quantum group, root of unity]
operation_hints: [quantum_group_relation, representation_truncation, character_identity]
anchor_for: finite lattice / CFT representation-theoretic structure anchor
mvp_role: representation_axis_anchor
operation_type: [algebra_relation, character_identity]
gap_axes: [root_of_unity, representation_truncation, finite_system_cft_bridge]
harvest_queries:
  - "\"Common structures between finite systems and conformal field theories through quantum groups\""
  - "\"Pasquier\" \"Saleur\" \"finite systems\" \"quantum groups\""
  - "\"root of unity\" \"finite integrable lattice\" \"conformal field theory\""
notes: Supports loop/TL and RSOS representation-equivalence gaps.
```

```yaml
id: kasteleyn-1961-dimers
title: The statistics of dimers on a lattice. I. The number of dimer arrangements on a quadratic lattice
authors: [P. W. Kasteleyn]
year: 1961
source_type: article
journal: Physica
volume: 27
issue: 12
pages: 1209-1225
doi: 10.1016/0031-8914(61)90063-5
url: https://doi.org/10.1016/0031-8914(61)90063-5
model_hints: [square lattice dimer]
operation_hints: [pfaffian_formula, kasteleyn_orientation, determinant_formula]
anchor_for: square-lattice dimer Pfaffian known cell
mvp_role: primary_anchor
operation_type: [pfaffian_formula, determinant_formula]
gap_axes: [square_lattice, kasteleyn_orientation, finite_domain]
harvest_queries:
  - "\"The statistics of dimers on a lattice\""
  - "\"Kasteleyn orientation\" \"Pfaffian\" \"dimer\""
notes: Main Pfaffian/dimer seed.
```

```yaml
id: temperley-fisher-1961-dimer
title: Dimer problem in statistical mechanics-an exact result
authors: [H. N. V. Temperley, M. E. Fisher]
year: 1961
source_type: article
journal: Philosophical Magazine
volume: 6
issue: 68
pages: 1061-1063
doi: 10.1080/14786436108243366
url: https://doi.org/10.1080/14786436108243366
model_hints: [square lattice dimer]
operation_hints: [exact_formula, determinant_formula]
anchor_for: square-lattice dimer exact enumeration known cell
mvp_role: supporting_anchor
operation_type: [determinant_formula]
gap_axes: [square_lattice, exact_enumeration, finite_domain]
harvest_queries:
  - "\"Dimer problem in statistical mechanics\""
  - "\"Temperley Fisher\" dimer exact result"
notes: Pair with Kasteleyn for FKT/Pfaffian lineage.
```

```yaml
id: fisher-1961-plane-lattice-dimers
title: Statistical Mechanics of Dimers on a Plane Lattice
authors: [M. E. Fisher]
year: 1961
source_type: article
journal: Physical Review
volume: 124
pages: 1664-1672
doi: 10.1103/PhysRev.124.1664
url: https://doi.org/10.1103/PhysRev.124.1664
model_hints: [plane lattice dimer, square lattice dimer]
operation_hints: [exact_formula, determinant_formula]
anchor_for: finite plane dimer exact formula known cell
mvp_role: supporting_anchor
operation_type: [determinant_formula]
gap_axes: [plane_lattice, finite_domain, boundary_shape]
harvest_queries:
  - "\"Statistical Mechanics of Dimers on a Plane Lattice\""
  - "\"dimer\" \"plane lattice\" Pfaffian"
notes: Useful for finite-domain dimer formula variations.
```

```yaml
id: kasteleyn-1967-graph-theory-crystal-physics
title: Graph theory and crystal physics
authors: [P. W. Kasteleyn]
year: 1967
source_type: book_chapter
book: Graph Theory and Theoretical Physics
editor: F. Harary
publisher: Academic Press
pages: 43-110
url: https://cir.nii.ac.jp/crid/1574231875423659392
model_hints: [planar graph dimer, Ising model, Pfaffian orientation]
operation_hints: [pfaffian_orientation, pfaffian_formula, planar_graph]
anchor_for: planar-graph Pfaffian-orientation known cell
mvp_role: primary_anchor
operation_type: [pfaffian_formula]
gap_axes: [planar_graph, pfaffian_orientation, graph_class]
harvest_queries:
  - "\"Graph theory and crystal physics\" \"Kasteleyn\""
  - "\"Kasteleyn\" \"planar graph\" \"Pfaffian orientation\""
  - "\"Graph Theory and Theoretical Physics\" \"dimers\" \"Pfaffian\""
notes: Extends square-lattice dimer anchors to general planar graphs.
```

```yaml
id: kenyon-1997-local-statistics-dimers
title: Local statistics of lattice dimers
authors: [Richard Kenyon]
year: 1997
source_type: article
journal: Annales de l'I.H.P. Probabilites et statistiques
volume: 33
issue: 5
pages: 591-618
url: https://eudml.org/doc/77583
model_hints: [lattice dimer, planar graph dimer]
operation_hints: [kasteleyn_matrix, inverse_matrix, local_statistics]
anchor_for: local statistics from Kasteleyn matrix known cell
mvp_role: analysis_axis_anchor
operation_type: [pfaffian_formula]
gap_axes: [local_statistics, weighted_lattice, inverse_kasteleyn_matrix]
harvest_queries:
  - "\"Local statistics of lattice dimers\""
  - "\"Kenyon\" \"lattice dimers\" \"Kasteleyn matrix\""
  - "\"dimer\" \"local statistics\" \"inverse Kasteleyn\""
notes: Useful for dimer candidates beyond pure enumeration formulas.
```

## Immediate Harvest Slices

この seed から最初に収集する文献束。

1. `six_vertex_dwbc_determinant`
   - anchors: `korepin-1982-bethe-norms`, `izergin-1987-finite-volume`, `izergin-coker-korepin-1992-determinant`, `tsuchiya-1998-reflecting-end-determinant`, `foda-wheeler-2012-partial-dwpf`, `kuperberg-2002-asm-symmetry-classes`
   - axis: reflecting / partial / symmetry-class / triangular boundary variants
2. `rsos_character_identity`
   - anchors: `andrews-baxter-forrester-1984-rsos`, `forrester-baxter-1985-further-rsos`, `jimbo-miwa-okado-1988-local-state-probabilities`, `melzer-1994-fermionic-character-sums`, `warnaar-1995-abf-melzer-polynomial-identities`
   - axis: affine type / rank / finite-size truncation / branching identity variants
3. `tl_loop_finitized_character`
   - anchors: `temperley-lieb-1971-percolation-colouring`, `pasquier-saleur-1990-quantum-groups`, `pearce-rasmussen-zuber-2006-logarithmic-minimal`, `nienhuis-1982-on-loop`
   - axis: boundary condition / strip geometry / link-state sector / fused TL variants
4. `dimer_pfaffian_boundary`
   - anchors: `kasteleyn-1961-dimers`, `temperley-fisher-1961-dimer`, `fisher-1961-plane-lattice-dimers`, `kasteleyn-1967-graph-theory-crystal-physics`, `kenyon-1997-local-statistics-dimers`
   - axis: boundary defects / weighted finite domains / graph class restrictions
