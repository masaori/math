# 章 012「自由エネルギーと熱力学極限」の Lean 形式化で見つかった点

対象: `structured-latex/content/012_free_energy.ts`（7 ブロック）
形式化: `lean/Ising2D/Part012/`（具体版）、`lean/Ising2D/Abstract/`（抽象版）
一覧表と 2 本立ての対応は `lean/docs/ch012-formalization.md`。

**`structured-latex/` は本セッションでは一切編集していない。** 以下は本文修正を担当する
別セッションへの申し送りである。

---

## 1.（本文の記述の不正確さ）実数解析から持ち込む事実は「2 つだけ」ではない

**該当**: `freeenergy_000_remark_escape_to_real_analysis`（ラベル
`remark_real_analysis_escape_point`）

本文は

> そこで外部から持ち込む事実は次の 2 つだけであり、他では使わない。
> (R1) Heine–Cantor / (R2) 連続関数の Riemann 可積分性（区間加法性・評価・定数の積分）

と述べている。しかし同じ章の `gamma_is_continuous`（`freeenergy_002`）の Step 2 は、
(R1)(R2) に含まれない実数解析の事実を 3 つ使っている。

- `cos : ℝ → ℝ` が連続であること（Step 1）
- 非負実数上で `√` が連続であること（Step 2）
- `ℝ_{>0}` 上で `log` が連続であること（Step 2）

本文自身が Step 2 で「`y ↦ y^2-1` は連続」「非負実数の平方根は連続」「`log` は連続」と
明示的に使っており、これらは有限の代数計算では代用できない。

**一次情報（Lean）**: `Ising2D.gamma_is_continuous`
（`lean/Ising2D/Part012/Claim002_GammaContinuous.lean`）の依存を辿ると、
mathlib の `Real.continuousOn_arcosh`（内部で `Real.continuousOn_log` と
`Real.continuous_sqrt` を使う）と `Real.continuous_cos` が現れる。
`Ising2D.riemann_sum_to_integral`（(R1)(R2) に対応）とは独立の依存である。

**推奨する直し方**: (R1)(R2) の列挙に「(R3) 初等関数（`cos`, `√`, `log`）の連続性と
連続関数の合成の連続性」を加えるか、あるいは (R1)(R2) の但し書きを
「**Riemann 積分について**外部から持ち込む事実は次の 2 つだけ」に限定する。
どちらでも本証明の構成は変わらない（誤りではなく、列挙の不足である）。

---

## 2.（証明の穴・軽微）集合上の和からの添字つき和への移行が正当化されていない

**該当**: `freeenergy_005_theorem_onsager_expression`（ラベル
`onsager_free_energy_expression`）

statement は

```
Θ^{(δ)}_M := { 2π(μ-δ)/M | μ = 1,…,M },
Λ^{(δ)}_M := (2 sinh 2K_2)^{M/2} exp( (1/2) Σ_{θ ∈ Θ^{(δ)}_M} γ(θ) )
```

と**集合**についての和で定義しているが、proof は断りなく

```
(1/2)·(1/M) Σ_{μ=1}^{M} γ(2π(μ-δ)/M)
```

という**添字つきの和**へ移っている。両者が一致するには
`μ ↦ 2π(μ-δ)/M` が `{1,…,M}` 上で単射であることが要る（重複があれば集合の和では
重複分が 1 回しか数えられない）。実際には `2π/M > 0` なので単射であり主張は正しいが、
本文にはその一行が無い。

**Lean 側の扱い**: 形式化では proof が実際に使っている添字つきの和
（`∑ μ ∈ Finset.Icc 1 M, ...`）を定義に採用した
（`Ising2D.LambdaM`, `lean/Ising2D/Part012/Theorem005_OnsagerFreeEnergy.lean`）。
本文を直すなら、定義を添字つきの和（族）に変えるか、単射性の一行を proof に足すのがよい。
これは章 006 の `Z_m, Y_m` の線型独立性で「族の性質を集合で述べている」として
すでに指摘されているのと同種の問題である（`lean/README.md`「形式化の過程で見つかった
原文の問題」の `parts/004_転送行列/001_claim_...` の行を参照）。

---

## 3.（過剰な仮定・誤りではない）`riemann_sum_to_integral` の周期性と `δ < 1`

**該当**: `freeenergy_004_theorem_riemann_sum_to_integral`（ラベル
`riemann_sum_to_integral`）

本文は `g` に「連続かつ**周期 `2π`**」を仮定し、proof の最後に

> （周期性は本証明では `δ = 0` のとき `t^{(M)}_M = 2π` が区間 `[0,2π]` の端点として
> 現れることを許すために使っている。`g(2π) = g(0)` なので、どちらの端点を代表点に取っても
> 値は同じである。）

と書いている。**この周期性はまったく必要ない。** 代表点 `t^{(M)}_μ` は閉区間
`I_μ = [2π(μ-1)/M, 2πμ/M]` に属していればよく、それが `[0,2π]` の端点であっても
Step 2 の評価（`|g(t) - g(t^{(M)}_μ)| ≤ ω(2π/M)`）はそのまま通る。
`g(2π)` と `g(0)` を比べる必要がどこにも生じない。

同様に、`δ ∈ [0,1)` の右端が開である必要もない。**`δ ∈ [0,1]` で成り立つ**
（`δ = 1` は各小区間の左端点を代表点に取る場合）。本文が `0 < 1-δ` を使うのは
`t^{(M)}_μ` が `I_μ` の左端**より真に大きい**ことを言うためだが、必要なのは
`t^{(M)}_μ ∈ I_μ`（閉区間の所属）だけである。

