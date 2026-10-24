import Ising2DLambda.AlgebraicEigenvalue.PerfectMatching
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationOrbitBasepoint

namespace Ising2DLambda.AlgebraicEigenvalue
variable {J : Type*} [Fintype J]

/-- 第一の相手、第二の相手の順に二歩進む置換。 -/
def matchingPairStep (τ υ : FixedPointFreeInvolution J) : Equiv.Perm J where
  toFun i := υ.val (τ.val i)
  invFun i := τ.val (υ.val i)
  left_inv i := by
    change τ.val (υ.val (υ.val (τ.val i))) = i
    rw [υ.property.2, τ.property.2]
  right_inv i := by
    change υ.val (τ.val (τ.val (υ.val i))) = i
    rw [τ.property.2, υ.property.2]

/-- 相手へ到達する仮定から反復回数を二つ減らす、本文の強帰納法。 -/
theorem matchingPairStep_iterate_ne_mate (τ υ : FixedPointFreeInvolution J)
    (n : ℕ) (i : J) :
    finiteMapIterate (matchingPairStep τ υ) n i ≠ τ.val i := by
  induction n using Nat.strong_induction_on generalizing i with
  | h n ih =>
    cases n with
    | zero =>
      exact (τ.property.1 i).symm
    | succ n =>
      cases n with
      | zero =>
        intro heq
        exact υ.property.1 (τ.val i) heq
      | succ k =>
        intro heq
        let p := matchingPairStep τ υ
        have hstep : finiteMapIterate p (k + 2) i =
            p (finiteMapIterate p (k + 1) i) :=
          (finiteMapIterate_commute p (k + 1) i).symm
        have hreduce : finiteMapIterate p k (p i) = τ.val (p i) := by
          calc
            finiteMapIterate p k (p i) = finiteMapIterate p (k + 1) i := rfl
            _ = τ.val (τ.val (finiteMapIterate p (k + 1) i)) :=
              (τ.property.2 _).symm
            _ = τ.val (υ.val (υ.val (τ.val (finiteMapIterate p (k + 1) i)))) :=
              congrArg τ.val (υ.property.2 _).symm
            _ = τ.val (υ.val (p (finiteMapIterate p (k + 1) i))) := rfl
            _ = τ.val (υ.val (finiteMapIterate p (k + 2) i)) :=
              congrArg (fun x => τ.val (υ.val x)) hstep.symm
            _ = τ.val (υ.val (τ.val i)) :=
              congrArg (fun x => τ.val (υ.val x)) heq
            _ = τ.val (p i) := rfl
        exact ih k (by omega) (p i) hreduce

/-- 逆向きの正の反復は、第一の相手を消して対合を交換した順反復へ移す。 -/
theorem matchingPairStep_inverse_iterate_ne_mate (τ υ : FixedPointFreeInvolution J)
    (n : ℕ) (i : J) :
    finiteMapIterate (matchingPairStep τ υ).symm n i ≠ τ.val i := by
  cases n with
  | zero => exact (τ.property.1 i).symm
  | succ k =>
    intro heq
    let q := matchingPairStep υ τ
    have hstep : finiteMapIterate q (k + 1) i = q (finiteMapIterate q k i) :=
      (finiteMapIterate_commute q k i).symm
    have hreduce : finiteMapIterate q k i = υ.val i := by
      calc
        finiteMapIterate q k i = υ.val (υ.val (finiteMapIterate q k i)) :=
          (υ.property.2 _).symm
        _ = υ.val (τ.val (τ.val (υ.val (finiteMapIterate q k i)))) :=
          congrArg υ.val (τ.property.2 _).symm
        _ = υ.val (τ.val (q (finiteMapIterate q k i))) := rfl
        _ = υ.val (τ.val (finiteMapIterate q (k + 1) i)) :=
          congrArg (fun x => υ.val (τ.val x)) hstep.symm
        _ = υ.val (τ.val (τ.val i)) :=
          congrArg (fun x => υ.val (τ.val x)) heq
        _ = υ.val i := congrArg υ.val (τ.property.2 i)
    exact matchingPairStep_iterate_ne_mate υ τ k i hreduce

/-- 第一の相手は、順方向にも逆方向にも二歩置換の軌道に入らない。 -/
theorem matchingPairStep_mate_not_mem (τ υ : FixedPointFreeInvolution J) (i : J) :
    τ.val i ∉ finitePermutationOrbit (matchingPairStep τ υ) i := by
  rintro ⟨n, h | h⟩
  · exact matchingPairStep_iterate_ne_mate τ υ n i h
  · exact matchingPairStep_inverse_iterate_ne_mate τ υ n i h

/-- 共通点があれば始点変更で軌道が一致し、相手の非所属に反する。 -/
theorem matchingPairStep_orbits_disjoint (τ υ : FixedPointFreeInvolution J) (i : J) :
    Disjoint (finitePermutationOrbit (matchingPairStep τ υ) i)
      (finitePermutationOrbit (matchingPairStep τ υ) (τ.val i)) := by
  apply Set.disjoint_left.mpr
  intro j hi hmate
  have hleft := finitePermutationOrbit_basepoint (matchingPairStep τ υ) i j hi
  have hright := finitePermutationOrbit_basepoint (matchingPairStep τ υ) (τ.val i) j hmate
  have heq : finitePermutationOrbit (matchingPairStep τ υ) (τ.val i) =
      finitePermutationOrbit (matchingPairStep τ υ) i := hright.symm.trans hleft
  apply matchingPairStep_mate_not_mem τ υ i
  rw [← heq]
  exact finitePermutationOrbit_self_mem (matchingPairStep τ υ) (τ.val i)

end Ising2DLambda.AlgebraicEigenvalue
