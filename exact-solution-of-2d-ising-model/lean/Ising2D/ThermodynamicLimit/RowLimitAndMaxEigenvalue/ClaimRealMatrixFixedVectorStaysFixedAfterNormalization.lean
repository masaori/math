/-
# 実数の行列が動かさない零でない実数のベクトルは、各成分をそのノルムで割っても、その行列で動かない

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_claim_real_matrix_fixed_vector_stays_fixed_after_normalization`
  （ラベル **`real_matrix_fixed_vector_stays_fixed_after_normalization`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: `norm_of_normalized_real_vector_is_one` の `‖v‖ ∈ ℝ_{>0}` から `‖v‖ ≠ 0` | `vecNorm_pos_of_ne_zero` からの `hN` |
| 準備: `v̂_k = v_k/‖v‖ = (1/‖v‖)v_k` の 2 行 | `hscal` の `calc` の 2 段 |
| 主張の 4 行の鎖 | `real_matrix_fixed_vector_stays_fixed_after_normalization` の `calc` の 4 段 |
| 結び（`i` は任意） | 同じ定理の `∀ i` |

- 人手の `‖v‖ ∈ ℝ_{>0}` は `norm_of_normalized_real_vector_is_one` の主張の一部で、Lean ではその準備の `vecNorm_pos_of_ne_zero` である。
- 人手の `def_real_matrix_vector_product` は Lean の `Matrix _ _ ℝ` の `*ᵥ`、`‖·‖` は `vecNorm`（`def_matrix_norm` の `K = ℝ`）である。
- 人手は `ℝ^n` の元の実数倍を定めず、`v̂` を成分の等式 `v̂_k = v_k/‖v‖` で与える。Lean も同じく仮定 `hvhat` に置く。
  仮定 `(Pv)_i = v_i`（すべての `i`）は `hfix` である。
- 人手の「`ℝ` の四則演算」の 2 つ（`a/b = (1/b)a`、`(1/b)a = a/b`）は `div_eq_mul_one_div`・`mul_comm`・`one_div_mul_eq_div` で埋める。
  Lean の `ℝ` の商は `b = 0` でも値を持つので、人手が添える `b ≠ 0` は Lean の段では使わない（`hN` は人手の準備の行に対応させて置く）。

必要十分版は置かない。主張は `real_matrix_vector_product_commutes_with_real_scalar_multiple`（必要十分版は
`NecSuf/MatrixVectorProductCommutesWithScalarMultiple.lean`）を `c → 1/‖v‖` で 1 回当て、`ℝ` の四則演算で整えることに尽きる。
ノルムであることは効いていない（`v̂` が `v` の実数倍であることだけを使い、`‖v‖` を任意の実数 `s` に替えた `v̂_k = v_k/s` でも同じ段で通る。
`hN` は人手の準備の行との対応のために置いており、Lean の段では使わない）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimNormOfNormalizedRealVectorIsOne
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealMatrixVectorProductCommutesWithRealScalarMultiple

set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **人手 `real_matrix_fixed_vector_stays_fixed_after_normalization`**: `v ≠ 0`、すべての `k` で `v̂_k = v_k/‖v‖`、
すべての `i` で `(Pv)_i = v_i` なら、すべての `i` で `(Pv̂)_i = v̂_i`（準備の 2 行と主張の 4 行の鎖と 1 対 1）。 -/
theorem real_matrix_fixed_vector_stays_fixed_after_normalization (P : Matrix n n ℝ) (v vhat : n → ℝ)
    (hv0 : v ≠ 0) (hvhat : ∀ k, vhat k = v k / vecNorm v) (hfix : ∀ i, (P *ᵥ v) i = v i) :
    ∀ i, (P *ᵥ vhat) i = vhat i := by
  have hN : vecNorm v ≠ 0 := (vecNorm_pos_of_ne_zero hv0).ne'      -- `norm_of_normalized_real_vector_is_one` の `‖v‖ > 0` から `‖v‖ ≠ 0`
  have hscal : ∀ k, vhat k = 1 / vecNorm v * v k := fun k =>
    calc vhat k
        = v k / vecNorm v := hvhat k                                -- `v̂` の定義
      _ = 1 / vecNorm v * v k := by
          rw [div_eq_mul_one_div, mul_comm]                         -- `ℝ` の四則演算 `a/b = (1/b)a`（`a → v_k`, `b → ‖v‖`）
  intro i
  calc (P *ᵥ vhat) i
      = 1 / vecNorm v * (P *ᵥ v) i :=
        real_matrix_vector_product_commutes_with_real_scalar_multiple
          P (1 / vecNorm v) v vhat hscal i                          -- `real_matrix_vector_product_commutes_with_real_scalar_multiple`（`c → 1/‖v‖`, `u → v`, `w → v̂`）
    _ = 1 / vecNorm v * v i := by rw [hfix i]                       -- 仮定 `(Pv)_i = v_i`
    _ = v i / vecNorm v := one_div_mul_eq_div _ _                   -- `ℝ` の四則演算 `(1/b)a = a/b`（`a → v_i`, `b → ‖v‖`）
    _ = vhat i := (hvhat i).symm                                    -- `v̂` の定義（`k → i`）を右辺から左辺へ

end Ising2D
