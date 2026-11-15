/-
節「系：一般の偶数次元の非退化な二次空間」の前半（直交基底の存在まで）の具体版が、必要十分版の K := ℂ への特殊化として
得られることを示す導出版。具体版のファイルは必要十分版を引かない。このファイルだけが両方を引く。

  具体版                                        必要十分版との対応
  addMultiplesOfMember・orthogonalizationCoefficient
                                                …_eq_necSuf（rfl）
  IsOrthogonalizedUpTo                          isOrthogonalizedUpTo_iff_necSuf
  各主張                                        …_of_necSuf

ℂ の性質は、加法の結合法則・交換法則に `add_assoc`・`add_comm`、a + (-a) = 0 に `add_neg_cancel`、(-a) + a = 0 に
`neg_add_cancel`、1 + 1 ≠ 0 に具体版の `complex_one_add_one_ne_zero`、0 でない二元の積が 0 でないことに `mul_ne_zero`、
0 でない d の d⁻¹ · d = 1 に `inv_mul_cancel₀` を渡す（組 `complexOrthogonalizationLaws`）。
本文の claim_one_plus_one_is_nonzero_in_complex_numbers は必要十分版では仮定になるので、導出版を置かない。
-/
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.OrthogonalBasis
import CliffordMatrixIsomorphism.MathematicalToolkit.QuadraticForm.QuadraticFormFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.OrthogonalBasis

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {V : Type u}

/-! ### 定義の対応 -/

theorem addMultiplesOfMember_eq_necSuf (S : ComplexVectorSpace V) (b : ℕ → V) (s : ℕ) (ω : ℕ → ℂ) :
    addMultiplesOfMember S b s ω = NecSuf.VectorSpace.addMultiplesOfMember S.toNecSuf b s ω := rfl

theorem orthogonalizationCoefficient_eq_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) (e : ℕ → V) (k : ℕ) :
    orthogonalizationCoefficient S q e k = NecSuf.VectorSpace.orthogonalizationCoefficient S.toNecSuf q e k := rfl

theorem isOrthogonalizedUpTo_iff_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) (n : ℕ) (e : ℕ → V) (k : ℕ) :
    IsOrthogonalizedUpTo S q n e k ↔ NecSuf.VectorSpace.IsOrthogonalizedUpTo S.toNecSuf q n e k :=
  ⟨fun h => ⟨(isBasisFamily_iff_necSuf S n e).1 h.isBasis, h.orthogonal_before, h.value_ne_zero, h.orthogonal_after⟩,
    fun h => ⟨(isBasisFamily_iff_necSuf S n e).2 h.isBasis, h.orthogonal_before, h.value_ne_zero, h.orthogonal_after⟩⟩

/-- 取り替えの主張に要る ℂ の性質。 -/
theorem complexOrthogonalizationLaws : NecSuf.VectorSpace.OrthogonalizationLaws ℂ where
  add_assoc := _root_.add_assoc
  add_comm := _root_.add_comm
  add_zero := _root_.add_zero
  zero_add := _root_.zero_add
  add_neg := add_neg_cancel
  neg_add := neg_add_cancel
  mul_assoc := mul_assoc
  one_mul := one_mul
  left_distrib := mul_add
  right_distrib := add_mul
  mul_zero := mul_zero
  zero_mul := zero_mul
  neg_one_mul := neg_one_mul
  neg_one_mul_neg_one := by norm_num
  one_ne_zero := one_ne_zero
  two_ne_zero := complex_one_add_one_ne_zero
  mul_ne_zero := fun _ _ => mul_ne_zero

/-! ### 各主張 -/

/-- 本文 `claim_polarization_of_quadratic_form_is_linear_in_second_argument` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_isLinearForm_right_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsQuadraticForm S q) (x : V) : IsComplexLinearForm S (fun y => polarization S q x y) :=
  (isComplexLinearForm_iff_necSuf S _).2
    (NecSuf.VectorSpace.polarization_isLinearForm_right _root_.add_assoc _root_.add_comm S.toNecSuf q
      ((isQuadraticForm_iff_necSuf S q).1 hq) x)

