/- 「正錐の元の冪は正錐の元である」を必要十分版から導く。 -/
import Ising2DLambda.FisherZero.PositiveConePow
import Ising2DLambda.FisherZero.PositiveRationalInPositiveConeFromNecSuf
import Ising2DLambda.FisherZero.QuadraticPositiveConeMulClosedFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.PositiveConePow

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 二つの再帰の定義が同じ元を与える。 -/
theorem quadraticPowElement_eq_iteratedPower (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (xi : QuadraticFieldElement s) (m : ℕ) :
    quadraticPowElement s hs xi m =
      Ising2DLambda.NecSuf.FisherZero.iteratedPower
        (positiveRationalElement s 1) (quadraticMulElement s hs) xi m := by
  induction m with
  | zero => rfl
  | succ m ih =>
      calc
        quadraticPowElement s hs xi (m + 1) =
            quadraticMulElement s hs (quadraticPowElement s hs xi m) xi := rfl
        _ = quadraticMulElement s hs
            (Ising2DLambda.NecSuf.FisherZero.iteratedPower
              (positiveRationalElement s 1) (quadraticMulElement s hs) xi m) xi :=
          congrArg (fun z => quadraticMulElement s hs z xi) ih
        _ = Ising2DLambda.NecSuf.FisherZero.iteratedPower
            (positiveRationalElement s 1) (quadraticMulElement s hs) xi (m + 1) := rfl

/-- 通常の冪との橋も、独立した必要十分版から導く。 -/
theorem quadraticPowElement_coe_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (xi : QuadraticFieldElement s) (m : ℕ) :
    (quadraticPowElement s hs xi m : Qbar) = (xi : Qbar) ^ m := by
  have hValue := Ising2DLambda.NecSuf.FisherZero.iteratedPower_value_necSuf
    (positiveRationalElement s 1) (quadraticMulElement s hs)
    (fun z : QuadraticFieldElement s => (z : Qbar)) xi
    (1 : Qbar) (fun a b : Qbar => a * b) (fun n => (xi : Qbar) ^ n)
    (map_one (algebraMap ℚ Qbar)) (fun _ _ => rfl)
    (pow_zero (xi : Qbar)) (fun n => pow_succ (xi : Qbar) n) m
  calc
    (quadraticPowElement s hs xi m : Qbar) =
        (Ising2DLambda.NecSuf.FisherZero.iteratedPower
          (X := QuadraticFieldElement s)
          (positiveRationalElement s 1) (quadraticMulElement s hs) xi m : Qbar) :=
      congrArg (fun z : QuadraticFieldElement s => (z : Qbar))
        (quadraticPowElement_eq_iteratedPower s hs xi m)
    _ = (xi : Qbar) ^ m := hValue

theorem quadraticPositiveCone_pow_mem_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) (m : ℕ) :
    quadraticPowElement s hs xi m ∈ quadraticPositiveCone s := by
  have hOneField : (positiveRationalElement s 1 : Qbar) ∈ quadraticFieldSet s :=
    (positiveRationalElement s 1).property
  have hOnePositive : positiveRationalElement s 1 ∈ quadraticPositiveCone s :=
    positiveRational_mem_positiveCone_from_necSuf s hs 1 (by norm_num)
  have hBoth := Ising2DLambda.NecSuf.FisherZero.iteratedPower_mem_necSuf
    (quadraticFieldSet s) (quadraticPositiveCone s)
    (fun z : QuadraticFieldElement s => (z : Qbar))
    (positiveRationalElement s 1) (quadraticMulElement s hs)
    hOneField hOnePositive
    (fun a b ha hb => quadraticMul_mem_from_necSuf s hs ⟨a, ha⟩ ⟨b, hb⟩)
    (fun a b ha hb => quadraticPositiveCone_mul_mem_from_necSuf s hs a b ha hb)
    xi.property hxi m
  exact (quadraticPowElement_eq_iteratedPower s hs xi m).symm ▸ hBoth.2

end Ising2DLambda.FisherZero
