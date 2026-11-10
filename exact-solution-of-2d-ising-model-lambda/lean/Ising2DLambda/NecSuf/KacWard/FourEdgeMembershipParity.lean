import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Four distinct candidates have even selected cardinality exactly when their
membership indicators sum to zero modulo two. -/
theorem fourEdgeMembershipParity {α : Type*} [DecidableEq α]
    (A : Finset α) (a b c d : α)
    (hab : a ≠ b) (hac : a ≠ c) (had : a ≠ d)
    (hbc : b ≠ c) (hbd : b ≠ d) (hcd : c ≠ d) :
    (((if a ∈ A then (1 : ZMod 2) else 0) +
      (if b ∈ A then 1 else 0) +
      (if c ∈ A then 1 else 0) +
      (if d ∈ A then 1 else 0)) = 0) ↔
      Even (({a, b, c, d} : Finset α).filter (fun e => e ∈ A)).card := by
  simp only [Finset.filter_insert, Finset.filter_singleton]
  by_cases ha : a ∈ A <;>
    by_cases hb : b ∈ A <;>
    by_cases hc : c ∈ A <;>
    by_cases hd : d ∈ A <;>
    simp [ha, hb, hc, hd, hab, hac, had, hbc, hbd, hcd,
      Nat.even_iff] <;> norm_num <;> decide

end Ising2DLambda.NecSuf.KacWard
