import Mathlib
import Ising2DLambda.NecSuf.KacWard.ContactPairCount

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

/-- A single vertex and injective passage targets force one step. The two parity
sums use only a binary edge classifier: one step contributes to exactly one sum.
Both assumptions are needed, since repeated visits or a second vertex permit
two steps with even sums. -/
theorem single_cell_vertex_simple_seam {m : ℕ} {E V : Type*}
    [Fintype V] (hV : Fintype.card V = 1)
    (γ : Fin (m + 1) → E) (target : E → V) (horizontal : E → Bool)
    (hinj : Function.Injective (target ∘ γ))
    (hh : (∑ k : Fin (m + 1), if horizontal (γ k) then 1 else 0) % 2 = 0)
    (hv : (∑ k : Fin (m + 1), if horizontal (γ k) then 0 else 1) % 2 = 0) :
    False := by
  have hcard : Fintype.card (Fin (m + 1)) ≤ Fintype.card V :=
    Fintype.card_le_of_injective _ hinj
  rw [Fintype.card_fin, hV] at hcard
  have hm : m = 0 := by omega
  subst m
  have hsingle : (Finset.univ : Finset (Fin (0 + 1))) = {0} := by decide
  rw [hsingle, Finset.sum_singleton] at hh hv
  cases hdir : horizontal (γ 0) <;> simp [hdir] at hh hv

end Ising2DLambda.NecSuf.KacWard
