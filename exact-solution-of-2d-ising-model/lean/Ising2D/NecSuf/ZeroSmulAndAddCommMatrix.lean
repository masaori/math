/-
# 行列の 0 倍は零行列・行列の和の可換則（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimZeroScalarMultipleAndMatrixSumCommutative.lean`
（人手 `zero_scalar_multiple_is_zero_matrix`・`matrix_sum_is_commutative`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_zero_smul_apply`（スカラー倍の定義 → `0_ℂ z = 0_ℂ` → 零行列の定義） | `zero_smul_matrix_apply'`（スカラー倍の定義 → `0 • x = 0` → 零行列の定義） |
| `matrix_add_comm_apply`（和の定義 → `ℂ` の加法の交換律 → 和の定義） | `add_comm_matrix_apply'`（和の定義 → `x + y = y + x` → 和の定義） |

## 何が効いているか / 効いていないか

- `0_ℂ A = O` に効くのは、スカラーの `0` を係数に作用させると `0` になること（仮定 `hz`）だけである。
  スカラーと係数が同じ集合であること、スカラー倍が係数の積であることは効いていない。係数の加法・積の他の性質も効いていない。
- `A + B = B + A` に効くのは、係数の加法の交換律（仮定 `hcomm`）だけである。加法の結合律・単位元・逆元、乗法は効いていない。
- 行列の添字の集合は任意で、有限であることは効いていない。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(0 A)_{ik} = O_{ik}`**（具体版 `matrix_zero_smul_apply`）。 -/
theorem zero_smul_matrix_apply' {α R : Type*} [Zero α] [Zero R] [SMul α R]
    (hz : ∀ x : R, (0 : α) • x = 0) (A : Matrix ι κ R) (i : ι) (k : κ) :
    ((0 : α) • A) i k = (0 : Matrix ι κ R) i k :=
  calc ((0 : α) • A) i k
      = (0 : α) • A i k := rfl              -- スカラー倍の定義
    _ = 0 := hz _                            -- `0 • x = 0`
    _ = (0 : Matrix ι κ R) i k := rfl       -- 零行列の定義

/-- **`0 A = O`**（具体版 `matrix_zero_smul`）。 -/
theorem zero_smul_matrix' {α R : Type*} [Zero α] [Zero R] [SMul α R]
    (hz : ∀ x : R, (0 : α) • x = 0) (A : Matrix ι κ R) : (0 : α) • A = 0 :=
  Matrix.ext (zero_smul_matrix_apply' hz A)   -- 行列の等号は成分ごと

/-- **`(A + B)_{ik} = (B + A)_{ik}`**（具体版 `matrix_add_comm_apply`）。 -/
theorem add_comm_matrix_apply' {R : Type*} [Add R] (hcomm : ∀ x y : R, x + y = y + x)
    (A B : Matrix ι κ R) (i : ι) (k : κ) : (A + B) i k = (B + A) i k :=
  calc (A + B) i k
      = A i k + B i k := rfl                 -- 和の定義
    _ = B i k + A i k := hcomm _ _           -- `x + y = y + x`
    _ = (B + A) i k := rfl                   -- 和の定義を右辺から左辺へ

/-- **`A + B = B + A`**（具体版 `matrix_add_comm`）。 -/
theorem add_comm_matrix' {R : Type*} [Add R] (hcomm : ∀ x y : R, x + y = y + x)
    (A B : Matrix ι κ R) : A + B = B + A :=
  Matrix.ext (add_comm_matrix_apply' hcomm A B)   -- 行列の等号は成分ごと

end Ising2D.NecSuf
