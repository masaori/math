/- 必要十分版を具体的な Λ_ℚ・ι・既約分数へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.CommonDenominatorExists
import Ising2DLambda.NecSuf.ThermodynamicLimit.CommonDenominatorExists

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem commonDenominator_exists_from_necSuf (l : RationalLogOrderGroup) :
    1 ≤ denominatorProduct l ∧
      IsCommonDenominator (denominatorProduct l) l (commonDenominatorWitness l) := by
  have h := NecSuf.ThermodynamicLimit.denominator_product_clears_necSuf
    (K := ℚ) l.support (fun p => l p) (fun p hp => Finsupp.notMem_support_iff.mp hp)
    (fun p => (l p).den) (fun p => Nat.one_le_iff_ne_zero.mpr (l p).den_nz)
    (fun p => (l p).num) (fun z => (z : ℚ))
    (fun p _ => by rw [mul_comm]; exact Rat.mul_den_eq_num (l p))
    (fun n m => by push_cast; ring)
    (by simp)
  obtain ⟨hpos, hpt⟩ := h
  refine ⟨hpos, ?_⟩
  unfold IsCommonDenominator
  ext p
  rw [Finsupp.smul_apply, smul_eq_mul, toRational_apply, commonDenominatorWitness_apply]
  have hp' := hpt p
  dsimp only at hp'
  by_cases hp : p ∈ l.support
  · rw [if_pos hp] at hp'
    exact hp'
  · rw [if_neg hp] at hp'
    have h0 : l p = 0 := Finsupp.notMem_support_iff.mp hp
    have hp'' : ((denominatorProduct l : ℕ) : ℚ) * l p = ((0 : ℤ) : ℚ) := hp'
    rw [hp'', h0]
    simp

end Ising2DLambda.ThermodynamicLimit
