/-
# 零でない実数のベクトルの各成分をそのノルムで割ると、実数の双線型値はノルムの二乗で割ったものになる

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_claim_real_bilinear_value_of_normalized_vector`（ラベル **`real_bilinear_value_of_normalized_vector`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: `norm_of_normalized_real_vector_is_one` の `‖v‖ ∈ ℝ_{>0}` から `‖v‖ ≠ 0`、準備の `‖v‖^2 = ‖v‖‖v‖ > 0` から `‖v‖^2 ≠ 0` | `vecNorm_pos_of_ne_zero` からの `hN`・`hN2` |
| 準備: `v̂_k = v_k/‖v‖ = (1/‖v‖)v_k` の 2 行 | `hscal` の `calc` の 2 段 |
| 主張の 4 行の鎖 | `real_bilinear_value_of_normalized_vector` の `calc` の 4 段 |

- 人手の `x^⊤Py`（`def_real_bilinear_value`）は Lean の `x ⬝ᵥ P *ᵥ y`、`‖·‖` は `vecNorm` である。
- 人手の `‖v‖^2 := ‖v‖‖v‖` は Lean の `vecNorm v ^ 2` で、3 段目の書き戻しは `sq`（`x^2 = x * x`）である。
- 人手は `ℝ^n` の元の実数倍を定めず、`v̂` を成分の等式 `v̂_k = v_k/‖v‖` で与える。Lean も同じく仮定 `hvhat` に置く。
- 人手の「`ℝ` の四則演算」の 3 つ（`a/b = (1/b)a`、`(1/b)(1/b) = 1/(bb)`、`(1/c)a = a/c`）は
  `div_eq_mul_one_div`・`mul_comm`・`one_div_mul_one_div`・`one_div_mul_eq_div` で埋める。
  Lean の `ℝ` の商は分母が 0 でも値を持つので、人手が添える `≠ 0` は Lean の段では使わない（`hN`・`hN2` は人手の準備の行に対応させて置く）。

必要十分版は置かない。主張は `real_bilinear_value_of_scalar_multiple_vector`（必要十分版は
`NecSuf/BilinearValueNonnegativeAndScalarMultiple.lean`）を `c → 1/‖v‖` で 1 回当て、`ℝ` の四則演算で整えることに尽きる。
ノルムであることは効いていない（`v̂` が `v` の実数倍であることだけを使い、`‖v‖` を任意の実数 `s` に替えた `v̂_k = v_k/s` でも同じ段で通る。
`hN`・`hN2` は人手の準備の行との対応のために置いており、Lean の段では使わない）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimNormOfNormalizedRealVectorIsOne
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultiple

set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **人手 `real_bilinear_value_of_normalized_vector`**: `v ≠ 0`、すべての `k` で `v̂_k = v_k/‖v‖` なら
`v̂^⊤Pv̂ = (v^⊤Pv)/‖v‖^2`（準備の 2 行と主張の 4 行の鎖と 1 対 1）。 -/
theorem real_bilinear_value_of_normalized_vector (P : Matrix n n ℝ) (v vhat : n → ℝ)
    (hv0 : v ≠ 0) (hvhat : ∀ k, vhat k = v k / vecNorm v) :
    vhat ⬝ᵥ P *ᵥ vhat = (v ⬝ᵥ P *ᵥ v) / vecNorm v ^ 2 := by
  have hN : vecNorm v ≠ 0 := (vecNorm_pos_of_ne_zero hv0).ne'      -- `norm_of_normalized_real_vector_is_one` の `‖v‖ > 0` から `‖v‖ ≠ 0`
  have hN2 : vecNorm v ^ 2 ≠ 0 :=
    (pow_pos (vecNorm_pos_of_ne_zero hv0) 2).ne'                    -- `‖v‖^2 > 0`（正の実数どうしの積は正）から `‖v‖^2 ≠ 0`
  have hscal : ∀ k, vhat k = 1 / vecNorm v * v k := fun k =>
    calc vhat k
        = v k / vecNorm v := hvhat k                                -- `v̂` の定義
      _ = 1 / vecNorm v * v k := by
          rw [div_eq_mul_one_div, mul_comm]                         -- `ℝ` の四則演算 `a/b = (1/b)a`（`a → v_k`, `b → ‖v‖`）
  calc vhat ⬝ᵥ P *ᵥ vhat
      = 1 / vecNorm v * (1 / vecNorm v) * (v ⬝ᵥ P *ᵥ v) :=
        real_bilinear_value_of_scalar_multiple_vector
          P (1 / vecNorm v) v vhat hscal                            -- `real_bilinear_value_of_scalar_multiple_vector`（`c → 1/‖v‖`, `u → v`, `w → v̂`）
    _ = 1 / (vecNorm v * vecNorm v) * (v ⬝ᵥ P *ᵥ v) := by
        rw [one_div_mul_one_div]                                    -- `ℝ` の四則演算 `(1/b)(1/b) = 1/(bb)`（`b → ‖v‖`）
    _ = 1 / vecNorm v ^ 2 * (v ⬝ᵥ P *ᵥ v) := by
        rw [sq]                                                     -- `‖v‖^2 := ‖v‖‖v‖` を右辺から左辺へ
    _ = (v ⬝ᵥ P *ᵥ v) / vecNorm v ^ 2 := one_div_mul_eq_div _ _     -- `ℝ` の四則演算 `(1/c)a = a/c`（`a → v^⊤Pv`, `c → ‖v‖^2`）

end Ising2D
