import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 全元列への置換作用の等式に、転倒符号の乗法性を適用する。 -/
theorem matchingPairWordSignMap_necSuf (base first : List J)
    (hb : IsCompleteWord base) (hf : IsCompleteWord first) (σ : Equiv.Perm J) :
    sign (fun x y : J => x < y)
        (completeWordPermutation base (first.map σ) hb (completeWord_map first hf σ)) =
      sign (fun x y : J => x < y) σ *
        sign (fun x y : J => x < y) (completeWordPermutation base first hb hf) := by
  have htri : Trichotomous (fun x y : J => x < y) := by
    intro x y
    rcases lt_trichotomy x y with h | h | h
    · exact Or.inl ⟨h, h.ne, h.not_gt⟩
    · exact Or.inr (Or.inl ⟨by simp [h], h, by simp [h]⟩)
    · exact Or.inr (Or.inr ⟨h.not_gt, h.ne', h⟩)
  rw [completeWordPermutation_map, sign_comp _ htri]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