**一次情報（Lean）**: 抽象版 `Ising2D.Abstract.abs_integral_sub_riemann_sum_le`
（`lean/Ising2D/Abstract/RiemannSum.lean`）は
「任意の `a ≤ b`」「周期性の仮定なし」「`δ ∈ [0,1]`」で証明されており、
`g(b) = g(a)` をどこでも使っていない。区間が `[0,2π]` であることも効いていない。

**推奨する直し方**: 誤りではないので急ぐ必要はない。ただし本文の目的
（「実数解析へ移行する箇所を最小にする」）に照らすと、不要な仮定と不要な注記は
削るほうが主張の輪郭が鮮明になる。周期性は `gamma_is_continuous` の結論としては
残す価値がある（`γ` の性質としては正しい）が、`riemann_sum_to_integral` の
仮定からは外せる。

---

## 4.（ツール側の記録）`lean/README.md` の「mathlib に `Real.arccosh` が無い」は現状では誤り

**該当**: `lean/README.md`「mathlib に無いことが分かっているもの」

本リポジトリが固定している mathlib（`lean-toolchain` = `leanprover/lean4:v4.32.1`、
`lakefile.toml` の mathlib4 rev も `v4.32.1`）には
`Mathlib/Analysis/SpecialFunctions/Arcosh.lean` があり、

```
def Real.arcosh (x : ℝ) := Real.log (x + √(x ^ 2 - 1))
theorem Real.cosh_arcosh {x : ℝ} (hx : 1 ≤ x) : Real.cosh (Real.arcosh x) = x
theorem Real.arcosh_nonneg {x : ℝ} (hx : 1 ≤ x) : 0 ≤ Real.arcosh x
theorem Real.continuousOn_arcosh : ContinuousOn Real.arcosh (Set.Ici 1)
```

がそろっている（綴りは `arccosh` ではなく **`arcosh`**）。定義は人手証明
`gamma_is_continuous` Step 2 の明示式とまったく同じであり、Step 2 が証明している内容も
`Real.cosh_arcosh` としてすでに存在する。**自前定義は不要だった。**

本セッションでは自前定義を作らず mathlib のものを使った。
`lean/README.md` は本セッションでは編集していない（規約により編集禁止）ので、
呼び出し元が README を更新するときにこの行を直すこと。

---

## 5. mathlib に**無かった**もの（探索の記録）

章 012 の実数解析部分について、次を探して**見つからなかった**。

| 探したもの | 検索した名前・場所 | 結果 |
| --- | --- | --- |
| 等分割リーマン和 → 積分の収束 | `Riemann sum` / `riemann_sum` / `RiemannSum` を `Mathlib/` 全体に grep | **該当なし**（`Mathlib/Analysis/SumIntegralComparisons.lean` は単調関数の和と積分の比較で、目的が異なる） |

したがって `riemann_sum_to_integral` は本リポジトリで証明する必要があり、
`Ising2D/Abstract/RiemannSum.lean` として実装した。使った mathlib の部品は次のとおりで、
人手証明が (R1)(R2) として挙げた外部事実にそのまま対応する。

| 人手証明 | mathlib |
| --- | --- |
| (R1) Heine–Cantor | `IsCompact.uniformContinuousOn_of_continuous`（`Mathlib/Topology/UniformSpace/HeineCantor.lean`）、`Metric.uniformContinuousOn_iff` |
| (R2) 連続関数の可積分性 | `Continuous.intervalIntegrable` |
| (R2) 区間加法性 | `intervalIntegral.sum_integral_adjacent_intervals`（`Mathlib/MeasureTheory/Integral/IntervalIntegral/Basic.lean:1114`） |
| (R2) `\|∫_I g\| ≤ \|I\| sup_I \|g\|` | `intervalIntegral.norm_integral_le_of_norm_le_const`（同 `:768`） |
| (R2) 定数の積分 | `intervalIntegral.integral_const` |

**すなわち (R1)(R2) はいずれも mathlib に存在し、新たな公理を持ち込む必要は無かった。**

---

## 6. 形式化していない部分（章 011 への依存）

`limit_of_log_Z_in_N_row` が入力として使う次の 3 つは、**別セッションが並行して
章 011 を形式化しているため import による結合をせず、仮定として受け取った**。

- `partition_function_sandwich`: `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`
- `def_rayleigh_sup`: `c(M) > 0`
- `def_partition_function_2d_ising`: `Z > 0`（挟み撃ちの下側から従うので明示仮定にしていない）

`Ising2D.limit_of_log_Z_in_N_row`（`lean/Ising2D/Part012/Claim003_LimitInNRow.lean`）は
「これらを認めれば `N_row → ∞` の極限が `(1/M) log c(M)` になること」を主張する。
章 011 の形式化が入った時点で仮定を実際の定理で埋めればよい。

同様に、`Λ^{(δ)}_M` と章 011 の `c(M)`・`eigenvalues_of_V` の `Λ_max` との同定
（`c_+(M) = Λ^{(1/2)}_M` 等）は章 013〜018 の内容であり、本章の主張ではないので
形式化の対象外とした（`freeenergy_006_remark_remaining_input` は解説の remark であり
数学的主張を含まないので形式化していない）。
