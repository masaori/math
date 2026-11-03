/-
# 行列乗算の右の因子についての連続性（具体版）

対応する人手証明のラベル: `matrix_multiplication_continuity_in_right_factor`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_matrix_multiplication_continuity_in_right_factor`）。

人手の 3 行の鎖 `‖BA_N − BA‖ = ‖B(A_N − A)‖ ≤ ‖B‖‖A_N − A‖ → 0` と 1 対 1 に対応する。
係数は人手の `K = ℂ` の場合で、`K = ℝ` の場合は置いていない（使う箇所が `ℂ` だけのため）。
ノルムは mathlib の Frobenius ノルム（成分の絶対値の二乗和の `1/2` 乗）で、`def_matrix_norm` の行列ノルム（二乗和の平方根）と値が一致する。
劣乗法性 `Matrix.frobenius_norm_mul` は、値が一致するこのノルムでの人手 `matrix_norm_submultiplicativity` と同じ主張である。
人手の「→ 0」の行は、評価の右辺が実数列 `‖A_N − A‖` の定数倍として 0 に収束すること（`Filter.Tendsto.const_mul`）と、
非負の列がそれで上から抑えられること（`squeeze_zero`）の 2 つで書く。

必要十分版は `Ising2D/NecSuf/ContinuityOfProductsAndScalarMultiples.lean` の `NecSuf.mul_left_tendsto'`、
この具体版をその特殊化として導くのは `ClaimContinuityOfProductsAndScalarMultiplesFromNecSuf.lean`。
-/
import Mathlib.Analysis.Matrix.Normed
import Mathlib.Analysis.Complex.Basic

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

/-- **`matrix_multiplication_continuity_in_right_factor`**: `‖A_N − A‖ → 0` なら `‖BA_N − BA‖ → 0`。 -/
theorem matrix_mul_left_tendsto {n : ℕ} (B : Matrix (Fin n) (Fin n) ℂ) (A : ℕ → Matrix (Fin n) (Fin n) ℂ)
    (Alim : Matrix (Fin n) (Fin n) ℂ) (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖B * A N - B * Alim‖) atTop (𝓝 0) := by
  have hle : ∀ N, ‖B * A N - B * Alim‖ ≤ ‖B‖ * ‖A N - Alim‖ := fun N =>
    calc ‖B * A N - B * Alim‖
        = ‖B * (A N - Alim)‖ := by rw [Matrix.mul_sub]
                                                        -- 行列の積の左分配則
      _ ≤ ‖B‖ * ‖A N - Alim‖ := Matrix.frobenius_norm_mul _ _
                                                        -- `matrix_norm_submultiplicativity`（`A → B`、`B → A_N − A`）
  -- `‖A_N − A‖ → 0` と、収束する実数列に定数を掛けた列の極限
  have h0 : Tendsto (fun N => ‖B‖ * ‖A N - Alim‖) atTop (𝓝 0) := by
    simpa using h.const_mul ‖B‖
  exact squeeze_zero (fun _ => norm_nonneg _) hle h0

end Ising2D
