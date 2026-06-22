# Λ gap-map — 方向 C: ℝ脱出隔離 / 自由フェルミオン構造（cycle 0, 広く浅く）

定義 `inputs/seeds/lambda-statement-program.md`、土台 `docs/discussion/対数順序群上の統計力学/`（特に 09 Step1-3 が代数的に閉じる構造・07-5 可解性は別構造から）。

## 中核の観察（C の Λ 構造）

09 が示す通り、2D Ising は **転送行列 $T(x)\in M_{2^L}(\mathbb{Z}[x])$ のまま、対角化が円分体つき $\overline{\mathbb{Q}(x)}$ で閉じ、$\mathbb{R}$ が連続極限（モード和→積分）の一点だけに隔離**される。これが成り立つ理由が**自由フェルミオン構造**（Jordan–Wigner で二次形式に落ちる）。よって C の中核命題は:

- **「模型・境界が ℝ脱出隔離（$T(x)\in M(\mathbb{Z}[x])$, 固有値 $\in\overline{\mathbb{Q}(x)}$, ℝ は連続極限の一点）をもつ」かどうかは、自由フェルミオン構造の有無で決まり、自由フェルミオン条件は Boltzmann 重みへの ℤ係数代数的制約＝決定可能。**
- さらに広く: **Bethe 仮設可解系では Bethe 方程式が代数的 ⇒ 有限 N の Bethe 根・スペクトルは $\overline{\mathbb{Q}}$、ℝ脱出は $N\to\infty$ の一点**。自由フェルミオンは「対角化が陽に閉じる」特別な場合。

非可解（3D Ising 等）は有限 N でも $\overline{\mathbb{Q}}$ には居る（零点は ℤ[x] の根）が、**極限の閉形がない**＝ℝ脱出先が定まらない（07-4）。C は「脱出が一点に隔離できる構造」を画定する。

## cell key

`model × C × target × home × complexity × solvability × decidable × formal_verifiable × status`

## Summary

| cell | model | target | home | solv | decid | status |
|---|---|---|---|---|---|---|
| C.K1 | 2D Ising | T(x)∈M(ℤ[x]), 対角化∈ℚ̄(x), ℝ一点 | ℚ̄(x)＋ℝ一点 | closed | yes | known(09) |
| C.K2 | dimer=自由フェルミ6V | 転送行列代数的(Jordan cell あり) | ℚ̄(x) | closed | yes | known |
| C.K3 | 自由フェルミ8V | 自由フェルミ条件・bipartite dimer・Z不変 | ℚ̄(x) | closed | yes | known |
| C.K4 | 一般 | 自由フェルミ条件=重みへの代数的制約 | ℚ̄ | — | yes | known |
| C.U1 | 可積分一般 | 「ℝ脱出隔離 ⟺ 自由フェルミ構造」決定可能判定 | ℚ̄ | — | yes | unknown |
| C.U2 | 自由フェルミ類 | 有限 N 量∈ℚ̄(x)＋ℝ脱出一点 の明示(Ising 以外) | ℚ̄(x)＋ℝ一点 | closed | yes | unknown |
| C.U3 | Bethe 可解系 | 有限 N Bethe 根∈ℚ̄, ℝ脱出は N→∞ | ℚ̄＋ℝ一点 | model 依存 | yes | unknown |
| C.U4 | 非対角化系(dimer DR) | Jordan 標準形が ℚ̄ で閉じる | ℚ̄(x) | closed | yes | unknown |

## Known cells

```yaml
cell_id: C.K1
model: 2D Ising 正方
direction: C
target_quantity: 転送行列 T(x) と対角化・ℝ脱出箇所
home: ℚ̄(x) ＋ ℝ脱出一点（連続極限）
complexity: poly
solvability: closed（Onsager）
decidable: yes（T(x)∈M(ℤ[x]), 固有値=特性多項式の根）
formal_verifiable: partial
status: known
known_anchors: [09_2DIsing(Step1-3 代数的, Step4 唯一の ℝ脱出)]
coverage_notes: C の規範例。指数形を使わず T(x)∈M(ℤ[x]) のまま、ℝ は積分一点。
review_notes:
```

```yaml
cell_id: C.K2
model: dimer（自由フェルミ六頂点）
direction: C
target_quantity: 転送行列・固有値の代数性
home: ℚ̄(x)
complexity: poly
solvability: closed
decidable: yes
formal_verifiable: partial
status: known
known_anchors: [arXiv:1612.09477(YB solution of dimers as free-fermion 6V), arXiv:2211.06805(自由フェルミ可解の分配関数計算)]
coverage_notes: dimer=自由フェルミ点。転送行列は対角化可能だが二重行転送行列に Jordan cell（C.U4）。
review_notes:
```

```yaml
cell_id: C.K3
model: 自由フェルミオン八頂点
direction: C
target_quantity: 自由フェルミ条件・bipartite dimer・Z不変性
home: ℚ̄(x)
complexity: poly
solvability: closed
decidable: yes
formal_verifiable: partial
status: known
known_anchors: [自由フェルミ8V(couplings, bipartite dimers, Z-invariance), 8V が dimer/ice/zero-field Ising/F/KDP を含む]
coverage_notes: 自由フェルミ 8V は 6V/dimer/Ising を特別な場合に含む統一枠。
review_notes:
```

