/-
# 成分が非負の `u` について、成分が `u_k + (ε_ℝu)_k` のベクトル `v` は `v^⊤W_ℝv ≥ 2(u^⊤W_ℝu)` を満たす

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_claim_W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`
  （ラベル **`W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: `ũ := ε_ℝu`、`A := u^⊤W_ℝu` | `set ut`（`A` は Lean では略記を置かず式のまま） |
| 一つ目の準備: `u^⊤W_ℝũ ≥ 0`・`ũ^⊤W_ℝu ≥ 0`（`epsilon_real_preserves_nonnegative_vectors`・`W_real_has_positive_entries`・`real_bilinear_value_with_nonnegative_entries_is_nonnegative` を 2 通りに） | `hcross1`・`hcross2` |
| 一つ目の準備: `A + u^⊤W_ℝũ ≥ A + 0`・`ũ^⊤W_ℝu + A ≥ 0 + A`（順序と加法の両立を 1 回ずつ） | `hpart1`・`hpart2` |
| 二つ目の準備: `ε_ℝ(W_ℝũ) = W_ℝu` の 7 行の鎖 | `hvec` の `calc` の 7 段 |
| 三つ目の準備: `ũ^⊤W_ℝũ = A` の 5 行の鎖 | `hww` の `calc` の 5 段 |
| 主張の 11 行の鎖 | 主定理の `calc` の 11 段 |

- 人手の `M_col` は Lean の `n + 1`、`ε_ℝ` は `epsilonReal n`、`W_ℝ` は `realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2) _`、
  `ℝ^d` の元は `Conf (n + 1) → ℝ` である。人手の `x^⊤Py`（`def_real_bilinear_value`）は Lean の `x ⬝ᵥ P *ᵥ y` で、
  二重和との行き来は `dotProduct_mulVec_eq_real_bilinear_value` である。
- 人手の `real_bilinear_value_is_sum_with_real_matrix_vector_product` の `u^⊤Pv = Σ_k u_k(Pv)_k` は、Lean では
  `dotProduct_mulVec_eq_real_bilinear_value`（左辺を二重和へ開く）と `real_bilinear_value_is_sum_with_real_matrix_vector_product`
  （二重和 `= Σ_k u_k(Pv)_k`）の合成で、1 行に当たる段は `rw` の 2 補題になる。
- 人手は `ℝ^d` の元どうしの和を定めず、`v` を成分の等式 `v_k = u_k + ũ_k` で与える。Lean も同じく仮定 `hv` に置く
  （`epsilon_real_fixes_sum_of_vector_and_its_image` と同じ形）。
- 人手は結合定数を `K_1, K_2 ∈ ℝ_{>0}` とする。Lean の `W_ℝ` が要るのは `K_2 > 0` だけである（`physicalSymTransferC_hasRealEntries` の仮定）。

必要十分版は置かない。`W_ℝ` について効いているのは、成分が非負であることと `ε_ℝ` と可換であることだけで、`W_ℝ` の対称性は使わない
（交差項 `u^⊤W_ℝũ`・`ũ^⊤W_ℝu` を入れ替えずに、どちらも非負性で落とす）。`ε_ℝ` について効いているのは、対称性・`ε_ℝε_ℝ = I`・
非負のベクトルを保つことである。証明はこれらと双線型値の加法性・非負性、行列とベクトルの積の結合性を順に当てることに尽き、
それらの必要十分版の外に新しい抽象的な内容を持たない（同じ章の `sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`・
`norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four` と同じ扱い）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealCommutesWithWRealAndWRealHasPositiveEntries
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealPreservesNonnegativeVectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealMatrixVectorProductAssociativityAndIdentity
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueIsAdditive
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultiple
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors

namespace Ising2D

open Matrix

