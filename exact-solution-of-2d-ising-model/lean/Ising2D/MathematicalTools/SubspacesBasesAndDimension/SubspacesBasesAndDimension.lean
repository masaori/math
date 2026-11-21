/-
# 部分空間・線型結合・張る・線型独立・基底・次元・直和（具体版）

対応する人手証明: `structured-latex/content/002_linear_space_general.ts` の、`def_subspace` から
`linearly_independent_family_of_n_vectors_is_basis` までのブロック（定義 9 個と主張 20 個。主張
`nonzero_elements_of_images_of_check_Q_form_basis` は同じフォルダの `ClaimNonzeroElementsOfImagesOfCheckQFormBasis.lean`）。

記号の読み替え:
- 人手の `Mat(m,n,ℂ)` は Lean の `Matrix ι κ ℂ`（`ι, κ` は有限型）。本文の行列の添字は `Fin m` か
  `Conf M`（`lean/README.md` の「行列の添字」）なので、どちらにも使えるよう添字の型を一般の有限型にした。
  人手の行列単位の添字の組 `(i,j) ∈ {1,…,m}×{1,…,n}` は `ι × κ`、`mn` は `Fintype.card ι * Fintype.card κ`。
- 人手の数ベクトル `ℂ^m` は、人手の `mat_mult` の約束（`m` 行 1 列の行列）どおり `Matrix ι (Fin 1) ℂ` で持つ。
  既存のファイルの多くは `ι → ℂ` と `mulVec` で書くが、ここでは人手の定義が `Mat(m,n,ℂ)` の部分空間として
  `ℂ^m` を扱う（`def_subspace` の `n = 1`）ので、同じ型の上の同じ定義で済む列行列を採った。
- 人手の族 `(u_1,…,u_p)` は `u : Fin p → Matrix ι κ ℂ`（添字は `0, …, p-1`）、線型結合は `Fin p` の上の和。
  人手の `p = 0` の場合分け（`def_linear_combination`）は、Lean では空の和が `0` であることに含まれる。
- 人手の `δ^{q}_{j_0}`（`def_index_skipping_map`）は `j₀.succAbove`、人手の `u_{p+1} := x` は `Fin.snoc u x`、
  人手の二つの族をつないだ `v_t` は `Fin.append u w`。

必要十分版は `Ising2D/NecSuf/SubspacesBasesAndDimension.lean`、特殊化による導出は同じフォルダの
`SubspacesBasesAndDimensionFromNecSuf.lean`、`def_dimension` の次元と mathlib の `Module.finrank` の一致は
`DimensionAgreesWithFinrank.lean`。各宣言の段のコメントの根拠名は人手の行の根拠のラベルである。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.Module.BigOperators
import Mathlib.Data.Nat.Find
import Mathlib.Data.Complex.Basic
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWords

namespace Ising2D

open Finset

section Definitions

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- **`def_subspace`**: `O` を含み、和とスカラー倍で閉じた `Mat(m,n,ℂ)` の部分集合。 -/
structure IsSubspaceMat (U : Set (Matrix ι κ ℂ)) : Prop where
  zero_mem : (0 : Matrix ι κ ℂ) ∈ U
  add_mem : ∀ {A B : Matrix ι κ ℂ}, A ∈ U → B ∈ U → A + B ∈ U
  smul_mem : ∀ (a : ℂ) {A : Matrix ι κ ℂ}, A ∈ U → a • A ∈ U

/-- **`def_linear_combination`**: `Σ_{t=1}^{p} c_t u_t`（`p = 0` では `O`）。 -/
def matLinComb {p : ℕ} (c : Fin p → ℂ) (u : Fin p → Matrix ι κ ℂ) : Matrix ι κ ℂ := ∑ t, c t • u t

/-- `A` は族 `(u_1,…,u_p)` の線型結合である（`def_linear_combination` の最後の文）。 -/
def MatIsLinComb (A : Matrix ι κ ℂ) {p : ℕ} (u : Fin p → Matrix ι κ ℂ) : Prop :=
  ∃ c : Fin p → ℂ, A = matLinComb c u

/-- **`def_spanning_family`**。 -/
def MatSpans (U : Set (Matrix ι κ ℂ)) {p : ℕ} (u : Fin p → Matrix ι κ ℂ) : Prop :=
  (∀ t, u t ∈ U) ∧ ∀ A ∈ U, MatIsLinComb A u

/-- **`def_linearly_independent`**。 -/
def MatLinIndep {p : ℕ} (u : Fin p → Matrix ι κ ℂ) : Prop :=
  ∀ c : Fin p → ℂ, matLinComb c u = 0 → ∀ t, c t = 0

/-- **`def_basis`**。 -/
def MatIsBasis (U : Set (Matrix ι κ ℂ)) {p : ℕ} (u : Fin p → Matrix ι κ ℂ) : Prop :=
  MatSpans U u ∧ MatLinIndep u

/-- **`def_basis_indexed_by_finite_set`**: 全単射 `π : {1,…,#𝒜} → 𝒜` で並べた族が基底になるもの。 -/
def MatIsBasisIndexed (U : Set (Matrix ι κ ℂ)) {α : Type*} [Fintype α] (u : α → Matrix ι κ ℂ) : Prop :=
  ∃ π : Fin (Fintype.card α) ≃ α, MatIsBasis U (u ∘ π)

/-- **`def_direct_sum_of_two_subspaces`**: `V = U ⊕ W`。 -/
def IsDirectSumOfTwoMat (Vs U W : Set (Matrix ι κ ℂ)) : Prop :=
  U ⊆ Vs ∧ W ⊆ Vs ∧ (∀ v ∈ Vs, ∃ u ∈ U, ∃ w ∈ W, v = u + w) ∧ ∀ x, x ∈ U → x ∈ W → x = 0

end Definitions

