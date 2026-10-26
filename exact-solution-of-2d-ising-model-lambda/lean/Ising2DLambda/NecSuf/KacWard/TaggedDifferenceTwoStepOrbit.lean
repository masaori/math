/-
二つの完全マッチングの相手写像が活動点を保つこと、各相手写像が
対合であること、活動点が有限であることだけを使う必要十分版。
-/
import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceActiveVertices
import Ising2DLambda.AlgebraicEigenvalue.FinitePermutationMinimalPeriod

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue

variable {J : Type*} [Fintype J]

noncomputable def activeMate (D R : PerfectMatching J) (T : Set (Set J))
    (M : PerfectMatching J)
    (hM : ∀ i ∈ activeVertices D R T,
      perfectMatchingMate M i ∈ activeVertices D R T) :
    Equiv.Perm {i : J // i ∈ activeVertices D R T} where
  toFun i := ⟨perfectMatchingMate M i.1, hM i.1 i.2⟩
  invFun i := ⟨perfectMatchingMate M i.1, hM i.1 i.2⟩
  left_inv i := Subtype.ext (perfectMatchingMate_involutive M i.1)
  right_inv i := Subtype.ext (perfectMatchingMate_involutive M i.1)

noncomputable def activeTwoStep (D R : PerfectMatching J) (T : Set (Set J)) :
    Equiv.Perm {i : J // i ∈ activeVertices D R T} :=
  (activeMate D R T D (fun i hi => (activeVertices_mates D R T i hi).1)).trans
    (activeMate D R T R (fun i hi => (activeVertices_mates D R T i hi).2))

theorem activeTwoStep_apply (D R : PerfectMatching J) (T : Set (Set J))
    (i : {i : J // i ∈ activeVertices D R T}) :
    (activeTwoStep D R T i).1 =
      perfectMatchingMate R (perfectMatchingMate D i.1) := rfl

theorem activeTwoStep_periodic (D R : PerfectMatching J) (T : Set (Set J))
    (i : {i : J // i ∈ activeVertices D R T}) :
    ∃ n : ℕ, 0 < n ∧
      (activeTwoStep D R T)^[n] i = i := by
  classical
  simpa only [finiteMapIterate] using
    finitePermutation_positive_return (activeTwoStep D R T) i

end Ising2DLambda.NecSuf.KacWard
