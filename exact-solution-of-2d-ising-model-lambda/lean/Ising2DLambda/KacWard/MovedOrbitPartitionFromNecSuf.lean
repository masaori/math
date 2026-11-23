import Ising2DLambda.KacWard.MovedOrbitPartition
import Ising2DLambda.NecSuf.KacWard.MovedOrbitPartition

namespace Ising2DLambda.KacWard

variable {E : Type} [Fintype E] [DecidableEq E]

omit [Fintype E] [DecidableEq E] in
private lemma iterate_eq_iterLeft (σ : Equiv.Perm E) (n : ℕ) (e : E) :
    (⇑σ)^[n] e = Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft (⇑σ) n e := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft,
      Function.iterate_succ_apply']
    rw [ih]

private lemma movedOrbit_eq_necSuf (σ : Equiv.Perm E) (e : E) :
    movedOrbit σ e = Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbit (⇑σ) e := by
  classical
  ext x
  simp only [mem_movedOrbit, Ising2DLambda.NecSuf.AlgebraicEigenvalue.mem_orbit]
  constructor
  · rintro ⟨k, hk⟩
    exact ⟨k, hk.trans (iterate_eq_iterLeft σ k e)⟩
  · rintro ⟨k, hk⟩
    exact ⟨k, hk.trans (iterate_eq_iterLeft σ k e).symm⟩

/-- 導出版: 同じ分割を必要十分版から得る。 -/
theorem movedEdgeOrbitSet_partition_from_necSuf (σ : Equiv.Perm E) :
    (∀ O ∈ movedEdgeOrbitSet σ, O.Nonempty)
      ∧ (∀ O₁ ∈ movedEdgeOrbitSet σ, ∀ O₂ ∈ movedEdgeOrbitSet σ,
          O₁ ≠ O₂ → Disjoint O₁ O₂)
      ∧ (movedEdgeOrbitSet σ).biUnion id = movedEdgeSet σ := by
  have hreturn : ∀ e : E, ∃ k, 1 ≤ k ∧
      Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft (⇑σ) k e = e := by
    intro e
    obtain ⟨k, hk, hret⟩ := permutation_power_return σ e
    exact ⟨k, hk, (iterate_eq_iterLeft σ k e).symm.trans hret⟩
  have h := Ising2DLambda.NecSuf.KacWard.movedOrbitSet_partition
    (⇑σ) σ.injective hreturn
  have horbit : movedEdgeOrbitSet σ =
      Ising2DLambda.NecSuf.KacWard.movedOrbitSet (⇑σ) := by
    classical
    unfold movedEdgeOrbitSet Ising2DLambda.NecSuf.KacWard.movedOrbitSet
    rw [show movedEdgeSet σ = Ising2DLambda.NecSuf.KacWard.movedSet (⇑σ) from rfl]
    exact Finset.image_congr (fun e _ => movedOrbit_eq_necSuf σ e)
  have hmoved : movedEdgeSet σ = Ising2DLambda.NecSuf.KacWard.movedSet (⇑σ) := rfl
  rw [horbit, hmoved]
  exact h

end Ising2DLambda.KacWard
