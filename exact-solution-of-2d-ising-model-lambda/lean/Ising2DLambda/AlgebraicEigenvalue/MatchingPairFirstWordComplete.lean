import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordMap
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairFirstWordComplete

namespace Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The first color chooses exactly one endpoint of every pair of the first matching. -/
theorem matchingPairFirstWordComplete (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    IsCompleteWord (w.flatMap (fun i => [i, τ.val i])) := by
  classical
  constructor
  · apply List.nodup_flatMap.mpr
    constructor
    · intro i hi
      simpa using (τ.property.1 i).symm
    · apply hw.imp_of_mem
      intro i j hi hj hij
      apply List.disjoint_left.mpr
      intro x hxi hxj
      simp only [List.mem_cons, List.not_mem_nil, or_false] at hxi hxj
      rcases hxi with hxi | hxi <;> rcases hxj with hxj | hxj
      · exact hij (hxi.symm.trans hxj)
      · have hjc : j ∈ matchingPairColor τ υ := (hcolor j).mp hj
        have hnot : τ.val j ∉ matchingPairColor τ υ :=
          fun h => ((matchingPairColor_alternates τ υ j).mp h) hjc
        have he : i = τ.val j := hxi.symm.trans hxj
        exact hnot (he ▸ (hcolor i).mp hi)
      · have hic : i ∈ matchingPairColor τ υ := (hcolor i).mp hi
        have hnot : τ.val i ∉ matchingPairColor τ υ :=
          fun h => ((matchingPairColor_alternates τ υ i).mp h) hic
        have he : τ.val i = j := hxi.symm.trans hxj
        exact hnot (he.symm ▸ (hcolor j).mp hj)
      · exact hij ((τ.property.2).injective (hxi.symm.trans hxj))
  · intro x
    by_cases hx : x ∈ matchingPairColor τ υ
    · exact List.mem_flatMap.mpr ⟨x, (hcolor x).mpr hx, by simp⟩
    · have hmate : τ.val x ∈ matchingPairColor τ υ :=
        (matchingPairColor_alternates τ υ x).mpr hx
      apply List.mem_flatMap.mpr
      refine ⟨τ.val x, (hcolor _).mpr hmate, ?_⟩
      simp [τ.property.2 x]

/-- The generic involution argument applies to the actual first color. -/
theorem matchingPairFirstWordComplete_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : w.Nodup)
    (hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ) :
    IsCompleteWord (w.flatMap (fun i => [i, τ.val i])) := by
  exact NecSuf.AlgebraicEigenvalue.matchingPairFirstWordComplete_necSuf
    τ.val (matchingPairColor τ υ) w τ.property.2
    (matchingPairColor_alternates τ υ) hw hcolor

end Ising2DLambda.AlgebraicEigenvalue
