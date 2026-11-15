/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」の前半（直交基底の存在まで）の具体版。
人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                              このファイル
  claim_one_plus_one_is_nonzero_in_complex_numbers                          complex_one_add_one_ne_zero
  claim_polarization_of_quadratic_form_is_linear_in_second_argument         polarization_isLinearForm_right
  claim_polarization_of_quadratic_form_on_diagonal_is_twice_value           polarization_self
  claim_quadratic_form_at_sum_with_scalar_multiple                          quadraticForm_add_smul
  claim_member_of_linearly_independent_family_is_nonzero                    linearlyIndependent_member_ne_zero
  claim_ordered_sum_of_zero_terms_is_zero                                   partialOrderedSum_eq_zero_of_terms_eq_zero・
                                                                            orderedSum_eq_zero_of_terms_eq_zero
  claim_element_orthogonal_to_spanning_family_is_zero                       eq_zero_of_polarization_eq_zero_on_spanning
  def_family_adding_multiples_of_one_member                                 addMultiplesOfMember（b^{(s,ω)}）
  claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged addMultiplesOfMember_of_coefficient_eq_zero
  claim_linear_combination_of_family_adding_multiples_of_one_member         partialLinearCombination_addMultiplesOfMember・
                                                                            linearCombination_addMultiplesOfMember
  claim_family_adding_multiples_of_one_member_to_basis_is_basis             addMultiplesOfMember_isBasis
  def_basis_orthogonalized_up_to_index                                      IsOrthogonalizedUpTo
  claim_orthogonalized_basis_can_be_modified_so_next_member_has_nonzero_value
                                                                            exists_orthogonalized_with_nonzero_next
  claim_polarization_on_diagonal_is_nonzero_when_value_is_nonzero           polarization_self_ne_zero
  claim_orthogonalization_step_extends_orthogonalized_part                  orthogonalizationCoefficient（ω）・
                                                                            orthogonalizationStep_isOrthogonalized
  claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form      exists_orthogonal_basis

表し方:
- 番号付けた族は `ℕ → V`、写像 ω:{1,…,n}→ℂ は `ℕ → ℂ` で表し、1,…,n の外の値は使わない。
- 本文の「第 k 元まで直交化された基底」は、基底であることを欄 `isBasis` に持つ（本文の定義は「e を基底とし…」で、
  存在を述べる主張が基底であることまで要るため）。
- 本文の d^{-1}・t^{-1}（0 でない ℂ の元の乗法の逆元）は ℂ の `d⁻¹` で、d^{-1} ·_ℂ d = 1_ℂ は `inv_mul_cancel₀` である。
- 本文の「ℂ の中で 0 でない二つの元の積は 0 でない」は `mul_ne_zero` である。

