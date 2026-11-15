/-
章「同型の証明」の節「クリフォード代数の中の大域的な等式」の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                                              このファイル
  claim_annihilation_generator_commutes_with_other_number_reversed_pair                     annihilation_commute_reversedPair
  claim_vacuum_factors_with_different_numbers_commute                                       vacuumFactor_commute
  claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator                vacuumFactor_mul_annihilation
  claim_creation_generator_times_vacuum_factor_is_creation_generator                        creation_mul_vacuumFactor
  claim_vacuum_factor_is_idempotent                                                         vacuumFactor_mul_self
  def_initial_ordered_product_of_selected_creation_generators                               initialCreationProduct（a†_{U,≤m}）
  claim_initial_ordered_creation_product_splits_off_last_number                             initialCreationProduct_succ
  claim_initial_ordered_creation_product_up_to_last_number_is_whole_product                 initialCreationProduct_last
  def_initial_part_of_vacuum_element                                                        initialVacuumPart（P_{≤m}）
  claim_initial_part_of_vacuum_element_splits_off_last_factor                               initialVacuumPart_succ
  claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element                  initialVacuumPart_last
  def_vacuum_sandwich_of_initial_parts                                                      vacuumSandwich（Q^{T,U}_m）
  claim_vacuum_sandwich_up_to_last_number_is_vacuum_element_sandwich                        vacuumSandwich_last
  claim_vacuum_factor_commutes_with_lower_initial_parts                                     vacuumFactor_commute_initialParts
  claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset                  vacuumSandwich_succ_of_exactlyOne
  claim_vacuum_sandwich_when_last_number_is_in_neither_subset                               vacuumSandwich_succ_of_neither
  claim_vacuum_sandwich_when_last_number_is_in_both_subsets                                 vacuumSandwich_succ_of_both
  claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part                    vacuumSandwich_of_agree
  claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero                                vacuumSandwich_of_disagree
  claim_vacuum_element_sandwich_of_annihilation_and_creation_products                       vacuumElement_sandwich
  def_selected_number_factor_of_split_clifford_algebra                                      selectedNumberFactor（u^S_i）
  claim_creation_vacuum_annihilation_factor_of_one_number                                   creation_vacuum_annihilation_factor
  claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors  initialParts_product_eq_orderedProduct
  claim_sum_over_subsets_of_selected_products_is_product_of_sums                            ComplexAlgebra.linearCombination_selectedProducts_eq
  claim_decomposition_of_unity_in_split_clifford_algebra                                    decomposition_of_unity

表し方:
- 宣言は `LocalIdentities.lean` と同じく名前空間 `Clifford.SplitData` に置く。部分集合の和の主張だけは、
  一般の ℂ-代数 B についての主張なので名前空間 `ComplexAlgebra` に置く。
- 本文の m ∈ {1,…,M} の段（m - 1 からの段）は、Lean では m + 1（m + 1 ≤ M）と書く。
- 本文の「族を {1,…,m} に制限した番号順の積」は、Lean では同じ族の `ComplexAlgebra.orderedProduct A m` であり、
  本文 claim_partial_product_is_ordered_product_of_restricted_family が与える Π_m との一致は定義どおりの等式（rfl）になる。
  したがって a†_{U,≤m}・P_{≤m} の分解の主張の Π_m を経る行は `rfl` である。
- 部分集合の和の主張の v^S_i は、S ∈ P_M の ℕ の部分集合としての中身 S.1 だけで決まるので、ℕ の部分集合 S について
  定める（`selectedFactorBySubset`）。本文の P_m ⊆ P_M は、P_m・P_M の元をどちらも ℕ の部分集合 `.1` として読むことに当たる。
  本文の前提 M と m ≤ M は、主張の文に残す（帰納法の仮定へ m ≤ M を渡すだけで、式変形の行には現れない）。
- 部分集合の上のクロネッカーのデルタ δ_{T,U} は、P_M の等号の判定に Classical を使う。
- 本文の「T ≠ U なら t ∈ T と t ∈ U が同値でない t がある」は、`ComplexMatrixAlgebra.PowerSet.ext` の対偶で書く。

