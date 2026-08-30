/-
章「トーラス上の Kac--Ward 行列式」の
「動く辺の軌道族は動く辺集合を互いに素に分割する」の具体版。
人手証明と同じ順で、非空性・互いに素・合併の等式を示す。
-/
import Ising2DLambda.KacWard.MovedOrbitClosedWalk
import Ising2DLambda.NecSuf.KacWard.MovedOrbitPartition

namespace Ising2DLambda.KacWard

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue

private lemma iterLeft_perm_eq {E : Type} (σ : Equiv.Perm E) (n : ℕ) (e : E) :
    iterLeft (⇑σ) n e = (⇑σ)^[n] e := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [iterLeft, Function.iterate_succ_apply']
    rw [ih]

variable {E : Type} [Fintype E]

private lemma permutation_iterLeft_return (σ : Equiv.Perm E) (e : E) :
    ∃ k, 1 ≤ k ∧ iterLeft (⇑σ) k e = e := by
  obtain ⟨k, hk, hreturn⟩ := permutation_power_return σ e
  exact ⟨k, hk, (iterLeft_perm_eq σ k e).trans hreturn⟩

variable [DecidableEq E]

/-- 動く辺の集合。 -/
def movedEdgeSet (σ : Equiv.Perm E) : Finset E :=
  univ.filter fun e => σ e ≠ e

lemma mem_movedEdgeSet {σ : Equiv.Perm E} {e : E} : e ∈ movedEdgeSet σ ↔ σ e ≠ e := by
  simp [movedEdgeSet]

/-- 置換の軌道集合。 -/
noncomputable def movedOrbit (σ : Equiv.Perm E) (e : E) : Finset E :=
  orbit σ e

/-- 同じ軌道を重複させない、動く辺の軌道族。 -/
noncomputable def movedEdgeOrbitSet (σ : Equiv.Perm E) : Finset (Finset E) :=
  open Classical in (movedEdgeSet σ).image (movedOrbit σ)

lemma mem_movedEdgeOrbitSet {σ : Equiv.Perm E} {O : Finset E} :
    O ∈ movedEdgeOrbitSet σ ↔ ∃ e ∈ movedEdgeSet σ, movedOrbit σ e = O := by
  classical
  simp [movedEdgeOrbitSet]

/-- 動く辺の軌道族は、動く辺集合を分割する。 -/
theorem movedEdgeOrbitSet_partition (σ : Equiv.Perm E) :
    (∀ O ∈ movedEdgeOrbitSet σ, O.Nonempty)
      ∧ (∀ O₁ ∈ movedEdgeOrbitSet σ, ∀ O₂ ∈ movedEdgeOrbitSet σ,
          O₁ ≠ O₂ → Disjoint O₁ O₂)
      ∧ (movedEdgeOrbitSet σ).biUnion id = movedEdgeSet σ := by
  classical
  refine ⟨?_, ?_, ?_⟩
  · intro O hO
    obtain ⟨e, he, rfl⟩ := mem_movedEdgeOrbitSet.mp hO
    exact ⟨e, self_mem_orbit σ e⟩
  · intro O₁ hO₁ O₂ hO₂ hne
    obtain ⟨e₁, he₁, rfl⟩ := mem_movedEdgeOrbitSet.mp hO₁
    obtain ⟨e₂, he₂, rfl⟩ := mem_movedEdgeOrbitSet.mp hO₂
    rw [Finset.disjoint_left]
    intro a ha₁ ha₂
    apply hne
    exact orbit_eq_of_inter_nonempty σ e₁ e₂
      (permutation_iterLeft_return σ e₁) (permutation_iterLeft_return σ e₂)
      ⟨a, mem_inter.mpr ⟨ha₁, ha₂⟩⟩
  · ext a
    constructor
    · intro ha
      obtain ⟨O, hO, haO⟩ := mem_biUnion.mp ha
      obtain ⟨e, he, rfl⟩ := mem_movedEdgeOrbitSet.mp hO
      obtain ⟨k, hk⟩ := mem_orbit.mp haO
      rw [hk, mem_movedEdgeSet]
      rw [iterLeft_perm_eq]
      exact Ising2DLambda.NecSuf.KacWard.moved_iterate_ne σ.injective
        (mem_movedEdgeSet.mp he) k
    · intro ha
      exact mem_biUnion.mpr
        ⟨movedOrbit σ a, mem_movedEdgeOrbitSet.mpr ⟨a, ha, rfl⟩, self_mem_orbit σ a⟩

/-- 導出版: 同じ分割を必要十分版から得る。 -/
theorem movedEdgeOrbitSet_partition_from_necSuf (σ : Equiv.Perm E) :
    (∀ O ∈ movedEdgeOrbitSet σ, O.Nonempty)
      ∧ (∀ O₁ ∈ movedEdgeOrbitSet σ, ∀ O₂ ∈ movedEdgeOrbitSet σ,
          O₁ ≠ O₂ → Disjoint O₁ O₂)
      ∧ (movedEdgeOrbitSet σ).biUnion id = movedEdgeSet σ := by
  unfold movedEdgeOrbitSet movedEdgeSet movedOrbit
  simpa [
    Ising2DLambda.NecSuf.KacWard.movedOrbitSet,
    Ising2DLambda.NecSuf.KacWard.movedSet] using
    Ising2DLambda.NecSuf.KacWard.movedOrbitSet_partition (⇑σ) σ.injective
      (permutation_iterLeft_return σ)

end Ising2DLambda.KacWard
