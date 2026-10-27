/- `claim_same_direction_dual_inner_orthogonality` の必要十分版からの導出。 -/
import Ising2DLambda.KacWard.SameDirectionDualInnerOrthogonality
import Ising2DLambda.NecSuf.KacWard.SameDirectionDualInnerOrthogonality
import Ising2DLambda.KacWard.DualEndpointModeVectorFromNecSuf
import Ising2DLambda.KacWard.EndpointModeVectorFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial
open BigOperators
attribute [local instance] Classical.propDecidable

theorem sameDirection_dualInner_orthogonality_from_necSuf {L : ℕ} [NeZero L]
    (s : SpinStructure) (varpi varsigma varpi' varsigma' : Qbar) (δ : ZMod 4)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (hvarpi' : varpi' ∈ horizontalTwistedModes L s)
    (hvarsigma' : varsigma' ∈ verticalTwistedModes L s) :
    (∑ e : OrientedEdge L,
      dualEndpointModeVector L varpi varsigma δ e *
        endpointModeVector L varpi' varsigma' δ e) =
      if varpi = varpi' ∧ varsigma = varsigma' then (L : Qbar) ^ 2 else 0 := by
  classical
  let htarget : OrientedEdge L ≃ (Vertex L × ZMod 4) :=
    Equiv.ofBijective (fun e => (orientedTarget e, directionNumber e))
      targetDirection_bijective
  let hcoord : Vertex L ≃ Fin L × Fin L :=
    Equiv.prodCongr (ZMod.finEquiv L).symm (ZMod.finEquiv L).symm
  let h : OrientedEdge L ≃ ((Fin L × Fin L) × ZMod 4) :=
    htarget.trans (Equiv.prodCongr hcoord (Equiv.refl _))
  have hrow (e : OrientedEdge L) :
      (orientedTarget e).1.val = (h e).1.1.val := by
    simp [h, htarget, hcoord]
    cases L with
    | zero => exact (NeZero.ne 0 rfl).elim
    | succ n => rfl
  have hcolumn (e : OrientedEdge L) :
      (orientedTarget e).2.val = (h e).1.2.val := by
    simp [h, htarget, hcoord]
    cases L with
    | zero => exact (NeZero.ne 0 rfl).elim
    | succ n => rfl
  have hdirection (e : OrientedEdge L) : directionNumber e = (h e).2 := by
    simp [h, htarget, hcoord]
  have hnonzeroVarpi : varpi ≠ 0 := by
    intro hz
    have hp : varpi ^ L = (if s.1 then (-1 : Qbar) else 1) := hvarpi
    rw [hz, zero_pow (NeZero.ne L)] at hp
    split_ifs at hp <;> norm_num at hp
  have hnonzeroVarsigma : varsigma ≠ 0 := by
    intro hz
    have hp : varsigma ^ L = (if s.2 then (-1 : Qbar) else 1) := hvarsigma
    rw [hz, zero_pow (NeZero.ne L)] at hp
    split_ifs at hp <;> norm_num at hp
  obtain ⟨hr, ht⟩ := twistedMode_ratio_root s hvarpi hvarpi' hvarsigma hvarsigma'
  simpa only [dualEndpointModeVector_from_necSuf,
    endpointModeVector_from_necSuf] using
    Ising2DLambda.NecSuf.KacWard.sameDirection_dualInner_orthogonality_necSuf
      h (fun e => (orientedTarget e).1.val) (fun e => (orientedTarget e).2.val)
      directionNumber hrow hcolumn hdirection varpi varsigma varpi' varsigma' δ
      hnonzeroVarpi hnonzeroVarsigma hr ht

end Ising2DLambda.KacWard
