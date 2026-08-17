/-
「正錐の元の自然数倍は零元または正錐の元である」の具体版。
本文と同じく c = 0 と 1 ≤ c で場合分けし、零の場合は零元との積、
正の場合は正の有理数の正錐所属と正錐の乗法閉性を使う。
Q_s への所属は quadraticNatMulElement が Q_s の元として構成されることが担う
（本文の「どちらの場合も c·ξ ∈ Q_s」に対応する）。
-/
import Ising2DLambda.FisherZero.PositiveRationalInPositiveCone
import Ising2DLambda.FisherZero.QuadraticPositiveConeMulClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 自然数 `c` を鎖 ℕ ⊂ ℚ ⊂ Qbar で送って `Q_s` の元として持ち上げ、
    右から `xi` を掛けた積。 -/
noncomputable def quadraticNatMulElement (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s) :
    QuadraticFieldElement s :=
  quadraticMulElement s hs (positiveRationalElement s (c : ℚ)) xi

/-- 上の積は `Qbar` の通常の積と同じ元である（本文の「c·ξ は Qbar の乗法」）。 -/
theorem quadraticNatMulElement_coe (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s) :
    (quadraticNatMulElement s hs c xi : Qbar) =
      algebraMap ℚ Qbar (c : ℚ) * (xi : Qbar) := by
  simp only [quadraticNatMulElement, quadraticMulElement, positiveRationalElement]

/-- `claim_quadratic_positive_cone_nat_mul` の具体版。
    本文の場合分けどおり、c = 0 なら積は Qbar の零元、1 ≤ c なら正錐の元である。 -/
theorem quadraticNatMulElement_zero_or_mem_positiveCone (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (c : ℕ) (xi : QuadraticFieldElement s)
    (hxi : xi ∈ quadraticPositiveCone s) :
    (c = 0 → (quadraticNatMulElement s hs c xi : Qbar) = 0) ∧
      (1 ≤ c → quadraticNatMulElement s hs c xi ∈ quadraticPositiveCone s) := by
  constructor
  · -- 本文の c = 0 の場合: c·ξ = 0·ξ = 0（零元との積）
    intro hc
    subst hc
    rw [quadraticNatMulElement_coe]
    simp
  · -- 本文の 1 ≤ c の場合: c ∈ ℚ_{>0} から c ∈ P_s、正錐の乗法閉性で閉じる
    intro hc
    have hcpos : (0 : ℚ) < (c : ℚ) := by exact_mod_cast hc
    exact quadraticPositiveCone_mul_mem s hs
      (positiveRationalElement s (c : ℚ)) xi
      (positiveRational_mem_positiveCone s hs (c : ℚ) hcpos) hxi

end Ising2DLambda.FisherZero
