/-
# 行列 A と差 B − A の和は B（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixPlusDifferenceCancels.lean`
（人手 `matrix_plus_difference_cancels`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixPlusDifferenceCancelsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_add_sub_cancel_apply`（和の定義 → 差の定義 → `z - w = z + (-w)` → 加法の交換律 → 加法の結合律 → `a + (-a) = 0` → `0 + b = b`） | `add_sub_cancel_matrix_apply'`（同じ並び） |

## 何が効いているか / 効いていないか

- `A + (B - A) = B` に効くのは、係数の加法が可換群であること（`AddCommGroup`）の公理のうち、`x - y = x + (-y)`・加法の交換律・
  結合律・`a + (-a) = 0`・`0 + b = b` だけである。`AddCommGroup` はちょうどこれらを公理（またはその直接の帰結）として持つので、
  型クラスはそれにした（`eq_sub_of_add_eq_matrix'` と同じ）。乗法は効いていない。
- 行列の添字の集合は任意で、有限であることは効いていない。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(A + (B - A))_{ik} = B_{ik}`**（具体版 `matrix_add_sub_cancel_apply`）。 -/
theorem add_sub_cancel_matrix_apply' {R : Type*} [AddCommGroup R]
    (A B : Matrix ι κ R) (i : ι) (k : κ) : (A + (B - A)) i k = B i k :=
  calc (A + (B - A)) i k
      = A i k + (B - A) i k := rfl                                       -- 和の定義
    _ = A i k + (B i k - A i k) := rfl                                   -- 差の定義
    _ = A i k + (B i k + -A i k) := by rw [sub_eq_add_neg]               -- `x - y = x + (-y)`
    _ = A i k + (-A i k + B i k) := by rw [add_comm (B i k)]             -- 加法の交換律
    _ = (A i k + -A i k) + B i k := (add_assoc _ _ _).symm               -- 加法の結合律
    _ = 0 + B i k := by rw [add_neg_cancel]                              -- `a + (-a) = 0`
    _ = B i k := zero_add _                                              -- `0 + b = b`

/-- **`A + (B - A) = B`**（具体版 `matrix_add_sub_cancel`）。 -/
theorem add_sub_cancel_matrix' {R : Type*} [AddCommGroup R]
    (A B : Matrix ι κ R) : A + (B - A) = B :=
  Matrix.ext (add_sub_cancel_matrix_apply' A B)   -- 全ての成分が一致する

end Ising2D.NecSuf
