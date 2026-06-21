# Gap Map: rsos_character_identity (first pass, cycle 0 thin)

## Scope

- Source corpus: `inputs/corpus/002_rsos_character_identity.md`（13 records, anchored slice 2）。
- Model family / model: RSOS / face（ABF, Forrester-Baxter, A_{n-1}^{(1)} 系, su(2) coset）。
- First-pass operation focus: `character_identity` / `q_series_identity`（有限化 = finitized character の boson=fermion 多項式恒等式と、その分岐/配置和表示）。
- このマップは corpus の coverage 範囲に対する gap であり、`not found` は `unknown`（未確認）であって `open` ではない。
- Out of first-pass scope（後続パスで扱う。誤って `open` 扱いしない）: off-critical 楕円 SOS の1点関数、TBA/dilogarithm の非有限 character 漸近。
- cycle 0 thin: セルは粗い。`resolved`/`novelty` は判定しない。attribution は corpus 側で `verify` 留め。

## Cell key

```text
model_family × model × boundary_condition × parameter_regime × operation_type × statement_type
```

- `operation_type` 語彙: `docs/schemas.md` の OperationType。
- `statement_type` 語彙: `docs/schemas.md` の StatementType。

## Status legend

- `known`: scoped corpus 内に直接の証拠あり。
- `probably_known`: 一般結果/手法で覆われている可能性が高いが未検証。
- `unknown`: scoped corpus 内に証拠なし（= 候補生成の主対象）。
- `impossible`: 定義/両立性が破綻すると見える。
- `needs_review`: 分類または文献カバレッジが弱い（手法重複・有限記号該当性の確認が必要）。

## Summary

