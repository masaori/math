/-
「実閉部分体と虚数単位」の帰結 ω⁴ = 1 の必要十分版。

この三段の計算に必要なのは可換環の乗法と ω² = -1 だけである。部分体、平方の三分法、
一意表示、代数閉性、順序は要求しない。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

/-- 可換環で平方が -1 の元は四乗すると 1 になる。 -/
theorem omega_pow_four_of_square_neg_one_necSuf
    {K : Type} [CommRing K] (omega : K) (homega : omega * omega = -1) :
    omega ^ 4 = 1 := by
  calc
    omega ^ 4 = (omega * omega) * (omega * omega) := by ring
    _ = (-1) * (-1) := by rw [homega]
    _ = 1 := by ring

end Ising2DLambda.NecSuf.FisherZero
