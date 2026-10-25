import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairFirstEnumeration

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped Classical

variable {J : Type*} [LinearOrder J]

/-- A color-reversing involution transfers an enumeration of the first color
to the second; the second involution then enumerates its ascending pairs. -/
theorem matchingPairSecondEnumeration_necSuf
    (f g : J → J) (C : Set J) (w : List J)
    (hf : ∀ i, f (f i) = i)
    (hflipF : ∀ i, f i ∈ C ↔ i ∉ C)
    (hflipG : ∀ i, g i ∈ C ↔ i ∉ C)
    (hw : w.Nodup) (hcolor : ∀ i, i ∈ w ↔ i ∈ C) :
    let w₂ := w.map f
    let l := w₂.map (ascendingMatePair g)
    l.Nodup ∧
      l.flatMap (fun p => if p.1 ∉ C then [p.1, p.2] else [p.2, p.1]) =
        w₂.flatMap (fun i => [i, g i]) := by
  classical
  dsimp
  have hinj : Function.Injective f := by
    intro i j hij
    calc i = f (f i) := (hf i).symm
      _ = f (f j) := by rw [hij]
      _ = j := hf j
  have hw₂ : (w.map f).Nodup := hw.map hinj
  have hcolor₂ (i : J) : i ∈ w.map f ↔ i ∉ C := by
    constructor
    · intro him
      obtain ⟨j, hj, rfl⟩ := List.mem_map.mp him
      intro hfj
      exact ((hflipF j).mp hfj) ((hcolor j).mp hj)
    · intro hi
      have hfi : f i ∈ C := (hflipF i).mpr hi
      exact List.mem_map.mpr ⟨f i, (hcolor _).mpr hfi, hf i⟩
  have hflip₂ (i : J) : g i ∉ C ↔ i ∈ C := by
    simpa using not_congr (hflipG i)
  have h := matchingPairFirstEnumeration_necSuf g {i | i ∉ C} (w.map f)
    (by intro i; simpa using hflip₂ i) hw₂
    (by intro i; exact hcolor₂ i)
  constructor
  · exact h.1
  · have heq : ((w.map f).map (ascendingMatePair g)).flatMap
        (fun p => if p.1 ∉ C then [p.1, p.2] else [p.2, p.1]) =
        ((w.map f).map (ascendingMatePair g)).flatMap
        (fun p => @ite (List J) (p.1 ∈ {i | i ∉ C})
          (Classical.propDecidable _) [p.1, p.2] [p.2, p.1]) := by
        apply List.flatMap_congr
        intro p hp
        by_cases hs : p.1 ∉ C <;> simp [hs]
    exact heq.trans h.2

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
