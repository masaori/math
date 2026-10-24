/- 有限性・順序・相等判定は不要。二つの不動点なし対合と自然数反復だけで、具体版と同じ強帰納法を行う。 -/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatching
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitBasepoint

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
variable {J : Type*}

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
    Nat.iterate (matchingPairStep τ υ) n i ≠ τ.val i := by
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
        have hstep : Nat.iterate p (k + 2) i =
            p (Nat.iterate p (k + 1) i) :=
          (iterate_commute_necSuf p (k + 1) i).symm
        have hreduce : Nat.iterate p k (p i) = τ.val (p i) := by
          calc
            Nat.iterate p k (p i) = Nat.iterate p (k + 1) i := rfl
            _ = τ.val (τ.val (Nat.iterate p (k + 1) i)) :=
              (τ.property.2 _).symm
            _ = τ.val (υ.val (υ.val (τ.val (Nat.iterate p (k + 1) i)))) :=
              congrArg τ.val (υ.property.2 _).symm
            _ = τ.val (υ.val (p (Nat.iterate p (k + 1) i))) := rfl
            _ = τ.val (υ.val (Nat.iterate p (k + 2) i)) :=
              congrArg (fun x => τ.val (υ.val x)) hstep.symm
            _ = τ.val (υ.val (τ.val i)) :=
              congrArg (fun x => τ.val (υ.val x)) heq
            _ = τ.val (p i) := rfl
        exact ih k (by omega) (p i) hreduce

/-- 逆向きの正の反復は、第一の相手を消して対合を交換した順反復へ移す。 -/
theorem matchingPairStep_inverse_iterate_ne_mate (τ υ : FixedPointFreeInvolution J)
    (n : ℕ) (i : J) :
    Nat.iterate (matchingPairStep τ υ).symm n i ≠ τ.val i := by
  cases n with
  | zero => exact (τ.property.1 i).symm
  | succ k =>
    intro heq
    let q := matchingPairStep υ τ
    have hstep : Nat.iterate q (k + 1) i = q (Nat.iterate q k i) :=
      (iterate_commute_necSuf q k i).symm
    have hreduce : Nat.iterate q k i = υ.val i := by
      calc
        Nat.iterate q k i = υ.val (υ.val (Nat.iterate q k i)) :=
          (υ.property.2 _).symm
        _ = υ.val (τ.val (τ.val (υ.val (Nat.iterate q k i)))) :=
          congrArg υ.val (τ.property.2 _).symm
        _ = υ.val (τ.val (q (Nat.iterate q k i))) := rfl
        _ = υ.val (τ.val (Nat.iterate q (k + 1) i)) :=
          congrArg (fun x => υ.val (τ.val x)) hstep.symm
        _ = υ.val (τ.val (τ.val i)) :=
          congrArg (fun x => υ.val (τ.val x)) heq
        _ = υ.val i := congrArg υ.val (τ.property.2 i)
    exact matchingPairStep_iterate_ne_mate υ τ k i hreduce

/-- 第一の相手は、順方向にも逆方向にも二歩置換の軌道に入らない。 -/
theorem matchingPairStep_mate_not_mem (τ υ : FixedPointFreeInvolution J) (i : J) :
    τ.val i ∉ permutationOrbit (matchingPairStep τ υ) i := by
  rintro ⟨n, h | h⟩
  · exact matchingPairStep_iterate_ne_mate τ υ n i h
  · exact matchingPairStep_inverse_iterate_ne_mate τ υ n i h

/-- 共通点があれば始点変更で軌道が一致し、相手の非所属に反する。 -/
theorem matchingPairStep_orbits_disjoint (τ υ : FixedPointFreeInvolution J) (i : J) :
    Disjoint (permutationOrbit (matchingPairStep τ υ) i)
      (permutationOrbit (matchingPairStep τ υ) (τ.val i)) := by
  apply Set.disjoint_left.mpr
  intro j hi hmate
  have hleft := permutationOrbit_basepoint_necSuf (matchingPairStep τ υ) i j hi
  have hright := permutationOrbit_basepoint_necSuf (matchingPairStep τ υ) (τ.val i) j hmate
  have heq : permutationOrbit (matchingPairStep τ υ) (τ.val i) =
      permutationOrbit (matchingPairStep τ υ) i := hright.symm.trans hleft
  apply matchingPairStep_mate_not_mem τ υ i
  rw [← heq]
  exact permutationOrbit_self_mem_necSuf (matchingPairStep τ υ) (τ.val i)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
