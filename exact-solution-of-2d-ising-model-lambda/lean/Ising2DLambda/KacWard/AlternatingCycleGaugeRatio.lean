/-
「短い対と基準の長い対の対角変換因子の比」（claim_alternating_cycle_gauge_ratio）の具体版。
実際の対角変換の成分 u_e（diagonalGaugeWeight）、v_e（diagonalGaugeInverseWeight）と
重み w_{e,f}（gaugePairWeight）について、本文の準備の三等号（各辺の比の平方は負の一）、
主鎖の六等号、掛け戻しの二等号を順に示す。必要十分版は呼ばない。
閉路の添字は Fin (m + 1) の巡回の減法で読む（本文の ℤ/kℤ で k = m + 1）。
閉路の性質（非後退・交互閉路）は使わないので、任意の巡回辺列について述べる。
-/
import Ising2DLambda.KacWard.GaugedTerminalSkew
import Ising2DLambda.KacWard.GaugePairWeightNonzero
import Ising2DLambda.KacWard.EdgeDistinctCrossingEliminationParity

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped BigOperators

/-- 本文の v_e = u_e⁻¹。対角変換の両側逆行列の成分の等式（九等号）から得る。 -/
lemma diagonalGaugeInverseWeight_eq_inv {L : ℕ} (z : Qbar) (hz : z ≠ 0)
    (s : SpinStructure) (e : OrientedEdge L) :
    diagonalGaugeInverseWeight z s e = (diagonalGaugeWeight z s e)⁻¹ :=
  eq_inv_of_mul_eq_one_right
    (diagonalGauge_powerPair_cancel z hz (directionGaugeExponent e) (twistGaugeExponent s e))

/-- u_e は零でない。 -/
lemma diagonalGaugeWeight_ne_zero {L : ℕ} (z : Qbar) (hz : z ≠ 0)
    (s : SpinStructure) (e : OrientedEdge L) : diagonalGaugeWeight z s e ≠ 0 :=
  mul_ne_zero (zpow_ne_zero _ hz) (zpow_ne_zero _ hz)

/-- 反転した方向の代表と元の方向の代表の差の二倍は四または負の四である。 -/
lemma directionStandardRepresentative_reversal_double (d : ZMod 4) :
    2 * (directionStandardRepresentative (d + 2) - directionStandardRepresentative d) = 4 ∨
      2 * (directionStandardRepresentative (d + 2) - directionStandardRepresentative d) = -4 := by
  fin_cases d <;> decide

