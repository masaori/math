# Gap Map: six_vertex_dwbc_determinant (first pass)

## Scope

- Source corpus: `inputs/corpus/001_six_vertex_dwbc_determinant.md`（18 records, first anchored slice）。
- Model family / model: vertex/spin-chain × six-vertex。
- First-pass boundary focus（per `MEMORY.md`）: reflecting-end / partial DWBC / symmetry-class / triangular variants と、それらの標準 DWBC からのずれ。
- このマップは corpus の coverage 範囲に対する gap であり、`not found` は `unknown`（= 未確認）であって `open` ではない。
- Out of first-pass scope（後続パスで扱う。誤って `open` 扱いしない）: elliptic DWBC, higher-spin DWBC, eight-vertex DWBC。

## Cell key

```text
model_family × model × boundary_condition × parameter_regime × operation_type × statement_type
```

- `operation_type` 語彙: `docs/schemas.md` の OperationType。
- `statement_type` 語彙: `docs/schemas.md` の StatementType。
- `boundary_condition` / `parameter_regime` 語彙: `inputs/seeds/axes.md`。

## Status legend

- `known`: scoped corpus 内に直接の証拠あり。
- `probably_known`: 一般結果/手法で覆われている可能性が高いが未検証。
- `unknown`: scoped corpus 内に証拠なし（= 候補生成の主対象）。
- `impossible`: 定義/両立性が破綻すると見える。
- `needs_review`: 分類または文献カバレッジが弱い（出版状態・有限記号該当性の確認が必要）。

## Summary

| cell_id | boundary | operation × statement | status |
|---|---|---|---|
| K1_std_dwbc_det | domain wall | determinant_formula × exact_formula | known |
| K2_reflecting_diag_det | domain wall + reflecting (diagonal) | determinant_formula × boundary_generalization | known |
| K3_partial_dwbc_det | partial domain wall | determinant_formula × boundary_generalization | known |
| K4_symmetry_class_det | domain wall + symmetry class (HT/U-turn) | determinant/pfaffian_formula × finite_size_identity | known |
| K5_std_boundary_corr_det | domain wall | determinant_formula × exact_formula (1pt corr) | known |
| K6_std_fredholm_det | domain wall | determinant_formula × representation_equivalence | known |
| K7_std_efp_det | domain wall | determinant_formula × exact_formula (EFP) | known |
| P1_algebraic_det_construction | domain wall / partial | determinant_formula × normal_form | probably_known |
| NR1_nondiag_reflecting_det | domain wall + non-diagonal reflecting | determinant_formula × boundary_generalization | needs_review |
| NR2_partial_reflecting_pf | domain wall + partially reflecting | determinant_formula × boundary_generalization | needs_review |
| NR3_halfturn_asymptotics | domain wall + half-turn | (asymptotics, 有限記号外) | needs_review |
| NR4_reflecting_boundary_corr | domain wall + reflecting | determinant_formula × exact_formula (corr) | needs_review |
| U1_partial_dwbc_corr_det | partial domain wall | determinant_formula × exact_formula (corr/EFP) | unknown |
| U2_reflecting_efp_det | domain wall + reflecting | determinant_formula × exact_formula (EFP) | unknown |
| U3_symmetry_class_corr_det | domain wall + symmetry class | determinant_formula × exact_formula (corr/EFP) | unknown |
| U4_partial_reflecting_corr_det | domain wall + partially reflecting | determinant_formula × exact_formula (corr) | unknown |
| U5_nondiag_reflecting_corr_det | domain wall + non-diagonal reflecting | determinant_formula × exact_formula (corr) | unknown |
| U6_triangular_dwbc_det | triangular / cut DWBC | determinant_formula × boundary_generalization | unknown |

## Known cells

```yaml
cell_id: K1_std_dwbc_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall
parameter_regime: [trigonometric, inhomogeneous, finite size]
operation_type: determinant_formula
statement_type: exact_formula
status: known
known_anchors: [izergin-coker-korepin-1992-determinant, izergin-1987-finite-volume]
missing_generalization:
evidence_papers: [korepin-1982-bethe-norms, izergin-1987-finite-volume, izergin-coker-korepin-1992-determinant]
coverage_notes: Izergin-Korepin 行列式が標準 DWBC 分配関数の primary known cell。Korepin 1982 は recursion/determinant の precursor。
review_notes:
```

