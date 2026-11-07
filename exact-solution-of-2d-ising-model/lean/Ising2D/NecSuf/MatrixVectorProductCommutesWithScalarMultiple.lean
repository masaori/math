/-
# 必要十分版: 行列とベクトルの積は、ベクトルの左からのスカラー倍と交換する

人手証明のラベル: **`real_matrix_vector_product_commutes_with_real_scalar_multiple`**
（正本 `structured-latex/content/002_linear_space_general.ts`）。
具体版は `Ising2D.real_matrix_vector_product_commutes_with_real_scalar_multiple`
（`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealMatrixVectorProductCommutesWithRealScalarMultiple.lean`）で、
導出は同じフォルダの `ClaimRealMatrixVectorProductCommutesWithRealScalarMultipleFromNecSuf.lean` に置く。

## 手順（具体版の `calc` と同じ並び）

| 具体版の段 | 本ファイル |
| --- | --- |
| `def_real_matrix_vector_product`（最初と最後の段） | `rfl`（mathlib の `*ᵥ` の成分は `Σ_j P_ij x_j`） |
| 仮定 `w_k = c u_k` | 仮定 `hw` |
| 結合則、交換則、結合則 | `mul_assoc`、仮定 `hc`、`mul_assoc` |
| `finite_sum_of_real_scalar_multiples_fintype` | `finite_sum_mul_left'`（`NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`） |

## この主張に本質的に効いている構造

* 乗法の結合則（人手の 2 か所の段）と、`c` が行 `i` の各成分 `P_ij` と可換であること（明示の仮定 `hc`。人手の交換則の段
  `P_ij c = c P_ij` で使う元だけに限った）、左分配則と `c·0 = 0`（`finite_sum_mul_left'`）。
  乗法の可換性一般・単位元・加法の逆元・順序は使わない。
* `hc` を外すと人手の交換則の段が書けず、`(Pw)_i` と `c(Pu)_i` は一般に一致しない
  （非可換な環で、`c` が `P_ij` と可換でない場合。例えば係数を 2×2 の実行列の環（単位元を持つ非可換な環）に取り、
  `pc ≠ cp` なる `p, c` について 1 行 1 列で `P = (p)`、`u = (1)` とすると `(Pw)_1 = pc`、`c(Pu)_1 = cp`）。
* 主張の文の `P *ᵥ w` そのものが mathlib で `NonUnitalNonAssocSemiring` を要求し、結合則の段のために結合的にする。
  以上から、係数は非単位的な半環 `R` に置く。
-/
import Ising2D.NecSuf.FiniteSumDifferenceAndNonnegativeTerm
import Mathlib.Data.Matrix.Mul

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*} [NonUnitalSemiring R]
variable {α β : Type*} [Fintype β]

/-- **人手 `real_matrix_vector_product_commutes_with_real_scalar_multiple` の必要十分版**（具体版の 7 段と同じ並び）。 -/
theorem matrix_vector_product_commutes_with_scalar_multiple' (P : Matrix α β R) (c : R) (u w : β → R)
    (hw : ∀ k, w k = c * u k) (i : α) (hc : ∀ j, P i j * c = c * P i j) :
    (P *ᵥ w) i = c * (P *ᵥ u) i :=
  calc (P *ᵥ w) i
      = ∑ j, P i j * w j := rfl
    _ = ∑ j, P i j * (c * u j) := Finset.sum_congr rfl fun j _ => by rw [hw j]
    _ = ∑ j, (P i j * c) * u j := Finset.sum_congr rfl fun j _ => (mul_assoc _ _ _).symm
    _ = ∑ j, (c * P i j) * u j := Finset.sum_congr rfl fun j _ => by rw [hc j]
    _ = ∑ j, c * (P i j * u j) := Finset.sum_congr rfl fun j _ => mul_assoc _ _ _
    _ = c * ∑ j, P i j * u j := finite_sum_mul_left' c (mul_zero c) (fun j => P i j * u j)
    _ = c * (P *ᵥ u) i := rfl

end Ising2D.NecSuf
