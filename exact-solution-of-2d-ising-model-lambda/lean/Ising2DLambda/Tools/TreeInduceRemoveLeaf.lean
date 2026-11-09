import Mathlib.Combinatorics.SimpleGraph.Acyclic
import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

/-- Removing a leaf other than the root preserves the rooted tree. -/
theorem tree_induce_remove_leaf (n : ℕ) (G : SimpleGraph (Fin n))
    [DecidableRel G.Adj] (hG : G.IsTree) (root leaf parent : Fin n)
    (hroot : root ≠ leaf) (hparent : G.Adj leaf parent)
    (hleaf : ∀ w : Fin n, G.Adj leaf w → w = parent) :
    root ∈ ({leaf}ᶜ : Set (Fin n)) ∧
      (G.induce ({leaf}ᶜ : Set (Fin n))).IsTree := by
  classical
  constructor
  · simpa using hroot
  have hleafUnique : ∃! w : Fin n, G.Adj leaf w :=
    ⟨parent, hparent, fun w hw => hleaf w hw⟩
  have hneighbors : (G.neighborSet leaf).Subsingleton := by
    intro a ha b hb
    exact hleafUnique.unique ha hb
  have hpre : (G.induce ({leaf}ᶜ : Set (Fin n))).Preconnected := by
    rintro ⟨u, hu⟩ ⟨w, hw⟩
    obtain ⟨p, hp⟩ := hG.connected.preconnected.exists_isPath u w
    constructor
    convert! p.induce ({leaf}ᶜ : Set (Fin n)) _
    intro z hz
    by_contra hzs
    have hzl : z = leaf := by simpa using hzs
    subst z
    exact hp.not_mem_support_of_subsingleton_neighborSet
      (by simpa using Ne.symm hu) (by simpa using Ne.symm hw) hneighbors hz
  have hconnected : (G.induce ({leaf}ᶜ : Set (Fin n))).Connected :=
    { preconnected := hpre
      nonempty := ⟨⟨root, by simpa using hroot⟩⟩ }
  exact ⟨hconnected, hG.isAcyclic.induce _⟩

end Ising2DLambda.Tools
