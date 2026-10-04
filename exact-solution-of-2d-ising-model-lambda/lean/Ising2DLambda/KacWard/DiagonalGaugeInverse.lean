/-
実際の方向番号と切断線の偶奇から定めた対角変換の逆行列。
本文の整数冪九行、対角成分の二方向、有限和の成分計算を独立に証明する。
必要十分版は呼ばない。係数の住処は Qbar、指数の住処は整数である。
-/
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.KacWard.DirectionGateCrossingTurning

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped BigOperators

lemma directionStandardRepresentative_nonneg (d : ZMod 4) :
    0 ≤ directionStandardRepresentative d := Int.natCast_nonneg _

lemma directionStandardRepresentative_lt_four (d : ZMod 4) :
    directionStandardRepresentative d < 4 := by
  have h := ZMod.val_lt d
  unfold directionStandardRepresentative
  omega

lemma directionStandardRepresentative_eq_zero_or_one_or_two_or_three (d : ZMod 4) :
    directionStandardRepresentative d = 0 ∨ directionStandardRepresentative d = 1 ∨
      directionStandardRepresentative d = 2 ∨ directionStandardRepresentative d = 3 := by
  have hnonneg := directionStandardRepresentative_nonneg d
  have hlt := directionStandardRepresentative_lt_four d
  omega

/-- 実際の二つの切断線とねじれから得る、自然数値の偶奇。 -/
def twistParity {L : ℕ} (s : SpinStructure) (e : OrientedEdge L) : ℕ :=
  (s.1.toNat * horizontalSeamParity e + s.2.toNat * verticalSeamParity e) % 2

lemma twistParity_lt_two {L : ℕ} (s : SpinStructure) (e : OrientedEdge L) :
    twistParity s e < 2 := Nat.mod_lt _ (by decide)

lemma twistParity_eq_zero_or_one {L : ℕ} (s : SpinStructure) (e : OrientedEdge L) :
    twistParity s e = 0 ∨ twistParity s e = 1 := by
  have h := twistParity_lt_two s e
  omega

/-- 方向から来る整数指数 p_e。 -/
def directionGaugeExponent {L : ℕ} (e : OrientedEdge L) : ℤ :=
  -directionStandardRepresentative (directionNumber e)

/-- ねじれから来る整数指数 q_e。 -/
def twistGaugeExponent {L : ℕ} (s : SpinStructure) (e : OrientedEdge L) : ℤ :=
  -2 * (twistParity s e : ℤ)

/-- 対角変換の対角成分 u_e。 -/
noncomputable def diagonalGaugeWeight {L : ℕ} (z : Qbar) (s : SpinStructure)
    (e : OrientedEdge L) : Qbar :=
  z ^ directionGaugeExponent e * z ^ twistGaugeExponent s e

/-- 逆行列の対角成分 v_e。因子の順序を反転する。 -/
noncomputable def diagonalGaugeInverseWeight {L : ℕ} (z : Qbar) (s : SpinStructure)
    (e : OrientedEdge L) : Qbar :=
  z ^ (-twistGaugeExponent s e) * z ^ (-directionGaugeExponent e)

noncomputable def diagonalGauge (L : ℕ) (z : Qbar) (s : SpinStructure) :
    Matrix (OrientedEdge L) (OrientedEdge L) Qbar :=
  fun e f => if f = e then diagonalGaugeWeight z s e else 0

noncomputable def diagonalGaugeInverse (L : ℕ) (z : Qbar) (s : SpinStructure) :
    Matrix (OrientedEdge L) (OrientedEdge L) Qbar :=
  fun e f => if f = e then diagonalGaugeInverseWeight z s e else 0

/-- 四乗が負の一である根は零でない。 -/
lemma diagonalGauge_root_ne_zero (z : Qbar) (hz : z ^ (4 : ℕ) = -1) : z ≠ 0 := by
  intro hzero
  rw [hzero] at hz
  norm_num at hz

/-- 本文の準備の九等号。結合、整数冪の加法、指数の逆元、零乗を分ける。 -/
lemma diagonalGauge_powerPair_cancel (z : Qbar) (hz : z ≠ 0) (p q : ℤ) :
    (z ^ p * z ^ q) * (z ^ (-q) * z ^ (-p)) = 1 := by
  calc
    (z ^ p * z ^ q) * (z ^ (-q) * z ^ (-p)) =
        z ^ p * (z ^ q * (z ^ (-q) * z ^ (-p))) := mul_assoc _ _ _
    _ = z ^ p * ((z ^ q * z ^ (-q)) * z ^ (-p)) := by
      rw [← mul_assoc (z ^ q) (z ^ (-q)) (z ^ (-p))]
    _ = z ^ p * (z ^ (q + -q) * z ^ (-p)) :=
      congrArg (fun t => z ^ p * (t * z ^ (-p))) (zpow_add₀ hz q (-q)).symm
    _ = z ^ p * (z ^ (0 : ℤ) * z ^ (-p)) := by rw [add_neg_cancel]
    _ = z ^ p * (1 * z ^ (-p)) := by rw [zpow_zero]
    _ = z ^ p * z ^ (-p) := by rw [one_mul]
    _ = z ^ (p + -p) := (zpow_add₀ hz p (-p)).symm
    _ = z ^ (0 : ℤ) := by rw [add_neg_cancel]
    _ = 1 := zpow_zero z

