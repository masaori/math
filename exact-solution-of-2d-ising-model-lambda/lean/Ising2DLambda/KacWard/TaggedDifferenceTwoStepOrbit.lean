/-
活動点の二つの相手写像をそれぞれ制限して対合とし、短い相手の後に
長い相手を取る合成を置換にする。正の帰還は本文の有限置換の補題を引く。
標識は活動点の定義に残るので、端点が同じ長短の対も区別される。
-/
import Ising2DLambda.KacWard.TaggedDifferenceActiveVertices
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationMinimalPeriod

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

noncomputable def taggedActiveShortMate {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    Equiv.Perm {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)} where
  toFun i := ⟨perfectMatchingMate D i.1,
    (taggedDifference_active_mates D t i.1 i.2).1⟩
  invFun i := ⟨perfectMatchingMate D i.1,
    (taggedDifference_active_mates D t i.1 i.2).1⟩
  left_inv i := Subtype.ext (perfectMatchingMate_involutive D i.1)
  right_inv i := Subtype.ext (perfectMatchingMate_involutive D i.1)

noncomputable def taggedActiveLongMate {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    Equiv.Perm {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)} where
  toFun i := ⟨perfectMatchingMate
    (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
      PerfectMatching (OrientedEdge L)) i.1,
    (taggedDifference_active_mates D t i.1 i.2).2⟩
  invFun i := ⟨perfectMatchingMate
    (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
      PerfectMatching (OrientedEdge L)) i.1,
    (taggedDifference_active_mates D t i.1 i.2).2⟩
  left_inv i := Subtype.ext (perfectMatchingMate_involutive
    (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
      PerfectMatching (OrientedEdge L)) i.1)
  right_inv i := Subtype.ext (perfectMatchingMate_involutive
    (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
      PerfectMatching (OrientedEdge L)) i.1)

noncomputable def taggedActiveTwoStep {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    Equiv.Perm {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)} :=
  (taggedActiveShortMate D t).trans (taggedActiveLongMate D t)

theorem taggedActiveTwoStep_apply {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)}) :
    (taggedActiveTwoStep D t i).1 = perfectMatchingMate
      (⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩ :
        PerfectMatching (OrientedEdge L)) (perfectMatchingMate D i.1) := rfl

theorem taggedActiveTwoStep_periodic {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L))
    (i : {i : OrientedEdge L // i ∈
      Ising2DLambda.NecSuf.KacWard.activeVertices D
        ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩
        (shortUnderlyingPairs t)}) :
    ∃ n : ℕ, 0 < n ∧
      (taggedActiveTwoStep D t)^[n] i = i := by
  classical
  simpa only [finiteMapIterate] using
    finitePermutation_positive_return (taggedActiveTwoStep D t) i

end Ising2DLambda.KacWard
