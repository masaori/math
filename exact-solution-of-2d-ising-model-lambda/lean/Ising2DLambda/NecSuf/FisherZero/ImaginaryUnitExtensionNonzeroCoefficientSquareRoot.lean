import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitSquareRootFormula

namespace Ising2DLambda.NecSuf.FisherZero

/-- 正錐や極大性を除き、二つの平方根の証人から明示式へ代入する部分。 -/
theorem imaginaryUnitExtension_nonzeroCoefficient_squareRoot
    {K : Type*} [Field K] (F : Subfield K) (a b c omega d t : K)
    (hb : b ∈ F) (hdF : d ∈ F) (htF : t ∈ F)
    (hd0 : d ≠ 0) (ht0 : t ≠ 0)
    (hc2 : c * c = a * a + b * b) (hd2 : d * d = c + a)
    (ht2 : t * t = 2) (homega : omega * omega = -1) :
    ∃ u v : K, u ∈ F ∧ v ∈ F ∧
      (u + v * omega) * (u + v * omega) = a + b * omega := by
  let u : K := d / t
  have huF : u ∈ F := F.div_mem hdF htF
  have hu0 : u ≠ 0 := div_ne_zero hd0 ht0
  have htwo : (2 : K) ≠ 0 := by
    intro h
    rw [← ht2] at h
    exact ht0 (mul_self_eq_zero.mp h)
  have hu2 : 2 * u * u = c + a := by
    dsimp [u]
    calc
      2 * (d / t) * (d / t) = (d * d) * (2 / (t * t)) := by ring
      _ = d * d := by rw [ht2, div_self htwo, mul_one]
      _ = c + a := hd2
  have hvF : b / (2 * u) ∈ F := by
    have htwoF : (2 : K) ∈ F := by
      convert F.add_mem F.one_mem F.one_mem using 1 <;> norm_num
    exact F.div_mem hb (F.mul_mem htwoF huF)
  have hroot := imaginaryUnit_squareRootFormula a b c u omega htwo hu0 hc2 hu2 homega
  exact ⟨u, b / (2 * u), huF, hvF, hroot⟩

end Ising2DLambda.NecSuf.FisherZero