```yaml
cell_id: C.K4
model: 一般可積分模型
direction: C
target_quantity: 自由フェルミオン条件（Boltzmann 重みへの代数的制約）
home: ℚ̄
complexity: —
solvability: —
decidable: yes（重みの多項式関係の充足判定）
formal_verifiable: partial
status: known
known_anchors: [Fan-Wu 自由フェルミ条件, 8V 自由フェルミ点]
coverage_notes: 「自由フェルミか」は重みの代数的関係（決定可能）。C.U1 の足場。
review_notes:
```

## Unknown cells（C の Λ-statement 候補源）

```yaml
cell_id: C.U1
model: 可積分格子模型一般
direction: C
target_quantity: 「ℝ脱出隔離（T(x)∈M(ℤ[x]),固有値∈ℚ̄(x),ℝ一点）⟺ 自由フェルミ構造」の決定可能判定
home: ℚ̄
complexity: —
solvability: —
decidable: yes（自由フェルミ条件=重みの代数的制約）
formal_verifiable: yes
status: unknown
known_anchors: [C.K1, C.K4, 09]
missing_generalization: 09 の Ising 例を一般化し「どの模型・境界が ℝ脱出隔離をもつか」を自由フェルミ条件で決定可能に画定する総合命題が差分。
coverage_notes: C の中核。可解性軸(07-4)を「構造保存＝決定可能判定」に落とす。
```

```yaml
cell_id: C.U2
model: 自由フェルミオン類（dimer, 自由フェルミ6V/8V, critical dense polymers）
direction: C
target_quantity: 有限 N の分配関数・自由エネルギーが ℚ̄(x) に留まり ℝ脱出が一点、の明示（Ising 以外）
home: ℚ̄(x) ＋ ℝ脱出一点
complexity: poly
solvability: closed
decidable: yes
formal_verifiable: partial
status: unknown
known_anchors: [C.K2, C.K3, 09(Ising 版)]
missing_generalization: 09 の「Step1-3 代数的・Step4 唯一の ℝ脱出」を自由フェルミ類の各模型へ移植・明示する（Ising 以外で同型の隔離命題）。
coverage_notes: 09 の構造を class 全体へ。A.U2（積分解）と交差。
```

```yaml
cell_id: C.U3
model: Bethe 仮設可解系（六頂点/XXZ, 八頂点/XYZ, RSOS）
direction: C
target_quantity: 有限 N の Bethe 根・スペクトルが ℚ̄、ℝ脱出は N→∞ の一点
home: ℚ̄ ＋ ℝ脱出一点
complexity: poly〜（model 依存）
solvability: model 依存
decidable: yes（Bethe 方程式は代数的方程式系 → 根∈ℚ̄）
formal_verifiable: partial
status: unknown
known_anchors: [Bethe ansatz, C.K1（自由フェルミは特別な場合）]
missing_generalization: ℝ脱出隔離を自由フェルミの外（相互作用 Bethe 可解系）へ拡張。Bethe 方程式が有限 N で代数的⇒有限 N 量∈ℚ̄ を明示し、ℝ脱出を画定。
coverage_notes: C を最も広げる候補。自由フェルミは「対角化が陽に閉じる」特別ケース、Bethe 系は「代数的方程式系の根として ℚ̄」。
```

```yaml
cell_id: C.U4
model: 非対角化（dimer 二重行転送行列の Jordan cell）
direction: C
target_quantity: Jordan 標準形が ℚ̄ で閉じる（非対角化でも構造保存）
home: ℚ̄(x)
complexity: poly
solvability: closed
decidable: yes（Jordan form over ℚ̄）
formal_verifiable: partial
status: unknown
known_anchors: [C.K2（dimer DR transfer matrix の Jordan cell）]
missing_generalization: 対角化不能でも有限 N の Jordan 標準形は ℚ̄ で閉じる（固有値∈ℚ̄, 一般化固有空間も代数的）こと、よって ℝ脱出隔離は保たれることを明示。
coverage_notes: 対数 CFT 的 Jordan cell でも可算構造が壊れないという保証。
```

## 観察（rank への申し送り, C 分）

- C は **可解性軸(07-4) の中身を「決定可能な構造保存判定」に翻訳**する方向で、Λ プログラムの核に最も近い。自由フェルミ条件が重みへの代数的制約＝決定可能なのが効く。
- **C.U3（Bethe 可解系で有限 N 量∈ℚ̄, ℝ脱出 N→∞）が最も射程が広い**：自由フェルミの外（XXZ/XYZ/RSOS）まで「ℝ脱出隔離」を拡張でき、A（零点∈ℚ̄）・B（臨界点∈ℚ̄）と合わせて「**有限 N は ℚ̄ で完全決定可能、ℝ は極限の一点**」という統一テーマを作る。
- A/B/C 横断の核テーマが見えてきた: **「有限・離散・可積分 ⇒ 全量が ℚ̄ で決定可能、相転移＝ℝ脱出は N→∞ の一点に隔離」**。これが cycle 1 の最有力筋になりうる（D-F 観察後に確定）。
