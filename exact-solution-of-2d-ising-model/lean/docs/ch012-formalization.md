# 章 012「自由エネルギーと熱力学極限」の形式化

人手証明の正本: `structured-latex/content/012_free_energy.ts`（7 ブロック）
Lean: `Ising2D/Part012/`（具体版）、`Ising2D/NecSuf/`（必要十分版）

**この文書は `lean/README.md` へ統合されるまでの暫定の置き場である**（統合は呼び出し元が行う）。
形式化の過程で見つかった原文の問題は
`docs/tasks/2026-07_lean-ch009-013/012_ch012-formalization-findings.md` に書いた。

---

## 1. 形式化した定理の一覧

### 具体版（人手証明と同じ抽象度）

| Lean の名前 | 内容 | 対応する人手証明のラベル |
| --- | --- | --- |
| `Ising2D.IsingParam` | `K_1, K_2, K_2^* ∈ ℝ_{>0}` を束ねた前提 | `def_transfer_matrix_symbols` |
| `Ising2D.IsingParam.const` | `c_1 = cosh 2K_1` 等で `IsingConst` を作る | 同上 |
| `Ising2D.gamma1R` | `γ_1(θ) = c_1c_2^* - s_1s_2^*\cos θ` の実数版 | `def_A_theta` |
| `Ising2D.gamma1_eq_ofReal` | 既存の ℂ 版 `gamma1` が `gamma1R` の埋め込みであること | 定義の突き合わせ |
| `Ising2D.gamma1R_ge_cosh_sub` | `γ_1(θ) ≥ cosh(2K_1-2K_2^*)`（`∀θ ∈ ℝ`） | `gamma1_lower_bound_all_theta` 第 1 式 |
| `Ising2D.one_le_gamma1R` | `γ_1(θ) ≥ 1`（`∀θ ∈ ℝ`） | 同 第 2 式 |
| `Ising2D.gamma1_lower_bound_all_theta` | 上 2 つを並べた形 | `gamma1_lower_bound_all_theta` |
| `Ising2D.gammaFn` | `γ(θ) := arcosh(γ_1(θ))` | `def_gamma_theta_mu` の実数 `θ` への拡張 |
| `Ising2D.gammaFn_eq` | `γ` の明示形（`cosh 2K_1 cosh 2K_2^* - sinh 2K_1 sinh 2K_2^* cos θ` の `arcosh`） | `onsager_free_energy_expression` の `γ` |
| `Ising2D.gammaFn_nonneg` | `γ(θ) ∈ ℝ_{≥0}` | `gamma1_lower_bound_all_theta` 結論の後半 |
| `Ising2D.cosh_gammaFn` | `cosh γ(θ) = γ_1(θ)` | 同上（`arccosh` が逆写像であること） |
| `Ising2D.continuous_gamma1R` | `γ_1` は連続 | `gamma_is_continuous` Step 1 前半 |
| `Ising2D.gamma1R_periodic` | `γ_1(θ+2π) = γ_1(θ)` | 同 Step 1 後半 |
| `Ising2D.gamma_is_continuous` | **`γ` は `ℝ` 上連続** | `gamma_is_continuous` 前半 |
| `Ising2D.gammaFn_periodic` | `γ(θ+2π) = γ(θ)` | 同 後半 |
| `Ising2D.abs_log_Z_sub_log_c_le` | `\|(1/(MN))log Z - (1/M)log c\| ≤ (log 2)/N` | `limit_of_log_Z_in_N_row` の誤差評価 |
| `Ising2D.limit_of_log_Z_in_N_row` | **`(1/(M N_row))log Z → (1/M)log c(M)`** | `limit_of_log_Z_in_N_row` |
| `Ising2D.tagPoint` | `t^{(M)}_μ = 2π(μ-δ)/M` | `riemann_sum_to_integral` |
| `Ising2D.sum_Icc_one_eq_sum_range` / `sum_Icc_eq_sum_range_tag` | 添字の付け替え `μ = k+1` | 同上（記法の橋渡し） |
| `Ising2D.riemann_sum_to_integral_error` | **`\|(1/M)Σγ(t_μ) - (1/2π)∫₀^{2π}γ\| ≤ ω(2π/M)`** | `riemann_sum_to_integral` statement の評価 |
| `Ising2D.tendsto_modulus_gamma` | `ω(2π/M) → 0`（(R1) の帰結） | 同 Step 4 |
| `Ising2D.riemann_sum_to_integral` | **`(1/M)Σ g(t^{(M)}_μ) → (1/2π)∫₀^{2π} g`（★実数解析への移行点）** | `riemann_sum_to_integral` |
| `Ising2D.riemann_sum_to_integral_indep_delta` | 極限は `δ ∈ [0,1)` に依らない | 同 statement 末尾 |
| `Ising2D.LambdaM` | `Λ^{(δ)}_M = (2 sinh 2K_2)^{M/2}\exp((1/2)Σγ)` | `onsager_free_energy_expression` |
| `Ising2D.two_sinh_pos` / `LambdaM_pos` | `2 sinh 2K_2 > 0`、`Λ^{(δ)}_M > 0` | 同 proof 冒頭 |
| `Ising2D.log_LambdaM` | `log Λ = (M/2)log(2 sinh 2K_2) + (1/2)Σγ` | 同 proof 第 1 式 |
| `Ising2D.inv_M_log_LambdaM` | `(1/M)log Λ = (1/2)log(2 sinh 2K_2) + (1/2)(1/M)Σγ` | 同 proof 第 2 式 |
| `Ising2D.onsager_free_energy_expression` | **`(1/M)log Λ^{(δ)}_M → (1/2)log(2 sinh 2K_2) + (1/4π)∫₀^{2π}γ`** | `onsager_free_energy_expression` |
| `Ising2D.onsager_free_energy_expression_indep_delta` | 右辺が `δ` に依らないこと | 同 statement の「右辺は `δ` に依らない」 |

