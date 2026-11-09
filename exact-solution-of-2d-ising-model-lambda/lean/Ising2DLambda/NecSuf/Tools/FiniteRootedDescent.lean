import Mathlib.Data.Finset.Card

namespace Ising2DLambda.NecSuf.Tools

/-- Finite descent needs only a decreasing finite set and a successor for every nonterminal state. -/
theorem finiteRootedDescent {V E : Type*} [DecidableEq V] (root : V)
    (P : Finset V → Finset E → Prop)
    (hstep : ∀ U A, P U A → U ≠ {root} →
      ∃ v B, v ∈ U ∧ P (U.erase v) B)
    (U : Finset V) (A : Finset E) (hP : P U A) :
    ∃ B, P {root} B := by
  classical
  suffices descend : ∀ k : ℕ, ∀ U A, U.card = k → P U A → ∃ B, P {root} B from
    descend U.card U A rfl hP
  intro k
  induction k using Nat.strong_induction_on with
  | h k ih =>
    intro U A hk hUA
    -- The terminal state is the singleton root.
    by_cases hsingle : U = {root}
    · exact ⟨A, by simpa [hsingle] using hUA⟩
    · obtain ⟨v, B, hv, hnext⟩ := hstep U A hUA hsingle
      -- The proof only uses finiteness and the strict decrease of cardinality.
      have hsmaller : (U.erase v).card < k := by
        rw [Finset.card_erase_of_mem hv, hk]
        have hpos : 0 < k := by
          rw [← hk]
          exact Finset.card_pos.mpr ⟨v, hv⟩
        omega
      exact ih _ hsmaller (U.erase v) B rfl hnext

end Ising2DLambda.NecSuf.Tools
