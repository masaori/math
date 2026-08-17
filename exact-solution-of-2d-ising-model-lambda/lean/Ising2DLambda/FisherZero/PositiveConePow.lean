/-
「正錐の元の冪は正錐の元である」の具体版。
本文と同じく自然数について帰納し、出発点では 1 の正値性、一歩では
二次体の台集合と正錐が積で閉じることを使う。
-/
import Ising2DLambda.FisherZero.PositiveRationalInPositiveCone
import Ising2DLambda.FisherZero.QuadraticPositiveConeMulClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `Q_s` の中で、右から `xi` を掛けて作る自然数冪。 -/
noncomputable def quadraticPowElement (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (xi : QuadraticFieldElement s) :
    ℕ → QuadraticFieldElement s
  | 0 => positiveRationalElement s 1
  | m + 1 => quadraticMulElement s hs (quadraticPowElement s hs xi m) xi

/-- 上の `Q_s` 内の冪は、`Qbar` の通常の冪と同じ元である。 -/
theorem quadraticPowElement_coe (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (xi : QuadraticFieldElement s) (m : ℕ) :
    (quadraticPowElement s hs xi m : Qbar) = (xi : Qbar) ^ m := by
  induction m with
  | zero =>
      simp [quadraticPowElement, positiveRationalElement]
  | succ m ih =>
      simp only [quadraticPowElement, quadraticMulElement, pow_succ]
      exact congrArg (fun z : Qbar => z * (xi : Qbar)) ih

/-- `claim_quadratic_positive_cone_pow_closed` の具体版。 -/
theorem quadraticPositiveCone_pow_mem (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) (m : ℕ) :
    quadraticPowElement s hs xi m ∈ quadraticPositiveCone s := by
  induction m with
  | zero =>
      exact positiveRational_mem_positiveCone s hs 1 (by norm_num)
  | succ m ih =>
      exact quadraticPositiveCone_mul_mem s hs (quadraticPowElement s hs xi m) xi ih hxi

end Ising2DLambda.FisherZero
