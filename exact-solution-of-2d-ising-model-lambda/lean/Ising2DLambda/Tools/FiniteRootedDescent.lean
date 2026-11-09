import Mathlib.Combinatorics.SimpleGraph.Finite

namespace Ising2DLambda.Tools

/-- A finite sequence of admissible non-root removals reaches the singleton root. -/
theorem finiteRootedDescent (n : ℕ) (root : Fin n)
    (P : Finset (Fin n) → Finset (Sym2 (Fin n)) → Prop)
    (hroot : ∀ U A, P U A → root ∈ U)
    (hstep : ∀ U A, P U A → U ≠ {root} →
      ∃ v B, v ∈ U ∧ v ≠ root ∧ P (U.erase v) B)
    (U : Finset (Fin n)) (A : Finset (Sym2 (Fin n))) (hP : P U A) :
    ∃ B, P {root} B := by
  classical
  suffices descend : ∀ k : ℕ, ∀ U A, U.card = k → P U A → ∃ B, P {root} B from
    descend U.card U A rfl hP
  intro k
  induction k using Nat.strong_induction_on with
  | h k ih =>
    intro U A hk hUA
    -- The singleton root is the terminal state of the human proof.
    by_cases hsingle : U = {root}
    · exact ⟨A, by simpa [hsingle] using hUA⟩
    · obtain ⟨v, B, hv, _, hnext⟩ := hstep U A hUA hsingle
      -- Removing a member decreases the number of unprocessed vertices by one.
      have hsmaller : (U.erase v).card < k := by
        rw [Finset.card_erase_of_mem hv, hk]
        exact Nat.sub_one_lt (by
          have := Finset.card_pos.mpr ⟨root, hroot U A hUA⟩
          omega)
      -- Apply strong induction to the state after the leaf has been processed.
      exact ih _ hsmaller (U.erase v) B rfl hnext

end Ising2DLambda.Tools
