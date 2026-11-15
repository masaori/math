/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」の前半（直交基底の存在まで）の必要十分版。
具体版 `Isomorphism/GeneralEvenDimensional/OrthogonalBasis.lean` と同じ def・structure・calc の行を、係数 ℂ を型の変数 K に替えて書く。
K には演算の記号（`Add`・`Mul`・`Zero`・`One`・`Neg`、ω を定める主張だけ `Inv`）だけを与え、公理は仮定として渡す。

  本文のラベル                                                              このファイル
  claim_one_plus_one_is_nonzero_in_complex_numbers                          宣言を置かない。使う主張の仮定 1 + 1 ≠ 0（`two_ne_zero`）になる
  claim_polarization_of_quadratic_form_is_linear_in_second_argument         polarization_isLinearForm_right
  claim_polarization_of_quadratic_form_on_diagonal_is_twice_value           polarization_self
  claim_quadratic_form_at_sum_with_scalar_multiple                          quadraticForm_add_smul
  claim_member_of_linearly_independent_family_is_nonzero                    linearlyIndependent_member_ne_zero
  claim_ordered_sum_of_zero_terms_is_zero                                   partialOrderedSum_eq_zero_of_terms_eq_zero・orderedSum_eq_zero_of_terms_eq_zero
  claim_element_orthogonal_to_spanning_family_is_zero                       eq_zero_of_polarization_eq_zero_on_spanning
  def_family_adding_multiples_of_one_member                                 addMultiplesOfMember
  claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged addMultiplesOfMember_of_coefficient_eq_zero
  claim_linear_combination_of_family_adding_multiples_of_one_member         partialLinearCombination_addMultiplesOfMember・linearCombination_addMultiplesOfMember
  claim_family_adding_multiples_of_one_member_to_basis_is_basis             addMultiplesOfMember_isBasis
  def_basis_orthogonalized_up_to_index                                      IsOrthogonalizedUpTo
  claim_orthogonalized_basis_can_be_modified_so_next_member_has_nonzero_value
                                                                            exists_orthogonalized_with_nonzero_next
  claim_polarization_on_diagonal_is_nonzero_when_value_is_nonzero           polarization_self_ne_zero
  claim_orthogonalization_step_extends_orthogonalized_part                  orthogonalizationCoefficient・orthogonalizationStep_isOrthogonalized
  claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form      exists_orthogonal_basis

主張ごとに使う K の性質（削ると通らない）:

  polarization_isLinearForm_right             加法の結合法則・交換法則（偏極の対称性から）
  polarization_self                           加法の結合法則・交換法則、a + (-a) = 0、(-a) + a = 0、0 + a = a、
                                              右分配法則、1 · a = a
  quadraticForm_add_smul                      加法の結合法則・交換法則、a + (-a) = 0、0 + a = a
  linearlyIndependent_member_ne_zero          0 + 0 = 0、1 ≠ 0
  orderedSum_eq_zero_of_terms_eq_zero         0 + 0 = 0
  eq_zero_of_polarization_eq_zero_on_spanning 加法の結合法則・交換法則、0 + 0 = 0、a · 0 = 0、0 · a = 0
  addMultiplesOfMember_of_coefficient_eq_zero 0 + 0 = 0
  linearCombination_addMultiplesOfMember      0 + 0 = 0
  addMultiplesOfMember_isBasis                a + 0 = a、a · 0 = 0、0 · a = 0、a + (-a) = 0
  exists_orthogonalized_with_nonzero_next     `OrthogonalizationLaws` の全部の欄（1 + 1 ≠ 0 と、0 でない二元の積が 0 でないことを含む）
  polarization_self_ne_zero                   polarization_self の性質、1 + 1 ≠ 0、0 でない二元の積が 0 でない
  orthogonalizationStep_isOrthogonalized      `OrthogonalizationLaws` のうち左分配法則・(-1) · a = -a・(-1)·(-1) = 1・1 ≠ 0 以外の欄と、
                                              (-a) · b = -(a · b)、a · 1 = a、0 でない d について d⁻¹ · d = 1
  exists_orthogonal_basis                     上の二つの和

分かったこと:
- 直交基底の存在まで、K の乗法の交換法則は一度も使わない。
- 1 + 1 ≠ 0（2 の可逆性）が要るのは、B_q(v, v) = (1 + 1)·q(v) から q(v) ≠ 0 ⇒ B_q(v, v) ≠ 0 を出す二か所である。
  一つは、t = 1 と t = -1 の二つの値がともに 0 なら (1 + 1)·β = 0 となって矛盾することを使う、取り替えの主張
  （`exists_orthogonalized_with_nonzero_next`）。もう一つは、d := B_q(v, v) で割る直交化の一歩（`polarization_self_ne_zero` を経る）。
  どちらも「0 でない二元の積は 0 でない」と組で使う。
- 1 ≠ 0 は、一次独立な族の元が零ベクトルでないこと（δ_{j,j} = 1 と δ_{j,j} = 0 の矛盾）で要る。
- d⁻¹ の存在（0 でない元の乗法の逆元）は直交化の一歩だけが使う。取り替えの主張は逆元を使わない。
- 平方根の存在は、この前半のどの主張も使わない。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.QuadraticForm.QuadraticForm
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.CoordinatesAndDualBasis

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {V : Type u}

