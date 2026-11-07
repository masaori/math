/-
# 成分が `u_k + (ε_ℝu)_k` のベクトルは `ε_ℝ` を掛けても変わらない

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_claim_epsilon_real_fixes_sum_of_vector_and_its_image`（ラベル **`epsilon_real_fixes_sum_of_vector_and_its_image`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 各成分 `k` の 10 行の鎖 `(ε_ℝv)_k = Σ_l(ε_ℝ)_klv_l = ⋯ = v_k` | `epsilon_real_fixes_sum_of_vector_and_its_image` の `calc` の 10 段 |
| 結び（`k` は任意なので `ε_ℝv = v`） | 同じ定理の `funext k` |

- 人手の `M_col` は Lean の `n + 1`、`ε_ℝ` は `epsilonReal n`（`ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors.lean`）、
  行列とベクトルの積（`def_real_matrix_vector_product`）は `*ᵥ` で、その成分 `(Px)_i = Σ_jP_ijx_j` は定義から `rfl` で開く。
- 人手は `ℝ^d` の元どうしの和を定めず、`v` を成分の等式 `v_k = u_k + (ε_ℝu)_k` で与える。Lean も同じく仮定 `hv` に置く
  （引く側で `v := u + ε_ℝ *ᵥ u` なら `hv := fun _ => rfl`）。
- 人手の和の添字 `{1, …, d}` は Lean では有限型 `Conf (n + 1)` で、`finite_sum_of_real_sums` は `_fintype` 版を引く。

必要十分版は置かない。鎖は、引いた主張（`finite_sum_of_real_sums`・`real_matrix_vector_product_is_associative`・
`epsilon_real_square_is_identity`・`real_identity_matrix_is_left_unit_of_real_matrix_vector_product`）と ℝ の分配則・加法の交換則を
成分ごとに 1 回ずつ当てることに尽き、それらの外に抽象的な内容を持たない（`epsilon_real_square_is_identity` と同じ）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealIsSymmetricAndSquareIsIdentity
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealMatrixVectorProductAssociativityAndIdentity
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers

namespace Ising2D

open Matrix

/-- **人手 `epsilon_real_fixes_sum_of_vector_and_its_image`**: すべての `k` で `v_k = u_k + (ε_ℝu)_k` なら `ε_ℝv = v`
（人手の `M_col` は `n + 1`。各成分の 10 行の鎖と 1 対 1）。 -/
theorem epsilon_real_fixes_sum_of_vector_and_its_image (n : ℕ) (u v : Conf (n + 1) → ℝ)
    (hv : ∀ k, v k = u k + (epsilonReal n *ᵥ u) k) :
    epsilonReal n *ᵥ v = v := by
  funext k
  calc (epsilonReal n *ᵥ v) k
      = ∑ l, epsilonReal n k l * v l := rfl                                   -- `def_real_matrix_vector_product`（`P → ε_ℝ`、`x → v`）
    _ = ∑ l, epsilonReal n k l * (u l + (epsilonReal n *ᵥ u) l) :=
        Finset.sum_congr rfl fun l _ => by rw [hv l]                          -- `v` の定義（`k → l`）を `d` 個の項へ
    _ = ∑ l, (epsilonReal n k l * u l + epsilonReal n k l * (epsilonReal n *ᵥ u) l) :=
        Finset.sum_congr rfl fun l _ => mul_add _ _ _                         -- ℝ の分配則 `a(b + c) = ab + ac` を `d` 個の項へ
    _ = (∑ l, epsilonReal n k l * u l) + ∑ l, epsilonReal n k l * (epsilonReal n *ᵥ u) l :=
        finite_sum_of_real_sums_fintype
          (fun l => epsilonReal n k l * u l)
          (fun l => epsilonReal n k l * (epsilonReal n *ᵥ u) l)               -- `finite_sum_of_real_sums`（`j → l`）
    _ = (epsilonReal n *ᵥ u) k + (epsilonReal n *ᵥ (epsilonReal n *ᵥ u)) k := rfl
                                                                              -- `def_real_matrix_vector_product` を右辺から左辺へ 2 か所
    _ = (epsilonReal n *ᵥ u) k + ((epsilonReal n * epsilonReal n) *ᵥ u) k := by
        rw [real_matrix_vector_product_is_associative]                        -- `real_matrix_vector_product_is_associative`（`P, Q → ε_ℝ`）を右辺から左辺へ
    _ = (epsilonReal n *ᵥ u) k + ((1 : Matrix (Conf (n + 1)) (Conf (n + 1)) ℝ) *ᵥ u) k := by
        rw [epsilon_real_square_is_identity]                                  -- `epsilon_real_square_is_identity`
    _ = (epsilonReal n *ᵥ u) k + u k := by
        rw [real_identity_matrix_is_left_unit_of_real_matrix_vector_product]  -- `real_identity_matrix_is_left_unit_of_real_matrix_vector_product`（`x → u`）
    _ = u k + (epsilonReal n *ᵥ u) k := add_comm _ _                          -- ℝ の加法の交換則
    _ = v k := (hv k).symm                                                    -- `v` の定義を右辺から左辺へ

end Ising2D
