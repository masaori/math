import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Double count incidence when every object has four incident markers. -/
theorem finiteIncidence_sum_four {Object Marker : Type*}
    [DecidableEq Object] [DecidableEq Marker]
    (objects : Finset Object) (markers : Object → Finset Marker)
    (hfour : ∀ x ∈ objects, (markers x).card = 4) :
    (∑ v ∈ objects.biUnion markers,
      (objects.filter (fun x => v ∈ markers x)).card) = 4 * objects.card := by
  classical
  calc
    (∑ v ∈ objects.biUnion markers,
      (objects.filter (fun x => v ∈ markers x)).card) =
        ∑ v ∈ objects.biUnion markers,
          ∑ x ∈ objects, if v ∈ markers x then 1 else 0 := by
          simp only [Finset.card_filter]
    _ = ∑ x ∈ objects,
          ∑ v ∈ objects.biUnion markers, if v ∈ markers x then 1 else 0 := by
          rw [Finset.sum_comm]
    _ = ∑ x ∈ objects, (markers x).card := by
          apply Finset.sum_congr rfl
          intro x hx
          rw [← Finset.sum_subset (show markers x ⊆ objects.biUnion markers by
            intro v hv
            exact Finset.mem_biUnion.mpr ⟨x, hx, hv⟩)]
          · simp
          · intro v hv hvx
            simp [hvx]
    _ = 4 * objects.card := by
          calc
            (∑ x ∈ objects, (markers x).card) = ∑ _x ∈ objects, 4 := by
              apply Finset.sum_congr rfl
              intro x hx
              exact hfour x hx
            _ = 4 * objects.card := by simp [mul_comm]

/-- Partition a finite weighted sum when every weight is one of four values. -/
theorem finiteWeightedSum_fourClasses {V : Type*} [DecidableEq V]
    (vertices : Finset V) (weight : V → ℕ)
    (hclass : ∀ v ∈ vertices,
      weight v = 1 ∨ weight v = 2 ∨ weight v = 3 ∨ weight v = 4) :
    (∑ v ∈ vertices, weight v) =
      (vertices.filter (fun v => weight v = 1)).card +
      2 * (vertices.filter (fun v => weight v = 2)).card +
      3 * (vertices.filter (fun v => weight v = 3)).card +
      4 * (vertices.filter (fun v => weight v = 4)).card := by
  classical
  have hpoint (v : V) (hv : v ∈ vertices) :
      weight v = (if weight v = 1 then 1 else 0) +
        (if weight v = 2 then 2 else 0) +
        (if weight v = 3 then 3 else 0) +
        (if weight v = 4 then 4 else 0) := by
    rcases hclass v hv with h | h | h | h <;> simp [h]
  calc
    (∑ v ∈ vertices, weight v) = ∑ v ∈ vertices,
        ((if weight v = 1 then 1 else 0) +
          (if weight v = 2 then 2 else 0) +
          (if weight v = 3 then 3 else 0) +
          (if weight v = 4 then 4 else 0)) := by
          apply Finset.sum_congr rfl
          exact hpoint
    _ = (vertices.filter (fun v => weight v = 1)).card +
        2 * (vertices.filter (fun v => weight v = 2)).card +
        3 * (vertices.filter (fun v => weight v = 3)).card +
        4 * (vertices.filter (fun v => weight v = 4)).card := by
          simp [Finset.sum_add_distrib, Finset.sum_ite, mul_comm]

end Ising2DLambda.NecSuf.KacWard
