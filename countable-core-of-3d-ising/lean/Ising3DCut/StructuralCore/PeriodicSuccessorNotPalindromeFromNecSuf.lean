/- 具体版が必要十分版の特殊化として得られることを明示する。 -/
import Ising3DCut.StructuralCore.PeriodicSuccessorNotPalindrome
import Ising3DCut.NecSuf.StructuralCore.PeriodicSuccessorNotPalindrome

namespace Ising3DCut.StructuralCore

open Ising3DCut.NullModel

noncomputable section

variable {V I : Type} [Fintype V] [Fintype I] [DecidableEq V] [DecidableEq I]
variable [Nonempty V] [Nonempty I] {L : ℕ}

/-- 人手証明の具体版を、証明で使うデータだけの必要十分版から導く。 -/
theorem periodicStructuralMultiplicity_not_palindrome_from_necSuf
    (S : PeriodicSuccessorSystem V I L) (hodd : Odd L) :
    periodicStructuralMultiplicity S 0 ≠
      periodicStructuralMultiplicity S
        (Fintype.card (PeriodicStructuralEdge (V := V) (I := I)) - 0) := by
  let σzero : PeriodicStructuralConfig (V := V) := fun _ => ⟨1, Or.inl rfl⟩
  have hzero : periodicStructuralBrokenCount S σzero = 0 := by
    simp [periodicStructuralBrokenCount, periodicStructuralBrokenSet, σzero]
  let value : PeriodicStructuralConfig (V := V) → Fin L → ℤ :=
    fun σ k => (σ (S.orbit (Classical.choice inferInstance) (Classical.choice inferInstance) k)).1
  have hvalue : ∀ σ k, value σ k = 1 ∨ value σ k = -1 := by
    intro σ k
    exact (σ _).2
  have hfull_opposite : ∀ σ,
      periodicStructuralBrokenCount S σ =
        Fintype.card (PeriodicStructuralEdge (V := V) (I := I)) →
      ∀ k, value σ k ≠ value σ (finRotate L k) := by
    intro σ hfull k hEq
    have hset : periodicStructuralBrokenSet S σ = Finset.univ := by
      apply (Finset.card_eq_iff_eq_univ (periodicStructuralBrokenSet S σ)).mp
      simpa [periodicStructuralBrokenCount] using hfull
    have hedge :
        (S.orbit (Classical.choice inferInstance) (Classical.choice inferInstance) k,
          Classical.choice inferInstance) ∈ periodicStructuralBrokenSet S σ := by
      rw [hset]
      exact Finset.mem_univ _
    have hbroken := (Finset.mem_filter.mp hedge).2
    apply hbroken
    rw [← S.orbit_succ (Classical.choice inferInstance) (Classical.choice inferInstance) k]
    exact Subtype.ext hEq
  simpa [Ising3DCut.NecSuf.StructuralCore.periodicMultiplicity,
    periodicStructuralMultiplicity] using
    (Ising3DCut.NecSuf.StructuralCore.periodicMultiplicity_not_palindrome
      (Edge := PeriodicStructuralEdge (V := V) (I := I))
      (periodicStructuralBrokenCount S) hodd σzero hzero value hvalue hfull_opposite)

end

end Ising3DCut.StructuralCore
