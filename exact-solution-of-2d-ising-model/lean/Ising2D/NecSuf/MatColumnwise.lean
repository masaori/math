/-
# 行列の積は列ごとに作用する（**必要十分版**）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatColumnwise.lean`
（人手 `mat_columnwise`）。具体版をこのファイルの系として導くのと `TensorPow M` での系は、同じフォルダの
`ClaimMatColumnwiseFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `mat_columnwise` の 4 行（積の成分・列に並べた行列の成分・行列とベクトルの積の成分・列に並べた行列の成分） | `mul_cols_eq_cols_mulVec` の 4 段（同じ並び） |

## 何が効いているか / 効いていないか

- 効いているのは、**行列の積と行列とベクトルの積が同じ和 `Σ_j A_{ij} v_j` で定まること**だけで、係数に要るのは
  その和を書くための `Mul`・`AddCommMonoid`（mathlib の `Matrix.mulVec` が要求する `NonUnitalNonAssocSemiring`）である。
  積の結合則・分配則・単位元・可換性はどれも鎖に出ない。添字の集合に順序も要らない（`Fintype` だけ）。
-/
import Mathlib.Data.Matrix.Mul

namespace Ising2D.NecSuf

open Matrix

variable {m n p R : Type*} [Fintype n] [NonUnitalNonAssocSemiring R]

/-- **`mat_columnwise` の必要十分版**: `A[b_1 ⋯ b_p] = [Ab_1 ⋯ Ab_p]`（列に並べた行列は `Matrix.of fun j k => b k j`）。
calc の 4 段は具体版 `Ising2D.matrix_mul_columns` の 4 段と同じ順に並ぶ。 -/
theorem mul_cols_eq_cols_mulVec (A : Matrix m n R) (b : p → n → R) :
    A * Matrix.of (fun j k => b k j) = Matrix.of (fun i k => (A *ᵥ b k) i) := by
  ext i k
  calc (A * Matrix.of (fun j k => b k j)) i k
      = ∑ j, A i j * Matrix.of (fun j k => b k j) j k := rfl
                                                        -- `mat_mult` の積の成分にあたる
    _ = ∑ j, A i j * b k j := rfl                       -- 列に並べた行列の成分の定め方
    _ = (A *ᵥ b k) i := rfl                             -- `mat_mult` を `Ab_k` へ適用したものにあたる
    _ = Matrix.of (fun i k => (A *ᵥ b k) i) i k := rfl  -- 列に並べた行列の成分の定め方

end Ising2D.NecSuf