### 必要十分版（`Ising2D.NecSuf`）

| Lean の名前 | 内容 | ファイル |
| --- | --- | --- |
| `Ising2D.NecSuf.continuous_arcosh_comp` | 値が `1` 以上の連続関数と `arcosh` の合成は連続（**定義域は任意の位相空間**） | `NecSuf/Arcosh.lean` |
| `Ising2D.NecSuf.cosh_sub_le_cosh_mul_cosh_sub` | `x ≤ 1`, `sinh u sinh v ≥ 0` ⇒ `cosh(u-v) ≤ cosh u cosh v - sinh u sinh v · x` | `NecSuf/CoshLowerBound.lean` |
| `Ising2D.NecSuf.one_le_cosh_mul_cosh_sub` | 上の下界がさらに `1` 以上 | 同上 |
| `Ising2D.NecSuf.node` / `tag` | 等分点と代表点（任意の `[a,b]`、任意のずらし `δ`） | `NecSuf/RiemannSum.lean` |
| `Ising2D.NecSuf.abs_integral_sub_riemann_sum_le` | 誤差評価（`ε` を仮定で受け取る形。**周期性不要・`δ ∈ [0,1]`・任意の `[a,b]`**） | 同上 |
| `Ising2D.NecSuf.modulus` | 連続度 `ω(h)`（`sSup` で定義） | 同上 |
| `Ising2D.NecSuf.bddAbove_modulusSet` / `le_modulus` / `modulus_nonneg` / `modulus_le` | `ω` が well-defined であることと基本性質 | 同上 |
| `Ising2D.NecSuf.abs_integral_sub_riemann_sum_le_modulus` | 誤差評価（`ε = ω`） | 同上 |
| `Ising2D.NecSuf.tendsto_modulus_atTop` | `ω((b-a)/M) → 0`（(R1) Heine–Cantor） | 同上 |
| `Ising2D.NecSuf.tendsto_riemann_sum` | **等分割リーマン和 → 積分の平均値**（必要十分版） | 同上 |
| `Ising2D.NecSuf.abs_log_div_sub_log_le_of_sandwich` | `c^N ≤ Z ≤ B c^N` ⇒ `\|log Z/N - log c\| ≤ log B/N` | `NecSuf/LogSqueeze.lean` |
| `Ising2D.NecSuf.log_rpow_mul_exp` | `log(A^r e^S) = r log A + S`（`A > 0`） | 同上 |
| `Ising2D.NecSuf.tendsto_affine` | 収束列のアフィン変換は収束する | 同上 |

