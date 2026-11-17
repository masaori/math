import Ising2DLambda.FisherZero.QuadraticFieldSubfield
import Ising2DLambda.FisherZero.QuadraticPositiveConeAmbientTrichotomy
import Ising2DLambda.FisherZero.QuadraticPositiveConeAddClosed
import Ising2DLambda.FisherZero.QuadraticPositiveConeMulClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_quadratic_positive_cone_is_subfield_positive_cone` の具体版。 -/
theorem quadraticPositiveCone_isSubfieldPositiveCone
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    IsSubfieldPositiveCone (quadraticFieldSubfield s hs)
      (quadraticPositiveConeAmbient s) := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro z hz
    exact hz.1
  · intro x y hx hy
    rcases hx with ⟨hxF, hxP⟩
    rcases hy with ⟨hyF, hyP⟩
    let xi : QuadraticFieldElement s := ⟨x, hxF⟩
    let eta : QuadraticFieldElement s := ⟨y, hyF⟩
    have hxy : quadraticAddElement s xi eta ∈ quadraticPositiveCone s :=
      quadraticPositiveCone_add_mem s hs xi eta hxP hyP
    exact ⟨quadraticAdd_mem s xi eta, hxy⟩
  · intro x y hx hy
    rcases hx with ⟨hxF, hxP⟩
    rcases hy with ⟨hyF, hyP⟩
    let xi : QuadraticFieldElement s := ⟨x, hxF⟩
    let eta : QuadraticFieldElement s := ⟨y, hyF⟩
    have hxy : quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s :=
      quadraticPositiveCone_mul_mem s hs xi eta hxP hyP
    exact ⟨quadraticMul_mem s hs xi eta, hxy⟩
  · intro z hz
    exact quadraticPositiveCone_ambient_trichotomy s hs z hz

end Ising2DLambda.FisherZero
