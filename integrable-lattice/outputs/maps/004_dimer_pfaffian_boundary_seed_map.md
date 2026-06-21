# Gap Map: dimer_pfaffian_boundary (first pass, cycle 0 thin)

## Scope

- Source corpus: `inputs/corpus/004_dimer_pfaffian_boundary.md`（9 records, anchored slice 4）。
- Model family / model: dimer / Pfaffian（square lattice, planar graph, Aztec finite domain）。
- First-pass operation focus: `pfaffian_formula` / `determinant_formula`（有限領域の数え上げと inverse-Kasteleyn 相関）。
- `not found` は `unknown`（未確認）であって `open` ではない。
- Out of first-pass scope: 連続 scaling limit（massive holomorphicity / SLE）、doubly-periodic spectral curve 漸近。
- cycle 0 thin: セルは粗い。`resolved`/`novelty` は判定しない。attribution は corpus 側で `verify` 留め。

## Cell key

```text
model_family × model × boundary_condition × parameter_regime × operation_type × statement_type
```

## Status legend

- `known` / `probably_known` / `unknown` / `impossible` / `needs_review`（map 001-003 と同一）。

## Summary

| cell_id | model / setting | operation × statement | status |
|---|---|---|---|
| K1_square_dimer_pfaffian | square-lattice dimer | pfaffian_formula × exact_formula | known |
| K2_planar_graph_pfaffian | planar-graph dimer | pfaffian_formula × boundary_generalization | known |
| K3_aztec_finite_domain_enum | Aztec diamond finite domain | determinant_formula × exact_formula | known |
| K4_inverse_kasteleyn_correlation | finite region, dimer correlations | determinant_formula × exact_formula (corr) | known |
| NR1_free_boundary_inverse_kasteleyn | free / Robin boundary, finite region | determinant_formula × boundary_generalization | needs_review |
| NR2_finite_domain_corner_corr | finite domain, corner / correlations | determinant_formula × exact_formula (corr) | needs_review |
| U1_boundary_defect_monomer_pfaffian | finite domain + boundary defects / monomers | pfaffian_formula × exact_formula | unknown |
| U2_weighted_finite_domain_boundary_param | weighted finite domain, boundary-param dependence | determinant_formula × boundary_generalization | unknown |
| U3_graph_class_product_formula | non-square graph class, explicit product | determinant_formula × exact_formula | unknown |

## Known cells

```yaml
cell_id: K1_square_dimer_pfaffian
model_family: dimer
model: square-lattice dimer
boundary_condition: open finite rectangle
parameter_regime: [uniform_or_edge_weighted, finite_size]
operation_type: pfaffian_formula
statement_type: exact_formula
status: known
known_anchors: [kasteleyn-1961-dimers, temperley-fisher-1961-dimer, fisher-1961-plane-lattice-dimers]
missing_generalization:
evidence_papers: [kasteleyn-1961-dimers, temperley-fisher-1961-dimer, fisher-1961-plane-lattice-dimers]
coverage_notes: 有限矩形の dimer 数え上げ = Kasteleyn 行列の Pfaffian/行列式。primary known cell。
review_notes:
```

```yaml
cell_id: K2_planar_graph_pfaffian
model_family: dimer
model: planar-graph dimer
boundary_condition: general planar graph
parameter_regime: [edge_weighted, finite_size]
operation_type: pfaffian_formula
statement_type: boundary_generalization
status: known
known_anchors: [kasteleyn-1967-graph-theory-crystal-physics]
missing_generalization:
evidence_papers: [kasteleyn-1967-graph-theory-crystal-physics]
coverage_notes: Pfaffian orientation で一般平面グラフへ拡張。graph-class 軸の known 基準。
review_notes:
```

```yaml
cell_id: K3_aztec_finite_domain_enum
model_family: dimer
model: Aztec diamond (domino tilings)
boundary_condition: Aztec finite domain
parameter_regime: [uniform_or_weighted, finite_size]
operation_type: determinant_formula
statement_type: exact_formula
status: known
known_anchors: [elkies-kuperberg-larsen-propp-1992-aztec]
missing_generalization:
evidence_papers: [elkies-kuperberg-larsen-propp-1992-aztec, kenyon-2003-introduction-dimer-model]
coverage_notes: Aztec 定理（タイル数 = 2^{n(n+1)/2}）。有限領域の閉形 product/determinant の代表。
review_notes:
```

```yaml
cell_id: K4_inverse_kasteleyn_correlation
model_family: dimer
model: lattice dimer (finite region)
boundary_condition: finite region with fixed boundary
parameter_regime: [edge_weighted, finite_size]
operation_type: determinant_formula
statement_type: exact_formula
status: known
known_anchors: [kenyon-1997-local-statistics-dimers]
missing_generalization:
evidence_papers: [kenyon-1997-local-statistics-dimers, kenyon-2003-introduction-dimer-model]
coverage_notes: 有限領域の dimer 相関 = inverse Kasteleyn 行列の minor/Pfaffian。
review_notes:
```

## Needs-review cells

