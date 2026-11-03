/-
# 一つの行列のスカラー倍の差と有限和（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultiplesOfOneMatrix.lean`
（人手 `difference_of_scalar_multiples_of_one_matrix`・`finite_sum_of_scalar_multiples_of_one_matrix`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultiplesOfOneMatrixFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `smul_sub_smul_matrix_apply`（差の定義 → スカラー倍の定義を 2 か所 → `x - y = x + (-y)` → `-y = (-1)y` → 結合則 → `(-1)b = -b` → 右分配則を右辺から左辺へ → `x + (-y) = x - y` → スカラー倍の定義） | `smul_sub_smul_matrix_apply'`（同じ並び） |
| `smul_sub_smul_matrix`（全ての成分が一致する） | `smul_sub_smul_matrix'` |
| `finite_sum_smul_one_matrix_apply`（有限和の成分は成分の有限和 → スカラー倍の定義を各項へ → 係数の有限和の右分配 → スカラー倍の定義） | `finite_sum_smul_one_matrix_apply'`（同じ並び） |
| `finite_sum_smul_one_matrix`（全ての成分が一致する） | `finite_sum_smul_one_matrix'` |

## 何が効いているか / 効いていないか

- スカラーは係数と同じ集合の元が左から掛かるものとした（具体版のスカラー倍が `ℂ` の積であることに合わせた）。
- 差のくくり出しで効いているのは、差が `x - y = x + (-y)` であること（仮定 `hsub`。人手の `def_complex_difference` に当たる。
  `SmulMatrixSub.lean` と同じ理由で型クラスにせず仮定にした）、`-y = (-1)y`（単位元と、符号反転が積に分配すること。`HasDistribNeg`）、
  乗法の結合則、**右分配則**である。
- 差のくくり出しの仮定は `Add`・`Monoid`・`HasDistribNeg`・`RightDistribClass`・`Sub`（と `hsub`）だけにした。
  **加法の結合則・交換則・零、左分配則、`0 * x = 0`、加法の逆元（`x + (-x) = 0`）、乗法の可換則は効いていない。** 具体版 `scalar_multiple_distributes_over_matrix_difference`
  と違い、`-1` と係数を入れ替える段も無い。
- 有限和のくくり出しで効いているのは、行列の有限和の成分が成分の有限和であることと、係数の有限和の右分配（`Finset.sum_mul`）だけである。
  `Finset.sum_mul` のために `NonUnitalNonAssocSemiring` を取った。`0 * x = 0` は mathlib の `Finset.sum` の空の和の段にだけ現れ、
  人手の `r ≥ 1` 項の和では効いていない。**乗法の結合則・単位元・可換則、加法の逆元は効いていない。**
- 行列の添字の集合は任意で、有限であることも順序も効いていない（積を使わないため）。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(aA - bA)_{ik} = ((a - b)A)_{ik}`**（具体版 `smul_sub_smul_matrix_apply`）。係数は加法（`Add`。結合則・交換則・零は使わない）、乗法のモノイド（結合則・単位元）、`HasDistribNeg`、右分配則、差は `hsub` の式で定まるもの。 -/
theorem smul_sub_smul_matrix_apply' {R : Type*} [Add R] [Monoid R] [HasDistribNeg R] [RightDistribClass R] [Sub R]
    (hsub : ∀ x y : R, x - y = x + -y) (a b : R) (A : Matrix ι κ R) (i : ι) (k : κ) :
    (a • A - b • A) i k = ((a - b) • A) i k :=
  calc (a • A - b • A) i k
      = (a • A) i k - (b • A) i k := rfl                                      -- 差の定義
    _ = a * A i k - b * A i k := rfl                                          -- スカラー倍の定義（2 か所へ同時適用）
    _ = a * A i k + -(b * A i k) := hsub _ _                                  -- `x - y = x + (-y)`
    _ = a * A i k + (-1) * (b * A i k) := by rw [neg_one_mul]                 -- `-y = (-1)y`
    _ = a * A i k + ((-1) * b) * A i k := by rw [mul_assoc]                   -- 結合則
    _ = a * A i k + (-b) * A i k := by rw [neg_one_mul]                       -- `(-1)b = -b`
    _ = (a + -b) * A i k := (right_distrib _ _ _).symm                        -- 右分配則を右辺から左辺へ
    _ = (a - b) * A i k := by rw [hsub]                                       -- `x + (-y) = x - y`
    _ = ((a - b) • A) i k := rfl                                              -- スカラー倍の定義

/-- **`aA - bA = (a - b)A`**（具体版 `smul_sub_smul_matrix`）。 -/
theorem smul_sub_smul_matrix' {R : Type*} [Add R] [Monoid R] [HasDistribNeg R] [RightDistribClass R] [Sub R]
    (hsub : ∀ x y : R, x - y = x + -y) (a b : R) (A : Matrix ι κ R) :
    a • A - b • A = (a - b) • A :=
  Matrix.ext (smul_sub_smul_matrix_apply' hsub a b A)   -- 全ての成分が一致する

/-- **`(Σ_j c_jA)_{ik} = ((Σ_j c_j)A)_{ik}`**（具体版 `finite_sum_smul_one_matrix_apply`）。 -/
theorem finite_sum_smul_one_matrix_apply' {R : Type*} [NonUnitalNonAssocSemiring R] (r : ℕ)
    (c : Fin (r + 1) → R) (A : Matrix ι κ R) (i : ι) (k : κ) :
    (∑ j, c j • A) i k = ((∑ j, c j) • A) i k :=
  calc (∑ j, c j • A) i k
      = ∑ j, (c j • A) i k := Matrix.sum_apply _ _ _ _                        -- 有限和の成分は成分の有限和
    _ = ∑ j, c j * A i k := rfl                                               -- スカラー倍の定義を各項へ
    _ = (∑ j, c j) * A i k := (Finset.sum_mul _ _ _).symm                     -- 係数の有限和の右分配
    _ = ((∑ j, c j) • A) i k := rfl                                           -- スカラー倍の定義

/-- **`Σ_j (c_jA) = (Σ_j c_j)A`**（具体版 `finite_sum_smul_one_matrix`）。 -/
theorem finite_sum_smul_one_matrix' {R : Type*} [NonUnitalNonAssocSemiring R] (r : ℕ)
    (c : Fin (r + 1) → R) (A : Matrix ι κ R) :
    ∑ j, c j • A = (∑ j, c j) • A :=
  Matrix.ext (finite_sum_smul_one_matrix_apply' r c A)   -- 全ての成分が一致する

end Ising2D.NecSuf
