import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open BigOperators

/-- 有限集合の全単射、積の冪、有限和の分配律だけを残した冪和の形。 -/
theorem twistedMode_powerSum_necSuf {F I J : Type*}
    [CommRing F] [Fintype I] [Fintype J]
    (e : I ≃ J) (root : I → F) (ξ : F) (k : ℕ) (c : F)
    (hroot : (∑ y : I, root y ^ k) = c) :
    (∑ z : J, (ξ * root (e.symm z)) ^ k) = ξ ^ k * c := by
  calc
    (∑ z : J, (ξ * root (e.symm z)) ^ k)
        = ∑ y : I, (ξ * root y) ^ k := by
          exact (Fintype.sum_equiv e _ _ (fun _ => by simp)).symm
    _ = ∑ y : I, ξ ^ k * root y ^ k := by
      apply Finset.sum_congr rfl
      intro y _
      rw [mul_pow]
    _ = ξ ^ k * (∑ y : I, root y ^ k) := by rw [Finset.mul_sum]
    _ = ξ ^ k * c := by rw [hroot]

end Ising2DLambda.NecSuf.KacWard
