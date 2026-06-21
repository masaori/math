# Gap Map: tl_loop_finitized_character (first pass, cycle 0 thin)

## Scope

- Source corpus: `inputs/corpus/003_tl_loop_finitized_character.md`（11 records, anchored slice 3）。
- Model family / model: Temperley-Lieb / dense-loop（logarithmic minimal models LM(p,p'), critical dense polymers, blob / 2-boundary TL）。
- First-pass operation focus: `character_identity`（strip 上の finitized Kac character）と link-state 代数（blob/2BTL）の `representation_equivalence`。
- `not found` は `unknown`（未確認）であって `open` ではない。
- Out of first-pass scope: 連続極限 LCFT の不可分加群 fusion、O(n) Coulomb-gas 漸近。
- cycle 0 thin: セルは粗い。`resolved`/`novelty` は判定しない。attribution は corpus 側で `verify` 留め。

## Cell key

```text
model_family × model × boundary_condition × parameter_regime × operation_type × statement_type
```

## Status legend

- `known` / `probably_known` / `unknown` / `impossible` / `needs_review`（map 001/002 と同一）。

## Summary

| cell_id | model / setting | operation × statement | status |
|---|---|---|---|
| K1_lm_strip_finitized_char | LM(p,p') strip, link-state sectors | character_identity × finite_size_identity | known |
| K2_dense_polymers_defect_char | critical dense polymers LM(1,2), extended-Kac defects | character_identity × finite_size_identity | known |
| K3_boundary_tl_blob_link_states | blob / 1-/2-boundary TL | algebra_relation × representation_equivalence | known |
| K4_conformal_boundary_loop_sectors | dense loop boundary conditions | character_identity × boundary_generalization | known |
| NR1_robin_nsr_finitized_char | Robin / NS-R (super)conformal | character_identity × finite_size_identity | needs_review |
| NR2_two_point_boundary_loop_corr | dense loop, 2 boundary points | character_identity × exact_formula (corr) | needs_review |
| U1_two_boundary_general_param_finitized_char | 2-boundary / blob, general boundary params | character_identity × finite_size_identity | unknown |
| U2_fused_tl_finitized_char | fused TL (higher fusion level) | character_identity × finite_size_identity | unknown |
| U3_loop_boundary_correlation_formula | dense loop, boundary observable | character_identity × exact_formula (corr) | unknown |

## Known cells

```yaml
cell_id: K1_lm_strip_finitized_char
model_family: loop_tl
model: logarithmic minimal model LM(p,p')
boundary_condition: strip (link-state sectors, vacuum/boundary Kac labels)
parameter_regime: [trigonometric_critical, finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: known
known_anchors: [pearce-rasmussen-zuber-2006-logarithmic-minimal]
missing_generalization:
evidence_papers: [pearce-rasmussen-zuber-2006-logarithmic-minimal, temperley-lieb-1971-percolation-colouring]
coverage_notes: LM(p,p') を strip 上の TL link-state 表現で構成、finitized Kac character を与える primary known cell。
review_notes:
```

```yaml
cell_id: K2_dense_polymers_defect_char
model_family: loop_tl
model: critical dense polymers (LM(1,2))
boundary_condition: strip + s-1 defects (extended Kac label s)
parameter_regime: [critical, finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: known
known_anchors: [pearce-rasmussen-2007-critical-dense-polymers]
missing_generalization:
evidence_papers: [pearce-rasmussen-2007-critical-dense-polymers]
coverage_notes: 有限 strip で厳密解、extended-Kac defect sector ごとの finitized character。最も clean な worked example。
review_notes:
```

```yaml
cell_id: K3_boundary_tl_blob_link_states
model_family: loop_tl
model: blob (1-boundary TL) / 2-boundary TL / periodic TL
boundary_condition: one / two integrable boundaries (blob/unblob link states)
parameter_regime: [generic_loop_fugacity, finite_size]
operation_type: algebra_relation
statement_type: representation_equivalence
status: known
known_anchors: [martin-saleur-1994-blob-algebra, degier-nichols-2009-one-boundary-tl]
missing_generalization:
evidence_papers: [martin-saleur-1994-blob-algebra, degier-nichols-2009-one-boundary-tl, pasquier-saleur-1990-quantum-groups]
coverage_notes: 境界 link-state sector を与える代数（blob = 1-boundary TL）と表現論。character cell の土台。
review_notes:
```

```yaml
cell_id: K4_conformal_boundary_loop_sectors
model_family: loop_tl
model: dense loop model
boundary_condition: classified conformal boundary conditions
parameter_regime: [critical, finite_size]
operation_type: character_identity
statement_type: boundary_generalization
status: known
known_anchors: [jacobsen-saleur-2008-conformal-boundary-loop]
missing_generalization:
evidence_papers: [jacobsen-saleur-2008-conformal-boundary-loop]
coverage_notes: dense loop の共形境界条件とその sector/spectrum の分類。
review_notes:
```

## Needs-review cells

```yaml
cell_id: NR1_robin_nsr_finitized_char
model_family: loop_tl
model: critical dense polymers / logarithmic superconformal minimal
boundary_condition: Robin / half-integer Kac / Neveu-Schwarz-Ramond
parameter_regime: [critical, finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: needs_review
known_anchors: [pearce-villani-2014-critical-dense-polymers-robin, pearce-tartaglia-2014-logarithmic-superconformal]
missing_generalization: Robin / NS-R 境界の finitized character が標準 Kac character cell（K1/K2）とどこまで別物かが未確認。
evidence_papers: [pearce-villani-2014-critical-dense-polymers-robin, pearce-tartaglia-2014-logarithmic-superconformal]
coverage_notes: 比較的新しい結果。fused-TL（超共形）と境界拡張を含む。
review_notes: attribution/venue を corpus 側で verify。K1/K2 との重複範囲を後続で確認。
```

```yaml
cell_id: NR2_two_point_boundary_loop_corr
model_family: loop_tl
model: dense loop model
boundary_condition: two boundary points (blob sector)
parameter_regime: [critical, finite_size]
operation_type: character_identity
statement_type: exact_formula
status: needs_review
known_anchors: [morin-duchesne-saleur-2018-two-point-boundary-loop]
missing_generalization: 2点境界相関を有限記号の閉じた式（行列式/有限和）として扱えるか、どの sector で finite-symbol になるか未確認。
evidence_papers: [morin-duchesne-saleur-2018-two-point-boundary-loop]
coverage_notes: loop 側の境界 observable。U3 の near-known な隣接。
review_notes: 有限記号該当性を後続で確認。
```

## Unknown cells

```yaml
cell_id: U1_two_boundary_general_param_finitized_char
model_family: loop_tl
model: 2-boundary TL / blob loop model
boundary_condition: two integrable boundaries, general boundary parameters (blob fugacities)
parameter_regime: [generic_loop_fugacity, finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: unknown
known_anchors: [pearce-rasmussen-2007-critical-dense-polymers, degier-nichols-2009-one-boundary-tl]
missing_generalization: 1-boundary / 特殊点の finitized character は既知（K2/K3）。一般 2 境界パラメータでの finitized Kac character（boundary fugacity 依存の有限 q-多項式）は scoped corpus に証拠なし。
evidence_papers: []
coverage_notes: 最有力 unknown。境界数 × 一般境界パラメータ軸への明確なずれ。slice 1 の reflecting/partial 境界、slice 2 の境界 RSOS と並行する「境界 × 有限公式」gap。
review_notes: de Gier 系の後続に既出の可能性 → 後続サイクルで harvest 補強・resolved 確認。
```

```yaml
cell_id: U2_fused_tl_finitized_char
model_family: loop_tl
model: fused Temperley-Lieb loop model (fusion level n>1)
boundary_condition: strip
parameter_regime: [critical, finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: unknown
known_anchors: [pearce-rasmussen-zuber-2006-logarithmic-minimal, pearce-tartaglia-2014-logarithmic-superconformal]
missing_generalization: fusion level 1（と超共形=level 2 の一部）の finitized character は既知/needs_review。一般 fusion level の fused-TL finitized character は scoped corpus に証拠なし。
evidence_papers: []
coverage_notes: fusion 軸への拡張。slice 2 の高ランク（U2）と類似の「既知有限恒等式 × fusion/rank」交差。
review_notes: 一部既出の可能性（Pearce-Tartaglia 系の続き）→ resolved 確認要。
```

```yaml
cell_id: U3_loop_boundary_correlation_formula
model_family: loop_tl
model: dense loop model
boundary_condition: integrable boundary, boundary observable
parameter_regime: [critical, finite_size]
operation_type: character_identity
statement_type: exact_formula
status: unknown
known_anchors: [morin-duchesne-saleur-2018-two-point-boundary-loop, pearce-rasmussen-2007-critical-dense-polymers]
missing_generalization: loop 側の境界相関を、有限サイズで閉じた有限記号公式（行列式 / 有限和 / 生成関数）として与えるセルは scoped corpus に証拠なし（NR2 は near-known、一般化が unknown）。
evidence_papers: []
coverage_notes: six-vertex の境界相関 det（slice 1 K5/U1）の loop 版。vertex-face/loop 対応で繋がる可能性。
review_notes: NR2 を起点に一般化方向を後続で精査。
```

## Immediate observations (07_rank への申し送り)

- known の核は「LM(p,p') strip の finitized Kac character」「critical dense polymers の defect-sector finitized character」「blob/2BTL link-state 代数」「dense loop の共形境界分類」。Pearce 系で finitized character の機構が非常に整備されている。
- unknown の筋: (U1) 一般2境界パラメータの finitized character、(U2) fused-TL の finitized character、(U3) loop 側境界相関の有限公式。いずれも「既知の finitized character/link-state 代数 × 別軸（境界数・fusion・observable）」の交差で、ずれが明確。
- 観察上の横断パターン: slice 1（六頂点・境界相関 det）、slice 2（境界つき RSOS character）、slice 3（2境界/fused/loop 境界相関）で、いずれも **境界軸 × 有限公式** が共通の unknown 筋。これは vertex-face/loop 対応（Pasquier-Saleur, vertex_face_correspondence）で束ねられる可能性があり、cycle 1 の方向候補。
