/- 具体版の有限和の帰納法が必要十分版の特殊化であることを記録する。 -/
import Ising2DLambda.FisherZero.CriticalPartitionValuePositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial

theorem criticalPartitionValue_mem_positiveCone_from_necSuf (L : ℕ) [NeZero L]
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    ∃ xi : QuadraticFieldElement s,
      (xi : Qbar) = qbarPolynomialEval (criticalPoint s : Qbar)
        (Ising2DLambda.PartitionPolynomial.partitionPolynomial L) ∧
        xi ∈ quadraticPositiveCone s := by
  let f := criticalCoefficientTerm L s hs
  have hfirst : f 0 ∈ quadraticPositiveCone s :=
    (quadraticNatMulElement_zero_or_mem_positiveCone s hs
      (PartitionPolynomial.multiplicity L 0) (quadraticPowElement s hs (criticalPoint s) 0)
      (quadraticPositiveCone_pow_mem s hs (criticalPoint s)
        (selfDualRootPlus_mem_positiveCone s hs) 0)).2 (multiplicity_zero_pos L)
  have hterm : ∀ n : ℕ, f (n + 1) = positiveRationalElement s 0 ∨
      f (n + 1) ∈ quadraticPositiveCone s := by
    intro n
    rcases criticalCoefficientTerm_zero_or_positive L s hs (n + 1) with hz | hp
    · left
      apply Subtype.ext
      simpa [positiveRationalElement] using hz
    · exact Or.inr hp
  have hpositive := Ising2DLambda.NecSuf.FisherZero.nonempty_sum_mem_positive_necSuf
    (quadraticPositiveCone s) (quadraticAddElement s) f (positiveRationalElement s 0)
    (fun x => by apply Subtype.ext; simp [quadraticAddElement, positiveRationalElement])
    (fun x y hx hy => quadraticPositiveCone_add_mem s hs x y hx hy)
    hfirst hterm (2 * L ^ 2)
  refine ⟨criticalPartitionPartialSum L s hs (2 * L ^ 2), ?_, hpositive⟩
  rw [criticalPartitionPartialSum_coe]
  exact (qbarPolynomialEval_partitionPolynomial_eq_sum_multiplicity_qbar L
    (criticalPoint s : Qbar)).symm

end Ising2DLambda.FisherZero