| cell_id | model / setting | operation × statement | status |
|---|---|---|---|
| K1_unitary_finitized_char | ABF / M(ν,ν+1) unitary | character_identity × finite_size_identity | known |
| K2_nonunitary_fb_finitized_char | Forrester-Baxter / M(p,p') | character_identity × finite_size_identity | known |
| K3_su2_coset_branching_finitized | su(2)_M×su(2)_N/su(2)_{M+N} coset | character_identity (branching) × finite_size_identity | known |
| K4_affine_An_config_sum_char | A_{n-1}^{(1)} face | character_identity × representation_equivalence | known |
| NR1_bailey_construction_char | minimal RSOS (Bailey route) | character_identity × finite_size_identity | needs_review |
| NR2_root_of_unity_hecke_char | RSOS at root of unity / Hecke | character_identity × representation_equivalence | needs_review |
| U1_boundary_rsos_finitized_char | RSOS + integrable boundary/defect | character_identity × finite_size_identity | unknown |
| U2_higher_rank_finitized_char | A_{n-1}^{(1)} (n>2) | character_identity × finite_size_identity | unknown |
| U3_coset_beyond_su2_finitized | coset 外 su(2)_M×su(2)_N | character_identity (branching) × finite_size_identity | unknown |

## Known cells

```yaml
cell_id: K1_unitary_finitized_char
model_family: rsos_face
model: ABF (eight-vertex SOS, regime III/IV)
boundary_condition: bulk (corner transfer matrix / fixed boundary heights)
parameter_regime: [trigonometric_critical, finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: known
known_anchors: [melzer-1994-fermionic-character-sums, warnaar-1995-abf-melzer-polynomial-identities, berkovich-1994-fermionic-counting-rsos]
missing_generalization:
evidence_papers: [andrews-baxter-forrester-1984-rsos, melzer-1994-fermionic-character-sums, warnaar-1995-abf-melzer-polynomial-identities, berkovich-1994-fermionic-counting-rsos]
coverage_notes: 単位 minimal M(ν,ν+1) の finitized Virasoro character（boson=fermion）。Melzer 予想を Warnaar / Berkovich が証明。primary known cell。
review_notes:
```

```yaml
cell_id: K2_nonunitary_fb_finitized_char
model_family: rsos_face
model: Forrester-Baxter (M(p,p') 非単位 minimal)
boundary_condition: bulk (configuration sum / fixed boundary heights)
parameter_regime: [trigonometric_critical, finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: known
known_anchors: [forrester-baxter-1985-further-rsos, foda-welsh-1995-combinatorics-forrester-baxter, welsh-2005-fermionic-expressions-minimal]
missing_generalization:
evidence_papers: [forrester-baxter-1985-further-rsos, foda-welsh-1995-combinatorics-forrester-baxter, welsh-2005-fermionic-expressions-minimal]
coverage_notes: 非単位 M(p,p') の finitized character。Welsh が全 minimal character の fermionic 形を証明。
review_notes: foda-welsh / welsh の venue・arxiv_id は corpus 側で verify 留め。
```

```yaml
cell_id: K3_su2_coset_branching_finitized
model_family: rsos_face_coset
model: su(2)_M × su(2)_N / su(2)_{M+N} coset
boundary_condition: bulk
parameter_regime: [finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: known
known_anchors: [berkovich-mccoy-schilling-1998-branching-fermionic-forms, schilling-warnaar-1998-supernomial-branching]
missing_generalization:
evidence_papers: [berkovich-mccoy-schilling-1998-branching-fermionic-forms, schilling-warnaar-1998-supernomial-branching]
coverage_notes: su(2) coset 分岐関数の有限 fermionic 形（Berkovich-McCoy-Schilling）と bosonic / supernomial 形（Schilling-Warnaar）。両側そろって boson=fermion finite 恒等式。
review_notes: 年/doi は verify 留め。
```

```yaml
cell_id: K4_affine_An_config_sum_char
model_family: rsos_face
model: A_{n-1}^{(1)} face family (JMO)
boundary_condition: bulk (one-dimensional configuration sum)
parameter_regime: [trigonometric_critical, finite_size, q_series]
operation_type: character_identity
statement_type: representation_equivalence
status: known
known_anchors: [jimbo-miwa-okado-1988-local-state-probabilities, date-jimbo-kuniba-miwa-okado-1989-config-sums]
missing_generalization:
evidence_papers: [jimbo-miwa-okado-1988-local-state-probabilities, date-jimbo-kuniba-miwa-okado-1989-config-sums]
coverage_notes: 1次元 configuration sum = affine Lie 代数 character / 分岐関数（JMO local state prob., DJKMO config sum）。高ランク character の known cell。
review_notes: これは「character = config sum」の同定であり、有限多項式(finitized)恒等式の証明とは別軸。U2 と区別。
```

## Probably-known / needs-review cells

```yaml
cell_id: NR1_bailey_construction_char
model_family: rsos_face
model: minimal RSOS (M(p,p'))
boundary_condition: bulk
parameter_regime: [finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: needs_review
known_anchors: [foda-quano-1996-virasoro-character-bailey]
missing_generalization: Bailey-pair / (higher-level) Bailey lemma で得る character 恒等式が、CTM configuration-sum 経由（K1/K2）と同一の恒等式族をどこまで覆うか未確認。
evidence_papers: [foda-quano-1996-virasoro-character-bailey]
coverage_notes: 別証明ルート。新規というより手法重複の可能性。
review_notes: K1/K2 との重複範囲を後続サイクルで確認。corpus 側で arxiv_id collision を verify。
```

```yaml
cell_id: NR2_root_of_unity_hecke_char
model_family: rsos_face
model: RSOS at root of unity / Hecke algebra modules
boundary_condition: bulk
parameter_regime: [root_of_unity, finite_size]
operation_type: character_identity
statement_type: representation_equivalence
status: needs_review
known_anchors: [foda-leclerc-okado-thibon-welsh-rsos-jantzen-seitz]
missing_generalization: Jantzen-Seitz / Hecke 表現としての RSOS state space 記述が、有限記号の character 恒等式として扱えるか（表現分類 vs 多項式恒等式）が未確認。
evidence_papers: [foda-leclerc-okado-thibon-welsh-rsos-jantzen-seitz]
coverage_notes: 表現論的記述。有限記号該当性の確認が必要。
review_notes: authors/arxiv_id/year を corpus 側で verify。
```

## Unknown cells

```yaml
cell_id: U1_boundary_rsos_finitized_char
model_family: rsos_face
model: RSOS / ABF with integrable boundary or defect
boundary_condition: open / integrable boundary / seam-defect (vs bulk CTM)
parameter_regime: [trigonometric_critical, finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: unknown
known_anchors: [melzer-1994-fermionic-character-sums, warnaar-1995-abf-melzer-polynomial-identities]
missing_generalization: bulk finitized character（K1）は確立。境界/欠陥を入れた RSOS configuration sum の finitized character（boson=fermion 多項式恒等式）は scoped corpus に証拠なし。slice 1 の「分配関数 → 境界相関」gap の RSOS 版。
evidence_papers: []
coverage_notes: 最有力 unknown。boundary を1つ入れた path 数え上げ → 有限 q-多項式恒等式、という明確な「ずれ」。
review_notes: 境界 RSOS の既存研究（Behrend-Pearce 等）が corpus 外にある可能性大 → 後続サイクルで harvest 補強要。
```

```yaml
cell_id: U2_higher_rank_finitized_char
model_family: rsos_face
model: A_{n-1}^{(1)} face (n>2)
boundary_condition: bulk
parameter_regime: [trigonometric_critical, finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: unknown
known_anchors: [date-jimbo-kuniba-miwa-okado-1989-config-sums, melzer-1994-fermionic-character-sums]
missing_generalization: n=2（su(2)）の finitized boson=fermion 多項式恒等式（K1）と、高ランク character = config sum（K4）は別々に既知。両者を繋ぐ「高ランク(n>2) の finitized 多項式恒等式」は scoped corpus に証拠なし。
evidence_papers: []
coverage_notes: rank 軸への自然な拡張。K1（finitization）× K4（高ランク character）の交差セル。
review_notes: 高ランク fermionic form（Kirillov-Reshetikhin 型）が corpus 外にある可能性 → harvest 補強要。
```

```yaml
cell_id: U3_coset_beyond_su2_finitized
model_family: rsos_face_coset
model: coset 外 su(2)_M × su(2)_N（例: su(n) coset, parafermion 系）
boundary_condition: bulk
parameter_regime: [finite_size, q_series]
operation_type: character_identity
statement_type: finite_size_identity
status: unknown
known_anchors: [berkovich-mccoy-schilling-1998-branching-fermionic-forms, schilling-warnaar-1998-supernomial-branching]
missing_generalization: su(2) coset 分岐関数の有限 boson/fermion 形（K3）は確立。su(2) 以外の coset 分岐関数の finitization は scoped corpus に証拠なし。
evidence_papers: []
coverage_notes: coset 軸の拡張。U2（rank 軸）と関連。
review_notes: 一部は既知の可能性（parafermion 系）→ 後続サイクルで resolved リスク確認。
```

## Immediate observations (07_rank への申し送り)

- known の核は「単位/非単位 minimal の finitized character（boson=fermion）」と「su(2) coset 分岐関数の有限形」「高ランク character = config sum」。
- unknown の筋: (U1) 境界/欠陥付き RSOS の finitized character、(U2) 高ランク finitized 多項式恒等式、(U3) su(2) 外 coset の finitization。いずれも「既知の有限恒等式 × 別軸（境界 / rank / coset）」の交差セルで、ずれが明確。
- harvest 補強が必要なサブ領域: 境界 RSOS（Behrend-Pearce 系）、高ランク fermionic form（Kirillov-Reshetikhin 系）。cycle 0 では補強せず観察に留める。
