import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Data.Finset.SymmDiff
import Mathlib.Tactic

namespace Ising2DLambda.Tools

open scoped symmDiff

/-- Parity at a vertex of a selected set of unoriented edges. -/
def edgeParity (n : ℕ) (A : Finset (Sym2 (Fin n))) (v : Fin n) : ZMod 2 :=
  ∑ e : Sym2 (Fin n), if e ∈ A ∧ v ∈ e then 1 else 0

def IsEvenEdgeSet (n : ℕ) (A : Finset (Sym2 (Fin n))) : Prop :=
  ∀ v : Fin n, edgeParity n A v = 0

def IsEvenEdgeSubsetOf (n : ℕ) (G : SimpleGraph (Fin n))
    [DecidableRel G.Adj] (A : Finset (Sym2 (Fin n))) : Prop :=
  A ⊆ G.edgeFinset ∧ IsEvenEdgeSet n A

theorem edgeParity_symmDiff (n : ℕ) (A B : Finset (Sym2 (Fin n))) (v : Fin n) :
    edgeParity n (A ∆ B) v = edgeParity n A v + edgeParity n B v := by
  unfold edgeParity
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro e _
  by_cases ha : e ∈ A <;> by_cases hb : e ∈ B <;> by_cases hv : v ∈ e <;>
    simp [Finset.mem_symmDiff, ha, hb, hv] <;> decide

theorem evenEdgeSet_symmDiff (n : ℕ) (A B : Finset (Sym2 (Fin n)))
    (hA : IsEvenEdgeSet n A) (hB : IsEvenEdgeSet n B) :
    IsEvenEdgeSet n (A ∆ B) := by
  intro v
  rw [edgeParity_symmDiff, hA v, hB v, add_zero]

theorem evenEdgeSubset_symmDiff (n : ℕ) (G : SimpleGraph (Fin n))
    [DecidableRel G.Adj] (A B : Finset (Sym2 (Fin n)))
    (hA : IsEvenEdgeSubsetOf n G A) (hB : IsEvenEdgeSubsetOf n G B) :
    IsEvenEdgeSubsetOf n G (A ∆ B) := by
  constructor
  · exact (Finset.symmDiff_subset_union).trans (Finset.union_subset hA.1 hB.1)
  · exact evenEdgeSet_symmDiff n A B hA.2 hB.2

end Ising2DLambda.Tools