---

## 2. 2 本立ての対応表と「必要十分版で判明した本質」

| 人手証明のラベル | 具体版 | 必要十分版 | 具体版を必要十分版の系として導出しているか |
| --- | --- | --- | --- |
| `gamma1_lower_bound_all_theta` | `Ising2D.gamma1R_ge_cosh_sub` / `one_le_gamma1R` | `NecSuf.cosh_sub_le_cosh_mul_cosh_sub` / `one_le_cosh_mul_cosh_sub` | **している**（`gamma1R_ge_cosh_sub` の証明が必要十分版の特殊化） |
| `gamma_is_continuous` | `Ising2D.gamma_is_continuous` | `NecSuf.continuous_arcosh_comp` | **している**（1 行の特殊化） |
| `limit_of_log_Z_in_N_row` | `Ising2D.abs_log_Z_sub_log_c_le` / `limit_of_log_Z_in_N_row` | `NecSuf.abs_log_div_sub_log_le_of_sandwich` | **している**（`B = 2^M` を代入して `M` で割る） |
| `riemann_sum_to_integral` | `Ising2D.riemann_sum_to_integral_error` / `riemann_sum_to_integral` | `NecSuf.abs_integral_sub_riemann_sum_le_modulus` / `NecSuf.tendsto_riemann_sum` | **している**（`a = 0`, `b = 2π` の特殊化と添字の付け替え） |
| `onsager_free_energy_expression` | `Ising2D.log_LambdaM` / `inv_M_log_LambdaM` / `onsager_free_energy_expression` | `NecSuf.log_rpow_mul_exp` / `NecSuf.tendsto_affine`（＋上の `tendsto_riemann_sum`） | **している** |

### 必要十分版で判明した本質（本文には持ち込まないが、解説パートの素材になる）

- **`riemann_sum_to_integral` に `g` の周期性はまったく効いていない。**
  人手証明は `g` に「連続かつ周期 `2π`」を仮定し、最後の括弧で
  「`δ = 0` のとき代表点が区間の端点 `2π` になるのを許すために周期性を使う」と述べているが、
  代表点は閉区間 `I_μ` に属していればよいので `g(2π) = g(0)` を比べる必要はどこにもない。
  必要十分版は周期性の仮定なしで通っており、証明中に `g(b) = g(a)` は現れない。
- **区間が `[0,2π]` であることも効いていない。** 任意の有界閉区間 `[a,b]`（`a ≤ b`）でよい。
  `2π` は「小区間の幅 `(b-a)/M`」と「平均を取る割り算」にしか現れない。
- **`δ ∈ [0,1)` の右端が開である必要もない。** `δ ∈ [0,1]` で成り立ち、
  `δ = 1` は各小区間の左端点を代表点に取る場合にあたる。
  したがって「整数運動量（`δ=0`）と半整数運動量（`δ=1/2`）で極限が同じ」という結論は、
  **代表点の取り方が小区間の中である限り何でもよい**という、より強い事実の特殊例である。
- 残る本質は 3 つだけである: `g` の `[a,b]` 上の連続性（可積分性と一様連続性）、
  代表点が対応する小区間に属すること、積分の区間加法性・定数の積分・`|∫_I h| ≤ |I| sup_I |h|`。
  これは人手証明が (R1)(R2) として明示したものと一致する。
- **`limit_of_log_Z_in_N_row` に Ising 模型の構造はまったく効いていない。**
  効いているのは挟み撃ちの形 `c^N ≤ Z ≤ B c^N`（`c > 0`, `B ≥ 1`）と、
  `log` の単調性・`log(xy) = log x + log y`・`log(x^N) = N log x` だけである。
  `B = 2^M` という具体形も、行列も転送行列も跡も固有値も出てこない。
  人手証明が得ている `\|log Z/(MN) - log c/M\| ≤ log 2/N` は、必要十分版の
  `\|log Z/N - log c\| ≤ log B/N` の両辺を `M` で割って `log 2^M = M log 2` が
  約分された結果にすぎない（`M` で割るのは線型な後処理）。
