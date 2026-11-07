/-
# 実数の双線型値 `u^⊤Pv` を `u` と `Pv` の成分の積の和に開くことと、対称な実数の行列を積の和の左の因子から右の因子へ移すこと

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_claim_real_bilinear_value_is_sum_with_real_matrix_vector_product`
  （ラベル **`real_bilinear_value_is_sum_with_real_matrix_vector_product`**）
* `maxeig_claim_real_symmetric_matrix_moves_between_factors_of_sum_of_products`
  （ラベル **`real_symmetric_matrix_moves_between_factors_of_sum_of_products`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `real_bilinear_value_is_sum_with_real_matrix_vector_product` の 4 行の鎖 | 1 行目は主張の左辺の書き方、2〜4 行目は `real_bilinear_value_is_sum_with_real_matrix_vector_product` の `calc` の 3 段 |
| `real_symmetric_matrix_moves_between_factors_of_sum_of_products` の 10 行の鎖 | `real_symmetric_matrix_moves_between_factors_of_sum_of_products` の `calc` の 10 段 |

- 人手の `x^⊤Py`（`def_real_bilinear_value`）は Lean の `x ⬝ᵥ P *ᵥ y` で、`dotProduct_mulVec_eq_real_bilinear_value`
  （`RealMatrixBilinearFormAndNorm.lean`）が人手の和の形へ開く。
- 人手の `Px`（`def_real_matrix_vector_product` の `(Px)_i = Σ_j P_ij x_j`）は Lean の `P *ᵥ x` で、成分は人手の式と `rfl` である
  （`ClaimRealMatrixVectorProductAssociativityAndIdentity.lean` と同じ）。
- 人手の対称（`def_real_symmetric_matrix` の `P_kl = P_lk`）は Lean の `Matrix.IsSymm` で、各項へ当てる段は `Matrix.IsSymm.apply` である。
- `finite_sum_of_real_scalar_multiples`・`finite_double_sum_of_real_numbers_interchange` は有限型の添字の版
  `finite_sum_of_real_scalar_multiples_fintype`・`finite_double_sum_of_real_numbers_interchange_fintype` を引く。
  乗法の結合則・可換則は `mul_assoc`・`mul_comm` である。
- 人手の最後の行の「和の添字を書き換える」は束縛変数の名前の付け替えで、Lean では段にならない。
- 一つ目の主張の左辺は、mathlib の `u ⬝ᵥ P *ᵥ v` ではなく人手 `def_real_bilinear_value` の和 `Σ_kΣ_l (u_kP_kl)v_l` で書く。
  mathlib の `u ⬝ᵥ P *ᵥ v` は定義から `∑ k, u k * (P *ᵥ v) k` と `rfl` で一致するので、`⬝ᵥ` で書くと主張が中身を持たず、
  人手の 2・3 行目（結合則と `finite_sum_of_real_scalar_multiples`）が Lean で確かめられないからである。人手の 1 行目
  （`def_real_bilinear_value`）は、この左辺の書き方に当たる。引く側で `⬝ᵥ` の値から始めるときは、
  `dotProduct_mulVec_eq_real_bilinear_value` で和へ開いてから本定理を当てる（`⬝ᵥ` の値を `Σ_k u_k(Pv)_k` へ移すだけなら `rfl` で足りる）。

必要十分版は `Ising2D.NecSuf.bilinear_value_is_sum_with_matrix_vector_product'`・
`Ising2D.NecSuf.symmetric_matrix_moves_between_factors_of_sum_of_products'`
（`NecSuf/BilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean`）で、本ファイルの `calc` と同じ並びで示す。
具体版がその `R → ℝ` の特殊化として得られることは `ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactorsFromNecSuf.lean` に置く。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Mathlib.LinearAlgebra.Matrix.Symmetric

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

