import Ising2DLambda.NecSuf.Tools.EvenEdgeSymmDiff

namespace Ising2DLambda.NecSuf.Tools

open scoped symmDiff

private theorem incidenceParity_eq_one_of_unique {E V : Type*}
    [Fintype E] [DecidableEq E] (incident : V → E → Prop) [DecidableRel incident]
    (D : Finset E) (v : V) (e : E) (he : e ∈ D) (hve : incident v e)
    (hunique : ∀ f ∈ D, incident v f → f = e) :
    incidenceParity incident D v = 1 := by
  classical
  unfold incidenceParity
  rw [Finset.sum_eq_single e]
  · simp [he, hve]
  · intro f _ hne
    by_cases hf : f ∈ D
    · by_cases hvf : incident v f
      · exact (hne (hunique f hf hvf)).elim
      · simp [hvf]
    · simp [hf]
  · simp

theorem evenIncidenceSubset_treeComplement_injective {E V : Type*}
    [Fintype E] [DecidableEq E]
    (incident : V → E → Prop) [DecidableRel incident]
    (allEdges treeEdges A B : Finset E)
    (hA : A ⊆ allEdges ∧ IsEvenIncidence incident A)
    (hB : B ⊆ allEdges ∧ IsEvenIncidence incident B)
    (hLeaf : ∀ D : Finset E, D ⊆ treeEdges → D.Nonempty →
      ∃ v : V, ∃ e : E, e ∈ D ∧ incident v e ∧
        ∀ f ∈ D, incident v f → f = e)
    (hsame : A ∩ (allEdges \ treeEdges) = B ∩ (allEdges \ treeEdges)) :
    A = B := by
  classical
  let D := A ∆ B
  -- 具体版と同じく、対称差の偶数性、木への包含、端点での矛盾の順に示す。
  have hD_even : IsEvenIncidence incident D :=
    evenIncidence_symmDiff incident A B hA.2 hB.2
  have hD_tree : D ⊆ treeEdges := by
    intro e he
    by_contra hnot
    have heAll : e ∈ allEdges := by
      rcases Finset.mem_union.mp (Finset.symmDiff_subset_union he) with ha | hb
      · exact hA.1 ha
      · exact hB.1 hb
    have hs : e ∈ A ↔ e ∈ B := by
      have h := congrArg (fun S : Finset E => e ∈ S) hsame
      simpa [heAll, hnot] using h
    rcases Finset.mem_symmDiff.mp he with ⟨ha, hnb⟩ | ⟨hb, hna⟩
    · exact hnb (hs.mp ha)
    · exact hna (hs.mpr hb)
  have hD_empty : D = ∅ := by
    by_contra hne
    obtain ⟨v, e, he, hve, hunique⟩ :=
      hLeaf D hD_tree (Finset.nonempty_iff_ne_empty.mpr hne)
    have hodd : incidenceParity incident D v = 1 :=
      incidenceParity_eq_one_of_unique incident D v e he hve hunique
    have heven := hD_even v
    have : (1 : ZMod 2) = 0 := hodd.symm.trans heven
    norm_num at this
  exact Finset.symmDiff_eq_empty.mp hD_empty

end Ising2DLambda.NecSuf.Tools
