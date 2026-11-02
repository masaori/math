/-
# 零行列を右から掛けると零行列（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimZeroMatrixIsRightZeroOfMatMult.lean`
（人手 `zero_matrix_is_right_zero_of_mat_mult`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimZeroMatrixIsRightZeroOfMatMultFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_mul_zero_matrix_apply`（積の定義 → 零行列の定義 → `z·0 = 0` → 零の有限和 → 零行列の定義） | `mul_zero_matrix_apply'`（同じ並び） |

## 何が効いているか / 効いていないか

- `A O = O` に効くのは、係数の `x·0 = 0`（仮定 `hz`）と、零の有限和が零であること（`Finset.sum_const_zero`。加法の可換モノイドの公理だけで出る）だけである。
  積の定義が `Finset.sum` を使うので、係数は `AddCommMonoid` と `Mul`、中の添字は有限型である。積の結合則・単位元・分配則、`0·x = 0` は効いていない。
  `hz` を外すと、`x·0` が `0` と限らない演算では主張は一般に成り立たない。
- 行列の添字の集合は任意で、有限であることは積の定義のためだけに要る。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ ν : Type*}

/-- **`(A O)_{ik} = O_{ik}`**（具体版 `matrix_mul_zero_matrix_apply`）。 -/
theorem mul_zero_matrix_apply' {R : Type*} [AddCommMonoid R] [Mul R] [Fintype κ]
    (hz : ∀ x : R, x * 0 = 0) (A : Matrix ι κ R) (i : ι) (k : ν) :
    (A * (0 : Matrix κ ν R)) i k = (0 : Matrix ι ν R) i k :=
  calc (A * (0 : Matrix κ ν R)) i k
      = ∑ j, A i j * (0 : Matrix κ ν R) j k := Matrix.mul_apply          -- 積の定義
    _ = ∑ j, A i j * (0 : R) := rfl                                      -- 零行列の定義を各項へ
    _ = ∑ _j : κ, (0 : R) := Finset.sum_congr rfl fun j _ => hz (A i j)  -- `x·0 = 0` を各項へ
    _ = 0 := Finset.sum_const_zero                                       -- 零の有限和
    _ = (0 : Matrix ι ν R) i k := rfl                                    -- 零行列の定義

/-- **`A O = O`**（具体版 `matrix_mul_zero_matrix`）。 -/
theorem mul_zero_matrix' {R : Type*} [AddCommMonoid R] [Mul R] [Fintype κ]
    (hz : ∀ x : R, x * 0 = 0) (A : Matrix ι κ R) : A * (0 : Matrix κ ν R) = 0 :=
  Matrix.ext (mul_zero_matrix_apply' hz A)   -- 全ての成分が一致する

end Ising2D.NecSuf
