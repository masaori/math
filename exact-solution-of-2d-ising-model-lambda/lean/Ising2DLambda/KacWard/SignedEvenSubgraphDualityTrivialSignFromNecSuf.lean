import Ising2DLambda.KacWard.SignedEvenSubgraphDualityTrivialSign
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphDualityTrivialSign

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.FisherZero Polynomial

/-- The four-term abstract sign argument specializes to the torus polynomials. -/
theorem signedEvenSubgraphDuality_trivial_negative_sign_from_necSuf
    (data : RealClosedSubfieldData) (L : ℕ) [NeZero L] (hL : 1 ≤ L)
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (x : Qbar) (hx : x ^ 2 + 2 * x - 1 = 0) :
    signedEvenSubgraphDualityCleared L 0 0 =
      -(2 ^ (L ^ 2) *
        (signedEvenSubgraphPolynomial L 0 0).map (Int.castRingHom Qbar)) := by
  let Q : Fin 2 × Fin 2 → Qbar := fun s =>
    ((signedEvenSubgraphPolynomial L s.1 s.2).map (Int.castRingHom Qbar)).eval 1
  have hthree : ∀ s : Fin 2 × Fin 2, s ≠ (0, 0) → Q s = (2 : Qbar) ^ (L ^ 2) := by
    intro s hs
    rcases s with ⟨a, b⟩
    let t : SpinStructure := (a.val = 1, b.val = 1)
    have ht : t ≠ (false, false) := by
      intro h
      fin_cases a <;> fin_cases b
      · exact hs rfl
      · have hb := congrArg Prod.snd h
        simp [t] at hb
      · have ha := congrArg Prod.fst h
        simp [t] at ha
      · have ha := congrArg Prod.fst h
        simp [t] at ha
    have hs0 : spinComponentFin t.1 = a := by fin_cases a <;> rfl
    have hs1 : spinComponentFin t.2 = b := by fin_cases b <;> rfl
    simpa only [Q, hs0, hs1] using
      signed_eval_one_of_positive L t
        (signedEvenSubgraphDuality_nontrivial_positive_sign data L hL z hz t ht x hx)
  have hsum : (∑ s : Fin 2 × Fin 2, Q s) =
      2 * (2 : Qbar) ^ (L ^ 2) := by
    have hpoly := congrArg (fun p : Polynomial ℤ =>
      ((p.map (Int.castRingHom Qbar)).eval 1)) (finiteTorusPolynomial L)
    simpa only [Q, Polynomial.map_sum, Polynomial.eval_finsetSum,
      Polynomial.map_mul, Polynomial.eval_mul, Polynomial.map_ofNat,
      Polynomial.eval_ofNat, partition_eval_one] using hpoly
  have hsign : signedEvenSubgraphDualityCleared L 0 0 =
      2 ^ (L ^ 2) * (signedEvenSubgraphPolynomial L 0 0).map (Int.castRingHom Qbar) ∨
      signedEvenSubgraphDualityCleared L 0 0 =
      -(2 ^ (L ^ 2) * (signedEvenSubgraphPolynomial L 0 0).map (Int.castRingHom Qbar)) := by
    simpa [spinComponentFin] using
      signedEvenSubgraphDuality_up_to_sign L z hz (false, false)
  have heval : (signedEvenSubgraphDualityCleared L 0 0).eval 0 = Q (0, 0) := by
    rw [signedEvenSubgraphDualityCleared_eval L 0 0 0 (by norm_num)]
    simp [Q]
  have hq0 : ((signedEvenSubgraphPolynomial L 0 0).map
      (Int.castRingHom Qbar)).eval 0 = 1 := by
    simpa [spinComponentFin] using signed_eval_zero L (false, false)
  have hbranches : Q (0, 0) = (2 : Qbar) ^ (L ^ 2) ∨
      Q (0, 0) = -((2 : Qbar) ^ (L ^ 2)) := by
    rcases hsign with hp | hn
    · left
      rw [hp] at heval
      simpa only [Polynomial.eval_mul, Polynomial.eval_pow,
        Polynomial.eval_ofNat, hq0, mul_one] using heval.symm
    · right
      rw [hn] at heval
      simpa only [Polynomial.eval_neg, Polynomial.eval_mul,
        Polynomial.eval_pow, Polynomial.eval_ofNat, hq0, mul_one] using heval.symm
  have hnegative := Ising2DLambda.NecSuf.KacWard.duality_trivial_negative_sign
    (L ^ 2) Q ((2 : Qbar) ^ (L ^ 2)) hthree hsum rfl hbranches
  rcases hsign with hp | hn
  · have hpositive : Q (0, 0) = (2 : Qbar) ^ (L ^ 2) := by
      rw [hp] at heval
      simpa only [Polynomial.eval_mul, Polynomial.eval_pow,
        Polynomial.eval_ofNat, hq0, mul_one] using heval.symm
    have htwo : (2 : Qbar) * (2 : Qbar) ^ (L ^ 2) = 0 := by
      linear_combination hnegative - hpositive
    exact False.elim ((mul_ne_zero (by norm_num)
      (pow_ne_zero _ (by norm_num))) htwo)
  · exact hn

end Ising2DLambda.KacWard
