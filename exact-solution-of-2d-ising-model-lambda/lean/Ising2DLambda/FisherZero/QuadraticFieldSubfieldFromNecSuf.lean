import Ising2DLambda.FisherZero.QuadraticFieldSubfield
import Ising2DLambda.NecSuf.FisherZero.QuadraticFieldSubfield

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版の閉包条件を二次体の台集合へ接続する。 -/
theorem quadraticFieldSubfield_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    ∃ F : Subfield Qbar, F = quadraticFieldSubfield s hs := by
  let F := Ising2DLambda.NecSuf.FisherZero.carrier_isSubfield_necSuf
    (quadraticFieldSet s) (quadraticZero_mem s)
    (by refine ⟨1, 0, ?_⟩; simp)
    (fun x y hx hy => quadraticAdd_mem s ⟨x, hx⟩ ⟨y, hy⟩)
    (fun x hx => quadraticNeg_mem s ⟨x, hx⟩)
    (fun x y hx hy => quadraticMul_mem s hs ⟨x, hx⟩ ⟨y, hy⟩)
    (fun x hx => by
      by_cases hzero : x = 0
      · subst x
        simpa using quadraticZero_mem s
      · exact quadraticInverse_mem s hs x hx hzero)
  refine ⟨F, ?_⟩
  ext z
  rfl

end Ising2DLambda.FisherZero
