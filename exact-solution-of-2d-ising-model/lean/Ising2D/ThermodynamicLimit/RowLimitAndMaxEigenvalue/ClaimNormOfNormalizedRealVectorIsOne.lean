/-
# 零でない実数のベクトルの各成分をそのノルムで割ったベクトルは、ノルムが 1 である

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_claim_norm_of_normalized_real_vector_is_one`（ラベル **`norm_of_normalized_real_vector_is_one`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: `matrix_norm_triangle_inequality` (1)（`K^n`）から `‖v‖ ≥ 0`、`‖v‖ ≠ 0`、`‖v‖ > 0`、`‖v‖^2 = ‖v‖‖v‖ > 0`（`square_of_real_number_is_product`） | `vecNorm_pos_of_ne_zero`、主定理の `hN`・`hN2pos`・`hN2` |
| 準備: `‖x‖^2 = (√Σ|x_k|^2)^2 = Σ|x_k|^2` の 2 行（`def_matrix_norm`、`definition_of_sqrt_r_positive` の `y^2 = x`） | `vecNorm_sq_eq_sum_abs_sq` の `calc` の 2 段 |
| 主張の 11 行の鎖 | `norm_of_normalized_real_vector_is_one` の `calc` の 11 段 |

- 人手の `ℝ^n` の元は Lean の `n → ℝ`（`n` は有限型）、`‖·‖` は `vecNorm`（`def_matrix_norm` の `K = ℝ`）である。
- 人手の `def_matrix_norm` の `‖w‖ = √(Σ|w_k|^2)` は、Lean の `vecNorm w = √(w ⬝ᵥ w)` を `vecNormSq_eq_sum` で `√(Σ w_k^2)` に開き、
  `square_of_real_absolute_value` で `√(Σ|w_k|^2)` に書いたものである（この `square_of_real_absolute_value` は人手の行ではなく、二つの書き方の差を埋める段。
  `ClaimNormOfVectorOfAbsoluteValuesEqualsNorm.lean` と同じ）。
- 人手の `matrix_norm_triangle_inequality` (1) の `K^n` の非退化性（`‖x‖ = 0 ⟺ x = 0`）は、Lean では `vecNormSq_eq_zero_iff`（`‖x‖^2 = 0 ⟺ x = 0`）と
  `Real.sqrt_eq_zero` を合わせたものである（`matrix_norm_triangle_inequality` の `K^n` の具体版は Lean に無い）。
- 人手の二乗は `def_power_of_real_number` の冪で、Lean の `^ 2`（`Monoid.npow`）である。積の形との行き来は `square_of_real_number_is_product` で引き、
  mathlib の `sq`・`pow_two`・`div_pow` は使わない。
- 人手の `definition_of_sqrt_r_positive`（`√x` は `y ≥ 0, y^2 = x` を満たす `y`）は Lean では `Real.sqrt` で、その `y^2 = x` の行は `Real.sq_sqrt`、
  `√1 = 1` の行は `Real.sqrt_eq_iff_eq_sq`（`x ≥ 0`、`y ≥ 0` のとき `√x = y ↔ x = y^2`）に `1 ≥ 0` と `power_of_real_one_is_one`（`m → 2`）を渡したものである。
- 人手の「`ℝ` の四則演算」の 2 行（`(a/b)(a/b) = (1/(bb))(aa)`、`(1/b)b = 1`）は `div_mul_div_comm`・`div_eq_mul_one_div`・`mul_comm`・`one_div_mul_cancel` で埋める。
- 人手は `ℝ^n` の元の実数倍を定めず、`v̂` を成分の等式 `v̂_k = v_k/‖v‖` で与える。Lean も同じく仮定 `hvhat` に置く
  （`real_bilinear_value_of_scalar_multiple_vector` と同じ形）。

必要十分版は置かない。主張は `def_matrix_norm` を開いて `square_of_real_absolute_value`・`finite_sum_of_real_scalar_multiples`
（必要十分版はそれぞれ `NecSuf/SquareOfAbsoluteValueAndOfSum.lean`・`NecSuf/FiniteSums.lean`）を当て、`ℝ` の四則演算で `1` にすることに尽きる。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealAbsoluteValueAndOfRealSum
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimPowerOfRealOneIsOne

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

/-- 人手の証明の準備の `‖x‖^2 = Σ|x_k|^2`（2 行の鎖）。 -/
theorem vecNorm_sq_eq_sum_abs_sq {ι : Type*} [Fintype ι] [DecidableEq ι] (x : ι → ℝ) :
    vecNorm x ^ 2 = ∑ k, |x k| ^ 2 := by
  calc vecNorm x ^ 2
      = (Real.sqrt (∑ k, |x k| ^ 2)) ^ 2 := by
        rw [vecNorm, vecNormSq_eq_sum]
        simp only [square_of_real_absolute_value]                   -- `def_matrix_norm`（`w → x`）。`square_of_real_absolute_value` は書き方の差を埋める段
    _ = ∑ k, |x k| ^ 2 :=
        Real.sq_sqrt (Finset.sum_nonneg fun k _ => sq_nonneg |x k|) -- `definition_of_sqrt_r_positive` の `y^2 = x`（根号の中は非負）

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 人手の証明の準備: `v ≠ 0` なら `‖v‖ > 0`（`matrix_norm_triangle_inequality` (1) の `K^n`）。 -/
theorem vecNorm_pos_of_ne_zero {v : n → ℝ} (hv0 : v ≠ 0) : 0 < vecNorm v := by
  have hge : 0 ≤ vecNorm v := vecNorm_nonneg v                       -- `‖v‖ ≥ 0`
  have hne : vecNorm v ≠ 0 := by                                     -- `‖v‖ = 0` なら `v = 0` で仮定に反する
    intro h
    exact hv0 (vecNormSq_eq_zero_iff.mp ((Real.sqrt_eq_zero (vecNormSq_nonneg v)).mp h))
  exact lt_of_le_of_ne hge (Ne.symm hne)                             -- よって `‖v‖ > 0`

/-- **人手 `norm_of_normalized_real_vector_is_one`**: `v ≠ 0`、すべての `k` で `v̂_k = v_k/‖v‖` なら `‖v̂‖ = 1`
（準備と 11 行の鎖と 1 対 1）。 -/
theorem norm_of_normalized_real_vector_is_one (v vhat : n → ℝ) (hv0 : v ≠ 0)
    (hvhat : ∀ k, vhat k = v k / vecNorm v) :
    vecNorm vhat = 1 := by
  have hN : vecNorm v ≠ 0 := (vecNorm_pos_of_ne_zero hv0).ne'
  have hN2pos : 0 < vecNorm v ^ 2 := by
    rw [square_of_real_number_is_product (vecNorm v)]               -- `‖v‖^2 = ‖v‖‖v‖`（`square_of_real_number_is_product`, `r → ‖v‖`）
    exact mul_pos (vecNorm_pos_of_ne_zero hv0) (vecNorm_pos_of_ne_zero hv0)  -- `> 0`（正の実数どうしの積は正）
  have hN2 : vecNorm v ^ 2 ≠ 0 := hN2pos.ne'                       -- よって `‖v‖^2 ≠ 0`
  calc vecNorm vhat
      = Real.sqrt (∑ k, |vhat k| ^ 2) := by
        rw [vecNorm, vecNormSq_eq_sum]
        exact congrArg Real.sqrt (Finset.sum_congr rfl fun k _ =>
          (square_of_real_absolute_value _).symm)                   -- `def_matrix_norm`（`w → v̂`）。`square_of_real_absolute_value` は書き方の差を埋める段
    _ = Real.sqrt (∑ k, |v k / vecNorm v| ^ 2) := by
        simp only [hvhat]                                           -- `v̂` の定義を `n` 個の項へ同時に
    _ = Real.sqrt (∑ k, (v k / vecNorm v) ^ 2) :=
        congrArg Real.sqrt (Finset.sum_congr rfl fun k _ =>
          square_of_real_absolute_value (v k / vecNorm v))          -- `square_of_real_absolute_value`（`q → v_k/‖v‖`）を `n` 個の項へ同時に
    _ = Real.sqrt (∑ k, v k / vecNorm v * (v k / vecNorm v)) :=
        congrArg Real.sqrt (Finset.sum_congr rfl fun k _ =>
          square_of_real_number_is_product (v k / vecNorm v))       -- `square_of_real_number_is_product`（`r → v_k/‖v‖`）を `n` 個の項へ同時に
    _ = Real.sqrt (∑ k, 1 / (vecNorm v * vecNorm v) * (v k * v k)) :=
        congrArg Real.sqrt (Finset.sum_congr rfl fun k _ => by
          rw [div_mul_div_comm, div_eq_mul_one_div, mul_comm])      -- `ℝ` の四則演算 `(a/b)(a/b) = (1/(bb))(aa)` を `n` 個の項へ同時に
    _ = Real.sqrt (∑ k, 1 / vecNorm v ^ 2 * v k ^ 2) := by
        simp only [← square_of_real_number_is_product]              -- `square_of_real_number_is_product`（`r → ‖v‖`, `r → v_k`）を右辺から左辺へ `2n` か所へ同時に
    _ = Real.sqrt (1 / vecNorm v ^ 2 * ∑ k, v k ^ 2) :=
        congrArg Real.sqrt
          (finite_sum_of_real_scalar_multiples_fintype _ _)         -- `finite_sum_of_real_scalar_multiples`（`c → 1/‖v‖^2`, `x_k → v_k^2`）
    _ = Real.sqrt (1 / vecNorm v ^ 2 * ∑ k, |v k| ^ 2) := by
        simp only [square_of_real_absolute_value]                   -- `square_of_real_absolute_value`（`q → v_k`）を右辺から左辺へ `n` 個の項へ同時に
    _ = Real.sqrt (1 / vecNorm v ^ 2 * vecNorm v ^ 2) :=
        congrArg (fun t => Real.sqrt (1 / vecNorm v ^ 2 * t))
          (vecNorm_sq_eq_sum_abs_sq v).symm                         -- 準備の `‖x‖^2 = Σ|x_k|^2`（`x → v`）を右辺から左辺へ（右の因子だけ）
    _ = Real.sqrt 1 := by
        rw [one_div_mul_cancel hN2]                                 -- `ℝ` の四則演算 `(1/b)b = 1`（`b → ‖v‖^2 ≠ 0`）
    _ = 1 := (Real.sqrt_eq_iff_eq_sq zero_le_one zero_le_one).mpr
        (power_of_real_one_is_one 2).symm                  -- `definition_of_sqrt_r_positive`（`x → 1`）と `1 ≥ 0`、`power_of_real_one_is_one`（`m → 2`）の `1^2 = 1`

end Ising2D
