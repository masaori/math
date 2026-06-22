# 方向 F 候補 — 形式検証可能性（cycle 0, 粗い）

Source map: `outputs/maps/F_formal_verifiable_map.md`。選別基準 (i)–(iv)。`resolved_risk: unchecked`。

```yaml
id: F-U1-lean-decide-lambda-lemma
title: Λ 補題（第〇法則・Massieu Φ 恒等式）の Lean decide/reflection 最小実装
direction: F
model: 接触系 / 任意有限・離散
target_quantity: β_A=β_B, Φ_N=log Z_N(q) などの Λ 命題
home: Λ
candidate_statement: >
  第〇法則 β_A(U_A*)=β_B(U_B*)（整数比較）や Massieu Φ_N=log Z_N(q)（素因数分解）を、
  Lean/Coq で `decide`/reflection により ℝ・実解析ライブラリを使わず証明できる最小例として実装し、
  証明強度が RCA₀ 以下に収まることを示す。
home_and_escape: 本体 Λ（ℝ 不使用）。
decidable: yes
formal_verifiable: yes（実装そのものが成果）
finite_symbol_process: 整数比較・素因数分解の decide 手続き。
known_result_anchor: [00§6, 可算性の効用§2,5, D.K1-K2]
missing_generalization: 「decide 可能」を実コードで実演（可算性の効用§5 の次手）。
resolved_risk: unchecked
paper_potential: medium
notes: 最も具体的。D と直結、即実装可能。
```

```yaml
id: F-U2-qqbar-certificate-zeros-critical-point
title: Lee–Yang 単位円・臨界点最小多項式の QQbar 証明書（数値→記号検証の格上げ）
direction: F
model: Ising / Potts
target_quantity: 各 N の Lee–Yang 零点（|z|=1）、x_c の最小多項式
home: ℚ̄
candidate_statement: >
  強磁性 Ising の各有限 N で Lee–Yang 零点が |z|=1 上にあることを QQbar で代数的に検証し、
  臨界点 x_c を最小多項式（Ising: x^2+2x−1）の witness として独立検証可能な証明書にする。
home_and_escape: 本体 ℚ̄（ℝ 不使用）。
decidable: yes（根分離）
formal_verifiable: yes（最小多項式 witness）
finite_symbol_process: QQbar の根表現・実根分離。
known_result_anchor: [A-K2, B-U2, F-K2, 可算性の効用§5]
missing_generalization: A/B の ℚ̄ 命題を証明書化（数値検証→記号検証の格上げ）。
resolved_risk: unchecked
paper_potential: medium
notes: A×B×F 結節。SageMath QQbar で即実演可能。
```

```yaml
id: F-U4-meta-decidability-of-finite-N-integrable
title: 「有限 N 可積分格子命題は Λ/ℚ̄ で decide 可能」メタ定理
direction: F
model: 可積分格子模型一般
target_quantity: Ω/Z/零点/Φ に関する有限 N 命題
home: Λ/ℚ̄
candidate_statement: >
  有限・離散・可積分の Ω_N∈ℕ, Z_N∈ℤ[x], 零点∈ℚ̄, Φ_N∈Λ に関する命題は、等号・順序・帰属が
  Λ（素因数分解・整数比較）/ℚ̄（根分離）で無条件に決定可能で、witness を抽出できる。これを
  A-D を貫くメタ定理として述べる。
home_and_escape: 本体 Λ/ℚ̄。ℝ は極限（脱出 b）にのみ現れ、本定理は有限 N に限る。
decidable: yes
formal_verifiable: yes
finite_symbol_process: 有限・離散性 → 整数・代数的対象 → decide。
known_result_anchor: [F-K1, F-K2, A-D 全体]
missing_generalization: A-D 統一テーマ（有限 N=可算で決定可能）の形式検証版総括。
resolved_risk: unchecked
paper_potential: medium
notes: A/B/C/D 統一テーマの総括メタ定理。cycle 1 の束ねの軸候補。
```
