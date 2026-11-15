import Ising2DLambda.KacWard.SignedEvenSubgraphDualityPolynomiality
import Ising2DLambda.KacWard.DispersionDualityFiniteProduct
import Ising2DLambda.KacWard.DeterminantSignedEvenSubgraphSquare

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The mode pairs have the cardinality used in the third line of the human proof. -/
theorem fourierModePair_card_eq (L : ℕ) [NeZero L] (s : SpinStructure) :
    Fintype.card (FourierModePair L s) = L ^ 2 := by
  classical
  obtain ⟨hU, hW, hUcard, hWcard⟩ := modeIndex_card_data (L := L) s
  rw [← Nat.card_eq_fintype_card]
  change Nat.card {p : Qbar × Qbar //
    p ∈ horizontalTwistedModes L s ×ˢ verticalTwistedModes L s} = L ^ 2
  rw [Nat.card_coe_set_eq, Set.ncard_prod, hUcard, hWcard]
  ring

/-- The square identity for the actual signed subgraph polynomial, before
extracting the sign. The equality is in `Qbar[X]`. -/
theorem signedEvenSubgraphDuality_squares (L : ℕ) [NeZero L]
    (z : Qbar) (hz : z ^ 4 = -1) (s : SpinStructure) :
    (signedEvenSubgraphDualityCleared L (spinComponentFin s.1)
      (spinComponentFin s.2)) ^ 2 =
      (2 ^ (L ^ 2) *
        (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
          (spinComponentFin s.2)).map (Int.castRingHom Qbar)) ^ 2 := by
  let q : QbarPoly :=
    (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
      (spinComponentFin s.2)).map (Int.castRingHom Qbar)
  let d : QbarPoly := kacWardDeterminant (kacWardTransitionMatrix L z s)
  let f : QbarPoly := signedEvenSubgraphDualityCleared L
    (spinComponentFin s.1) (spinComponentFin s.2)
  apply Polynomial.eq_of_infinite_eval_eq
  have hinf : Set.Infinite {x : Qbar | 1 + x ≠ 0} := by
    have h : ({(-1 : Qbar)} : Set Qbar).Finite := Set.finite_singleton _
    have heq : {x : Qbar | 1 + x ≠ 0} = ({(-1 : Qbar)} : Set Qbar)ᶜ := by
      ext x
      simp only [Set.mem_setOf_eq, Set.mem_compl_iff, Set.mem_singleton_iff]
      constructor
      · intro hx heq
        subst x
        exact hx (by ring)
      · intro hx hzero
        apply hx
        linear_combination hzero
    rw [heq]
    exact h.infinite_compl
  apply hinf.mono
  intro x hx
  change 1 + x ≠ 0 at hx
  change (f ^ 2).eval x = ((2 ^ (L ^ 2) * q) ^ 2).eval x
  have hmode := dispersion_mode_product_duality_factor (L := L) z x hz s hx
  rw [fourierModePair_card_eq L s] at hmode
  have hsq : d = q ^ 2 := kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq z hz s
  rw [Polynomial.eval_pow, Polynomial.eval_pow, Polynomial.eval_mul,
    Polynomial.eval_pow, Polynomial.eval_ofNat]
  rw [signedEvenSubgraphDualityCleared_eval L (spinComponentFin s.1)
    (spinComponentFin s.2) x hx]
  change ((1 + x) ^ (2 * L ^ 2) * q.eval ((1 - x) / (1 + x))) ^ 2 =
    (2 ^ (L ^ 2) * q.eval x) ^ 2
  have hmode' : (1 + x) ^ (4 * L ^ 2) * d.eval ((1 - x) / (1 + x)) =
      4 ^ (L ^ 2) * d.eval x := by
    simpa only [Ising2DLambda.FisherZero.kwDualTransform, div_eq_mul_inv] using hmode
  rw [hsq] at hmode'
  simp only [Polynomial.eval_pow] at hmode'
  calc
    ((1 + x) ^ (2 * L ^ 2) * q.eval ((1 - x) / (1 + x))) ^ 2 =
        (1 + x) ^ (4 * L ^ 2) * (q.eval ((1 - x) / (1 + x))) ^ 2 := by
          ring
    _ = 4 ^ (L ^ 2) * (q.eval x) ^ 2 := hmode'
    _ = (2 ^ (L ^ 2) * q.eval x) ^ 2 := by
      have hpow : (4 : Qbar) ^ (L ^ 2) = (2 ^ (L ^ 2)) ^ 2 := by
        rw [show (4 : Qbar) = 2 ^ 2 by norm_num, ← pow_mul, ← pow_mul,
          Nat.mul_comm 2 (L ^ 2)]
      rw [hpow]
      ring

end Ising2DLambda.KacWard
