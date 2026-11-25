/-
# `sin θ~_μ = 0` なら `cos θ~_μ = -1`（具体版を必要十分版から導く）

具体版 `ClaimGamma2TildeNonzero.lean` の `cos_thetaTilde_eq_neg_one_of_sin_eq_zero` の主張を、必要十分版
`Ising2D/NecSuf/OddModePhase.lean` の `cos_eq_neg_one_of_sin_eq_zero_of_odd` の `N := M`、`m := 2μ − 1`、`θ := θ~_μ`
への特殊化として得る。仮定 `Odd m` には `odd_two_mul_sub_one`、`N·θ = m·π` には `thetaTilde_mul_M` を渡す。
人手のラベルは `gamma_2_theta_tilde_nonzero`。
`thetaTilde_mul_M`・`odd_two_mul_sub_one` は、必要十分版の仮定へ渡すためだけの補題なので、このファイルに置く
（具体版は人手の Step 2 のとおり `θ~_μ = kπ` から `2μ − 1 = kM_col` を経るので、これらを使わない）。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimGamma2TildeNonzero
import Ising2D.NecSuf.OddModePhase

namespace Ising2D

/-- **015 章の要**: `M · θ~_μ = (2μ-1)π`。右辺の係数 `2μ-1` は**奇数**である。

整数運動量では `M · θ_μ = 2μ · π`（偶数倍）であり、この違いが
`gamma_2_theta_tilde_nonzero` の例外の有無を生む。 -/
theorem thetaTilde_mul_M (M : ℕ) (hM : M ≠ 0) (μ : ℤ) :
    (M : ℝ) * thetaTilde M μ = ((2 * μ - 1 : ℤ) : ℝ) * Real.pi := by
  have hM' : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [thetaTilde, inclusionNNtoZZ_eq_natCast]   -- 分母の像 `ι_{ℕ→ℤ}(M)` を Lean の `Nat.cast` へ移す
  push_cast
  field_simp

/-- `2μ-1` が奇数であること（`thetaTilde_mul_M` と組で使う）。 -/
theorem odd_two_mul_sub_one (μ : ℤ) : Odd (2 * μ - 1) := ⟨μ - 1, by ring⟩

/-- `cos_thetaTilde_eq_neg_one_of_sin_eq_zero` を `NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd`
（`N := M`、`m := 2μ − 1`）の特殊化として得る。 -/
theorem cos_thetaTilde_eq_neg_one_of_sin_eq_zero_of_necSuf {M : ℕ} (hM : M ≠ 0) (μ : ℤ)
    (hsin : Real.sin (thetaTilde M μ) = 0) : Real.cos (thetaTilde M μ) = -1 :=
  NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd (N := (M : ℤ)) (m := 2 * μ - 1)
    (odd_two_mul_sub_one μ) (by exact_mod_cast thetaTilde_mul_M M hM μ) hsin

end Ising2D
