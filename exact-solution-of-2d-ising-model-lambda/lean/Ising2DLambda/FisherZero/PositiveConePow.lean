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
      calc
        (quadraticPowElement s hs xi 0 : Qbar) = algebraMap ℚ Qbar 1 := rfl
        _ = (1 : Qbar) := map_one (algebraMap ℚ Qbar)
        _ = (xi : Qbar) ^ 0 := (pow_zero _).symm
  | succ m ih =>
      calc
        (quadraticPowElement s hs xi (m + 1) : Qbar) =
            (quadraticPowElement s hs xi m : Qbar) * (xi : Qbar) := rfl
        _ = (xi : Qbar) ^ m * (xi : Qbar) :=
          congrArg (fun z : Qbar => z * (xi : Qbar)) ih
        _ = (xi : Qbar) ^ (m + 1) := (pow_succ _ _).symm

/-- `claim_quadratic_positive_cone_pow_closed` の具体版。 -/
theorem quadraticPositiveCone_pow_mem (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) (m : ℕ) :
    quadraticPowElement s hs xi m ∈ quadraticPositiveCone s := by
  have hxiField : (xi : Qbar) ∈ quadraticFieldSet s := xi.property
  have hBoth : ∀ n : ℕ,
      (quadraticPowElement s hs xi n : Qbar) ∈ quadraticFieldSet s ∧
      quadraticPowElement s hs xi n ∈ quadraticPositiveCone s := by
    intro n
    induction n with
    | zero =>
        have hOneField : algebraMap ℚ Qbar 1 ∈ quadraticFieldSet s :=
          positiveRational_mem_quadraticFieldSet s 1
        have hOnePositive : positiveRationalElement s 1 ∈ quadraticPositiveCone s :=
          positiveRational_mem_positiveCone s hs 1 (by norm_num)
        have hZero : quadraticPowElement s hs xi 0 = positiveRationalElement s 1 := rfl
        have hZeroField : (quadraticPowElement s hs xi 0 : Qbar) ∈ quadraticFieldSet s :=
          (congrArg (fun z : QuadraticFieldElement s => (z : Qbar)) hZero).symm ▸ hOneField
        have hZeroPositive : quadraticPowElement s hs xi 0 ∈ quadraticPositiveCone s :=
          hZero.symm ▸ hOnePositive
        exact ⟨hZeroField, hZeroPositive⟩
    | succ n ih =>
        have hProductField :
            (quadraticPowElement s hs xi n : Qbar) * (xi : Qbar) ∈ quadraticFieldSet s :=
          quadraticMul_mem s hs ⟨_, ih.1⟩ ⟨_, hxiField⟩
        have hProductPositive :
            quadraticMulElement s hs (quadraticPowElement s hs xi n) xi ∈
              quadraticPositiveCone s :=
          quadraticPositiveCone_mul_mem s hs (quadraticPowElement s hs xi n) xi ih.2 hxi
        have hSucc : quadraticPowElement s hs xi (n + 1) =
            quadraticMulElement s hs (quadraticPowElement s hs xi n) xi := rfl
        have hSuccField : (quadraticPowElement s hs xi (n + 1) : Qbar) ∈
            quadraticFieldSet s :=
          (congrArg (fun z : QuadraticFieldElement s => (z : Qbar)) hSucc).symm ▸ hProductField
        have hSuccPositive : quadraticPowElement s hs xi (n + 1) ∈ quadraticPositiveCone s :=
          hSucc.symm ▸ hProductPositive
        exact ⟨hSuccField, hSuccPositive⟩
  exact (hBoth m).2

end Ising2DLambda.FisherZero