```yaml
cell_id: K2_reflecting_diag_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall + reflecting (diagonal end)
parameter_regime: [trigonometric, inhomogeneous, finite size]
operation_type: determinant_formula
statement_type: boundary_generalization
status: known
known_anchors: [tsuchiya-1998-reflecting-end-determinant]
missing_generalization:
evidence_papers: [tsuchiya-1998-reflecting-end-determinant]
coverage_notes: 対角 reflecting end の分配関数行列式の primary known cell（open XXZ / reflection equation）。
review_notes:
```

```yaml
cell_id: K3_partial_dwbc_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: partial domain wall
parameter_regime: [trigonometric, inhomogeneous, finite size]
operation_type: determinant_formula
statement_type: boundary_generalization
status: known
known_anchors: [foda-wheeler-2012-partial-dwpf]
missing_generalization:
evidence_papers: [foda-wheeler-2012-partial-dwpf, bleher-liechty-2014-partial-dwbc-ferroelectric]
coverage_notes: partial DWBC 分配関数の n×n / N×N 等価行列式の primary known cell。Bleher-Liechty は同 cell の漸近解析側。
review_notes: Bleher-Liechty 2014 は有限記号行列式ではなく漸近（thermodynamic limit）。有限 cell としては Foda-Wheeler を anchor とする。
```

```yaml
cell_id: K4_symmetry_class_det
model_family: vertex_spin_chain
model: six-vertex (square ice / ASM)
boundary_condition: domain wall + symmetry class (half-turn / U-turn)
parameter_regime: [trigonometric, finite size, root of unity (ice point)]
operation_type: [determinant_formula, pfaffian_formula]
statement_type: finite_size_identity
status: known
known_anchors: [kuperberg-2002-asm-symmetry-classes, kuperberg-1997-asm-conjecture]
missing_generalization:
evidence_papers: [kuperberg-1997-asm-conjecture, kuperberg-2002-asm-symmetry-classes]
coverage_notes: ASM 対称類（HT/U-turn 含む）の enumeration を determinant/Pfaffian で与える known cell。ただし主に ice point の数え上げ等式。
review_notes: 一般 spectral parameter での対称類「分配関数」行列式は別 cell（U3 参照）。
```

```yaml
cell_id: K5_std_boundary_corr_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: exact_formula
status: known
known_anchors: [bogoliubov-pronko-zvonarev-2002-boundary-correlations]
missing_generalization:
evidence_papers: [bogoliubov-pronko-zvonarev-2002-boundary-correlations]
coverage_notes: 標準 DWBC の境界 1 点相関を行列式に拡張した known cell。U1/U3/U4/U5 の標準境界アンカー。
review_notes:
```

```yaml
cell_id: K6_std_fredholm_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall
parameter_regime: [trigonometric, finite size, thermodynamic limit]
operation_type: determinant_formula
statement_type: representation_equivalence
status: known
known_anchors: [colomo-pronko-2003-fredholm-dwbc]
missing_generalization:
evidence_papers: [colomo-pronko-2003-fredholm-dwbc]
coverage_notes: 標準 DWBC 分配関数の Fredholm 行列式表示（積分核 + 直交多項式）。K1 の代替表現。
review_notes: 有限 N 行列式ではなく Fredholm（積分核）表示。有限記号該当性は「直交多項式の有限切り出し」として要確認。
```

```yaml
cell_id: K7_std_efp_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: exact_formula
status: known
known_anchors: [colomo-pronko-2007-efp-dwbc]
missing_generalization:
evidence_papers: [colomo-pronko-2007-efp-dwbc, colomo-pronko-2009-arctic-curve]
coverage_notes: 標準 DWBC の emptiness formation probability を行列式/多重積分で与える known cell。arctic curve(2009) はその漸近 descendant。
review_notes: arctic-curve 論文自体は行列式ではなく saddle-point 漸近。U2 の標準境界アンカー。
```

## probably_known cells

