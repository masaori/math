/-
「短い対と基準の長い対の対角変換因子の比」の具体版が必要十分版の特殊化として得られることの記録。
G = Qbar、E = 向き付き辺、c = z²、μ = -1、p = 方向の指数、q = ねじれの指数、ρ = 反転と取る。
-/
import Ising2DLambda.KacWard.AlternatingCycleGaugeRatio
import Ising2DLambda.NecSuf.KacWard.AlternatingCycleGaugeRatio

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped BigOperators

theorem alternating_cycle_gauge_ratio_from_necSuf {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) :
    ∏ r : Fin (m + 1), gaugePairWeight z s (reversal (γ (r - 1))) (γ r) =
      (-1) ^ (m + 1) * ∏ r : Fin (m + 1), gaugePairWeight z s (γ r) (reversal (γ r)) := by
  have hnz := diagonalGauge_root_ne_zero z hz
  have hfour : z ^ (4 : ℤ) = -1 := (zpow_natCast z 4).trans hz
  have hnegfour : z ^ (-4 : ℤ) = -1 := by rw [zpow_neg, hfour, inv_neg, inv_one]
  have hp : ∀ e : OrientedEdge L,
      2 * (directionGaugeExponent e - directionGaugeExponent (reversal e)) = 4 ∨
        2 * (directionGaugeExponent e - directionGaugeExponent (reversal e)) = -4 := by
    intro e
    have h := directionStandardRepresentative_reversal_double (directionNumber e)
    simp only [directionGaugeExponent, directionNumber_reversal]
    rcases h with h | h
    · left; linarith
    · right; linarith
  exact Ising2DLambda.NecSuf.KacWard.cycle_gauge_ratio_necSuf z (z ^ (2 : ℕ)) (-1) hnz
    (pow_ne_zero 2 hnz) directionGaugeExponent (twistGaugeExponent s) reversal
    (fun _ => rfl) hp hfour hnegfour γ

end Ising2DLambda.KacWard
