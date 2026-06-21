# Dimer / Pfaffian Boundary Candidates (cycle 0, thin)

Source gap map: `outputs/maps/004_dimer_pfaffian_boundary_seed_map.md`。
cycle 0 thin の粗い候補。`resolved_risk` / `novelty_risk` は `unchecked`、`paper_potential` は粗い当て推量。06_verify・sagemath はこの周では行わない。
記法: 有限平面領域 \(\Lambda\)（辺重み付き）、Kasteleyn 行列 \(K\)、その逆 \(K^{-1}\)。

```yaml
id: U1-boundary-defect-monomer-pfaffian
title: 境界 monomer/defect を指定した有限平面 dimer 配置の閉じた Pfaffian 公式
status: candidate
model_family: dimer
model: planar dimer (square / planar graph)
operation_type: pfaffian_formula
statement_type: exact_formula
parameters: [edge_weighted, finite_size]
boundary_condition: finite domain with prescribed boundary monomers / defects
known_result_anchor: >
  Kasteleyn 1961（無欠陥 dimer = Pfaffian）と Kenyon 1997（有限相関 = inverse Kasteleyn の minor/Pfaffian）。
missing_generalization: >
  無欠陥の Pfaffian（K1）と内部 dimer 相関（K4）は既知。境界に指定した monomer/defect 集合を持つ
  有限領域の dimer 母関数を、閉じた Pfaffian / inverse-Kasteleyn minor として与えるセルは gap map U1 が unknown。
candidate_statement: >
  有限平面領域 \(\Lambda\)（辺重み付き、Kasteleyn 向き付け可能）と境界上の monomer 位置集合 \(B\) に対し、
  \(B\) を空けた dimer 被覆の重み付き母関数は、\(K^{-1}\) の \(B\) に対応する小行列の Pfaffian と
  全 dimer 数 \(\mathrm{Pf}\,K\) の積で閉じた形に表せる:
  \(Z_\Lambda(B) = \mathrm{Pf}(K) \cdot \mathrm{Pf}\big(K^{-1}|_B\big)\)（符号・向き付けの規約込み）。
  \(B=\varnothing\) で Kasteleyn 公式に帰着する。
finite_symbol_process: >
  pfaffian_formula。境界 monomer を Kasteleyn 行列の行/列除去（または source/sink 挿入）として表し、
  Jacobi 型 minor 恒等式で母関数を inverse-Kasteleyn の Pfaffian に落とす。
expected_proof_strategy: >
  Kenyon の内部相関公式（Pfaffian of K^{-1} minor）を境界 monomer 集合へ適用し、
  境界に限定した場合の符号・向き付けの整合と \(B=\varnothing\) 還元を示す。
small_case_experiment: >
  小領域（2×2, 2×4, 小 Aztec）で境界 monomer 入り被覆を直接列挙し、予想 Pfaffian と一致を SageMath で検証。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: medium
references: [kasteleyn-1961-dimers, kenyon-1997-local-statistics-dimers]
notes: gap map U1。最有力だが monomer-dimer（Wu / Tzeng-Wu 系）に近接結果がある可能性大 → resolved 確認が後続で必須。横断テーマ「境界×有限公式」の dimer 代表。
```

```yaml
id: U2-weighted-finite-domain-boundary-parameter-determinant
title: 境界パラメータ依存の重みをもつ有限領域 dimer 分配関数の閉じた行列式/積公式
status: candidate
model_family: dimer
model: Aztec-type / finite-domain dimer
operation_type: determinant_formula
statement_type: boundary_generalization
parameters: [boundary_weighted, finite_size]
boundary_condition: finite domain with boundary-parameter-dependent edge weights
known_result_anchor: >
  Elkies-Kuperberg-Larsen-Propp 1992（一様 Aztec enumeration）と Fisher 1961（有限平面 det）。
missing_generalization: >
  一様/単純重みの有限領域 enumeration（K3）は既知。境界辺の重みをパラメータ \(\{t_i\}\) で変えた
  有限領域分配関数の閉じた product/determinant は gap map U2 が unknown。
candidate_statement: >
  サイズ \(n\) の Aztec 型領域で、境界辺の重みを境界パラメータ \(\{t_i\}\) に依存させたとき、
  dimer 分配関数は \(\{t_i\}\) の有理式係数をもつ閉じた行列式（または積）で表され、
  全 \(t_i\) を等しくすると Aztec 定理の積公式に帰着する。
finite_symbol_process: >
  determinant_formula。境界重みを Kasteleyn 行列の境界行/列の変形として入れ、
  行列式の境界パラメータ依存を Schur 補元 / 因数分解で閉形に整理する。
expected_proof_strategy: >
  重み付き Kasteleyn 行列式に対し境界行/列のランク1変形を施し、行列式補題で \(\{t_i\}\) 依存を分離。
  一様極限での Aztec 還元を確認。
small_case_experiment: >
  小 Aztec（n=1,2,3）で境界重み付き被覆を列挙し、予想行列式の \(\{t_i\}\) 依存を記号一致検証。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: low
references: [elkies-kuperberg-larsen-propp-1992-aztec, fisher-1961-plane-lattice-dimers]
notes: gap map U2。重み付き Aztec（Propp/Stanley 系）に既出の可能性大 → novelty_risk 高、resolved 確認要。slice 1 の partial/reflecting 境界 det の dimer 版。
```

```yaml
id: U3-graph-class-explicit-product-formula
title: square/Aztec 以外の制限 graph class における有限 dimer の明示積公式
status: candidate
model_family: dimer
model: restricted planar graph class (triangular / hexagonal / defect graphs)
operation_type: determinant_formula
statement_type: exact_formula
parameters: [uniform_or_weighted, finite_size]
boundary_condition: finite domain of a restricted graph class
known_result_anchor: >
  Kasteleyn 1967（一般平面グラフ Pfaffian）と EKLP 1992（square/Aztec の明示積）。
missing_generalization: >
  平面 Pfaffian（K2, 数値）と square/Aztec の明示積（K1/K3）は既知。Aztec 以外の特定 graph class での
  「閉じた積公式」は gap map U3 が unknown。
candidate_statement: >
  指定した graph class（例: ある欠陥規則をもつ三角/六角格子の有限領域）の dimer 数は、
  Kasteleyn Pfaffian を因数分解した閉じた積公式で表される。
finite_symbol_process: >
  determinant_formula / product_formula。Kasteleyn 行列式の固有値を境界条件の対称性で明示因数分解する。
expected_proof_strategy: >
  対称性（巡回/鏡映）で Kasteleyn 行列をブロック対角化し固有値を明示、積公式を得る。
small_case_experiment: >
  小領域で Pfaffian を数値計算し、予想積公式と一致を確認。
resolved_risk: unchecked
novelty_risk: unchecked
paper_potential: low
references: [kasteleyn-1967-graph-theory-crystal-physics, elkies-kuperberg-larsen-propp-1992-aztec]
notes: gap map U3。enumerative combinatorics（Ciucu / Lindström-Gessel-Viennot 系）に既出の可能性が高く novelty_risk 高。cycle 0 では粗い形に留める。
```
