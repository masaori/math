import Mathlib.Combinatorics.SimpleGraph.Acyclic
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

/-- Removing the chosen leaf from the unprocessed vertex set preserves its induced tree. -/
theorem inducedTree_removeLeaf (n : ℕ) (T : SimpleGraph (Fin n))
    [DecidableRel T.Adj] (U : Finset (Fin n))
    (hTree : (T.induce (U : Set (Fin n))).IsTree)
    (root leaf parent : {w : Fin n // w ∈ U}) (hroot : root ≠ leaf)
    (hadj : (T.induce (U : Set (Fin n))).Adj leaf parent)
    (hleaf : ∀ w : {w : Fin n // w ∈ U},
      (T.induce (U : Set (Fin n))).Adj leaf w → w = parent) :
    root.1 ∈ U.erase leaf.1 ∧
      (T.induce (U.erase leaf.1 : Set (Fin n))).IsTree := by
  classical
  let H := T.induce (U : Set (Fin n))
  have hleafUnique : ∃! w : {w : Fin n // w ∈ U}, H.Adj leaf w :=
    ⟨parent, hadj, fun w hw => hleaf w hw⟩
  have hneighbors : (H.neighborSet leaf).Subsingleton := by
    intro a ha b hb
    exact hleafUnique.unique ha hb
  have hpre : (H.induce ({leaf}ᶜ : Set {w : Fin n // w ∈ U})).Preconnected := by
    rintro ⟨u, hu⟩ ⟨w, hw⟩
    obtain ⟨p, hp⟩ := hTree.connected.preconnected.exists_isPath u w
    constructor
    convert! p.induce ({leaf}ᶜ : Set {w : Fin n // w ∈ U}) _
    intro z hz
    by_contra hzs
    have hzl : z = leaf := by simpa using hzs
    subst z
    exact hp.not_mem_support_of_subsingleton_neighborSet
      (by simpa using Ne.symm hu) (by simpa using Ne.symm hw) hneighbors hz
  have hconnected : (H.induce ({leaf}ᶜ : Set {w : Fin n // w ∈ U})).Connected :=
    { preconnected := hpre
      nonempty := ⟨⟨root, by simpa using hroot⟩⟩ }
  have hTree' : (H.induce ({leaf}ᶜ : Set {w : Fin n // w ∈ U})).IsTree :=
    ⟨hconnected, hTree.isAcyclic.induce _⟩
  have hrootErase : root.1 ∈ U.erase leaf.1 := by
    exact Finset.mem_erase.mpr ⟨fun h => hroot (Subtype.ext h), root.2⟩
  let e : {w : Fin n // w ∈ U.erase leaf.1} ≃
      {w : {w : Fin n // w ∈ U} // w ≠ leaf} := {
    toFun w := ⟨⟨w.1, (Finset.mem_erase.mp w.2).2⟩,
      fun h => (Finset.mem_erase.mp w.2).1 (congrArg Subtype.val h)⟩
    invFun w := ⟨w.1.1, Finset.mem_erase.mpr
      ⟨fun h => w.2 (Subtype.ext h), w.1.2⟩⟩
    left_inv w := by cases w; rfl
    right_inv w := by cases w with | mk w hw => cases w; rfl
  }
  let iso : T.induce (U.erase leaf.1 : Set (Fin n)) ≃g
      (T.induce (U : Set (Fin n))).induce ({leaf}ᶜ) := {
    __ := e
    map_rel_iff' := by intro a b; rfl
  }
  exact ⟨hrootErase, iso.isTree_iff.mpr hTree'⟩

end Ising2DLambda.Tools
