/-
# 必要十分版: 双線型値 `u^⊤Pv` を `u` と `Pv` の成分の積の和に開くことと、対称な行列を積の和の左の因子から右の因子へ移すこと

人手証明のラベル: **`real_bilinear_value_is_sum_with_real_matrix_vector_product`**・
**`real_symmetric_matrix_moves_between_factors_of_sum_of_products`**（正本 `structured-latex/content/011_max_eigenvalue.ts`）。
具体版は `Ising2D.real_bilinear_value_is_sum_with_real_matrix_vector_product`・
`Ising2D.real_symmetric_matrix_moves_between_factors_of_sum_of_products`
（`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean`）で、
導出は同じフォルダの `ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactorsFromNecSuf.lean` に置く。

## 手順（具体版の `calc` と同じ並び）

| 具体版の段 | 本ファイル |
| --- | --- |
| `def_real_matrix_vector_product`（右辺から左辺へを含む） | `rfl` |
| `finite_sum_of_real_scalar_multiples`（右辺から左辺へを含む） | `finite_sum_mul_left'`（`NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`） |
| `def_real_symmetric_matrix` を各項へ | `Matrix.IsSymm.apply` |
| 乗法の可換則・結合則を各項へ | `mul_comm`・`mul_assoc` |
| `finite_double_sum_of_real_numbers_interchange` | `finite_double_sum_interchange'`（`NecSuf/FiniteDoubleSumInterchange.lean`） |

## この主張に本質的に効いている構造

一つ目の主張（`Σ_kΣ_l (u_kP_kl)v_l = Σ_k u_k(Pv)_k`。左辺は人手 `def_real_bilinear_value` の和で、mathlib の `u ⬝ᵥ P *ᵥ v` では書かない。
`⬝ᵥ` は定義から右辺と `rfl` で一致し、検査にならないため）:
* 乗法の結合則（1 段目）。`(u_kP_kl)v_l` から `(Pv)_k` を作るには `u_k(P_klv_l)` へ組み替えるしかないので外せない。
* 左分配則と `a·0 = 0`（2 段目の `finite_sum_mul_left'`。`a·0 = 0` は添字の型が空のときに要る）。
* 乗法の可換性・単位元・加法の逆元・順序・ℝ であることは使わない。したがって係数は非単位的な半環 `R` に置く。

二つ目の主張（対称な `Q` で `Σ_k (Qu)_k v_k = Σ_k u_k(Qv)_k`）:
* 乗法の**可換則**（2・5・6 段目）。可換でない係数では、`Q` が対称でも主張は一般に成り立たない
  （`n = 1` で、係数を 2 行 2 列の行列にとり、`v` を単位行列、`Q = q`・`u` を `qu ≠ uq` となる行列にすると、左辺は `qu`、右辺は `uq`）ので、外せない。
* 乗法の結合則（7 段目）、左分配則と `a·0 = 0`（3・9 段目）、加法の結合則・交換則（8 段目の和の順序の入れ替え）。
* 乗法の単位元・加法の逆元・順序・ℝ であることは使わない。したがって係数は非単位的な可換半環 `R` に置く。
-/
import Ising2D.NecSuf.FiniteDoubleSumInterchange
import Ising2D.NecSuf.FiniteSumDifferenceAndNonnegativeTerm
import Mathlib.LinearAlgebra.Matrix.Symmetric

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {n : Type*} [Fintype n]

/-- **人手 `real_bilinear_value_is_sum_with_real_matrix_vector_product` の必要十分版**（具体版の 3 段と同じ並び）。 -/
theorem bilinear_value_is_sum_with_matrix_vector_product' {R : Type*} [NonUnitalSemiring R]
    (P : Matrix n n R) (u v : n → R) :
    ∑ k, ∑ l, u k * P k l * v l = ∑ k, u k * (P *ᵥ v) k :=
  calc ∑ k, ∑ l, u k * P k l * v l
      = ∑ k, ∑ l, u k * (P k l * v l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_assoc (u k) (P k l) (v l)
    _ = ∑ k, u k * ∑ l, P k l * v l :=
        Finset.sum_congr rfl fun k _ =>
          finite_sum_mul_left' (u k) (mul_zero _) (fun l => P k l * v l)
    _ = ∑ k, u k * (P *ᵥ v) k := rfl

/-- **人手 `real_symmetric_matrix_moves_between_factors_of_sum_of_products` の必要十分版**（具体版の 10 段と同じ並び）。 -/
theorem symmetric_matrix_moves_between_factors_of_sum_of_products' {R : Type*} [NonUnitalCommSemiring R]
    (Q : Matrix n n R) (hQ : Q.IsSymm) (u v : n → R) :
    ∑ k, (Q *ᵥ u) k * v k = ∑ k, u k * (Q *ᵥ v) k :=
  calc ∑ k, (Q *ᵥ u) k * v k
      = ∑ k, (∑ l, Q k l * u l) * v k := rfl
    _ = ∑ k, v k * ∑ l, Q k l * u l :=
        Finset.sum_congr rfl fun k _ => mul_comm (∑ l, Q k l * u l) (v k)
    _ = ∑ k, ∑ l, v k * (Q k l * u l) :=
        Finset.sum_congr rfl fun k _ =>
          (finite_sum_mul_left' (v k) (mul_zero _) (fun l => Q k l * u l)).symm
    _ = ∑ k, ∑ l, v k * (Q l k * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [hQ.apply l k]
    _ = ∑ k, ∑ l, Q l k * u l * v k :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_comm (v k) (Q l k * u l)
    _ = ∑ k, ∑ l, u l * Q l k * v k :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_comm (Q l k) (u l)]
    _ = ∑ k, ∑ l, u l * (Q l k * v k) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_assoc (u l) (Q l k) (v k)
    _ = ∑ l, ∑ k, u l * (Q l k * v k) :=
        finite_double_sum_interchange' (fun k l => u l * (Q l k * v k))
    _ = ∑ l, u l * ∑ k, Q l k * v k :=
        Finset.sum_congr rfl fun l _ =>
          finite_sum_mul_left' (u l) (mul_zero _) (fun k => Q l k * v k)
    _ = ∑ k, u k * (Q *ᵥ v) k := rfl

end Ising2D.NecSuf
