/-
章「Kac--Ward 行列式の置換展開」の
「動く辺の軌道族は動く辺集合を互いに素に分割する」の具体版。
人手証明と同じ順で、非空性・互いに素・合併の等式を示す。
-/
import Ising2DLambda.KacWard.MovedOrbitClosedWalk

namespace Ising2DLambda.KacWard

open Finset

variable {E : Type} [Fintype E]

omit [Fintype E] in
private lemma permutation_moved_iterate (σ : Equiv.Perm E) {e : E}
    (he : σ e ≠ e) : ∀ k, σ (σ^[k] e) ≠ σ^[k] e := by
  intro k
  induction k with
  | zero => simpa using he
  | succ k ih =>
    intro h
    rw [Function.iterate_succ_apply'] at h
    exact ih (σ.injective h)

variable [DecidableEq E]

/-- 動く辺の集合。 -/
def movedEdgeSet (σ : Equiv.Perm E) : Finset E :=
  univ.filter fun e => σ e ≠ e

lemma mem_movedEdgeSet {σ : Equiv.Perm E} {e : E} : e ∈ movedEdgeSet σ ↔ σ e ≠ e := by
  simp [movedEdgeSet]

/-- 置換の軌道集合。 -/
noncomputable def movedOrbit (σ : Equiv.Perm E) (e : E) : Finset E :=
  open Classical in univ.filter fun x => ∃ k : ℕ, x = (⇑σ)^[k] e

omit [DecidableEq E] in
lemma mem_movedOrbit {σ : Equiv.Perm E} {e x : E} :
    x ∈ movedOrbit σ e ↔ ∃ k : ℕ, x = (⇑σ)^[k] e := by
  classical
  simp [movedOrbit]

lemma self_mem_movedOrbit (σ : Equiv.Perm E) (e : E) : e ∈ movedOrbit σ e :=
  mem_movedOrbit.mpr ⟨0, rfl⟩

private lemma movedOrbit_subset_of_mem (σ : Equiv.Perm E) {e x : E}
    (hx : x ∈ movedOrbit σ e) : movedOrbit σ x ⊆ movedOrbit σ e := by
  obtain ⟨n, hn⟩ := mem_movedOrbit.mp hx
  intro y hy
  obtain ⟨k, hk⟩ := mem_movedOrbit.mp hy
  refine mem_movedOrbit.mpr ⟨k + n, ?_⟩
  calc
    y = (⇑σ)^[k] x := hk
    _ = (⇑σ)^[k] ((⇑σ)^[n] e) := by rw [hn]
    _ = (⇑σ)^[k + n] e := (Function.iterate_add_apply (⇑σ) k n e).symm

private lemma movedOrbit_eq_of_mem (σ : Equiv.Perm E) (e : E) {x : E}
    (hx : x ∈ movedOrbit σ e) : movedOrbit σ x = movedOrbit σ e := by
  obtain ⟨m, hm⟩ := mem_movedOrbit.mp hx
  let d := minimalReturnTime σ e
  have hd : 1 ≤ d := minimalReturnTime_pos σ e
  have hdm : (d - 1) * m + m = d * m := by
    calc
      (d - 1) * m + m = ((d - 1) + 1) * m := by rw [Nat.add_mul]; simp
      _ = d * m := by rw [Nat.sub_add_cancel hd]
  have hex : e ∈ movedOrbit σ x := by
    refine mem_movedOrbit.mpr ⟨(d - 1) * m, ?_⟩
    calc
      e = (⇑σ)^[d * m] e := by
        rw [Function.iterate_mul]
        exact (Function.iterate_fixed (minimalReturnTime_return σ e) m).symm
      _ = (⇑σ)^[(d - 1) * m + m] e := by rw [hdm]
      _ = (⇑σ)^[(d - 1) * m] ((⇑σ)^[m] e) :=
        Function.iterate_add_apply (⇑σ) _ _ e
      _ = (⇑σ)^[(d - 1) * m] x := by rw [← hm]
  exact Finset.Subset.antisymm (movedOrbit_subset_of_mem σ hx)
    (movedOrbit_subset_of_mem σ hex)

private lemma movedOrbit_eq_of_inter_nonempty (σ : Equiv.Perm E) (e₁ e₂ : E)
    (hne : (movedOrbit σ e₁ ∩ movedOrbit σ e₂).Nonempty) :
    movedOrbit σ e₁ = movedOrbit σ e₂ := by
  obtain ⟨x, hx⟩ := hne
  rw [mem_inter] at hx
  calc
    movedOrbit σ e₁ = movedOrbit σ x := (movedOrbit_eq_of_mem σ e₁ hx.1).symm
    _ = movedOrbit σ e₂ := movedOrbit_eq_of_mem σ e₂ hx.2

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
    exact ⟨e, self_mem_movedOrbit σ e⟩
  · intro O₁ hO₁ O₂ hO₂ hne
    obtain ⟨e₁, he₁, rfl⟩ := mem_movedEdgeOrbitSet.mp hO₁
    obtain ⟨e₂, he₂, rfl⟩ := mem_movedEdgeOrbitSet.mp hO₂
    rw [Finset.disjoint_left]
    intro a ha₁ ha₂
    apply hne
    exact movedOrbit_eq_of_inter_nonempty σ e₁ e₂
      ⟨a, mem_inter.mpr ⟨ha₁, ha₂⟩⟩
  · ext a
    constructor
    · intro ha
      obtain ⟨O, hO, haO⟩ := mem_biUnion.mp ha
      obtain ⟨e, he, rfl⟩ := mem_movedEdgeOrbitSet.mp hO
      obtain ⟨k, hk⟩ := mem_movedOrbit.mp haO
      rw [hk, mem_movedEdgeSet]
      exact permutation_moved_iterate σ (mem_movedEdgeSet.mp he) k
    · intro ha
      exact mem_biUnion.mpr
        ⟨movedOrbit σ a, mem_movedEdgeOrbitSet.mpr ⟨a, ha, rfl⟩,
          self_mem_movedOrbit σ a⟩

end Ising2DLambda.KacWard
