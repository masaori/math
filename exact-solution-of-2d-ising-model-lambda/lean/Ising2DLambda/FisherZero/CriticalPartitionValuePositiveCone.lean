/- 「分配多項式の臨界点での値は正錐の元である」の具体版。 -/
import Ising2DLambda.FisherZero.PositiveConeNatMul
import Ising2DLambda.FisherZero.PositiveConePow
import Ising2DLambda.FisherZero.SelfDualPositiveRoot
import Ising2DLambda.FisherZero.QuadraticPositiveConeAddClosed
import Ising2DLambda.FisherZero.PositiveRationalNotFisherZero
import Ising2DLambda.ThermodynamicLimit.ConstantPlusConfiguration
import Ising2DLambda.NecSuf.FisherZero.CriticalPartitionValuePositiveCone

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
open Ising2DLambda.ThermodynamicLimit

noncomputable def criticalCoefficientTerm (L : ℕ) [NeZero L] (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (m : ℕ) : QuadraticFieldElement s :=
  quadraticNatMulElement s hs (PartitionPolynomial.multiplicity L m)
    (quadraticPowElement s hs (criticalPoint s) m)

theorem criticalCoefficientTerm_coe (L : ℕ) [NeZero L] (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (m : ℕ) :
    (criticalCoefficientTerm L s hs m : Qbar) =
      (PartitionPolynomial.multiplicity L m : Qbar) * (criticalPoint s : Qbar) ^ m := by
  rw [criticalCoefficientTerm, quadraticNatMulElement_coe, quadraticPowElement_coe]
  norm_num

theorem multiplicity_zero_pos (L : ℕ) [NeZero L] :
    0 < PartitionPolynomial.multiplicity L 0 := by
  unfold PartitionPolynomial.multiplicity
  rw [Finset.card_pos]
  refine ⟨allPlusConfig L, ?_⟩
  simp [allPlusConfig_brokenBondCount_eq_zero L]

theorem criticalCoefficientTerm_zero_or_positive (L : ℕ) [NeZero L] (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (m : ℕ) :
    (criticalCoefficientTerm L s hs m : Qbar) = 0 ∨
      criticalCoefficientTerm L s hs m ∈ quadraticPositiveCone s := by
  have hpow := quadraticPositiveCone_pow_mem s hs (criticalPoint s)
    (selfDualRootPlus_mem_positiveCone s hs) m
  have h := quadraticNatMulElement_zero_or_mem_positiveCone s hs
    (PartitionPolynomial.multiplicity L m) (quadraticPowElement s hs (criticalPoint s) m) hpow
  rcases Nat.eq_zero_or_pos (PartitionPolynomial.multiplicity L m) with hz | hp
  · exact Or.inl (h.1 hz)
  · exact Or.inr (h.2 hp)

noncomputable def criticalPartitionPartialSum (L : ℕ) [NeZero L] (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) : ℕ → QuadraticFieldElement s :=
  Ising2DLambda.NecSuf.FisherZero.nonemptyPartialSum
    (quadraticAddElement s) (criticalCoefficientTerm L s hs)

theorem criticalPartitionPartialSum_coe (L : ℕ) [NeZero L] (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (n : ℕ) :
    (criticalPartitionPartialSum L s hs n : Qbar) =
      ∑ m ∈ Finset.range (n + 1),
        (PartitionPolynomial.multiplicity L m : Qbar) * (criticalPoint s : Qbar) ^ m := by
  induction n with
  | zero => simp [criticalPartitionPartialSum,
      Ising2DLambda.NecSuf.FisherZero.nonemptyPartialSum, criticalCoefficientTerm_coe]
  | succ n ih =>
      rw [criticalPartitionPartialSum,
        Ising2DLambda.NecSuf.FisherZero.nonemptyPartialSum]
      change (criticalPartitionPartialSum L s hs n : Qbar) +
          (criticalCoefficientTerm L s hs (n + 1) : Qbar) = _
      rw [ih, criticalCoefficientTerm_coe]
      simp only [Finset.sum_range_succ]

theorem qbarPolynomialEval_partitionPolynomial_eq_sum_multiplicity_qbar
    (L : ℕ) [NeZero L] (xi : Qbar) :
    qbarPolynomialEval xi (partitionPolynomial L) =
      ∑ m ∈ range (2 * L ^ 2 + 1),
        (PartitionPolynomial.multiplicity L m : Qbar) * xi ^ m := by
  rw [Ising2DLambda.PartitionPolynomial.partitionPolynomial_eq_sum_multiplicity]
  simp [qbarPolynomialEval]

theorem criticalPartitionValue_mem_positiveCone (L : ℕ) [NeZero L] (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    ∃ xi : QuadraticFieldElement s,
      (xi : Qbar) = qbarPolynomialEval (criticalPoint s : Qbar) (partitionPolynomial L) ∧
        xi ∈ quadraticPositiveCone s := by
  let f := criticalCoefficientTerm L s hs
  have hfirst : f 0 ∈ quadraticPositiveCone s := by
    exact (quadraticNatMulElement_zero_or_mem_positiveCone s hs
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
