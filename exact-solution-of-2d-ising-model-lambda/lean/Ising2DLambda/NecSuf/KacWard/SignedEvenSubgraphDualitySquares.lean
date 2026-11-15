import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- The square argument uses an infinite integral domain, the cardinality of
the mode set, and the three identities already proved in the human proof. -/
theorem duality_squares {K : Type*} [CommRing K] [IsDomain K] [Infinite K]
    {ι : Type*} [Fintype ι] (n : ℕ) (q d f : Polynomial K) (τ : K → K)
    (good : K → Prop) (hgood : Set.Infinite {x | good x})
    (hcard : Fintype.card ι = n)
    (hsquare : d = q ^ 2)
    (hclear : ∀ x, good x → f.eval x = (1 + x) ^ (2 * n) * q.eval (τ x))
    (hmode : ∀ x, good x →
      (1 + x) ^ (4 * Fintype.card ι) * d.eval (τ x) =
        4 ^ Fintype.card ι * d.eval x) :
    f ^ 2 = (2 ^ n * q) ^ 2 := by
  apply Polynomial.eq_of_infinite_eval_eq
  apply hgood.mono
  intro x hx
  change good x at hx
  change (f ^ 2).eval x = ((2 ^ n * q) ^ 2).eval x
  have hm := hmode x hx
  rw [hcard, hsquare] at hm
  simp only [Polynomial.eval_pow] at hm
  simp only [Polynomial.eval_pow, Polynomial.eval_mul, Polynomial.eval_ofNat]
  rw [hclear x hx]
  calc
    ((1 + x) ^ (2 * n) * q.eval (τ x)) ^ 2 =
        (1 + x) ^ (4 * n) * (q.eval (τ x)) ^ 2 := by ring
    _ = 4 ^ n * (q.eval x) ^ 2 := hm
    _ = (2 ^ n * q.eval x) ^ 2 := by
      have hpow : (4 : K) ^ n = (2 ^ n) ^ 2 := by
        rw [show (4 : K) = 2 ^ 2 by ring, ← pow_mul, ← pow_mul,
          Nat.mul_comm 2 n]
      rw [hpow]
      ring

end Ising2DLambda.NecSuf.KacWard
