/- 実際の方向・切断線の指数と、非零な Qbar の整数冪を必要十分版へ供給する。 -/
import Ising2DLambda.KacWard.DiagonalGaugeInverse
import Ising2DLambda.NecSuf.KacWard.DiagonalGaugeInverse

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 四乗根の非零性、整数冪の法則、実際の二指数、零の左右吸収を供給する。 -/
theorem diagonalGauge_mul_inverse_from_necSuf (L : ℕ) (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    diagonalGauge L z s * diagonalGaugeInverse L z s = 1 ∧
      diagonalGaugeInverse L z s * diagonalGauge L z s = 1 := by
  have hnz : z ≠ 0 := diagonalGauge_root_ne_zero z hz
  let φ : ℤ → Qbar := fun n => z ^ n
  have hzero : φ 0 = 1 := zpow_zero z
  have hadd (a b : ℤ) : φ (a + b) = φ a * φ b := zpow_add₀ hnz a b
  have hU : diagonalGauge L z s =
      NecSuf.KacWard.powerPairDiagonal φ directionGaugeExponent (twistGaugeExponent s) := rfl
  have hV : diagonalGaugeInverse L z s =
      NecSuf.KacWard.powerPairDiagonalInverse φ directionGaugeExponent (twistGaugeExponent s) := rfl
  rw [hU, hV]
  exact NecSuf.KacWard.powerPairDiagonal_mul_inverse_necSuf φ hzero hadd
    directionGaugeExponent (twistGaugeExponent s) (fun r => zero_mul r) (fun r => mul_zero r)

end Ising2DLambda.KacWard