/-- **人手 `W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`**:
すべての `k` で `u_k ≥ 0` かつ `v_k = u_k + (ε_ℝu)_k` なら `v^⊤W_ℝv ≥ 2(u^⊤W_ℝu)`
（人手の `M_col` は `n + 1`。準備の 3 つと主張の 11 行の鎖と 1 対 1）。 -/
theorem W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice
    (n : ℕ) (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2) (u v : Conf (n + 1) → ℝ) (hu : ∀ k, 0 ≤ u k)
    (hv : ∀ k, v k = u k + (epsilonReal n *ᵥ u) k) :
    v ⬝ᵥ realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
        (physicalSymTransferC_hasRealEntries K1 hK2) *ᵥ v
      ≥ 2 * (u ⬝ᵥ realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
        (physicalSymTransferC_hasRealEntries K1 hK2) *ᵥ u) := by
  set W := realMatrixOfRealEntries (physicalSymTransferC (n + 1) K1 K2)
    (physicalSymTransferC_hasRealEntries K1 hK2) with hW
  set ut := epsilonReal n *ᵥ u with hut                                      -- 準備: `ũ := ε_ℝu`
  -- 一つ目の準備: `u^⊤W_ℝũ ≥ 0`・`ũ^⊤W_ℝu ≥ 0`
  have hW0 : ∀ k l, 0 ≤ W k l := fun k l => (W_real_has_positive_entries K1 hK2 k l).le
                                                                              -- `W_real_has_positive_entries`（`(W_ℝ)_kl > 0` より `≥ 0`）
  have hut0 : ∀ l, 0 ≤ ut l := epsilon_real_preserves_nonnegative_vectors n u hu
                                                                              -- `epsilon_real_preserves_nonnegative_vectors`（`ũ_l ≥ 0`）
  have hcross1 : u ⬝ᵥ W *ᵥ ut ≥ 0 :=
    real_bilinear_value_with_nonnegative_entries_is_nonnegative W hW0 u ut hu hut0
                                                                              -- `real_bilinear_value_with_nonnegative_entries_is_nonnegative`（`x → u, y → ũ`）
  have hcross2 : ut ⬝ᵥ W *ᵥ u ≥ 0 :=
    real_bilinear_value_with_nonnegative_entries_is_nonnegative W hW0 ut u hut0 hu
                                                                              -- `real_bilinear_value_with_nonnegative_entries_is_nonnegative`（`x → ũ, y → u`）
  have hpart1 : u ⬝ᵥ W *ᵥ u + u ⬝ᵥ W *ᵥ ut ≥ u ⬝ᵥ W *ᵥ u + 0 :=
    add_le_add_right hcross1 _                                                -- ℝ の順序と加法の両立 `x ≥ y ⇒ c + x ≥ c + y`（`c → A`）
  have hpart2 : ut ⬝ᵥ W *ᵥ u + u ⬝ᵥ W *ᵥ u ≥ 0 + u ⬝ᵥ W *ᵥ u :=
    add_le_add_left hcross2 _                                                 -- ℝ の順序と加法の両立 `x ≥ y ⇒ x + c ≥ y + c`（`c → A`）
  -- 二つ目の準備: `ε_ℝ(W_ℝũ) = W_ℝu`（7 行の鎖）
  have hvec : epsilonReal n *ᵥ (W *ᵥ ut) = W *ᵥ u :=
    calc epsilonReal n *ᵥ (W *ᵥ ut)
        = epsilonReal n *ᵥ (W *ᵥ (epsilonReal n *ᵥ u)) := rfl                 -- `ũ` の定義
      _ = (epsilonReal n * W) *ᵥ (epsilonReal n *ᵥ u) :=
          (real_matrix_vector_product_is_associative _ _ _).symm              -- `real_matrix_vector_product_is_associative`（`P → ε_ℝ, Q → W_ℝ, x → ε_ℝu`）を右辺から左辺へ
      _ = (W * epsilonReal n) *ᵥ (epsilonReal n *ᵥ u) := by
          rw [epsilon_real_commutes_with_W_real n K1 hK2]                     -- `epsilon_real_commutes_with_W_real`
      _ = W *ᵥ (epsilonReal n *ᵥ (epsilonReal n *ᵥ u)) :=
          real_matrix_vector_product_is_associative _ _ _                     -- `real_matrix_vector_product_is_associative`（`P → W_ℝ, Q → ε_ℝ, x → ε_ℝu`）
      _ = W *ᵥ ((epsilonReal n * epsilonReal n) *ᵥ u) := by
          rw [real_matrix_vector_product_is_associative]                      -- `real_matrix_vector_product_is_associative`（`P, Q → ε_ℝ, x → u`）を右辺から左辺へ
      _ = W *ᵥ ((1 : Matrix (Conf (n + 1)) (Conf (n + 1)) ℝ) *ᵥ u) := by
          rw [epsilon_real_square_is_identity]                                -- `epsilon_real_square_is_identity`
      _ = W *ᵥ u := by
          rw [real_identity_matrix_is_left_unit_of_real_matrix_vector_product] -- `real_identity_matrix_is_left_unit_of_real_matrix_vector_product`（`x → u`）
  -- 三つ目の準備: `ũ^⊤W_ℝũ = A`（5 行の鎖）
  have hww : ut ⬝ᵥ W *ᵥ ut = u ⬝ᵥ W *ᵥ u :=
    calc ut ⬝ᵥ W *ᵥ ut
        = ∑ k, ut k * (W *ᵥ ut) k := by
          rw [dotProduct_mulVec_eq_real_bilinear_value,
            real_bilinear_value_is_sum_with_real_matrix_vector_product]       -- `real_bilinear_value_is_sum_with_real_matrix_vector_product`（`P → W_ℝ, u → ũ, v → ũ`）
      _ = ∑ k, (epsilonReal n *ᵥ u) k * (W *ᵥ ut) k := rfl                    -- `ũ` の定義
      _ = ∑ k, u k * (epsilonReal n *ᵥ (W *ᵥ ut)) k :=
          real_symmetric_matrix_moves_between_factors_of_sum_of_products
            (epsilonReal n) (epsilon_real_is_symmetric n) u (W *ᵥ ut)         -- `real_symmetric_matrix_moves_between_factors_of_sum_of_products`（`Q → ε_ℝ, u → u, v → W_ℝũ`）
      _ = ∑ k, u k * (W *ᵥ u) k := by rw [hvec]                               -- 二つ目の準備の `ε_ℝ(W_ℝũ) = W_ℝu` を各 `k` へ
      _ = u ⬝ᵥ W *ᵥ u := by
          rw [dotProduct_mulVec_eq_real_bilinear_value,
            real_bilinear_value_is_sum_with_real_matrix_vector_product]       -- `real_bilinear_value_is_sum_with_real_matrix_vector_product`（`u, v → u`）を右辺から左辺へ
  -- 主張の 11 行の鎖
  calc v ⬝ᵥ W *ᵥ v
      = u ⬝ᵥ W *ᵥ v + ut ⬝ᵥ W *ᵥ v :=
        real_bilinear_value_is_additive_in_left_vector W v u ut v hv          -- `real_bilinear_value_is_additive_in_left_vector`（`x → v, y → u, z → ũ, w → v`）
    _ = (u ⬝ᵥ W *ᵥ u + u ⬝ᵥ W *ᵥ ut) + ut ⬝ᵥ W *ᵥ v := by
        rw [real_bilinear_value_is_additive_in_right_vector W u u ut v hv]    -- `real_bilinear_value_is_additive_in_right_vector`（`x → u, y → u, z → ũ, w → v`）
    _ = (u ⬝ᵥ W *ᵥ u + u ⬝ᵥ W *ᵥ ut) + (ut ⬝ᵥ W *ᵥ u + ut ⬝ᵥ W *ᵥ ut) := by
        rw [real_bilinear_value_is_additive_in_right_vector W ut u ut v hv]   -- `real_bilinear_value_is_additive_in_right_vector`（`x → ũ, y → u, z → ũ, w → v`）
    _ = (u ⬝ᵥ W *ᵥ u + u ⬝ᵥ W *ᵥ ut) + (ut ⬝ᵥ W *ᵥ u + u ⬝ᵥ W *ᵥ u) := by
        rw [hww]                                                              -- 三つ目の準備の `ũ^⊤W_ℝũ = A`
    _ ≥ (u ⬝ᵥ W *ᵥ u + 0) + (ut ⬝ᵥ W *ᵥ u + u ⬝ᵥ W *ᵥ u) :=
        add_le_add_left hpart1 _                                              -- 一つ目の準備と `x ≥ y ⇒ x + c ≥ y + c`
    _ ≥ (u ⬝ᵥ W *ᵥ u + 0) + (0 + u ⬝ᵥ W *ᵥ u) :=
        add_le_add_right hpart2 _                                             -- 一つ目の準備と `x ≥ y ⇒ c + x ≥ c + y`
    _ = u ⬝ᵥ W *ᵥ u + (0 + u ⬝ᵥ W *ᵥ u) := by rw [add_zero]                 -- `0` は ℝ の加法の右単位元 `A + 0 = A`
    _ = u ⬝ᵥ W *ᵥ u + u ⬝ᵥ W *ᵥ u := by rw [zero_add]                       -- `0` は ℝ の加法の左単位元 `0 + A = A`
    _ = 1 * (u ⬝ᵥ W *ᵥ u) + 1 * (u ⬝ᵥ W *ᵥ u) := by rw [one_mul]            -- `1` は ℝ の乗法の単位元（2 か所）
    _ = (1 + 1) * (u ⬝ᵥ W *ᵥ u) := (add_mul 1 1 _).symm                       -- ℝ の分配則 `(a + b)c = ac + bc` を右辺から左辺へ
    _ = 2 * (u ⬝ᵥ W *ᵥ u) := by rw [one_add_one_eq_two]                      -- ℝ の `1 + 1 = 2`

end Ising2D
