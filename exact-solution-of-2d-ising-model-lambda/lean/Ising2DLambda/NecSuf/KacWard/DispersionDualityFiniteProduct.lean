import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- Multiplying the denominator-cleared identity over a finite set uses only
commutative multiplication and the identity at each factor. -/
theorem dispersion_duality_finite_product {K : Type*} [CommRing K]
    {α : Type*} [Fintype α] (x : K) (f g : α → K)
    (h : ∀ m, (1 + x) ^ 4 * f m = 4 * g m) :
    (1 + x) ^ (4 * Fintype.card α) * ∏ m, f m =
      4 ^ Fintype.card α * ∏ m, g m := by
  classical
  calc
    (1 + x) ^ (4 * Fintype.card α) * ∏ m, f m =
        ∏ m : α, ((1 + x) ^ 4 * f m) := by
      rw [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ]
      rw [← pow_mul]
    _ = ∏ m : α, (4 * g m) := Finset.prod_congr rfl (fun m _ => h m)
    _ = 4 ^ Fintype.card α * ∏ m, g m := by
      rw [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ]

end Ising2DLambda.NecSuf.KacWard
