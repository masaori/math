# 方向 C 候補 — ℝ脱出隔離 / 自由フェルミオン構造（cycle 0, 粗い）

Source map: `outputs/maps/C_R_escape_structure_map.md`。選別基準 (i)–(iv)。`resolved_risk: unchecked`、厳密検証はこの周ではしない。

```yaml
id: C-U3-bethe-solvable-finite-N-in-qqbar
title: Bethe 仮設可解系の有限 N スペクトルは ℚ̄、ℝ脱出は N→∞ の一点
direction: C
model: 六頂点/XXZ, 八頂点/XYZ, RSOS（Bethe 可解系一般）
target_quantity: 有限 N の Bethe 根・転送行列スペクトル
home: ℚ̄ ＋ ℝ脱出一点
candidate_statement: >
  Bethe 仮設で可解な可積分模型では、有限 N の Bethe 方程式は ℤ/ℚ̄ 係数の代数的方程式系であり、
  その根（Bethe 根）と転送行列スペクトルは ℚ̄ に住む。よって有限 N の全量は QQbar で決定可能で、
  ℝ が要るのは熱力学極限 N→∞ の一点に隔離される。自由フェルミオン系（Ising/dimer）は
  「対角化が陽に閉じる」特別な場合。
home_and_escape: 本体 ℚ̄（有限 N）。ℝ脱出は N→∞ の一点のみ。
decidable: yes（代数的方程式系の根, QQbar）
formal_verifiable: partial（有限 N の Bethe 根の代数的同定）
finite_symbol_process: Bethe 方程式（代数的）→ 根 ∈ ℚ̄ → 転送行列固有値。
small_case_experiment: 小 N の XXZ で Bethe 根を QQbar で厳密に解く（次サイクル）。
known_result_anchor: [Bethe ansatz, 09(自由フェルミは特別ケース), C-K1]
missing_generalization: ℝ脱出隔離を自由フェルミの外（相互作用 Bethe 可解系）へ拡張する明示命題。
resolved_risk: unchecked
paper_potential: medium
notes: C を最も広げる。A/B/C 統一テーマ「有限 N は ℚ̄ 決定可能、ℝ は極限一点」の屋台骨。
```

```yaml
id: C-U1-R-escape-isolation-iff-free-fermion-decidable
title: 「ℝ脱出隔離 ⟺ 自由フェルミオン構造」の決定可能判定
direction: C
model: 可積分格子模型一般
target_quantity: 自由フェルミオン条件（重みへの代数的制約）と構造保存
home: ℚ̄
candidate_statement: >
  模型・境界が「T(x)∈M(ℤ[x]) を保ち対角化が円分体つき ℚ̄(x) で陽に閉じる（ℝ は連続極限一点）」
  をもつのは自由フェルミオン構造をもつときで、自由フェルミオン条件は Boltzmann 重みへの
  ℤ係数代数的制約として書け、その充足は決定可能。
home_and_escape: 本体 ℚ̄。ℝ脱出は連続極限の一点で明示。
decidable: yes（重みの多項式関係の充足判定）
formal_verifiable: yes
finite_symbol_process: 重みの代数的制約 → Jordan–Wigner 二次形式可能性。
known_result_anchor: [09, 自由フェルミ8V条件(Fan-Wu), C-K4]
missing_generalization: 09 の Ising 例を「決定可能な構造保存判定」に総合化。
resolved_risk: unchecked
paper_potential: medium
notes: C の中核。可解性軸を決定可能判定へ翻訳。
```

```yaml
id: C-U2-free-fermion-class-single-R-escape
title: 自由フェルミオン類で有限 N 量∈ℚ̄(x)＋ℝ脱出一点（Ising 以外への移植）
direction: C
model: dimer, 自由フェルミ6V/8V, critical dense polymers
target_quantity: 有限 N 分配関数・自由エネルギーの帰属と ℝ脱出箇所
home: ℚ̄(x) ＋ ℝ脱出一点
candidate_statement: >
  自由フェルミオン類の各模型で、09 の Ising と同型に「Step1-3 が ℚ̄(x) で閉じ、ℝ脱出は連続極限の一点」
  が成り立つことを明示する。dimer・自由フェルミ8V・critical dense polymers で具体化。
home_and_escape: 本体 ℚ̄(x)、ℝ は一点。
decidable: yes
formal_verifiable: partial
finite_symbol_process: 転送行列 T(x)∈M(ℤ[x]) の固有値積。
known_result_anchor: [C-K2, C-K3, 09]
missing_generalization: 09 の隔離命題を自由フェルミ class 全体へ移植。
resolved_risk: unchecked
paper_potential: low
notes: A-U2(積分解)と交差。class への一般化。
```

```yaml
id: C-U4-jordan-form-stays-in-qqbar
title: 非対角化（Jordan cell）でも有限 N の Jordan 標準形は ℚ̄ で閉じる
direction: C
model: dimer 二重行転送行列（対数 CFT 的 Jordan cell）
target_quantity: Jordan 標準形・一般化固有空間
home: ℚ̄(x)
candidate_statement: >
  転送行列が対角化不能（Jordan cell）でも、有限 N の固有値は ℚ̄、Jordan 標準形・一般化固有空間も
  ℚ̄ 上で構成でき、ℝ脱出隔離は保たれる。
home_and_escape: 本体 ℚ̄(x)、ℝ は一点。
decidable: yes（Jordan form over ℚ̄）
formal_verifiable: partial
finite_symbol_process: ℚ̄ 上の Jordan 分解。
known_result_anchor: [C-K2(dimer DR transfer matrix Jordan cell)]
missing_generalization: 非対角化でも可算構造が壊れない保証の明示。
resolved_risk: unchecked
paper_potential: low
notes: 対数 CFT との接点。
```
