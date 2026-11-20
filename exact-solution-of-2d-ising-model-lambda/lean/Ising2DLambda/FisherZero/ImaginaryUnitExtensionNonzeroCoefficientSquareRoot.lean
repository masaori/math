import Ising2DLambda.FisherZero.SumOfSquaresPositiveRootPlusRealPositive
import Ising2DLambda.FisherZero.ImaginaryUnitSquareRootFormula
import Ising2DLambda.FisherZero.PositiveWeightedSquareSums

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 非零の虚係数では、正の平方和根から二つの平方根を選んで明示式へ代入する。 -/
theorem imaginaryUnitExtension_nonzeroCoefficient_squareRoot
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C →
      ∃ w : Qbar, w ∈ F ∧ w ≠ 0 ∧ w * w = z)
    (a b c omega : Qbar) (ha : a ∈ F) (hb : b ∈ F)
    (hc : c ∈ C) (hb0 : b ≠ 0)
    (hc2 : c * c = a * a + b * b) (homega : omega * omega = -1) :
    ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧
      (u + v * omega) * (u + v * omega) = a + b * omega := by
  have hca : c + a ∈ C :=
    sumOfSquares_positiveRoot_plusReal_positive F C hC a b c ha hb hc hb0 hc2
  have htwo : (2 : Qbar) ∈ C := by
    have hone := one_mem_of_isSubfieldPositiveCone F C hC
    convert hC.add_mem 1 1 hone hone using 1 <;> norm_num
  obtain ⟨d, hdF, hd0, hd2⟩ := hpositive (c + a) hca
  obtain ⟨t, htF, ht0, ht2⟩ := hpositive 2 htwo
  let u : Qbar := d / t
  have huF : u ∈ F := F.div_mem hdF htF
  have hu0 : u ≠ 0 := div_ne_zero hd0 ht0
  have hu2 : 2 * u * u = c + a := by
    dsimp [u]
    calc
      2 * (d / t) * (d / t) = (d * d) * (2 / (t * t)) := by ring
      _ = d * d := by rw [ht2]; norm_num
      _ = c + a := hd2
  obtain ⟨hvF, hroot⟩ :=
    imaginaryUnit_squareRootFormula F a b c u omega ha hb (hC.subset c hc)
      huF hu0 hc2 hu2 homega
  exact ⟨u, b / (2 * u), huF, hvF, hroot⟩

end Ising2DLambda.FisherZero