必要十分版は `NecSuf/Isomorphism/GeneralEvenDimensional/OrthogonalBasis.lean`、導出版は `OrthogonalBasisFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.QuadraticForm.QuadraticForm
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.CoordinatesAndDualBasis

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {V : Type u}

/-- 本文 `claim_one_plus_one_is_nonzero_in_complex_numbers`：ℂ の中で 1_ℂ +_ℂ 1_ℂ ≠ 0_ℂ。
本文はこれを ℂ の四則の前提の一つとして置く。 -/
theorem complex_one_add_one_ne_zero : (1 : ℂ) + 1 ≠ 0 := by norm_num

/-- 本文 `claim_polarization_of_quadratic_form_is_linear_in_second_argument`：
二次形式 q について、各 x で B_q(x, •) は線型形式である。 -/
theorem polarization_isLinearForm_right (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsQuadraticForm S q) (x : V) : IsComplexLinearForm S (fun y => polarization S q x y) where
  map_add y y' := calc
    polarization S q x (S.add y y') = polarization S q (S.add y y') x := polarization_symm S q x (S.add y y')
    _ = polarization S q y x + polarization S q y' x := (hq.polarization_isLinearForm x).map_add y y'
    _ = polarization S q x y + polarization S q x y' := by
        rw [polarization_symm S q y x, polarization_symm S q y' x]
  map_smul l y := calc
    polarization S q x (S.smul l y) = polarization S q (S.smul l y) x := polarization_symm S q x (S.smul l y)
    _ = l * polarization S q y x := (hq.polarization_isLinearForm x).map_smul l y
    _ = l * polarization S q x y := by rw [polarization_symm S q y x]

/-- 本文 `claim_polarization_of_quadratic_form_on_diagonal_is_twice_value`：B_q(x, x) = (1_ℂ +_ℂ 1_ℂ) ·_ℂ q(x)。
本文どおり τ := 1_ℂ +_ℂ 1_ℂ、a := q(x) と置き、二つの準備の等式を先に置く。 -/
theorem polarization_self (S : ComplexVectorSpace V) (q : V → ℂ) (hq : IsQuadraticForm S q) (x : V) :
    polarization S q x x = (1 + 1) * q x := by
  let τ : ℂ := 1 + 1
  let a : ℂ := q x
  have hτ : ∀ z : ℂ, τ * z = z + z := fun z => calc
    τ * z = (1 + 1) * z := rfl
    _ = 1 * z + 1 * z := by rw [add_mul (1 : ℂ) 1 z]
    _ = z + z := by rw [one_mul z]
  have hxx : S.add x x = S.smul τ x := calc
    S.add x x = S.add (S.smul 1 x) (S.smul 1 x) := by rw [S.one_smul x]
    _ = S.smul (1 + 1) x := by rw [S.add_smul 1 1 x]
    _ = S.smul τ x := rfl
  calc polarization S q x x
      = 0 + polarization S q x x := by rw [_root_.zero_add (polarization S q x x)]
    _ = (-(τ * a) + τ * a) + polarization S q x x := by rw [neg_add_cancel (τ * a)]
    _ = -(τ * a) + (τ * a + polarization S q x x) := by
        rw [_root_.add_assoc (-(τ * a)) (τ * a) (polarization S q x x)]
    _ = -(τ * a) + ((a + a) + polarization S q x x) := by rw [hτ a]
    _ = -(τ * a) + q (S.add x x) := by rw [polarization_identity S q x x]
    _ = -(τ * a) + q (S.smul τ x) := by rw [hxx]
    _ = -(τ * a) + τ * (τ * a) := by rw [hq.map_smul τ x]
    _ = -(τ * a) + (τ * a + τ * a) := by rw [hτ (τ * a)]
    _ = (-(τ * a) + τ * a) + τ * a := by rw [← _root_.add_assoc (-(τ * a)) (τ * a) (τ * a)]
    _ = 0 + τ * a := by rw [neg_add_cancel (τ * a)]
    _ = τ * a := by rw [_root_.zero_add (τ * a)]
    _ = (1 + 1) * q x := rfl

/-- 本文 `claim_quadratic_form_at_sum_with_scalar_multiple`：
q(x +_V t ·_V y) = (q(x) +_ℂ t ·_ℂ (t ·_ℂ q(y))) +_ℂ t ·_ℂ B_q(x, y)。 -/
theorem quadraticForm_add_smul (S : ComplexVectorSpace V) (q : V → ℂ) (hq : IsQuadraticForm S q)
    (x y : V) (t : ℂ) :
    q (S.add x (S.smul t y)) = (q x + t * (t * q y)) + t * polarization S q x y := calc
  q (S.add x (S.smul t y)) = (q x + q (S.smul t y)) + polarization S q x (S.smul t y) :=
      (polarization_identity S q x (S.smul t y)).symm
  _ = (q x + t * (t * q y)) + polarization S q x (S.smul t y) := by rw [hq.map_smul t y]
  _ = (q x + t * (t * q y)) + t * polarization S q x y := by
      rw [(polarization_isLinearForm_right S q hq x).map_smul t y]

/-- 本文 `claim_member_of_linearly_independent_family_is_nonzero`：一次独立な族 b について b_j ≠ 0_V（1 ≤ j ≤ n）。
本文の前提 n ∈ ℤ_{≥1} は、1 ≤ j ≤ n から従うので仮定に置かない。 -/
theorem linearlyIndependent_member_ne_zero (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsLinearlyIndependentFamily S n b) (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) : b j ≠ S.zero := by
  intro hbj
  have hlc : linearCombination S n (fun k => kroneckerDelta k j) b = S.zero := calc
    linearCombination S n (fun k => kroneckerDelta k j) b = b j := linearCombination_kroneckerDelta S n b j hj1 hjn
    _ = S.zero := hbj
  have h0 : (kroneckerDelta j j : ℂ) = 0 := hb (fun k => kroneckerDelta k j) hlc j hj1 hjn
  have h1 : (kroneckerDelta j j : ℂ) = 1 := if_pos rfl
  exact one_ne_zero (h1.symm.trans h0)

/-- 本文 `claim_ordered_sum_of_zero_terms_is_zero` の帰納法の主張 S_m = 0_ℂ（m ≤ n）。 -/
theorem partialOrderedSum_eq_zero_of_terms_eq_zero (n : ℕ) (a : ℕ → ℂ)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → a k = 0) : ∀ m : ℕ, m ≤ n → partialOrderedSum a m = 0 := by
  intro m
  induction m with
  | zero => intro _; rfl
  | succ m ih =>
    intro hm
    calc partialOrderedSum a (m + 1)
        = partialOrderedSum a m + a (m + 1) := rfl
      _ = 0 + a (m + 1) := by rw [ih (Nat.le_of_succ_le hm)]
      _ = 0 + 0 := by rw [h (m + 1) (Nat.succ_pos m) hm]
      _ = 0 := by rw [_root_.add_zero (0 : ℂ)]

/-- 本文 `claim_ordered_sum_of_zero_terms_is_zero`：どの項も 0_ℂ なら Σ_{ℂ,k=1}^{n} α_k = 0_ℂ。 -/
theorem orderedSum_eq_zero_of_terms_eq_zero (n : ℕ) (a : ℕ → ℂ) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → a k = 0) :
    orderedSum n a = 0 :=
  partialOrderedSum_eq_zero_of_terms_eq_zero n a h n le_rfl

/-- 本文 `claim_element_orthogonal_to_spanning_family_is_zero`：非退化な二次形式 q と V を張る族 b について、
すべての k で B_q(x, b_k) = 0_ℂ なら x = 0_V。 -/
theorem eq_zero_of_polarization_eq_zero_on_spanning (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsNondegenerateQuadraticForm S q) (n : ℕ) (b : ℕ → V) (hb : SpansByLinearCombination S n b)
    (x : V) (hx : ∀ k : ℕ, 1 ≤ k → k ≤ n → polarization S q x (b k) = 0) : x = S.zero := by
  apply hq.nondegenerate x
  intro y
  obtain ⟨μ, hμ⟩ := hb y
  have hterm : ∀ k : ℕ, 1 ≤ k → k ≤ n → μ k * polarization S q x (b k) = 0 := fun k hk1 hkn => calc
    μ k * polarization S q x (b k) = μ k * 0 := by rw [hx k hk1 hkn]
    _ = 0 := mul_zero (μ k)
  calc polarization S q x y
      = polarization S q x (linearCombination S n μ b) := by rw [hμ]
    _ = orderedSum n (fun k => μ k * polarization S q x (b k)) :=
        (polarization_isLinearForm_right S q hq.isQuadraticForm x).map_linearCombination n b μ
    _ = 0 := orderedSum_eq_zero_of_terms_eq_zero n _ hterm

/-- 本文 `def_family_adding_multiples_of_one_member`：b^{(s,ω)}_r := b_r +_V (ω_r ·_V b_s)。 -/
def addMultiplesOfMember (S : ComplexVectorSpace V) (b : ℕ → V) (s : ℕ) (ω : ℕ → ℂ) : ℕ → V :=
  fun r => S.add (b r) (S.smul (ω r) (b s))

/-- 本文 `claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged`：
ω_r = 0_ℂ なら b^{(s,ω)}_r = b_r。 -/
theorem addMultiplesOfMember_of_coefficient_eq_zero (S : ComplexVectorSpace V) (b : ℕ → V) (s : ℕ)
    (ω : ℕ → ℂ) (r : ℕ) (hr : ω r = 0) : addMultiplesOfMember S b s ω r = b r := calc
  addMultiplesOfMember S b s ω r = S.add (b r) (S.smul (ω r) (b s)) := rfl
  _ = S.add (b r) (S.smul 0 (b s)) := by rw [hr]
  _ = S.add (b r) S.zero := by rw [zero_smul_eq_zero S (b s)]
  _ = b r := S.add_zero (b r)

/-- 本文 `claim_linear_combination_of_family_adding_multiples_of_one_member` の帰納法の主張
L'_m = L_m +_V (S_m ·_V b_s)。本文どおり A := L_{m-1}、σ := S_{m-1} と置く。 -/
theorem partialLinearCombination_addMultiplesOfMember (S : ComplexVectorSpace V) (b : ℕ → V) (s : ℕ)
    (ω ν : ℕ → ℂ) (m : ℕ) :
    partialLinearCombination S ν (addMultiplesOfMember S b s ω) m
      = S.add (partialLinearCombination S ν b m)
          (S.smul (partialOrderedSum (fun k => ν k * ω k) m) (b s)) := by
  induction m with
  | zero => calc
      partialLinearCombination S ν (addMultiplesOfMember S b s ω) 0 = S.zero := rfl
      _ = S.add S.zero S.zero := by rw [S.add_zero S.zero]
      _ = S.add S.zero (S.smul 0 (b s)) := by rw [zero_smul_eq_zero S (b s)]
      _ = S.add (partialLinearCombination S ν b 0)
            (S.smul (partialOrderedSum (fun k => ν k * ω k) 0) (b s)) := rfl
  | succ m ih =>
    let A : V := partialLinearCombination S ν b m
    let σ : ℂ := partialOrderedSum (fun k => ν k * ω k) m
    let bs : V := b s
    let bm : V := b (m + 1)
    let νm : ℂ := ν (m + 1)
    let ωm : ℂ := ω (m + 1)
    calc partialLinearCombination S ν (addMultiplesOfMember S b s ω) (m + 1)
        = S.add (partialLinearCombination S ν (addMultiplesOfMember S b s ω) m)
            (S.smul νm (addMultiplesOfMember S b s ω (m + 1))) := rfl
      _ = S.add (S.add A (S.smul σ bs)) (S.smul νm (addMultiplesOfMember S b s ω (m + 1))) := by rw [ih]
      _ = S.add (S.add A (S.smul σ bs)) (S.smul νm (S.add bm (S.smul ωm bs))) := rfl
      _ = S.add (S.add A (S.smul σ bs)) (S.add (S.smul νm bm) (S.smul νm (S.smul ωm bs))) := by
          rw [S.smul_add νm bm (S.smul ωm bs)]
      _ = S.add (S.add A (S.smul σ bs)) (S.add (S.smul νm bm) (S.smul (νm * ωm) bs)) := by
          rw [S.smul_assoc νm ωm bs]
      _ = S.add A (S.add (S.smul σ bs) (S.add (S.smul νm bm) (S.smul (νm * ωm) bs))) := by
          rw [S.add_assoc A (S.smul σ bs) (S.add (S.smul νm bm) (S.smul (νm * ωm) bs))]
      _ = S.add A (S.add (S.add (S.smul σ bs) (S.smul νm bm)) (S.smul (νm * ωm) bs)) := by
          rw [S.add_assoc (S.smul σ bs) (S.smul νm bm) (S.smul (νm * ωm) bs)]
      _ = S.add A (S.add (S.add (S.smul νm bm) (S.smul σ bs)) (S.smul (νm * ωm) bs)) := by
          rw [S.add_comm (S.smul σ bs) (S.smul νm bm)]
      _ = S.add A (S.add (S.smul νm bm) (S.add (S.smul σ bs) (S.smul (νm * ωm) bs))) := by
          rw [S.add_assoc (S.smul νm bm) (S.smul σ bs) (S.smul (νm * ωm) bs)]
      _ = S.add (S.add A (S.smul νm bm)) (S.add (S.smul σ bs) (S.smul (νm * ωm) bs)) := by
          rw [S.add_assoc A (S.smul νm bm) (S.add (S.smul σ bs) (S.smul (νm * ωm) bs))]
      _ = S.add (S.add A (S.smul νm bm)) (S.smul (σ + νm * ωm) bs) := by
          rw [S.add_smul σ (νm * ωm) bs]
      _ = S.add (partialLinearCombination S ν b (m + 1)) (S.smul (σ + νm * ωm) bs) := rfl
      _ = S.add (partialLinearCombination S ν b (m + 1))
            (S.smul (partialOrderedSum (fun k => ν k * ω k) (m + 1)) (b s)) := rfl

/-- 本文 `claim_linear_combination_of_family_adding_multiples_of_one_member`：
Σ ν_k ·_V b^{(s,ω)}_k = (Σ ν_k ·_V b_k) +_V (Σ_{ℂ} ν_k ·_ℂ ω_k) ·_V b_s。 -/
theorem linearCombination_addMultiplesOfMember (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) (s : ℕ)
    (ω ν : ℕ → ℂ) :
    linearCombination S n ν (addMultiplesOfMember S b s ω)
      = S.add (linearCombination S n ν b) (S.smul (orderedSum n (fun k => ν k * ω k)) (b s)) :=
  partialLinearCombination_addMultiplesOfMember S b s ω ν n

/-- 本文 `claim_family_adding_multiples_of_one_member_to_basis_is_basis`：b が基底で ω_s = 0_ℂ なら
b^{(s,ω)} は基底である。本文の前提 s ∈ {1,…,n} を 1 ≤ s、s ≤ n で書く。 -/
theorem addMultiplesOfMember_isBasis (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (s : ℕ) (hs1 : 1 ≤ s) (hsn : s ≤ n) (ω : ℕ → ℂ) (hωs : ω s = 0) :
    IsBasisFamily S n (addMultiplesOfMember S b s ω) := by
  have hbs : addMultiplesOfMember S b s ω s = b s :=
    addMultiplesOfMember_of_coefficient_eq_zero S b s ω s hωs
  constructor
  · -- 一次独立
    intro ν hν
    let σ : ℂ := orderedSum n (fun k => ν k * ω k)
    have h0 : S.zero = linearCombination S n (fun k => ν k + σ * kroneckerDelta k s) b := calc
      S.zero = linearCombination S n ν (addMultiplesOfMember S b s ω) := hν.symm
      _ = S.add (linearCombination S n ν b) (S.smul σ (b s)) :=
          linearCombination_addMultiplesOfMember S n b s ω ν
      _ = S.add (linearCombination S n ν b)
            (S.smul σ (linearCombination S n (fun k => kroneckerDelta k s) b)) := by
          rw [linearCombination_kroneckerDelta S n b s hs1 hsn]
      _ = S.add (linearCombination S n ν b)
            (linearCombination S n (fun k => σ * kroneckerDelta k s) b) := by
          rw [smul_linearCombination S n b (fun k => kroneckerDelta k s) σ]
      _ = linearCombination S n (fun k => ν k + σ * kroneckerDelta k s) b :=
          linearCombination_add_of_same_family S n b ν (fun k => σ * kroneckerDelta k s)
    -- (*)
    have hstar : ∀ k : ℕ, 1 ≤ k → k ≤ n → ν k + σ * kroneckerDelta k s = 0 :=
      hb.linearlyIndependent (fun k => ν k + σ * kroneckerDelta k s) h0.symm
    have hne : ∀ k : ℕ, 1 ≤ k → k ≤ n → k ≠ s → ν k = 0 := fun k hk1 hkn hks => calc
      ν k = ν k + 0 := by rw [_root_.add_zero (ν k)]
      _ = ν k + σ * 0 := by rw [mul_zero σ]
      _ = ν k + σ * kroneckerDelta k s := by rw [kroneckerDelta, if_neg hks]
      _ = 0 := hstar k hk1 hkn
    have hσ : σ = 0 := orderedSum_eq_zero_of_terms_eq_zero n (fun k => ν k * ω k) (by
      intro k hk1 hkn
      by_cases hks : k = s
      · show ν k * ω k = 0
        rw [hks, hωs, mul_zero (ν s)]
      · show ν k * ω k = 0
        rw [hne k hk1 hkn hks, zero_mul (ω k)])
    intro k hk1 hkn
    by_cases hks : k = s
    · subst hks
      calc ν k = ν k + 0 := by rw [_root_.add_zero (ν k)]
        _ = ν k + 0 * kroneckerDelta k k := by rw [zero_mul (kroneckerDelta k k : ℂ)]
        _ = ν k + σ * kroneckerDelta k k := by rw [hσ]
        _ = 0 := hstar k hk1 hkn
    · exact hne k hk1 hkn hks
  · -- 張る
    intro x
    obtain ⟨μ, hμ⟩ := hb.spans x
    let ρ : ℂ := orderedSum n (fun k => μ k * ω k)
    refine ⟨fun k => μ k + (-ρ) * kroneckerDelta k s, ?_⟩
    let b' : ℕ → V := addMultiplesOfMember S b s ω
    calc linearCombination S n (fun k => μ k + (-ρ) * kroneckerDelta k s) b'
        = S.add (linearCombination S n μ b')
            (linearCombination S n (fun k => (-ρ) * kroneckerDelta k s) b') :=
          (linearCombination_add_of_same_family S n b' μ (fun k => (-ρ) * kroneckerDelta k s)).symm
      _ = S.add (linearCombination S n μ b')
            (S.smul (-ρ) (linearCombination S n (fun k => kroneckerDelta k s) b')) := by
          rw [smul_linearCombination S n b' (fun k => kroneckerDelta k s) (-ρ)]
      _ = S.add (linearCombination S n μ b') (S.smul (-ρ) (b' s)) := by
          rw [linearCombination_kroneckerDelta S n b' s hs1 hsn]
      _ = S.add (linearCombination S n μ b') (S.smul (-ρ) (b s)) := by
          rw [show b' s = b s from hbs]
      _ = S.add (S.add (linearCombination S n μ b) (S.smul ρ (b s))) (S.smul (-ρ) (b s)) := by
          rw [linearCombination_addMultiplesOfMember S n b s ω μ]
      _ = S.add (linearCombination S n μ b) (S.add (S.smul ρ (b s)) (S.smul (-ρ) (b s))) :=
          S.add_assoc (linearCombination S n μ b) (S.smul ρ (b s)) (S.smul (-ρ) (b s))
      _ = S.add (linearCombination S n μ b) (S.smul (ρ + -ρ) (b s)) := by rw [S.add_smul ρ (-ρ) (b s)]
      _ = S.add (linearCombination S n μ b) (S.smul 0 (b s)) := by rw [add_neg_cancel ρ]
      _ = S.add (linearCombination S n μ b) S.zero := by rw [zero_smul_eq_zero S (b s)]
      _ = linearCombination S n μ b := S.add_zero (linearCombination S n μ b)
      _ = x := hμ

/-- 本文 `def_basis_orthogonalized_up_to_index`：q について第 k 元まで直交化された基底。
本文の前提「e は V の基底」を欄 `isBasis` に置き、三つの条件を残りの欄に置く。 -/
structure IsOrthogonalizedUpTo (S : ComplexVectorSpace V) (q : V → ℂ) (n : ℕ) (e : ℕ → V) (k : ℕ) :
    Prop where
  isBasis : IsBasisFamily S n e
  /-- 一つ目の条件 -/
  orthogonal_before : ∀ i i' : ℕ, 1 ≤ i → i ≤ k → 1 ≤ i' → i' ≤ k → i ≠ i' →
    polarization S q (e i) (e i') = 0
  /-- 二つ目の条件 -/
  value_ne_zero : ∀ i : ℕ, 1 ≤ i → i ≤ k → q (e i) ≠ 0
  /-- 三つ目の条件 -/
  orthogonal_after : ∀ i j : ℕ, 1 ≤ i → i ≤ k → k + 1 ≤ j → j ≤ n → polarization S q (e i) (e j) = 0

/-- 本文 `claim_orthogonalized_basis_can_be_modified_so_next_member_has_nonzero_value`：
q が非退化で、e が第 k 元まで直交化された基底（k + 1 ≤ n）なら、第 k 元まで直交化された基底 ẽ で
q(ẽ_{k+1}) ≠ 0_ℂ を満たすものがある。 -/
theorem exists_orthogonalized_with_nonzero_next (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsNondegenerateQuadraticForm S q) (n k : ℕ) (hk : k + 1 ≤ n) (e : ℕ → V)
    (he : IsOrthogonalizedUpTo S q n e k) :
    ∃ e' : ℕ → V, IsOrthogonalizedUpTo S q n e' k ∧ q (e' (k + 1)) ≠ 0 := by
  by_cases hzero : q (e (k + 1)) ≠ 0
  · exact ⟨e, he, hzero⟩
  have hzero : q (e (k + 1)) = 0 := not_not.mp hzero
  have hq' : IsQuadraticForm S q := hq.isQuadraticForm
  -- 第 k+1 元と直交しない元が後ろにあること
  have hexists : ∃ j : ℕ, k + 2 ≤ j ∧ j ≤ n ∧ polarization S q (e (k + 1)) (e j) ≠ 0 := by
    by_contra hnone
    have hafter : ∀ j : ℕ, k + 2 ≤ j → j ≤ n → polarization S q (e (k + 1)) (e j) = 0 := by
      intro j hj2 hjn
      by_contra hj
      exact hnone ⟨j, hj2, hjn, hj⟩
    have hall : ∀ j : ℕ, 1 ≤ j → j ≤ n → polarization S q (e (k + 1)) (e j) = 0 := by
      intro j hj1 hjn
      rcases Nat.lt_trichotomy j (k + 1) with hlt | heq | hgt
      · calc polarization S q (e (k + 1)) (e j)
            = polarization S q (e j) (e (k + 1)) := polarization_symm S q (e (k + 1)) (e j)
          _ = 0 := he.orthogonal_after j (k + 1) hj1 (Nat.le_of_lt_succ hlt) le_rfl hk
      · subst heq
        calc polarization S q (e (k + 1)) (e (k + 1))
            = (1 + 1) * q (e (k + 1)) := polarization_self S q hq' (e (k + 1))
          _ = (1 + 1) * 0 := by rw [hzero]
          _ = 0 := mul_zero (1 + 1 : ℂ)
      · exact hafter j hgt hjn
    have hz : e (k + 1) = S.zero :=
      eq_zero_of_polarization_eq_zero_on_spanning S q hq n e he.isBasis.spans (e (k + 1)) hall
    exact linearlyIndependent_member_ne_zero S n e he.isBasis.linearlyIndependent (k + 1)
      (Nat.succ_pos k) hk hz
  obtain ⟨j, hj2, hjn, hβ⟩ := hexists
  let β : ℂ := polarization S q (e (k + 1)) (e j)
  let ζ : ℂ := q (e j)
  -- 足す倍の係数の選び方
  have hvalue : ∀ t : ℂ, t * t = 1 → q (S.add (e (k + 1)) (S.smul t (e j))) = ζ + t * β := by
    intro t ht
    calc q (S.add (e (k + 1)) (S.smul t (e j)))
        = (q (e (k + 1)) + t * (t * q (e j))) + t * polarization S q (e (k + 1)) (e j) :=
          quadraticForm_add_smul S q hq' (e (k + 1)) (e j) t
      _ = (0 + t * (t * q (e j))) + t * polarization S q (e (k + 1)) (e j) := by rw [hzero]
      _ = (0 + t * (t * ζ)) + t * polarization S q (e (k + 1)) (e j) := rfl
      _ = (0 + t * (t * ζ)) + t * β := rfl
      _ = t * (t * ζ) + t * β := by rw [_root_.zero_add (t * (t * ζ))]
      _ = (t * t) * ζ + t * β := by rw [← mul_assoc t t ζ]
      _ = 1 * ζ + t * β := by rw [ht]
      _ = ζ + t * β := by rw [one_mul ζ]
  -- 二つの t でともに値が 0 なら矛盾
  have htwo : ζ + 1 * β = 0 → ζ + (-1) * β = 0 → (1 + 1) * β = 0 := by
    intro h1 h2
    have hprep : (-1) * (ζ + (-1) * β) = -ζ + 1 * β := calc
      (-1) * (ζ + (-1) * β) = (-1) * ζ + (-1) * ((-1) * β) := by rw [mul_add (-1 : ℂ) ζ ((-1) * β)]
      _ = -ζ + (-1) * ((-1) * β) := by rw [neg_one_mul ζ]
      _ = -ζ + ((-1) * (-1)) * β := by rw [← mul_assoc (-1 : ℂ) (-1) β]
      _ = -ζ + 1 * β := by rw [show ((-1 : ℂ) * (-1)) = 1 by norm_num]
    calc (1 + 1) * β
        = 1 * β + 1 * β := by rw [add_mul (1 : ℂ) 1 β]
      _ = (0 + 1 * β) + 1 * β := by rw [_root_.zero_add (1 * β)]
      _ = ((ζ + -ζ) + 1 * β) + 1 * β := by rw [add_neg_cancel ζ]
      _ = (ζ + (-ζ + 1 * β)) + 1 * β := by rw [_root_.add_assoc ζ (-ζ) (1 * β)]
      _ = (ζ + (1 * β + -ζ)) + 1 * β := by rw [_root_.add_comm (-ζ) (1 * β)]
      _ = ((ζ + 1 * β) + -ζ) + 1 * β := by rw [← _root_.add_assoc ζ (1 * β) (-ζ)]
      _ = (ζ + 1 * β) + (-ζ + 1 * β) := by rw [_root_.add_assoc (ζ + 1 * β) (-ζ) (1 * β)]
      _ = (ζ + 1 * β) + (-1) * (ζ + (-1) * β) := by rw [hprep]
      _ = 0 + (-1) * 0 := by rw [h1, h2]
      _ = 0 + 0 := by rw [mul_zero (-1 : ℂ)]
      _ = 0 := by rw [_root_.add_zero (0 : ℂ)]
  have hchoice : ∃ t : ℂ, t * t = 1 ∧ ζ + t * β ≠ 0 := by
    by_cases h1 : ζ + 1 * β = 0
    · by_cases h2 : ζ + (-1) * β = 0
      · exact absurd (htwo h1 h2) (mul_ne_zero complex_one_add_one_ne_zero hβ)
      · exact ⟨-1, by norm_num, h2⟩
    · exact ⟨1, by norm_num, h1⟩
  obtain ⟨t, htt, hζt⟩ := hchoice
  have hqt : q (S.add (e (k + 1)) (S.smul t (e j))) ≠ 0 := by rw [hvalue t htt]; exact hζt
  -- 取り替えた族
  let ω : ℕ → ℂ := fun r => if r = k + 1 then t else 0
  have hωj : ω j = 0 := if_neg (by omega)
  have hunchanged : ∀ r : ℕ, r ≠ k + 1 → addMultiplesOfMember S e j ω r = e r :=
    fun r hr => addMultiplesOfMember_of_coefficient_eq_zero S e j ω r (if_neg hr)
  have hnext : addMultiplesOfMember S e j ω (k + 1) = S.add (e (k + 1)) (S.smul t (e j)) := by
    show S.add (e (k + 1)) (S.smul (ω (k + 1)) (e j)) = S.add (e (k + 1)) (S.smul t (e j))
    rw [show ω (k + 1) = t from if_pos rfl]
  refine ⟨addMultiplesOfMember S e j ω, ?_, by rw [hnext]; exact hqt⟩
  refine {
    isBasis := addMultiplesOfMember_isBasis S n e he.isBasis j (by omega) hjn ω hωj
    orthogonal_before := ?_
    value_ne_zero := ?_
    orthogonal_after := ?_ }
  · intro i i' hi1 hik hi'1 hi'k hii'
    rw [hunchanged i (by omega), hunchanged i' (by omega)]
    exact he.orthogonal_before i i' hi1 hik hi'1 hi'k hii'
  · intro i hi1 hik
    rw [hunchanged i (by omega)]
    exact he.value_ne_zero i hi1 hik
  · intro i r hi1 hik hr1 hrn
    rw [hunchanged i (by omega)]
    by_cases hr : r = k + 1
    · subst hr
      calc polarization S q (e i) (addMultiplesOfMember S e j ω (k + 1))
          = polarization S q (e i) (S.add (e (k + 1)) (S.smul t (e j))) := by rw [hnext]
        _ = polarization S q (e i) (e (k + 1)) + polarization S q (e i) (S.smul t (e j)) :=
            (polarization_isLinearForm_right S q hq' (e i)).map_add (e (k + 1)) (S.smul t (e j))
        _ = polarization S q (e i) (e (k + 1)) + t * polarization S q (e i) (e j) := by
            rw [(polarization_isLinearForm_right S q hq' (e i)).map_smul t (e j)]
        _ = 0 + t * 0 := by
            rw [he.orthogonal_after i (k + 1) hi1 hik le_rfl hk,
              he.orthogonal_after i j hi1 hik (by omega) hjn]
        _ = 0 + 0 := by rw [mul_zero t]
        _ = 0 := by rw [_root_.add_zero (0 : ℂ)]
    · rw [hunchanged r hr]
      exact he.orthogonal_after i r hi1 hik hr1 hrn

/-- 本文 `claim_polarization_on_diagonal_is_nonzero_when_value_is_nonzero`：q(v) ≠ 0_ℂ なら B_q(v, v) ≠ 0_ℂ。 -/
theorem polarization_self_ne_zero (S : ComplexVectorSpace V) (q : V → ℂ) (hq : IsQuadraticForm S q)
    (v : V) (hv : q v ≠ 0) : polarization S q v v ≠ 0 := by
  rw [polarization_self S q hq v]
  exact mul_ne_zero complex_one_add_one_ne_zero hv

/-- 本文 `claim_orthogonalization_step_extends_orthogonalized_part` の写像 ω：
r ≤ k + 1 なら 0_ℂ、r ≥ k + 2 なら -_ℂ (B_q(ẽ_r, v) ·_ℂ d^{-1})（v := ẽ_{k+1}、d := B_q(v, v)）。 -/
noncomputable def orthogonalizationCoefficient (S : ComplexVectorSpace V) (q : V → ℂ) (e : ℕ → V) (k : ℕ)
    (r : ℕ) : ℂ :=
  if r ≤ k + 1 then 0
  else -(polarization S q (e r) (e (k + 1)) * (polarization S q (e (k + 1)) (e (k + 1)))⁻¹)

/-- 本文 `claim_orthogonalization_step_extends_orthogonalized_part`：ẽ が第 k 元まで直交化された基底で
q(ẽ_{k+1}) ≠ 0_ℂ なら、ẽ^{(k+1,ω)} は第 k+1 元まで直交化された基底である。 -/
theorem orthogonalizationStep_isOrthogonalized (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsQuadraticForm S q) (n k : ℕ) (hk : k + 1 ≤ n) (e : ℕ → V)
    (he : IsOrthogonalizedUpTo S q n e k) (hv : q (e (k + 1)) ≠ 0) :
    IsOrthogonalizedUpTo S q n
      (addMultiplesOfMember S e (k + 1) (orthogonalizationCoefficient S q e k)) (k + 1) := by
  let v : V := e (k + 1)
  let d : ℂ := polarization S q v v
  have hd : d ≠ 0 := polarization_self_ne_zero S q hq v hv
  let ω : ℕ → ℂ := orthogonalizationCoefficient S q e k
  have hunchanged : ∀ r : ℕ, r ≤ k + 1 → addMultiplesOfMember S e (k + 1) ω r = e r :=
    fun r hr => addMultiplesOfMember_of_coefficient_eq_zero S e (k + 1) ω r (if_pos hr)
  refine {
    isBasis := addMultiplesOfMember_isBasis S n e he.isBasis (k + 1) (Nat.succ_pos k) hk ω (if_pos le_rfl)
    orthogonal_before := ?_
    value_ne_zero := ?_
    orthogonal_after := ?_ }
  · -- 一つ目の条件
    intro i i' hi1 hik hi'1 hi'k hii'
    show polarization S q (addMultiplesOfMember S e (k + 1) ω i) (addMultiplesOfMember S e (k + 1) ω i') = 0
    rw [hunchanged i hik, hunchanged i' hi'k]
    by_cases hik' : i ≤ k
    · by_cases hi'k' : i' ≤ k
      · exact he.orthogonal_before i i' hi1 hik' hi'1 hi'k' hii'
      · have hi' : i' = k + 1 := by omega
        rw [hi']
        exact he.orthogonal_after i (k + 1) hi1 hik' le_rfl hk
    · have hi : i = k + 1 := by omega
      have hi'k' : i' ≤ k := by omega
      rw [hi]
      calc polarization S q (e (k + 1)) (e i')
          = polarization S q (e i') (e (k + 1)) := polarization_symm S q (e (k + 1)) (e i')
        _ = 0 := he.orthogonal_after i' (k + 1) hi'1 hi'k' le_rfl hk
  · -- 二つ目の条件
    intro i hi1 hik
    show q (addMultiplesOfMember S e (k + 1) ω i) ≠ 0
    rw [hunchanged i hik]
    by_cases hik' : i ≤ k
    · exact he.value_ne_zero i hi1 hik'
    · have hi : i = k + 1 := by omega
      rw [hi]
      exact hv
  · -- 三つ目の条件
    intro i r hi1 hik hr2 hrn
    show polarization S q (addMultiplesOfMember S e (k + 1) ω i) (addMultiplesOfMember S e (k + 1) ω r) = 0
    have hr : addMultiplesOfMember S e (k + 1) ω r = S.add (e r) (S.smul (ω r) v) := rfl
    rw [hunchanged i hik, hr]
    by_cases hik' : i ≤ k
    · calc polarization S q (e i) (S.add (e r) (S.smul (ω r) v))
          = polarization S q (e i) (e r) + polarization S q (e i) (S.smul (ω r) v) :=
            (polarization_isLinearForm_right S q hq (e i)).map_add (e r) (S.smul (ω r) v)
        _ = polarization S q (e i) (e r) + ω r * polarization S q (e i) v := by
            rw [(polarization_isLinearForm_right S q hq (e i)).map_smul (ω r) v]
        _ = 0 + ω r * 0 := by
            rw [he.orthogonal_after i r hi1 hik' (by omega) hrn,
              he.orthogonal_after i (k + 1) hi1 hik' le_rfl hk]
        _ = 0 + 0 := by rw [mul_zero (ω r)]
        _ = 0 := by rw [_root_.add_zero (0 : ℂ)]
    · have hi : i = k + 1 := by omega
      rw [hi]
      let α : ℂ := polarization S q (e r) v
      have hωr : ω r = -(α * d⁻¹) := if_neg (by omega)
      calc polarization S q (e (k + 1)) (S.add (e r) (S.smul (ω r) v))
          = polarization S q v (S.add (e r) (S.smul (ω r) v)) := rfl
        _ = polarization S q v (e r) + polarization S q v (S.smul (ω r) v) :=
            (polarization_isLinearForm_right S q hq v).map_add (e r) (S.smul (ω r) v)
        _ = polarization S q v (e r) + ω r * polarization S q v v := by
            rw [(polarization_isLinearForm_right S q hq v).map_smul (ω r) v]
        _ = polarization S q (e r) v + ω r * polarization S q v v := by
            rw [polarization_symm S q v (e r)]
        _ = α + ω r * d := rfl
        _ = α + (-(α * d⁻¹)) * d := by rw [hωr]
        _ = α + -((α * d⁻¹) * d) := by rw [neg_mul (α * d⁻¹) d]
        _ = α + -(α * (d⁻¹ * d)) := by rw [mul_assoc α d⁻¹ d]
        _ = α + -(α * 1) := by rw [inv_mul_cancel₀ hd]
        _ = α + -α := by rw [mul_one α]
        _ = 0 := add_neg_cancel α

/-- 本文 `claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form`：基底 b をもつ V の上の
非退化な二次形式 q には、i ≠ j なら B_q(e_i, e_j) = 0_ℂ、すべての i で q(e_i) ≠ 0_ℂ を満たす基底 e がある。 -/
theorem exists_orthogonal_basis (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsNondegenerateQuadraticForm S q) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) :
    ∃ e : ℕ → V, IsBasisFamily S n e
      ∧ (∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
      ∧ (∀ i : ℕ, 1 ≤ i → i ≤ n → q (e i) ≠ 0) := by
  have hinduction : ∀ k : ℕ, k ≤ n → ∃ e : ℕ → V, IsOrthogonalizedUpTo S q n e k := by
    intro k
    induction k with
    | zero =>
      intro _
      exact ⟨b, {
        isBasis := hb
        orthogonal_before := fun i _ hi1 hi0 _ _ _ => absurd (Nat.le_trans hi1 hi0) (by omega)
        value_ne_zero := fun i hi1 hi0 => absurd (Nat.le_trans hi1 hi0) (by omega)
        orthogonal_after := fun i _ hi1 hi0 _ _ => absurd (Nat.le_trans hi1 hi0) (by omega) }⟩
    | succ k ih =>
      intro hk
      obtain ⟨e, he⟩ := ih (Nat.le_of_succ_le hk)
      obtain ⟨e', he', hv⟩ := exists_orthogonalized_with_nonzero_next S q hq n k hk e he
      exact ⟨_, orthogonalizationStep_isOrthogonalized S q hq.isQuadraticForm n k hk e' he' hv⟩
  obtain ⟨e, he⟩ := hinduction n le_rfl
  exact ⟨e, he.isBasis, he.orthogonal_before, he.value_ne_zero⟩

end CliffordMatrixIsomorphism.ComplexVectorSpace
