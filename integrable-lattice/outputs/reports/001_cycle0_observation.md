# Cycle 0 観察レポート（07_rank）

cycle 0（4 slice を広く薄く 01_harvest→04_gap_map→05_generate）を1周した観察。
**目的は件数ではなく、cycle 1 で深掘りする方向を根拠付きで選ぶこと**（`README.md`「cycle 0 の成功条件」）。

## 前提（この周の制約）

- 06_verify・sagemath 数値検証は cycle 0 では未実施。よって各候補の `resolved_risk` / `novelty_risk` は `unchecked`。
- したがって下の `literature_risk` 列は **暫定**（anchor の近接度からの当て推量）であり、確定値ではない。cycle 1 の最初の仕事が resolved-risk の確認。
- 入力: gap map 001-004（各 known/needs_review/unknown）、候補 000-003（計12件）。

## 4 slice 横断の主観察（最重要）

4 slice すべてで、共通の unknown 筋は **「境界（数・パラメータ・defect）× 有限記号閉形式」** だった。

| slice | 既知の有限公式（bulk/標準境界） | unknown の方向（境界一般化） |
|---|---|---|
| 1 six-vertex DWBC det | 分配関数 det（Izergin-Korepin）, 標準 DWBC 境界相関 det（BPZ） | partial/reflecting/half-turn 境界の**相関/EFP** det（U1,U3） |
| 2 RSOS character | bulk finitized character（Melzer/Warnaar） | **境界つき** RSOS finitized character（U1）, 高ランク/coset（U2,U3） |
| 3 TL/loop finitized | LM(p,p') strip finitized character, 1境界 blob | **一般2境界**パラメータ finitized character（U1）, loop **境界相関**の有限公式（U3） |
| 4 dimer Pfaffian | 無欠陥 Pfaffian, Aztec enum, inverse-Kasteleyn 相関 | **境界 defect/monomer** Pfaffian（U1）, 境界パラメータ重み det（U2） |

操作型は determinant/Pfaffian（slice 1,4）と character/q-series（slice 2,3）に分かれるが、**「標準境界での有限公式は既知 → 境界を一般化した有限公式が unknown」** という構造は共通。さらに slice 1↔3↔4 は vertex-face/loop 対応（Pasquier-Saleur, `vertex_face_correspondence`）で繋がりうる。これが cycle 1 の最有力テーマ。

## 候補ランキング（暫定スコア; 5段階 H/M/L）

```yaml
candidate_id: U1-corr-partial-dwbc-boundary-onepoint
rank_bucket: high
novelty: M
proof_feasibility: H
finite_symbol_clarity: H
experimentability: H
literature_risk: M   # 暫定。BPZ×Foda-Wheeler の合成で近接結果がある可能性 → 要 resolved 確認
paper_scope: H
recommended_next_step: resolved-risk 確認 → sagemath で n∈{1,2},N∈{2,3} 検証
paper_bundle: boundary_finite_formula
notes: anchor 明確（BPZ + Foda-Wheeler）、単一の一般化（partial 境界）、小サイズ検証容易。最有力。
```

```yaml
candidate_id: U1-boundary-defect-monomer-pfaffian
rank_bucket: high
novelty: M
proof_feasibility: H
finite_symbol_clarity: H
experimentability: H
literature_risk: H   # 暫定。monomer-dimer（Wu/Tzeng-Wu 系）に近接の可能性大 → 要 resolved 確認
paper_scope: M
recommended_next_step: resolved-risk 確認（monomer-dimer 文献）→ 小領域で Pfaffian 検証
paper_bundle: boundary_finite_formula
notes: 有限記号性・検証容易性が全候補中最強。ただし既出リスクも最も高い。検証より先に文献確認。
```

```yaml
candidate_id: U3-corr-loop-boundary-correlation-finite-formula   # slice 3 の U3
rank_bucket: high
novelty: M
proof_feasibility: M
finite_symbol_clarity: M
experimentability: M
literature_risk: M
paper_scope: H
recommended_next_step: vertex-face/loop 対応で slice1 U1-corr と接続できるか確認
paper_bundle: boundary_finite_formula
notes: 横断テーマの結節点。six-vertex 境界相関 det の loop 版。bundle の理論的接着剤。
```

```yaml
candidate_id: U1-boundary-rsos-finitized-character
rank_bucket: medium
novelty: M
proof_feasibility: M
finite_symbol_clarity: M
experimentability: M
literature_risk: M   # 境界 RSOS（Behrend-Pearce 系）要確認
paper_scope: M
recommended_next_step: 境界 RSOS の harvest 補強 → resolved 確認
paper_bundle: boundary_finitized_character
notes: character 側の「境界×有限公式」。harvest 補強が前提。
```

```yaml
candidate_id: U1-two-boundary-general-param-finitized-character
rank_bucket: medium
novelty: M
proof_feasibility: M
finite_symbol_clarity: M
experimentability: M
literature_risk: M   # de Gier 系後続 要確認
paper_scope: M
recommended_next_step: 2-boundary TL の harvest 補強 → resolved 確認
paper_bundle: boundary_finitized_character
notes: Pearce/de Gier の機構が整備済みで proof_feasibility は悪くない。
```

```yaml
candidate_id: U1-efp-partial-dwbc-emptiness
rank_bucket: medium
novelty: M
proof_feasibility: M
finite_symbol_clarity: H
experimentability: H
literature_risk: M
paper_scope: M
recommended_next_step: U1-corr が通れば従属的に検証
paper_bundle: boundary_finite_formula
notes: U1-corr の発展。単独より bundle の2本目。
```

```yaml
candidate_id: U3-corr-halfturn-boundary-onepoint
rank_bucket: medium
novelty: M
proof_feasibility: M
finite_symbol_clarity: M
experimentability: M
literature_risk: H   # 分配関数 det は既知（Kuperberg/Bleher-Liechty）、新規性は相関に限定
paper_scope: M
recommended_next_step: resolved 確認（分配関数側は既知前提）
paper_bundle: boundary_finite_formula
notes: 新規性の核が「相関」部分のみ。リスク要確認。
```

```yaml
candidate_id: U2-higher-rank-finitized-character
rank_bucket: low
novelty: M
proof_feasibility: L
finite_symbol_clarity: M
experimentability: L
literature_risk: H   # Kirillov-Reshetikhin/HKOTY 系で既出の可能性大
paper_scope: M
recommended_next_step: 後続サイクルで harvest 補強後に再評価
paper_bundle: finitized_character_rank
notes: 高ランク fermionic form は既存研究が厚い。novelty_risk 高。
```

```yaml
candidate_id: U2-weighted-finite-domain-boundary-parameter-determinant
rank_bucket: low
novelty: L
proof_feasibility: M
finite_symbol_clarity: H
experimentability: H
literature_risk: H   # 重み付き Aztec（Propp/Stanley）で既出の可能性大
paper_scope: L
recommended_next_step: 保留
paper_bundle: boundary_finite_formula
notes: 検証は容易だが既出リスク高。
```

```yaml
candidate_id: U2-fused-tl-finitized-character
rank_bucket: low
novelty: L
proof_feasibility: L
finite_symbol_clarity: M
experimentability: L
literature_risk: H   # Pearce-Tartaglia 系の続きで既出の可能性
paper_scope: L
recommended_next_step: 保留
paper_bundle: finitized_character_rank
notes: fusion 軸。既出リスク高。
```

```yaml
candidate_id: U3-coset-beyond-su2-finitized-branching
rank_bucket: low
novelty: L
proof_feasibility: L
finite_symbol_clarity: M
experimentability: L
literature_risk: H
paper_scope: L
recommended_next_step: 保留
paper_bundle: finitized_character_rank
notes: parafermion 系で一部既知の可能性。
```

```yaml
candidate_id: U3-graph-class-explicit-product-formula
rank_bucket: low
novelty: L
proof_feasibility: M
finite_symbol_clarity: M
experimentability: H
literature_risk: H   # Ciucu/LGV 系で既出の可能性大
paper_scope: L
recommended_next_step: 保留
paper_bundle: dimer_enumeration
notes: enumerative combinatorics で既出が厚い。
```

## paper bundle（候補のまとまり）

- **boundary_finite_formula（最有力）**: 標準境界で既知の有限公式（det/Pfaffian/相関）を、境界（数・パラメータ・defect）方向へ一般化する束。six-vertex（U1-corr, U1-efp, U3-corr）+ loop（U3）+ dimer（U1）。vertex-face/loop 対応で理論的に接着可能。
- **boundary_finitized_character**: 境界つき finitized character（RSOS U1, TL/loop U1）。character 側の同テーマ。harvest 補強が前提。
- **finitized_character_rank / dimer_enumeration**: rank/fusion/coset/graph-class 一般化。novelty_risk 高で後回し。

## cycle 1 への方向提案（decide:cycle1 で確定する）

1. **方向を `boundary_finite_formula` 束に絞る**（4 slice 横断で最も筋が揃い、anchor 明確・小サイズ検証容易）。
2. cycle 1 の最初の仕事は **resolved-risk 確認**（この束の上位3件 U1-corr / U1-boundary-defect-monomer / loop-U3 は既出リスクが現実的）。harvest 補強（partial-DWBC 相関の後続、monomer-dimer、boundary RSOS/2BTL）を1段入れる。
3. resolved を抜けた候補のみ **06_verify + sagemath 小サイズ検証** へ進める（ここで初めて深さを投下）。
4. vertex-face/loop 対応で six-vertex↔loop↔dimer の境界公式を1本の論文に束ねられるかを paper-plan として検討。

→ これで cycle 0 の成功条件（次サイクルの深掘り方向を根拠付きで選べる状態）を満たす。