- **`γ_1` の下界に `cos` であることは効いていない。** 効いているのは
  「`cos θ ≤ 1`」と「`sinh 2K_1 · sinh 2K_2^* ≥ 0`」の 2 つだけで、
  `cos θ` は「`1` 以下の任意の実数」に置き換えられる。
  人手証明が `K_1, K_2^* > 0` から `s_1 s_2^* > 0`（狭義）を出しているが、
  不等式には `≥ 0` で十分である。
- **`arcosh` の連続性の合成に定義域が `ℝ` であることは効いていない。**
  必要なのは「連続で値が `1` 以上」だけで、定義域は任意の位相空間でよい。
  mathlib 側が `ContinuousOn Real.arcosh (Ici 1)` と区間つきで述べているのに対し、
  合成の形にすると区間への制限が消えることも、この抽象化で見える。
- **`onsager_free_energy_expression` の残りは代数と極限の後処理だけである。**
  `log(A^{M/2} e^{S}) = (M/2)log A + S`（`A > 0`）と、収束列の定数倍・定数加算。
  Ising 模型の構造は何も効いていない。

---

## 3. 形式化していない主張とその理由

| 人手証明のブロック | 形式化の状況 | 理由 |
| --- | --- | --- |
| `freeenergy_000_remark_escape_to_real_analysis`（`remark_real_analysis_escape_point`） | 形式化していない | (R1)(R2) の宣言と「移行点はここだけ」という**メタな注記**であり、数学的主張を含まない。ただし「外部から持ち込む事実は 2 つだけ」という記述は不正確（`docs/tasks/2026-07_lean-ch009-013/012_...md` の 1 節） |
| `freeenergy_006_remark_remaining_input`（`remark_remaining_input_even_sector`） | 形式化していない | 章 013〜018 への道筋を説明する remark であり、数学的主張を含まない |
| `limit_of_log_Z_in_N_row` の入力（`partition_function_sandwich`, `def_rayleigh_sup`） | **仮定として受け取った** | 章 011 を別セッションが並行して形式化中のため、import による結合を避けた。仮定は `Ising2D.limit_of_log_Z_in_N_row` の `hc`, `h1`, `h2` |
| `Λ^{(δ)}_M` と `c(M)` / `Λ_max` の同定 | 形式化していない | 章 013〜018 の内容で、本章の主張ではない |

**`sorry` / `admit` はゼロ。** `Λ^{(δ)}_M` は本章内で人手証明の式そのままに定義してあるので、
章 011・013 の形式化が入った時点で `c(M)` との同定を橋渡しの補題として追加すればよい。

---

## 4. mathlib の探索結果（一次情報）

- **等分割リーマン和 → 積分の収束は mathlib に無い。**
  `Riemann sum` / `riemann_sum` / `RiemannSum` を `Mathlib/` 全体に grep して該当なし。
  `Mathlib/Analysis/SumIntegralComparisons.lean` は単調関数の和と積分の比較で目的が異なる。
  したがって `NecSuf/RiemannSum.lean` で自前に証明した。
- **`Real.arcosh` は mathlib にある**（`Mathlib/Analysis/SpecialFunctions/Arcosh.lean`）。
  `lean/README.md` の「mathlib に無いことが分かっているもの: `Real.arccosh`（自前定義が必要）」は
  現行の mathlib（`v4.32.1`）では**誤り**である。綴りが `arccosh` ではなく `arcosh` であることに注意。
  定義 `Real.arcosh x = log (x + √(x^2-1))` は人手証明 `gamma_is_continuous` Step 2 の
  明示式とまったく同じで、Step 2 の内容も `Real.cosh_arcosh` として存在する。
- (R1)(R2) に対応する mathlib の補題（すべて存在）:
  `IsCompact.uniformContinuousOn_of_continuous`, `Metric.uniformContinuousOn_iff`,
  `Continuous.intervalIntegrable`, `intervalIntegral.sum_integral_adjacent_intervals`,
  `intervalIntegral.norm_integral_le_of_norm_le_const`, `intervalIntegral.integral_const`。
