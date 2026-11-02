/-
# スカラー倍は行列の差に分配する（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleDistributesOverMatrixDifference.lean`
（人手 `scalar_multiple_distributes_over_matrix_difference`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleDistributesOverMatrixDifferenceFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_smul_sub_apply`（スカラー倍の定義 → 差の定義 → `x - y = x + (-y)` → 左分配則 → `-y = (-1)y` → 結合則 → 交換則 → 結合則 → `(-1)y = -y` → `x + (-y) = x - y` → スカラー倍の定義 → 差の定義） | `smul_sub_matrix_apply'`（同じ並び。交換則の段は `c` と `-1` の交換 `Commute.neg_one_left`） |
| `matrix_smul_sub`（行列の等号は成分ごと） | `smul_sub_matrix'` |

## 何が効いているか / 効いていないか

- 係数は `Semiring` と `HasDistribNeg` にし、スカラーは係数と同じ集合の元が左から掛かるものとした（具体版のスカラー倍が `ℂ` の積であることに合わせた）。
  効いているのは、差が `x - y = x + (-y)` であること、左分配則、`-y = (-1)y`（単位元と、符号反転が積に分配すること）、乗法の結合則である。
- 差が `x + (-y)` で定まることは、仮定 `hsub` として受け取る。人手の `def_complex_difference` がこの式で差を定めているのに当たる。
  mathlib には、この式と `Semiring`・`HasDistribNeg` を加法の逆元なしで同時に持つ型クラスが無いので、`Ring` にせず仮定の形にした。
  `ℂ` への特殊化では `hsub` に `sub_eq_add_neg` を渡す。
- **加法の逆元（`x + (-x) = 0`）は効いていない。** 符号反転を加法の逆元として使う段が無い。
- **係数の乗法の可換則は効いていない。** 具体版は `c(-1) = (-1)c` の段で `ℂ` の積の交換律を使っているが、交換する相手は `-1` だけであり、
  `-1` は単位元と `HasDistribNeg` だけから全ての元と交換する（`Commute.neg_one_left`）。
- 行列の添字の集合は任意で、有限であることは効いていない（積を使わないため）。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(c(A - B))_{ik} = (cA - cB)_{ik}`**（具体版 `matrix_smul_sub_apply`）。係数は `Semiring` と `HasDistribNeg`、差は `hsub` の式で定まるもの（可換則・加法の逆元は使わない）。 -/
theorem smul_sub_matrix_apply' {R : Type*} [Semiring R] [HasDistribNeg R] [Sub R]
    (hsub : ∀ x y : R, x - y = x + -y) (c : R) (A B : Matrix ι κ R) (i : ι) (k : κ) :
    (c • (A - B)) i k = (c • A - c • B) i k :=
  calc (c • (A - B)) i k
      = c * (A - B) i k := rfl                                                -- スカラー倍の定義
    _ = c * (A i k - B i k) := rfl                                            -- 差の定義
    _ = c * (A i k + -B i k) := by rw [hsub]                                  -- `x - y = x + (-y)`
    _ = c * A i k + c * (-B i k) := mul_add _ _ _                             -- 左分配則
    _ = c * A i k + c * ((-1) * B i k) := by rw [neg_one_mul]                 -- `-y = (-1)y`
    _ = c * A i k + (c * (-1)) * B i k := by rw [mul_assoc]                   -- 結合則
    _ = c * A i k + ((-1) * c) * B i k := by rw [(Commute.neg_one_left c).eq.symm]  -- `-1` との交換
    _ = c * A i k + (-1) * (c * B i k) := by rw [mul_assoc]                   -- 結合則
    _ = c * A i k + -(c * B i k) := by rw [neg_one_mul]                       -- `(-1)y = -y`
    _ = c * A i k - c * B i k := (hsub _ _).symm                              -- `x + (-y) = x - y`
    _ = (c • A) i k - (c • B) i k := rfl                                      -- スカラー倍の定義
    _ = (c • A - c • B) i k := rfl                                            -- 差の定義

/-- **`c(A - B) = cA - cB`**（具体版 `matrix_smul_sub`）。 -/
theorem smul_sub_matrix' {R : Type*} [Semiring R] [HasDistribNeg R] [Sub R]
    (hsub : ∀ x y : R, x - y = x + -y) (c : R) (A B : Matrix ι κ R) :
    c • (A - B) = c • A - c • B :=
  Matrix.ext (smul_sub_matrix_apply' hsub c A B)   -- 行列の等号は成分ごと

end Ising2D.NecSuf
