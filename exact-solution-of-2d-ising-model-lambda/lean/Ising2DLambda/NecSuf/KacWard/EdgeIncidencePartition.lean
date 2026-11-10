import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite incidence sum with one contribution on the boundary and two on
its complement is the corresponding weighted edge count. -/
theorem edgeIncidence_sum_partition {E : Type*} [DecidableEq E]
    (edges boundary : Finset E) (incidence : E → ℕ)
    (hboundary : boundary ⊆ edges)
    (hboundaryIncidence : ∀ e ∈ boundary, incidence e = 1)
    (hinteriorIncidence : ∀ e ∈ edges \ boundary, incidence e = 2) :
    ∑ e ∈ edges, incidence e = boundary.card + 2 * (edges \ boundary).card := by
  calc
    ∑ e ∈ edges, incidence e =
        (∑ e ∈ boundary, incidence e) +
          (∑ e ∈ edges \ boundary, incidence e) := by
            rw [← Finset.sum_sdiff hboundary, add_comm]
    _ = boundary.card + 2 * (edges \ boundary).card := by
      have h₁ : (∑ e ∈ boundary, incidence e) = boundary.card := by
        calc
          _ = ∑ _e ∈ boundary, (1 : ℕ) := Finset.sum_congr rfl hboundaryIncidence
          _ = boundary.card := by simp
      have h₂ : (∑ e ∈ edges \ boundary, incidence e) =
          2 * (edges \ boundary).card := by
        calc
          _ = ∑ _e ∈ edges \ boundary, (2 : ℕ) :=
            Finset.sum_congr rfl hinteriorIncidence
          _ = 2 * (edges \ boundary).card := by simp [mul_comm]
      rw [h₁, h₂]

end Ising2DLambda.NecSuf.KacWard
