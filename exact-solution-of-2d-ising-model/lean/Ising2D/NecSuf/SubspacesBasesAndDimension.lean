/-
# 部分空間・線型結合・張る・線型独立・基底・次元・直和（**必要十分版**）

人手: `structured-latex/content/002_linear_space_general.ts` の定義 `def_subspace`・`def_linear_combination`・
`def_spanning_family`・`def_linearly_independent`・`def_basis`・`def_basis_indexed_by_finite_set`・`def_dimension`・
`def_direct_sum_of_two_subspaces`・`def_direct_sum_over_binary_words` と、主張
`finite_sum_of_complex_numbers_times_complex_number` から `linearly_independent_family_of_n_vectors_is_basis` まで。
具体版は `Ising2D/MathematicalTools/SubspacesBasesAndDimension/SubspacesBasesAndDimension.lean`、
具体版をこのファイルの特殊化として導くのは同じフォルダの `SubspacesBasesAndDimensionFromNecSuf.lean`。

人手の `Mat(m,n,ℂ)` を任意の加群 `V`、係数 `ℂ` を環 `K` に置き換え、族は `Fin p → V`、線型結合は `Fin p` の上の
`Finset.sum` で書く。部分空間・張る・線型独立・基底・次元・直和は mathlib の `Submodule`・`LinearIndependent`・
`Basis`・`finrank` を使わず、人手の定義どおりここで定める。証明の段は具体版と同じ並び（具体版の各宣言の名前に
`NecSuf.` を付けたものが対応する）。

## 何が効いているか / 効いていないか

- 定義（部分空間・線型結合・張る・線型独立・基底）は係数が半環、`V` が可換モノイドの加群で書ける。
- `finite_sum_of_complex_numbers_times_complex_number`: 右分配律だけ（`NonUnitalNonAssocSemiring`）。
- `linear_combination_splits_off_last_term`・`linear_combination_splits_into_two_blocks`・
  `linear_combination_of_subspace_elements_stays_in_subspace`: 和の結合律・可換律と零元（`AddCommMonoid`）だけで、
  係数の性質は使わない。`matrix_sum_is_associative` は `AddSemigroup` の公理そのもの。
- `linearly_independent_family_has_no_zero_element`: `1 ≠ 0`（`Nontrivial K`）が要る。零環では零元だけの族も
  線型独立になり、主張が崩れる。
- `homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution`: **乗法の可換性は要らない**（`DivisionRing`）。
  消去に要るのは `a_{pj_0}` の左逆元 `α a_{pj_0} = 1` と結合律・分配律だけで、係数は左から掛ける。
  零でない元の逆元は削れない（消去の段そのもの）。
- 交換（`linearly_independent_family_is_no_longer_than_spanning_family`）・基底の存在・元の個数の一意性・
  `extending_independent_family_by_element_outside_span`・`linearly_independent_family_of_n_vectors_is_basis`:
  `DivisionRing K` 上の左加群で通る（可換性・有限次元性・`V` が行列であることは使わない）。
  人手の交換は `q ≥ 1` で述べるが、Lean の証明は `q = 0` でも通るのでその仮定を置かない
  （人手で `q ≥ 1` に限ったのは、元を持たない族の線型結合を `O` と別に定めたためで、論証は使わない）。
- 基底の存在（`subspace_has_basis`）: `U` が部分空間であることは**使わない**（線型独立な族の元が `U` に属すること
  だけを使う）。使うのは、全体を張る有限族 `w : Fin N → V` があることだけ（人手では行列単位の族）。
- `concatenated_bases_of_direct_sum_form_basis`: `-1` 倍で閉じることを使うので係数は環（`Ring K`）。
- `matrix_units_form_basis`: 係数は半環でよい（`1`・`0` と積の単位元・零元だけ）。
- `matrix_of_basis_columns_has_inverse`: **乗法の可換性が要る**（`CommRing K`）。準備 (L) の
  `P_{ij} y_j = y_j (v_j)_i`（行列と数ベクトルの積を、係数を左から掛ける線型結合に読み替える段）で使う。
  零でない元の逆元は使わない。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Algebra.Module.Pi
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.Module.BigOperators
import Mathlib.Data.Nat.Find
import Mathlib.Algebra.Field.Basic
import Mathlib.Algebra.Module.LinearMap.Defs
import Ising2D.NecSuf.BinaryWordSum

namespace Ising2D.NecSuf

open Finset

section Definitions

variable (K : Type*) {V : Type*} [Semiring K] [AddCommMonoid V] [Module K V]

/-- **`def_subspace`**: 零元・和・スカラー倍で閉じた部分集合。 -/
structure IsSubspaceSet (U : Set V) : Prop where
  zero_mem : (0 : V) ∈ U
  add_mem : ∀ {A B : V}, A ∈ U → B ∈ U → A + B ∈ U
  smul_mem : ∀ (a : K) {A : V}, A ∈ U → a • A ∈ U

variable {K}

/-- **`def_linear_combination`**: 族 `u` の係数 `c` による線型結合 `Σ_t c_t u_t`（`p = 0` では `0`）。 -/
def famLinComb {p : ℕ} (c : Fin p → K) (u : Fin p → V) : V := ∑ t, c t • u t

variable (K)