/-- 本文の u_e v_e の三等号。 -/
lemma diagonalGaugeWeight_mul_inverse (L : ℕ) (z : Qbar) (hz : z ≠ 0)
    (s : SpinStructure) (e : OrientedEdge L) :
    diagonalGaugeWeight z s e * diagonalGaugeInverseWeight z s e = 1 := by
  calc
    diagonalGaugeWeight z s e * diagonalGaugeInverseWeight z s e =
        (z ^ directionGaugeExponent e * z ^ twistGaugeExponent s e) *
          diagonalGaugeInverseWeight z s e := rfl
    _ = (z ^ directionGaugeExponent e * z ^ twistGaugeExponent s e) *
        (z ^ (-twistGaugeExponent s e) * z ^ (-directionGaugeExponent e)) := rfl
    _ = 1 := diagonalGauge_powerPair_cancel z hz _ _

/-- 本文の v_e u_e の五等号。二重の負号を指数ごとに戻す。 -/
lemma diagonalGaugeInverseWeight_mul_weight (L : ℕ) (z : Qbar) (hz : z ≠ 0)
    (s : SpinStructure) (e : OrientedEdge L) :
    diagonalGaugeInverseWeight z s e * diagonalGaugeWeight z s e = 1 := by
  calc
    diagonalGaugeInverseWeight z s e * diagonalGaugeWeight z s e =
        (z ^ (-twistGaugeExponent s e) * z ^ (-directionGaugeExponent e)) *
          diagonalGaugeWeight z s e := rfl
    _ = (z ^ (-twistGaugeExponent s e) * z ^ (-directionGaugeExponent e)) *
        (z ^ directionGaugeExponent e * z ^ twistGaugeExponent s e) := rfl
    _ = (z ^ (-twistGaugeExponent s e) * z ^ (-directionGaugeExponent e)) *
        (z ^ (-(-directionGaugeExponent e)) * z ^ twistGaugeExponent s e) := by rw [neg_neg]
    _ = (z ^ (-twistGaugeExponent s e) * z ^ (-directionGaugeExponent e)) *
        (z ^ (-(-directionGaugeExponent e)) * z ^ (-(-twistGaugeExponent s e))) := by
      rw [neg_neg (twistGaugeExponent s e)]
    _ = 1 := diagonalGauge_powerPair_cancel z hz _ _

/-- 実際の方向・切断線から作った二つの Qbar 行列は互いの左右逆行列である。 -/
theorem diagonalGauge_mul_inverse (L : ℕ) (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) :
    diagonalGauge L z s * diagonalGaugeInverse L z s = 1 ∧
      diagonalGaugeInverse L z s * diagonalGauge L z s = 1 := by
  have hnz := diagonalGauge_root_ne_zero z hz
  -- 本文の M,N は (U,V) または (V,U)。以下の成分計算を各組に適用する。
  have hmatrix (M N : Matrix (OrientedEdge L) (OrientedEdge L) Qbar)
      (m n : OrientedEdge L → Qbar)
      (hM : ∀ e f, M e f = if f = e then m e else 0)
      (hN : ∀ e f, N e f = if f = e then n e else 0)
      (hmn : ∀ e, m e * n e = 1) : M * N = 1 := by
    apply Matrix.ext
    intro e f
    -- 対角以外の和の項を零にする二等号。
    have hzero (g : OrientedEdge L) (hg : g ≠ e) : M e g * N g f = 0 := by
      calc
        M e g * N g f = 0 * N g f := by rw [hM e g, if_neg hg]
        _ = 0 := zero_mul _
    -- 行列積、有限和の唯一の項、対角成分の順に三等号。
    have hentry : (M * N) e f = m e * N e f := by
      calc
        (M * N) e f = ∑ g, M e g * N g f := rfl
        _ = M e e * N e f := Fintype.sum_eq_single e hzero
        _ = m e * N e f := by rw [hM e e, if_pos rfl]
    rw [hentry]
    by_cases hfe : f = e
    · subst f
      calc
        m e * N e e = m e * n e := by rw [hN e e, if_pos rfl]
        _ = 1 := hmn e
        _ = (1 : Matrix (OrientedEdge L) (OrientedEdge L) Qbar) e e := by
          rw [Matrix.one_apply_eq]
    · calc
        m e * N e f = m e * 0 := by rw [hN e f, if_neg hfe]
        _ = 0 := mul_zero _
        _ = (1 : Matrix (OrientedEdge L) (OrientedEdge L) Qbar) e f := by
          rw [Matrix.one_apply_ne (Ne.symm hfe)]
  constructor
  · exact hmatrix _ _ _ _ (fun _ _ => rfl) (fun _ _ => rfl)
      (diagonalGaugeWeight_mul_inverse L z hnz s)
  · exact hmatrix _ _ _ _ (fun _ _ => rfl) (fun _ _ => rfl)
      (diagonalGaugeInverseWeight_mul_weight L z hnz s)

end Ising2DLambda.KacWard
