/-
# 符号反転した行列のスカラー倍はスカラー倍の符号反転に等しい（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleOfNegatedMatrix.lean`
（人手 `scalar_multiple_of_negated_matrix`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleOfNegatedMatrixFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `smul_neg_matrix_apply`（スカラー倍の定義 → 符号反転の定義 → `-x = (-1)x` → 結合則 → 交換則 → 結合則 → `(-1)x = -x` → スカラー倍の定義 → 符号反転の定義） | `smul_neg_matrix_apply'`（同じ並び。交換則の段は `a` と `-1` の交換 `Commute.neg_one_right`） |

## 何が効いているか / 効いていないか

- 型クラスは `Monoid` と `HasDistribNeg` にした。効いているのは、`-x = (-1)x`（`neg_one_mul`。単位元と、符号反転が積に分配すること）と
  乗法の結合則である。単位元か結合則を欠くと、`-x = (-1)x` の段か結合則の段が出せない。
- **加法は効いていない。** 成分の鎖に和が一つも現れない（行列の積を含まない）ので、加法・分配則・零元のどれも要らない。
  同じ符号反転の主張でも、行列の積を含む `negation_factors_out_of_left_factor` の必要十分版（`NecSuf/NegMatrixProduct.lean`）が
  `Semiring` を要るのとの違いはここにある。
- **係数の乗法の可換則は効いていない。** 具体版は `a(-1) = (-1)a` の段で `ℂ` の積の交換律を使っているが、
  交換する相手は `-1` だけであり、`-1` は単位元と `HasDistribNeg` だけから全ての元と交換する（`Commute.neg_one_right`）。
- 添字の有限性も、`Fin m`・`Fin n` の順序も効いていない（添字の型は任意）。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(a(-A))_{ij} = (-(aA))_{ij}`**（具体版 `smul_neg_matrix_apply`）。係数は `Monoid` と `HasDistribNeg`（加法・可換則は使わない）。 -/
theorem smul_neg_matrix_apply' {R : Type*} [Monoid R] [HasDistribNeg R]
    (a : R) (A : Matrix ι κ R) (i : ι) (j : κ) : (a • (-A)) i j = (-(a • A)) i j :=
  calc (a • (-A)) i j
      = a * (-A) i j := rfl                                                  -- スカラー倍の定義
    _ = a * (-A i j) := rfl                                                  -- 符号反転の定義
    _ = a * ((-1) * A i j) := by rw [neg_one_mul]                            -- `-x = (-1)x`
    _ = (a * (-1)) * A i j := (mul_assoc _ _ _).symm                         -- 結合則
    _ = ((-1) * a) * A i j := by rw [(Commute.neg_one_right a).eq]           -- `-1` との交換
    _ = (-1) * (a * A i j) := mul_assoc _ _ _                                -- 結合則
    _ = -(a * A i j) := neg_one_mul _                                        -- `(-1)x = -x`
    _ = -((a • A) i j) := rfl                                                -- スカラー倍の定義
    _ = (-(a • A)) i j := rfl                                                -- 符号反転の定義

/-- **`a(-A) = -(aA)`**（具体版 `smul_neg_matrix`）。 -/
theorem smul_neg_matrix' {R : Type*} [Monoid R] [HasDistribNeg R] (a : R) (A : Matrix ι κ R) :
    a • (-A) = -(a • A) :=
  Matrix.ext (smul_neg_matrix_apply' a A)   -- 全ての成分が一致する

end Ising2D.NecSuf
