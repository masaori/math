/-
# `g^2 = 1 + r^2` から `e^{±arcosh g} = g ± r` を出す（**必要十分版**）

対応する人手証明のラベル: `gamma_theta_tilde_mu_positive`, `lambda_eq_exp_gamma_theta_tilde`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_008_claim_gamma_theta_tilde_positive`, `Athetatilde_009_claim_lambda_eq_exp_gamma`）

具体版: `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/DefinitionGammaTildeMu.lean`（`gammaTilde_pos` と
`λ_{±,μ} = e^{±γ(θ~_μ)}`）と `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/TheoremMaxEigenvalueSimple.lean`
（`gammaFn_thetaTilde_pos`）。

## mathlib の状況

`Real.arcosh`（綴りは `arccosh` ではない）は mathlib v4.32.1 に存在する。
詳細は `Ising2D/NecSuf/Arcosh.lean` 冒頭を参照（`lean/README.md` の
「mathlib に `Real.arccosh` は無い」という記述は誤りである）。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明 `lambda_eq_exp_gamma_theta_tilde` の Step 1・Step 2 は
`cosh γ = γ_1`、`γ_1^2 = 1 + |γ_2|^2` から `sinh γ = |γ_2|` を出し、
`e^{±γ} = cosh γ ± sinh γ` で結論する。ここに効いているのは

* **`cosh^2 - sinh^2 = 1`**（`sinh γ` の 2 乗が決まる）
* **`γ ≥ 0` すなわち `sinh γ ≥ 0`**（2 乗から符号を決める分岐の解消）
* **`e^{±x} = cosh x ± sinh x`**（定義そのもの）

の 3 つだけである。`γ_1`, `γ_2` が Ising 模型の量であることも、`θ` が半整数運動量であることも、
`|γ_2|` が絶対値であること（`r ≥ 0` しか使わない）も、`M` も効いていない。
**とくに固有値の分離 `λ_+ > 1 > λ_- > 0` に効いているのは `r > 0` の一点だけ**であり、
整数運動量で分離が壊れうるのは、そこで `r = |γ_2(θ_μ)|` が `0` になりうるからである。
-/
import Mathlib.Analysis.SpecialFunctions.Arcosh
import Ising2D.NecSuf.SquareIsProduct

namespace Ising2D.NecSuf

/-- 補助（人手証明 `gamma1_gt_1_theta_tilde` の準備の第二の含意の鎖の後半）: `0 < a` なら `0 < a^2`。
具体版 `gamma1_gt_1_prep_absGamma2_sq_pos` の 3 段（`a·a > 0·a` → `0·a = 0` で `a·a > 0` → 冪へ戻して `a^2 > 0`）と同じ並び。
効くのは、正の元を右から掛けると狭義の不等号が保たれること（`MulPosStrictMono`）、鎖の `a` での `0·a = 0`（仮定 `h0a`）、
冪の定義の 2 つの式と `1` が乗法の単位元であること（`sq_eq_mul_self'`）だけである。`Monoid R` は乗法と冪のため、`Zero R` は `0` を置くため
（乗法を持たないので、`Monoid R` と並べても乗法は 1 つ）、`Preorder R` は `MulPosStrictMono` の定義が前提にするためだけに置く
（推移律・反射律は使わない）。`0·a = 0` は全ての元についての公理ではなく、`a` の 1 点の等式を仮定に取る
（`MonoidWithZero` は使わない `a·0 = 0` と、`a` 以外の元での `0·b = 0` を連れてくる）。
`NegConjPair.lean` の `sq_pos_of_pos_chain` と主張は同じだが、段の順が人手の `gamma1_gt_1_theta_tilde` の準備に合わせて違う。 -/
theorem sq_pos_of_pos_implication_chain {R : Type*} [Monoid R] [Zero R] [Preorder R] [MulPosStrictMono R]
    {a : R} (h0a : (0 : R) * a = 0) (ha : 0 < a) : 0 < a ^ 2 := by
  have h1 : 0 * a < a * a := mul_lt_mul_of_pos_right ha ha   -- `a > 0` の両辺に `0 < a` を掛ける
  have h2 : 0 < a * a := by rw [h0a] at h1; exact h1          -- 仮定 `0·a = 0`
  rw [sq_eq_mul_self' a]; exact h2                            -- `square_of_real_number_is_product` を右辺から左辺へ

/-- 補助（人手証明 `gamma1_gt_1_theta_tilde` の背理の鎖）: `0 < t` かつ `t ≤ 1` なら `t^2 ≤ 1`。
具体版 `gamma1R_thetaTilde_sq_le_one_of_le_one` の 4 段と同じ並び。

効くのは、冪の定義の 2 つの式と `1` が乗法の単位元であること（`sq_eq_mul_self'`。`Monoid`）、
非負の元を右から掛けると `≤` が保たれること（`MulPosMono`。2 段目は `0 < t` を `0 ≤ t` に弱めて使う）、
非負の元を左から掛けると `≤` が保たれること（`PosMulMono`）、`0 ≤ 1`（`ZeroLEOneClass`。人手は `0 < 1` と書くが
`≤` の単調性には非負で足りる）だけである。加法・積の可換性・逆元・全順序は効いていない。
`Preorder R` は、mathlib の `MulPosMono`・`PosMulMono` の定義が前提にするため、`0 < t` から `0 ≤ t` を出すため、
2 段目と 3 段目の `≤` を合成する推移律（人手の鎖の結論 `g^2 ≤ 1` を出す段）のために置く。 -/
theorem sq_le_one_of_le_one_chain {R : Type*} [Monoid R] [Zero R] [Preorder R] [ZeroLEOneClass R]
    [MulPosMono R] [PosMulMono R] {t : R} (ht : 0 < t) (h : t ≤ 1) : t ^ 2 ≤ 1 :=
  calc t ^ 2
      = t * t := sq_eq_mul_self' t                          -- `square_of_real_number_is_product`（`r → t`）
    _ ≤ 1 * t := mul_le_mul_of_nonneg_right h ht.le         -- `t ≤ 1` の両辺に `0 < t` を右から掛ける
    _ ≤ 1 * 1 := mul_le_mul_of_nonneg_left h zero_le_one    -- `t ≤ 1` の両辺に `0 ≤ 1` を左から掛ける
    _ = 1 := mul_one 1                                      -- `1` は乗法の単位元

/-- 補助（人手証明 `gamma1_gt_1_theta_tilde` の結論の段）: `0 < t` かつ `1 < t^2` なら `1 < t`。
具体版 `one_lt_gamma1R_thetaTilde` と同じく、`t ≤ 1` を仮定して背理の鎖 `sq_le_one_of_le_one_chain` から
`1 < t^2 ≤ 1` を出し、順序の非反射律で矛盾させ、全順序（`not_le`）で `1 < t` を得る。
ここで初めて全順序（`LinearOrder`）が効く（`t ≤ 1` でないことから `1 < t` を出す段）。 -/
theorem one_lt_of_sq_gt_one {R : Type*} [Monoid R] [Zero R] [LinearOrder R] [ZeroLEOneClass R]
    [MulPosMono R] [PosMulMono R] {t : R} (ht : 0 < t) (h : 1 < t ^ 2) : 1 < t :=
  lt_of_not_ge fun hle : t ≤ 1 =>
    lt_irrefl (1 : R) (lt_of_lt_of_le h (sq_le_one_of_le_one_chain ht hle))

/-- **必要十分版 Step 1**: `1 ≤ g`, `0 ≤ r`, `g^2 = 1 + r^2` なら `sinh (arcosh g) = r`。 -/
theorem sinh_arcosh_of_sq {g r : ℝ} (hg : 1 ≤ g) (hr : 0 ≤ r) (h : g ^ 2 = 1 + r ^ 2) :
    Real.sinh (Real.arcosh g) = r := by
  have hcosh : Real.cosh (Real.arcosh g) = g := Real.cosh_arcosh hg
  have hnn : 0 ≤ Real.sinh (Real.arcosh g) :=
    Real.sinh_nonneg_iff.2 (Real.arcosh_nonneg hg)
  have hsq : Real.sinh (Real.arcosh g) ^ 2 = r ^ 2 := by
    have := Real.cosh_sq_sub_sinh_sq (Real.arcosh g)
    rw [hcosh] at this
    nlinarith [this, h]
  nlinarith [hsq, hnn, hr]

/-- **必要十分版 Step 2**: `e^{+arcosh g} = g + r`。 -/
theorem exp_arcosh_of_sq {g r : ℝ} (hg : 1 ≤ g) (hr : 0 ≤ r) (h : g ^ 2 = 1 + r ^ 2) :
    Real.exp (Real.arcosh g) = g + r := by
  have hs := sinh_arcosh_of_sq hg hr h
  have hc : Real.cosh (Real.arcosh g) = g := Real.cosh_arcosh hg
  have := Real.cosh_add_sinh (Real.arcosh g)
  rw [hc, hs] at this
  exact this.symm

/-- **必要十分版 Step 2**: `e^{-arcosh g} = g - r`。 -/
theorem exp_neg_arcosh_of_sq {g r : ℝ} (hg : 1 ≤ g) (hr : 0 ≤ r) (h : g ^ 2 = 1 + r ^ 2) :
    Real.exp (-Real.arcosh g) = g - r := by
  have hs := sinh_arcosh_of_sq hg hr h
  have hc : Real.cosh (Real.arcosh g) = g := Real.cosh_arcosh hg
  have hsum := Real.cosh_sub_sinh (Real.arcosh g)
  rw [hc, hs] at hsum
  exact hsum.symm

/-- **必要十分版**: `1 < g` なら `arcosh g > 0`（人手証明 `gamma_theta_tilde_mu_positive`）。

具体版 `gammaFn_thetaTilde_pos`・`gammaTilde_pos` と同じ手順: 準備の `arcosh g ≥ 0`・`cosh(arcosh g) = g`
（`arccosh_properties` (1)・(2)）、`arcosh g = 0` と仮定したときの鎖
`g = cosh(arcosh g) = cosh 0 = (exp 0 + exp(−0))/2 = (exp 0 + exp 0)/2 = (1 + 1)/2 = 1` の 6 行、
`1 > 1` の矛盾から `arcosh g ≠ 0`、`arcosh g ≥ 0` と合わせて `arcosh g > 0`。
使うのは `cosh ∘ arcosh = id`（`[1,∞)` 上）・`arcosh ≥ 0`・`cosh` の定義・`−0 = 0`・`exp 0 = 1`・ℝ の四則と順序だけで、
`g` が Ising 模型の量 `γ_1(θ~_μ)` であることは効いていない。 -/
theorem arcosh_pos_of_one_lt {g : ℝ} (hg : 1 < g) : 0 < Real.arcosh g := by
  -- 人手の `t := γ(θ~_μ)` は、ここでは `t := arcosh g` である（以下の注の `t` はこれを指す）
  have hg1 : 1 ≤ g := hg.le                                          -- とくに `g ≥ 1`
  have ht0 : 0 ≤ Real.arcosh g := Real.arcosh_nonneg hg1             -- `arccosh_properties` (1)
  have hcosh : Real.cosh (Real.arcosh g) = g := Real.cosh_arcosh hg1  -- `arccosh_properties` (2)
  have hne : Real.arcosh g ≠ 0 := by
    intro h0
    have hchain : g = 1 :=
      calc g = Real.cosh (Real.arcosh g) := hcosh.symm              -- 準備の `cosh t = g`
        _ = Real.cosh 0 := by rw [h0]                                -- 仮定 `t = 0`
        _ = (Real.exp 0 + Real.exp (-0)) / 2 := Real.cosh_eq 0       -- `def_cosh_sinh`
        _ = (Real.exp 0 + Real.exp 0) / 2 := by rw [neg_zero]        -- `real_negation_of_zero_is_zero`
        _ = (1 + 1) / 2 := by rw [Real.exp_zero]                     -- `scalar_exp_zero`（`K = ℝ`）
        _ = 1 := by norm_num                                         -- ℝ の四則
    have h11 : (1 : ℝ) < 1 := by rw [hchain] at hg; exact hg        -- 準備の `g > 1` と合わせて `1 > 1`
    exact lt_irrefl (1 : ℝ) h11
  exact lt_of_le_of_ne ht0 (Ne.symm hne)                            -- `t ≠ 0` と `t ≥ 0` から `t > 0`

end Ising2D.NecSuf
