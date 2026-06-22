# Λ gap-map — 方向 F: 形式検証可能性（cycle 0, 広く浅く）

定義 `inputs/seeds/lambda-statement-program.md`、土台 `docs/discussion/可算性の効用/00_可算で完結することの工学的効用.md`・`docs/research/実無限を認めない数学基礎論.md`。

## 中核の観察（F の Λ 構造）

可算／ℝ の境界 ＝ 決定可能性・計算可能性・形式化可能性の境界（可算性の効用 §1）。$\Lambda$ の等号＝素因数分解一致、順序＝整数比較、$\overline{\mathbb{Q}}$ の等号・順序＝根分離。いずれも**無条件決定可能** ⇒ Lean/Coq の `decide`／reflection・witness 提示に乗る。$\Lambda$ 補題は RCA₀ 強度で証明でき ℝ 抜きで再利用可。ℝ脱出 (a)(b)(c) は WKL₀/ACA₀ 領域（逆数学 Big Five）。

F の statement は「この厳密結果は $\Lambda$/$\overline{\mathbb{Q}}$ 上 decide 可能か・どの証明強度か・witness は何か」。A-D の候補に**形式検証の保証**を与える方向。

## cell key / Summary

`statement × F × home × decidable × proof_strength × status`

| cell | 対象 | home | decidable | 強度 | status |
|---|---|---|---|---|---|
| F.K1 | Λ の等号・順序 | Λ | yes（素因数分解/整数比較） | RCA₀ 以下 | known |
| F.K2 | ℚ̄ の等号・順序 | ℚ̄ | yes（根分離, QQbar） | RCA₀ 程度 | known |
| F.K3 | 可算/ℝ ↔ 逆数学 Big Five | — | — | RCA₀/WKL₀/ACA₀ | known(可算性の効用§3) |
| F.K4 | 第〇法則 β_A=β_B | Λ | yes（整数比較） | RCA₀ | known |
| F.U1 | Λ 補題の Lean 形式化（decide/reflection） | Λ | yes | RCA₀ | unknown |
| F.U2 | Lee–Yang 単位円・x_c 最小多項式の証明書 | ℚ̄ | yes | RCA₀程度 | unknown |
| F.U3 | A-D 各命題の逆数学 calibration | — | — | RCA₀ vs WKL₀/ACA₀ | unknown |
| F.U4 | 「有限 N 可積分命題は Λ/ℚ̄ で decide」メタ定理 | Λ/ℚ̄ | yes | RCA₀ | unknown |

## Known cells

```yaml
cell_id: F.K1
direction: F
statement: Λ の等号・順序は決定可能
home: Λ
decidable: yes（等号=素因数分解一致, 順序=整数比較）
proof_strength: RCA₀ 以下
formal_verifiable: yes（decide）
status: known
known_anchors: [可算性の効用§2(2), 00§0.3]
coverage_notes: Λ 命題は重い実解析・古典選択公理を避けられ decide/reflection に乗る。
review_notes:
```

```yaml
cell_id: F.K2
direction: F
statement: ℚ̄ の等号・順序は決定可能（根分離, QQbar）
home: ℚ̄
decidable: yes
proof_strength: RCA₀ 程度
formal_verifiable: yes
status: known
known_anchors: [可算性の効用§3, SageMath QQbar]
coverage_notes: Fisher/Lee–Yang 零点・臨界点（A,B）の ℚ̄ 値が無条件に検証可能。
review_notes:
```

```yaml
cell_id: F.K3
direction: F
statement: 可算/ℝ 境界 ↔ 逆数学 Big Five（RCA₀/WKL₀/ACA₀）
home: —
decidable: —
proof_strength: 脱出 (a)(b)(c) ↔ WKL₀/ACA₀
formal_verifiable: —（calibration 枠）
status: known
known_anchors: [可算性の効用§3,4, 実無限を認めない数学基礎論]
coverage_notes: 「どこで ℝ が要るか」= 「どこで証明強度が上がるか」の対応。
review_notes:
```

```yaml
cell_id: F.K4
direction: F
statement: 第〇法則 β_A=β_B は整数比較で decide
home: Λ
decidable: yes
proof_strength: RCA₀
formal_verifiable: yes
status: known
known_anchors: [00§6, D.K2]
coverage_notes: D（Massieu/β）の命題が形式検証に乗る具体例。
review_notes:
```

## Unknown cells（F の Λ-statement 候補源）

```yaml
cell_id: F.U1
direction: F
statement: Λ 補題（第〇法則・Massieu Φ 恒等式）の Lean `decide`/reflection 形式化の最小例
home: Λ
decidable: yes
proof_strength: RCA₀
formal_verifiable: yes
status: unknown
known_anchors: [F.K1, F.K4, D.K1-K2, 可算性の効用§5]
missing_generalization: 「decide 可能」を実際に Lean の最小例として実装し、ℝ 抜きで証明される様を示す。可算性の効用§5 の次手。
coverage_notes: 形式検証の実演。D と直結、最も具体的。
```

```yaml
cell_id: F.U2
direction: F
statement: Lee–Yang 単位円（各 N）・x_c 最小多項式を証明書付きで検証
home: ℚ̄
decidable: yes
proof_strength: RCA₀ 程度
formal_verifiable: yes
status: unknown
known_anchors: [A.K2(円定理), B.U2(x_c 多項式), F.K2]
missing_generalization: A/B の ℚ̄ 命題を QQbar の witness（最小多項式・根分離）として証明書化し独立検証可能に。
coverage_notes: A×B×F 結節。数値→記号検証の格上げ（可算性の効用§5）。
```

```yaml
cell_id: F.U3
direction: F
statement: A-D 各命題の逆数学 calibration（RCA₀ vs WKL₀/ACA₀）
home: —
decidable: —
proof_strength: 命題ごとに確定
status: unknown
known_anchors: [F.K3, 可算性の効用§5(Big Five 対応を貼る)]
missing_generalization: A(零点)/B(臨界点)/C(構造)/D(Φ) の各命題が、有限部は RCA₀、ℝ脱出は WKL₀/ACA₀ のどれかを明示的に貼る。
coverage_notes: 可算性の効用§5 の宿題。Λ プログラム全体の calibration 台帳。
```

```yaml
cell_id: F.U4
direction: F
statement: 「有限 N の可積分格子命題（Ω/Z/零点/Φ）は Λ/ℚ̄ で decide 可能」メタ定理
home: Λ/ℚ̄
decidable: yes
proof_strength: RCA₀
formal_verifiable: yes
status: unknown
known_anchors: [F.K1, F.K2, A-D 全体]
missing_generalization: A-D を貫く「有限・離散・可積分 ⇒ decide 可能・witness 抽出可能」を一つのメタ定理として述べる。
coverage_notes: A/B/C/D 統一テーマ（有限 N=可算で決定可能）の形式検証版の総括。
```

## 観察（rank への申し送り, F 分）

- F は A-D の候補に **「形式検証可能・witness 付き・証明強度 RCA₀」という保証** を与える横断方向。単体の数学的新規性より、A-D を「機械可読・独立検証可能」に格上げする価値。
- **F.U1（Lean 最小例）と F.U2（QQbar 証明書）が最も具体的**で、次サイクルで A/B/D と組んで即実装可能。F.U4 は A-D 統一テーマ（有限 N＝可算で decide）のメタ定理化。
- F により、Λ プログラムの成果が「数値検証→記号・形式検証」へ格上げされる（可算性の効用§5 の方向）。
