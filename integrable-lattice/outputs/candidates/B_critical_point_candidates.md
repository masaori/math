# 方向 B 候補 — 臨界点の代数性・双対固定（cycle 0, 粗い）

Source map: `outputs/maps/B_critical_point_qqbar_map.md`。選別基準 (i)–(iv)。`resolved_risk: unchecked`、厳密検証はこの周ではしない。

```yaml
id: B-U2-self-dual-polynomial-root-witness
title: 臨界点を自己双対多項式 D(x)∈ℤ[x] の一意実根として ℝ なしで述べ decide
direction: B
model: 自己双対系（2D Ising 正方をまず, 次に q-Potts）
target_quantity: 自己双対多項式 D(x)∈ℤ[x] とその根
home: ℚ̄
candidate_statement: >
  KW 自己双対をもつ模型で、自己双対条件は整係数多項式 D(x)=0（Ising: x^2+2x−1）に帰着し、
  臨界点 x_c はその一意の正実根∈ℚ̄。x_c の値・実根性・一意性は QQbar で無条件決定可能で、
  最小多項式を witness として提示でき、ℝ を一切使わない。
home_and_escape: 本体 ℚ̄（ℝ 不使用）。相転移の非解析性・存在は別命題（ℝ脱出 N→∞）。
decidable: yes（最小多項式＋実根分離＋一意性）
formal_verifiable: yes（witness=D(x)、QQbar、decide）
finite_symbol_process: 双対対合（08 の ℤ[t] 表現）→ 不動点多項式 → QQbar 根。
small_case_experiment: Ising x^2+2x−1、q-Potts の自己双対多項式を QQbar で根確認（次サイクル）。
known_result_anchor: [09(x_c=√2−1), 08_KW双対性, hep-lat/9801006]
missing_generalization: 臨界点を「自己双対多項式の根」として ℝ 抜きで述べ・decide する形式が未整備。
resolved_risk: unchecked
paper_potential: medium
notes: A-U1 と同型(ℚ̄ witness)。単体新規性は薄め、A との統合で価値。
```

```yaml
id: B-U1-algebraic-duality-fixes-critical-point-classification
title: 「代数的双対対合をもつ可積分模型の臨界点は ℚ̄・決定可能」分類命題
direction: B
model: 可積分格子模型一般（Ising/Potts/六頂点/star-triangle 系）
target_quantity: 双対対合のクラスと臨界点の帰属
home: ℚ̄
candidate_statement: >
  ℤ係数の代数的双対対合（KW / star-triangle / Wegner 一般化）をもつ模型では、自己双対点は
  必ず ℚ̄ に住み QQbar 決定可能。どの模型クラスがこれに該当するかを分類し、決定可能命題として束ねる。
home_and_escape: 本体 ℚ̄。位置の代数性のみを主張（転移の存在・閉形式は主張しない＝08 と一致）。
decidable: yes
formal_verifiable: yes
finite_symbol_process: 双対対合の ℤ[t] 表現 → 不動点の代数性。
known_result_anchor: [08_KW双対性(ℤ[t]/Λ 表現, Wegner), B-K1/K2/K3]
missing_generalization: 個別例は既知、一般論は 08。分類＋決定可能性命題化が差分。
resolved_risk: unchecked
paper_potential: low
notes: 総合化命題。新規性は分類の網羅性と decide 化に依存。
```

```yaml
id: B-U4-self-dual-point-equals-fisher-accumulation
title: 自己双対点（ℚ̄）= Fisher 零点集積点 の代数的一致命題（A↔B 統合）
direction: B
model: 自己双対 Ising / Potts
target_quantity: 自己双対点と Fisher 零点集積点
home: ℚ̄ ＋ ℝ脱出一点
candidate_statement: >
  自己双対 Ising で、自己双対点（代数的, B）と有限 N Fisher 零点（ℚ̄, A）の集積点が、極限で
  代数的に一致する。有限 N の ℚ̄ 命題（零点・双対点とも QQbar）と、一致が現れる極限（ℝ脱出一点）を分離して述べる。
home_and_escape: 有限部 ℚ̄（決定可能）、一致の極限は ℝ脱出 (b) の一点に隔離。
decidable: 有限部 yes
formal_verifiable: partial
finite_symbol_process: QQbar 零点 + 自己双対多項式根 + 極限 calibration。
known_result_anchor: [cond-mat/9805282(自己双対 Ising zeros), B-K1, A-K4]
missing_generalization: A と B を一つの ℚ̄ 決定可能命題群に統合する視点が未整備。
resolved_risk: unchecked
paper_potential: medium
notes: A×B 結節。cycle 1 で A と束ねる候補。
```
