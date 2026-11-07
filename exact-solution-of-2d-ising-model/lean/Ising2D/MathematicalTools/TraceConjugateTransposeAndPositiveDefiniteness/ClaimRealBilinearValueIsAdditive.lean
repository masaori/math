/-
# 実数の双線型値 `x^⊤Py` は、右のベクトル・左のベクトルの和について和に分かれる

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_claim_real_bilinear_value_is_additive_in_right_vector`（ラベル **`real_bilinear_value_is_additive_in_right_vector`**）
* `maxeig_claim_real_bilinear_value_is_additive_in_left_vector`（ラベル **`real_bilinear_value_is_additive_in_left_vector`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `real_bilinear_value_is_additive_in_right_vector` の 6 行の鎖 | `real_bilinear_value_is_additive_in_right_vector` の `calc` の 6 段 |
| `real_bilinear_value_is_additive_in_left_vector` の 7 行の鎖 | `real_bilinear_value_is_additive_in_left_vector` の `calc` の 7 段 |

- 人手の `x^⊤Py`（`def_real_bilinear_value` の `Σ_kΣ_l (x_kP_kl)y_l`）は Lean の `x ⬝ᵥ P *ᵥ y` で、
  `dotProduct_mulVec_eq_real_bilinear_value`（`RealMatrixBilinearFormAndNorm.lean`）が人手の和の形へ開く。
- 人手は `ℝ^n` の元どうしの和を定めず、`w` を成分の等式 `w_l = y_l + z_l` で与える。Lean も同じく仮定 `hw` に置く
  （引く側で `w := y + z` なら `hw := fun _ => rfl`）。
- 人手の和の添字 `{1, …, n}` は Lean では有限型 `n` で、`finite_sum_of_real_sums` は `_fintype` 版を引く。

必要十分版は `Ising2D.NecSuf.bilinear_value_is_additive_in_right_vector'`・`bilinear_value_is_additive_in_left_vector'`
（`NecSuf/BilinearValueIsAdditive.lean`）である。係数を非単位的な半環へ上げ、本ファイルの `calc` と同じ並びで示す。
具体版がその `R → ℝ` の特殊化として得られることは `ClaimRealBilinearValueIsAdditiveFromNecSuf.lean` に置く。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

/-- **人手 `real_bilinear_value_is_additive_in_right_vector`**: すべての `l` で `w_l = y_l + z_l` なら
`x^⊤Pw = x^⊤Py + x^⊤Pz`（人手の 6 行の鎖と 1 対 1）。 -/
theorem real_bilinear_value_is_additive_in_right_vector (P : Matrix n n ℝ) (x y z w : n → ℝ)
    (hw : ∀ l, w l = y l + z l) :
    x ⬝ᵥ P *ᵥ w = x ⬝ᵥ P *ᵥ y + x ⬝ᵥ P *ᵥ z :=
  calc x ⬝ᵥ P *ᵥ w
      = ∑ k, ∑ l, x k * P k l * w l :=
        dotProduct_mulVec_eq_real_bilinear_value x w P               -- `def_real_bilinear_value`（`y → w`）
    _ = ∑ k, ∑ l, x k * P k l * (y l + z l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [hw l]                                                  -- 仮定 `w_l = y_l + z_l` を各項へ
    _ = ∑ k, ∑ l, (x k * P k l * y l + x k * P k l * z l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_add (x k * P k l) (y l) (z l)                          -- ℝ の分配則 `a(b + c) = ab + ac` を各項へ
    _ = ∑ k, ((∑ l, x k * P k l * y l) + ∑ l, x k * P k l * z l) :=
        Finset.sum_congr rfl fun k _ =>
          finite_sum_of_real_sums_fintype
            (fun l => x k * P k l * y l) (fun l => x k * P k l * z l)  -- `finite_sum_of_real_sums` を各 `k` へ
    _ = (∑ k, ∑ l, x k * P k l * y l) + ∑ k, ∑ l, x k * P k l * z l :=
        finite_sum_of_real_sums_fintype
          (fun k => ∑ l, x k * P k l * y l) (fun k => ∑ l, x k * P k l * z l)  -- `finite_sum_of_real_sums`
    _ = x ⬝ᵥ P *ᵥ y + x ⬝ᵥ P *ᵥ z := by
        rw [dotProduct_mulVec_eq_real_bilinear_value x y P,
          dotProduct_mulVec_eq_real_bilinear_value x z P]            -- `def_real_bilinear_value` を右辺から左辺へ 2 か所

/-- **人手 `real_bilinear_value_is_additive_in_left_vector`**: すべての `k` で `w_k = y_k + z_k` なら
`w^⊤Px = y^⊤Px + z^⊤Px`（人手の 7 行の鎖と 1 対 1）。 -/
theorem real_bilinear_value_is_additive_in_left_vector (P : Matrix n n ℝ) (x y z w : n → ℝ)
    (hw : ∀ k, w k = y k + z k) :
    w ⬝ᵥ P *ᵥ x = y ⬝ᵥ P *ᵥ x + z ⬝ᵥ P *ᵥ x :=
  calc w ⬝ᵥ P *ᵥ x
      = ∑ k, ∑ l, w k * P k l * x l :=
        dotProduct_mulVec_eq_real_bilinear_value w x P               -- `def_real_bilinear_value`（`x → w`、`y → x`）
    _ = ∑ k, ∑ l, (y k + z k) * P k l * x l :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [hw k]                                                  -- 仮定 `w_k = y_k + z_k` を各項へ
    _ = ∑ k, ∑ l, (y k * P k l + z k * P k l) * x l :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [add_mul (y k) (z k) (P k l)]                           -- ℝ の分配則 `(b + c)a = ba + ca` を各項へ
    _ = ∑ k, ∑ l, (y k * P k l * x l + z k * P k l * x l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          add_mul (y k * P k l) (z k * P k l) (x l)                  -- ℝ の分配則 `(b + c)a = ba + ca` を各項へ
    _ = ∑ k, ((∑ l, y k * P k l * x l) + ∑ l, z k * P k l * x l) :=
        Finset.sum_congr rfl fun k _ =>
          finite_sum_of_real_sums_fintype
            (fun l => y k * P k l * x l) (fun l => z k * P k l * x l)  -- `finite_sum_of_real_sums` を各 `k` へ
    _ = (∑ k, ∑ l, y k * P k l * x l) + ∑ k, ∑ l, z k * P k l * x l :=
        finite_sum_of_real_sums_fintype
          (fun k => ∑ l, y k * P k l * x l) (fun k => ∑ l, z k * P k l * x l)  -- `finite_sum_of_real_sums`
    _ = y ⬝ᵥ P *ᵥ x + z ⬝ᵥ P *ᵥ x := by
        rw [dotProduct_mulVec_eq_real_bilinear_value y x P,
          dotProduct_mulVec_eq_real_bilinear_value z x P]            -- `def_real_bilinear_value` を右辺から左辺へ 2 か所

end Ising2D
