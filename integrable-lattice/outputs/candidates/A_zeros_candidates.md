# 方向 A 候補 — 分配関数零点 ∈ ℚ̄（cycle 0, 粗い）

Source map: `outputs/maps/A_zeros_qqbar_map.md`。選別基準 `inputs/seeds/lambda-statement-program.md` (i)–(iv)。`resolved_risk: unchecked`、厳密検証(sagemath/06_verify)はこの周ではしない。

```yaml
id: A-U1-finite-N-fisher-zeros-qqbar
title: 有限 N 可積分模型の Fisher 零点の厳密 ℚ̄ 軌跡（決定可能・witness 付き）
direction: A
model: 2D Ising 正方格子（まず有限トーラス L×L）、次に六頂点
target_quantity: Z_L(x)∈ℤ[x] の零点
home: ℚ̄
candidate_statement: >
  有限 L×L トーラス Ising の分配多項式 Z_L(x)∈ℤ[x] の各零点は代数的数で、その最小多項式・
  実根分離・実軸からの距離は QQbar 上で無条件に決定可能。零点集合は ℝ を一切使わずに
  厳密記述でき、L ごとの厳密軌跡（離散ビーズ）を witness（最小多項式）付きで与えられる。
home_and_escape: 本体は ℚ̄（有限 N、ℝ 不使用）。ℝ脱出は L→∞ の集積（相転移）の一点のみで、本命題はそこに踏み込まない。
decidable: yes（最小多項式＋実根分離）
formal_verifiable: yes（witness=最小多項式、QQbar、原理的に decide/reflection）
finite_symbol_process: ℤ[x] の因数分解 → QQbar の根表現。
small_case_experiment: L∈{2,3,4} で Z_L(x) を構築し QQbar で零点を厳密計算（次サイクル）。
known_result_anchor: [Lee-Yang 1952(円定理), Fisher 零点(極限集積円)]
missing_generalization: 文献は数値/極限集積曲線。有限 N 零点を ℚ̄ の厳密対象として述べ・決定する可算再定式化（06「未踏＝差分」）。
resolved_risk: unchecked
paper_potential: medium
notes: ℝ 不使用・完全決定可能・形式検証可能で Λ プログラム適合度が最も高い。最有力。
```

```yaml
id: A-U2-free-fermion-product-factorization-qqbar
title: 自由フェルミオン可解模型の Z_N(x) の ℚ̄ 上積分解の閉形
direction: A
model: 自由フェルミオン可解（境界つき含む）
target_quantity: Z_N(x) の因数分解
home: ℚ̄
candidate_statement: >
  自由フェルミオン構造をもつ可積分模型（特定境界クラス）の分配多項式 Z_N(x) は、
  ℚ̄ 係数（円分体つき）の代数的因子の積に閉じた形で分解し、その因子は転送行列固有値の
  代数的表示から構成される。
home_and_escape: 本体 ℚ̄。ℝ脱出なし（有限 N の代数的恒等式）。
decidable: yes
formal_verifiable: partial（因子の代数的同定）
finite_symbol_process: 転送行列 T(x)∈M(ℤ[x]) の固有値積 → ℚ̄(x) 因子。
known_result_anchor: [arXiv:2507.21943 自由フェルミ零点の積形]
missing_generalization: 特殊境界の積形を、どの模型・境界まで拡張できるか。方向 C（構造保存）と交差。
resolved_risk: unchecked
paper_potential: medium
notes: A×C の交差。積形＝構造保存の代数的指標。
```

```yaml
id: A-U4-countable-vs-R-separation-for-zeros
title: 零点プログラムにおける可算/ℝ 境界の厳密分離命題
direction: A
model: 任意の有限・離散模型
target_quantity: 「有限 N 零点∈ℚ̄」対「相転移=実軸挟み込み=N→∞ の ℝ脱出」
home: ℚ̄ ＋ ℝ脱出一点
candidate_statement: >
  有限・離散模型では分配関数零点は全 N で ℚ̄（決定可能）。非解析性（相転移）は零点が実軸を
  挟む極限 N→∞ にのみ現れ、これは ℝ脱出 (b) の一点に隔離される。両者の境界を零点プログラムで
  厳密に命題化する（梯子 calibration の零点版）。
home_and_escape: 有限部 ℚ̄（決定可能）、ℝ は極限の一点に限定し明示。
decidable: 有限部 yes
formal_verifiable: yes（有限部）、逆数学 calibration に対応
finite_symbol_process: QQbar の零点 + 極限の calibration。
known_result_anchor: [05_相転移はΦで論じられるか, 可算性の効用§3]
missing_generalization: 09/05 の可算/ℝ 立場を零点プログラムで明示命題化。
resolved_risk: unchecked
paper_potential: medium
notes: メタだが形式検証・逆数学との橋。A.U1 と対。
```
