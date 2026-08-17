/- 「正錐の元の冪は正錐の元である」を必要十分版から導く。 -/
import Ising2DLambda.FisherZero.PositiveConePow
import Ising2DLambda.NecSuf.FisherZero.PositiveConePow

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositiveCone_pow_mem_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) (m : ℕ) :
    quadraticPowElement s hs xi m ∈ quadraticPositiveCone s := by
  have hEq : quadraticPowElement s hs xi m =
      Ising2DLambda.NecSuf.FisherZero.iteratedPower
        (positiveRationalElement s 1) (quadraticMulElement s hs) xi m := by
    induction m with
    | zero => rfl
    | succ m ih =>
        simp only [quadraticPowElement,
          Ising2DLambda.NecSuf.FisherZero.iteratedPower, ih]
  rw [hEq]
  apply Ising2DLambda.NecSuf.FisherZero.iteratedPower_mem_necSuf
  · exact positiveRational_mem_positiveCone s hs 1 (by norm_num)
  · intro a b ha hb
    exact quadraticPositiveCone_mul_mem s hs a b ha hb
  · exact hxi

end Ising2DLambda.FisherZero
