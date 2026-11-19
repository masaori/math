import Ising2DLambda.FisherZero.ImaginaryUnitSquareRootFormula
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitSquareRootFormula

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版の代数的検算を代数的数に特殊化する。 -/
theorem imaginaryUnit_squareRootFormula_from_necSuf
    (F : Subfield Qbar) (a b c u omega : Qbar)
    (ha : a ∈ F) (hb : b ∈ F) (hc : c ∈ F) (hu : u ∈ F)
    (hu0 : u ≠ 0) (hc2 : c * c = a * a + b * b)
    (hu2 : 2 * u * u = c + a) (homega : omega * omega = -1) :
    let v := b / (2 * u)
    v ∈ F ∧ (u + v * omega) * (u + v * omega) = a + b * omega := by
  dsimp
  constructor
  · have htwoF : (2 : Qbar) ∈ F := by
      convert F.add_mem F.one_mem F.one_mem using 1 <;> norm_num
    exact F.div_mem hb (F.mul_mem htwoF hu)
  · exact Ising2DLambda.NecSuf.FisherZero.imaginaryUnit_squareRootFormula
      a b c u omega (by norm_num) hu0 hc2 hu2 homega

end Ising2DLambda.FisherZero