/-- `A` は族 `u` の線型結合である（`def_linear_combination` の後半）。 -/
def FamIsLinComb (A : V) {p : ℕ} (u : Fin p → V) : Prop := ∃ c : Fin p → K, A = famLinComb c u

/-- **`def_spanning_family`**: 族 `u` は `U` を張る（元が `U` に属し、`U` の元はすべて `u` の線型結合）。 -/
def FamSpans (U : Set V) {p : ℕ} (u : Fin p → V) : Prop :=
  (∀ t, u t ∈ U) ∧ ∀ A ∈ U, FamIsLinComb K A u

/-- **`def_linearly_independent`**。 -/
def FamLinIndep {p : ℕ} (u : Fin p → V) : Prop := ∀ c : Fin p → K, famLinComb c u = 0 → ∀ t, c t = 0

/-- **`def_basis`**: 張り、かつ線型独立。 -/
def FamIsBasis (U : Set V) {p : ℕ} (u : Fin p → V) : Prop := FamSpans K U u ∧ FamLinIndep K u

/-- **`def_basis_indexed_by_finite_set`**: 有限集合 `ι` を添字とする族は、`Fin (#ι)` へ並べる全単射で並べると基底になるとき基底。 -/
def FamIsBasisIndexed (U : Set V) {ι : Type*} [Fintype ι] (u : ι → V) : Prop :=
  ∃ π : Fin (Fintype.card ι) ≃ ι, FamIsBasis K U (u ∘ π)

/-- **`def_dimension`**: 基底の元の個数（基底が存在するという証拠 `h` から選ぶ。取り方によらないことは
`famDim_eq_of_isBasis`）。 -/
noncomputable def famDim (U : Set V) (h : ∃ p : ℕ, ∃ u : Fin p → V, FamIsBasis K U u) : ℕ := Classical.choose h

/-- **`def_direct_sum_of_two_subspaces`**。 -/
def IsDirectSumOfTwo (Vs U W : Set V) : Prop :=
  U ⊆ Vs ∧ W ⊆ Vs ∧ (∀ v ∈ Vs, ∃ u ∈ U, ∃ w ∈ W, v = u + w) ∧ ∀ x, x ∈ U → x ∈ W → x = 0

/-- **`def_direct_sum_over_binary_words`**（`{0,1}^{r+1}` で添字付けた部分空間の直和。和は `binWordSum`）。 -/
def IsDirectSumOverBinaryWords (r : ℕ) (Vs : Set V) (U : (Fin (r + 1) → Fin 2) → Set V) : Prop :=
  (∀ ε, U ε ⊆ Vs) ∧ (∀ v ∈ Vs, ∃ u : (Fin (r + 1) → Fin 2) → V, (∀ ε, u ε ∈ U ε) ∧ v = binWordSum r u) ∧
    ∀ u : (Fin (r + 1) → Fin 2) → V, (∀ ε, u ε ∈ U ε) → binWordSum r u = 0 → ∀ ε, u ε = 0

end Definitions

/-- **`finite_sum_of_complex_numbers_times_complex_number`**: `Σ_{j=1}^{m} (y_j w) = (Σ y_j) w`
（人手の `m ≥ 1` は Lean の `m + 1`。`m` についての帰納法、右分配律だけを使う）。 -/
theorem finite_sum_of_complex_numbers_times_complex_number {R : Type*} [NonUnitalNonAssocSemiring R] :
    ∀ (m : ℕ) (y : Fin (m + 1) → R) (w : R), ∑ j, y j * w = (∑ j, y j) * w
  | 0, y, w => by
    rw [Fin.sum_univ_one, Fin.sum_univ_one]                 -- `def_finite_sum_of_complex_numbers`（`m = 1`）
  | m + 1, y, w => by
    rw [Fin.sum_univ_castSucc, Fin.sum_univ_castSucc (f := y), -- `def_finite_sum_of_complex_numbers`
      finite_sum_of_complex_numbers_times_complex_number m (fun j => y j.castSucc) w,  -- 帰納法の仮定
      add_mul]                                                -- 分配律を右辺から左辺へ

/-- 長さ `0` も含めた `finite_sum_of_complex_numbers_times_complex_number`（消去の段の `p - 1` 個の和で使う。
長さ `0` の和は両辺とも `0`）。 -/
theorem finite_sum_of_complex_numbers_times_complex_number' {R : Type*} [NonUnitalNonAssocSemiring R]
    {m : ℕ} (y : Fin m → R) (w : R) : ∑ j, y j * w = (∑ j, y j) * w := by
  cases m with
  | zero => simp
  | succ m => exact finite_sum_of_complex_numbers_times_complex_number m y w

section AddCommMonoidLemmas

variable {K : Type*} {V : Type*} [Semiring K] [AddCommMonoid V] [Module K V]

/-- **`linear_combination_splits_off_last_term`**: `Σ_{t=1}^{p+1} c_t u_t = (Σ_{t=1}^{p} c_t u_t) + c_{p+1} u_{p+1}`。 -/
theorem linear_combination_splits_off_last_term {p : ℕ} (c : Fin (p + 1) → K) (u : Fin (p + 1) → V) :
    famLinComb c u = famLinComb (fun t => c t.castSucc) (fun t => u t.castSucc) + c (Fin.last p) • u (Fin.last p) :=
  Fin.sum_univ_castSucc _                                    -- `def_linear_combination` と `def_finite_sum_of_matrices`

