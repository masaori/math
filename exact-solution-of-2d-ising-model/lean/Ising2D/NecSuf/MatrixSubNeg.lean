/-
# 行列の差は符号反転した行列との和に等しい・符号反転した行列の差は差の符号反転に等しい（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixDifferenceIsSumWithNegation.lean`
（人手 `matrix_difference_is_sum_with_negation`・`difference_of_negated_matrices`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixDifferenceIsSumWithNegationFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_sub_eq_add_neg_apply`（差の定義 → `x - y = x + (-y)` → 符号反転の定義 → 和の定義） | `sub_eq_add_neg_matrix_apply'`（同じ並び） |
| `neg_sub_neg_matrix`（差を和と符号反転へ → 和の符号反転を右辺から左辺へ → 和と符号反転を差へ） | `neg_sub_neg_matrix'`（同じ並び） |

## 何が効いているか / 効いていないか

- 差が `x + (-y)` で定まることは、仮定 `hsub : ∀ x y, x - y = x + (-y)` として受け取る（人手の `def_complex_difference`）。
  `A - B = A + (-B)` で効いているのは **`hsub` だけ**である。係数の `Add`・`Neg`・`Sub` に他の性質（結合則・交換則・零・逆元・積）は要らない。
  `hsub` を外すと `Sub` は `Add`・`Neg` と無関係な演算になり、主張は一般には成り立たない。
- `(-A) - (-B) = -(A - B)` で効いているのは、`hsub` と、和の符号反転（`NecSuf.neg_add_matrix'`。`-x = (-1)x` の仮定 `hneg` と左分配則）だけである。
  **二重の符号反転 `-(-y) = y`、加法の逆元 `x + (-x) = 0`、加法の結合則・交換則・零、乗法の結合則・単位元・可換則は効いていない。**
  `-(-B)` を `B` へ戻す段が無いからである。
- 添字の集合は任意で、有限であることは効いていない（積を使わないため）。複素数であること、体であることは効いていない。
-/
import Ising2D.NecSuf.NegMatrixSum

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(A - B)_{ij} = (A + (-B))_{ij}`**（具体版 `matrix_sub_eq_add_neg_apply`）。 -/
theorem sub_eq_add_neg_matrix_apply' {R : Type*} [Add R] [Neg R] [Sub R]
    (hsub : ∀ x y : R, x - y = x + -y) (A B : Matrix ι κ R) (i : ι) (j : κ) :
    (A - B) i j = (A + (-B)) i j :=
  calc (A - B) i j
      = A i j - B i j := rfl                                                  -- 差の定義
    _ = A i j + (-B i j) := hsub _ _                                          -- `x - y = x + (-y)`
    _ = A i j + (-B) i j := rfl                                               -- 符号反転の定義
    _ = (A + (-B)) i j := rfl                                                 -- 和の定義

/-- **`A - B = A + (-B)`**（具体版 `matrix_sub_eq_add_neg`）。 -/
theorem sub_eq_add_neg_matrix' {R : Type*} [Add R] [Neg R] [Sub R]
    (hsub : ∀ x y : R, x - y = x + -y) (A B : Matrix ι κ R) : A - B = A + (-B) :=
  Matrix.ext (sub_eq_add_neg_matrix_apply' hsub A B)   -- 全ての成分が一致する

/-- **`(-A) - (-B) = -(A - B)`**（具体版 `neg_sub_neg_matrix`）。 -/
theorem neg_sub_neg_matrix' {R : Type*} [Add R] [Mul R] [Neg R] [One R] [Sub R] [LeftDistribClass R]
    (hsub : ∀ x y : R, x - y = x + -y) (hneg : ∀ x : R, -x = (-1) * x) (A B : Matrix ι κ R) :
    (-A) - (-B) = -(A - B) :=
  calc (-A) - (-B)
      = (-A) + (-(-B)) := sub_eq_add_neg_matrix' hsub _ _                    -- 差を和と符号反転へ
    _ = -(A + (-B)) := (neg_add_matrix' hneg A (-B)).symm                     -- 和の符号反転
    _ = -(A - B) := by rw [sub_eq_add_neg_matrix' hsub A B]                   -- 和と符号反転を差へ

end Ising2D.NecSuf
