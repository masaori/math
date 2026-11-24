import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairReconstructedOrbit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.FiniteInjectiveMinimalPeriod
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PeriodicTwoWayOrbit
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEvenOrbit

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.NecSuf.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J]

/-- 相手写像が色を反転するなら、後続置換の最小周期は偶数であり、
    周期未満の反復は交互成分をちょうど一度ずつ列挙する。
    後続置換自身も色を反転し、色に応じた相手写像を選ぶ。 -/
theorem alternatingCycleEnumeration_necSuf (τ υ : J → J) (C : J → Prop)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ j, C (τ j) ↔ ¬ C j)
    (hυcolor : ∀ j, C (υ j) ↔ ¬ C j) (i : J) :
    let σ := matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor
    let p := finiteInjectiveMinimalPeriod σ σ.injective i
    Even p ∧
      Function.Bijective (twoWayOrbitEnumeration σ σ.symm i p) ∧
      twoWayOrbit σ σ.symm i = matchingPairComponent τ υ hτ hυ i ∧
      σ^[p] i = i ∧
      (∀ j, C (σ j) ↔ ¬ C j) ∧
      (∀ j, σ j = if C j then τ j else υ j) := by
  classical
  dsimp
  let σ := matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor
  let p := finiteInjectiveMinimalPeriod σ σ.injective i
  have hp := finiteInjectiveMinimalPeriod_spec σ σ.injective i
  have hflip (j : J) : C (σ j) ↔ ¬ C j :=
    matchingPairSuccessor_color_necSuf τ υ C hτcolor hυcolor j
  constructor
  · exact even_of_color_flip σ C hflip p i hp.2.1
  constructor
  · exact twoWayOrbitEnumeration_bijective_necSuf σ σ.symm
      σ.symm_apply_apply i p hp.1 hp.2.1 hp.2.2
  constructor
  · exact matchingPairPermutation_orbit_eq_component τ υ C hτ hυ hτcolor hυcolor i
  constructor
  · exact hp.2.1
  constructor
  · exact hflip
  · intro j
    change matchingPairSuccessor τ υ C j = _
    rfl

/-- 最小正周期の長さは、二色の相手写像でできる成分の点数である。 -/
theorem alternatingCycle_period_eq_component_ncard_necSuf
    (τ υ : J → J) (C : J → Prop)
    (hτ : Function.Involutive τ) (hυ : Function.Involutive υ)
    (hτcolor : ∀ j, C (τ j) ↔ ¬ C j)
    (hυcolor : ∀ j, C (υ j) ↔ ¬ C j) (i : J) :
    let σ := matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor
    finiteInjectiveMinimalPeriod σ σ.injective i =
      (matchingPairComponent τ υ hτ hυ i).ncard := by
  dsimp
  let σ := matchingPairPermutation τ υ C hτ hυ hτcolor hυcolor
  let p := finiteInjectiveMinimalPeriod σ σ.injective i
  have hp := finiteInjectiveMinimalPeriod_spec σ σ.injective i
  calc
    p = (twoWayOrbit σ σ.symm i).ncard :=
      period_eq_twoWayOrbit_ncard_necSuf σ σ.symm σ.symm_apply_apply
        i p hp.1 hp.2.1 hp.2.2
    _ = (matchingPairComponent τ υ hτ hυ i).ncard := by
      change (permutationOrbit σ i).ncard = _
      rw [matchingPairPermutation_orbit_eq_component τ υ C hτ hυ hτcolor hυcolor i]

end Ising2DLambda.NecSuf.KacWard
