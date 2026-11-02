/-
# 零行列のスカラー倍は零行列（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleOfZeroMatrix.lean`
（人手 `scalar_multiple_of_zero_matrix`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleOfZeroMatrixFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_smul_zero_matrix_apply`（スカラー倍の定義 → 零行列の定義 → `z 0_ℂ = 0_ℂ` → 零行列の定義） | `smul_zero_matrix_apply`（スカラー倍の定義 → 零行列の定義 → `a • 0 = 0` → 零行列の定義） |
| `matrix_smul_zero_matrix`（行列の等号は成分ごと） | `smul_zero_matrix` |

## 何が効いているか / 効いていないか

- `aO = O` に効くのは、スカラーを係数の `0` に作用させると `0` になること（`a • 0 = 0`）だけである。
  型クラスはこの 1 つだけを持つ `SMulZeroClass α R` にした。
  具体版はこれを `ℂ` の積 `a · 0_ℂ = 0_ℂ`（`complex_times_zero_is_zero`）で出しているが、
  スカラーと係数が同じ集合であること、スカラー倍が係数の積であることは効いていない。
  係数の加法・積の性質（結合則・可換則・分配則）も効いていない。
- 行列の添字の集合は任意で、有限であることは効いていない。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(aO)_{ik} = O_{ik}`**（具体版 `matrix_smul_zero_matrix_apply`）。係数とスカラーは `SMulZeroClass`。 -/
theorem smul_zero_matrix_apply {α R : Type*} [Zero R] [SMulZeroClass α R] (a : α) (i : ι) (k : κ) :
    (a • (0 : Matrix ι κ R)) i k = (0 : Matrix ι κ R) i k :=
  calc (a • (0 : Matrix ι κ R)) i k
      = a • (0 : Matrix ι κ R) i k := rfl   -- スカラー倍の定義
    _ = a • (0 : R) := rfl                   -- 零行列の定義
    _ = 0 := smul_zero a                     -- `a • 0 = 0`
    _ = (0 : Matrix ι κ R) i k := rfl       -- 零行列の定義

/-- **`aO = O`**（具体版 `matrix_smul_zero_matrix`）。 -/
theorem smul_zero_matrix {α R : Type*} [Zero R] [SMulZeroClass α R] (a : α) :
    a • (0 : Matrix ι κ R) = 0 :=
  Matrix.ext (smul_zero_matrix_apply a)   -- 行列の等号は成分ごと

end Ising2D.NecSuf
