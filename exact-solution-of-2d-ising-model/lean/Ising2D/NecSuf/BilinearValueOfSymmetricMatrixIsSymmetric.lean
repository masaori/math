/-
# 必要十分版: 対称な行列 `P` について `u^⊤Pv = v^⊤Pu`

人手証明のラベル: **`real_bilinear_value_of_symmetric_matrix_is_symmetric`**
（正本 `structured-latex/content/011_max_eigenvalue.ts`）。
具体版は `Ising2D.real_bilinear_value_of_symmetric_matrix_is_symmetric`
（`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueOfSymmetricMatrixIsSymmetric.lean`）で、
導出は同じフォルダの `ClaimRealBilinearValueOfSymmetricMatrixIsSymmetricFromNecSuf.lean` に置く。

## 手順（具体版の `calc` の 7 段と同じ並び）

| 具体版の段 | 本ファイル |
| --- | --- |
| 1 段目 `def_real_bilinear_value` | `dotProduct_mulVec_eq_double_sum'`（`NecSuf/BilinearValueAtMostValueAtAbsoluteVector.lean`） |
| 2 段目 `def_real_symmetric_matrix` を各項へ | `Matrix.IsSymm.apply` |
| 3・4 段目 乗法の可換則を各項へ | `mul_comm` |
| 5 段目 乗法の結合則を各項へ | `mul_assoc` |
| 6 段目 `finite_double_sum_of_real_numbers_interchange` | `finite_double_sum_interchange'`（`NecSuf/FiniteDoubleSumInterchange.lean`） |
| 7 段目 `def_real_bilinear_value` を右辺から左辺へ | `dotProduct_mulVec_eq_double_sum'` |

## この主張に本質的に効いている構造

* 乗法の**可換則**（3・4 段目）。可換でない係数では、`P` が対称でも `u^⊤Pv = v^⊤Pu` は一般に成り立たない
  （`n = 1`・`P = 1` で `uv` と `vu`）ので、外せない。
* 乗法の結合則（5 段目と、mathlib の `x ⬝ᵥ P *ᵥ y` を人手の和へ開く 1・7 段目）。結合的でない係数では
  `(u_kP_kl)v_l` と `u_k(P_klv_l)` が一致せず、人手の `Σ_kΣ_l (x_kP_kl)y_l` と mathlib の値が別物になるので外せない。
* 加法の結合則・交換則（6 段目の和の順序の入れ替え。`NecSuf/FiniteDoubleSumInterchange.lean`）。和の順序の入れ替えはこの二つに尽きるので外せない。
* 分配律と `a·0 = 0` は、mathlib の `x ⬝ᵥ P *ᵥ y`（`Σ_k x_k (Σ_l P_kl y_l)`）を人手の `Σ_kΣ_l (x_kP_kl)y_l` へ開く段
  （`Finset.mul_sum`。`a·0 = 0` は添字の型が空のときに要る）だけで使う。
* 乗法の単位元・加法の逆元・順序・ℝ であることは使わない。したがって係数は非単位的な可換半環 `R` に置く。
-/
import Ising2D.NecSuf.BilinearValueAtMostValueAtAbsoluteVector
import Ising2D.NecSuf.FiniteDoubleSumInterchange
import Mathlib.LinearAlgebra.Matrix.Symmetric

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*} [NonUnitalCommSemiring R]
variable {n : Type*} [Fintype n]

/-- **人手 `real_bilinear_value_of_symmetric_matrix_is_symmetric` の必要十分版**（具体版の 7 段と同じ並び）。 -/
theorem bilinear_value_of_symmetric_matrix_is_symmetric' (P : Matrix n n R) (hP : P.IsSymm) (u v : n → R) :
    u ⬝ᵥ P *ᵥ v = v ⬝ᵥ P *ᵥ u :=
  calc u ⬝ᵥ P *ᵥ v
      = ∑ k, ∑ l, u k * P k l * v l := dotProduct_mulVec_eq_double_sum' u v P
    _ = ∑ k, ∑ l, u k * P l k * v l :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [hP.apply l k]
    _ = ∑ k, ∑ l, v l * (u k * P l k) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_comm (u k * P l k) (v l)
    _ = ∑ k, ∑ l, v l * (P l k * u k) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_comm (u k) (P l k)]
    _ = ∑ k, ∑ l, v l * P l k * u k :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          (mul_assoc (v l) (P l k) (u k)).symm
    _ = ∑ l, ∑ k, v l * P l k * u k :=
        finite_double_sum_interchange' (fun k l => v l * P l k * u k)
    _ = v ⬝ᵥ P *ᵥ u := (dotProduct_mulVec_eq_double_sum' v u P).symm

end Ising2D.NecSuf