/-- **`matrix_sum_is_associative`**（`V` の加法の結合律そのもの）。 -/
theorem matrix_sum_is_associative (A B C : V) : (A + B) + C = A + (B + C) := add_assoc A B C

/-- **`linear_combination_splits_into_two_blocks`**（`s` についての帰納法。`Fin.append` が人手の `v_t`・`v_{r+t}`）。 -/
theorem linear_combination_splits_into_two_blocks {r : ℕ} :
    ∀ (s : ℕ) (c : Fin (r + s) → K) (v : Fin (r + s) → V),
      famLinComb c v
        = famLinComb (fun t => c (Fin.castAdd s t)) (fun t => v (Fin.castAdd s t))
          + famLinComb (fun t => c (Fin.natAdd r t)) (fun t => v (Fin.natAdd r t))
  | 0, c, v => by
    -- `s = 0`: `matrix_plus_zero_matrix` と、元を持たない族の線型結合は `0`
    simp only [famLinComb, Finset.univ_eq_empty, Finset.sum_empty, add_zero]
    rfl
  | s + 1, c, v => by
    have h1 := linear_combination_splits_off_last_term (p := r + s) c v  -- `linear_combination_splits_off_last_term`（`p → r+s`）
    have h2 := linear_combination_splits_into_two_blocks s (fun t => c t.castSucc) (fun t => v t.castSucc) -- 帰納法の仮定
    have h3 := linear_combination_splits_off_last_term (fun t => c (Fin.natAdd r t)) (fun t => v (Fin.natAdd r t))
    refine h1.trans ?_
    rw [h2, matrix_sum_is_associative, h3]                          -- `matrix_sum_is_associative`・`linear_combination_splits_off_last_term` を右辺から左辺へ
    rfl                                                             -- 同じ添字の読み替え

/-- **`linear_combination_of_subspace_elements_stays_in_subspace`**（`p` についての帰納法）。 -/
theorem linear_combination_of_subspace_elements_stays_in_subspace {U : Set V} (hU : IsSubspaceSet K U) :
    ∀ {p : ℕ} (c : Fin p → K) (u : Fin p → V), (∀ t, u t ∈ U) → famLinComb c u ∈ U
  | 0, c, u, _ => by
    simpa [famLinComb] using hU.zero_mem                          -- `def_linear_combination` の `p = 0` と `def_subspace` (i)
  | p + 1, c, u, hu => by
    rw [linear_combination_splits_off_last_term]                   -- `linear_combination_splits_off_last_term`
    exact hU.add_mem                                               -- `def_subspace` (ii)
      (linear_combination_of_subspace_elements_stays_in_subspace hU _ _ fun t => hu _)  -- 帰納法の仮定
      (hU.smul_mem _ (hu _))                                       -- `def_subspace` (iii)

end AddCommMonoidLemmas

section NontrivialLemmas

variable {K : Type*} {V : Type*} [Semiring K] [Nontrivial K] [AddCommMonoid V] [Module K V]

/-- **`linearly_independent_family_has_no_zero_element`**。`c_t := δ_{ts}` を取る。 -/
theorem linearly_independent_family_has_no_zero_element {p : ℕ} {u : Fin p → V}
    (hu : FamLinIndep K u) (s : Fin p) : u s ≠ 0 := by
  intro hs
  have hsum : famLinComb (fun t => if t = s then (1 : K) else 0) u = 0 := by
    unfold famLinComb
    refine Finset.sum_eq_zero fun t _ => ?_
    show (if t = s then (1 : K) else 0) • u t = 0
    by_cases hts : t = s
    · rw [if_pos hts, hts, hs, smul_zero]                         -- `c_s u_s = c_s O = O`（`scalar_multiple_of_zero_matrix`）
    · rw [if_neg hts, zero_smul]                                  -- `0_ℂ u_t = O`（`zero_scalar_multiple_is_zero_matrix`）
  have := hu _ hsum s                                             -- 線型独立性
  rw [if_pos rfl] at this
  exact one_ne_zero this                                          -- `1_ℂ ≠ 0_ℂ`

end NontrivialLemmas

section DivisionRingLemmas

variable {K : Type*} [DivisionRing K]

