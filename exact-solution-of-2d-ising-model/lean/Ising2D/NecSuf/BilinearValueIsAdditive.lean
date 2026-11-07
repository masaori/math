/-
# 必要十分版: 双線型値 `x^⊤Py` は、右のベクトル・左のベクトルの和について和に分かれる

人手証明のラベル: **`real_bilinear_value_is_additive_in_right_vector`**・**`real_bilinear_value_is_additive_in_left_vector`**
（正本 `structured-latex/content/011_max_eigenvalue.ts`）。
具体版は `Ising2D.real_bilinear_value_is_additive_in_right_vector`・`Ising2D.real_bilinear_value_is_additive_in_left_vector`
（`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueIsAdditive.lean`）で、
導出は同じフォルダの `ClaimRealBilinearValueIsAdditiveFromNecSuf.lean` に置く。

## 手順（具体版の `calc` と同じ並び）

| 具体版の段 | 本ファイル |
| --- | --- |
| 1 段目 `def_real_bilinear_value` | `dotProduct_mulVec_eq_double_sum'`（`NecSuf/BilinearValueAtMostValueAtAbsoluteVector.lean`） |
| 2 段目 仮定 `w_l = y_l + z_l`（左は `w_k = y_k + z_k`）を各項へ | 仮定 `hw` |
| 分配則を各項へ（右は 1 回 `mul_add`、左は 2 回 `add_mul`） | `mul_add`・`add_mul` |
| `finite_sum_of_real_sums` を各 `k` へ、続けて外側の和へ | `finite_sum_add'`（`NecSuf/MatMulDistribSum.lean`） |
| 最後の段 `def_real_bilinear_value` を右辺から左辺へ 2 か所 | `dotProduct_mulVec_eq_double_sum'` |

## この主張に本質的に効いている構造

* 分配則。右のベクトルの主張は左分配則 `a(b + c) = ab + ac` だけ、左のベクトルの主張は右分配則 `(b + c)a = ba + ca` だけを
  主張の段で使う。和に分かれることそのものなので外せない。
* 加法の結合則・交換則（`finite_sum_add'`。有限和を二つの有限和に分ける段）。
* 乗法の結合則は、mathlib の `x ⬝ᵥ P *ᵥ y`（`Σ_k x_k (Σ_l P_kl y_l)`）を人手の `Σ_kΣ_l (x_kP_kl)y_l` へ開く最初と最後の段
  （ほかに `Finset.mul_sum` の左分配則と、添字の型が空のときの `a·0 = 0`）だけで使う。結合的でない係数では
  `(x_kP_kl)y_l` と `x_k(P_kl y_l)` が一致せず、人手の和と mathlib の値が別物になるので、具体版と同じ手順を保つ限り外せない
  （主張の文だけなら結合則なしでも成り立つ）。
* 右のベクトルの主張は右分配則と `0·a = 0` を手順では使わない。それでも外せないのは、主張の文の `P *ᵥ y` そのものが
  mathlib で `NonUnitalNonAssocSemiring`（左右の分配則と `0·a = a·0 = 0` を含む）を要求するからである。
* 乗法の可換性・単位元・加法の逆元・順序・ℝ であることは使わない。したがって係数は非単位的な半環 `R` に置く。
-/
import Ising2D.NecSuf.BilinearValueAtMostValueAtAbsoluteVector
import Ising2D.NecSuf.MatMulDistribSum

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*} [NonUnitalSemiring R]
variable {n : Type*} [Fintype n]

/-- **人手 `real_bilinear_value_is_additive_in_right_vector` の必要十分版**（具体版の 6 段と同じ並び）。 -/
theorem bilinear_value_is_additive_in_right_vector' (P : Matrix n n R) (x y z w : n → R)
    (hw : ∀ l, w l = y l + z l) :
    x ⬝ᵥ P *ᵥ w = x ⬝ᵥ P *ᵥ y + x ⬝ᵥ P *ᵥ z :=
  calc x ⬝ᵥ P *ᵥ w
      = ∑ k, ∑ l, x k * P k l * w l := dotProduct_mulVec_eq_double_sum' x w P
    _ = ∑ k, ∑ l, x k * P k l * (y l + z l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by rw [hw l]
    _ = ∑ k, ∑ l, (x k * P k l * y l + x k * P k l * z l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_add (x k * P k l) (y l) (z l)
    _ = ∑ k, ((∑ l, x k * P k l * y l) + ∑ l, x k * P k l * z l) :=
        Finset.sum_congr rfl fun k _ =>
          finite_sum_add' (fun l => x k * P k l * y l) (fun l => x k * P k l * z l)
    _ = (∑ k, ∑ l, x k * P k l * y l) + ∑ k, ∑ l, x k * P k l * z l :=
        finite_sum_add' (fun k => ∑ l, x k * P k l * y l) (fun k => ∑ l, x k * P k l * z l)
    _ = x ⬝ᵥ P *ᵥ y + x ⬝ᵥ P *ᵥ z := by
        rw [dotProduct_mulVec_eq_double_sum' x y P, dotProduct_mulVec_eq_double_sum' x z P]

/-- **人手 `real_bilinear_value_is_additive_in_left_vector` の必要十分版**（具体版の 7 段と同じ並び）。 -/
theorem bilinear_value_is_additive_in_left_vector' (P : Matrix n n R) (x y z w : n → R)
    (hw : ∀ k, w k = y k + z k) :
    w ⬝ᵥ P *ᵥ x = y ⬝ᵥ P *ᵥ x + z ⬝ᵥ P *ᵥ x :=
  calc w ⬝ᵥ P *ᵥ x
      = ∑ k, ∑ l, w k * P k l * x l := dotProduct_mulVec_eq_double_sum' w x P
    _ = ∑ k, ∑ l, (y k + z k) * P k l * x l :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by rw [hw k]
    _ = ∑ k, ∑ l, (y k * P k l + z k * P k l) * x l :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [add_mul (y k) (z k) (P k l)]
    _ = ∑ k, ∑ l, (y k * P k l * x l + z k * P k l * x l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          add_mul (y k * P k l) (z k * P k l) (x l)
    _ = ∑ k, ((∑ l, y k * P k l * x l) + ∑ l, z k * P k l * x l) :=
        Finset.sum_congr rfl fun k _ =>
          finite_sum_add' (fun l => y k * P k l * x l) (fun l => z k * P k l * x l)
    _ = (∑ k, ∑ l, y k * P k l * x l) + ∑ k, ∑ l, z k * P k l * x l :=
        finite_sum_add' (fun k => ∑ l, y k * P k l * x l) (fun k => ∑ l, z k * P k l * x l)
    _ = y ⬝ᵥ P *ᵥ x + z ⬝ᵥ P *ᵥ x := by
        rw [dotProduct_mulVec_eq_double_sum' y x P, dotProduct_mulVec_eq_double_sum' z x P]

end Ising2D.NecSuf
