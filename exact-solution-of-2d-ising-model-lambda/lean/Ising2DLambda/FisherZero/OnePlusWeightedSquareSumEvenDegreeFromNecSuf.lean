/- 必要十分版を Qbar の部分体とその正錐へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.OnePlusWeightedSquareSumEvenDegree
import Ising2DLambda.NecSuf.FisherZero.OnePlusWeightedSquareSumEvenDegree

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_subfield_positive_cone_contains_nonzero_squares` を必要十分版から得る。 -/
theorem mul_self_mem_of_isSubfieldPositiveCone_from_necSuf (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) (a : Qbar) (ha : a ∈ F) (ha0 : a ≠ 0) :
    a * a ∈ CF :=
  Ising2DLambda.NecSuf.FisherZero.mul_self_mem_of_cover_necSuf CF hCF.mul_mem a
    (hCF.trichotomy a ha).1 ha0

/-- `claim_qbar_poly_square_top_coefficient` を必要十分版から得る。 -/
theorem qbarPolySquareTopCoeff_from_necSuf (f : QbarPoly) (m : ℕ)
    (hf : ∀ k, m < k → f.coeff k = 0) :
    (f * f).coeff (2 * m) = f.coeff m * f.coeff m :=
  Ising2DLambda.NecSuf.FisherZero.squareTopCoeff_necSuf f m hf

/-- `claim_one_plus_weighted_square_sum_polynomial_even_degree` を必要十分版から得る。
単位元の所属と零でない元の平方は具体版の前段（`mul_self_mem_of_isSubfieldPositiveCone`）、
零元を含まないことは三分法の排他性から渡す。 -/
theorem onePlusWeightedSquareSum_evenDegree_from_necSuf (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) {ι : Type} [Fintype ι] (c : ι → Qbar) (g : ι → QbarPoly)
    (hc : ∀ i, c i ∈ CF) (hg : ∀ i, g i ∈ subfieldCoefficientPolynomials F) :
    (1 + ∑ i, qbarConst (c i) * (g i * g i)) ≠ 0 ∧
      ∃ m : ℕ, (1 + ∑ i, qbarConst (c i) * (g i * g i)).coeff (2 * m) ∈ CF ∧
        ∀ k : ℕ, 2 * m < k → (1 + ∑ i, qbarConst (c i) * (g i * g i)).coeff k = 0 := by
  have h1C : (1 : Qbar) ∈ CF := by
    have h := mul_self_mem_of_isSubfieldPositiveCone_from_necSuf F CF hCF 1 F.one_mem one_ne_zero
    rw [mul_one] at h
    exact h
  have h0C : (0 : Qbar) ∉ CF := fun h0 =>
    (hCF.trichotomy 0 (hCF.subset 0 h0)).2.1 ⟨rfl, h0⟩
  exact Ising2DLambda.NecSuf.FisherZero.onePlusWeightedSquareSum_evenDegree_necSuf
    (F : Set Qbar) CF hCF.add_mem hCF.mul_mem h1C h0C
    (fun a ha ha0 => mul_self_mem_of_isSubfieldPositiveCone_from_necSuf F CF hCF a ha ha0)
    c g hc hg

end Ising2DLambda.FisherZero
