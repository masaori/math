import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- A list of one endpoint per involution pair expands to a complete list. -/
theorem matchingPairFirstWordComplete_necSuf {J : Type*} [Fintype J]
    (f : J → J) (S : Set J) (w : List J)
    (hinv : Function.Involutive f)
    (hflip : ∀ i : J, f i ∈ S ↔ i ∉ S)
    (hw : w.Nodup) (hcolor : ∀ i : J, i ∈ w ↔ i ∈ S) :
    (w.flatMap (fun i => [i, f i])).Nodup ∧
      ∀ x : J, x ∈ w.flatMap (fun i => [i, f i]) := by
  classical
  constructor
  · apply List.nodup_flatMap.mpr
    constructor
    · intro i hi
      have hne : f i ≠ i := by
        intro he
        by_cases his : i ∈ S
        · exact ((hflip i).mp (he.symm ▸ his)) his
        · exact his (he ▸ (hflip i).mpr his)
      simpa using hne.symm
    · apply hw.imp_of_mem
      intro i j hi hj hij
      apply List.disjoint_left.mpr
      intro x hxi hxj
      simp only [List.mem_cons, List.not_mem_nil, or_false] at hxi hxj
      rcases hxi with hxi | hxi <;> rcases hxj with hxj | hxj
      · exact hij (hxi.symm.trans hxj)
      · have hjc : j ∈ S := (hcolor j).mp hj
        have hnot : f j ∉ S := fun h => ((hflip j).mp h) hjc
        have he : i = f j := hxi.symm.trans hxj
        exact hnot (he ▸ (hcolor i).mp hi)
      · have hic : i ∈ S := (hcolor i).mp hi
        have hnot : f i ∉ S := fun h => ((hflip i).mp h) hic
        have he : f i = j := hxi.symm.trans hxj
        exact hnot (he.symm ▸ (hcolor j).mp hj)
      · exact hij (hinv.injective (hxi.symm.trans hxj))
  · intro x
    by_cases hx : x ∈ S
    · exact List.mem_flatMap.mpr ⟨x, (hcolor x).mpr hx, by simp⟩
    · have hmate : f x ∈ S := (hflip x).mpr hx
      apply List.mem_flatMap.mpr
      refine ⟨f x, (hcolor _).mpr hmate, ?_⟩
      simp [hinv x]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
