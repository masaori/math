/-
# 行列の冪の指数法則 `A^{p+q} = A^pA^q`（具体版）

正本: `structured-latex/content/003_exp_linear_map.ts`
（`exp_linear_map_claim_matrix_power_exponent_law`、ラベル **`matrix_power_exponent_law`**）

必要十分版: `Ising2D.NecSuf.power_exponent_law'`（`Ising2D/NecSuf/PowerExponentLaw.lean`）。
具体版をその特殊化として得るのは `ClaimMatrixPowerExponentLawFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `q = 0` の 3 行 `A^{p+0} = A^p = A^pI = A^pA^0` | `matrix_power_exponent_law` の `0` の `calc` の 3 段 |
| `q + 1` の 5 行 `A^{p+(q+1)} = A^{(p+q)+1} = A^{p+q}A = (A^pA^q)A = A^p(A^qA) = A^pA^{q+1}` | `matrix_power_exponent_law` の `q + 1` の `calc` の 5 段 |

- 行列は `TensorPow M`（添字 `Conf M`）で述べ、人手の `n` は `2^M` に限る。使う側（`trace_power_upper_bound`・
  `power_of_real_symmetric_complex_matrix_is_real_symmetric` の `A → W`）が `TensorPow M` の行列だからである。
  添字が `Conf M` なので、`identity_matrix_is_right_unit_of_mat_mult` は `TensorPow M` での具体版
  `mul_identity_matrix_tensorPow`（`ClaimIdentityAndScalarMultipleInTensorPowProduct.lean`）を引く。
- `def_matrix_power` の冪 `A^0 := I`・`A^{m+1} := A^mA` は、`TensorPow M` での一致の補題 `tensorPow_pow_zero_and_succ`
  （`DefinitionMatrixOperationsOverMultiIndices.lean`）の二つの式で引く。
- `mat_mult_associative` は本文に Lean の具体版が無く、他のファイルと同じく mathlib の `Matrix.mul_assoc` を引く。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInTensorPowProduct

namespace Ising2D

variable {M : ℕ}

/-- **人手 `matrix_power_exponent_law`**: すべての `p, q` について `A^{p+q} = A^pA^q`（`p` を固定し `q` についての帰納法）。 -/
theorem matrix_power_exponent_law (A : TensorPow M) (p : ℕ) :
    ∀ q : ℕ, A ^ (p + q) = A ^ p * A ^ q
  | 0 =>
    calc A ^ (p + 0)
        = A ^ p := by rw [Nat.add_zero]                                     -- `ℤ` で `p + 0 = p`
      _ = A ^ p * 1 := (mul_identity_matrix_tensorPow _).symm               -- `identity_matrix_is_right_unit_of_mat_mult`
      _ = A ^ p * A ^ 0 := by rw [(tensorPow_pow_zero_and_succ A).1]       -- `def_matrix_power` の `A^0 := I`
  | q + 1 =>
    calc A ^ (p + (q + 1))
        = A ^ ((p + q) + 1) := by rw [Nat.add_assoc]                        -- `ℤ` の加法の結合律
      _ = A ^ (p + q) * A := (tensorPow_pow_zero_and_succ A).2 (p + q)      -- `def_matrix_power` の `A^{m+1} := A^mA`（`m → p + q`）
      _ = (A ^ p * A ^ q) * A := by rw [matrix_power_exponent_law A p q]    -- 帰納法の仮定
      _ = A ^ p * (A ^ q * A) := Matrix.mul_assoc _ _ _                     -- `mat_mult_associative`
      _ = A ^ p * A ^ (q + 1) := by rw [(tensorPow_pow_zero_and_succ A).2 q] -- `def_matrix_power` の `A^{m+1} := A^mA`（`m → q`）

end Ising2D
