/- 「正錐の元の自然数倍は零元または正錐の元である」を必要十分版から導く。
   具体側の仕事は、零の添字での積が Q_s の零元になること、
   正の添字の元が正錐に属すること、正錐の乗法閉性の三つの供給だけである。 -/
import Ising2DLambda.FisherZero.PositiveConeNatMul
import Ising2DLambda.NecSuf.FisherZero.PositiveConeNatMul

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticNatMulElement_zero_or_mem_positiveCone_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) :
    (c = 0 → (quadraticNatMulElement s hs c xi : Qbar) = 0) ∧
      (1 ≤ c → quadraticNatMulElement s hs c xi ∈ quadraticPositiveCone s) := by
  have h := Ising2DLambda.NecSuf.FisherZero.natIndexed_mul_zero_or_mem_necSuf
    (quadraticPositiveCone s) (quadraticMulElement s hs)
    (fun n : ℕ => positiveRationalElement s (n : ℚ))
    (positiveRationalElement s 0)
    (fun x => by
      apply Subtype.ext
      simp [quadraticMulElement, positiveRationalElement])
    (fun n hn => positiveRational_mem_positiveCone s hs (n : ℚ)
      (by exact_mod_cast hn))
    (fun a b ha hb => quadraticPositiveCone_mul_mem s hs a b ha hb)
    c hxi
  refine ⟨fun hc => ?_, h.2⟩
  have hz := h.1 hc
  have : (quadraticNatMulElement s hs c xi : Qbar) =
      (positiveRationalElement s 0 : Qbar) := congrArg Subtype.val hz
  rw [this]
  simp [positiveRationalElement]

end Ising2DLambda.FisherZero