必要十分版は `NecSuf/Isomorphism/GlobalIdentities/GlobalIdentities.lean`、導出版は `GlobalIdentitiesFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.LocalIdentities.LocalIdentities
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet

namespace CliffordMatrixIsomorphism.ComplexAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra

universe v

variable {B : Type v}

open Classical in
/-- 本文 `claim_sum_over_subsets_of_selected_products_is_product_of_sums` の v^S_i：i ∈ S なら g_i、i ∉ S なら h_i。 -/
noncomputable def selectedFactorBySubset (g h : ℕ → B) (S : Set ℕ) (i : ℕ) : B :=
  if i ∈ S then g i else h i

theorem selectedFactorBySubset_of_mem {g h : ℕ → B} {S : Set ℕ} {i : ℕ} (hi : i ∈ S) :
    selectedFactorBySubset g h S i = g i := if_pos hi

theorem selectedFactorBySubset_of_not_mem {g h : ℕ → B} {S : Set ℕ} {i : ℕ} (hi : i ∉ S) :
    selectedFactorBySubset g h S i = h i := if_neg hi

/-- 本文 `claim_sum_over_subsets_of_selected_products_is_product_of_sums`：
Σ_{k=1}^{2^m} 1_ℂ ∗_B ∏_{B,i=1}^{m} v^{e_m(k)}_i = ∏_{B,i=1}^{m} (h_i +_B g_i)（m ∈ {0,…,M}）。
F_m(S) := ∏_{B,i=1}^{m} v^S_i、Π_m := ∏_{B,i=1}^{m} (h_i +_B g_i) と置き、m の帰納法で示す。 -/
theorem linearCombination_selectedProducts_eq (SB : ComplexAlgebra B) (M : ℕ) (g h : ℕ → B) :
    ∀ m : ℕ, m ≤ M →
      linearCombination SB.toComplexVectorSpace (twoPower m) (fun _ => 1)
          (numberedFamily (binaryNumbering m) (fun S => orderedProduct SB m (selectedFactorBySubset g h S.1)) SB.zero)
        = orderedProduct SB m (fun i => SB.add (h i) (g i)) := by
  let S := SB.toComplexVectorSpace
  let F : ℕ → Set ℕ → B := fun m T => orderedProduct SB m (selectedFactorBySubset g h T)
  let Pr : ℕ → B := fun m => orderedProduct SB m (fun i => SB.add (h i) (g i))
  intro m
  induction m with
  | zero =>
    intro _
    -- m = 0：2^0 = 1、F_0(e_0(1)) = 1_B
    calc linearCombination S (twoPower 0) (fun _ => 1)
          (numberedFamily (binaryNumbering 0) (fun T => F 0 T.1) SB.zero)
        = SB.add SB.zero (SB.smul 1 (numberedFamily (binaryNumbering 0) (fun T => F 0 T.1) SB.zero 1)) := rfl
      _ = SB.add SB.zero (SB.smul 1 SB.one) := by
          rw [numberedFamily_of_le (binaryNumbering 0) (fun T => F 0 T.1) SB.zero 1 le_rfl le_rfl]
          rfl
      _ = SB.add SB.zero SB.one := by rw [SB.one_smul SB.one]
      _ = SB.add SB.one SB.zero := SB.add_comm _ _
      _ = SB.one := SB.add_zero SB.one
      _ = Pr 0 := rfl
  | succ m ih =>
    intro hm
    let n := twoPower m
    let X : ℕ → B := numberedFamily (binaryNumbering (m + 1)) (fun T => F (m + 1) T.1) SB.zero
    let Y : ℕ → B := numberedFamily (binaryNumbering m) (fun T => F m T.1) SB.zero
    -- （イ）k ∈ {1,…,n} なら F_{m+1}(e_{m+1}(k)) = F_m(e_m(k)) ·_B h_{m+1}
    have hfirst : ∀ k : ℕ, 1 ≤ k → k ≤ n → SB.smul 1 (X k) = SB.smul 1 (SB.mul (Y k) (h (m + 1))) := by
      intro k hk1 hkn
      have hk2 : k ≤ twoPower (m + 1) := by rw [twoPower_succ]; omega
      let kk : Idx (twoPower (m + 1)) := ⟨k, hk1, hk2⟩
      have hnot : m + 1 ∉ (binaryNumbering (m + 1) kk).1 := not_mem_binaryNumbering_succ_of_le m kk hkn
      have heq : (binaryNumbering (m + 1) kk).1 = (binaryNumbering m ⟨k, hk1, hkn⟩).1 :=
        binaryNumbering_succ_of_le m kk hkn
      have hX : X k = F (m + 1) (binaryNumbering (m + 1) kk).1 :=
        numberedFamily_of_le (binaryNumbering (m + 1)) (fun T => F (m + 1) T.1) SB.zero k hk1 hk2
      have hY : Y k = F m (binaryNumbering m ⟨k, hk1, hkn⟩).1 :=
        numberedFamily_of_le (binaryNumbering m) (fun T => F m T.1) SB.zero k hk1 hkn
      have hstep : F (m + 1) (binaryNumbering (m + 1) kk).1 = SB.mul (Y k) (h (m + 1)) := calc
        F (m + 1) (binaryNumbering (m + 1) kk).1
            = SB.mul (F m (binaryNumbering (m + 1) kk).1)
                (selectedFactorBySubset g h (binaryNumbering (m + 1) kk).1 (m + 1)) := rfl
        _ = SB.mul (F m (binaryNumbering (m + 1) kk).1) (h (m + 1)) := by
            rw [selectedFactorBySubset_of_not_mem hnot]
        _ = SB.mul (F m (binaryNumbering m ⟨k, hk1, hkn⟩).1) (h (m + 1)) := by rw [heq]
        _ = SB.mul (Y k) (h (m + 1)) := by rw [hY]
      rw [hX, hstep]
    -- （ロ）j ∈ {1,…,n} なら F_{m+1}(e_{m+1}(n+j)) = F_m(e_m(j)) ·_B g_{m+1}
    have hsecond : ∀ j : ℕ, 1 ≤ j → j ≤ n →
        SB.smul 1 (X (n + j)) = SB.smul 1 (SB.mul (Y j) (g (m + 1))) := by
      intro j hj1 hjn
      have hk2 : n + j ≤ twoPower (m + 1) := by rw [twoPower_succ]; omega
      let kk : Idx (twoPower (m + 1)) := ⟨n + j, by omega, hk2⟩
      have hgt : ¬ kk.1 ≤ twoPower m := by show ¬ n + j ≤ n; omega
      have hidx : (⟨kk.1 - twoPower m, sub_twoPower_mem kk hgt⟩ : Idx (twoPower m)) = ⟨j, hj1, hjn⟩ :=
        Subtype.ext (by show n + j - n = j; omega)
      have hmem : m + 1 ∈ (binaryNumbering (m + 1) kk).1 := mem_binaryNumbering_succ_of_gt m kk hgt
      have hiff : ∀ t : ℕ, t ≤ m → (t ∈ (binaryNumbering (m + 1) kk).1 ↔ t ∈ (binaryNumbering m ⟨j, hj1, hjn⟩).1) := by
        intro t ht
        rw [← hidx]
        exact mem_binaryNumbering_succ_iff_of_gt m kk hgt t ht
      have hX : X (n + j) = F (m + 1) (binaryNumbering (m + 1) kk).1 :=
        numberedFamily_of_le (binaryNumbering (m + 1)) (fun T => F (m + 1) T.1) SB.zero (n + j) (by omega) hk2
      have hY : Y j = F m (binaryNumbering m ⟨j, hj1, hjn⟩).1 :=
        numberedFamily_of_le (binaryNumbering m) (fun T => F m T.1) SB.zero j hj1 hjn
      -- 各 i ∈ {1,…,m} で v^{e_{m+1}(n+j)}_i = v^{e_m(j)}_i
      have hv : ∀ i : ℕ, 1 ≤ i → i ≤ m →
          selectedFactorBySubset g h (binaryNumbering (m + 1) kk).1 i
            = selectedFactorBySubset g h (binaryNumbering m ⟨j, hj1, hjn⟩).1 i := by
        intro i _ him
        by_cases hi : i ∈ (binaryNumbering m ⟨j, hj1, hjn⟩).1
        · rw [selectedFactorBySubset_of_mem ((hiff i him).2 hi), selectedFactorBySubset_of_mem hi]
        · rw [selectedFactorBySubset_of_not_mem (fun h' => hi ((hiff i him).1 h')),
            selectedFactorBySubset_of_not_mem hi]
      have hstep : F (m + 1) (binaryNumbering (m + 1) kk).1 = SB.mul (Y j) (g (m + 1)) := calc
        F (m + 1) (binaryNumbering (m + 1) kk).1
            = SB.mul (F m (binaryNumbering (m + 1) kk).1)
                (selectedFactorBySubset g h (binaryNumbering (m + 1) kk).1 (m + 1)) := rfl
        _ = SB.mul (F m (binaryNumbering (m + 1) kk).1) (g (m + 1)) := by
            rw [selectedFactorBySubset_of_mem hmem]
        _ = SB.mul (F m (binaryNumbering m ⟨j, hj1, hjn⟩).1) (g (m + 1)) := by
            rw [show F m (binaryNumbering (m + 1) kk).1 = F m (binaryNumbering m ⟨j, hj1, hjn⟩).1 from
              orderedProduct_congr SB m _ _ hv]
        _ = SB.mul (Y j) (g (m + 1)) := by rw [hY]
      rw [hX, hstep]
    -- （ハ）右から r を掛ける写像は線型写像なので、Σ 1 ∗ (X_k · r) = (Σ 1 ∗ X_k) · r
    have hright : ∀ r : B,
        linearCombination S n (fun _ => 1) (fun k => SB.mul (Y k) r)
          = SB.mul (linearCombination S n (fun _ => 1) Y) r := fun r =>
      ((rightMul_isLinearMap SB r).map_linearCombination n (fun _ => 1) Y).symm
    calc linearCombination S (twoPower (m + 1)) (fun _ => 1) X
        = linearCombination S (n + n) (fun _ => 1) X := by rw [twoPower_succ m]
      _ = SB.add (linearCombination S n (fun _ => 1) X)
            (linearCombination S n (fun _ => 1) (fun j => X (n + j))) :=
          linearCombination_split S n n X (fun _ => 1)
      _ = SB.add (linearCombination S n (fun _ => 1) (fun k => SB.mul (Y k) (h (m + 1))))
            (linearCombination S n (fun _ => 1) (fun j => X (n + j))) := by
          rw [linearCombination_eq_of_terms_eq S n X (fun k => SB.mul (Y k) (h (m + 1))) _ _ hfirst]
      _ = SB.add (linearCombination S n (fun _ => 1) (fun k => SB.mul (Y k) (h (m + 1))))
            (linearCombination S n (fun _ => 1) (fun j => SB.mul (Y j) (g (m + 1)))) := by
          rw [linearCombination_eq_of_terms_eq S n (fun j => X (n + j)) (fun j => SB.mul (Y j) (g (m + 1))) _ _
            hsecond]
      _ = SB.add (SB.mul (linearCombination S n (fun _ => 1) Y) (h (m + 1)))
            (SB.mul (linearCombination S n (fun _ => 1) Y) (g (m + 1))) := by
          rw [hright (h (m + 1)), hright (g (m + 1))]
      _ = SB.add (SB.mul (Pr m) (h (m + 1))) (SB.mul (Pr m) (g (m + 1))) := by
          rw [show linearCombination S n (fun _ => 1) Y = Pr m from ih (by omega)]
      _ = SB.mul (Pr m) (SB.add (h (m + 1)) (g (m + 1))) := (SB.left_distrib _ _ _).symm
      _ = Pr (m + 1) := rfl

end CliffordMatrixIsomorphism.ComplexAlgebra

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### 消滅と生成の積の交換と冪等性 -/

/-- 本文 `claim_annihilation_generator_commutes_with_other_number_reversed_pair`：
i ≠ j なら a_i (a†_j a_j) = (a†_j a_j) a_i。 -/
theorem annihilation_commute_reversedPair {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M) (hij : i ≠ j) :
    D.space.cliffordAlgebra.mul (D.annihilation i) (D.space.cliffordAlgebra.mul (D.creation j) (D.annihilation j))
      = D.space.cliffordAlgebra.mul (D.space.cliffordAlgebra.mul (D.creation j) (D.annihilation j)) (D.annihilation i) := by
  let A := D.space.cliffordAlgebra
  -- 準備：a_i a†_j + a†_j a_i = 0_A
  have hprep : A.add (A.mul (D.annihilation i) (D.creation j)) (A.mul (D.creation j) (D.annihilation i))
      = A.zero := calc
    A.add (A.mul (D.annihilation i) (D.creation j)) (A.mul (D.creation j) (D.annihilation i))
        = A.smul (kroneckerDelta i j) A.one := D.annihilation_creation_anticommute i j hi.1 hi.2 hj.1 hj.2
    _ = A.smul 0 A.one := by rw [kroneckerDelta, if_neg hij]
    _ = A.zero := zero_smul_eq_zero A A.one
  calc A.mul (D.annihilation i) (A.mul (D.creation j) (D.annihilation j))
      = A.mul (A.mul (D.annihilation i) (D.creation j)) (D.annihilation j) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul (-1) (A.mul (D.creation j) (D.annihilation i))) (D.annihilation j) := by
        rw [mul_eq_neg_one_smul_swap A (D.annihilation i) (D.creation j) hprep]
    _ = A.smul (-1) (A.mul (A.mul (D.creation j) (D.annihilation i)) (D.annihilation j)) :=
        (A.smul_mul_left _ _ _).symm
    _ = A.smul (-1) (A.mul (D.creation j) (A.mul (D.annihilation i) (D.annihilation j))) := by
        rw [A.mul_assoc (D.creation j) (D.annihilation i) (D.annihilation j)]
    _ = A.smul (-1) (A.mul (D.creation j) (A.smul (-1) (A.mul (D.annihilation j) (D.annihilation i)))) := by
        rw [mul_eq_neg_one_smul_swap A (D.annihilation i) (D.annihilation j) (D.annihilation_anticommute i j)]
    _ = A.smul (-1) (A.smul (-1) (A.mul (D.creation j) (A.mul (D.annihilation j) (D.annihilation i)))) := by
        rw [← A.smul_mul_right (-1) (D.creation j) (A.mul (D.annihilation j) (D.annihilation i))]
    _ = A.smul ((-1) * (-1)) (A.mul (D.creation j) (A.mul (D.annihilation j) (D.annihilation i))) :=
        (A.smul_assoc _ _ _).symm
    _ = A.smul 1 (A.mul (D.creation j) (A.mul (D.annihilation j) (D.annihilation i))) := by
        rw [neg_one_mul_neg_one]
    _ = A.mul (D.creation j) (A.mul (D.annihilation j) (D.annihilation i)) := A.one_smul _
    _ = A.mul (A.mul (D.creation j) (D.annihilation j)) (D.annihilation i) := (A.mul_assoc _ _ _).symm

/-- 本文 `claim_vacuum_factors_with_different_numbers_commute`：i ≠ j なら x_i x_j = x_j x_i。 -/
theorem vacuumFactor_commute {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M) (hij : i ≠ j) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor i) (D.vacuumFactor j)
      = D.space.cliffordAlgebra.mul (D.vacuumFactor j) (D.vacuumFactor i) := by
  let A := D.space.cliffordAlgebra
  calc A.mul (D.vacuumFactor i) (D.vacuumFactor j)
      = A.mul (A.mul (D.annihilation i) (D.creation i)) (D.vacuumFactor j) := rfl
    _ = A.mul (D.annihilation i) (A.mul (D.creation i) (D.vacuumFactor j)) := A.mul_assoc _ _ _
    _ = A.mul (D.annihilation i) (A.mul (D.vacuumFactor j) (D.creation i)) := by
        rw [D.creation_commute_vacuumFactor hi hj hij]
    _ = A.mul (A.mul (D.annihilation i) (D.vacuumFactor j)) (D.creation i) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul (D.vacuumFactor j) (D.annihilation i)) (D.creation i) := by
        rw [D.annihilation_commute_vacuumFactor hi hj hij]
    _ = A.mul (D.vacuumFactor j) (A.mul (D.annihilation i) (D.creation i)) := A.mul_assoc _ _ _
    _ = A.mul (D.vacuumFactor j) (D.vacuumFactor i) := rfl

/-- 本文 `claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator`：x_i a_i = a_i。 -/
theorem vacuumFactor_mul_annihilation {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor i) (D.annihilation i) = D.annihilation i := by
  let A := D.space.cliffordAlgebra
  let a := D.annihilation i
  let c := D.creation i
  calc A.mul (D.vacuumFactor i) a
      = A.mul (A.mul a c) a := rfl
    _ = A.mul a (A.mul c a) := A.mul_assoc _ _ _
    _ = A.add (A.mul a (A.mul c a)) A.zero := (A.add_zero _).symm
    _ = A.add A.zero (A.mul a (A.mul c a)) := A.add_comm _ _
    _ = A.add (A.mul A.zero c) (A.mul a (A.mul c a)) := by rw [zero_mul_eq_zero A c]
    _ = A.add (A.mul (A.mul a a) c) (A.mul a (A.mul c a)) := by rw [D.annihilation_mul_self i]
    _ = A.add (A.mul a (A.mul a c)) (A.mul a (A.mul c a)) := by rw [A.mul_assoc a a c]
    _ = A.mul a (A.add (A.mul a c) (A.mul c a)) := (A.left_distrib _ _ _).symm
    _ = A.mul a (A.smul (kroneckerDelta i i) A.one) := by
        rw [D.annihilation_creation_anticommute i i hi.1 hi.2 hi.1 hi.2]
    _ = A.mul a (A.smul 1 A.one) := by rw [kroneckerDelta, if_pos rfl]
    _ = A.mul a A.one := by rw [A.one_smul A.one]
    _ = a := A.mul_one a

/-- 本文 `claim_creation_generator_times_vacuum_factor_is_creation_generator`：a†_i x_i = a†_i。 -/
theorem creation_mul_vacuumFactor {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.vacuumFactor i) = D.creation i := by
  let A := D.space.cliffordAlgebra
  let a := D.annihilation i
  let c := D.creation i
  calc A.mul c (D.vacuumFactor i)
      = A.mul c (A.mul a c) := rfl
    _ = A.mul (A.mul c a) c := (A.mul_assoc _ _ _).symm
    _ = A.add (A.mul (A.mul c a) c) A.zero := (A.add_zero _).symm
    _ = A.add A.zero (A.mul (A.mul c a) c) := A.add_comm _ _
    _ = A.add (A.mul a A.zero) (A.mul (A.mul c a) c) := by rw [mul_zero_eq_zero A a]
    _ = A.add (A.mul a (A.mul c c)) (A.mul (A.mul c a) c) := by rw [D.creation_mul_self i]
    _ = A.add (A.mul (A.mul a c) c) (A.mul (A.mul c a) c) := by rw [A.mul_assoc a c c]
    _ = A.mul (A.add (A.mul a c) (A.mul c a)) c := (A.right_distrib _ _ _).symm
    _ = A.mul (A.smul (kroneckerDelta i i) A.one) c := by
        rw [D.annihilation_creation_anticommute i i hi.1 hi.2 hi.1 hi.2]
    _ = A.mul (A.smul 1 A.one) c := by rw [kroneckerDelta, if_pos rfl]
    _ = A.mul A.one c := by rw [A.one_smul A.one]
    _ = c := A.one_mul c

/-- 本文 `claim_vacuum_factor_is_idempotent`：x_i x_i = x_i。 -/
theorem vacuumFactor_mul_self {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor i) (D.vacuumFactor i) = D.vacuumFactor i := by
  let A := D.space.cliffordAlgebra
  calc A.mul (D.vacuumFactor i) (D.vacuumFactor i)
      = A.mul (D.vacuumFactor i) (A.mul (D.annihilation i) (D.creation i)) := rfl
    _ = A.mul (A.mul (D.vacuumFactor i) (D.annihilation i)) (D.creation i) := (A.mul_assoc _ _ _).symm
    _ = A.mul (D.annihilation i) (D.creation i) := by rw [D.vacuumFactor_mul_annihilation hi]
    _ = D.vacuumFactor i := rfl

/-! ### 番号が m 以下の部分 -/

/-- 本文 `def_initial_ordered_product_of_selected_creation_generators`：a†_{U,≤m} := ∏_{A,t=1}^{m} y^U_t。 -/
def initialCreationProduct (U : PowerSet D.M) (m : ℕ) : D.space.Cl :=
  ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m (D.selectedCreationFactor U)

/-- 本文 `claim_initial_ordered_creation_product_splits_off_last_number`：
a†_{U,≤m} = a†_{U,≤m-1} ·_A y^U_m（本文の m を Lean では m + 1 と書く）。 -/
theorem initialCreationProduct_succ (U : PowerSet D.M) (m : ℕ) :
    D.initialCreationProduct U (m + 1)
      = D.space.cliffordAlgebra.mul (D.initialCreationProduct U m) (D.selectedCreationFactor U (m + 1)) :=
  calc D.initialCreationProduct U (m + 1)
      = ComplexAlgebra.orderedProduct D.space.cliffordAlgebra (m + 1) (D.selectedCreationFactor U) := rfl
    -- Π_{m+1} = Π_m ·_A y^U_{m+1}（def_ordered_product_in_algebra）
    _ = D.space.cliffordAlgebra.mul (ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m (D.selectedCreationFactor U))
          (D.selectedCreationFactor U (m + 1)) := rfl
    _ = D.space.cliffordAlgebra.mul (D.initialCreationProduct U m) (D.selectedCreationFactor U (m + 1)) := rfl

/-- 本文 `claim_initial_ordered_creation_product_up_to_last_number_is_whole_product`：a†_{U,≤M} = a†_U。 -/
theorem initialCreationProduct_last (U : PowerSet D.M) :
    D.initialCreationProduct U D.M = D.orderedCreationProduct U :=
  calc D.initialCreationProduct U D.M
      = ComplexAlgebra.orderedProduct D.space.cliffordAlgebra D.M (D.selectedCreationFactor U) := rfl
    _ = D.orderedCreationProduct U := rfl

/-- 本文 `def_initial_part_of_vacuum_element`：P_{≤m} := ∏_{A,i=1}^{m} x_i。 -/
def initialVacuumPart (m : ℕ) : D.space.Cl :=
  ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m D.vacuumFactor

/-- 本文 `claim_initial_part_of_vacuum_element_splits_off_last_factor`：P_{≤m} = P_{≤m-1} ·_A x_m
（本文の m を Lean では m + 1 と書く）。 -/
theorem initialVacuumPart_succ (m : ℕ) :
    D.initialVacuumPart (m + 1) = D.space.cliffordAlgebra.mul (D.initialVacuumPart m) (D.vacuumFactor (m + 1)) :=
  calc D.initialVacuumPart (m + 1)
      = ComplexAlgebra.orderedProduct D.space.cliffordAlgebra (m + 1) D.vacuumFactor := rfl
    -- Π_{m+1} = Π_m ·_A x_{m+1}（def_ordered_product_in_algebra）
    _ = D.space.cliffordAlgebra.mul (ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m D.vacuumFactor)
          (D.vacuumFactor (m + 1)) := rfl
    _ = D.space.cliffordAlgebra.mul (D.initialVacuumPart m) (D.vacuumFactor (m + 1)) := rfl

/-- 本文 `claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element`：P_{≤M} = P。 -/
theorem initialVacuumPart_last : D.initialVacuumPart D.M = D.vacuumElement :=
  calc D.initialVacuumPart D.M
      = ComplexAlgebra.orderedProduct D.space.cliffordAlgebra D.M D.vacuumFactor := rfl
    _ = D.vacuumElement := rfl

/-- 本文 `def_vacuum_sandwich_of_initial_parts`：Q^{T,U}_m := (P_{≤m} ·_A (a_{T,≤m} ·_A a†_{U,≤m})) ·_A P_{≤m}。 -/
def vacuumSandwich (T U : PowerSet D.M) (m : ℕ) : D.space.Cl :=
  D.space.cliffordAlgebra.mul
    (D.space.cliffordAlgebra.mul (D.initialVacuumPart m)
      (D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m)))
    (D.initialVacuumPart m)

/-- 本文 `claim_vacuum_sandwich_up_to_last_number_is_vacuum_element_sandwich`：Q^{T,U}_M = (P (a_T a†_U)) P。 -/
theorem vacuumSandwich_last (T U : PowerSet D.M) :
    D.vacuumSandwich T U D.M
      = D.space.cliffordAlgebra.mul
          (D.space.cliffordAlgebra.mul D.vacuumElement
            (D.space.cliffordAlgebra.mul (D.reverseOrderedAnnihilationProduct T) (D.orderedCreationProduct U)))
          D.vacuumElement := by
  let A := D.space.cliffordAlgebra
  calc D.vacuumSandwich T U D.M
      = A.mul (A.mul (D.initialVacuumPart D.M)
          (A.mul (D.initialReverseAnnihilationProduct T D.M) (D.initialCreationProduct U D.M)))
          (D.initialVacuumPart D.M) := rfl
    _ = A.mul (A.mul (D.initialVacuumPart D.M)
          (A.mul (D.reverseOrderedAnnihilationProduct T) (D.initialCreationProduct U D.M)))
          (D.initialVacuumPart D.M) := by rw [D.initialReverseAnnihilationProduct_last T]
    _ = A.mul (A.mul (D.initialVacuumPart D.M)
          (A.mul (D.reverseOrderedAnnihilationProduct T) (D.orderedCreationProduct U)))
          (D.initialVacuumPart D.M) := by rw [D.initialCreationProduct_last U]
    _ = A.mul (A.mul D.vacuumElement
          (A.mul (D.reverseOrderedAnnihilationProduct T) (D.orderedCreationProduct U)))
          D.vacuumElement := by rw [D.initialVacuumPart_last]

/-- 本文 `claim_vacuum_factor_commutes_with_lower_initial_parts`：
x_m (a_{T,≤m-1} a†_{U,≤m-1}) = (a_{T,≤m-1} a†_{U,≤m-1}) x_m（本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumFactor_commute_initialParts (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor (m + 1))
        (D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m))
      = D.space.cliffordAlgebra.mul
          (D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m))
          (D.vacuumFactor (m + 1)) := by
  let A := D.space.cliffordAlgebra
  let x := D.vacuumFactor (m + 1)
  let α := D.initialReverseAnnihilationProduct T m
  let κ := D.initialCreationProduct U m
  have hmM : 1 ≤ m + 1 ∧ m + 1 ≤ D.M := ⟨Nat.succ_pos m, hm⟩
  -- x_m は α の因子 z^T_{m-k}（k ∈ {1,…,m-1}）と交換する
  have hα : A.mul x α = A.mul α x := by
    apply commute_orderedProduct A x m (fun k => D.selectedAnnihilationFactor T (m + 1 - k))
    intro k hk1 hkm
    show A.mul x (D.selectedAnnihilationFactor T (m + 1 - k)) = A.mul (D.selectedAnnihilationFactor T (m + 1 - k)) x
    by_cases ht : m + 1 - k ∈ T.1
    · rw [D.selectedAnnihilationFactor_of_mem ht]
      exact (D.annihilation_commute_vacuumFactor ⟨by omega, by omega⟩ hmM (by omega)).symm
    · rw [D.selectedAnnihilationFactor_of_not_mem ht, A.mul_one x, A.one_mul x]
  -- x_m は κ の因子 y^U_t（t ∈ {1,…,m-1}）と交換する
  have hκ : A.mul x κ = A.mul κ x := by
    apply commute_orderedProduct A x m (D.selectedCreationFactor U)
    intro t ht1 htm
    by_cases ht : t ∈ U.1
    · rw [D.selectedCreationFactor_of_mem ht]
      exact (D.creation_commute_vacuumFactor ⟨ht1, by omega⟩ hmM (by omega)).symm
    · rw [D.selectedCreationFactor_of_not_mem ht, A.mul_one x, A.one_mul x]
  calc A.mul x (A.mul α κ)
      = A.mul (A.mul x α) κ := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul α x) κ := by rw [hα]
    _ = A.mul α (A.mul x κ) := A.mul_assoc _ _ _
    _ = A.mul α (A.mul κ x) := by rw [hκ]
    _ = A.mul (A.mul α κ) x := (A.mul_assoc _ _ _).symm

/-- 三つの場合の主張の証明が共通に置く準備（イ）：P_{≤m} = P' ·_A x と x ·_A P' = P' ·_A x
（P' := P_{≤m-1}、x := x_m。本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumFactor_commute_initialVacuumPart {m : ℕ} (hm : m + 1 ≤ D.M) :
    D.space.cliffordAlgebra.mul (D.vacuumFactor (m + 1)) (D.initialVacuumPart m)
      = D.space.cliffordAlgebra.mul (D.initialVacuumPart m) (D.vacuumFactor (m + 1)) := by
  apply commute_orderedProduct D.space.cliffordAlgebra (D.vacuumFactor (m + 1)) m D.vacuumFactor
  intro j hj1 hjm
  exact D.vacuumFactor_commute ⟨Nat.succ_pos m, hm⟩ ⟨hj1, by omega⟩ (by omega)

/-- 三つの場合の主張の証明が共通に置く準備（ハ）：a_{T,≤m} ·_A a†_{U,≤m} = z ·_A (G ·_A y)
（z := z^T_m、y := y^U_m、G := a_{T,≤m-1} ·_A a†_{U,≤m-1}。本文の m を Lean では m + 1 と書く）。 -/
theorem initialParts_mul_succ (T U : PowerSet D.M) (m : ℕ) :
    D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T (m + 1)) (D.initialCreationProduct U (m + 1))
      = D.space.cliffordAlgebra.mul (D.selectedAnnihilationFactor T (m + 1))
          (D.space.cliffordAlgebra.mul
            (D.space.cliffordAlgebra.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m))
            (D.selectedCreationFactor U (m + 1))) := by
  let A := D.space.cliffordAlgebra
  let z := D.selectedAnnihilationFactor T (m + 1)
  let y := D.selectedCreationFactor U (m + 1)
  let α := D.initialReverseAnnihilationProduct T m
  let κ := D.initialCreationProduct U m
  calc A.mul (D.initialReverseAnnihilationProduct T (m + 1)) (D.initialCreationProduct U (m + 1))
      = A.mul (A.mul z α) (D.initialCreationProduct U (m + 1)) := by
        rw [D.initialReverseAnnihilationProduct_succ T m]
    _ = A.mul (A.mul z α) (A.mul κ y) := by rw [D.initialCreationProduct_succ U m]
    _ = A.mul z (A.mul α (A.mul κ y)) := A.mul_assoc _ _ _
    _ = A.mul z (A.mul (A.mul α κ) y) := by rw [A.mul_assoc α κ y]

/-- 本文 `claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset`：
m がちょうど一方に入るなら Q^{T,U}_m = 0_A（本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumSandwich_succ_of_exactlyOne (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M)
    (h : (m + 1 ∈ T.1 ∧ m + 1 ∉ U.1) ∨ (m + 1 ∉ T.1 ∧ m + 1 ∈ U.1)) :
    D.vacuumSandwich T U (m + 1) = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  let x := D.vacuumFactor (m + 1)
  let P' := D.initialVacuumPart m
  let G := A.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m)
  let am := D.annihilation (m + 1)
  let cm := D.creation (m + 1)
  -- （イ）
  have hP : D.initialVacuumPart (m + 1) = A.mul P' x := D.initialVacuumPart_succ m
  have hxP : A.mul x P' = A.mul P' x := D.vacuumFactor_commute_initialVacuumPart hm
  -- （ロ）
  have hxG : A.mul x G = A.mul G x := D.vacuumFactor_commute_initialParts T U hm
  -- （ハ）
  have hzy := D.initialParts_mul_succ T U m
  rcases h with ⟨hT, hU⟩ | ⟨hT, hU⟩
  · -- m ∈ T かつ m ∉ U：z = a_m、y = 1_A
    have hprod : A.mul (D.initialReverseAnnihilationProduct T (m + 1)) (D.initialCreationProduct U (m + 1))
        = A.mul am G := by
      rw [hzy, D.selectedAnnihilationFactor_of_mem hT, D.selectedCreationFactor_of_not_mem hU, A.mul_one G]
    have hax : A.mul am x = A.zero := calc
      A.mul am x = A.mul am (A.mul am cm) := rfl
      _ = A.mul (A.mul am am) cm := (A.mul_assoc _ _ _).symm
      _ = A.mul A.zero cm := by rw [D.annihilation_mul_self (m + 1)]
      _ = A.zero := zero_mul_eq_zero A cm
    calc D.vacuumSandwich T U (m + 1)
        = A.mul (A.mul (D.initialVacuumPart (m + 1)) (A.mul am G)) (D.initialVacuumPart (m + 1)) := by
          rw [vacuumSandwich, hprod]
      _ = A.mul (A.mul (A.mul P' x) (A.mul am G)) (A.mul P' x) := by rw [hP]
      _ = A.mul (A.mul P' (A.mul x (A.mul am G))) (A.mul P' x) := by rw [A.mul_assoc P' x (A.mul am G)]
      _ = A.mul (A.mul P' (A.mul (A.mul x am) G)) (A.mul P' x) := by rw [A.mul_assoc x am G]
      _ = A.mul (A.mul P' (A.mul am G)) (A.mul P' x) := by
          rw [D.vacuumFactor_mul_annihilation ⟨Nat.succ_pos m, hm⟩]
      _ = A.mul P' (A.mul (A.mul am G) (A.mul P' x)) := A.mul_assoc _ _ _
      _ = A.mul P' (A.mul (A.mul am G) (A.mul x P')) := by rw [hxP]
      _ = A.mul P' (A.mul am (A.mul G (A.mul x P'))) := by rw [A.mul_assoc am G (A.mul x P')]
      _ = A.mul P' (A.mul am (A.mul (A.mul G x) P')) := by rw [A.mul_assoc G x P']
      _ = A.mul P' (A.mul am (A.mul (A.mul x G) P')) := by rw [hxG]
      _ = A.mul P' (A.mul am (A.mul x (A.mul G P'))) := by rw [A.mul_assoc x G P']
      _ = A.mul P' (A.mul (A.mul am x) (A.mul G P')) := by rw [A.mul_assoc am x (A.mul G P')]
      _ = A.mul P' (A.mul A.zero (A.mul G P')) := by rw [hax]
      _ = A.mul P' A.zero := by rw [zero_mul_eq_zero A (A.mul G P')]
      _ = A.zero := mul_zero_eq_zero A P'
  · -- m ∉ T かつ m ∈ U：z = 1_A、y = a†_m
    have hprod : A.mul (D.initialReverseAnnihilationProduct T (m + 1)) (D.initialCreationProduct U (m + 1))
        = A.mul G cm := by
      rw [hzy, D.selectedAnnihilationFactor_of_not_mem hT, D.selectedCreationFactor_of_mem hU, A.one_mul]
    have hxc : A.mul x cm = A.zero := calc
      A.mul x cm = A.mul (A.mul am cm) cm := rfl
      _ = A.mul am (A.mul cm cm) := A.mul_assoc _ _ _
      _ = A.mul am A.zero := by rw [D.creation_mul_self (m + 1)]
      _ = A.zero := mul_zero_eq_zero A am
    calc D.vacuumSandwich T U (m + 1)
        = A.mul (A.mul (D.initialVacuumPart (m + 1)) (A.mul G cm)) (D.initialVacuumPart (m + 1)) := by
          rw [vacuumSandwich, hprod]
      _ = A.mul (A.mul (A.mul P' x) (A.mul G cm)) (A.mul P' x) := by rw [hP]
      _ = A.mul (A.mul P' (A.mul x (A.mul G cm))) (A.mul P' x) := by rw [A.mul_assoc P' x (A.mul G cm)]
      _ = A.mul (A.mul P' (A.mul (A.mul x G) cm)) (A.mul P' x) := by rw [A.mul_assoc x G cm]
      _ = A.mul (A.mul P' (A.mul (A.mul G x) cm)) (A.mul P' x) := by rw [hxG]
      _ = A.mul (A.mul P' (A.mul G (A.mul x cm))) (A.mul P' x) := by rw [A.mul_assoc G x cm]
      _ = A.mul (A.mul P' (A.mul G A.zero)) (A.mul P' x) := by rw [hxc]
      _ = A.mul (A.mul P' A.zero) (A.mul P' x) := by rw [mul_zero_eq_zero A G]
      _ = A.mul A.zero (A.mul P' x) := by rw [mul_zero_eq_zero A P']
      _ = A.zero := zero_mul_eq_zero A _

/-- 本文 `claim_vacuum_sandwich_when_last_number_is_in_neither_subset`：
m ∉ T かつ m ∉ U なら Q^{T,U}_m = Q^{T,U}_{m-1} ·_A x_m（本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumSandwich_succ_of_neither (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M)
    (hT : m + 1 ∉ T.1) (hU : m + 1 ∉ U.1) :
    D.vacuumSandwich T U (m + 1) = D.space.cliffordAlgebra.mul (D.vacuumSandwich T U m) (D.vacuumFactor (m + 1)) := by
  let A := D.space.cliffordAlgebra
  let x := D.vacuumFactor (m + 1)
  let P' := D.initialVacuumPart m
  let G := A.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m)
  have hP : D.initialVacuumPart (m + 1) = A.mul P' x := D.initialVacuumPart_succ m
  have hxP : A.mul x P' = A.mul P' x := D.vacuumFactor_commute_initialVacuumPart hm
  have hxG : A.mul x G = A.mul G x := D.vacuumFactor_commute_initialParts T U hm
  -- z = 1_A、y = 1_A
  have hprod : A.mul (D.initialReverseAnnihilationProduct T (m + 1)) (D.initialCreationProduct U (m + 1)) = G := by
    rw [D.initialParts_mul_succ T U m, D.selectedAnnihilationFactor_of_not_mem hT,
      D.selectedCreationFactor_of_not_mem hU, A.one_mul, A.mul_one G]
  calc D.vacuumSandwich T U (m + 1)
      = A.mul (A.mul (D.initialVacuumPart (m + 1)) G) (D.initialVacuumPart (m + 1)) := by
        rw [vacuumSandwich, hprod]
    _ = A.mul (A.mul (A.mul P' x) G) (A.mul P' x) := by rw [hP]
    _ = A.mul (A.mul P' (A.mul x G)) (A.mul P' x) := by rw [A.mul_assoc P' x G]
    _ = A.mul (A.mul P' (A.mul G x)) (A.mul P' x) := by rw [hxG]
    _ = A.mul (A.mul (A.mul P' G) x) (A.mul P' x) := by rw [A.mul_assoc P' G x]
    _ = A.mul (A.mul (A.mul P' G) x) (A.mul x P') := by rw [hxP]
    _ = A.mul (A.mul P' G) (A.mul x (A.mul x P')) := A.mul_assoc _ _ _
    _ = A.mul (A.mul P' G) (A.mul (A.mul x x) P') := by rw [A.mul_assoc x x P']
    _ = A.mul (A.mul P' G) (A.mul x P') := by rw [D.vacuumFactor_mul_self ⟨Nat.succ_pos m, hm⟩]
    _ = A.mul (A.mul P' G) (A.mul P' x) := by rw [hxP]
    _ = A.mul (A.mul (A.mul P' G) P') x := (A.mul_assoc _ _ _).symm
    _ = A.mul (D.vacuumSandwich T U m) (D.vacuumFactor (m + 1)) := rfl

/-- 本文 `claim_vacuum_sandwich_when_last_number_is_in_both_subsets`：
m ∈ T かつ m ∈ U なら Q^{T,U}_m = a_m ·_A (Q^{T,U}_{m-1} ·_A a†_m)（本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumSandwich_succ_of_both (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M)
    (hT : m + 1 ∈ T.1) (hU : m + 1 ∈ U.1) :
    D.vacuumSandwich T U (m + 1)
      = D.space.cliffordAlgebra.mul (D.annihilation (m + 1))
          (D.space.cliffordAlgebra.mul (D.vacuumSandwich T U m) (D.creation (m + 1))) := by
  let A := D.space.cliffordAlgebra
  let x := D.vacuumFactor (m + 1)
  let P' := D.initialVacuumPart m
  let G := A.mul (D.initialReverseAnnihilationProduct T m) (D.initialCreationProduct U m)
  let am := D.annihilation (m + 1)
  let cm := D.creation (m + 1)
  have hmM : 1 ≤ m + 1 ∧ m + 1 ≤ D.M := ⟨Nat.succ_pos m, hm⟩
  -- （イ）
  have hP : D.initialVacuumPart (m + 1) = A.mul P' x := D.initialVacuumPart_succ m
  -- （ロ）a_m P' = P' a_m、a†_m P' = P' a†_m
  have haP : A.mul am P' = A.mul P' am := by
    apply commute_orderedProduct A am m D.vacuumFactor
    intro j hj1 hjm
    exact D.annihilation_commute_vacuumFactor hmM ⟨hj1, by omega⟩ (by omega)
  have hcP : A.mul cm P' = A.mul P' cm := by
    apply commute_orderedProduct A cm m D.vacuumFactor
    intro j hj1 hjm
    exact D.creation_commute_vacuumFactor hmM ⟨hj1, by omega⟩ (by omega)
  -- （ハ）z = a_m、y = a†_m
  have hprod : A.mul (D.initialReverseAnnihilationProduct T (m + 1)) (D.initialCreationProduct U (m + 1))
      = A.mul am (A.mul G cm) := by
    rw [D.initialParts_mul_succ T U m, D.selectedAnnihilationFactor_of_mem hT, D.selectedCreationFactor_of_mem hU]
  calc D.vacuumSandwich T U (m + 1)
      = A.mul (A.mul (D.initialVacuumPart (m + 1)) (A.mul am (A.mul G cm))) (D.initialVacuumPart (m + 1)) := by
        rw [vacuumSandwich, hprod]
    _ = A.mul (A.mul (A.mul P' x) (A.mul am (A.mul G cm))) (A.mul P' x) := by rw [hP]
    _ = A.mul (A.mul P' (A.mul x (A.mul am (A.mul G cm)))) (A.mul P' x) := by
        rw [A.mul_assoc P' x (A.mul am (A.mul G cm))]
    _ = A.mul (A.mul P' (A.mul (A.mul x am) (A.mul G cm))) (A.mul P' x) := by
        rw [A.mul_assoc x am (A.mul G cm)]
    _ = A.mul (A.mul P' (A.mul am (A.mul G cm))) (A.mul P' x) := by rw [D.vacuumFactor_mul_annihilation hmM]
    _ = A.mul (A.mul (A.mul P' am) (A.mul G cm)) (A.mul P' x) := by rw [A.mul_assoc P' am (A.mul G cm)]
    _ = A.mul (A.mul (A.mul am P') (A.mul G cm)) (A.mul P' x) := by rw [haP]
    _ = A.mul (A.mul am (A.mul P' (A.mul G cm))) (A.mul P' x) := by rw [A.mul_assoc am P' (A.mul G cm)]
    _ = A.mul am (A.mul (A.mul P' (A.mul G cm)) (A.mul P' x)) := A.mul_assoc _ _ _
    _ = A.mul am (A.mul (A.mul (A.mul P' G) cm) (A.mul P' x)) := by rw [A.mul_assoc P' G cm]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul cm (A.mul P' x))) := by rw [A.mul_assoc (A.mul P' G) cm (A.mul P' x)]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul (A.mul cm P') x)) := by rw [A.mul_assoc cm P' x]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul (A.mul P' cm) x)) := by rw [hcP]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul P' (A.mul cm x))) := by rw [A.mul_assoc P' cm x]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul P' cm)) := by rw [D.creation_mul_vacuumFactor hmM]
    _ = A.mul am (A.mul (A.mul (A.mul P' G) P') cm) := by rw [A.mul_assoc (A.mul P' G) P' cm]
    _ = A.mul am (A.mul (D.vacuumSandwich T U m) cm) := rfl

/-- 本文 `claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part`：
すべての t ∈ {1,…,m} で t ∈ T ⟺ t ∈ U なら Q^{T,U}_m = P_{≤m}（m ∈ {0,…,M}）。 -/
theorem vacuumSandwich_of_agree (T U : PowerSet D.M) :
    ∀ m : ℕ, m ≤ D.M → (∀ t : ℕ, 1 ≤ t → t ≤ m → (t ∈ T.1 ↔ t ∈ U.1)) →
      D.vacuumSandwich T U m = D.initialVacuumPart m := by
  let A := D.space.cliffordAlgebra
  intro m
  induction m with
  | zero =>
    intro _ _
    -- a_{T,≤0} = 1_A、a†_{U,≤0} = 1_A、P_{≤0} = 1_A（空の番号順の積）
    have ha : D.initialReverseAnnihilationProduct T 0 = A.one := rfl
    have hc : D.initialCreationProduct U 0 = A.one := rfl
    have hP : D.initialVacuumPart 0 = A.one := rfl
    calc D.vacuumSandwich T U 0
        = A.mul (A.mul (D.initialVacuumPart 0)
            (A.mul (D.initialReverseAnnihilationProduct T 0) (D.initialCreationProduct U 0)))
            (D.initialVacuumPart 0) := rfl
      _ = A.mul (A.mul A.one (A.mul A.one A.one)) A.one := by rw [ha, hc, hP]
      _ = A.mul (A.mul A.one A.one) A.one := by rw [A.one_mul (A.mul A.one A.one)]
      _ = A.mul A.one A.one := congrArg (fun t => A.mul t A.one) (A.one_mul A.one)
      _ = A.one := A.one_mul A.one
      _ = D.initialVacuumPart 0 := hP.symm
  | succ m ih =>
    intro hm hagree
    let P' := D.initialVacuumPart m
    let x := D.vacuumFactor (m + 1)
    have hmM : 1 ≤ m + 1 ∧ m + 1 ≤ D.M := ⟨Nat.succ_pos m, hm⟩
    have hih : D.vacuumSandwich T U m = P' :=
      ih (by omega) fun t ht1 htm => hagree t ht1 (by omega)
    have hP : D.initialVacuumPart (m + 1) = A.mul P' x := D.initialVacuumPart_succ m
    by_cases hT : m + 1 ∈ T.1
    · -- m ∈ T かつ m ∈ U
      have hU : m + 1 ∈ U.1 := (hagree (m + 1) hmM.1 le_rfl).1 hT
      have hcP : A.mul (D.creation (m + 1)) P' = A.mul P' (D.creation (m + 1)) := by
        apply commute_orderedProduct A (D.creation (m + 1)) m D.vacuumFactor
        intro j hj1 hjm
        exact D.creation_commute_vacuumFactor hmM ⟨hj1, by omega⟩ (by omega)
      have hxP : A.mul x P' = A.mul P' x := D.vacuumFactor_commute_initialVacuumPart hm
      calc D.vacuumSandwich T U (m + 1)
          = A.mul (D.annihilation (m + 1)) (A.mul (D.vacuumSandwich T U m) (D.creation (m + 1))) :=
            D.vacuumSandwich_succ_of_both T U hm hT hU
        _ = A.mul (D.annihilation (m + 1)) (A.mul P' (D.creation (m + 1))) := by rw [hih]
        _ = A.mul (D.annihilation (m + 1)) (A.mul (D.creation (m + 1)) P') := by rw [hcP]
        _ = A.mul (A.mul (D.annihilation (m + 1)) (D.creation (m + 1))) P' := (A.mul_assoc _ _ _).symm
        _ = A.mul x P' := rfl
        _ = A.mul P' x := hxP
        _ = D.initialVacuumPart (m + 1) := hP.symm
    · -- m ∉ T かつ m ∉ U
      have hU : m + 1 ∉ U.1 := fun h => hT ((hagree (m + 1) hmM.1 le_rfl).2 h)
      calc D.vacuumSandwich T U (m + 1)
          = A.mul (D.vacuumSandwich T U m) x := D.vacuumSandwich_succ_of_neither T U hm hT hU
        _ = A.mul P' x := by rw [hih]
        _ = D.initialVacuumPart (m + 1) := hP.symm

/-- 本文 `claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero`：
「t ∈ T かつ t ∉ U」か「t ∉ T かつ t ∈ U」を満たす t ∈ {1,…,m} があれば Q^{T,U}_m = 0_A（m ∈ {0,…,M}）。 -/
theorem vacuumSandwich_of_disagree (T U : PowerSet D.M) :
    ∀ m : ℕ, m ≤ D.M → (∃ t : ℕ, 1 ≤ t ∧ t ≤ m ∧ ((t ∈ T.1 ∧ t ∉ U.1) ∨ (t ∉ T.1 ∧ t ∈ U.1))) →
      D.vacuumSandwich T U m = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  intro m
  induction m with
  | zero =>
    -- {1,…,0} は空集合なので、条件を満たす t は無い
    intro _ ⟨t, ht1, ht0, _⟩
    omega
  | succ m ih =>
    intro hm ⟨t, ht1, htm, ht⟩
    by_cases htm' : t = m + 1
    · -- t = m
      rw [htm'] at ht
      exact D.vacuumSandwich_succ_of_exactlyOne T U hm ht
    · -- t ≠ m：帰納法の仮定により Q^{T,U}_{m-1} = 0_A
      have hih : D.vacuumSandwich T U m = A.zero := ih (by omega) ⟨t, ht1, by omega, ht⟩
      by_cases hT : m + 1 ∈ T.1 <;> by_cases hU : m + 1 ∈ U.1
      · -- 両方に入る
        calc D.vacuumSandwich T U (m + 1)
            = A.mul (D.annihilation (m + 1)) (A.mul (D.vacuumSandwich T U m) (D.creation (m + 1))) :=
              D.vacuumSandwich_succ_of_both T U hm hT hU
          _ = A.mul (D.annihilation (m + 1)) (A.mul A.zero (D.creation (m + 1))) := by rw [hih]
          _ = A.mul (D.annihilation (m + 1)) A.zero := by rw [zero_mul_eq_zero A (D.creation (m + 1))]
          _ = A.zero := mul_zero_eq_zero A _
      · -- ちょうど一方に入る
        exact D.vacuumSandwich_succ_of_exactlyOne T U hm (Or.inl ⟨hT, hU⟩)
      · exact D.vacuumSandwich_succ_of_exactlyOne T U hm (Or.inr ⟨hT, hU⟩)
      · -- どちらにも入らない
        calc D.vacuumSandwich T U (m + 1)
            = A.mul (D.vacuumSandwich T U m) (D.vacuumFactor (m + 1)) :=
              D.vacuumSandwich_succ_of_neither T U hm hT hU
          _ = A.mul A.zero (D.vacuumFactor (m + 1)) := by rw [hih]
          _ = A.zero := zero_mul_eq_zero A _

open Classical in
/-- 本文 `claim_vacuum_element_sandwich_of_annihilation_and_creation_products`：
(P ·_A (a_T ·_A a†_U)) ·_A P = δ_{T,U} ∗_A P。 -/
theorem vacuumElement_sandwich (T U : PowerSet D.M) :
    D.space.cliffordAlgebra.mul
        (D.space.cliffordAlgebra.mul D.vacuumElement
          (D.space.cliffordAlgebra.mul (D.reverseOrderedAnnihilationProduct T) (D.orderedCreationProduct U)))
        D.vacuumElement
      = D.space.cliffordAlgebra.smul (kroneckerDelta T U) D.vacuumElement := by
  let A := D.space.cliffordAlgebra
  by_cases hTU : T = U
  · -- T = U：すべての t で t ∈ T ⟺ t ∈ U
    have hagree : ∀ t : ℕ, 1 ≤ t → t ≤ D.M → (t ∈ T.1 ↔ t ∈ U.1) := fun t _ _ => by rw [hTU]
    calc A.mul (A.mul D.vacuumElement
          (A.mul (D.reverseOrderedAnnihilationProduct T) (D.orderedCreationProduct U))) D.vacuumElement
        = D.vacuumSandwich T U D.M := (D.vacuumSandwich_last T U).symm
      _ = D.initialVacuumPart D.M := D.vacuumSandwich_of_agree T U D.M le_rfl hagree
      _ = D.vacuumElement := D.initialVacuumPart_last
      _ = A.smul 1 D.vacuumElement := (A.one_smul _).symm
      _ = A.smul (kroneckerDelta T U) D.vacuumElement := by rw [kroneckerDelta, if_pos hTU]
  · -- T ≠ U：t ∈ T と t ∈ U が同値でない t ∈ {1,…,M} がある（集合の等しさの対偶）
    have hdis : ∃ t : ℕ, 1 ≤ t ∧ t ≤ D.M ∧ ((t ∈ T.1 ∧ t ∉ U.1) ∨ (t ∉ T.1 ∧ t ∈ U.1)) := by
      by_contra hno
      apply hTU
      apply PowerSet.ext
      intro t ht1 htM
      constructor
      · intro hT
        by_contra hU
        exact hno ⟨t, ht1, htM, Or.inl ⟨hT, hU⟩⟩
      · intro hU
        by_contra hT
        exact hno ⟨t, ht1, htM, Or.inr ⟨hT, hU⟩⟩
    calc A.mul (A.mul D.vacuumElement
          (A.mul (D.reverseOrderedAnnihilationProduct T) (D.orderedCreationProduct U))) D.vacuumElement
        = D.vacuumSandwich T U D.M := (D.vacuumSandwich_last T U).symm
      _ = A.zero := D.vacuumSandwich_of_disagree T U D.M le_rfl hdis
      _ = A.smul 0 D.vacuumElement := (zero_smul_eq_zero A _).symm
      _ = A.smul (kroneckerDelta T U) D.vacuumElement := by rw [kroneckerDelta, if_neg hTU]

/-! ### 1 の分解 -/

open Classical in
/-- 本文 `def_selected_number_factor_of_split_clifford_algebra`：u^S_i := a†_i ·_A a_i（i ∈ S）、a_i ·_A a†_i（i ∉ S）。 -/
def selectedNumberFactor (S : PowerSet D.M) (i : ℕ) : D.space.Cl :=
  if i ∈ S.1 then D.space.cliffordAlgebra.mul (D.creation i) (D.annihilation i)
  else D.space.cliffordAlgebra.mul (D.annihilation i) (D.creation i)

/-- 本文 `claim_creation_vacuum_annihilation_factor_of_one_number`：(y^S_i ·_A x_i) ·_A z^S_i = u^S_i。 -/
theorem creation_vacuum_annihilation_factor (S : PowerSet D.M) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.space.cliffordAlgebra.mul
        (D.space.cliffordAlgebra.mul (D.selectedCreationFactor S i) (D.vacuumFactor i))
        (D.selectedAnnihilationFactor S i)
      = D.selectedNumberFactor S i := by
  let A := D.space.cliffordAlgebra
  by_cases hiS : i ∈ S.1
  · -- i ∈ S：y^S_i = a†_i、z^S_i = a_i
    calc A.mul (A.mul (D.selectedCreationFactor S i) (D.vacuumFactor i)) (D.selectedAnnihilationFactor S i)
        = A.mul (A.mul (D.creation i) (D.vacuumFactor i)) (D.annihilation i) := by
          rw [D.selectedCreationFactor_of_mem hiS, D.selectedAnnihilationFactor_of_mem hiS]
      _ = A.mul (D.creation i) (D.annihilation i) := by rw [D.creation_mul_vacuumFactor hi]
      _ = D.selectedNumberFactor S i := (if_pos hiS).symm
  · -- i ∉ S：y^S_i = z^S_i = 1_A
    calc A.mul (A.mul (D.selectedCreationFactor S i) (D.vacuumFactor i)) (D.selectedAnnihilationFactor S i)
        = A.mul (A.mul A.one (D.vacuumFactor i)) A.one := by
          rw [D.selectedCreationFactor_of_not_mem hiS, D.selectedAnnihilationFactor_of_not_mem hiS]
      _ = A.mul (D.vacuumFactor i) A.one := by rw [A.one_mul (D.vacuumFactor i)]
      _ = D.vacuumFactor i := A.mul_one _
      _ = A.mul (D.annihilation i) (D.creation i) := rfl
      _ = D.selectedNumberFactor S i := (if_neg hiS).symm

/-- 本文 `claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors`：
(a†_{S,≤m} ·_A P_{≤m}) ·_A a_{S,≤m} = ∏_{A,i=1}^{m} u^S_i（m ∈ {0,…,M}）。 -/
theorem initialParts_product_eq_orderedProduct (S : PowerSet D.M) :
    ∀ m : ℕ, m ≤ D.M →
      D.space.cliffordAlgebra.mul
          (D.space.cliffordAlgebra.mul (D.initialCreationProduct S m) (D.initialVacuumPart m))
          (D.initialReverseAnnihilationProduct S m)
        = ComplexAlgebra.orderedProduct D.space.cliffordAlgebra m (D.selectedNumberFactor S) := by
  let A := D.space.cliffordAlgebra
  intro m
  induction m with
  | zero =>
    intro _
    have hc : D.initialCreationProduct S 0 = A.one := rfl
    have hP : D.initialVacuumPart 0 = A.one := rfl
    have ha : D.initialReverseAnnihilationProduct S 0 = A.one := rfl
    calc A.mul (A.mul (D.initialCreationProduct S 0) (D.initialVacuumPart 0)) (D.initialReverseAnnihilationProduct S 0)
        = A.mul (A.mul A.one A.one) A.one := by rw [hc, hP, ha]
      _ = A.mul A.one A.one := congrArg (fun t => A.mul t A.one) (A.one_mul A.one)
      _ = A.one := A.one_mul A.one
      _ = ComplexAlgebra.orderedProduct A 0 (D.selectedNumberFactor S) := rfl
  | succ m ih =>
    intro hm
    let κ := D.initialCreationProduct S m
    let P' := D.initialVacuumPart m
    let α := D.initialReverseAnnihilationProduct S m
    let x := D.vacuumFactor (m + 1)
    let y := D.selectedCreationFactor S (m + 1)
    let z := D.selectedAnnihilationFactor S (m + 1)
    let u := D.selectedNumberFactor S (m + 1)
    have hmM : 1 ≤ m + 1 ∧ m + 1 ≤ D.M := ⟨Nat.succ_pos m, hm⟩
    -- （イ）y ·_A P' = P' ·_A y
    have hyP : A.mul y P' = A.mul P' y := by
      apply commute_orderedProduct A y m D.vacuumFactor
      intro j hj1 hjm
      show A.mul (D.selectedCreationFactor S (m + 1)) (D.vacuumFactor j)
        = A.mul (D.vacuumFactor j) (D.selectedCreationFactor S (m + 1))
      by_cases hmS : m + 1 ∈ S.1
      · rw [D.selectedCreationFactor_of_mem hmS]
        exact D.creation_commute_vacuumFactor hmM ⟨hj1, by omega⟩ (by omega)
      · rw [D.selectedCreationFactor_of_not_mem hmS, A.one_mul, A.mul_one]
    -- （ロ）u ·_A α = α ·_A u
    have huα : A.mul u α = A.mul α u := by
      apply commute_orderedProduct A u m (fun k => D.selectedAnnihilationFactor S (m + 1 - k))
      intro k hk1 hkm
      show A.mul u (D.selectedAnnihilationFactor S (m + 1 - k)) = A.mul (D.selectedAnnihilationFactor S (m + 1 - k)) u
      have ht : 1 ≤ m + 1 - k ∧ m + 1 - k ≤ D.M := ⟨by omega, by omega⟩
      have htm : m + 1 - k ≠ m + 1 := by omega
      by_cases htS : m + 1 - k ∈ S.1
      · rw [D.selectedAnnihilationFactor_of_mem htS]
        by_cases hmS : m + 1 ∈ S.1
        · rw [show u = A.mul (D.creation (m + 1)) (D.annihilation (m + 1)) from if_pos hmS]
          exact (D.annihilation_commute_reversedPair ht hmM htm).symm
        · rw [show u = A.mul (D.annihilation (m + 1)) (D.creation (m + 1)) from if_neg hmS]
          exact (D.annihilation_commute_vacuumFactor ht hmM htm).symm
      · rw [D.selectedAnnihilationFactor_of_not_mem htS, A.mul_one, A.one_mul]
    calc A.mul (A.mul (D.initialCreationProduct S (m + 1)) (D.initialVacuumPart (m + 1)))
          (D.initialReverseAnnihilationProduct S (m + 1))
        = A.mul (A.mul (A.mul κ y) (D.initialVacuumPart (m + 1))) (D.initialReverseAnnihilationProduct S (m + 1)) := by
          rw [D.initialCreationProduct_succ S m]
      _ = A.mul (A.mul (A.mul κ y) (A.mul P' x)) (D.initialReverseAnnihilationProduct S (m + 1)) := by
          rw [D.initialVacuumPart_succ m]
      _ = A.mul (A.mul (A.mul κ y) (A.mul P' x)) (A.mul z α) := by
          rw [D.initialReverseAnnihilationProduct_succ S m]
      _ = A.mul (A.mul κ (A.mul y (A.mul P' x))) (A.mul z α) := by rw [A.mul_assoc κ y (A.mul P' x)]
      _ = A.mul (A.mul κ (A.mul (A.mul y P') x)) (A.mul z α) := by rw [A.mul_assoc y P' x]
      _ = A.mul (A.mul κ (A.mul (A.mul P' y) x)) (A.mul z α) := by rw [hyP]
      _ = A.mul (A.mul κ (A.mul P' (A.mul y x))) (A.mul z α) := by rw [A.mul_assoc P' y x]
      _ = A.mul (A.mul (A.mul κ P') (A.mul y x)) (A.mul z α) := by rw [A.mul_assoc κ P' (A.mul y x)]
      _ = A.mul (A.mul κ P') (A.mul (A.mul y x) (A.mul z α)) := A.mul_assoc _ _ _
      _ = A.mul (A.mul κ P') (A.mul (A.mul (A.mul y x) z) α) := by rw [A.mul_assoc (A.mul y x) z α]
      _ = A.mul (A.mul κ P') (A.mul u α) := by rw [D.creation_vacuum_annihilation_factor S hmM]
      _ = A.mul (A.mul κ P') (A.mul α u) := by rw [huα]
      _ = A.mul (A.mul (A.mul κ P') α) u := (A.mul_assoc _ _ _).symm
      _ = A.mul (ComplexAlgebra.orderedProduct A m (D.selectedNumberFactor S)) u := by rw [ih (by omega)]
      _ = ComplexAlgebra.orderedProduct A (m + 1) (D.selectedNumberFactor S) := rfl

/-- 本文 `claim_decomposition_of_unity_in_split_clifford_algebra`：
Σ_{S∈P_M} 1_ℂ ∗_A ((a†_S ·_A P) ·_A a_S) = 1_A。 -/
theorem decomposition_of_unity :
    sumOverFiniteSet D.space.cliffordAlgebra.toComplexVectorSpace (isFiniteSet_powerSet D.M) (fun _ => 1)
        (fun S => D.space.cliffordAlgebra.mul
          (D.space.cliffordAlgebra.mul (D.orderedCreationProduct S) D.vacuumElement)
          (D.reverseOrderedAnnihilationProduct S))
      = D.space.cliffordAlgebra.one := by
  let A := D.space.cliffordAlgebra
  let SV := A.toComplexVectorSpace
  let g : ℕ → D.space.Cl := fun i => A.mul (D.creation i) (D.annihilation i)
  let h : ℕ → D.space.Cl := fun i => A.mul (D.annihilation i) (D.creation i)
  let Fu : PowerSet D.M → D.space.Cl := fun S => ComplexAlgebra.orderedProduct A D.M (D.selectedNumberFactor S)
  -- （イ）(a†_S P) a_S = ∏ u^S_i
  have hI : ∀ S : PowerSet D.M,
      A.mul (A.mul (D.orderedCreationProduct S) D.vacuumElement) (D.reverseOrderedAnnihilationProduct S) = Fu S := by
    intro S
    calc A.mul (A.mul (D.orderedCreationProduct S) D.vacuumElement) (D.reverseOrderedAnnihilationProduct S)
        = A.mul (A.mul (D.initialCreationProduct S D.M) D.vacuumElement) (D.reverseOrderedAnnihilationProduct S) := by
          rw [D.initialCreationProduct_last S]
      _ = A.mul (A.mul (D.initialCreationProduct S D.M) (D.initialVacuumPart D.M))
            (D.reverseOrderedAnnihilationProduct S) := by rw [D.initialVacuumPart_last]
      _ = A.mul (A.mul (D.initialCreationProduct S D.M) (D.initialVacuumPart D.M))
            (D.initialReverseAnnihilationProduct S D.M) := by rw [D.initialReverseAnnihilationProduct_last S]
      _ = Fu S := D.initialParts_product_eq_orderedProduct S D.M le_rfl
  -- （ロ）v^S_i = u^S_i（g_i := a†_i a_i、h_i := a_i a†_i）
  have hII : ∀ S : PowerSet D.M, ComplexAlgebra.orderedProduct A D.M (selectedFactorBySubset g h S.1) = Fu S :=
    fun S => rfl
  -- （ハ）a_i a†_i + a†_i a_i = 1_A
  have hIII : ∀ i : ℕ, 1 ≤ i → i ≤ D.M → A.add (h i) (g i) = A.one := by
    intro i hi1 hiM
    calc A.add (h i) (g i)
        = A.smul (kroneckerDelta i i) A.one := D.annihilation_creation_anticommute i i hi1 hiM hi1 hiM
      _ = A.smul 1 A.one := by rw [kroneckerDelta, if_pos rfl]
      _ = A.one := A.one_smul A.one
  -- （ニ）すべての因子が 1_A の番号順の積は 1_A
  have hIV : ∀ m : ℕ, ComplexAlgebra.orderedProduct A m (fun _ => A.one) = A.one := by
    intro m
    induction m with
    | zero => rfl
    | succ m ih => calc
        ComplexAlgebra.orderedProduct A (m + 1) (fun _ => A.one)
            = A.mul (ComplexAlgebra.orderedProduct A m (fun _ => A.one)) A.one := rfl
        _ = ComplexAlgebra.orderedProduct A m (fun _ => A.one) := A.mul_one _
        _ = A.one := ih
  calc sumOverFiniteSet SV (isFiniteSet_powerSet D.M) (fun _ => 1)
        (fun S => A.mul (A.mul (D.orderedCreationProduct S) D.vacuumElement) (D.reverseOrderedAnnihilationProduct S))
      = sumOverFiniteSet SV (isFiniteSet_powerSet D.M) (fun _ => 1) Fu :=
        sumOverFiniteSet_congr SV _ _ _ _ _ fun S => by rw [hI S]
    -- 番号付け (2^M, e_M) で開く（def_sum_over_finite_set）
    _ = linearCombination SV (twoPower D.M) (fun _ => 1) (numberedFamily (binaryNumbering D.M) Fu A.zero) := by
        rw [sumOverFiniteSet_eq SV _ _ _ (twoPower D.M) (binaryNumbering D.M) (binaryNumbering_isNumbering D.M)]
        apply linearCombination_eq_of_terms_eq
        intro k hk1 hk2
        rw [numberedFamily_of_le (binaryNumbering D.M) (fun _ => (1 : ℂ)) 0 k hk1 hk2]
        rfl
    _ = linearCombination SV (twoPower D.M) (fun _ => 1)
          (numberedFamily (binaryNumbering D.M)
            (fun S => ComplexAlgebra.orderedProduct A D.M (selectedFactorBySubset g h S.1)) A.zero) := by
        rw [show (fun S : PowerSet D.M => ComplexAlgebra.orderedProduct A D.M (selectedFactorBySubset g h S.1)) = Fu
          from funext hII]
    _ = ComplexAlgebra.orderedProduct A D.M (fun i => A.add (h i) (g i)) :=
        linearCombination_selectedProducts_eq A D.M g h D.M le_rfl
    _ = ComplexAlgebra.orderedProduct A D.M (fun _ => A.one) := orderedProduct_congr A D.M _ _ hIII
    _ = A.one := hIV D.M

end

end CliffordMatrixIsomorphism.Clifford.SplitData
