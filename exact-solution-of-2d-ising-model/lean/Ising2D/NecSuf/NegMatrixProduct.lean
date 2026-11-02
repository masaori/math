/-
# 因子の符号反転は行列の積の外へ出る（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNegationFactorsOutOfMatrixProduct.lean`
（人手 `negation_factors_out_of_left_factor`・`negation_factors_out_of_right_factor`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNegationFactorsOutOfMatrixProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `neg_mul_matrix_apply`（積の定義 → 符号反転の定義 → `-x = (-1)x` → 結合則 → 左分配則 → 積の定義 → `(-1)x = -x` → 符号反転の定義） | `neg_mul_matrix_apply'`（同じ並び） |
| `mul_neg_matrix_apply`（積の定義 → 符号反転の定義 → `-x = (-1)x` → 結合則 → 交換則 → 結合則 → 左分配則 → 積の定義 → `(-1)x = -x` → 符号反転の定義） | `mul_neg_matrix_apply'`（同じ並び。交換則の段は `-1` と `A_{ij}` の交換 `Commute.neg_one_right`） |

## 何が効いているか / 効いていないか

- 型クラスは `Semiring` と `HasDistribNeg` にした。効いているのは、`-x = (-1)x`（`neg_one_mul`。単位元と、符号反転が積に分配すること）、
  乗法の結合則、有限和への左分配則である。`Semiring` は単位元・結合則・分配則を持ち、`HasDistribNeg` は符号反転が積に分配することを持つ。
  単位元か結合則を欠くと、`-x = (-1)x` の段か結合則の段が出せない。
- **加法の逆元（`x + (-x) = 0`）は効いていない。** 具体版の `ℂ` は体だが、手順は符号反転を積の `-1` 倍として動かすだけで、
  符号反転を加法の逆元として使う段が無い。
- **係数の乗法の可換則は効いていない。** 具体版の `A(-B) = -(AB)` は `A_{ij}(-1) = (-1)A_{ij}` の段で `ℂ` の積の交換律を使っているが、
  交換する相手は `-1` だけであり、`-1` は単位元と `HasDistribNeg` だけから全ての元と交換する（`Commute.neg_one_right`）。
  したがって必要十分版は乗法が非可換な係数でも同じ段を通る。具体版のスカラー倍の主張 `A(aB) = a(AB)` が可換則を要するのとの違いはここにある。
- 添字は有限であること（`Fintype`。積が有限和だから）だけが効き、`Fin n` の順序は効いていない。
  複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2D.NecSuf

open Matrix

variable {ι κ μ : Type*}

/-- **`((-A)B)_{ik} = (-(AB))_{ik}`**（具体版 `neg_mul_matrix_apply`）。係数は `Semiring` と `HasDistribNeg`（可換則・加法の逆元は使わない）。 -/
theorem neg_mul_matrix_apply' {R : Type*} [Semiring R] [HasDistribNeg R] [Fintype κ]
    (A : Matrix ι κ R) (B : Matrix κ μ R) (i : ι) (k : μ) : ((-A) * B) i k = (-(A * B)) i k :=
  calc ((-A) * B) i k
      = ∑ j, (-A) i j * B j k := rfl                                         -- 積の定義
    _ = ∑ j, (-A i j) * B j k := rfl                                         -- 符号反転の定義
    _ = ∑ j, ((-1) * A i j) * B j k :=
        Finset.sum_congr rfl fun j _ => by rw [neg_one_mul]                   -- `-x = (-1)x`
    _ = ∑ j, (-1) * (A i j * B j k) :=
        Finset.sum_congr rfl fun j _ => mul_assoc _ _ _                       -- 結合則
    _ = (-1) * ∑ j, A i j * B j k := (Finset.mul_sum _ _ _).symm              -- 左分配則
    _ = (-1) * (A * B) i k := rfl                                             -- 積の定義
    _ = -(A * B) i k := neg_one_mul _                                         -- `(-1)x = -x`
    _ = (-(A * B)) i k := rfl                                                 -- 符号反転の定義

/-- **`(-A)B = -(AB)`**（具体版 `neg_mul_matrix`）。 -/
theorem neg_mul_matrix' {R : Type*} [Semiring R] [HasDistribNeg R] [Fintype κ] (A : Matrix ι κ R) (B : Matrix κ μ R) :
    (-A) * B = -(A * B) :=
  Matrix.ext (neg_mul_matrix_apply' A B)   -- 全ての成分が一致する

/-- **`(A(-B))_{ik} = (-(AB))_{ik}`**（具体版 `mul_neg_matrix_apply`）。係数は `Semiring` と `HasDistribNeg`。
交換則の段は `-1` が全ての元と交換すること（`Commute.neg_one_right`）で通り、係数の可換則は要らない。 -/
theorem mul_neg_matrix_apply' {R : Type*} [Semiring R] [HasDistribNeg R] [Fintype κ]
    (A : Matrix ι κ R) (B : Matrix κ μ R) (i : ι) (k : μ) : (A * (-B)) i k = (-(A * B)) i k :=
  calc (A * (-B)) i k
      = ∑ j, A i j * (-B) j k := rfl                                         -- 積の定義
    _ = ∑ j, A i j * (-B j k) := rfl                                         -- 符号反転の定義
    _ = ∑ j, A i j * ((-1) * B j k) :=
        Finset.sum_congr rfl fun j _ => by rw [neg_one_mul]                   -- `-x = (-1)x`
    _ = ∑ j, (A i j * (-1)) * B j k :=
        Finset.sum_congr rfl fun j _ => (mul_assoc _ _ _).symm                -- 結合則
    _ = ∑ j, ((-1) * A i j) * B j k :=
        Finset.sum_congr rfl fun j _ => by rw [(Commute.neg_one_right (A i j)).eq]  -- `-1` との交換
    _ = ∑ j, (-1) * (A i j * B j k) :=
        Finset.sum_congr rfl fun j _ => mul_assoc _ _ _                       -- 結合則
    _ = (-1) * ∑ j, A i j * B j k := (Finset.mul_sum _ _ _).symm              -- 左分配則
    _ = (-1) * (A * B) i k := rfl                                             -- 積の定義
    _ = -(A * B) i k := neg_one_mul _                                         -- `(-1)x = -x`
    _ = (-(A * B)) i k := rfl                                                 -- 符号反転の定義

/-- **`A(-B) = -(AB)`**（具体版 `mul_neg_matrix`）。 -/
theorem mul_neg_matrix' {R : Type*} [Semiring R] [HasDistribNeg R] [Fintype κ] (A : Matrix ι κ R) (B : Matrix κ μ R) :
    A * (-B) = -(A * B) :=
  Matrix.ext (mul_neg_matrix_apply' A B)   -- 全ての成分が一致する

end Ising2D.NecSuf
