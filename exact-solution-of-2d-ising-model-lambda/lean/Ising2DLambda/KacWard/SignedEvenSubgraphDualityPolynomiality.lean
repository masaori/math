import Ising2DLambda.KacWard.SignedEvenSubgraphSectorSum
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial Ising2DLambda.FisherZero

/-- The degree bound is the number of torus edges, as in the first line of the human proof. -/
theorem signedEvenSubgraphPolynomial_natDegree_le (L : ℕ) [NeZero L]
    (a b : Fin 2) :
    (signedEvenSubgraphPolynomial L a b).natDegree ≤ 2 * L ^ 2 := by
  unfold signedEvenSubgraphPolynomial
  refine Polynomial.natDegree_sum_le_of_forall_le _ _ ?_
  intro A hA
  calc
    (signedEvenSubgraphCoefficient a b (torusHomologySector L A) *
        (Polynomial.X : Polynomial ℤ) ^ A.card).natDegree
        ≤ (signedEvenSubgraphCoefficient a b (torusHomologySector L A)).natDegree +
          ((Polynomial.X : Polynomial ℤ) ^ A.card).natDegree := Polynomial.natDegree_mul_le
    _ = A.card := by simp [signedEvenSubgraphCoefficient]
    _ ≤ Fintype.card (Edge L) := Finset.card_le_univ _
    _ = 2 * L ^ 2 := card_edge L

/-- The denominator-cleared expression for a polynomial of degree at most `n`.
Its coefficients remain in `Qbar`; no real or complex realization is used. -/
noncomputable def dualityDenominatorCleared (n : ℕ) (p : QbarPoly) : QbarPoly :=
  ∑ j ∈ Finset.range (n + 1), Polynomial.C (p.coeff j) *
    (1 - Polynomial.X) ^ j * (1 + Polynomial.X) ^ (n - j)

theorem dualityDenominatorCleared_eval (n : ℕ) (p : QbarPoly)
    (hn : p.natDegree ≤ n) (x : Qbar) (hx : 1 + x ≠ 0) :
    (dualityDenominatorCleared n p).eval x =
      (1 + x) ^ n * p.eval ((1 - x) / (1 + x)) := by
  rw [dualityDenominatorCleared, Polynomial.eval_finsetSum]
  simp only [Polynomial.eval_mul, Polynomial.eval_pow, Polynomial.eval_add,
    Polynomial.eval_sub, Polynomial.eval_one, Polynomial.eval_X, Polynomial.eval_C]
  rw [Polynomial.eval_eq_sum_range' (Nat.lt_succ_of_le hn), Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  have hjle : j ≤ n := Nat.le_of_lt_succ (Finset.mem_range.mp hj)
  rw [div_pow, div_eq_mul_inv]
  have hpow : (1 + x) ^ n * ((1 + x) ^ j)⁻¹ = (1 + x) ^ (n - j) := by
    conv_lhs => rw [← Nat.sub_add_cancel hjle, pow_add]
    simp [pow_ne_zero j hx]
  symm
  calc
    (1 + x) ^ n * (p.coeff j * ((1 - x) ^ j * ((1 + x) ^ j)⁻¹))
        = p.coeff j * (1 - x) ^ j * ((1 + x) ^ n * ((1 + x) ^ j)⁻¹) := by ring
    _ = p.coeff j * (1 - x) ^ j * (1 + x) ^ (n - j) := by rw [hpow]

/-- The concrete coefficient expression for the signed even-subgraph polynomial. -/
noncomputable def signedEvenSubgraphDualityCleared (L : ℕ) [NeZero L]
    (a b : Fin 2) : QbarPoly :=
  dualityDenominatorCleared (2 * L ^ 2)
    ((signedEvenSubgraphPolynomial L a b).map (Int.castRingHom Qbar))

theorem signedEvenSubgraphDualityCleared_eval (L : ℕ) [NeZero L]
    (a b : Fin 2) (x : Qbar) (hx : 1 + x ≠ 0) :
    (signedEvenSubgraphDualityCleared L a b).eval x =
      (1 + x) ^ (2 * L ^ 2) *
        ((signedEvenSubgraphPolynomial L a b).map (Int.castRingHom Qbar)).eval
          ((1 - x) / (1 + x)) := by
  have hdegree :
      ((signedEvenSubgraphPolynomial L a b).map (Int.castRingHom Qbar)).natDegree ≤
        2 * L ^ 2 :=
    Polynomial.natDegree_map_le.trans (signedEvenSubgraphPolynomial_natDegree_le L a b)
  exact dualityDenominatorCleared_eval (2 * L ^ 2)
    ((signedEvenSubgraphPolynomial L a b).map (Int.castRingHom Qbar)) hdegree x hx

end Ising2DLambda.KacWard
