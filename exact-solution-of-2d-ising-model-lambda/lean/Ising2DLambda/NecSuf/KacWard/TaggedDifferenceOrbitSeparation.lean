import Ising2DLambda.NecSuf.KacWard.TaggedDifferenceTwoStepOrbit
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrbitSeparation

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

variable {J : Type*} [Fintype J]

private noncomputable def shortInvolution (D R : PerfectMatching J) (T : Set (Set J)) :
    FixedPointFreeInvolution {i : J // i ∈ activeVertices D R T} :=
  ⟨activeMate D R T D (fun i hi => (activeVertices_mates D R T i hi).1),
    (fun i h => perfectMatchingMate_ne D i.1 (congrArg Subtype.val h)),
    (fun i => Subtype.ext (perfectMatchingMate_involutive D i.1))⟩

private noncomputable def longInvolution (D R : PerfectMatching J) (T : Set (Set J)) :
    FixedPointFreeInvolution {i : J // i ∈ activeVertices D R T} :=
  ⟨activeMate D R T R (fun i hi => (activeVertices_mates D R T i hi).2),
    (fun i h => perfectMatchingMate_ne R i.1 (congrArg Subtype.val h)),
    (fun i => Subtype.ext (perfectMatchingMate_involutive R i.1))⟩

theorem activeTwoStep_orbits_disjoint (D R : PerfectMatching J) (T : Set (Set J))
    (i : {i : J // i ∈ activeVertices D R T}) :
    Disjoint (finitePermutationOrbit (activeTwoStep D R T) i)
      (finitePermutationOrbit (activeTwoStep D R T)
        (activeMate D R T D (fun j hj => (activeVertices_mates D R T j hj).1) i)) := by
  let τ := shortInvolution D R T
  let υ := longInvolution D R T
  have hstep : matchingPairStep τ υ = activeTwoStep D R T := by
    apply Equiv.ext
    intro j
    rfl
  have hmate : τ.val i =
      activeMate D R T D (fun j hj => (activeVertices_mates D R T j hj).1) i := rfl
  simpa only [hstep, hmate] using matchingPairStep_orbits_disjoint τ υ i

end Ising2DLambda.NecSuf.KacWard
