/-
# `g^2 = 1 + r^2` から `e^{±arcosh g} = g ± r` を出す（**必要十分版**）

対応する人手証明のラベル: `def_gamma_theta_tilde_mu`, `lambda_eq_exp_gamma_theta_tilde`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_008_definition_gamma_theta_tilde`, `Athetatilde_009_claim_lambda_eq_exp_gamma`）

具体版: `Ising2D/Part015/Definition008_GammaTildeMu.lean`。

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

namespace Ising2D.NecSuf

/-- 補助（人手証明 `gamma1_gt_1_theta_tilde` Step 3）:
線型順序体で `0 < t` かつ `1 < t^2` なら `1 < t`。 -/
theorem one_lt_of_sq_gt_one {t : ℝ} (ht : 0 < t) (h : 1 < t ^ 2) : 1 < t := by
  nlinarith [h, ht]

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

/-- **必要十分版**: `1 < g` なら `arcosh g > 0`（人手証明 `def_gamma_theta_tilde_mu` の末尾）。

mathlib に `Real.arcosh_pos` があるのでその言い換えにすぎない
（人手証明は「`γ = 0` なら `γ_1 = cosh 0 = 1` で矛盾」と述べており、内容も同じ）。 -/
theorem arcosh_pos_of_one_lt {g : ℝ} (hg : 1 < g) : 0 < Real.arcosh g := Real.arcosh_pos hg

end Ising2D.NecSuf