```yaml
cell_id: P1_algebraic_det_construction
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: [domain wall, partial domain wall]
parameter_regime: [trigonometric, inhomogeneous, finite size]
operation_type: determinant_formula
statement_type: normal_form
status: probably_known
known_anchors: [minin-pronko-tarasov-2023-determinant-construction]
missing_generalization: recursion を使わない spectral-parameter 代数系による行列式構成を、reflecting/symmetry-class/triangular 境界へ移す部分。
evidence_papers: [minin-pronko-tarasov-2023-determinant-construction]
coverage_notes: IK / Kostov / Foda-Wheeler 基底を代数方程式から復元する近代的構成法。標準・partial では known 同等。
review_notes: 他境界（reflecting / symmetry-class / triangular）への適用可否は未検証。候補の expected_proof_strategy としての再利用価値が高い。
```

## needs_review cells

```yaml
cell_id: NR1_nondiag_reflecting_det
model_family: vertex_spin_chain
model: six-vertex (open XXZ)
boundary_condition: domain wall + non-diagonal reflecting end
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: boundary_generalization
status: needs_review
known_anchors: [tsuchiya-1998-reflecting-end-determinant]
missing_generalization:
evidence_papers: [yang-chen-feng-hao-hou-shi-zhang-2011-nondiagonal-reflecting]
coverage_notes: 非対角 reflecting end 分配関数の行列式表示（F-basis）。Tsuchiya cell の境界変形。
review_notes: arXiv preprint。出版状態を最終 bibliography 前に検証。検証後 known へ昇格しうる。
```

```yaml
cell_id: NR2_partial_reflecting_pf
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall + partially reflecting end
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: boundary_generalization
status: needs_review
known_anchors: [tsuchiya-1998-reflecting-end-determinant, foda-wheeler-2012-partial-dwpf]
missing_generalization:
evidence_papers: [hietala-2022-partially-reflecting-end]
coverage_notes: 1 つの partially reflecting end を持つ trigonometric DWBC の分配関数を IK 法で計算、ASM 様行列へ特殊化。Foda-Wheeler partial と Tsuchiya reflecting の中間 cell。
review_notes: 出版済(LMP 2022)。分配関数が閉じた有限行列式形か（IK 法の出力形）を確認し known 昇格可否を判定。
```

```yaml
cell_id: NR3_halfturn_asymptotics
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall + half-turn symmetry
parameter_regime: [thermodynamic limit]
operation_type: determinant_formula
statement_type: parameter_specialization
status: needs_review
known_anchors: [kuperberg-2002-asm-symmetry-classes]
missing_generalization:
evidence_papers: [bleher-liechty-2017-half-turn]
coverage_notes: half-turn DWBC 分配関数の漸近を IK-Kuperberg 行列式還元から導出。
review_notes: 漸近結果であり有限記号操作の対象外の可能性が高い。出版状態も要確認。有限 N の half-turn 分配関数行列式は K4/U3 側で扱う。
```

```yaml
cell_id: NR4_reflecting_boundary_corr
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall + reflecting end
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: exact_formula
status: needs_review
known_anchors: [tsuchiya-1998-reflecting-end-determinant, bogoliubov-pronko-zvonarev-2002-boundary-correlations]
missing_generalization:
evidence_papers: [passos-ribeiro-2019-reflecting-boundary-correlations]
coverage_notes: reflecting end の境界相関を Tsuchiya 公式から recursion + 行列式形で計算。
review_notes: 出版済(JSTAT 2019)。どの相関量まで閉じた行列式で覆われるかを精査。覆われない相関は U2/U3 へ落とす。
```

## unknown cells（候補生成の主対象）

```yaml
cell_id: U1_partial_dwbc_corr_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: partial domain wall
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: exact_formula
status: unknown
known_anchors: [foda-wheeler-2012-partial-dwpf, bogoliubov-pronko-zvonarev-2002-boundary-correlations, colomo-pronko-2007-efp-dwbc]
missing_generalization: partial DWBC 下の境界相関 / EFP を、標準 DWBC（BPZ 2002 / Colomo-Pronko 2007）と同じ閉じた有限行列式形で与えること。
evidence_papers: []
coverage_notes: partial DWBC は分配関数行列式(K3)は既知だが、相関/EFP の行列式が first-pass corpus に無い。
review_notes:
```

