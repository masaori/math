/-
必要十分版を ℕ と Qbar の部分体へ特殊化する導出。
分解は `R := ℕ`、`lt := (· < ·)`、偶奇は `nat_eq_add_self_or_add_self_add_one` から渡す。
主張は `S := F`、`T := K = F(ω)`、`hstep` を `claim_subfield_polynomial_root_induction_step`、
`hα` を `claim_qbar_monic_polynomial_linear_factor_product` から渡す。住処: Qbar（分解は ℕ）。
-/
import Ising2DLambda.FisherZero.SubfieldPolynomialRootInImaginaryUnitExtension
import Ising2DLambda.NecSuf.FisherZero.SubfieldPolynomialRootInImaginaryUnitExtension

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_positive_natural_two_power_odd_decomposition` を必要十分版から得る。 -/
theorem positiveNatural_twoPowerOddDecomposition_from_necSuf (d : ℕ) (hd : 1 ≤ d) :
    ∃ k m : ℕ, (∃ j : ℕ, m = j + j + 1) ∧ d = 2 ^ k * m :=
  Ising2DLambda.NecSuf.FisherZero.positiveNatural_twoPowerOddDecomposition_necSuf (R := ℕ)
    (· < ·) wellFounded_lt nat_eq_add_self_or_add_self_add_one
    (fun j hj => Nat.lt_add_of_pos_right (Nat.pos_of_ne_zero hj)) d
    (Nat.one_le_iff_ne_zero.mp hd)

/-- `claim_subfield_polynomial_root_in_imaginary_unit_extension` を必要十分版から得る。 -/
theorem subfieldPolynomialRoot_inImaginaryUnitExtension_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C → ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (hodd : ∀ (n : ℕ) (g : QbarPoly), g ∈ subfieldCoefficientPolynomials F → Odd n →
      g.coeff n ≠ 0 → (∀ k : ℕ, n < k → g.coeff k = 0) →
      ∃ z : Qbar, z ∈ F ∧ qbarPolyEval z g = 0)
    (omega : Qbar) (homega : omega * omega = -1)
    (d : ℕ) (hd : 1 ≤ d) (f : QbarPoly) (hf : f ∈ subfieldCoefficientPolynomials F)
    (hbound : ∀ k : ℕ, d < k → f.coeff k = 0) (hlead : f.coeff d = 1) :
    ∃ z : Qbar, z ∈ Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) ∧
      qbarPolyEval z f = 0 := by
  obtain ⟨α, hα⟩ := qbarMonicPolynomialLinearFactorProduct d f hbound hlead
  obtain ⟨z, hz, hzero⟩ :=
    Ising2DLambda.NecSuf.FisherZero.subfieldPolynomialRoot_inImaginaryUnitExtension_necSuf
      (F : Set Qbar) (Subfield.closure ((F : Set Qbar) ∪ ({omega} : Set Qbar)) : Set Qbar)
      (fun x hx => Subfield.subset_closure (Or.inl hx))
      (fun n g hg hn hgn hgz => by
        obtain ⟨z, hzF, hz⟩ := hodd n g hg hn hgn hgz
        exact ⟨z, hzF, by rw [← qbarPolyEval_eq_eval]; exact hz⟩)
      (fun k m hk hm hIH α' hα' =>
        subfieldPolynomialRoot_inductionStep F C hC hpositive omega homega k m (2 ^ k * m)
          hk hm rfl hIH α' hα')
      d hd f hf α hα
  exact ⟨z, hz, by rw [qbarPolyEval_eq_eval]; exact hzero⟩

end Ising2DLambda.FisherZero
