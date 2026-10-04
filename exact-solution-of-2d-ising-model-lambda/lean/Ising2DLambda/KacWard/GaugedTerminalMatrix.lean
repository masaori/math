/-
対角相似した端末行列の成分を、実際の対角行列と有限和から独立に計算する。
左の零項・左成分・右の零項・右成分の各四等号と、主鎖十一等号を本文へ対応させる。
四乗根の条件は使わず、L=1 でも反転辺と同じ始点の二条件を別々に保つ。
-/
import Ising2DLambda.KacWard.PolynomialDiagonalGaugeInverse

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped BigOperators

/-- 対角相似と全体の定数倍から、成分ごとに現れる代数的数。 -/
noncomputable def gaugePairWeight {L : ℕ} (z : Qbar) (s : SpinStructure)
    (e f : OrientedEdge L) : Qbar :=
  z ^ (2 : ℕ) * (diagonalGaugeInverseWeight z s e * diagonalGaugeWeight z s f)

/-- 定数多項式の対角行列で端末行列を挟み、z² を掛けた行列。 -/
noncomputable def gaugedTerminalMatrix (L : ℕ) (z : Qbar) (s : SpinStructure) :
    QbarPolynomialMatrix (OrientedEdge L) :=
  fun e f => qbarConst (z ^ (2 : ℕ)) *
    ((polynomialDiagonalGaugeInverse L z s * terminalMatrix L z s) *
      polynomialDiagonalGauge L z s) e f

/-- 有限和を一項へ絞って得る成分式。必要十分版は呼ばない。 -/
theorem gaugedTerminalMatrix_entry (L : ℕ) [NeZero L] (z : Qbar) (s : SpinStructure)
    (e f : OrientedEdge L) :
    gaugedTerminalMatrix L z s e f = qbarConst (gaugePairWeight z s e f) *
      ((if f = reversal e then 1 else 0) - Polynomial.X *
        (if orientedSource f = orientedSource e ∧ f ≠ e
          then Polynomial.C ((twistSign s f : Qbar) * rotationPhase z (reversal e) f)
          else 0)) := by
  let A := terminalMatrix L z s
  let B := polynomialDiagonalGaugeInverse L z s * A
  have hleftZero (g : OrientedEdge L) (hg : g ≠ e) :
      polynomialDiagonalGaugeInverse L z s e g * A g f = 0 := by
    calc
      polynomialDiagonalGaugeInverse L z s e g * A g f =
          qbarConst (diagonalGaugeInverse L z s e g) * A g f := rfl
      _ = qbarConst 0 * A g f := by rw [diagonalGaugeInverse, if_neg hg]
      _ = 0 * A g f := by rw [show qbarConst 0 = 0 from Polynomial.C_0]
      _ = 0 := zero_mul _
  have hleft : B e f = qbarConst (diagonalGaugeInverseWeight z s e) * A e f := by
    calc
      B e f = ∑ g, polynomialDiagonalGaugeInverse L z s e g * A g f := rfl
      _ = polynomialDiagonalGaugeInverse L z s e e * A e f :=
        Fintype.sum_eq_single e hleftZero
      _ = qbarConst (diagonalGaugeInverse L z s e e) * A e f := rfl
      _ = qbarConst (diagonalGaugeInverseWeight z s e) * A e f := by
        rw [diagonalGaugeInverse, if_pos rfl]
  have hrightZero (g : OrientedEdge L) (hg : g ≠ f) :
      B e g * polynomialDiagonalGauge L z s g f = 0 := by
    calc
      B e g * polynomialDiagonalGauge L z s g f =
          B e g * qbarConst (diagonalGauge L z s g f) := rfl
      _ = B e g * qbarConst 0 := by rw [diagonalGauge, if_neg (Ne.symm hg)]
      _ = B e g * 0 := by rw [show qbarConst 0 = 0 from Polynomial.C_0]
      _ = 0 := mul_zero _
  have hright : (B * polynomialDiagonalGauge L z s) e f =
      B e f * qbarConst (diagonalGaugeWeight z s f) := by
    calc
      (B * polynomialDiagonalGauge L z s) e f =
          ∑ g, B e g * polynomialDiagonalGauge L z s g f := rfl
      _ = B e f * polynomialDiagonalGauge L z s f f :=
        Fintype.sum_eq_single f hrightZero
      _ = B e f * qbarConst (diagonalGauge L z s f f) := rfl
      _ = B e f * qbarConst (diagonalGaugeWeight z s f) := by
        rw [diagonalGauge, if_pos rfl]
  calc
    gaugedTerminalMatrix L z s e f =
        qbarConst (z ^ (2 : ℕ)) * (B * polynomialDiagonalGauge L z s) e f := rfl
    _ = qbarConst (z ^ (2 : ℕ)) * (B e f * qbarConst (diagonalGaugeWeight z s f)) := by
      rw [hright]
    _ = qbarConst (z ^ (2 : ℕ)) *
        ((qbarConst (diagonalGaugeInverseWeight z s e) * A e f) *
          qbarConst (diagonalGaugeWeight z s f)) := by rw [hleft]
    _ = qbarConst (z ^ (2 : ℕ)) *
        (qbarConst (diagonalGaugeInverseWeight z s e) *
          (A e f * qbarConst (diagonalGaugeWeight z s f))) :=
      congrArg (qbarConst (z ^ (2 : ℕ)) * ·) (mul_assoc _ _ _)
    _ = qbarConst (z ^ (2 : ℕ)) *
        (qbarConst (diagonalGaugeInverseWeight z s e) *
          (qbarConst (diagonalGaugeWeight z s f) * A e f)) :=
      congrArg (fun t => qbarConst (z ^ (2 : ℕ)) *
        (qbarConst (diagonalGaugeInverseWeight z s e) * t)) (mul_comm _ _)
    _ = qbarConst (z ^ (2 : ℕ)) *
        ((qbarConst (diagonalGaugeInverseWeight z s e) *
          qbarConst (diagonalGaugeWeight z s f)) * A e f) :=
      congrArg (qbarConst (z ^ (2 : ℕ)) * ·) (mul_assoc _ _ _).symm
    _ = (qbarConst (z ^ (2 : ℕ)) *
        (qbarConst (diagonalGaugeInverseWeight z s e) *
          qbarConst (diagonalGaugeWeight z s f))) * A e f := (mul_assoc _ _ _).symm
    _ = (qbarConst (z ^ (2 : ℕ)) *
        qbarConst (diagonalGaugeInverseWeight z s e * diagonalGaugeWeight z s f)) * A e f :=
      congrArg (fun t => (qbarConst (z ^ (2 : ℕ)) * t) * A e f) Polynomial.C_mul.symm
    _ = qbarConst (z ^ (2 : ℕ) *
        (diagonalGaugeInverseWeight z s e * diagonalGaugeWeight z s f)) * A e f :=
      congrArg (· * A e f) Polynomial.C_mul.symm
    _ = qbarConst (gaugePairWeight z s e f) * A e f := rfl
    _ = qbarConst (gaugePairWeight z s e f) *
        ((if f = reversal e then 1 else 0) - Polynomial.X *
          (if orientedSource f = orientedSource e ∧ f ≠ e
            then Polynomial.C ((twistSign s f : Qbar) * rotationPhase z (reversal e) f)
            else 0)) := congrArg (qbarConst (gaugePairWeight z s e f) * ·)
              (terminalMatrix_entry L z s e f)

end Ising2DLambda.KacWard
