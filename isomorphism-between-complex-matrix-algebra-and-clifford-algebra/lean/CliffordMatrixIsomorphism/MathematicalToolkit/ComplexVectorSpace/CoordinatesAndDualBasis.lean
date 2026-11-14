/-
節「ℂ-線型空間」のうち座標の写像・番号順の和・双対基底の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                              このファイル
  claim_coordinate_map_is_linear_form                       coordinate（β^b_k）・linearCombination_coordinate（一つ目の性質）・
                                                            coordinate_eq_of_linearCombination_eq（二つ目の性質）・
                                                            coordinate_isLinearForm
  claim_linear_form_maps_linear_combination_to_ordered_sum  IsComplexLinearForm.map_linearCombination
  claim_family_member_is_kronecker_delta_linear_combination linearCombination_kroneckerDelta
  def_dual_basis                                            IsDualBasis
  claim_coordinate_maps_form_dual_basis                     coordinateFamily（β^b）・coordinateFamily_isDualBasis
  claim_value_of_linear_combination_in_dual_space           dualSpace_linearCombination_apply
  claim_ordered_sum_with_kronecker_delta_picks_term         orderedSum_mul_kroneckerDelta
  claim_dual_basis_spans_dual_space                         dualBasis_spans
  claim_dual_basis_is_linearly_independent                  dualBasis_linearlyIndependent
  claim_ordered_sums_in_complex_numbers_with_equal_terms_are_equal
                                                            partialOrderedSum_congr・orderedSum_congr
  claim_dual_basis_is_basis_of_dual_space                   dualBasis_isBasis

必要十分版は `NecSuf/MathematicalToolkit/ComplexVectorSpace/CoordinatesAndDualBasis.lean`、
導出版は `ComplexVectorSpaceFromNecSuf.lean`。

座標の写像 β^b_k は、張ることから存在する係数の与え方を `Classical.choose` で一つ選んで定める。
本文はこの与え方が一つしかないことを先に示してから β^b_k と書くが、Lean では選んだものに名前を付け、
一つしかないことは二つ目の性質 `coordinate_eq_of_linearCombination_eq` として示す。
番号付けた族 β^b は 1,…,n の外では 0_{V^*} を置く（1,…,n の外の値は使わない）。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.DualSpace
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.LinearCombination

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {V : Type u}

/-- 本文 `claim_coordinate_map_is_linear_form` の β^b_k(x)：x を b の線型結合で書く係数の第 k 成分。 -/
noncomputable def coordinate (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) (x : V) : ℂ :=
  Classical.choose (hb.spans x) k

