import Mathlib.Data.Fin.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- A cyclic successor on a nonempty finite index set. -/
def cyclicSuccessor {m : ℕ} (k : Fin (m + 1)) : Fin (m + 1) :=
  if h : k.val < m then ⟨k.val + 1, Nat.succ_lt_succ h⟩ else 0

/-- The two consecutive entries of a cyclic sequence at one index. -/
def cyclicPass {E : Type*} {m : ℕ} (γ : Fin (m + 1) → E)
    (k : Fin (m + 1)) : E × E :=
  (γ k, γ (cyclicSuccessor k))

/-- The vertex assigned to a cyclic pass by the target map. -/
def cyclicPassVertex {E V : Type*} {m : ℕ} (γ : Fin (m + 1) → E)
    (target : E → V) (k : Fin (m + 1)) : V :=
  target (γ k)

end Ising2DLambda.NecSuf.KacWard
