/-
# 収束する複素数の列による行列のスカラー倍は収束する（具体版）

対応する人手証明のラベル: `scalar_sequence_times_matrix_converges`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_scalar_sequence_times_matrix_converges`）。

人手の 3 行の鎖 `‖c_NA − cA‖ = ‖(c_N − c)A‖ = |c_N − c|‖A‖ → 0` と 1 対 1 に対応する。
1 行目は具体版 `smul_sub_smul_matrix`（人手 `difference_of_scalar_multiples_of_one_matrix`）、2 行目は Frobenius ノルムの
`norm_smul`（人手 `matrix_norm_triangle_inequality` (2)。値が `def_matrix_norm` の行列ノルムと一致するノルムでの同じ主張）、
3 行目は実数列 `|c_N − c|` に定数 `‖A‖` を掛けた列の極限（`Filter.Tendsto.mul_const`）である。

必要十分版は `Ising2D/NecSuf/ContinuityOfProductsAndScalarMultiples.lean` の `NecSuf.smul_tendsto'`、
この具体版をその特殊化として導くのは `ClaimContinuityOfProductsAndScalarMultiplesFromNecSuf.lean`。
-/
import Mathlib.Analysis.Matrix.Normed
import Mathlib.Analysis.Complex.Basic
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultiplesOfOneMatrix

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup Matrix.frobeniusNormSMulClass

/-- **`scalar_sequence_times_matrix_converges`**: `|c_N − c| → 0` なら `‖c_NA − cA‖ → 0`。 -/
theorem smul_matrix_tendsto {n : ℕ} (c : ℕ → ℂ) (clim : ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (h : Tendsto (fun N => ‖c N - clim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖c N • A - clim • A‖) atTop (𝓝 0) := by
  have heq : ∀ N, ‖c N • A - clim • A‖ = ‖c N - clim‖ * ‖A‖ := fun N =>
    calc ‖c N • A - clim • A‖
        = ‖(c N - clim) • A‖ := by rw [smul_sub_smul_matrix]
                                                        -- `difference_of_scalar_multiples_of_one_matrix`（`m → n`、`a → c_N`、`b → c`）
      _ = ‖c N - clim‖ * ‖A‖ := norm_smul _ _
                                                        -- `matrix_norm_triangle_inequality` (2)（`c → c_N − c`）
  -- `|c_N − c| → 0` と、収束する実数列に定数を掛けた列の極限
  simp_rw [heq]
  simpa using h.mul_const ‖A‖

end Ising2D
