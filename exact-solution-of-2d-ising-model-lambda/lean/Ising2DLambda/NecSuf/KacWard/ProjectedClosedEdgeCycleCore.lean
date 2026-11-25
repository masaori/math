import Ising2DLambda.NecSuf.AlgebraicEigenvalue.FiniteInjectiveMinimalPeriod
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEvenOrbit

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 色を反転する有限置換の偶数周期では、第二色の点の次は第二の相手写像で得られる。 -/
theorem projectedClosedEdgeCycleCore {J : Type*} [Fintype J]
    (σ : Equiv.Perm J) (υ : J → J) (C : J → Prop)
    (hflip : ∀ j, C (σ j) ↔ ¬ C j)
    (hsecond : ∀ j, ¬ C j → σ j = υ j)
    (i : J) (hi : C i) :
    ∃ k : ℕ, 0 < k ∧ σ^[2 * k] i = i ∧
      ∀ r : ℕ, r < k →
        υ (σ^[2 * r + 1] i) = σ^[2 * (r + 1)] i := by
  classical
  let n := finiteInjectiveMinimalPeriod σ σ.injective i
  have hnpos : 0 < n := (finiteInjectiveMinimalPeriod_spec σ σ.injective i).1
  have hnreturn : σ^[n] i = i :=
    (finiteInjectiveMinimalPeriod_spec σ σ.injective i).2.1
  have hneven : Even n := even_of_color_flip σ C hflip n i hnreturn
  obtain ⟨k, hk⟩ := hneven
  have hkpos : 0 < k := by omega
  refine ⟨k, hkpos, ?_, ?_⟩
  · calc
      σ^[2 * k] i = σ^[n] i := by congr 1; omega
      _ = i := hnreturn
  · have heven (r : ℕ) : C (σ^[2 * r] i) := by
      induction r with
      | zero => simpa using hi
      | succ r ihr =>
        have hodd : ¬ C (σ (σ^[2 * r] i)) := by
          intro h
          exact (hflip _).mp h ihr
        have hnext : C (σ (σ (σ^[2 * r] i))) :=
          (hflip _).mpr hodd
        have hindex : 2 * (r + 1) = 2 + 2 * r := by omega
        rw [hindex, iterate_add_necSuf]
        exact hnext
    intro r _
    have hodd : ¬ C (σ^[2 * r + 1] i) := by
      have hstep : σ^[2 * r + 1] i = σ (σ^[2 * r] i) := by
        rw [show 2 * r + 1 = 1 + 2 * r by omega, iterate_add_necSuf]
        rfl
      rw [hstep]
      intro h
      exact (hflip _).mp h (heven r)
    calc
      υ (σ^[2 * r + 1] i) = σ (σ^[2 * r + 1] i) :=
        (hsecond _ hodd).symm
      _ = σ^[1 + (2 * r + 1)] i :=
        (iterate_add_necSuf σ 1 (2 * r + 1) i).symm
      _ = σ^[2 * (r + 1)] i := by congr 1; omega

end Ising2DLambda.NecSuf.KacWard
