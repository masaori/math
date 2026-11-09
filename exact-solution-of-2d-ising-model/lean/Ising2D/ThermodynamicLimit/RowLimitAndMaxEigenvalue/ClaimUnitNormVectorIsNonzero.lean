/-
# `‖x‖ = 1` なら `x ≠ 0`（**具体版**）

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_claim_unit_norm_vector_is_nonzero`、ラベル **`unit_norm_vector_is_nonzero`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `x = 0` と仮定する | `rintro rfl` |
| `‖x‖ = √(Σ_j\|x_j\|^2)`（`def_matrix_norm`、`K = ℝ`） | `h0` の `calc` の 1 段目 |
| `x_j = 0` を各項へ | 2 段目 |
| `\|0\| = 0` を各項へ（`def_real_absolute_value`） | 3 段目 |
| `0^2 = 0` を各項へ | 4 段目 |
| 和を左から順に足し `0 + 0 = 0`（`def_finite_sum_of_real_numbers`） | 5 段目 |
| `√0 = 0`（`sqrt_of_real_zero_is_zero`） | 6 段目 |
| `ℝ` で `0 ≠ 1` なので `‖x‖ = 1` と矛盾 | `zero_ne_one` |

必要十分版は置かない。証明は `def_matrix_norm` を開いて各項へ `0` を入れ、`|0| = 0`・`0^2 = 0`・`√0 = 0` を当てることに尽き、
`ℝ` の完備性も使わない。ノルムの形（`√` と `|·|^2` の和）そのものが主張の中身で、ほどく構造が無い
（`ClaimSqrtOfRealZeroIsZero.lean` と同じ扱い）。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealAbsoluteValueAndOfRealSum
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSqrtOfRealZeroIsZero

namespace Ising2D

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 人手 `unit_norm_vector_is_nonzero`（「`‖x‖ = 1` なら `x ≠ 0`」。`def_rayleigh_sup` の `𝓡 ⊆ ℝ_{>0}` の段・
`moment_log_convexity`・`c_between_Lambda_half_and_twice_Lambda_half` の Step 2 の準備が引く）: `x = 0` と仮定すると
`‖x‖ = √(Σ_j|x_j|^2) = √(Σ_j|0|^2) = √(Σ_j 0^2) = √(Σ_j 0) = √0 = 0` の 6 行の鎖になり、`ℝ` で `0 ≠ 1` なので `‖x‖ = 1` と矛盾する。
人手の `d ∈ ℤ_{≥1}`・`x ∈ ℝ^d` は、ここでは任意の有限型の添字 `n` の `x : n → ℝ` で受ける（鎖は `d ≥ 1` を使わない）。 -/
theorem ne_zero_of_unit_norm {x : n → ℝ} (hx : vecNorm x = 1) : x ≠ 0 := by
  rintro rfl
  have h0 : vecNorm (0 : n → ℝ) = 0 :=
    calc vecNorm (0 : n → ℝ)
        = Real.sqrt (∑ j, |(0 : n → ℝ) j| ^ 2) := by
          rw [vecNorm, vecNormSq_eq_sum]
          simp only [square_of_real_absolute_value]                         -- `def_matrix_norm`（`K = ℝ`、`w → x`）。`square_of_real_absolute_value` は
                                                                            -- Lean の `vecNormSq`（`Σ x_j^2`）と `def_matrix_norm`（`Σ|x_j|^2`）の書き方の差を埋める段
      _ = Real.sqrt (∑ _j : n, |(0 : ℝ)| ^ 2) := rfl                         -- `x_j = 0` を各項へ
      _ = Real.sqrt (∑ _j : n, (0 : ℝ) ^ 2) := by
          rw [abs_of_nonneg (le_refl (0 : ℝ))]                              -- `def_real_absolute_value` の `0 ≥ 0` の場合 `|0| = 0` を各項へ
      _ = Real.sqrt (∑ _j : n, (0 : ℝ)) := by rw [zero_pow two_ne_zero]      -- `ℝ` で `0^2 = 0` を各項へ
      _ = Real.sqrt 0 := by rw [Finset.sum_const_zero]                      -- `def_finite_sum_of_real_numbers` の和と `0 + 0 = 0`（具体版が無いので mathlib）
      _ = 0 := sqrt_of_real_zero_is_zero                                    -- `sqrt_of_real_zero_is_zero`
  exact zero_ne_one (h0.symm.trans hx)                                      -- `ℝ` で `0 ≠ 1` なので `‖x‖ = 1` と矛盾

end Ising2D