/-- **人手 `real_bilinear_value_is_sum_with_real_matrix_vector_product`**: `u^⊤Pv = Σ_k u_k(Pv)_k`
（人手の 4 行の鎖のうち 2〜4 行目と 1 対 1。左辺は人手の 1 行目の右辺、すなわち `def_real_bilinear_value` の和で書く）。 -/
theorem real_bilinear_value_is_sum_with_real_matrix_vector_product (P : Matrix n n ℝ) (u v : n → ℝ) :
    ∑ k, ∑ l, u k * P k l * v l = ∑ k, u k * (P *ᵥ v) k :=
  calc ∑ k, ∑ l, u k * P k l * v l
      = ∑ k, ∑ l, u k * (P k l * v l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_assoc (u k) (P k l) (v l)                              -- ℝ の乗法の結合則を各項へ
    _ = ∑ k, u k * ∑ l, P k l * v l :=
        Finset.sum_congr rfl fun k _ =>
          finite_sum_of_real_scalar_multiples_fintype (u k) (fun l => P k l * v l)
                                                                     -- `finite_sum_of_real_scalar_multiples`（`c → u_k`）を各 `k` へ
    _ = ∑ k, u k * (P *ᵥ v) k := rfl                                -- `def_real_matrix_vector_product`（`x → v`）を右辺から左辺へ

/-- **人手 `real_symmetric_matrix_moves_between_factors_of_sum_of_products`**: 対称な `Q` について
`Σ_k (Qu)_k v_k = Σ_k u_k (Qv)_k`（人手の 10 行の鎖と 1 対 1）。 -/
theorem real_symmetric_matrix_moves_between_factors_of_sum_of_products (Q : Matrix n n ℝ) (hQ : Q.IsSymm)
    (u v : n → ℝ) :
    ∑ k, (Q *ᵥ u) k * v k = ∑ k, u k * (Q *ᵥ v) k :=
  calc ∑ k, (Q *ᵥ u) k * v k
      = ∑ k, (∑ l, Q k l * u l) * v k := rfl                        -- `def_real_matrix_vector_product`（`P → Q`、`x → u`）を各 `k` へ
    _ = ∑ k, v k * ∑ l, Q k l * u l :=
        Finset.sum_congr rfl fun k _ =>
          mul_comm (∑ l, Q k l * u l) (v k)                          -- ℝ の乗法の可換則を各 `k` へ
    _ = ∑ k, ∑ l, v k * (Q k l * u l) :=
        Finset.sum_congr rfl fun k _ =>
          (finite_sum_of_real_scalar_multiples_fintype (v k) (fun l => Q k l * u l)).symm
                                                                     -- `finite_sum_of_real_scalar_multiples`（`c → v_k`）を右辺から左辺へ、各 `k` へ
    _ = ∑ k, ∑ l, v k * (Q l k * u l) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [hQ.apply l k]                                          -- `def_real_symmetric_matrix`（`Q_kl = Q_lk`）を各項へ
    _ = ∑ k, ∑ l, Q l k * u l * v k :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_comm (v k) (Q l k * u l)                               -- ℝ の乗法の可換則を各項へ
    _ = ∑ k, ∑ l, u l * Q l k * v k :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_comm (Q l k) (u l)]                                -- ℝ の乗法の可換則 `Q_lku_l = u_lQ_lk` を各項へ
    _ = ∑ k, ∑ l, u l * (Q l k * v k) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_assoc (u l) (Q l k) (v k)                              -- ℝ の乗法の結合則を各項へ
    _ = ∑ l, ∑ k, u l * (Q l k * v k) :=
        finite_double_sum_of_real_numbers_interchange_fintype
          (fun k l => u l * (Q l k * v k))                           -- `finite_double_sum_of_real_numbers_interchange`（`c_{k,l} → u_l(Q_lkv_k)`）
    _ = ∑ l, u l * ∑ k, Q l k * v k :=
        Finset.sum_congr rfl fun l _ =>
          finite_sum_of_real_scalar_multiples_fintype (u l) (fun k => Q l k * v k)
                                                                     -- `finite_sum_of_real_scalar_multiples`（`c → u_l`）を各 `l` へ
    _ = ∑ k, u k * (Q *ᵥ v) k := rfl                                -- `def_real_matrix_vector_product`（`P → Q`、`x → v`）を右辺から左辺へ

end Ising2D