/-- **`homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution`**（`q` についての帰納法。
最後の未知数 `c_p` を、その係数が `0` でない式 `j_0` で消去する）。人手の `p` は Lean の `p' + 1`、
人手の `δ^{q}_{j_0}` は `j_0.succAbove`（`q = 0` でも同じ式で書ける）。 -/
theorem homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution :
    ∀ (q p : ℕ), q < p → ∀ a : Fin p → Fin q → K,
      ∃ c : Fin p → K, (∃ i, c i ≠ 0) ∧ ∀ j, ∑ i, c i * a i j = 0
  | 0, p, hp, _ => by
    -- `q = 0`: `c_1 := 1`、他は `0`。式の条件は空
    refine ⟨fun i => if (i : ℕ) = 0 then 1 else 0, ⟨⟨0, hp⟩, by simp⟩, fun j => j.elim0⟩
  | q + 1, p, hp, a => by
    obtain ⟨p', rfl⟩ : ∃ p', p = p' + 1 := ⟨p - 1, by omega⟩
    by_cases hcase : ∀ j, a (Fin.last p') j = 0
    · -- 場合 1: `c_i := 0 (i ≤ p-1)`、`c_p := 1`
      refine ⟨Fin.snoc (α := fun _ => K) (fun _ => 0) 1, ⟨Fin.last p', by simp⟩, fun j => ?_⟩
      rw [Fin.sum_univ_castSucc]                                  -- `def_finite_sum_of_complex_numbers`（`m → p-1`）
      simp only [Fin.snoc_castSucc, Fin.snoc_last, zero_mul,       -- `c_i` の置き方・`complex_zero_times_is_zero`
        Finset.sum_const_zero, zero_add, one_mul]                  -- `finite_sum_of_complex_zeros`・`complex_zero_plus_is_original`・`complex_one_is_multiplicative_identity`
      exact hcase j                                                -- 場合 1 の仮定
    · -- 場合 2: `a_{pj_0} ≠ 0`
      push_neg at hcase
      obtain ⟨j₀, hj₀⟩ := hcase
      set α := (a (Fin.last p') j₀)⁻¹ with hα
      have hαa : α * a (Fin.last p') j₀ = 1 := inv_mul_cancel₀ hj₀   -- 乗法の逆元
      let τ : Fin (q + 1) → K := fun j => -(α * a (Fin.last p') j)
      let g : Fin p' → Fin (q + 1) → K := fun k j => a k.castSucc j + a k.castSucc j₀ * τ j
      have hg₀ : ∀ k, g k j₀ = 0 := fun k => by
        show a k.castSucc j₀ + a k.castSucc j₀ * (-(α * a (Fin.last p') j₀)) = 0
        rw [hαa,                                                   -- `α a_{pj_0} = 1`
          mul_neg,                                                 -- `complex_times_negation_is_negation_of_product_in_cc`
          mul_one,                                                 -- `complex_one_is_multiplicative_identity`
          add_neg_cancel]                                          -- 加法の逆元
      obtain ⟨c', ⟨k₀, hk₀⟩, hc'⟩ :=
        homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution q p' (by omega)
          (fun k l => g k (j₀.succAbove l))                        -- 帰納法の仮定（`b_{kl} := g_{k δ(l)}`）
      set S := ∑ k, c' k * a k.castSucc j₀ with hS
      refine ⟨Fin.snoc (α := fun _ => K) c' (-(S * α)), ⟨k₀.castSucc, by simpa using hk₀⟩, fun j => ?_⟩
      have hchain : ∑ i, Fin.snoc (α := fun _ => K) c' (-(S * α)) i * a i j = ∑ k, c' k * g k j := by
        rw [Fin.sum_univ_castSucc]                                 -- `def_finite_sum_of_complex_numbers`（`m → p-1`）
        simp only [Fin.snoc_castSucc, Fin.snoc_last]               -- `c_i` の置き方
        rw [neg_mul,                                               -- `negation_times_complex_is_negation_of_product_in_cc`
          mul_assoc,                                               -- `complex_multiplication_is_associative`
          ← mul_neg]                                               -- `complex_times_negation_is_negation_of_product_in_cc` を右辺から左辺へ
        show _ + S * τ j = _                                       -- `τ_j` の置き方
        rw [hS, ← finite_sum_of_complex_numbers_times_complex_number' (fun k => c' k * a k.castSucc j₀) (τ j),
          ← Finset.sum_add_distrib]                                -- `finite_sum_of_complex_sums` を右辺から左辺へ
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [mul_assoc, ← mul_add]                                  -- 結合律・分配律を右辺から左辺へ
      rw [hchain]
      by_cases hj : j = j₀
      · subst hj
        simp only [hg₀, mul_zero, Finset.sum_const_zero]           -- `g_{kj_0} = 0`・`complex_times_zero_is_zero`・`finite_sum_of_complex_zeros`
      · obtain ⟨l, rfl⟩ := Fin.exists_succAbove_eq hj              -- `index_skipping_map_reaches_every_other_index`
        exact hc' l                                                -- `c'` の取り方

variable {V : Type*} [AddCommGroup V] [Module K V]

/-- **`linearly_independent_family_is_no_longer_than_spanning_family`**（人手の `q ≥ 1` は使わない）。 -/
theorem linearly_independent_family_is_no_longer_than_spanning_family {p q : ℕ}
    (u : Fin p → V) (w : Fin q → V) (hu : ∀ i, FamIsLinComb K (u i) w) (hind : FamLinIndep K u) : p ≤ q := by
  by_contra hpq
  push_neg at hpq
  choose a ha using hu                                             -- `u_i = Σ_j a_{ij} w_j`
  obtain ⟨c, ⟨i₀, hi₀⟩, hc⟩ :=
    homogeneous_linear_equations_with_more_unknowns_have_nonzero_solution q p hpq a
  apply hi₀
  refine hind c ?_ i₀
  calc famLinComb c u
      = ∑ i, c i • ∑ j, a i j • w j := by
        unfold famLinComb; refine Finset.sum_congr rfl fun i _ => ?_; rw [ha i]; rfl   -- `u_i` の表示
    _ = ∑ i, ∑ j, c i • (a i j • w j) := by simp only [Finset.smul_sum]               -- `finite_sum_of_scalar_multiples`
    _ = ∑ i, ∑ j, (c i * a i j) • w j := by simp only [mul_smul]                      -- `scalar_multiple_is_associative`
    _ = ∑ j, ∑ i, (c i * a i j) • w j := Finset.sum_comm                               -- `finite_double_sum_of_matrices_interchange`
    _ = ∑ j, (∑ i, c i * a i j) • w j := by simp only [Finset.sum_smul]               -- `finite_sum_of_scalar_multiples_of_one_matrix`
    _ = ∑ j, (0 : K) • w j := by simp only [hc]                                        -- `c` の取り方
    _ = 0 := by simp only [zero_smul, Finset.sum_const_zero]                            -- `zero_scalar_multiple_is_zero_matrix`・`finite_sum_of_zero_matrices`

/-- **`extending_independent_family_by_element_outside_span`**: `u_{p+1} := x`（`Fin.snoc`）。 -/
theorem extending_independent_family_by_element_outside_span {p : ℕ} {u : Fin p → V} {x : V}
    (hu : FamLinIndep K u) (hx : ¬ FamIsLinComb K x u) :
    FamLinIndep K (Fin.snoc (α := fun _ => V) u x) := by
  intro c hc
  rw [linear_combination_splits_off_last_term] at hc               -- `linear_combination_splits_off_last_term`
  simp only [Fin.snoc_castSucc, Fin.snoc_last] at hc
  set L := famLinComb (fun t => c t.castSucc) u with hL
  have hneg : c (Fin.last p) • x = -L := eq_neg_of_add_eq_zero_left (by rw [add_comm]; exact hc)
    -- `matrix_sum_is_commutative`・`matrix_equals_negation_if_sum_is_zero`
  -- Step 1: `c_{p+1} = 0`
  have hlast : c (Fin.last p) = 0 := by
    by_contra hne
    apply hx
    set β := (c (Fin.last p))⁻¹
    refine ⟨fun t => -β * c t.castSucc, ?_⟩
    calc x = (1 : K) • x := (one_smul K x).symm                    -- `scalar_multiple_by_one`
      _ = (β * c (Fin.last p)) • x := by rw [inv_mul_cancel₀ hne] -- `β c_{p+1} = 1`
      _ = β • (c (Fin.last p) • x) := mul_smul _ _ _              -- `scalar_multiple_is_associative`
      _ = β • (-L) := by rw [hneg]
      _ = (-β) • L := by rw [smul_neg, neg_smul]                   -- `negation_is_scalar_multiple_by_minus_one`・`complex_times_negation_is_negation_of_product_in_cc`
      _ = famLinComb (fun t => -β * c t.castSucc) u := by
        rw [hL]; unfold famLinComb
        rw [Finset.smul_sum]                                       -- `finite_sum_of_scalar_multiples`
        exact Finset.sum_congr rfl fun t _ => (mul_smul _ _ _).symm -- `scalar_multiple_is_associative`
  -- Step 2: `t ≤ p` の係数
  have hL0 : L = 0 := by rw [hlast, zero_smul, add_zero] at hc; exact hc
  intro t
  refine Fin.lastCases ?_ (fun t => ?_) t
  · exact hlast
  · exact hu _ hL0 t

/-- **`subspace_has_basis`**: 全体を張る有限族 `w : Fin N → V` があれば、`U` は元の個数 `N` 以下の基底を持つ。
`U` が部分空間であることは使わない（冒頭の「何が効いているか」）。 -/
theorem subspace_has_basis {N : ℕ} (w : Fin N → V) (hw : ∀ A, FamIsLinComb K A w) (U : Set V) :
    ∃ p, p ≤ N ∧ ∃ u : Fin p → V, FamIsBasis K U u := by
  classical
  let S : ℕ → Prop := fun p => ∃ u : Fin p → V, (∀ t, u t ∈ U) ∧ FamLinIndep K u
  -- Step 1: `0 ∈ 𝒮`
  have h0 : S 0 := ⟨Fin.elim0, fun t => t.elim0, fun _ _ t => t.elim0⟩
  -- Step 2: `p ∈ 𝒮 ⇒ p ≤ N`
  have hle : ∀ p, S p → p ≤ N := fun p ⟨u, _, hind⟩ =>
    linearly_independent_family_is_no_longer_than_spanning_family u w (fun i => hw (u i)) hind
  -- Step 3: 最大元 `p₀`
  set p₀ := Nat.findGreatest S N
  obtain ⟨u, huU, hind⟩ : S p₀ := Nat.findGreatest_spec (Nat.zero_le N) h0
  refine ⟨p₀, Nat.findGreatest_le N, u, ⟨huU, fun x hxU => ?_⟩, hind⟩
  by_contra hx
  have hS : S (p₀ + 1) :=
    ⟨Fin.snoc (α := fun _ => V) u x, fun t => Fin.lastCases (by simpa using hxU) (fun t => by simpa using huU t) t,
      extending_independent_family_by_element_outside_span hind hx⟩
  exact Nat.findGreatest_is_greatest (Nat.lt_succ_self p₀) (hle _ hS) hS

/-- **`bases_of_subspace_have_same_number_of_elements`**。 -/
theorem bases_of_subspace_have_same_number_of_elements {U : Set V} {p q : ℕ} {u : Fin p → V} {w : Fin q → V}
    (hu : FamIsBasis K U u) (hw : FamIsBasis K U w) : p = q := by
  -- Step 2 の向き: `u` は `w` の線型結合で線型独立なので `p ≤ q`
  have h1 : p ≤ q :=
    linearly_independent_family_is_no_longer_than_spanning_family u w (fun s => hw.1.2 _ (hu.1.1 s)) hu.2
  have h2 : q ≤ p :=
    linearly_independent_family_is_no_longer_than_spanning_family w u (fun s => hu.1.2 _ (hw.1.1 s)) hw.2
  exact le_antisymm h1 h2

/-- `def_dimension` の well-definedness: 基底の元の個数は `famDim` に等しい。 -/
theorem famDim_eq_of_isBasis {U : Set V} (h : ∃ p : ℕ, ∃ u : Fin p → V, FamIsBasis K U u)
    {p : ℕ} {u : Fin p → V} (hu : FamIsBasis K U u) : famDim K U h = p :=
  bases_of_subspace_have_same_number_of_elements (Classical.choose_spec h).choose_spec hu

/-- **`linearly_independent_family_of_n_vectors_is_basis`**: 全体を張る `n` 個の族 `e` があるとき、`n` 個の線型独立な族は基底。 -/
theorem linearly_independent_family_of_n_vectors_is_basis {n : ℕ} (e : Fin n → V)
    (he : ∀ A, FamIsLinComb K A e) (v : Fin n → V) (hv : FamLinIndep K v) :
    FamIsBasis K Set.univ v := by
  refine ⟨⟨fun _ => trivial, fun x _ => ?_⟩, hv⟩
  by_contra hx
  have := linearly_independent_family_is_no_longer_than_spanning_family (Fin.snoc (α := fun _ => V) v x) e
    (fun i => he _) (extending_independent_family_by_element_outside_span hv hx)
  omega

end DivisionRingLemmas

section NontrivialDivisionRing

variable {K : Type*} {V : Type*} [DivisionRing K] [AddCommGroup V] [Module K V]

/-- **`one_dimensional_subspace_is_multiples_of_nonzero_element`**。 -/
theorem one_dimensional_subspace_is_multiples_of_nonzero_element {U : Set V} (hU : IsSubspaceSet K U)
    (h : ∃ p : ℕ, ∃ u : Fin p → V, FamIsBasis K U u) (hdim : famDim K U h = 1) :
    ∃ q ∈ U, q ≠ 0 ∧ U = {A | ∃ c : K, A = c • q} := by
  obtain ⟨u, hu⟩ := Classical.choose_spec h
  have hcard : Classical.choose h = 1 := hdim
  revert u
  rw [hcard]
  intro u hu
  refine ⟨u 0, hu.1.1 0, linearly_independent_family_has_no_zero_element hu.2 0, Set.ext fun A => ⟨fun hA => ?_, ?_⟩⟩
  · obtain ⟨c, hc⟩ := hu.1.2 A hA
    exact ⟨c 0, by rw [hc]; simp [famLinComb]⟩
  · rintro ⟨c, rfl⟩
    exact hU.smul_mem c (hu.1.1 0)

end NontrivialDivisionRing

section RingLemmas

variable {K : Type*} {V : Type*} [Ring K] [AddCommGroup V] [Module K V]

/-- **`concatenated_bases_of_direct_sum_form_basis`**（つないだ族は `Fin.append u w`）。 -/
theorem concatenated_bases_of_direct_sum_form_basis {Vs U W : Set V}
    (hU : IsSubspaceSet K U) (hW : IsSubspaceSet K W) (hds : IsDirectSumOfTwo Vs U W)
    {r s : ℕ} {u : Fin r → V} {w : Fin s → V} (hu : FamIsBasis K U u) (hw : FamIsBasis K W w) :
    FamIsBasis K Vs (Fin.append u w) := by
  obtain ⟨hUV, hWV, hsum, hcap⟩ := hds
  refine ⟨⟨fun t => ?_, fun x hx => ?_⟩, fun c hc => ?_⟩
  · refine Fin.addCases (fun t => ?_) (fun t => ?_) t
    · rw [Fin.append_left]; exact hUV (hu.1.1 t)
    · rw [Fin.append_right]; exact hWV (hw.1.1 t)
  · -- Step 1（張る）
    obtain ⟨y, hy, z, hz, rfl⟩ := hsum x hx
    obtain ⟨a, rfl⟩ := hu.1.2 y hy
    obtain ⟨b, rfl⟩ := hw.1.2 z hz
    refine ⟨Fin.append a b, ?_⟩
    rw [linear_combination_splits_into_two_blocks]                -- `linear_combination_splits_into_two_blocks`
    simp only [Fin.append_left, Fin.append_right]                 -- `c_t`・`v_t` の置き方
  · -- Step 2（線型独立）
    rw [linear_combination_splits_into_two_blocks] at hc
    simp only [Fin.append_left, Fin.append_right] at hc
    set y := famLinComb (fun t => c (Fin.castAdd s t)) u
    set z := famLinComb (fun t => c (Fin.natAdd r t)) w
    have hyU : y ∈ U := linear_combination_of_subspace_elements_stays_in_subspace hU _ _ hu.1.1
    have hzW : z ∈ W := linear_combination_of_subspace_elements_stays_in_subspace hW _ _ hw.1.1
    have hyneg : y = (-1 : K) • z := by
      rw [neg_one_smul]; exact eq_neg_of_add_eq_zero_left hc       -- `matrix_equals_negation_if_sum_is_zero`・`negation_is_scalar_multiple_by_minus_one`
    have hy0 : y = 0 := hcap y hyU (hyneg ▸ hW.smul_mem (-1) hzW)   -- `def_subspace` (iii)・`def_direct_sum_of_two_subspaces` (ii)
    have hz0 : z = 0 := by rw [hy0, zero_add] at hc; exact hc
    intro t
    refine Fin.addCases (fun t => ?_) (fun t => ?_) t
    · exact hu.2 _ hy0 t
    · exact hw.2 _ hz0 t

end RingLemmas

section MatrixUnits

variable {K : Type*} [Semiring K] {ι κ : Type*} [Fintype ι] [Fintype κ] [DecidableEq ι] [DecidableEq κ]

/-- 人手の行列単位 `(E_{ij})_{kl} := δ_{ik} δ_{jl}`。 -/
def matrixUnitOf (i : ι) (j : κ) : Matrix ι κ K :=
  Matrix.of fun k l => (if i = k then (1 : K) else 0) * (if j = l then (1 : K) else 0)

/-- `matrix_units_form_basis` の Step 1 の式 (C): `(Σ_t b_t F_t)_{kl} = b_{π^{-1}(k,l)}`。 -/
theorem matrixUnit_linComb_apply {N : ℕ} (π : Fin N ≃ ι × κ) (b : Fin N → K) (k : ι) (l : κ) :
    famLinComb b (fun t => matrixUnitOf (K := K) (π t).1 (π t).2) k l = b (π.symm (k, l)) := by
  unfold famLinComb
  rw [Matrix.sum_apply]                                            -- `finite_sum_of_matrices_entrywise`
  simp only [Matrix.smul_apply, matrixUnitOf, Matrix.of_apply, smul_eq_mul]  -- `def_matrix_scalar_multiple`
  rw [Finset.sum_eq_single (π.symm (k, l))]                       -- `finite_sum_with_single_nonzero_term`
  · simp                                                           -- `δ_{kk} δ_{ll} = 1`
  · intro t _ ht
    have hne : π t ≠ (k, l) := fun h => ht (by rw [← h, Equiv.symm_apply_apply])
    by_cases h1 : (π t).1 = k
    · have h2 : (π t).2 ≠ l := fun h2 => hne (Prod.ext h1 h2)
      simp [h2]                                                    -- `complex_times_zero_is_zero`
    · simp [h1]                                                    -- `complex_zero_times_is_zero`
  · intro h; exact absurd (Finset.mem_univ _) h

/-- **`matrix_units_form_basis`**: どの全単射 `π : Fin N ≃ ι × κ` で並べても、行列単位の族は行列全体の基底。 -/
theorem matrix_units_form_basis {N : ℕ} (π : Fin N ≃ ι × κ) :
    FamIsBasis K (Set.univ : Set (Matrix ι κ K)) (fun t => matrixUnitOf (K := K) (π t).1 (π t).2) := by
  refine ⟨⟨fun _ => trivial, fun A _ => ⟨fun t => A (π t).1 (π t).2, ?_⟩⟩, fun c hc t₀ => ?_⟩
  · -- Step 2（張る）
    ext k l
    rw [matrixUnit_linComb_apply]
    simp
  · -- Step 3（線型独立）
    have := matrixUnit_linComb_apply π c (π t₀).1 (π t₀).2
    rw [hc] at this
    simpa using this.symm

end MatrixUnits

section ColumnsInverse

variable {K : Type*} [CommRing K]

/-- **`matrix_of_basis_columns_has_inverse`**: 列ベクトル `v_j : Mat(n,1)` を並べた `P` は両側逆行列を持つ。 -/
theorem matrix_of_basis_columns_has_inverse {n : ℕ} (v : Fin n → Matrix (Fin n) (Fin 1) K)
    (hv : FamIsBasis K Set.univ v) :
    ∃ P' : Matrix (Fin n) (Fin n) K,
      P' * Matrix.of (fun i j => v j i 0) = 1 ∧ Matrix.of (fun i j => v j i 0) * P' = 1 := by
  set P : Matrix (Fin n) (Fin n) K := Matrix.of fun i j => v j i 0 with hP
  -- 準備 (L): `P y = Σ_j y_j v_j`（`y` の第 `j` 成分は `y j 0`）
  have hL : ∀ y : Matrix (Fin n) (Fin 1) K, P * y = famLinComb (fun j => y j 0) v := by
    intro y; ext i z
    have hz : z = 0 := Subsingleton.elim _ _
    subst hz
    rw [Matrix.mul_apply]                                          -- `mat_mult`
    unfold famLinComb
    rw [Matrix.sum_apply]                                          -- `finite_sum_of_matrices_entrywise`
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [hP, Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, mul_comm]  -- `mat_columnwise`・可換律・`def_matrix_scalar_multiple`
  -- 標準基底 `e_k`
  let e : Fin n → Matrix (Fin n) (Fin 1) K := fun k => Matrix.of fun i _ => if k = i then 1 else 0
  -- Step 1: `PC = I`
  choose cc hcc using fun k => hv.1.2 (e k) trivial
  let C : Matrix (Fin n) (Fin n) K := Matrix.of fun j k => cc k j
  have hPC : P * C = 1 := by
    ext i k
    have h := congrArg (fun X : Matrix (Fin n) (Fin 1) K => X i 0)
      (hL (Matrix.of fun j _ => cc k j))
    simp only [Matrix.mul_apply, Matrix.of_apply] at h
    rw [Matrix.mul_apply]
    simp only [C, Matrix.of_apply]
    rw [h, ← hcc k]                                                -- (L)・`c_{jk}` の取り方
    simp [e, Matrix.one_apply, eq_comm]                            -- `e_k` の定め方・`def_identity_matrix`
  -- Step 2: `CP = I`
  have hCP : C * P = 1 := by
    ext j l
    let y : Matrix (Fin n) (Fin 1) K := (C * P) * e l - e l
    have hPy : P * y = 0 := by
      simp only [y, Matrix.mul_sub, ← Matrix.mul_assoc, hPC, Matrix.one_mul, sub_self]
        -- `mat_mult_vector_difference`・`mat_mult_associative`・Step 1・`identity_matrix_is_left_unit_of_mat_mult`
    have hy : ∀ t, y t 0 = 0 := hv.2 _ (by rw [← hL]; exact hPy)   -- (L) と線型独立性
    -- `(CP)e_l` の第 `j` 成分は `(CP)_{jl}`（`finite_sum_with_single_nonzero_term`）
    have hcol : ((C * P) * e l) j 0 = (C * P) j l := by
      rw [Matrix.mul_apply]
      simp only [e, Matrix.of_apply, mul_ite, mul_one, mul_zero]
      rw [Finset.sum_ite_eq]
      simp
    have h := hy j
    simp only [y, Matrix.sub_apply, hcol] at h
    rw [sub_eq_zero] at h
    rw [h]
    simp [e, Matrix.one_apply, eq_comm]                            -- `e_l` の定め方・`def_identity_matrix`
  exact ⟨C, hCP, hPC⟩

end ColumnsInverse

section LinearMapSubspaces

variable {K : Type*} {V W : Type*} [Semiring K] [AddCommMonoid V] [AddCommMonoid W] [Module K V] [Module K W]

/-- **`image_of_matrix_is_subspace`**: 人手の `x ↦ Qx` を線型写像 `f` に置き換えたもの（零・和・スカラー倍を保つことだけを使う）。 -/
theorem image_of_matrix_is_subspace (f : V →ₗ[K] W) : IsSubspaceSet K {y : W | ∃ x, y = f x} where
  zero_mem := ⟨0, (map_zero f).symm⟩                               -- `zero_matrix_is_right_zero_of_mat_mult`
  add_mem := by
    rintro _ _ ⟨x, rfl⟩ ⟨y, rfl⟩
    exact ⟨x + y, (map_add f x y).symm⟩                           -- `mat_mult_distributes_over_sum_in_right_factor`
  smul_mem := by
    rintro a _ ⟨x, rfl⟩
    exact ⟨a • x, (map_smul f a x).symm⟩                          -- `scalar_multiple_factors_out_of_right_factor`

/-- **`kernel_of_matrix_is_subspace`**。 -/
theorem kernel_of_matrix_is_subspace (f : V →ₗ[K] W) : IsSubspaceSet K {x : V | f x = 0} where
  zero_mem := map_zero f                                           -- `zero_matrix_is_right_zero_of_mat_mult`
  add_mem := by
    intro x y hx hy
    show f (x + y) = 0
    rw [map_add, hx, hy, add_zero]                                 -- `mat_mult_distributes_over_sum_in_right_factor`・`matrix_plus_zero_matrix`
  smul_mem := by
    intro a x hx
    show f (a • x) = 0
    rw [map_smul, hx, smul_zero]                                   -- `scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_of_zero_matrix`

end LinearMapSubspaces

section EigenSubspace

variable {K : Type*} {V : Type*} [CommSemiring K] [AddCommMonoid V] [Module K V]

/-- **`eigenvalue_equation_solution_set_is_subspace`**。(iii) の `aλ = λa` で**乗法の可換性が要る**
（`λ` が中心にない非可換環では `A(ax) = λ(ax)` が崩れる）。 -/
theorem eigenvalue_equation_solution_set_is_subspace (f : V →ₗ[K] V) (lam : K) :
    IsSubspaceSet K {x : V | f x = lam • x} where
  zero_mem := by
    show f 0 = lam • 0
    rw [map_zero, smul_zero]                                       -- `zero_matrix_is_right_zero_of_mat_mult`・`scalar_multiple_of_zero_matrix`
  add_mem := by
    intro x y hx hy
    show f (x + y) = lam • (x + y)
    rw [map_add, hx, hy, smul_add]                                 -- 右の因子の和への分配・`scalar_multiple_distributes_over_matrix_sum`
  smul_mem := by
    intro a x hx
    show f (a • x) = lam • (a • x)
    rw [map_smul, hx,                                              -- `scalar_multiple_factors_out_of_right_factor`
      smul_smul, mul_comm, ← smul_smul]                            -- `scalar_multiple_is_associative`・`complex_multiplication_is_commutative`

end EigenSubspace

end Ising2D.NecSuf