/-- 本文の準備の三等号。各辺について (u_e / u_{ι(e)})² = -1。 -/
theorem diagonalGaugeWeight_reversal_ratio_sq {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e : OrientedEdge L) :
    (diagonalGaugeWeight z s e / diagonalGaugeWeight z s (reversal e)) ^ (2 : ℕ) = -1 := by
  have hnz := diagonalGauge_root_ne_zero z hz
  let p := directionGaugeExponent e
  let p' := directionGaugeExponent (reversal e)
  let q := twistGaugeExponent s e
  have hq : twistGaugeExponent s (reversal e) = q := rfl
  have hfour : z ^ (4 : ℤ) = -1 := (zpow_natCast z 4).trans hz
  have hnegfour : z ^ (-4 : ℤ) = -1 := by
    rw [zpow_neg, hfour, inv_neg, inv_one]
  calc
    (diagonalGaugeWeight z s e / diagonalGaugeWeight z s (reversal e)) ^ (2 : ℕ) =
        ((z ^ p * z ^ q) / (z ^ p' * z ^ q)) ^ (2 : ℕ) := by
      simp only [diagonalGaugeWeight, hq, p, p', q]
    _ = (z ^ (p + q) / z ^ (p' + q)) ^ (2 : ℕ) := by
      rw [zpow_add₀ hnz, zpow_add₀ hnz]
    _ = (z ^ ((p + q) - (p' + q))) ^ (2 : ℕ) := by rw [zpow_sub₀ hnz]
    _ = z ^ (((p + q) - (p' + q)) * 2) := by
      rw [zpow_mul]
      exact (zpow_natCast _ 2).symm
    _ = z ^ (2 * (directionStandardRepresentative (directionNumber (reversal e)) -
          directionStandardRepresentative (directionNumber e))) := by
      congr 1
      simp only [p, p', directionGaugeExponent]
      ring
    _ = z ^ (2 * (directionStandardRepresentative (directionNumber e + 2) -
          directionStandardRepresentative (directionNumber e))) := by
      rw [directionNumber_reversal]
    _ = -1 := by
      rcases directionStandardRepresentative_reversal_double (directionNumber e) with h | h
      · rw [h, hfour]
      · rw [h, hnegfour]

/-- 長い対の重みの積は零でない（claim_gauge_pair_weight_nonzero の各因子から）。 -/
lemma longPairWeight_prod_ne_zero {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) :
    ∏ r : Fin (m + 1), gaugePairWeight z s (γ r) (reversal (γ r)) ≠ 0 :=
  Finset.prod_ne_zero_iff.mpr fun _ _ => gaugePairWeight_ne_zero z hz s _ _

/-- 有限積の巡回再添字付け: 添字を一つずらしても積は変わらない。 -/
lemma prod_fin_cyclic_pred {m : ℕ} (f : Fin (m + 1) → Qbar) :
    ∏ r : Fin (m + 1), f (r - 1) = ∏ r : Fin (m + 1), f r :=
  Fintype.prod_equiv (Equiv.subRight (1 : Fin (m + 1))) _ _ (fun _ => rfl)

/-- 本文の主鎖の六等号。短い対と長い対の重みの積の比は (-1)^k である。 -/
theorem alternating_cycle_gauge_ratio_quotient {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) :
    (∏ r : Fin (m + 1), gaugePairWeight z s (reversal (γ (r - 1))) (γ r)) /
        (∏ r : Fin (m + 1), gaugePairWeight z s (γ r) (reversal (γ r))) =
      (-1) ^ (m + 1) := by
  have hnz := diagonalGauge_root_ne_zero z hz
  have htwo : z ^ (2 : ℕ) ≠ 0 := pow_ne_zero 2 hnz
  let u : OrientedEdge L → Qbar := diagonalGaugeWeight z s
  let v : OrientedEdge L → Qbar := diagonalGaugeInverseWeight z s
  calc
    (∏ r : Fin (m + 1), gaugePairWeight z s (reversal (γ (r - 1))) (γ r)) /
        (∏ r : Fin (m + 1), gaugePairWeight z s (γ r) (reversal (γ r))) =
        (∏ r : Fin (m + 1), z ^ (2 : ℕ) * (v (reversal (γ (r - 1))) * u (γ r))) /
          (∏ r : Fin (m + 1), z ^ (2 : ℕ) * (v (γ r) * u (reversal (γ r)))) := rfl
    _ = (∏ r : Fin (m + 1), z ^ (2 : ℕ) * (v (reversal (γ r)) * u (γ r))) /
          (∏ r : Fin (m + 1), z ^ (2 : ℕ) * (v (γ r) * u (reversal (γ r)))) := by
      congr 1
      calc
        ∏ r : Fin (m + 1), z ^ (2 : ℕ) * (v (reversal (γ (r - 1))) * u (γ r)) =
            (∏ r : Fin (m + 1), z ^ (2 : ℕ)) *
              ((∏ r : Fin (m + 1), v (reversal (γ (r - 1)))) * ∏ r : Fin (m + 1), u (γ r)) := by
          rw [Finset.prod_mul_distrib, Finset.prod_mul_distrib]
        _ = (∏ r : Fin (m + 1), z ^ (2 : ℕ)) *
              ((∏ r : Fin (m + 1), v (reversal (γ r))) * ∏ r : Fin (m + 1), u (γ r)) := by
          rw [prod_fin_cyclic_pred (fun r => v (reversal (γ r)))]
        _ = ∏ r : Fin (m + 1), z ^ (2 : ℕ) * (v (reversal (γ r)) * u (γ r)) := by
          rw [Finset.prod_mul_distrib, Finset.prod_mul_distrib]
    _ = ∏ r : Fin (m + 1), (z ^ (2 : ℕ) * (v (reversal (γ r)) * u (γ r))) /
          (z ^ (2 : ℕ) * (v (γ r) * u (reversal (γ r)))) :=
      (Finset.prod_div_distrib _ _).symm
    _ = ∏ r : Fin (m + 1), (v (reversal (γ r)) * u (γ r)) / (v (γ r) * u (reversal (γ r))) := by
      refine Finset.prod_congr rfl fun r _ => ?_
      exact mul_div_mul_left _ _ htwo
    _ = ∏ r : Fin (m + 1), (u (γ r) / u (reversal (γ r))) ^ (2 : ℕ) := by
      refine Finset.prod_congr rfl fun r _ => ?_
      have hu := diagonalGaugeWeight_ne_zero z hnz s (γ r)
      have hu' := diagonalGaugeWeight_ne_zero z hnz s (reversal (γ r))
      simp only [v, u, diagonalGaugeInverseWeight_eq_inv z hnz]
      field_simp
    _ = ∏ _r : Fin (m + 1), (-1 : Qbar) := by
      refine Finset.prod_congr rfl fun r _ => ?_
      exact diagonalGaugeWeight_reversal_ratio_sq z hz s (γ r)
    _ = (-1) ^ (m + 1) := by
      rw [Finset.prod_const, Finset.card_univ, Fintype.card_fin]

/-- 本文の主張。短い標識の対の重みの積は、長い標識の対の重みの積の (-1)^k 倍である。 -/
theorem alternating_cycle_gauge_ratio {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) {m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) :
    ∏ r : Fin (m + 1), gaugePairWeight z s (reversal (γ (r - 1))) (γ r) =
      (-1) ^ (m + 1) * ∏ r : Fin (m + 1), gaugePairWeight z s (γ r) (reversal (γ r)) := by
  have hlong := longPairWeight_prod_ne_zero z hz s γ
  calc
    ∏ r : Fin (m + 1), gaugePairWeight z s (reversal (γ (r - 1))) (γ r) =
        ((∏ r : Fin (m + 1), gaugePairWeight z s (reversal (γ (r - 1))) (γ r)) /
            (∏ r : Fin (m + 1), gaugePairWeight z s (γ r) (reversal (γ r)))) *
          ∏ r : Fin (m + 1), gaugePairWeight z s (γ r) (reversal (γ r)) :=
      (div_mul_cancel₀ _ hlong).symm
    _ = (-1) ^ (m + 1) * ∏ r : Fin (m + 1), gaugePairWeight z s (γ r) (reversal (γ r)) := by
      rw [alternating_cycle_gauge_ratio_quotient z hz s γ]

/-- 実際の閉じた非後退辺列（本文の射影した閉歩道）への適用。 -/
theorem closedWalk_gauge_ratio {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (δ : ClosedNonbacktrackingWalkData L) :
    ∏ r : Fin (δ.len + 1), gaugePairWeight z s (reversal (δ.walk (r - 1))) (δ.walk r) =
      (-1) ^ (δ.len + 1) *
        ∏ r : Fin (δ.len + 1), gaugePairWeight z s (δ.walk r) (reversal (δ.walk r)) :=
  alternating_cycle_gauge_ratio z hz s δ.walk

end Ising2DLambda.KacWard