omit [Zero K] in
/-- 本文 `claim_polarization_of_quadratic_form_is_linear_in_second_argument` の必要十分版。 -/
theorem polarization_isLinearForm_right (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a) (S : VectorSpace K V) (q : V → K)
    (hq : IsQuadraticForm S q) (x : V) : IsLinearForm S (fun y => polarization S q x y) where
  map_add y y' := calc
    polarization S q x (S.add y y') = polarization S q (S.add y y') x :=
        polarization_symm hassoc hcomm S q x (S.add y y')
    _ = polarization S q y x + polarization S q y' x := (hq.polarization_isLinearForm x).map_add y y'
    _ = polarization S q x y + polarization S q x y' := by
        rw [polarization_symm hassoc hcomm S q y x, polarization_symm hassoc hcomm S q y' x]
  map_smul l y := calc
    polarization S q x (S.smul l y) = polarization S q (S.smul l y) x :=
        polarization_symm hassoc hcomm S q x (S.smul l y)
    _ = l * polarization S q y x := (hq.polarization_isLinearForm x).map_smul l y
    _ = l * polarization S q x y := by rw [polarization_symm hassoc hcomm S q y x]

/-- 本文 `claim_polarization_of_quadratic_form_on_diagonal_is_twice_value` の必要十分版。 -/
theorem polarization_self (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a) (hneg : ∀ a : K, a + -a = 0) (hneg' : ∀ a : K, -a + a = 0)
    (hzero_add : ∀ a : K, 0 + a = a) (hrdistrib : ∀ a b c : K, (a + b) * c = a * c + b * c)
    (hone_mul : ∀ a : K, 1 * a = a)
    (S : VectorSpace K V) (q : V → K) (hq : IsQuadraticForm S q) (x : V) :
    polarization S q x x = (1 + 1) * q x := by
  let τ : K := 1 + 1
  let a : K := q x
  have hτ : ∀ z : K, τ * z = z + z := fun z => calc
    τ * z = (1 + 1) * z := rfl
    _ = 1 * z + 1 * z := by rw [hrdistrib 1 1 z]
    _ = z + z := by rw [hone_mul z]
  have hxx : S.add x x = S.smul τ x := calc
    S.add x x = S.add (S.smul 1 x) (S.smul 1 x) := by rw [S.one_smul x]
    _ = S.smul (1 + 1) x := by rw [S.add_smul 1 1 x]
    _ = S.smul τ x := rfl
  calc polarization S q x x
      = 0 + polarization S q x x := by rw [hzero_add (polarization S q x x)]
    _ = (-(τ * a) + τ * a) + polarization S q x x := by rw [hneg' (τ * a)]
    _ = -(τ * a) + (τ * a + polarization S q x x) := by
        rw [hassoc (-(τ * a)) (τ * a) (polarization S q x x)]
    _ = -(τ * a) + ((a + a) + polarization S q x x) := by rw [hτ a]
    _ = -(τ * a) + q (S.add x x) := by rw [polarization_identity hassoc hcomm hneg hzero_add S q x x]
    _ = -(τ * a) + q (S.smul τ x) := by rw [hxx]
    _ = -(τ * a) + τ * (τ * a) := by rw [hq.map_smul τ x]
    _ = -(τ * a) + (τ * a + τ * a) := by rw [hτ (τ * a)]
    _ = (-(τ * a) + τ * a) + τ * a := by rw [← hassoc (-(τ * a)) (τ * a) (τ * a)]
    _ = 0 + τ * a := by rw [hneg' (τ * a)]
    _ = τ * a := by rw [hzero_add (τ * a)]
    _ = (1 + 1) * q x := rfl

/-- 本文 `claim_quadratic_form_at_sum_with_scalar_multiple` の必要十分版。 -/
theorem quadraticForm_add_smul (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a) (hneg : ∀ a : K, a + -a = 0) (hzero_add : ∀ a : K, 0 + a = a)
    (S : VectorSpace K V) (q : V → K) (hq : IsQuadraticForm S q) (x y : V) (t : K) :
    q (S.add x (S.smul t y)) = (q x + t * (t * q y)) + t * polarization S q x y := calc
  q (S.add x (S.smul t y)) = (q x + q (S.smul t y)) + polarization S q x (S.smul t y) :=
      (polarization_identity hassoc hcomm hneg hzero_add S q x (S.smul t y)).symm
  _ = (q x + t * (t * q y)) + polarization S q x (S.smul t y) := by rw [hq.map_smul t y]
  _ = (q x + t * (t * q y)) + t * polarization S q x y := by
      rw [(polarization_isLinearForm_right hassoc hcomm S q hq x).map_smul t y]

omit [Neg K] in
/-- 本文 `claim_member_of_linearly_independent_family_is_nonzero` の必要十分版。
1 ≠ 0 は δ_{j,j} = 1 と δ_{j,j} = 0 の矛盾に要る。 -/
theorem linearlyIndependent_member_ne_zero (h00 : (0 : K) + 0 = 0) (hone_ne_zero : (1 : K) ≠ 0)
    (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsLinearlyIndependentFamily S n b) (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) : b j ≠ S.zero := by
  intro hbj
  have hlc : linearCombination S n (fun k => (kroneckerDelta k j : K)) b = S.zero := calc
    linearCombination S n (fun k => (kroneckerDelta k j : K)) b = b j :=
      linearCombination_kroneckerDelta S h00 n b j hj1 hjn
    _ = S.zero := hbj
  have h0 : (kroneckerDelta j j : K) = 0 := hb (fun k => (kroneckerDelta k j : K)) hlc j hj1 hjn
  have h1 : (kroneckerDelta j j : K) = 1 := if_pos rfl
  exact hone_ne_zero (h1.symm.trans h0)

omit [Mul K] [One K] [Neg K] in
/-- 本文 `claim_ordered_sum_of_zero_terms_is_zero` の帰納法の主張の必要十分版。 -/
theorem partialOrderedSum_eq_zero_of_terms_eq_zero (h00 : (0 : K) + 0 = 0) (n : ℕ) (a : ℕ → K)
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
      _ = 0 := h00

omit [Mul K] [One K] [Neg K] in
/-- 本文 `claim_ordered_sum_of_zero_terms_is_zero` の必要十分版。 -/
theorem orderedSum_eq_zero_of_terms_eq_zero (h00 : (0 : K) + 0 = 0) (n : ℕ) (a : ℕ → K)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → a k = 0) : orderedSum n a = 0 :=
  partialOrderedSum_eq_zero_of_terms_eq_zero h00 n a h n le_rfl

/-- 本文 `claim_element_orthogonal_to_spanning_family_is_zero` の必要十分版。 -/
theorem eq_zero_of_polarization_eq_zero_on_spanning (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a) (h00 : (0 : K) + 0 = 0) (hmul0 : ∀ a : K, a * 0 = 0)
    (h0mul : ∀ a : K, 0 * a = 0)
    (S : VectorSpace K V) (q : V → K)
    (hq : IsNondegenerateQuadraticForm S q) (n : ℕ) (b : ℕ → V) (hb : SpansByLinearCombination S n b)
    (x : V) (hx : ∀ k : ℕ, 1 ≤ k → k ≤ n → polarization S q x (b k) = 0) : x = S.zero := by
  apply hq.nondegenerate x
  intro y
  obtain ⟨μ, hμ⟩ := hb y
  have hterm : ∀ k : ℕ, 1 ≤ k → k ≤ n → μ k * polarization S q x (b k) = 0 := fun k hk1 hkn => calc
    μ k * polarization S q x (b k) = μ k * 0 := by rw [hx k hk1 hkn]
    _ = 0 := hmul0 (μ k)
  calc polarization S q x y
      = polarization S q x (linearCombination S n μ b) := by rw [hμ]
    _ = orderedSum n (fun k => μ k * polarization S q x (b k)) :=
        (polarization_isLinearForm_right hassoc hcomm S q hq.isQuadraticForm x).map_linearCombination
          h00 h0mul n b μ
    _ = 0 := orderedSum_eq_zero_of_terms_eq_zero h00 n _ hterm

omit [Zero K] [Neg K] in
/-- 本文 `def_family_adding_multiples_of_one_member` の必要十分版。 -/
def addMultiplesOfMember (S : VectorSpace K V) (b : ℕ → V) (s : ℕ) (ω : ℕ → K) : ℕ → V :=
  fun r => S.add (b r) (S.smul (ω r) (b s))

omit [Neg K] in
/-- 本文 `claim_member_of_family_adding_multiples_with_zero_coefficient_is_unchanged` の必要十分版。 -/
theorem addMultiplesOfMember_of_coefficient_eq_zero (h00 : (0 : K) + 0 = 0) (S : VectorSpace K V)
    (b : ℕ → V) (s : ℕ) (ω : ℕ → K) (r : ℕ) (hr : ω r = 0) : addMultiplesOfMember S b s ω r = b r := calc
  addMultiplesOfMember S b s ω r = S.add (b r) (S.smul (ω r) (b s)) := rfl
  _ = S.add (b r) (S.smul 0 (b s)) := by rw [hr]
  _ = S.add (b r) S.zero := by rw [zero_smul_eq_zero S h00 (b s)]
  _ = b r := S.add_zero (b r)

omit [Neg K] in
/-- 本文 `claim_linear_combination_of_family_adding_multiples_of_one_member` の帰納法の主張の必要十分版。 -/
theorem partialLinearCombination_addMultiplesOfMember (h00 : (0 : K) + 0 = 0) (S : VectorSpace K V)
    (b : ℕ → V) (s : ℕ) (ω ν : ℕ → K) (m : ℕ) :
    partialLinearCombination S ν (addMultiplesOfMember S b s ω) m
      = S.add (partialLinearCombination S ν b m)
          (S.smul (partialOrderedSum (fun k => ν k * ω k) m) (b s)) := by
  induction m with
  | zero => calc
      partialLinearCombination S ν (addMultiplesOfMember S b s ω) 0 = S.zero := rfl
      _ = S.add S.zero S.zero := by rw [S.add_zero S.zero]
      _ = S.add S.zero (S.smul 0 (b s)) := by rw [zero_smul_eq_zero S h00 (b s)]
      _ = S.add (partialLinearCombination S ν b 0)
            (S.smul (partialOrderedSum (fun k => ν k * ω k) 0) (b s)) := rfl
  | succ m ih =>
    let A : V := partialLinearCombination S ν b m
    let σ : K := partialOrderedSum (fun k => ν k * ω k) m
    let bs : V := b s
    let bm : V := b (m + 1)
    let νm : K := ν (m + 1)
    let ωm : K := ω (m + 1)
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

omit [Neg K] in
/-- 本文 `claim_linear_combination_of_family_adding_multiples_of_one_member` の必要十分版。 -/
theorem linearCombination_addMultiplesOfMember (h00 : (0 : K) + 0 = 0) (S : VectorSpace K V) (n : ℕ)
    (b : ℕ → V) (s : ℕ) (ω ν : ℕ → K) :
    linearCombination S n ν (addMultiplesOfMember S b s ω)
      = S.add (linearCombination S n ν b) (S.smul (orderedSum n (fun k => ν k * ω k)) (b s)) :=
  partialLinearCombination_addMultiplesOfMember h00 S b s ω ν n

/-- 本文 `claim_family_adding_multiples_of_one_member_to_basis_is_basis` の必要十分版。
0 + 0 = 0 は `hadd_zero 0` から得る。 -/
theorem addMultiplesOfMember_isBasis (hadd_zero : ∀ a : K, a + 0 = a) (hmul0 : ∀ a : K, a * 0 = 0)
    (h0mul : ∀ a : K, 0 * a = 0) (hneg : ∀ a : K, a + -a = 0)
    (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (s : ℕ) (hs1 : 1 ≤ s) (hsn : s ≤ n) (ω : ℕ → K) (hωs : ω s = 0) :
    IsBasisFamily S n (addMultiplesOfMember S b s ω) := by
  have h00 : (0 : K) + 0 = 0 := hadd_zero 0
  have hbs : addMultiplesOfMember S b s ω s = b s :=
    addMultiplesOfMember_of_coefficient_eq_zero h00 S b s ω s hωs
  constructor
  · -- 一次独立
    intro ν hν
    let σ : K := orderedSum n (fun k => ν k * ω k)
    have h0 : S.zero = linearCombination S n (fun k => ν k + σ * (kroneckerDelta k s : K)) b := calc
      S.zero = linearCombination S n ν (addMultiplesOfMember S b s ω) := hν.symm
      _ = S.add (linearCombination S n ν b) (S.smul σ (b s)) :=
          linearCombination_addMultiplesOfMember h00 S n b s ω ν
      _ = S.add (linearCombination S n ν b)
            (S.smul σ (linearCombination S n (fun k => (kroneckerDelta k s : K)) b)) := by
          rw [linearCombination_kroneckerDelta S h00 n b s hs1 hsn]
      _ = S.add (linearCombination S n ν b)
            (linearCombination S n (fun k => σ * (kroneckerDelta k s : K)) b) := by
          rw [smul_linearCombination S h00 hmul0 n b (fun k => (kroneckerDelta k s : K)) σ]
      _ = linearCombination S n (fun k => ν k + σ * (kroneckerDelta k s : K)) b :=
          linearCombination_add_of_same_family S n b ν (fun k => σ * (kroneckerDelta k s : K))
    have hstar : ∀ k : ℕ, 1 ≤ k → k ≤ n → ν k + σ * (kroneckerDelta k s : K) = 0 :=
      hb.linearlyIndependent (fun k => ν k + σ * (kroneckerDelta k s : K)) h0.symm
    have hne : ∀ k : ℕ, 1 ≤ k → k ≤ n → k ≠ s → ν k = 0 := fun k hk1 hkn hks => calc
      ν k = ν k + 0 := by rw [hadd_zero (ν k)]
      _ = ν k + σ * 0 := by rw [hmul0 σ]
      _ = ν k + σ * (kroneckerDelta k s : K) := by rw [kroneckerDelta, if_neg hks]
      _ = 0 := hstar k hk1 hkn
    have hσ : σ = 0 := orderedSum_eq_zero_of_terms_eq_zero h00 n (fun k => ν k * ω k) (by
      intro k hk1 hkn
      by_cases hks : k = s
      · show ν k * ω k = 0
        rw [hks, hωs, hmul0 (ν s)]
      · show ν k * ω k = 0
        rw [hne k hk1 hkn hks, h0mul (ω k)])
    intro k hk1 hkn
    by_cases hks : k = s
    · subst hks
      calc ν k = ν k + 0 := by rw [hadd_zero (ν k)]
        _ = ν k + 0 * (kroneckerDelta k k : K) := by rw [h0mul (kroneckerDelta k k : K)]
        _ = ν k + σ * (kroneckerDelta k k : K) := by rw [hσ]
        _ = 0 := hstar k hk1 hkn
    · exact hne k hk1 hkn hks
  · -- 張る
    intro x
    obtain ⟨μ, hμ⟩ := hb.spans x
    let ρ : K := orderedSum n (fun k => μ k * ω k)
    refine ⟨fun k => μ k + (-ρ) * (kroneckerDelta k s : K), ?_⟩
    let b' : ℕ → V := addMultiplesOfMember S b s ω
    calc linearCombination S n (fun k => μ k + (-ρ) * (kroneckerDelta k s : K)) b'
        = S.add (linearCombination S n μ b')
            (linearCombination S n (fun k => (-ρ) * (kroneckerDelta k s : K)) b') :=
          (linearCombination_add_of_same_family S n b' μ (fun k => (-ρ) * (kroneckerDelta k s : K))).symm
      _ = S.add (linearCombination S n μ b')
            (S.smul (-ρ) (linearCombination S n (fun k => (kroneckerDelta k s : K)) b')) := by
          rw [smul_linearCombination S h00 hmul0 n b' (fun k => (kroneckerDelta k s : K)) (-ρ)]
      _ = S.add (linearCombination S n μ b') (S.smul (-ρ) (b' s)) := by
          rw [linearCombination_kroneckerDelta S h00 n b' s hs1 hsn]
      _ = S.add (linearCombination S n μ b') (S.smul (-ρ) (b s)) := by
          rw [show b' s = b s from hbs]
      _ = S.add (S.add (linearCombination S n μ b) (S.smul ρ (b s))) (S.smul (-ρ) (b s)) := by
          rw [linearCombination_addMultiplesOfMember h00 S n b s ω μ]
      _ = S.add (linearCombination S n μ b) (S.add (S.smul ρ (b s)) (S.smul (-ρ) (b s))) :=
          S.add_assoc (linearCombination S n μ b) (S.smul ρ (b s)) (S.smul (-ρ) (b s))
      _ = S.add (linearCombination S n μ b) (S.smul (ρ + -ρ) (b s)) := by rw [S.add_smul ρ (-ρ) (b s)]
      _ = S.add (linearCombination S n μ b) (S.smul 0 (b s)) := by rw [hneg ρ]
      _ = S.add (linearCombination S n μ b) S.zero := by rw [zero_smul_eq_zero S h00 (b s)]
      _ = linearCombination S n μ b := S.add_zero (linearCombination S n μ b)
      _ = x := hμ

/-- 本文 `def_basis_orthogonalized_up_to_index` の必要十分版。 -/
structure IsOrthogonalizedUpTo (S : VectorSpace K V) (q : V → K) (n : ℕ) (e : ℕ → V) (k : ℕ) : Prop where
  isBasis : IsBasisFamily S n e
  orthogonal_before : ∀ i i' : ℕ, 1 ≤ i → i ≤ k → 1 ≤ i' → i' ≤ k → i ≠ i' →
    polarization S q (e i) (e i') = 0
  value_ne_zero : ∀ i : ℕ, 1 ≤ i → i ≤ k → q (e i) ≠ 0
  orthogonal_after : ∀ i j : ℕ, 1 ≤ i → i ≤ k → k + 1 ≤ j → j ≤ n → polarization S q (e i) (e j) = 0

/-- 取り替えの主張（`exists_orthogonalized_with_nonzero_next`）が使う K の性質の組。
`two_ne_zero` と `mul_ne_zero` は、t = 1 と t = -1 の値がともに 0 なら (1 + 1)·β = 0 となる矛盾と、
B_q(v, v) = (1 + 1)·q(v) ≠ 0 に要る。`one_ne_zero` は一次独立な族の元が零ベクトルでないことに要る。 -/
structure OrthogonalizationLaws (K : Type uK) [Add K] [Mul K] [One K] [Zero K] [Neg K] : Prop where
  add_assoc : ∀ a b c : K, (a + b) + c = a + (b + c)
  add_comm : ∀ a b : K, a + b = b + a
  add_zero : ∀ a : K, a + 0 = a
  zero_add : ∀ a : K, 0 + a = a
  add_neg : ∀ a : K, a + -a = 0
  neg_add : ∀ a : K, -a + a = 0
  mul_assoc : ∀ a b c : K, (a * b) * c = a * (b * c)
  one_mul : ∀ a : K, 1 * a = a
  left_distrib : ∀ a b c : K, a * (b + c) = a * b + a * c
  right_distrib : ∀ a b c : K, (a + b) * c = a * c + b * c
  mul_zero : ∀ a : K, a * 0 = 0
  zero_mul : ∀ a : K, 0 * a = 0
  neg_one_mul : ∀ a : K, (-1) * a = -a
  neg_one_mul_neg_one : (-1 : K) * (-1) = 1
  one_ne_zero : (1 : K) ≠ 0
  two_ne_zero : (1 : K) + 1 ≠ 0
  mul_ne_zero : ∀ a b : K, a ≠ 0 → b ≠ 0 → a * b ≠ 0

/-- 本文 `claim_orthogonalized_basis_can_be_modified_so_next_member_has_nonzero_value` の必要十分版。 -/
theorem exists_orthogonalized_with_nonzero_next (L : OrthogonalizationLaws K) (S : VectorSpace K V)
    (q : V → K) (hq : IsNondegenerateQuadraticForm S q) (n k : ℕ) (hk : k + 1 ≤ n) (e : ℕ → V)
    (he : IsOrthogonalizedUpTo S q n e k) :
    ∃ e' : ℕ → V, IsOrthogonalizedUpTo S q n e' k ∧ q (e' (k + 1)) ≠ 0 := by
  have h00 : (0 : K) + 0 = 0 := L.add_zero 0
  by_cases hzero : q (e (k + 1)) ≠ 0
  · exact ⟨e, he, hzero⟩
  have hzero : q (e (k + 1)) = 0 := not_not.mp hzero
  have hq' : IsQuadraticForm S q := hq.isQuadraticForm
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
            = polarization S q (e j) (e (k + 1)) := polarization_symm L.add_assoc L.add_comm S q (e (k + 1)) (e j)
          _ = 0 := he.orthogonal_after j (k + 1) hj1 (Nat.le_of_lt_succ hlt) le_rfl hk
      · subst heq
        calc polarization S q (e (k + 1)) (e (k + 1))
            = (1 + 1) * q (e (k + 1)) :=
              polarization_self L.add_assoc L.add_comm L.add_neg L.neg_add L.zero_add L.right_distrib
                L.one_mul S q hq' (e (k + 1))
          _ = (1 + 1) * 0 := by rw [hzero]
          _ = 0 := L.mul_zero (1 + 1 : K)
      · exact hafter j hgt hjn
    have hz : e (k + 1) = S.zero :=
      eq_zero_of_polarization_eq_zero_on_spanning L.add_assoc L.add_comm h00 L.mul_zero L.zero_mul S q hq n e
        he.isBasis.spans (e (k + 1)) hall
    exact linearlyIndependent_member_ne_zero h00 L.one_ne_zero S n e he.isBasis.linearlyIndependent (k + 1)
      (Nat.succ_pos k) hk hz
  obtain ⟨j, hj2, hjn, hβ⟩ := hexists
  let β : K := polarization S q (e (k + 1)) (e j)
  let ζ : K := q (e j)
  have hvalue : ∀ t : K, t * t = 1 → q (S.add (e (k + 1)) (S.smul t (e j))) = ζ + t * β := by
    intro t ht
    calc q (S.add (e (k + 1)) (S.smul t (e j)))
        = (q (e (k + 1)) + t * (t * q (e j))) + t * polarization S q (e (k + 1)) (e j) :=
          quadraticForm_add_smul L.add_assoc L.add_comm L.add_neg L.zero_add S q hq' (e (k + 1)) (e j) t
      _ = (0 + t * (t * q (e j))) + t * polarization S q (e (k + 1)) (e j) := by rw [hzero]
      _ = (0 + t * (t * ζ)) + t * polarization S q (e (k + 1)) (e j) := rfl
      _ = (0 + t * (t * ζ)) + t * β := rfl
      _ = t * (t * ζ) + t * β := by rw [L.zero_add (t * (t * ζ))]
      _ = (t * t) * ζ + t * β := by rw [← L.mul_assoc t t ζ]
      _ = 1 * ζ + t * β := by rw [ht]
      _ = ζ + t * β := by rw [L.one_mul ζ]
  have htwo : ζ + 1 * β = 0 → ζ + (-1) * β = 0 → (1 + 1) * β = 0 := by
    intro h1 h2
    have hprep : (-1) * (ζ + (-1) * β) = -ζ + 1 * β := calc
      (-1) * (ζ + (-1) * β) = (-1) * ζ + (-1) * ((-1) * β) := by rw [L.left_distrib (-1 : K) ζ ((-1) * β)]
      _ = -ζ + (-1) * ((-1) * β) := by rw [L.neg_one_mul ζ]
      _ = -ζ + ((-1) * (-1)) * β := by rw [← L.mul_assoc (-1 : K) (-1) β]
      _ = -ζ + 1 * β := by rw [L.neg_one_mul_neg_one]
    calc (1 + 1) * β
        = 1 * β + 1 * β := by rw [L.right_distrib (1 : K) 1 β]
      _ = (0 + 1 * β) + 1 * β := by rw [L.zero_add (1 * β)]
      _ = ((ζ + -ζ) + 1 * β) + 1 * β := by rw [L.add_neg ζ]
      _ = (ζ + (-ζ + 1 * β)) + 1 * β := by rw [L.add_assoc ζ (-ζ) (1 * β)]
      _ = (ζ + (1 * β + -ζ)) + 1 * β := by rw [L.add_comm (-ζ) (1 * β)]
      _ = ((ζ + 1 * β) + -ζ) + 1 * β := by rw [← L.add_assoc ζ (1 * β) (-ζ)]
      _ = (ζ + 1 * β) + (-ζ + 1 * β) := by rw [L.add_assoc (ζ + 1 * β) (-ζ) (1 * β)]
      _ = (ζ + 1 * β) + (-1) * (ζ + (-1) * β) := by rw [hprep]
      _ = 0 + (-1) * 0 := by rw [h1, h2]
      _ = 0 + 0 := by rw [L.mul_zero (-1 : K)]
      _ = 0 := by rw [L.add_zero (0 : K)]
  have hchoice : ∃ t : K, t * t = 1 ∧ ζ + t * β ≠ 0 := by
    by_cases h1 : ζ + 1 * β = 0
    · by_cases h2 : ζ + (-1) * β = 0
      · exact absurd (htwo h1 h2) (L.mul_ne_zero (1 + 1) β L.two_ne_zero hβ)
      · exact ⟨-1, L.neg_one_mul_neg_one, h2⟩
    · exact ⟨1, L.one_mul 1, h1⟩
  obtain ⟨t, htt, hζt⟩ := hchoice
  have hqt : q (S.add (e (k + 1)) (S.smul t (e j))) ≠ 0 := by rw [hvalue t htt]; exact hζt
  let ω : ℕ → K := fun r => if r = k + 1 then t else 0
  have hωj : ω j = 0 := if_neg (by omega)
  have hunchanged : ∀ r : ℕ, r ≠ k + 1 → addMultiplesOfMember S e j ω r = e r :=
    fun r hr => addMultiplesOfMember_of_coefficient_eq_zero h00 S e j ω r (if_neg hr)
  have hnext : addMultiplesOfMember S e j ω (k + 1) = S.add (e (k + 1)) (S.smul t (e j)) := by
    show S.add (e (k + 1)) (S.smul (ω (k + 1)) (e j)) = S.add (e (k + 1)) (S.smul t (e j))
    rw [show ω (k + 1) = t from if_pos rfl]
  refine ⟨addMultiplesOfMember S e j ω, ?_, by rw [hnext]; exact hqt⟩
  refine {
    isBasis := addMultiplesOfMember_isBasis L.add_zero L.mul_zero L.zero_mul L.add_neg S n e he.isBasis j
      (by omega) hjn ω hωj
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
            (polarization_isLinearForm_right L.add_assoc L.add_comm S q hq' (e i)).map_add (e (k + 1))
              (S.smul t (e j))
        _ = polarization S q (e i) (e (k + 1)) + t * polarization S q (e i) (e j) := by
            rw [(polarization_isLinearForm_right L.add_assoc L.add_comm S q hq' (e i)).map_smul t (e j)]
        _ = 0 + t * 0 := by
            rw [he.orthogonal_after i (k + 1) hi1 hik le_rfl hk,
              he.orthogonal_after i j hi1 hik (by omega) hjn]
        _ = 0 + 0 := by rw [L.mul_zero t]
        _ = 0 := by rw [L.add_zero (0 : K)]
    · rw [hunchanged r hr]
      exact he.orthogonal_after i r hi1 hik hr1 hrn

/-- 本文 `claim_polarization_on_diagonal_is_nonzero_when_value_is_nonzero` の必要十分版。
1 + 1 ≠ 0（2 の可逆性）と、0 でない二元の積が 0 でないことを使う。 -/
theorem polarization_self_ne_zero (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a) (hneg : ∀ a : K, a + -a = 0) (hneg' : ∀ a : K, -a + a = 0)
    (hzero_add : ∀ a : K, 0 + a = a) (hrdistrib : ∀ a b c : K, (a + b) * c = a * c + b * c)
    (hone_mul : ∀ a : K, 1 * a = a) (htwo : (1 : K) + 1 ≠ 0)
    (hmul_ne_zero : ∀ a b : K, a ≠ 0 → b ≠ 0 → a * b ≠ 0)
    (S : VectorSpace K V) (q : V → K) (hq : IsQuadraticForm S q)
    (v : V) (hv : q v ≠ 0) : polarization S q v v ≠ 0 := by
  rw [polarization_self hassoc hcomm hneg hneg' hzero_add hrdistrib hone_mul S q hq v]
  exact hmul_ne_zero (1 + 1) (q v) htwo hv

omit [One K] in
/-- 本文 `claim_orthogonalization_step_extends_orthogonalized_part` の写像 ω の必要十分版。
d^{-1} は K の `Inv` の記号で書き、d^{-1} · d = 1 は使う主張の仮定に置く。 -/
noncomputable def orthogonalizationCoefficient [Inv K] (S : VectorSpace K V) (q : V → K) (e : ℕ → V)
    (k : ℕ) (r : ℕ) : K :=
  if r ≤ k + 1 then 0
  else -(polarization S q (e r) (e (k + 1)) * (polarization S q (e (k + 1)) (e (k + 1)))⁻¹)

/-- 本文 `claim_orthogonalization_step_extends_orthogonalized_part` の必要十分版。
`OrthogonalizationLaws` のうち左分配法則・(-1) · a = -a・(-1) · (-1) = 1・1 ≠ 0 は使わない。
ほかに (-a) · b = -(a · b)、a · 1 = a、0 でない元 d について d⁻¹ · d = 1 を使う。 -/
theorem orthogonalizationStep_isOrthogonalized [Inv K]
    (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c)) (hcomm : ∀ a b : K, a + b = b + a)
    (hadd_zero : ∀ a : K, a + 0 = a) (hzero_add : ∀ a : K, 0 + a = a)
    (hneg : ∀ a : K, a + -a = 0) (hneg' : ∀ a : K, -a + a = 0)
    (hmul_assoc : ∀ a b c : K, (a * b) * c = a * (b * c)) (hone_mul : ∀ a : K, 1 * a = a)
    (hrdistrib : ∀ a b c : K, (a + b) * c = a * c + b * c)
    (hmul0 : ∀ a : K, a * 0 = 0) (h0mul : ∀ a : K, 0 * a = 0)
    (htwo : (1 : K) + 1 ≠ 0) (hmul_ne_zero : ∀ a b : K, a ≠ 0 → b ≠ 0 → a * b ≠ 0)
    (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hmul_one : ∀ a : K, a * 1 = a)
    (hinv : ∀ a : K, a ≠ 0 → a⁻¹ * a = 1)
    (S : VectorSpace K V) (q : V → K)
    (hq : IsQuadraticForm S q) (n k : ℕ) (hk : k + 1 ≤ n) (e : ℕ → V)
    (he : IsOrthogonalizedUpTo S q n e k) (hv : q (e (k + 1)) ≠ 0) :
    IsOrthogonalizedUpTo S q n
      (addMultiplesOfMember S e (k + 1) (orthogonalizationCoefficient S q e k)) (k + 1) := by
  have h00 : (0 : K) + 0 = 0 := hadd_zero 0
  let v : V := e (k + 1)
  let d : K := polarization S q v v
  have hd : d ≠ 0 :=
    polarization_self_ne_zero hassoc hcomm hneg hneg' hzero_add hrdistrib hone_mul
      htwo hmul_ne_zero S q hq v hv
  let ω : ℕ → K := orthogonalizationCoefficient S q e k
  have hunchanged : ∀ r : ℕ, r ≤ k + 1 → addMultiplesOfMember S e (k + 1) ω r = e r :=
    fun r hr => addMultiplesOfMember_of_coefficient_eq_zero h00 S e (k + 1) ω r (if_pos hr)
  refine {
    isBasis := addMultiplesOfMember_isBasis hadd_zero hmul0 h0mul hneg S n e he.isBasis (k + 1)
      (Nat.succ_pos k) hk ω (if_pos le_rfl)
    orthogonal_before := ?_
    value_ne_zero := ?_
    orthogonal_after := ?_ }
  · intro i i' hi1 hik hi'1 hi'k hii'
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
          = polarization S q (e i') (e (k + 1)) := polarization_symm hassoc hcomm S q (e (k + 1)) (e i')
        _ = 0 := he.orthogonal_after i' (k + 1) hi'1 hi'k' le_rfl hk
  · intro i hi1 hik
    show q (addMultiplesOfMember S e (k + 1) ω i) ≠ 0
    rw [hunchanged i hik]
    by_cases hik' : i ≤ k
    · exact he.value_ne_zero i hi1 hik'
    · have hi : i = k + 1 := by omega
      rw [hi]
      exact hv
  · intro i r hi1 hik hr2 hrn
    show polarization S q (addMultiplesOfMember S e (k + 1) ω i) (addMultiplesOfMember S e (k + 1) ω r) = 0
    have hr : addMultiplesOfMember S e (k + 1) ω r = S.add (e r) (S.smul (ω r) v) := rfl
    rw [hunchanged i hik, hr]
    by_cases hik' : i ≤ k
    · calc polarization S q (e i) (S.add (e r) (S.smul (ω r) v))
          = polarization S q (e i) (e r) + polarization S q (e i) (S.smul (ω r) v) :=
            (polarization_isLinearForm_right hassoc hcomm S q hq (e i)).map_add (e r) (S.smul (ω r) v)
        _ = polarization S q (e i) (e r) + ω r * polarization S q (e i) v := by
            rw [(polarization_isLinearForm_right hassoc hcomm S q hq (e i)).map_smul (ω r) v]
        _ = 0 + ω r * 0 := by
            rw [he.orthogonal_after i r hi1 hik' (by omega) hrn,
              he.orthogonal_after i (k + 1) hi1 hik' le_rfl hk]
        _ = 0 + 0 := by rw [hmul0 (ω r)]
        _ = 0 := by rw [hadd_zero (0 : K)]
    · have hi : i = k + 1 := by omega
      rw [hi]
      let α : K := polarization S q (e r) v
      have hωr : ω r = -(α * d⁻¹) := if_neg (by omega)
      calc polarization S q (e (k + 1)) (S.add (e r) (S.smul (ω r) v))
          = polarization S q v (S.add (e r) (S.smul (ω r) v)) := rfl
        _ = polarization S q v (e r) + polarization S q v (S.smul (ω r) v) :=
            (polarization_isLinearForm_right hassoc hcomm S q hq v).map_add (e r) (S.smul (ω r) v)
        _ = polarization S q v (e r) + ω r * polarization S q v v := by
            rw [(polarization_isLinearForm_right hassoc hcomm S q hq v).map_smul (ω r) v]
        _ = polarization S q (e r) v + ω r * polarization S q v v := by
            rw [polarization_symm hassoc hcomm S q v (e r)]
        _ = α + ω r * d := rfl
        _ = α + (-(α * d⁻¹)) * d := by rw [hωr]
        _ = α + -((α * d⁻¹) * d) := by rw [hneg_mul (α * d⁻¹) d]
        _ = α + -(α * (d⁻¹ * d)) := by rw [hmul_assoc α d⁻¹ d]
        _ = α + -(α * 1) := by rw [hinv d hd]
        _ = α + -α := by rw [hmul_one α]
        _ = 0 := hneg α

/-- 本文 `claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form` の必要十分版。 -/
theorem exists_orthogonal_basis [Inv K] (L : OrthogonalizationLaws K)
    (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hmul_one : ∀ a : K, a * 1 = a)
    (hinv : ∀ a : K, a ≠ 0 → a⁻¹ * a = 1)
    (S : VectorSpace K V) (q : V → K)
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
      obtain ⟨e', he', hv⟩ := exists_orthogonalized_with_nonzero_next L S q hq n k hk e he
      exact ⟨_, orthogonalizationStep_isOrthogonalized L.add_assoc L.add_comm L.add_zero L.zero_add L.add_neg
        L.neg_add L.mul_assoc L.one_mul L.right_distrib L.mul_zero L.zero_mul L.two_ne_zero L.mul_ne_zero
        hneg_mul hmul_one hinv S q hq.isQuadraticForm n k hk e' he' hv⟩
  obtain ⟨e, he⟩ := hinduction n le_rfl
  exact ⟨e, he.isBasis, he.orthogonal_before, he.value_ne_zero⟩

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
