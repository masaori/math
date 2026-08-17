/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.FisherZero.FisherZeroSetNonempty
import Ising2DLambda.NecSuf.FisherZero.FisherZeroSetNonempty

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
open Ising2DLambda.ThermodynamicLimit

theorem fisherZeroSet_nonempty_from_necSuf (L : ℕ) [NeZero L] (hL : 2 ≤ L) :
    (FisherZeroSet L).Nonempty := by
  obtain ⟨m, hmpos, hmultpos⟩ := positive_multiplicity_exists L hL
  let g := integerPolynomialQbarLift (partitionPolynomial L)
  have hmle : m ≤ 2 * L ^ 2 := by
    obtain ⟨σ, hσ⟩ := Finset.card_pos.mp hmultpos
    simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hσ
    rw [← hσ]
    exact brokenBondCount_le L σ
  have hcoeff : g.coeff m = (PartitionPolynomial.multiplicity L m : Qbar) := by
    simp only [g, integerPolynomialQbarLift_coeff, partitionPolynomial_coeff L m, if_pos hmle]
    norm_num
  have hcoeffne : g.coeff m ≠ 0 := by
    rw [hcoeff]
    exact_mod_cast (Nat.ne_of_gt hmultpos)
  obtain ⟨xi, hxi⟩ :=
    Ising2DLambda.NecSuf.FisherZero.rootSet_nonempty_of_positive_coeff_necSuf
      g m hmpos hcoeffne (fun hdegree => IsAlgClosed.exists_root g hdegree)
  refine ⟨xi, ?_⟩
  rw [mem_fisherZero]
  rw [← qbarPolyEval_integerPolynomialQbarLift xi (partitionPolynomial L)]
  rw [qbarPolyEval_eq_eval]
  exact hxi

end Ising2DLambda.FisherZero