/-- 本文 `claim_coordinate_map_is_linear_form` の一つ目の性質 Σ β^b_k(x) ·_V b_k = x。 -/
theorem linearCombination_coordinate (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (x : V) :
    linearCombination S n (fun k => coordinate S n b hb k x) b = x :=
  Classical.choose_spec (hb.spans x)

/-- 本文 `claim_coordinate_map_is_linear_form` の二つ目の性質：Σ λ_k ·_V b_k = x なら β^b_k(x) = λ_k。
一次独立による係数の一意性（`claim_uniqueness_of_coefficients_of_linear_combination`）による。 -/
theorem coordinate_eq_of_linearCombination_eq (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (x : V) (c : ℕ → ℂ) (h : linearCombination S n c b = x) :
    ∀ k : ℕ, 1 ≤ k → k ≤ n → coordinate S n b hb k x = c k :=
  coefficients_eq_of_linearCombination_eq S n b hb.linearlyIndependent
    (fun k => coordinate S n b hb k x) c
    ((linearCombination_coordinate S n b hb x).trans h.symm)

/-- 本文 `claim_coordinate_map_is_linear_form`：各 i ∈ {1,…,n} について β^b_i は線型形式である。 -/
theorem coordinate_isLinearForm (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (i : ℕ) (hi1 : 1 ≤ i) (hin : i ≤ n) :
    IsComplexLinearForm S (coordinate S n b hb i) where
  map_add x y := by
    have hsum : linearCombination S n
        (fun k => coordinate S n b hb k x + coordinate S n b hb k y) b = S.add x y := calc
      linearCombination S n (fun k => coordinate S n b hb k x + coordinate S n b hb k y) b
          = S.add (linearCombination S n (fun k => coordinate S n b hb k x) b)
              (linearCombination S n (fun k => coordinate S n b hb k y) b) :=
            (linearCombination_add_of_same_family S n b _ _).symm
      _ = S.add x y := by
            rw [linearCombination_coordinate S n b hb x, linearCombination_coordinate S n b hb y]
    exact coordinate_eq_of_linearCombination_eq S n b hb (S.add x y) _ hsum i hi1 hin
  map_smul ρ x := by
    have hsmul : linearCombination S n (fun k => ρ * coordinate S n b hb k x) b
        = S.smul ρ x := calc
      linearCombination S n (fun k => ρ * coordinate S n b hb k x) b
          = S.smul ρ (linearCombination S n (fun k => coordinate S n b hb k x) b) :=
            (smul_linearCombination S n b _ ρ).symm
      _ = S.smul ρ x := by rw [linearCombination_coordinate S n b hb x]
    exact coordinate_eq_of_linearCombination_eq S n b hb (S.smul ρ x) _ hsmul i hi1 hin

/-- 本文 `claim_linear_form_maps_linear_combination_to_ordered_sum` の帰納法の主張 f(L_m) = S_m。 -/
theorem IsComplexLinearForm.map_partialLinearCombination {S : ComplexVectorSpace V} {f : V → ℂ}
    (hf : IsComplexLinearForm S f) (b : ℕ → V) (c : ℕ → ℂ) (m : ℕ) :
    f (partialLinearCombination S c b m) = partialOrderedSum (fun k => c k * f (b k)) m := by
  induction m with
  | zero => calc
      f (partialLinearCombination S c b 0) = f S.zero := rfl
      _ = f (S.smul 0 S.zero) := by rw [zero_smul_eq_zero S S.zero]
      _ = 0 * f S.zero := by rw [hf.map_smul 0 S.zero]
      _ = 0 := by rw [zero_mul (f S.zero)]
      _ = partialOrderedSum (fun k => c k * f (b k)) 0 := rfl
  | succ m ih => calc
      f (partialLinearCombination S c b (m + 1))
          = f (S.add (partialLinearCombination S c b m) (S.smul (c (m + 1)) (b (m + 1)))) := rfl
      _ = f (partialLinearCombination S c b m) + f (S.smul (c (m + 1)) (b (m + 1))) := by
            rw [hf.map_add (partialLinearCombination S c b m) (S.smul (c (m + 1)) (b (m + 1)))]
      _ = partialOrderedSum (fun k => c k * f (b k)) m + f (S.smul (c (m + 1)) (b (m + 1))) := by
            rw [ih]
      _ = partialOrderedSum (fun k => c k * f (b k)) m + c (m + 1) * f (b (m + 1)) := by
            rw [hf.map_smul (c (m + 1)) (b (m + 1))]
      _ = partialOrderedSum (fun k => c k * f (b k)) (m + 1) := rfl

/-- 本文 `claim_linear_form_maps_linear_combination_to_ordered_sum`：
f(Σ λ_k ·_V b_k) = Σ_{ℂ} λ_k ·_ℂ f(b_k)。 -/
theorem IsComplexLinearForm.map_linearCombination {S : ComplexVectorSpace V} {f : V → ℂ}
    (hf : IsComplexLinearForm S f) (n : ℕ) (b : ℕ → V) (c : ℕ → ℂ) :
    f (linearCombination S n c b) = orderedSum n (fun k => c k * f (b k)) :=
  hf.map_partialLinearCombination b c n

/-- 本文 `claim_family_member_is_kronecker_delta_linear_combination` の帰納法の主張
L_m = 0_V（m < j）、b_j（m ≥ j）。 -/
theorem partialLinearCombination_kroneckerDelta (S : ComplexVectorSpace V) (b : ℕ → V) (j : ℕ)
    (hj : 1 ≤ j) (m : ℕ) :
    partialLinearCombination S (fun k => kroneckerDelta k j) b m
      = if m < j then S.zero else b j := by
  induction m with
  | zero => rw [if_pos (show 0 < j from hj)]; rfl
  | succ m ih =>
    rcases Nat.lt_trichotomy (m + 1) j with hlt | heq | hgt
    · have hm : m < j := Nat.lt_of_succ_lt hlt
      have hne : m + 1 ≠ j := Nat.ne_of_lt hlt
      rw [if_pos hlt]
      calc partialLinearCombination S (fun k => kroneckerDelta k j) b (m + 1)
          = S.add (partialLinearCombination S (fun k => kroneckerDelta k j) b m)
              (S.smul (kroneckerDelta (m + 1) j) (b (m + 1))) := rfl
        _ = S.add S.zero (S.smul (kroneckerDelta (m + 1) j) (b (m + 1))) := by
              rw [ih, if_pos hm]
        _ = S.add S.zero (S.smul 0 (b (m + 1))) := by rw [kroneckerDelta, if_neg hne]
        _ = S.add S.zero S.zero := by rw [zero_smul_eq_zero S (b (m + 1))]
        _ = S.zero := by rw [S.add_zero S.zero]
    · have hm : m < j := by omega
      rw [if_neg (by omega)]
      calc partialLinearCombination S (fun k => kroneckerDelta k j) b (m + 1)
          = S.add (partialLinearCombination S (fun k => kroneckerDelta k j) b m)
              (S.smul (kroneckerDelta (m + 1) j) (b (m + 1))) := rfl
        _ = S.add S.zero (S.smul (kroneckerDelta (m + 1) j) (b (m + 1))) := by
              rw [ih, if_pos hm]
        _ = S.add S.zero (S.smul 1 (b (m + 1))) := by rw [kroneckerDelta, if_pos heq]
        _ = S.add S.zero (b (m + 1)) := by rw [S.one_smul (b (m + 1))]
        _ = S.add (b (m + 1)) S.zero := by rw [S.add_comm S.zero (b (m + 1))]
        _ = b (m + 1) := by rw [S.add_zero (b (m + 1))]
        _ = b j := by rw [heq]
    · have hm : ¬ m < j := by omega
      have hne : m + 1 ≠ j := Nat.ne_of_gt hgt
      rw [if_neg (Nat.not_lt_of_gt hgt)]
      calc partialLinearCombination S (fun k => kroneckerDelta k j) b (m + 1)
          = S.add (partialLinearCombination S (fun k => kroneckerDelta k j) b m)
              (S.smul (kroneckerDelta (m + 1) j) (b (m + 1))) := rfl
        _ = S.add (b j) (S.smul (kroneckerDelta (m + 1) j) (b (m + 1))) := by
              rw [ih, if_neg hm]
        _ = S.add (b j) (S.smul 0 (b (m + 1))) := by rw [kroneckerDelta, if_neg hne]
        _ = S.add (b j) S.zero := by rw [zero_smul_eq_zero S (b (m + 1))]
        _ = b j := by rw [S.add_zero (b j)]

/-- 本文 `claim_family_member_is_kronecker_delta_linear_combination`：Σ δ_{k,j} ·_V b_k = b_j（1 ≤ j ≤ n）。 -/
theorem linearCombination_kroneckerDelta (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) (j : ℕ)
    (hj1 : 1 ≤ j) (hjn : j ≤ n) :
    linearCombination S n (fun k => kroneckerDelta k j) b = b j := by
  have h := partialLinearCombination_kroneckerDelta S b j hj1 n
  rw [if_neg (Nat.not_lt_of_ge hjn)] at h
  exact h

/-- 本文 `def_dual_basis`：f_i(b_j) = δ_{i,j}（1 ≤ i, j ≤ n）。基底であることは定義の前提で、条件には入れない。 -/
def IsDualBasis (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) (f : ℕ → DualSpace S) : Prop :=
  ∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → (f i).1 (b j) = kroneckerDelta i j

/-- 本文 `claim_coordinate_maps_form_dual_basis` の族 β^b(k) := β^b_k。 -/
noncomputable def coordinateFamily (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) : DualSpace S :=
  if h : 1 ≤ k ∧ k ≤ n then ⟨coordinate S n b hb k, coordinate_isLinearForm S n b hb k h.1 h.2⟩
  else DualSpace.zero S

/-- 本文 `claim_coordinate_maps_form_dual_basis`：β^b は基底 b の双対基底である。 -/
theorem coordinateFamily_isDualBasis (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) : IsDualBasis S n b (coordinateFamily S n b hb) := by
  intro i j hi1 hin hj1 hjn
  have hlc : linearCombination S n (fun k => coordinate S n b hb k (b j)) b
      = linearCombination S n (fun k => kroneckerDelta k j) b := calc
    linearCombination S n (fun k => coordinate S n b hb k (b j)) b = b j :=
      linearCombination_coordinate S n b hb (b j)
    _ = linearCombination S n (fun k => kroneckerDelta k j) b :=
      (linearCombination_kroneckerDelta S n b j hj1 hjn).symm
  have hk := coefficients_eq_of_linearCombination_eq S n b hb.linearlyIndependent
    (fun k => coordinate S n b hb k (b j)) (fun k => kroneckerDelta k j) hlc i hi1 hin
  rw [coordinateFamily, dif_pos ⟨hi1, hin⟩]
  exact hk

/-- 本文 `claim_value_of_linear_combination_in_dual_space` の帰納法の主張 L_r(x) = S_r。 -/
theorem dualSpace_partialLinearCombination_apply (S : ComplexVectorSpace V) (f : ℕ → DualSpace S)
    (c : ℕ → ℂ) (x : V) (r : ℕ) :
    (partialLinearCombination (dualSpaceVectorSpace S) c f r).1 x
      = partialOrderedSum (fun k => c k * (f k).1 x) r := by
  induction r with
  | zero => calc
      (partialLinearCombination (dualSpaceVectorSpace S) c f 0).1 x
          = (DualSpace.zero S).1 x := rfl
      _ = zeroMap x := rfl
      _ = 0 := rfl
      _ = partialOrderedSum (fun k => c k * (f k).1 x) 0 := rfl
  | succ r ih => calc
      (partialLinearCombination (dualSpaceVectorSpace S) c f (r + 1)).1 x
          = (DualSpace.add S (partialLinearCombination (dualSpaceVectorSpace S) c f r)
              (DualSpace.smul S (c (r + 1)) (f (r + 1)))).1 x := rfl
      _ = pointwiseSum (partialLinearCombination (dualSpaceVectorSpace S) c f r).1
            (DualSpace.smul S (c (r + 1)) (f (r + 1))).1 x := rfl
      _ = (partialLinearCombination (dualSpaceVectorSpace S) c f r).1 x
            + (DualSpace.smul S (c (r + 1)) (f (r + 1))).1 x := rfl
      _ = partialOrderedSum (fun k => c k * (f k).1 x) r
            + (DualSpace.smul S (c (r + 1)) (f (r + 1))).1 x := by rw [ih]
      _ = partialOrderedSum (fun k => c k * (f k).1 x) r
            + pointwiseScalarMultiple (c (r + 1)) (f (r + 1)).1 x := rfl
      _ = partialOrderedSum (fun k => c k * (f k).1 x) r + c (r + 1) * (f (r + 1)).1 x := rfl
      _ = partialOrderedSum (fun k => c k * (f k).1 x) (r + 1) := rfl

/-- 本文 `claim_value_of_linear_combination_in_dual_space`：
(Σ λ_k ·_{V^*} f_k)(x) = Σ_{ℂ} λ_k ·_ℂ f_k(x)。 -/
theorem dualSpace_linearCombination_apply (S : ComplexVectorSpace V) (n : ℕ)
    (f : ℕ → DualSpace S) (c : ℕ → ℂ) (x : V) :
    (linearCombination (dualSpaceVectorSpace S) n c f).1 x
      = orderedSum n (fun k => c k * (f k).1 x) :=
  dualSpace_partialLinearCombination_apply S f c x n

/-- 本文 `claim_ordered_sums_in_complex_numbers_with_equal_terms_are_equal` の帰納法の主張
S_m = S'_m（m ≤ n）。 -/
theorem partialOrderedSum_congr (n : ℕ) (a a' : ℕ → ℂ) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → a k = a' k) :
    ∀ m : ℕ, m ≤ n → partialOrderedSum a m = partialOrderedSum a' m := by
  intro m
  induction m with
  | zero =>
    intro _
    calc partialOrderedSum a 0
        = (0 : ℂ) := rfl
      _ = partialOrderedSum a' 0 := rfl
  | succ m ih =>
    intro hm
    calc partialOrderedSum a (m + 1)
        = partialOrderedSum a m + a (m + 1) := rfl
      _ = partialOrderedSum a' m + a (m + 1) := by rw [ih (Nat.le_of_succ_le hm)]
      _ = partialOrderedSum a' m + a' (m + 1) := by rw [h (m + 1) (Nat.succ_pos m) hm]
      _ = partialOrderedSum a' (m + 1) := rfl

/-- 本文 `claim_ordered_sums_in_complex_numbers_with_equal_terms_are_equal`：
1,…,n の項が等しい二つの ℂ の中の番号順の和は等しい。 -/
theorem orderedSum_congr (n : ℕ) (a a' : ℕ → ℂ) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → a k = a' k) :
    orderedSum n a = orderedSum n a' :=
  partialOrderedSum_congr n a a' h n le_rfl

/-- 本文 `claim_ordered_sum_with_kronecker_delta_picks_term` の帰納法の主張
S_m = 0_ℂ（m < j）、α_j（m ≥ j）。 -/
theorem partialOrderedSum_mul_kroneckerDelta (a : ℕ → ℂ) (j : ℕ) (hj : 1 ≤ j) (m : ℕ) :
    partialOrderedSum (fun k => a k * kroneckerDelta k j) m = if m < j then 0 else a j := by
  induction m with
  | zero => rw [if_pos (show 0 < j from hj)]; rfl
  | succ m ih =>
    rcases Nat.lt_trichotomy (m + 1) j with hlt | heq | hgt
    · have hm : m < j := Nat.lt_of_succ_lt hlt
      have hne : m + 1 ≠ j := Nat.ne_of_lt hlt
      rw [if_pos hlt]
      calc partialOrderedSum (fun k => a k * kroneckerDelta k j) (m + 1)
          = partialOrderedSum (fun k => a k * kroneckerDelta k j) m
              + a (m + 1) * kroneckerDelta (m + 1) j := rfl
        _ = 0 + a (m + 1) * kroneckerDelta (m + 1) j := by rw [ih, if_pos hm]
        _ = 0 + a (m + 1) * 0 := by rw [kroneckerDelta, if_neg hne]
        _ = 0 + 0 := by rw [mul_zero (a (m + 1))]
        _ = 0 := by rw [_root_.add_zero (0 : ℂ)]
    · have hm : m < j := by omega
      rw [if_neg (by omega)]
      calc partialOrderedSum (fun k => a k * kroneckerDelta k j) (m + 1)
          = partialOrderedSum (fun k => a k * kroneckerDelta k j) m
              + a (m + 1) * kroneckerDelta (m + 1) j := rfl
        _ = 0 + a (m + 1) * kroneckerDelta (m + 1) j := by rw [ih, if_pos hm]
        _ = 0 + a (m + 1) * 1 := by rw [kroneckerDelta, if_pos heq]
        _ = 0 + a (m + 1) := by rw [mul_one (a (m + 1))]
        _ = a (m + 1) := by rw [zero_add (a (m + 1))]
        _ = a j := by rw [heq]
    · have hm : ¬ m < j := by omega
      have hne : m + 1 ≠ j := Nat.ne_of_gt hgt
      rw [if_neg (Nat.not_lt_of_gt hgt)]
      calc partialOrderedSum (fun k => a k * kroneckerDelta k j) (m + 1)
          = partialOrderedSum (fun k => a k * kroneckerDelta k j) m
              + a (m + 1) * kroneckerDelta (m + 1) j := rfl
        _ = a j + a (m + 1) * kroneckerDelta (m + 1) j := by rw [ih, if_neg hm]
        _ = a j + a (m + 1) * 0 := by rw [kroneckerDelta, if_neg hne]
        _ = a j + 0 := by rw [mul_zero (a (m + 1))]
        _ = a j := by rw [_root_.add_zero (a j)]

/-- 本文 `claim_ordered_sum_with_kronecker_delta_picks_term`：Σ_{ℂ} α_k ·_ℂ δ_{k,j} = α_j（1 ≤ j ≤ n）。 -/
theorem orderedSum_mul_kroneckerDelta (n : ℕ) (a : ℕ → ℂ) (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) :
    orderedSum n (fun k => a k * kroneckerDelta k j) = a j := by
  have h := partialOrderedSum_mul_kroneckerDelta a j hj1 n
  rw [if_neg (Nat.not_lt_of_ge hjn)] at h
  exact h

/-- 本文 `claim_dual_basis_spans_dual_space`：g = Σ g(b_k) ·_{V^*} f_k（V^* の等式）。 -/
theorem dualBasis_spans (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b)
    (f : ℕ → DualSpace S) (hf : IsDualBasis S n b f) (g : DualSpace S) :
    g = linearCombination (dualSpaceVectorSpace S) n (fun k => g.1 (b k)) f := by
  -- h := Σ g(b_k) ·_{V^*} f_k
  have hbasis : ∀ j : ℕ, 1 ≤ j → j ≤ n →
      (linearCombination (dualSpaceVectorSpace S) n (fun k => g.1 (b k)) f).1 (b j) = g.1 (b j) := by
    intro j hj1 hjn
    calc (linearCombination (dualSpaceVectorSpace S) n (fun k => g.1 (b k)) f).1 (b j)
        = orderedSum n (fun k => g.1 (b k) * (f k).1 (b j)) :=
          dualSpace_linearCombination_apply S n f (fun k => g.1 (b k)) (b j)
      _ = orderedSum n (fun k => g.1 (b k) * kroneckerDelta k j) :=
          orderedSum_congr n _ _ (fun k hk1 hkn => by rw [hf k j hk1 hkn hj1 hjn])
      _ = g.1 (b j) := orderedSum_mul_kroneckerDelta n (fun k => g.1 (b k)) j hj1 hjn
  symm
  apply DualSpace.ext
  intro x
  obtain ⟨μ, hμ⟩ := hb.spans x
  calc (linearCombination (dualSpaceVectorSpace S) n (fun k => g.1 (b k)) f).1 x
      = (linearCombination (dualSpaceVectorSpace S) n (fun k => g.1 (b k)) f).1
          (linearCombination S n μ b) := by rw [hμ]
    _ = orderedSum n (fun k => μ k *
          (linearCombination (dualSpaceVectorSpace S) n (fun k => g.1 (b k)) f).1 (b k)) :=
        (linearCombination (dualSpaceVectorSpace S) n (fun k => g.1 (b k)) f).2.map_linearCombination
          n b μ
    _ = orderedSum n (fun k => μ k * g.1 (b k)) :=
        orderedSum_congr n _ _ (fun k hk1 hkn => by rw [hbasis k hk1 hkn])
    _ = g.1 (linearCombination S n μ b) := (g.2.map_linearCombination n b μ).symm
    _ = g.1 x := by rw [hμ]

/-- 本文 `claim_dual_basis_is_linearly_independent`。本文の仮定のうち b が基底であることは証明で使わないので、
仮定に置かない（本文の主張はここから直ちに従う）。 -/
theorem dualBasis_linearlyIndependent (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (f : ℕ → DualSpace S) (hf : IsDualBasis S n b f) :
    IsLinearlyIndependentFamily (dualSpaceVectorSpace S) n f := by
  intro c hc j hj1 hjn
  calc c j = orderedSum n (fun k => c k * kroneckerDelta k j) :=
        (orderedSum_mul_kroneckerDelta n c j hj1 hjn).symm
    _ = orderedSum n (fun k => c k * (f k).1 (b j)) :=
        orderedSum_congr n _ _ (fun k hk1 hkn => by rw [hf k j hk1 hkn hj1 hjn])
    _ = (linearCombination (dualSpaceVectorSpace S) n c f).1 (b j) :=
        (dualSpace_linearCombination_apply S n f c (b j)).symm
    _ = (DualSpace.zero S).1 (b j) := congrArg (fun h : DualSpace S => h.1 (b j)) hc
    _ = zeroMap (b j) := rfl
    _ = 0 := rfl

/-- 本文 `claim_dual_basis_is_basis_of_dual_space`。 -/
theorem dualBasis_isBasis (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b)
    (f : ℕ → DualSpace S) (hf : IsDualBasis S n b f) :
    IsBasisFamily (dualSpaceVectorSpace S) n f where
  linearlyIndependent := dualBasis_linearlyIndependent S n b f hf
  spans g := ⟨fun k => g.1 (b k), (dualBasis_spans S n b hb f hf g).symm⟩

end CliffordMatrixIsomorphism.ComplexVectorSpace
