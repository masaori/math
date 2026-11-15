/-
節「系：一般の偶数次元の非退化な二次空間」の前半のうち、虚数単位から互いに直交する族の線型結合での二次形式の値までの
具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。具体版のファイルは必要十分版を引かない。

  具体版                                        必要十分版との対応
  realToComplex_zero・realToComplex_neg         …_of_necSuf（R := ℝ、ρ := realToComplex）
  exists_complex_square_root                    exists_complex_square_root_of_necSuf
  各主張                                        …_of_necSuf

平方根の主張は、必要十分版の R に ℝ、ρ に realToComplex、i に imaginaryUnit を入れ、一つ目の事実に具体版の
`realToComplex_add`・`realToComplex_mul`・`complex_eq_real_add_imaginaryUnit_mul_real`、(★) に具体版の
`exists_real_pair_square_difference_double_product`（ℝ だけの主張で、ℝ の完備性への脱出を含む）をそのまま渡す。
本文の def_imaginary_unit・claim_imaginary_unit_squares_to_minus_one は必要十分版では変数と仮定になるので、導出版を置かない。
-/
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.OrthonormalBasis
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.OrthogonalBasisFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.OrthonormalBasis

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {V : Type u}

/-! ### ℂ の元の平方根 -/

/-- 平方根の主張の K の側の計算に要る ℂ の性質。 -/
theorem complexSquareRootLaws : NecSuf.VectorSpace.SquareRootLaws ℂ where
  add_assoc := _root_.add_assoc
  add_comm := _root_.add_comm
  add_zero := _root_.add_zero
  zero_add := _root_.zero_add
  add_neg := add_neg_cancel
  left_distrib := mul_add
  right_distrib := add_mul
  mul_assoc := mul_assoc
  mul_comm := mul_comm
  neg_one_mul := neg_one_mul

/-- 本文 `claim_existence_of_square_root_in_complex_numbers` の準備 ρ(0) = 0_ℂ を、必要十分版から得たもの。 -/
theorem realToComplex_zero_of_necSuf : realToComplex 0 = 0 :=
  NecSuf.VectorSpace.realPart_map_zero _root_.add_zero add_neg_cancel _root_.add_assoc (_root_.add_zero (0 : ℝ))
    realToComplex realToComplex_add

/-- 本文 `claim_existence_of_square_root_in_complex_numbers` の準備 ρ(-x) = -_ℂ ρ(x) を、必要十分版から得たもの。 -/
theorem realToComplex_neg_of_necSuf (x : ℝ) : realToComplex (-x) = -realToComplex x :=
  NecSuf.VectorSpace.realPart_map_neg _root_.add_zero add_neg_cancel _root_.add_assoc _root_.zero_add
    (_root_.add_zero (0 : ℝ)) neg_add_cancel realToComplex realToComplex_add x

/-- 本文 `claim_existence_of_square_root_in_complex_numbers` を、必要十分版に ℂ・ℝ の性質と (★) を渡して得たもの。 -/
theorem exists_complex_square_root_of_necSuf (z : ℂ) : ∃ s : ℂ, s * s = z :=
  NecSuf.VectorSpace.exists_square_root complexSquareRootLaws realToComplex realToComplex_add realToComplex_mul
    imaginaryUnit imaginaryUnit_mul_self complex_eq_real_add_imaginaryUnit_mul_real (_root_.add_zero (0 : ℝ))
    neg_add_cancel (fun x y => (sub_eq_add_neg x y).symm) (fun x y => by ring)
    exists_real_pair_square_difference_double_product z

/-! ### 基底の取り替えと、どの元での値も 1 の直交基底 -/

/-- 本文 `claim_nonzero_scalar_multiples_of_basis_members_form_basis` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem nonzero_smul_basis_isBasis_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (t : ℕ → ℂ) (ht : ∀ k : ℕ, 1 ≤ k → k ≤ n → t k ≠ 0) :
    IsBasisFamily S n (fun k => S.smul (t k) (b k)) :=
  (isBasisFamily_iff_necSuf S n _).2
    (NecSuf.VectorSpace.nonzero_smul_basis_isBasis mul_assoc mul_one zero_mul (fun _ h => mul_inv_cancel₀ h)
      (fun _ h => inv_mul_cancel₀ h) S.toNecSuf n b ((isBasisFamily_iff_necSuf S n b).1 hb) t ht)

/-- 本文 `claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form` を、必要十分版に ℂ の性質と
平方根の存在（`exists_complex_square_root_of_necSuf`、ℝ への脱出）を渡して得たもの。 -/
theorem exists_orthonormal_basis_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsNondegenerateQuadraticForm S q) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) :
    ∃ e : ℕ → V, IsBasisFamily S n e
      ∧ (∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
      ∧ (∀ i : ℕ, 1 ≤ i → i ≤ n → q (e i) = 1) := by
  obtain ⟨e, heb, horth, hone⟩ := NecSuf.VectorSpace.exists_orthonormal_basis complexOrthogonalizationLaws neg_mul
    mul_one (fun _ h => inv_mul_cancel₀ h) (fun _ h => mul_inv_cancel₀ h) mul_comm exists_complex_square_root_of_necSuf
    S.toNecSuf q ((isNondegenerateQuadraticForm_iff_necSuf S q).1 hq) n b ((isBasisFamily_iff_necSuf S n b).1 hb)
  exact ⟨e, (isBasisFamily_iff_necSuf S n e).2 heb, horth, hone⟩

/-! ### 互いに直交する族の線型結合での二次形式の値 -/

/-- 本文 `claim_quadratic_form_of_linear_combination_of_orthogonal_family` の二つ目の準備を、必要十分版から得たもの。 -/
theorem polarization_partialLinearCombination_eq_zero_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsQuadraticForm S q) (n : ℕ) (e : ℕ → V)
    (horth : ∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
    (ν : ℕ → ℂ) (m : ℕ) (hm1 : 1 ≤ m) (hmn : m ≤ n) :
    ∀ j : ℕ, j + 1 ≤ m → polarization S q (partialLinearCombination S ν e j) (e m) = 0 := by
  intro j hj
  rw [partialLinearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.polarization_partialLinearCombination_eq_zero (_root_.add_zero 0) mul_zero zero_mul
    S.toNecSuf q ((isQuadraticForm_iff_necSuf S q).1 hq) n e horth ν m hm1 hmn j hj

/-- 本文 `claim_quadratic_form_of_linear_combination_of_orthogonal_family` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem quadraticForm_linearCombination_orthogonal_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ)
    (hq : IsQuadraticForm S q) (n : ℕ) (e : ℕ → V)
    (horth : ∀ i j : ℕ, 1 ≤ i → i ≤ n → 1 ≤ j → j ≤ n → i ≠ j → polarization S q (e i) (e j) = 0)
    (ν : ℕ → ℂ) :
    q (linearCombination S n ν e) = orderedSum n (fun k => ν k * (ν k * q (e k))) := by
  rw [linearCombination_eq_necSuf, orderedSum_eq_necSuf]
  exact NecSuf.VectorSpace.quadraticForm_linearCombination_orthogonal _root_.add_assoc _root_.add_comm
    add_neg_cancel _root_.zero_add _root_.add_zero mul_zero zero_mul S.toNecSuf q
    ((isQuadraticForm_iff_necSuf S q).1 hq) n e horth ν

end CliffordMatrixIsomorphism.ComplexVectorSpace
