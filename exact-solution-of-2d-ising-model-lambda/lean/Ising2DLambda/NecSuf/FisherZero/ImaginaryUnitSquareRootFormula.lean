import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 明示式の検算に必要なのは、二が零でない体と二つの平方等式だけである。
特性零は使わず、二の非零性だけを仮定する。 -/
theorem imaginaryUnit_squareRootFormula
    {K : Type*} [Field K]
    (a b c u omega : K) (htwo : (2 : K) ≠ 0) (hu0 : u ≠ 0)
    (hc2 : c * c = a * a + b * b)
    (hu2 : 2 * u * u = c + a) (homega : omega * omega = -1) :
    let v := b / (2 * u)
    (u + v * omega) * (u + v * omega) = a + b * omega := by
  dsimp
  have hden : 2 * u ≠ 0 := mul_ne_zero htwo hu0
  have hcross : 2 * u * (b / (2 * u)) = b := by field_simp
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

end Ising2DLambda.NecSuf.FisherZero
