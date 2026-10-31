/-
# `T_{(V^{(+)})}` の `check(Z)_μ, check(Y)_μ` への作用の `A(θ~_μ) = B_1(θ~_μ) B_2 B_1(θ~_μ)` による表示

対応する人手証明（正本は `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`）:

* `reduction_to_A_theta_claim_T_V_plus_check_Z_Y_via_B1_B2_B1`
  （ラベル **`T_V_plus_check_Z_Y_via_B1_B2_B1`**）

主張: `μ ∈ M̌` について

  `(T_{(V^{(+)})}(check(Z)_μ), T_{(V^{(+)})}(check(Y)_μ))
     = (check(Z)_μ, check(Y)_μ) A(θ~_μ)
     = (check(Z)_μ, check(Y)_μ) B_1(θ~_μ) B_2 B_1(θ~_μ)`。

行ベクトル記法は `Ising2D.ActsBy`（`B` の**列**が像の係数）なので、一続きの等式の 2 本は
`ActsBy … (AMat K θ~_μ)` と `ActsBy … (B1mat · B2mat · B1mat)` の 2 本の主張になる。

## 人手証明との対応

人手の証明は式変形 2 行で、各行が次の定理の適用に当たる。

1. `(T(check(Z)_μ), T(check(Y)_μ)) = (check(Z)_μ, check(Y)_μ) A(θ~_μ)`: `T_V_plus_check_Z_Y`（`TVPlus_checkZ_checkY`）
2. `A(θ~_μ) = B_1(θ~_μ) B_2 B_1(θ~_μ)`: `factorization_of_A_theta_general` を `θ = θ~_μ` として
   （`factorization_of_A_thetaTilde`）

人手の主張は既存の二つの主張を続けるだけなので、必要十分版は置かない（1 行目の必要十分版は
`Ising2D.NecSuf.actsBy_TV_sandwich` が持つ）。
-/
import Ising2D.Part014.Claim010_TVPlusAction

namespace Ising2D

variable {M : ℕ}

/-- **人手 `T_V_plus_check_Z_Y_via_B1_B2_B1`**。 -/
theorem T_V_plus_check_Z_Y_via_B1_B2_B1 (hM : M ≠ 0) (K : IsingConst) (μ : ℤ) (K1 K2star : ℂ)
    {s2 : ℝ} (hs2 : 0 < s2)
    (hc1 : (K.c1 : ℂ) = Complex.cosh (2 * K1))
    (hs1 : (K.s1 : ℂ) = Complex.sinh (2 * K1))
    (hc2star : (K.c2star : ℂ) = Complex.cosh (2 * K2star))
    (hs2star : (K.s2star : ℂ) = Complex.sinh (2 * K2star))
    (hdual : (K.s2star : ℂ) * (K.c2 : ℂ) = (K.c2star : ℂ)) :
    ActsBy (TVPlus M hs2 K1 K2star).toLinearMap (checkZ M μ) (checkY M μ)
        (AMat K (thetaTilde M μ))
      ∧ ActsBy (TVPlus M hs2 K1 K2star).toLinearMap (checkZ M μ) (checkY M μ)
        (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ) * B2mat K2star
          * B1mat K1 ((thetaTilde M μ : ℝ) : ℂ)) := by
  have h1 := TVPlus_checkZ_checkY hM K μ K1 K2star hs2 hc1 hs1 hc2star hs2star hdual  -- 人手の 1 行目
  refine ⟨h1, ?_⟩
  rwa [factorization_of_A_thetaTilde (M := M) K K1 K2star μ hc1 hs1 hc2star hs2star hdual]  -- 人手の 2 行目

end Ising2D