```yaml
cell_id: U2_reflecting_efp_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall + reflecting end
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: exact_formula
status: unknown
known_anchors: [colomo-pronko-2007-efp-dwbc, tsuchiya-1998-reflecting-end-determinant, passos-ribeiro-2019-reflecting-boundary-correlations]
missing_generalization: reflecting end 下の emptiness formation probability の閉じた有限行列式/多重積分形（標準 DWBC の Colomo-Pronko 2007 の reflecting 版）。
evidence_papers: []
coverage_notes: reflecting end は分配関数(K2)・一部境界相関(NR4)は既知だが、EFP 行列式が corpus に無い。
review_notes: NR4 の精査で一部が known に動く可能性あり。
```

```yaml
cell_id: U3_symmetry_class_corr_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall + symmetry class (half-turn / U-turn)
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: exact_formula
status: unknown
known_anchors: [kuperberg-2002-asm-symmetry-classes, bogoliubov-pronko-zvonarev-2002-boundary-correlations]
missing_generalization: 対称類境界（HT/U-turn）下の一般 spectral parameter での境界相関 / EFP の有限行列式（Kuperberg は ice point の数え上げ行列式に限定）。
evidence_papers: []
coverage_notes: 対称類は数え上げ行列式(K4)は既知だが、一般パラメータでの相関/EFP 行列式が corpus に無い。
review_notes:
```

```yaml
cell_id: U4_partial_reflecting_corr_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: domain wall + partially reflecting end
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: exact_formula
status: unknown
known_anchors: [hietala-2022-partially-reflecting-end, bogoliubov-pronko-zvonarev-2002-boundary-correlations]
missing_generalization: partially reflecting end 下の境界相関 / EFP の有限行列式（Hietala は分配関数まで）。
evidence_papers: []
coverage_notes: NR2 で分配関数は計算済。相関/EFP は corpus に無い。
review_notes: NR2 の昇格判定後に anchor の確度が変わる。
```

```yaml
cell_id: U5_nondiag_reflecting_corr_det
model_family: vertex_spin_chain
model: six-vertex (open XXZ)
boundary_condition: domain wall + non-diagonal reflecting end
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: exact_formula
status: unknown
known_anchors: [yang-chen-feng-hao-hou-shi-zhang-2011-nondiagonal-reflecting, bogoliubov-pronko-zvonarev-2002-boundary-correlations]
missing_generalization: 非対角 reflecting end 下の境界相関の有限行列式（Yang et al は分配関数まで）。
evidence_papers: []
coverage_notes: 分配関数は NR1（要出版確認）。相関は corpus に無い。
review_notes: NR1 の出版状態が未確認のため anchor 確度低。
```

```yaml
cell_id: U6_triangular_dwbc_det
model_family: vertex_spin_chain
model: six-vertex
boundary_condition: triangular / cut domain wall
parameter_regime: [trigonometric, finite size]
operation_type: determinant_formula
statement_type: boundary_generalization
status: unknown
known_anchors: [foda-wheeler-2012-partial-dwpf, kuperberg-2002-asm-symmetry-classes]
missing_generalization: 三角形/切り欠き型 DWBC 分配関数の閉じた有限行列式（partial DWBC / 対称類のさらなる境界変形）。
evidence_papers: []
coverage_notes: first-pass corpus に triangular boundary の record が無い（MEMORY 指定の探索軸）。corpus の coverage 外であり、unknown かつ次パスでの harvest 対象。
review_notes: 「証拠なし」は corpus 未収集に由来する可能性が高い。候補化の前に triangular boundary の追加 harvest を検討。
```

## impossible / ill-defined cells

- first pass では `impossible` 判定に足る両立性破綻の証拠なし。後続で定義両立性（例: reflecting end と partial cut の同時課金）を精査する。

## Feeds into next stage

- 候補生成（`05_generate` → `outputs/candidates/000_seed_candidates.md`）の主対象は U1–U6。なかでも corpus hint「correlation formulas under partial/reflecting/symmetry-class boundaries」に対応する U1 / U3 が paper_potential 評価の最有力。
- U6（triangular）は corpus 未収集由来の unknown。候補化前に追加 harvest を回すか、`needs_review` 相当として扱う。
- NR1–NR4 は出版状態・有限記号該当性の検証で known/unknown へ振り分ける。検証結果により U2/U4/U5 の anchor 確度が変わる。
