/-
# 成分の絶対値を並べたベクトルのノルム `‖u‖ = ‖x‖`（`u_k := |x_k|`）

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_claim_norm_of_vector_of_absolute_values_equals_norm`（ラベル **`norm_of_vector_of_absolute_values_equals_norm`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 主張の 4 行の鎖（`def_matrix_norm`、`u_k := \|x_k\|` を各項へ、`square_of_real_absolute_value`（`q → \|x_k\|`）を各項へ、`def_matrix_norm`） | `norm_of_vector_of_absolute_values_equals_norm` の `calc` の 4 段 |

- 人手の `def_matrix_norm`（`K = ℝ`）の `‖w‖ = √(Σ|w_k|^2)` は、Lean の `vecNorm w = √(w ⬝ᵥ w)` を `vecNormSq_eq_sum` で `√(Σ w_k^2)` に開き、
  `square_of_real_absolute_value` で `√(Σ|w_k|^2)` に書いたものである（この `square_of_real_absolute_value` は人手の行ではなく、二つの書き方の差を埋める段。
  `ClaimNormOfNormalizedRealVectorIsOne.lean` の `vecNorm_sq_eq_sum_abs_sq` と同じ）。
- 人手の和の添字 `{1, …, n}` は Lean では有限型 `n` である。人手の `u` は Lean の `fun k => |x k|` である
  （`ClaimRealBilinearValueAtMostValueAtAbsoluteVector.lean` と同じ）。

必要十分版は置かない。主張は `def_matrix_norm` を開いて `square_of_real_absolute_value`（必要十分版 `NecSuf/SquareOfAbsoluteValueAndOfSum.lean`）を
各項へ当てることに尽きる。`NecSuf/PermMatrix.lean` の `vecNormSq_absVec` は同じ内容の二乗の形だが、`sq_abs` で閉じていて人手の鎖と 1 対 1 ではない。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealAbsoluteValueAndOfRealSum

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **人手 `norm_of_vector_of_absolute_values_equals_norm`**: `u_k := |x_k|` について `‖u‖ = ‖x‖`（人手の 4 行の鎖と 1 対 1）。 -/
theorem norm_of_vector_of_absolute_values_equals_norm (x : n → ℝ) :
    vecNorm (fun k => |x k|) = vecNorm x :=
  calc vecNorm (fun k => |x k|)
      = Real.sqrt (∑ k, |(fun k => |x k|) k| ^ 2) := by
        rw [vecNorm, vecNormSq_eq_sum]
        exact congrArg Real.sqrt (Finset.sum_congr rfl fun k _ =>
          (square_of_real_absolute_value _).symm)                   -- `def_matrix_norm`（`w → u`）。`square_of_real_absolute_value` は書き方の差を埋める段
    _ = Real.sqrt (∑ k, |(|x k|)| ^ 2) := rfl                       -- `u_k := |x_k|` を `n` 個の項へ同時に
    _ = Real.sqrt (∑ k, |x k| ^ 2) :=
        congrArg Real.sqrt (Finset.sum_congr rfl fun k _ =>
          square_of_real_absolute_value |x k|)                      -- `square_of_real_absolute_value`（`q → |x_k|`）を `n` 個の項へ同時に
    _ = vecNorm x := by
        rw [vecNorm, vecNormSq_eq_sum]
        exact congrArg Real.sqrt (Finset.sum_congr rfl fun k _ =>
          square_of_real_absolute_value _)                          -- `def_matrix_norm`（`w → x`）を右辺から左辺へ

end Ising2D
