# 方向 D 候補 — Massieu Φ_N ∈ Λ（cycle 0, 粗い）

Source map: `outputs/maps/D_massieu_phi_lambda_map.md`。選別基準 (i)–(iv)。`resolved_risk: unchecked`、厳密検証はこの周ではしない。

```yaml
id: D-U1-phi-recurrence-as-lambda-relation
title: 可積分模型の Massieu Φ_N(q) の有限 N 漸化式を Λ 関係式として
direction: D
model: Ising / 六頂点 / dimer（転送行列をもつ）
target_quantity: Φ_N(q)=log Z_N(q)∈Λ と Z_N=Tr T(q)^N
home: Λ
candidate_statement: >
  有理点 q で Z_N(q)=Tr T(q)^N（T(q)∈M(ℤ または ℚ)）の整数性から、Φ_N(q)=log Z_N(q)∈Λ は
  N について Λ 内の漸化的構造（整除性・素因数の増え方）をもち、その関係は素因数分解と整数比較で
  無条件 decide できる。ℝ を一切使わない。
home_and_escape: 本体 Λ（ℝ 不使用、有限 N）。
decidable: yes（素因数分解, 整数比較）
formal_verifiable: yes（ZZ/QQ, decide）
finite_symbol_process: Z_N=Tr T(q)^N → Z_N(q)∈ℚ → 素因数分解 → Λ。
small_case_experiment: 小 N の Ising/六頂点で Z_N(q) を厳密計算し Φ_N の Λ 漸化を観察（次サイクル）。
known_result_anchor: [04, 09(Z_L=Tr T^L, Φ_L 例)]
missing_generalization: 転送行列の整数性が Φ_N の Λ 構造に与える有限 N 命題化。
resolved_risk: unchecked
paper_potential: medium
notes: ℝ 不使用・完全 decide。F(形式検証)に最も乗る。
```

```yaml
id: D-U3-inverse-temperature-monotonicity-integer-comparison
title: 逆温度 β_N=ΔS の有限 N 単調性・凹凸を Λ 整数比較で decide
direction: D
model: 任意の有限・離散
target_quantity: β_N(U)=S_N(U+1)−S_N(U)∈Λ と熱容量符号
home: Λ
candidate_statement: >
  逆温度を差分商 β_N(U)=S_N(U+1)−S_N(U)∈Λ で定義すると、その U についての単調性・凹凸
  （熱容量の符号に対応）は ℝ 微分を使わず Λ の整数比較で無条件に判定でき、有限 N 命題として
  decide 可能。
home_and_escape: 本体 Λ（ℝ 不使用）。
decidable: yes（整数比較）
formal_verifiable: yes
finite_symbol_process: Ω_N の比 → β∈Λ → 整数比較。
known_result_anchor: [00§6, README「r(ε) の Λ 内評価・熱容量対応」]
missing_generalization: 熱容量の符号・凹凸を ℝ 微分でなく Λ で述べ decide する。
resolved_risk: unchecked
paper_potential: medium
notes: README 未解決スレッド直結。形式検証向き。
```

```yaml
id: D-U4-phi-via-qqbar-zeros
title: Φ_N(q) を分配多項式の ℚ̄ 零点で表す（D↔A 統合）
direction: D
model: 任意（D×A）
target_quantity: Φ_N(q)=Σ_{root} log|q−root|
home: Λ ／ ℚ̄
candidate_statement: >
  Φ_N(q)=log Z_N(q) は、Z_N の ℚ̄ 零点 {r_i} を用いて Φ_N(q)=Σ_i log|q−r_i|（先頭係数項込み）と
  書け、左辺は Λ（素因数分解）、右辺は ℚ̄ 零点に基づく。両表示の一致を可算命題として述べる。
home_and_escape: Λ と ℚ̄ の橋。ℝ 不使用（q 有理, root∈ℚ̄）。
decidable: yes
formal_verifiable: partial
finite_symbol_process: Z_N(q) の素因数分解 ↔ ℚ̄ 因数分解。
known_result_anchor: [D.K1, A-U1]
missing_generalization: Massieu Φ(Λ) と零点(ℚ̄) を一つの可算命題に束ねる。
resolved_risk: unchecked
paper_potential: medium
notes: A×D 結節。可算命題群の統合。
```