/-- 本文 `claim_polarization_of_quadratic_form_on_diagonal_is_twice_value` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_self_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) (hq : IsQuadraticForm S q) (x : V) :
    polarization S q x x = (1 + 1) * q x :=
  NecSuf.VectorSpace.polarization_self _root_.add_assoc _root_.add_comm add_neg_cancel neg_add_cancel
    _root_.zero_add add_mul one_mul S.toNecSuf q ((isQuadraticForm_iff_necSuf S q).1 hq) x

/-- 本文 `claim_quadratic_form_at_sum_with_scalar_multiple` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem quadraticForm_add_smul_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) (hq : IsQuadraticForm S q)
    (x y : V) (t : ℂ) :
    q (S.add x (S.smul t y)) = (q x + t * (t * q y)) + t * polarization S q x y :=
  NecSuf.VectorSpace.quadraticForm_add_smul _root_.add_assoc _root_.add_comm add_neg_cancel _root_.zero_add
    S.toNecSuf q ((isQuadraticForm_iff_necSuf S q).1 hq) x y t

/-- 本文 `claim_member_of_linearly_independent_family_is_nonzero` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem linearlyIndependent_member_ne_zero_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsLinearlyIndependentFamily S n b) (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) : b j ≠ S.zero :=
  NecSuf.VectorSpace.linearlyIndependent_member_ne_zero (_root_.add_zero 0) one_ne_zero S.toNecSuf n b
    ((isLinearlyIndependentFamily_iff_necSuf S n b).1 hb) j hj1 hjn

/-- 本文 `claim_ordered_sum_of_zero_terms_is_zero` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem orderedSum_eq_zero_of_terms_eq_zero_of_necSuf (n : ℕ) (a : ℕ → ℂ)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → a k = 0) : orderedSum n a = 0 := by
  rw [orderedSum_eq_necSuf]
  exact NecSuf.VectorSpace.orderedSum_eq_zero_of_terms_eq_zero (_root_.add_zero 0) n a h

/-- 本文 `claim_element_orthogonal_to_spanning_family_is_zero` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem eq_zero_of_polarization_eq_zero_on_spanning_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsNondegenerateQuadraticForm S q) (n : ℕ) (b : ℕ → V) (hb : SpansByLinearCombination S n b)
    (x : V) (hx : ∀ k : ℕ, 1 ≤ k → k ≤ n → polarization S q x (b k) = 0) : x = S.zero :=
  NecSuf.VectorSpace.eq_zero_of_polarization_eq_zero_on_spanning _root_.add_assoc _root_.add_comm
    (_root_.add_zero 0) mul_zero zero_mul S.toNecSuf q ((isNondegenerateQuadraticForm_iff_necSuf S q).1 hq) n b
    ((spansByLinearCombination_iff_necSuf S n b).1 hb) x hx

/-- 本文 `claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged` を、必要十分版から得たもの。 -/
theorem addMultiplesOfMember_of_coefficient_eq_zero_of_necSuf (S : ComplexVectorSpace V) (b : ℕ → V) (s : ℕ)
    (ω : ℕ → ℂ) (r : ℕ) (hr : ω r = 0) : addMultiplesOfMember S b s ω r = b r :=
  NecSuf.VectorSpace.addMultiplesOfMember_of_coefficient_eq_zero (_root_.add_zero 0) S.toNecSuf b s ω r hr

/-- 本文 `claim_linear_combination_of_family_adding_multiples_of_one_member` を、必要十分版から得たもの。 -/
theorem linearCombination_addMultiplesOfMember_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (s : ℕ) (ω ν : ℕ → ℂ) :
    linearCombination S n ν (addMultiplesOfMember S b s ω)
      = S.add (linearCombination S n ν b) (S.smul (orderedSum n (fun k => ν k * ω k)) (b s)) := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf, orderedSum_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_addMultiplesOfMember (_root_.add_zero 0) S.toNecSuf n b s ω ν

/-- 本文 `claim_family_adding_multiples_of_one_member_to_basis_is_basis` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem addMultiplesOfMember_isBasis_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (s : ℕ) (hs1 : 1 ≤ s) (hsn : s ≤ n) (ω : ℕ → ℂ) (hωs : ω s = 0) :
    IsBasisFamily S n (addMultiplesOfMember S b s ω) :=
  (isBasisFamily_iff_necSuf S n _).2
    (NecSuf.VectorSpace.addMultiplesOfMember_isBasis _root_.add_zero mul_zero zero_mul add_neg_cancel
      S.toNecSuf n b ((isBasisFamily_iff_necSuf S n b).1 hb) s hs1 hsn ω hωs)

