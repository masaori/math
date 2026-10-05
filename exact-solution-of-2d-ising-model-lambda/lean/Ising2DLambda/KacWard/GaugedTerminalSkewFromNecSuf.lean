/- 実際の方向・切断線・係数埋込みを、有限表と指数写像による反対称化へ供給する。 -/
import Ising2DLambda.KacWard.GaugedTerminalSkew
import Ising2DLambda.NecSuf.KacWard.GaugedTerminalSkew

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

lemma gaugePhase_specialization (z : Qbar) (a b : ZMod 4) :
    NecSuf.KacWard.gaugePhase (fun n : ℤ => z ^ n) a b = gaugeDirectionPhase z a b := by
  unfold NecSuf.KacWard.gaugePhase gaugeDirectionPhase
  simp only [zpow_zero, zpow_one, zpow_neg_one]

lemma gaugeWeight_specialization {L : ℕ} (z : Qbar) (s : SpinStructure)
    (e f : OrientedEdge L) :
    NecSuf.KacWard.gaugeWeight (fun n : ℤ => z ^ n) (directionNumber e) (directionNumber f)
      (twistParity s e : ℤ) (twistParity s f : ℤ) = gaugePairWeight z s e f := by
  simp only [NecSuf.KacWard.gaugeWeight, gaugePairWeight, diagonalGaugeInverseWeight,
    diagonalGaugeWeight, directionGaugeExponent, twistGaugeExponent,
    directionStandardRepresentative, neg_neg, neg_mul, zpow_natCast, zpow_ofNat]

lemma gaugedTerminalMatrix_eq_kernel (L : ℕ) [NeZero L] (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (e f : OrientedEdge L) :
    gaugedTerminalMatrix L z s e f = NecSuf.KacWard.gaugedKernel
      (fun n : ℤ => z ^ n) qbarConst Polynomial.X reversal directionNumber
      (fun e => (twistParity s e : ℤ))
      (fun e f => orientedSource f = orientedSource e ∧ f ≠ e) e f := by
  rw [gaugedTerminalMatrix_entry]
  unfold NecSuf.KacWard.gaugedKernel
  rw [gaugeWeight_specialization, gaugePhase_specialization]
  rw [← rotationPhase_reversal_eq_directionPhase]
  dsimp only
  rw [← twistSign_cast_eq_zpow z hz]
  rfl

theorem gaugedTerminalMatrix_skew_from_necSuf (L : ℕ) [NeZero L] (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (e f : OrientedEdge L) :
    gaugedTerminalMatrix L z s e f = -gaugedTerminalMatrix L z s f e := by
  have hnz : z ≠ 0 := diagonalGauge_root_ne_zero z hz
  let φ : ℤ → Qbar := fun n => z ^ n
  have hadd (a b : ℤ) : φ (a + b) = φ a * φ b := zpow_add₀ hnz a b
  have hfour : φ 4 = -1 := (zpow_natCast z 4).trans hz
  have hP (e f : OrientedEdge L) :
      (orientedSource f = orientedSource e ∧ f ≠ e) ↔
        (orientedSource e = orientedSource f ∧ e ≠ f) := by
    constructor <;> rintro ⟨hsrc, hne⟩ <;> exact ⟨hsrc.symm, Ne.symm hne⟩
  rw [gaugedTerminalMatrix_eq_kernel L z hz s e f,
    gaugedTerminalMatrix_eq_kernel L z hz s f e]
  exact NecSuf.KacWard.gaugedKernel_skew_necSuf
    (fun _ _ _ => mul_assoc _ _ _) (fun _ => mul_one _) (fun _ => mul_zero _)
    (fun _ _ _ => mul_sub _ _ _) (fun _ _ => mul_neg _ _)
    (fun _ _ => sub_eq_add_neg _ _) (fun _ _ => neg_add _ _)
    φ hadd hfour qbarConst
    Polynomial.C_0 (fun _ _ => Polynomial.C_mul) (fun _ => Polynomial.C_neg)
    Polynomial.X (fun _ => mul_comm _ _) reversal reversal_involutive
    directionNumber directionNumber_reversal (fun e => (twistParity s e : ℤ))
    (fun _ => congrArg (fun n : ℕ => (n : ℤ)) (twistParity_reversal s _))
    (fun e f => orientedSource f = orientedSource e ∧ f ≠ e) hP e f

theorem gaugedTerminalMatrix_diagonal_zero_from_necSuf (L : ℕ) [NeZero L] (z : Qbar)
    (s : SpinStructure) (e : OrientedEdge L) : gaugedTerminalMatrix L z s e e = 0 := by
  rw [gaugedTerminalMatrix_entry]
  exact NecSuf.KacWard.gaugedKernel_diagonal_zero_necSuf
    (fun _ => mul_zero _) (sub_zero (0 : Polynomial Qbar))
    (fun e f => qbarConst (gaugePairWeight z s e f))
    (fun e f => Polynomial.C ((twistSign s f : Qbar) * rotationPhase z (reversal e) f))
    Polynomial.X reversal reversal_ne
    (fun e f => orientedSource f = orientedSource e ∧ f ≠ e)
    (fun _ h => h.2 rfl) e

end Ising2DLambda.KacWard