/-- **`def_direct_sum_over_binary_words`**: `V = ⨁_{ε∈{0,1}^{r+1}} U_ε`（和は `def_sum_over_binary_words` の
`binaryWordMatrixSum`。人手の `r` は Lean の `r + 1`）。 -/
def IsDirectSumOverBinaryWordsMat {m n : ℕ} (r : ℕ) (Vs : Set (Matrix (Fin m) (Fin n) ℂ))
    (U : (Fin (r + 1) → Fin 2) → Set (Matrix (Fin m) (Fin n) ℂ)) : Prop :=
  (∀ ε, U ε ⊆ Vs) ∧
    (∀ v ∈ Vs, ∃ u : (Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ, (∀ ε, u ε ∈ U ε) ∧ v = binaryWordMatrixSum r u) ∧
    ∀ u : (Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ, (∀ ε, u ε ∈ U ε) → binaryWordMatrixSum r u = 0 → ∀ ε, u ε = 0

/-- **`finite_sum_of_complex_numbers_times_complex_number`**: `Σ_{j=1}^{m} (y_j w) = (Σ y_j) w`（人手の `m ≥ 1` は Lean の `m + 1`）。 -/
theorem finite_sum_of_complex_numbers_times_complex_number :
    ∀ (m : ℕ) (y : Fin (m + 1) → ℂ) (w : ℂ), ∑ j, y j * w = (∑ j, y j) * w
  | 0, y, w => by
    rw [Fin.sum_univ_one, Fin.sum_univ_one]                 -- `def_finite_sum_of_complex_numbers`（`m = 1`）
  | m + 1, y, w => by
    rw [Fin.sum_univ_castSucc, Fin.sum_univ_castSucc (f := y), -- `def_finite_sum_of_complex_numbers`
      finite_sum_of_complex_numbers_times_complex_number m (fun j => y j.castSucc) w,  -- 帰納法の仮定
      add_mul]                                                -- `complex_numbers_form_a_field` の分配律を右辺から左辺へ

/-- 長さ `0` の和も含めた `finite_sum_of_complex_numbers_times_complex_number`（消去の段の `p - 1` 個の和で使う）。 -/
theorem finite_sum_of_complex_numbers_times_complex_number' {m : ℕ} (y : Fin m → ℂ) (w : ℂ) :
    ∑ j, y j * w = (∑ j, y j) * w := by
  cases m with
  | zero => simp
  | succ m => exact finite_sum_of_complex_numbers_times_complex_number m y w

section MatrixSpace

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- **`linear_combination_splits_off_last_term`**。 -/
theorem linear_combination_splits_off_last_term {p : ℕ} (c : Fin (p + 1) → ℂ) (u : Fin (p + 1) → Matrix ι κ ℂ) :
    matLinComb c u = matLinComb (fun t => c t.castSucc) (fun t => u t.castSucc) + c (Fin.last p) • u (Fin.last p) :=
  Fin.sum_univ_castSucc _                                    -- `def_linear_combination`・`def_finite_sum_of_matrices`（`p = 0` では `zero_matrix_plus_matrix`）

/-- **`matrix_sum_is_associative`**（成分ごとの `ℂ` の和の結合律）。 -/
theorem matrix_sum_is_associative (A B C : Matrix ι κ ℂ) : (A + B) + C = A + (B + C) := by
  ext i k
  simp only [Matrix.add_apply]                               -- `def_matrix_sum`
  exact add_assoc _ _ _                                      -- `complex_numbers_form_a_field` の和の結合律

/-- **`linear_combination_splits_into_two_blocks`**（`s` についての帰納法）。 -/
theorem linear_combination_splits_into_two_blocks {r : ℕ} :
    ∀ (s : ℕ) (c : Fin (r + s) → ℂ) (v : Fin (r + s) → Matrix ι κ ℂ),
      matLinComb c v
        = matLinComb (fun t => c (Fin.castAdd s t)) (fun t => v (Fin.castAdd s t))
          + matLinComb (fun t => c (Fin.natAdd r t)) (fun t => v (Fin.natAdd r t))
  | 0, c, v => by
    simp only [matLinComb, Finset.univ_eq_empty, Finset.sum_empty, add_zero]  -- `matrix_plus_zero_matrix`・`def_linear_combination` の `p = 0`
    rfl
  | s + 1, c, v => by
    have h1 := linear_combination_splits_off_last_term (p := r + s) c v  -- `linear_combination_splits_off_last_term`（`p → r+s`）
    have h2 := linear_combination_splits_into_two_blocks s (fun t => c t.castSucc) (fun t => v t.castSucc) -- 帰納法の仮定
    have h3 := linear_combination_splits_off_last_term (fun t => c (Fin.natAdd r t)) (fun t => v (Fin.natAdd r t))
    refine h1.trans ?_
    rw [h2, matrix_sum_is_associative, h3]                    -- `matrix_sum_is_associative`・`linear_combination_splits_off_last_term` を右辺から左辺へ
    rfl

/-- **`linear_combination_of_subspace_elements_stays_in_subspace`**（`p` についての帰納法）。 -/
theorem linear_combination_of_subspace_elements_stays_in_subspace {U : Set (Matrix ι κ ℂ)} (hU : IsSubspaceMat U) :
    ∀ {p : ℕ} (c : Fin p → ℂ) (u : Fin p → Matrix ι κ ℂ), (∀ t, u t ∈ U) → matLinComb c u ∈ U
  | 0, c, u, _ => by
    simpa [matLinComb] using hU.zero_mem                     -- `def_linear_combination` の `p = 0`・`def_subspace` (i)
  | p + 1, c, u, hu => by
    rw [linear_combination_splits_off_last_term]              -- `linear_combination_splits_off_last_term`
    exact hU.add_mem                                          -- `def_subspace` (ii)
      (linear_combination_of_subspace_elements_stays_in_subspace hU _ _ fun t => hu _)  -- 帰納法の仮定
      (hU.smul_mem _ (hu _))                                  -- `def_subspace` (iii)

/-- **`linearly_independent_family_has_no_zero_element`**（`c_t := δ_{ts}`）。 -/
theorem linearly_independent_family_has_no_zero_element {p : ℕ} {u : Fin p → Matrix ι κ ℂ}
    (hu : MatLinIndep u) (s : Fin p) : u s ≠ 0 := by
  intro hs
  have hsum : matLinComb (fun t => if t = s then (1 : ℂ) else 0) u = 0 := by
    unfold matLinComb
    refine Finset.sum_eq_zero fun t _ => ?_                   -- `finite_sum_of_zero_matrices`
    show (if t = s then (1 : ℂ) else 0) • u t = 0
    by_cases hts : t = s
    · rw [if_pos hts, hts, hs, smul_zero]                    -- `u_s = O`・`scalar_multiple_of_zero_matrix`
    · rw [if_neg hts, zero_smul]                             -- `def_kronecker_delta`・`zero_scalar_multiple_is_zero_matrix`
  have := hu _ hsum s                                        -- 線型独立性
  rw [if_pos rfl] at this
  exact one_ne_zero this                                     -- `1_ℂ = (1,0) ≠ (0,0) = 0_ℂ`

end MatrixSpace

/-- **`homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution`**（`q` についての帰納法。
人手の `p` は Lean の `p' + 1`。`q = 0` の段の `δ` を置かない場合分けは、Lean では `Fin 0` の上の空の条件に含まれる）。 -/
theorem homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution :
    ∀ (q p : ℕ), q < p → ∀ a : Fin p → Fin q → ℂ,
      ∃ c : Fin p → ℂ, (∃ i, c i ≠ 0) ∧ ∀ j, ∑ i, c i * a i j = 0
  | 0, p, hp, _ => by
    -- `q = 0`: `c_1 := 1_ℂ`、他は `0_ℂ`。式の条件は空
    refine ⟨fun i => if (i : ℕ) = 0 then 1 else 0, ⟨⟨0, hp⟩, by simp⟩, fun j => j.elim0⟩
  | q + 1, p, hp, a => by
    obtain ⟨p', rfl⟩ : ∃ p', p = p' + 1 := ⟨p - 1, by omega⟩
    by_cases hcase : ∀ j, a (Fin.last p') j = 0
    · -- 場合 1
      refine ⟨Fin.snoc (α := fun _ => ℂ) (fun _ => 0) 1, ⟨Fin.last p', by simp⟩, fun j => ?_⟩
      rw [Fin.sum_univ_castSucc]                             -- `def_finite_sum_of_complex_numbers`（`m → p-1`）
      simp only [Fin.snoc_castSucc, Fin.snoc_last, zero_mul,  -- `c_i` の置き方・`complex_zero_times_is_zero`
        Finset.sum_const_zero, zero_add, one_mul]             -- `finite_sum_of_complex_zeros`・`complex_zero_plus_is_original`・`complex_one_is_multiplicative_identity`
      exact hcase j                                           -- 場合 1 の仮定
    · -- 場合 2
      push_neg at hcase
      obtain ⟨j₀, hj₀⟩ := hcase
      set α := (a (Fin.last p') j₀)⁻¹ with hα
      have hαa : α * a (Fin.last p') j₀ = 1 := inv_mul_cancel₀ hj₀   -- `complex_numbers_form_a_field` の乗法の逆元
      let τ : Fin (q + 1) → ℂ := fun j => -(α * a (Fin.last p') j)
      let g : Fin p' → Fin (q + 1) → ℂ := fun k j => a k.castSucc j + a k.castSucc j₀ * τ j
      have hg₀ : ∀ k, g k j₀ = 0 := fun k => by
        show a k.castSucc j₀ + a k.castSucc j₀ * (-(α * a (Fin.last p') j₀)) = 0
        rw [hαa,                                              -- `α a_{pj_0} = 1_ℂ`
          mul_neg,                                            -- `complex_times_negation_is_negation_of_product_in_cc`
          mul_one,                                            -- `complex_one_is_multiplicative_identity`
          add_neg_cancel]                                     -- `complex_numbers_form_a_field` の加法の逆元
      obtain ⟨c', ⟨k₀, hk₀⟩, hc'⟩ :=
        homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution q p' (by omega)
          (fun k l => g k (j₀.succAbove l))                   -- 帰納法の仮定（`b_{kl} := g_{k δ^{q}_{j_0}(l)}`）
      set S := ∑ k, c' k * a k.castSucc j₀ with hS
      refine ⟨Fin.snoc (α := fun _ => ℂ) c' (-(S * α)), ⟨k₀.castSucc, by simpa using hk₀⟩, fun j => ?_⟩
      have hchain : ∑ i, Fin.snoc (α := fun _ => ℂ) c' (-(S * α)) i * a i j = ∑ k, c' k * g k j := by
        rw [Fin.sum_univ_castSucc]                            -- `def_finite_sum_of_complex_numbers`（`m → p-1`）
        simp only [Fin.snoc_castSucc, Fin.snoc_last]          -- `c_i` の置き方
        rw [neg_mul,                                          -- `negation_times_complex_is_negation_of_product_in_cc`
          mul_assoc,                                          -- `complex_multiplication_is_associative`
          ← mul_neg]                                          -- `complex_times_negation_is_negation_of_product_in_cc` を右辺から左辺へ
        show _ + S * τ j = _                                  -- `τ_j` の置き方
        rw [hS, ← finite_sum_of_complex_numbers_times_complex_number' (fun k => c' k * a k.castSucc j₀) (τ j),
          ← Finset.sum_add_distrib]                           -- `finite_sum_of_complex_sums` を右辺から左辺へ
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [mul_assoc, ← mul_add]                             -- `complex_multiplication_is_associative`・分配律を右辺から左辺へ
      rw [hchain]
      by_cases hj : j = j₀
      · subst hj
        simp only [hg₀, mul_zero, Finset.sum_const_zero]      -- `g_{kj_0} = 0`・`complex_times_zero_is_zero`・`finite_sum_of_complex_zeros`
      · obtain ⟨l, rfl⟩ := Fin.exists_succAbove_eq hj         -- `index_skipping_map_reaches_every_other_index`
        exact hc' l                                           -- `c'` の取り方

section MatrixSpace2

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- **`linearly_independent_family_is_no_longer_than_spanning_family`**（人手の `q ≥ 1`。Lean の証明はこれを使わない）。 -/
theorem linearly_independent_family_is_no_longer_than_spanning_family {p q : ℕ} (_hq : 1 ≤ q)
    (u : Fin p → Matrix ι κ ℂ) (w : Fin q → Matrix ι κ ℂ) (hu : ∀ i, MatIsLinComb (u i) w)
    (hind : MatLinIndep u) : p ≤ q := by
  by_contra hpq
  push_neg at hpq
  choose a ha using hu                                        -- `u_i = Σ_j a_{ij} w_j`
  obtain ⟨c, ⟨i₀, hi₀⟩, hc⟩ :=
    homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution q p hpq a
  apply hi₀
  refine hind c ?_ i₀
  calc matLinComb c u
      = ∑ i, c i • ∑ j, a i j • w j := by
        unfold matLinComb; refine Finset.sum_congr rfl fun i _ => ?_; rw [ha i]; rfl   -- `u_i` の表示
    _ = ∑ i, ∑ j, c i • (a i j • w j) := by simp only [Finset.smul_sum]               -- `finite_sum_of_scalar_multiples`
    _ = ∑ i, ∑ j, (c i * a i j) • w j := by simp only [mul_smul]                      -- `scalar_multiple_is_associative`
    _ = ∑ j, ∑ i, (c i * a i j) • w j := Finset.sum_comm                               -- `finite_double_sum_of_matrices_interchange`
    _ = ∑ j, (∑ i, c i * a i j) • w j := by simp only [Finset.sum_smul]               -- `finite_sum_of_scalar_multiples_of_one_matrix`
    _ = ∑ j, (0 : ℂ) • w j := by simp only [hc]                                        -- `c` の取り方
    _ = 0 := by simp only [zero_smul, Finset.sum_const_zero]                            -- `zero_scalar_multiple_is_zero_matrix`・`finite_sum_of_zero_matrices`

/-- 人手の交換を `q = 0` を含めて使うための形（`bases_of_subspace_have_same_number_of_elements` の Step 1 を Lean で
まとめて扱うため）。人手の `q = 0` の場合は `linearly_independent_family_has_no_zero_element` で示す。 -/
theorem linearly_independent_family_is_no_longer_than_spanning_family_of_zero {p : ℕ}
    (u : Fin p → Matrix ι κ ℂ) (w : Fin 0 → Matrix ι κ ℂ) (hu : ∀ i, MatIsLinComb (u i) w)
    (hind : MatLinIndep u) : p = 0 := by
  by_contra hp
  obtain ⟨c, hc⟩ := hu ⟨0, Nat.pos_of_ne_zero hp⟩
  -- 元を持たない族の線型結合は `O`（`def_linear_combination`）
  have h0 : u ⟨0, Nat.pos_of_ne_zero hp⟩ = 0 := by rw [hc]; simp [matLinComb]
  exact linearly_independent_family_has_no_zero_element hind _ h0

/-- **`extending_independent_family_by_element_outside_span`**: `u_{p+1} := x`。 -/
theorem extending_independent_family_by_element_outside_span {p : ℕ} {u : Fin p → Matrix ι κ ℂ}
    {x : Matrix ι κ ℂ} (hu : MatLinIndep u) (hx : ¬ MatIsLinComb x u) :
    MatLinIndep (Fin.snoc (α := fun _ => Matrix ι κ ℂ) u x) := by
  intro c hc
  rw [linear_combination_splits_off_last_term] at hc          -- `linear_combination_splits_off_last_term`
  simp only [Fin.snoc_castSucc, Fin.snoc_last] at hc
  set L := matLinComb (fun t => c t.castSucc) u with hL
  have hneg : c (Fin.last p) • x = -L := eq_neg_of_add_eq_zero_left (by rw [add_comm]; exact hc)
    -- `matrix_sum_is_commutative`・`matrix_equals_negation_if_sum_is_zero`
  -- Step 1: `c_{p+1} = 0_ℂ`
  have hlast : c (Fin.last p) = 0 := by
    by_contra hne
    apply hx
    set β := (c (Fin.last p))⁻¹
    refine ⟨fun t => -β * c t.castSucc, ?_⟩
    calc x = (1 : ℂ) • x := (one_smul ℂ x).symm               -- `scalar_multiple_by_one`
      _ = (β * c (Fin.last p)) • x := by rw [inv_mul_cancel₀ hne]  -- `β c_{p+1} = 1_ℂ`
      _ = β • (c (Fin.last p) • x) := mul_smul _ _ _         -- `scalar_multiple_is_associative`
      _ = β • (-L) := by rw [hneg]                            -- `c_{p+1}x = -L`
      _ = (-β) • L := by rw [smul_neg, neg_smul]              -- `negation_is_scalar_multiple_by_minus_one`・`complex_times_negation_is_negation_of_product_in_cc`
      _ = matLinComb (fun t => -β * c t.castSucc) u := by
        rw [hL]; unfold matLinComb
        rw [Finset.smul_sum]                                  -- `finite_sum_of_scalar_multiples`
        exact Finset.sum_congr rfl fun t _ => (mul_smul _ _ _).symm  -- `scalar_multiple_is_associative`
  -- Step 2: `t ≤ p` の係数
  have hL0 : L = 0 := by rw [hlast, zero_smul, add_zero] at hc; exact hc
  intro t
  refine Fin.lastCases ?_ (fun t => ?_) t
  · exact hlast
  · exact hu _ hL0 t

end MatrixSpace2

section MatrixUnits

variable {ι κ : Type*} [Fintype ι] [Fintype κ] [DecidableEq ι] [DecidableEq κ]

/-- 人手の行列単位 `(E^{(m,n)}_{ij})_{kl} := δ_{ik} δ_{jl}`。 -/
def matUnit (i : ι) (j : κ) : Matrix ι κ ℂ :=
  Matrix.of fun k l => (if i = k then (1 : ℂ) else 0) * (if j = l then (1 : ℂ) else 0)

/-- `matrix_units_form_basis` の Step 1 の式 (C): `(Σ_t b_t F_t)_{kl} = b_{π^{-1}(k,l)}`。 -/
theorem matUnit_linComb_apply {N : ℕ} (π : Fin N ≃ ι × κ) (b : Fin N → ℂ) (k : ι) (l : κ) :
    matLinComb b (fun t => matUnit (π t).1 (π t).2) k l = b (π.symm (k, l)) := by
  unfold matLinComb
  rw [Matrix.sum_apply]                                       -- `finite_sum_of_matrices_entrywise`
  simp only [Matrix.smul_apply, matUnit, Matrix.of_apply, smul_eq_mul]  -- `def_matrix_scalar_multiple`
  rw [Finset.sum_eq_single (π.symm (k, l))]                  -- `finite_sum_with_single_nonzero_term`
  · simp                                                      -- `δ_{kk} δ_{ll} = 1_ℂ 1_ℂ`・`complex_one_is_multiplicative_identity`
  · intro t _ ht
    have hne : π t ≠ (k, l) := fun h => ht (by rw [← h, Equiv.symm_apply_apply])
    by_cases h1 : (π t).1 = k
    · have h2 : (π t).2 ≠ l := fun h2 => hne (Prod.ext h1 h2)
      simp [h2]                                               -- `complex_times_zero_is_zero`
    · simp [h1]                                               -- `complex_zero_times_is_zero`
  · intro h; exact absurd (Finset.mem_univ _) h

/-- **`matrix_units_form_basis`**: どの全単射 `π : {1,…,N} → {1,…,m}×{1,…,n}` で並べても基底。 -/
theorem matrix_units_form_basis {N : ℕ} (π : Fin N ≃ ι × κ) :
    MatIsBasis (Set.univ : Set (Matrix ι κ ℂ)) (fun t => matUnit (π t).1 (π t).2) := by
  refine ⟨⟨fun _ => trivial, fun A _ => ⟨fun t => A (π t).1 (π t).2, ?_⟩⟩, fun c hc t₀ => ?_⟩
  · -- Step 2（張る）
    ext k l
    rw [matUnit_linComb_apply]                                -- (C)
    simp
  · -- Step 3（線型独立）
    have := matUnit_linComb_apply π c (π t₀).1 (π t₀).2       -- (C)
    rw [hc] at this                                           -- 仮定
    simpa using this.symm                                     -- `def_zero_matrix`

/-- 行列単位の族は全体を張る（`subspace_has_basis` の Step 2・`linearly_independent_family_of_n_vectors_is_basis` で使う形）。 -/
theorem matUnit_spans (A : Matrix ι κ ℂ) :
    MatIsLinComb A (fun t => matUnit ((Fintype.equivFin (ι × κ)).symm t).1 ((Fintype.equivFin (ι × κ)).symm t).2) :=
  (matrix_units_form_basis (Fintype.equivFin (ι × κ)).symm).1.2 A trivial

end MatrixUnits

section BasisExistence

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- **`subspace_has_basis`**（人手の `N := mn` は `Fintype.card (ι × κ)`）。 -/
theorem subspace_has_basis (U : Set (Matrix ι κ ℂ)) (_hU : IsSubspaceMat U) :
    ∃ p, p ≤ Fintype.card ι * Fintype.card κ ∧ ∃ u : Fin p → Matrix ι κ ℂ, MatIsBasis U u := by
  classical
  have hN : Fintype.card (ι × κ) = Fintype.card ι * Fintype.card κ := Fintype.card_prod ι κ
  let S : ℕ → Prop := fun p => ∃ u : Fin p → Matrix ι κ ℂ, (∀ t, u t ∈ U) ∧ MatLinIndep u
  -- Step 1: `0 ∈ 𝒮`（元を持たない族は線型独立）
  have h0 : S 0 := ⟨Fin.elim0, fun t => t.elim0, fun _ _ t => t.elim0⟩
  -- Step 2: `p ∈ 𝒮 ⇒ p ≤ N`（`matrix_units_form_basis` と `linearly_independent_family_is_no_longer_than_spanning_family`）
  have hle : ∀ p, S p → p ≤ Fintype.card (ι × κ) := fun p ⟨u, _, hind⟩ => by
    by_cases hq : 1 ≤ Fintype.card (ι × κ)
    · exact linearly_independent_family_is_no_longer_than_spanning_family hq u _ (fun i => matUnit_spans (u i)) hind
    · -- `N = 0`（人手では `m, n ≥ 1` なので起きない）: 行列は `O` だけなので、線型独立な族は元を持たない
      have hemp : IsEmpty (ι × κ) := Fintype.card_eq_zero_iff.mp (by omega)
      rcases Nat.eq_zero_or_pos p with hp | hp
      · omega
      · exact absurd (Matrix.ext fun k l => (hemp.false (k, l)).elim)
          (linearly_independent_family_has_no_zero_element hind ⟨0, hp⟩)
  -- Step 3: 最大元 `p₀` と、その族が張ること
  set p₀ := Nat.findGreatest S (Fintype.card (ι × κ))
  obtain ⟨u, huU, hind⟩ : S p₀ := Nat.findGreatest_spec (Nat.zero_le _) h0
  refine ⟨p₀, hN ▸ Nat.findGreatest_le _, u, ⟨huU, fun x hxU => ?_⟩, hind⟩
  by_contra hx
  have hS : S (p₀ + 1) :=
    ⟨Fin.snoc (α := fun _ => Matrix ι κ ℂ) u x,
      fun t => Fin.lastCases (by simpa using hxU) (fun t => by simpa using huU t) t,
      extending_independent_family_by_element_outside_span hind hx⟩   -- `extending_independent_family_by_element_outside_span`
  exact Nat.findGreatest_is_greatest (Nat.lt_succ_self p₀) (hle _ hS) hS

/-- **`bases_of_subspace_have_same_number_of_elements`**。 -/
theorem bases_of_subspace_have_same_number_of_elements {U : Set (Matrix ι κ ℂ)} (_hU : IsSubspaceMat U)
    {p q : ℕ} {u : Fin p → Matrix ι κ ℂ} {w : Fin q → Matrix ι κ ℂ}
    (hu : MatIsBasis U u) (hw : MatIsBasis U w) : p = q := by
  -- Step 1: `q = 0 ⇒ p = 0` と、その逆
  rcases Nat.eq_zero_or_pos q with hq | hq
  · subst hq
    exact (linearly_independent_family_is_no_longer_than_spanning_family_of_zero u w
      (fun s => hw.1.2 _ (hu.1.1 s)) hu.2).trans rfl
  rcases Nat.eq_zero_or_pos p with hp | hp
  · subst hp
    exact (linearly_independent_family_is_no_longer_than_spanning_family_of_zero w u
      (fun s => hu.1.2 _ (hw.1.1 s)) hw.2).symm
  -- Step 2: `p, q ≥ 1`
  exact le_antisymm
    (linearly_independent_family_is_no_longer_than_spanning_family hq u w (fun s => hw.1.2 _ (hu.1.1 s)) hu.2)
    (linearly_independent_family_is_no_longer_than_spanning_family hp w u (fun s => hu.1.2 _ (hw.1.1 s)) hw.2)

/-- **`def_dimension`**: 基底の元の個数（存在は `subspace_has_basis`、取り方によらないことは
`bases_of_subspace_have_same_number_of_elements` と `matDim_eq_of_isBasis`）。 -/
noncomputable def matDim (U : Set (Matrix ι κ ℂ)) (hU : IsSubspaceMat U) : ℕ :=
  Classical.choose (subspace_has_basis U hU)

theorem matDim_spec (U : Set (Matrix ι κ ℂ)) (hU : IsSubspaceMat U) :
    ∃ u : Fin (matDim U hU) → Matrix ι κ ℂ, MatIsBasis U u :=
  (Classical.choose_spec (subspace_has_basis U hU)).2

/-- `def_dimension` の well-definedness: どの基底の元の個数も `dim_ℂ U` に等しい。 -/
theorem matDim_eq_of_isBasis {U : Set (Matrix ι κ ℂ)} (hU : IsSubspaceMat U)
    {p : ℕ} {u : Fin p → Matrix ι κ ℂ} (hu : MatIsBasis U u) : matDim U hU = p := by
  obtain ⟨w, hw⟩ := matDim_spec U hU
  exact bases_of_subspace_have_same_number_of_elements hU hw hu

/-- `Mat(m,n,ℂ)` 自身は部分空間（`def_subspace` の最後の文）。 -/
theorem isSubspaceMat_univ : IsSubspaceMat (Set.univ : Set (Matrix ι κ ℂ)) :=
  ⟨trivial, fun _ _ => trivial, fun _ _ _ => trivial⟩

/-- **`dimension_of_matrix_space`**: `dim_ℂ Mat(m,n,ℂ) = mn`。 -/
theorem dimension_of_matrix_space :
    matDim (Set.univ : Set (Matrix ι κ ℂ)) isSubspaceMat_univ = Fintype.card ι * Fintype.card κ := by
  classical
  rw [matDim_eq_of_isBasis isSubspaceMat_univ (matrix_units_form_basis (Fintype.equivFin (ι × κ)).symm)]
  exact Fintype.card_prod ι κ                                 -- 元の個数 `mn`

end BasisExistence

section ImageKernel

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- **`image_of_matrix_is_subspace`**: `im Q := {Qx | x ∈ ℂ^n}` は `ℂ^m` の部分空間。 -/
theorem image_of_matrix_is_subspace (Q : Matrix ι κ ℂ) :
    IsSubspaceMat {y : Matrix ι (Fin 1) ℂ | ∃ x : Matrix κ (Fin 1) ℂ, y = Q * x} where
  zero_mem := ⟨0, (Matrix.mul_zero Q).symm⟩                    -- `zero_matrix_is_right_zero_of_mat_mult`
  add_mem := by
    rintro _ _ ⟨x, rfl⟩ ⟨y, rfl⟩
    exact ⟨x + y, (Matrix.mul_add Q x y).symm⟩                -- `mat_mult_distributes_over_sum_in_right_factor`
  smul_mem := by
    rintro a _ ⟨x, rfl⟩
    exact ⟨a • x, (Matrix.mul_smul Q a x).symm⟩               -- `scalar_multiple_factors_out_of_right_factor`

/-- **`kernel_of_matrix_is_subspace`**: `ker Q := {x | Qx = O}` は `ℂ^n` の部分空間。 -/
theorem kernel_of_matrix_is_subspace (Q : Matrix ι κ ℂ) :
    IsSubspaceMat {x : Matrix κ (Fin 1) ℂ | Q * x = 0} where
  zero_mem := Matrix.mul_zero Q                                -- `zero_matrix_is_right_zero_of_mat_mult`
  add_mem := by
    intro x y hx hy
    show Q * (x + y) = 0
    rw [Matrix.mul_add, hx, hy, add_zero]                     -- `mat_mult_distributes_over_sum_in_right_factor`・`matrix_plus_zero_matrix`
  smul_mem := by
    intro a x hx
    show Q * (a • x) = 0
    rw [Matrix.mul_smul, hx, smul_zero]                       -- `scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_of_zero_matrix`

/-- **`eigenvalue_equation_solution_set_is_subspace`**: `E_λ(A) := {x | Ax = λx}` は `ℂ^n` の部分空間。 -/
theorem eigenvalue_equation_solution_set_is_subspace (A : Matrix κ κ ℂ) (lam : ℂ) :
    IsSubspaceMat {x : Matrix κ (Fin 1) ℂ | A * x = lam • x} where
  zero_mem := by
    show A * 0 = lam • (0 : Matrix κ (Fin 1) ℂ)
    rw [Matrix.mul_zero, smul_zero]                           -- `zero_matrix_is_right_zero_of_mat_mult`・`scalar_multiple_of_zero_matrix`
  add_mem := by
    intro x y hx hy
    show A * (x + y) = lam • (x + y)
    rw [Matrix.mul_add, hx, hy, smul_add]                     -- `mat_mult_distributes_over_sum_in_right_factor`・`scalar_multiple_distributes_over_matrix_sum`
  smul_mem := by
    intro a x hx
    show A * (a • x) = lam • (a • x)
    rw [Matrix.mul_smul, hx,                                  -- `scalar_multiple_factors_out_of_right_factor`
      smul_smul, mul_comm, ← smul_smul]                       -- `scalar_multiple_is_associative`・`complex_multiplication_is_commutative`

end ImageKernel

section DirectSum

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- **`concatenated_bases_of_direct_sum_form_basis`**（つないだ族は `Fin.append u w`）。 -/
theorem concatenated_bases_of_direct_sum_form_basis {Vs U W : Set (Matrix ι κ ℂ)}
    (hU : IsSubspaceMat U) (hW : IsSubspaceMat W) (hds : IsDirectSumOfTwoMat Vs U W)
    {r s : ℕ} {u : Fin r → Matrix ι κ ℂ} {w : Fin s → Matrix ι κ ℂ} (hu : MatIsBasis U u) (hw : MatIsBasis W w) :
    MatIsBasis Vs (Fin.append u w) := by
  obtain ⟨hUV, hWV, hsum, hcap⟩ := hds
  refine ⟨⟨fun t => ?_, fun x hx => ?_⟩, fun c hc => ?_⟩
  · refine Fin.addCases (fun t => ?_) (fun t => ?_) t        -- `U ⊆ V`、`W ⊆ V`
    · rw [Fin.append_left]; exact hUV (hu.1.1 t)
    · rw [Fin.append_right]; exact hWV (hw.1.1 t)
  · -- Step 1（張る）
    obtain ⟨y, hy, z, hz, rfl⟩ := hsum x hx                    -- `def_direct_sum_of_two_subspaces` (i)
    obtain ⟨a, rfl⟩ := hu.1.2 y hy
    obtain ⟨b, rfl⟩ := hw.1.2 z hz
    refine ⟨Fin.append a b, ?_⟩
    rw [linear_combination_splits_into_two_blocks]            -- `linear_combination_splits_into_two_blocks`
    simp only [Fin.append_left, Fin.append_right]             -- `c_t`・`v_t` の置き方
  · -- Step 2（線型独立）
    rw [linear_combination_splits_into_two_blocks] at hc      -- `linear_combination_splits_into_two_blocks` を右辺から左辺へ
    simp only [Fin.append_left, Fin.append_right] at hc
    set y := matLinComb (fun t => c (Fin.castAdd s t)) u
    set z := matLinComb (fun t => c (Fin.natAdd r t)) w
    have hyU : y ∈ U := linear_combination_of_subspace_elements_stays_in_subspace hU _ _ hu.1.1
    have hzW : z ∈ W := linear_combination_of_subspace_elements_stays_in_subspace hW _ _ hw.1.1
    have hyneg : y = (-1 : ℂ) • z := by
      rw [neg_one_smul]; exact eq_neg_of_add_eq_zero_left hc  -- `matrix_equals_negation_if_sum_is_zero`・`negation_is_scalar_multiple_by_minus_one`
    have hy0 : y = 0 := hcap y hyU (hyneg ▸ hW.smul_mem (-1) hzW)  -- `def_subspace` (iii)・`def_direct_sum_of_two_subspaces` (ii)
    have hz0 : z = 0 := by rw [hy0, zero_add] at hc; exact hc     -- `zero_matrix_plus_matrix`
    intro t
    refine Fin.addCases (fun t => ?_) (fun t => ?_) t
    · exact hu.2 _ hy0 t
    · exact hw.2 _ hz0 t

/-- `concatenated_bases_of_direct_sum_form_basis` の「とくに」: `dim_ℂ V = dim_ℂ U + dim_ℂ W`。 -/
theorem dim_of_direct_sum_of_two {Vs U W : Set (Matrix ι κ ℂ)} (hV : IsSubspaceMat Vs)
    (hU : IsSubspaceMat U) (hW : IsSubspaceMat W) (hds : IsDirectSumOfTwoMat Vs U W) :
    matDim Vs hV = matDim U hU + matDim W hW := by
  obtain ⟨u, hu⟩ := matDim_spec U hU
  obtain ⟨w, hw⟩ := matDim_spec W hW
  exact matDim_eq_of_isBasis hV (concatenated_bases_of_direct_sum_form_basis hU hW hds hu hw)

end DirectSum

/-- **`matrix_of_basis_columns_has_inverse`**: 基底 `v_1, …, v_n` を列に並べた `P` は両側逆行列を持つ。 -/
theorem matrix_of_basis_columns_has_inverse {n : ℕ} (v : Fin n → Matrix (Fin n) (Fin 1) ℂ)
    (hv : MatIsBasis Set.univ v) :
    ∃ P' : Matrix (Fin n) (Fin n) ℂ,
      P' * Matrix.of (fun i j => v j i 0) = 1 ∧ Matrix.of (fun i j => v j i 0) * P' = 1 := by
  set P : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun i j => v j i 0 with hP
  -- 準備 (L): `P y = Σ_j y_j v_j`
  have hL : ∀ y : Matrix (Fin n) (Fin 1) ℂ, P * y = matLinComb (fun j => y j 0) v := by
    intro y; ext i z
    have hz : z = 0 := Subsingleton.elim _ _
    subst hz
    rw [Matrix.mul_apply]                                     -- `mat_mult`
    unfold matLinComb
    rw [Matrix.sum_apply]                                     -- `finite_sum_of_matrices_entrywise` を右辺から左辺へ
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [hP, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, mul_comm]
      -- `mat_columnwise` の成分・`complex_multiplication_is_commutative`・`def_matrix_scalar_multiple`
  -- 標準基底 `e_k`（`(e_k)_i = δ_{ik}`）
  let e : Fin n → Matrix (Fin n) (Fin 1) ℂ := fun k => Matrix.of fun i _ => if k = i then 1 else 0
  -- Step 1: `PC = I`
  choose cc hcc using fun k => hv.1.2 (e k) trivial
  let C : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j k => cc k j
  have hPC : P * C = 1 := by
    ext i k
    have h := congrArg (fun X : Matrix (Fin n) (Fin 1) ℂ => X i 0) (hL (Matrix.of fun j _ => cc k j))
    simp only [Matrix.mul_apply, Matrix.of_apply] at h
    rw [Matrix.mul_apply]                                     -- `mat_mult`
    simp only [C, Matrix.of_apply]                            -- `C`・`c^{(k)}` の定め方
    rw [h, ← hcc k]                                           -- (L)・`c_{jk}` の取り方
    simp [e, Matrix.one_apply, eq_comm]                       -- `e_k` の定め方・`def_identity_matrix`
  -- Step 2: `CP = I`
  have hCP : C * P = 1 := by
    ext j l
    let y : Matrix (Fin n) (Fin 1) ℂ := (C * P) * e l - e l
    have hPy : P * y = 0 := by
      simp only [y, Matrix.mul_sub, ← Matrix.mul_assoc, hPC, Matrix.one_mul, sub_self]
        -- `mat_mult_vector_difference`・`mat_mult_associative`・Step 1・`identity_matrix_is_left_unit_of_mat_mult`・`matrix_difference_zero_iff_equal`
    have hy : ∀ t, y t 0 = 0 := hv.2 _ (by rw [← hL]; exact hPy)   -- (L) と線型独立性
    have hcol : ((C * P) * e l) j 0 = (C * P) j l := by        -- `finite_sum_with_single_nonzero_term`
      rw [Matrix.mul_apply]
      simp only [e, Matrix.of_apply, mul_ite, mul_one, mul_zero]
      rw [Finset.sum_ite_eq]
      simp
    have h := hy j
    simp only [y, Matrix.sub_apply, hcol] at h
    rw [sub_eq_zero] at h                                     -- `matrix_difference_zero_iff_equal` の `⇒`
    rw [h]
    simp [e, Matrix.one_apply, eq_comm]                       -- `e_l` の定め方・`def_identity_matrix`
  exact ⟨C, hCP, hPC⟩

section OneDimensional

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- **`one_dimensional_subspace_is_multiples_of_nonzero_element`**。 -/
theorem one_dimensional_subspace_is_multiples_of_nonzero_element {U : Set (Matrix ι κ ℂ)} (hU : IsSubspaceMat U)
    (hdim : matDim U hU = 1) :
    ∃ q ∈ U, q ≠ 0 ∧ U = {A | ∃ c : ℂ, A = c • q} := by
  obtain ⟨u, hu⟩ := matDim_spec U hU                          -- `def_dimension`・`subspace_has_basis`
  revert u
  rw [hdim]
  intro u hu
  refine ⟨u 0, hu.1.1 0, linearly_independent_family_has_no_zero_element hu.2 0,  -- `linearly_independent_family_has_no_zero_element`
    Set.ext fun A => ⟨fun hA => ?_, ?_⟩⟩
  · obtain ⟨c, hc⟩ := hu.1.2 A hA                             -- `def_spanning_family`
    exact ⟨c 0, by rw [hc]; simp [matLinComb]⟩                -- `def_linear_combination`・`def_finite_sum_of_matrices`
  · rintro ⟨c, rfl⟩
    exact hU.smul_mem c (hu.1.1 0)                            -- `def_subspace` (iii)

end OneDimensional

/-- **`linearly_independent_family_of_n_vectors_is_basis`**: `ℂ^N` の `N` 個の元の線型独立な族は基底。
人手の `ℂ^n` の添字 `{1,…,n}` を、元の個数が `N` の有限型 `ι` に広げた（`nonzero_elements_of_images_of_check_Q_form_basis` の
具体版の数ベクトルの添字は `Conf M` なので）。 -/
theorem linearly_independent_family_of_n_vectors_is_basis {ι : Type*} [Fintype ι] [DecidableEq ι] {N : ℕ}
    (hN : Fintype.card ι = N) (v : Fin N → Matrix ι (Fin 1) ℂ) (hv : MatLinIndep v) : MatIsBasis Set.univ v := by
  -- 標準基底 `e_t := E^{(N,1)}_{t1}`（`matrix_units_form_basis` の `π(t) := (t,1)`）
  let σ : ι ≃ Fin N := Fintype.equivFinOfCardEq hN
  let π : Fin N ≃ ι × Fin 1 :=
    { toFun := fun t => (σ.symm t, 0), invFun := fun x => σ x.1,
      left_inv := fun t => by simp,
      right_inv := fun x => Prod.ext (by simp) (Subsingleton.elim _ _) }
  have he := matrix_units_form_basis π
  refine ⟨⟨fun _ => trivial, fun x _ => ?_⟩, hv⟩
  by_contra hx
  rcases Nat.eq_zero_or_pos N with hn | hn
  · -- `N = 0`（人手では `n ≥ 1`）: `ℂ^0` の元は `O` で、元を持たない族の線型結合
    subst hn
    have hemp : IsEmpty ι := Fintype.card_eq_zero_iff.mp hN
    exact hx ⟨Fin.elim0, Matrix.ext fun i _ => (hemp.false i).elim⟩
  have := linearly_independent_family_is_no_longer_than_spanning_family hn (Fin.snoc (α := fun _ => _) v x) _
    (fun i => he.1.2 _ trivial)                               -- `(e_1,…,e_N)` は `ℂ^N` を張る
    (extending_independent_family_by_element_outside_span hv hx)  -- `extending_independent_family_by_element_outside_span`
  omega                                                       -- `N + 1 ≤ N` の矛盾

end Ising2D
