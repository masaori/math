/-
# 行列の 1 倍は元の行列（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleByOne.lean`
（人手 `scalar_multiple_by_one`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleByOneFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_one_smul_apply`（スカラー倍の定義 → `1_ℂ z = z`） | `one_smul_matrix_apply'`（スカラー倍の定義 → `1 • x = x`） |

## 何が効いているか / 効いていないか

- `1_ℂ A = A` に効くのは、スカラーの `1` を係数に作用させると係数が変わらないこと（仮定 `ho`）だけである。
  スカラーと係数が同じ集合であること、スカラー倍が係数の積であることは効いていない。係数の加法・積の他の性質も効いていない。
- 行列の添字の集合は任意で、有限であることは効いていない。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(1 A)_{ij} = A_{ij}`**（具体版 `matrix_one_smul_apply`）。 -/
theorem one_smul_matrix_apply' {α R : Type*} [One α] [SMul α R]
    (ho : ∀ x : R, (1 : α) • x = x) (A : Matrix ι κ R) (i : ι) (j : κ) :
    ((1 : α) • A) i j = A i j :=
  calc ((1 : α) • A) i j
      = (1 : α) • A i j := rfl              -- スカラー倍の定義
    _ = A i j := ho _                        -- `1 • x = x`

/-- **`1 A = A`**（具体版 `matrix_one_smul`）。 -/
theorem one_smul_matrix' {α R : Type*} [One α] [SMul α R]
    (ho : ∀ x : R, (1 : α) • x = x) (A : Matrix ι κ R) : (1 : α) • A = A :=
  Matrix.ext (one_smul_matrix_apply' ho A)   -- 行列の等号は成分ごと

end Ising2D.NecSuf
