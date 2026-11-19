import Ising2DLambda.FisherZero.MaximalOrderedSubfieldSumOfSquaresIsSquare

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 虚数単位を足した元の平方根の明示式の代数的な部分。 -/
theorem imaginaryUnit_squareRootFormula
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
  · have htwo : (2 : Qbar) ≠ 0 := by norm_num
    have hden : 2 * u ≠ 0 := mul_ne_zero htwo hu0
    have hcross : 2 * u * (b / (2 * u)) = b := by
      field_simp
    have hprod : (2 * u * u) * (c - a) = b * b := by
      calc
        (2 * u * u) * (c - a) = (c + a) * (c - a) := by rw [hu2]
        _ = c * c - a * a := by ring
        _ = b * b := by linear_combination hc2
    have hv2 : (b / (2 * u)) * (b / (2 * u)) = (c - a) / 2 := by
      field_simp [hu0]
      linear_combination -hprod
    have hu2' : u * u = (c + a) / 2 := by
      calc
        u * u = (2 * u * u) / 2 := by field_simp [htwo]
        _ = (c + a) / 2 := by rw [hu2]
    have hreal : u * u - (b / (2 * u)) * (b / (2 * u)) = a := by
      calc
        u * u - (b / (2 * u)) * (b / (2 * u))
            = (c + a) / 2 - (c - a) / 2 := by rw [hu2', hv2]
        _ = a := by field_simp; ring
    calc
      (u + b / (2 * u) * omega) * (u + b / (2 * u) * omega)
          = (u * u - (b / (2 * u)) * (b / (2 * u)))
              + (2 * u * (b / (2 * u))) * omega := by
                calc
                  _ = u * u + 2 * u * (b / (2 * u)) * omega
                      + (b / (2 * u)) * (b / (2 * u)) * (omega * omega) := by ring
                  _ = _ := by rw [homega]; ring
      _ = a + b * omega := by rw [hreal, hcross]

end Ising2DLambda.FisherZero
