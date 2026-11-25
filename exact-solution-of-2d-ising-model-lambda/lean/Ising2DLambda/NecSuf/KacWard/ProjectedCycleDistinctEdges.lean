import Ising2DLambda.NecSuf.AlgebraicEigenvalue.FiniteInjectiveMinimalPeriod
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.IterateNoShortReturn
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEvenOrbit

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J E : Type*} [Fintype J]

/-- A two-point fibre consisting of an edge and its second-colour mate meets
    the first colour of an alternating cycle at most once per period. -/
theorem projectedCycle_edges_injective (σ : Equiv.Perm J) (υ : J → J)
    (C : J → Prop)
    (hflip : ∀ j, C (σ j) ↔ ¬ C j)
    (hυcolor : ∀ j, C (υ j) ↔ ¬ C j)
    (p : J → E) (hfibre : ∀ j l, p j = p l → j = l ∨ j = υ l)
    (i : J) (hi : C i) :
    let n := finiteInjectiveMinimalPeriod σ σ.injective i
    let k := n / 2
    ∀ r s : ℕ, r < k → s < k →
      p (σ^[2 * r] i) = p (σ^[2 * s] i) → r = s := by
  dsimp
  let n := finiteInjectiveMinimalPeriod σ σ.injective i
  let k := n / 2
  have hneven : Even n :=
    even_of_color_flip σ C hflip n i
      (finiteInjectiveMinimalPeriod_spec σ σ.injective i).2.1
  have hnk : n = 2 * k := by
    obtain ⟨a, ha⟩ := hneven
    dsimp [k]
    omega
  have heven (r : ℕ) : C (σ^[2 * r] i) := by
    induction r with
    | zero => simpa using hi
    | succ r ih =>
      have hodd : ¬ C (σ (σ^[2 * r] i)) := by
        intro h
        exact (hflip _).mp h ih
      have hnext : C (σ (σ (σ^[2 * r] i))) := (hflip _).mpr hodd
      have hindex : 2 * (r + 1) = 2 + 2 * r := by omega
      rw [hindex, iterate_add_necSuf]
      exact hnext
  intro r s hr hs hprojection
  have hpair := hfibre _ _ hprojection
  have heq : σ^[2 * r] i = σ^[2 * s] i := by
    rcases hpair with h | h
    · exact h
    · exfalso
      have hnot : ¬ C (υ (σ^[2 * s] i)) := by
        intro hc
        exact (hυcolor _).mp hc (heven s)
      exact hnot (h ▸ heven r)
  have hrn : 2 * r < n := by omega
  have hsn : 2 * s < n := by omega
  have hinj := iterate_injOn_of_no_short_return_necSuf σ σ.injective i n
    (finiteInjectiveMinimalPeriod_spec σ σ.injective i).2.2
  have hindex : 2 * r = 2 * s := hinj hrn hsn heq
  omega

end Ising2DLambda.NecSuf.KacWard