```yaml
cell_id: NR1_free_boundary_inverse_kasteleyn
model_family: dimer
model: lattice dimer
boundary_condition: free / Robin boundary, finite region
parameter_regime: [edge_weighted, finite_size]
operation_type: determinant_formula
statement_type: boundary_generalization
status: needs_review
known_anchors: [berestycki-laslier-ray-2021-free-boundary-dimers]
missing_generalization: free/Robin 境界での inverse Kasteleyn の有限記号（閉形）部分が、scaling-limit 解析と分離してどこまで明示式になるか未確認。
evidence_papers: [berestycki-laslier-ray-2021-free-boundary-dimers]
coverage_notes: 境界条件軸の near-known。有限記号 vs 連続極限の切り分けが必要。
review_notes: authors/venue verify。U1/U2 の隣接。
```

```yaml
cell_id: NR2_finite_domain_corner_corr
model_family: dimer
model: square-lattice dimer (finite domain)
boundary_condition: finite domain with corners
parameter_regime: [edge_weighted, finite_size]
operation_type: determinant_formula
statement_type: exact_formula
status: needs_review
known_anchors: [giuliani-mastropietro-toninelli-2017-exact-2d-dimer]
missing_generalization: 有限領域の corner free energy / 相関の閉形部分の範囲が未確認（漸近主体か有限記号か）。
evidence_papers: [giuliani-mastropietro-toninelli-2017-exact-2d-dimer]
coverage_notes: 有限領域 corner/相関。K4 の精密化。
review_notes: venue/year verify。
```

## Unknown cells

```yaml
cell_id: U1_boundary_defect_monomer_pfaffian
model_family: dimer
model: planar dimer with boundary defects / monomers
boundary_condition: finite domain with prescribed boundary monomers / defects
parameter_regime: [edge_weighted, finite_size]
operation_type: pfaffian_formula
statement_type: exact_formula
status: unknown
known_anchors: [kasteleyn-1961-dimers, kenyon-1997-local-statistics-dimers]
missing_generalization: 無欠陥の Pfaffian/inverse-Kasteleyn（K1/K4）は確立。境界に指定した monomer/defect を持つ有限領域の閉じた Pfaffian/行列式公式は scoped corpus に証拠なし。
evidence_papers: []
coverage_notes: 最有力 unknown。境界 defect 軸への明確なずれ。slice 1-3 の「境界 × 有限公式」と同じ構造。
review_notes: monomer-dimer の既存（Wu 系）に既出の可能性 → 後続サイクルで harvest 補強・resolved 確認。
```

```yaml
cell_id: U2_weighted_finite_domain_boundary_param
model_family: dimer
model: Aztec-type / finite-domain dimer
boundary_condition: finite domain, boundary-parameter-dependent weights
parameter_regime: [boundary_weighted, finite_size]
operation_type: determinant_formula
statement_type: boundary_generalization
status: unknown
known_anchors: [elkies-kuperberg-larsen-propp-1992-aztec, fisher-1961-plane-lattice-dimers]
missing_generalization: 一様/単純重みの有限領域 enumeration（K3）は既知。境界パラメータ依存の重みをもつ有限領域分配関数の閉じた product/determinant は scoped corpus に証拠なし。
evidence_papers: []
coverage_notes: 境界パラメータ軸。slice 1 の partial/reflecting（境界パラメータ依存 det）の dimer 版。
review_notes: 重み付き Aztec（Stanley/Propp 系）に既出の可能性 → resolved 確認要。
```

```yaml
cell_id: U3_graph_class_product_formula
model_family: dimer
model: non-square graph class (e.g. triangular / hexagonal / defect graphs)
boundary_condition: finite domain of a restricted graph class
parameter_regime: [uniform_or_weighted, finite_size]
operation_type: determinant_formula
statement_type: exact_formula
status: unknown
known_anchors: [kasteleyn-1967-graph-theory-crystal-physics, elkies-kuperberg-larsen-propp-1992-aztec]
missing_generalization: planar Pfaffian（K2）と square/Aztec の閉形 product（K1/K3）は既知。Aztec 以外の特定 graph class での「閉じた product 公式」（単なる Pfaffian 数値でなく明示積）は scoped corpus に証拠なし。
evidence_papers: []
coverage_notes: graph-class 軸。enumerative combinatorics 寄り。
review_notes: 多くは既出の可能性（Lindström-Gessel-Viennot / Ciucu 系）→ novelty_risk 高。resolved 確認要。
```

## Immediate observations (07_rank への申し送り)

- known の核は「square/planar dimer の Pfaffian」「Aztec 有限領域 enumeration」「inverse-Kasteleyn 有限相関」。dimer slice はほぼ全て `pfaffian_formula` / `determinant_formula` 操作型で、有限記号性が最も強い（数値検証も容易）。
- unknown の筋: (U1) 境界 defect/monomer 付き Pfaffian、(U2) 境界パラメータ依存の重み付き有限領域 det、(U3) graph-class 別 product 公式。U1/U2 は「境界 × 有限公式」、U3 は enumerative で novelty_risk 高め。
- **横断観察（4 slice 出揃い）**: slice 1（六頂点境界相関 det）・slice 2（境界つき RSOS character）・slice 3（2境界/loop 境界相関）・slice 4（境界 defect/param dimer Pfaffian）すべてで **「境界（数・パラメータ・defect）× 有限記号閉形式」** が共通の unknown 筋。determinant/Pfaffian と character/q-series は別操作型だが、境界軸の一般化という点で揃う。これは cycle 1 の方向（境界一般化 × 有限公式に絞る、vertex-face/loop 対応で束ねる）を強く示唆。
