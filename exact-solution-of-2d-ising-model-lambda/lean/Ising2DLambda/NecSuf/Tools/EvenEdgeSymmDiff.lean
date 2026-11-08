import Mathlib.Data.Finset.SymmDiff
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.Tools

open scoped symmDiff

def incidenceParity {E V : Type*} [Fintype E] [DecidableEq E]
    (incident : V → E → Prop) [DecidableRel incident]
    (A : Finset E) (v : V) : ZMod 2 :=
  ∑ e : E, if e ∈ A ∧ incident v e then 1 else 0

def IsEvenIncidence {E V : Type*} [Fintype E] [DecidableEq E]
    (incident : V → E → Prop) [DecidableRel incident] (A : Finset E) : Prop :=
  ∀ v : V, incidenceParity incident A v = 0

theorem incidenceParity_symmDiff {E V : Type*} [Fintype E] [DecidableEq E]
    (incident : V → E → Prop) [DecidableRel incident]
    (A B : Finset E) (v : V) :
    incidenceParity incident (A ∆ B) v =
      incidenceParity incident A v + incidenceParity incident B v := by
  unfold incidenceParity
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro e _
  by_cases ha : e ∈ A <;> by_cases hb : e ∈ B <;> by_cases hv : incident v e <;>
    simp [Finset.mem_symmDiff, ha, hb, hv] <;> decide

theorem evenIncidence_symmDiff {E V : Type*} [Fintype E] [DecidableEq E]
    (incident : V → E → Prop) [DecidableRel incident]
    (A B : Finset E) (hA : IsEvenIncidence incident A)
    (hB : IsEvenIncidence incident B) :
    IsEvenIncidence incident (A ∆ B) := by
  intro v
  rw [incidenceParity_symmDiff, hA v, hB v, add_zero]

theorem evenIncidenceSubset_symmDiff {E V : Type*} [Fintype E] [DecidableEq E]
    (incident : V → E → Prop) [DecidableRel incident] (allEdges A B : Finset E)
    (hA : A ⊆ allEdges ∧ IsEvenIncidence incident A)
    (hB : B ⊆ allEdges ∧ IsEvenIncidence incident B) :
    A ∆ B ⊆ allEdges ∧ IsEvenIncidence incident (A ∆ B) := by
  constructor
  · exact (Finset.symmDiff_subset_union).trans (Finset.union_subset hA.1 hB.1)
  · exact evenIncidence_symmDiff incident A B hA.2 hB.2

end Ising2DLambda.NecSuf.Tools