/-- 本文 `claim_orthogonalized_basis_can_be_modified_so_next_member_has_nonzero_value` を、必要十分版に
ℂ の性質を渡して得たもの。 -/
theorem exists_orthogonalized_with_nonzero_next_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsNondegenerateQuadraticForm S q) (n k : ℕ) (hk : k + 1 ≤ n) (e : ℕ → V)
    (he : IsOrthogonalizedUpTo S q n e k) :
    ∃ e' : ℕ → V, IsOrthogonalizedUpTo S q n e' k ∧ q (e' (k + 1)) ≠ 0 := by
  obtain ⟨e', he', hv⟩ := NecSuf.VectorSpace.exists_orthogonalized_with_nonzero_next complexOrthogonalizationLaws
    S.toNecSuf q ((isNondegenerateQuadraticForm_iff_necSuf S q).1 hq) n k hk e
    ((isOrthogonalizedUpTo_iff_necSuf S q n e k).1 he)
  exact ⟨e', (isOrthogonalizedUpTo_iff_necSuf S q n e' k).2 he', hv⟩

/-- 本文 `claim_polarization_on_diagonal_is_nonzero_when_value_is_nonzero` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_self_ne_zero_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) (hq : IsQuadraticForm S q)
    (v : V) (hv : q v ≠ 0) : polarization S q v v ≠ 0 :=
  NecSuf.VectorSpace.polarization_self_ne_zero _root_.add_assoc _root_.add_comm add_neg_cancel neg_add_cancel
    _root_.zero_add add_mul one_mul complex_one_add_one_ne_zero (fun _ _ => mul_ne_zero) S.toNecSuf q
    ((isQuadraticForm_iff_necSuf S q).1 hq) v hv

/-- 本文 `claim_orthogonalization_step_extends_orthogonalized_part` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem orthogonalizationStep_isOrthogonalized_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsQuadraticForm S q) (n k : ℕ) (hk : k + 1 ≤ n) (e : ℕ → V)
    (he : IsOrthogonalizedUpTo S q n e k) (hv : q (e (k + 1)) ≠ 0) :
    IsOrthogonalizedUpTo S q n
      (addMultiplesOfMember S e (k + 1) (orthogonalizationCoefficient S q e k)) (k + 1) :=
  (isOrthogonalizedUpTo_iff_necSuf S q n _ (k + 1)).2
    (NecSuf.VectorSpace.orthogonalizationStep_isOrthogonalized _root_.add_assoc _root_.add_comm _root_.add_zero
      _root_.zero_add add_neg_cancel neg_add_cancel mul_assoc one_mul add_mul mul_zero zero_mul
      complex_one_add_one_ne_zero (fun _ _ => mul_ne_zero) neg_mul mul_one (fun _ h => inv_mul_cancel₀ h)
      S.toNecSuf q ((isQuadraticForm_iff_necSuf S q).1 hq) n k hk e
      ((isOrthogonalizedUpTo_iff_necSuf S q n e k).1 he) hv)

/-- 本文 `claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem exists_orthogonal_basis_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsNondegenerateQuadraticForm S q) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) :
    ∃ e : ℕ → V, IsBasisFamily S n e
      ∧ (∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
      ∧ (∀ i : ℕ, 1 ≤ i → i ≤ n → q (e i) ≠ 0) := by
  obtain ⟨e, heb, horth, hne⟩ := NecSuf.VectorSpace.exists_orthogonal_basis complexOrthogonalizationLaws neg_mul
    mul_one (fun _ h => inv_mul_cancel₀ h) S.toNecSuf q ((isNondegenerateQuadraticForm_iff_necSuf S q).1 hq) n b
    ((isBasisFamily_iff_necSuf S n b).1 hb)
  exact ⟨e, (isBasisFamily_iff_necSuf S n e).2 heb, horth, hne⟩

end CliffordMatrixIsomorphism.ComplexVectorSpace
