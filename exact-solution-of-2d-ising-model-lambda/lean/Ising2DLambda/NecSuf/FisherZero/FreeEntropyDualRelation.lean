/-
「分配多項式の値の双対分解」と「双対な点どうしの自由エントロピーの関係」の必要十分版。
前者に必要なのは可換半環での等式の推移・冪の指数法則・分配則、後者に必要なのは
加法可換群での等式の推移だけである。
-/
import Mathlib.Algebra.Ring.Defs

namespace Ising2DLambda.NecSuf.FisherZero

theorem partition_value_dual_factorization_necSuf
    {R : Type*} [CommSemiring R]
    (n m : ℕ) (z gTrivial g00 g01 g10 g11 h00 h01 h10 h11 common : R)
    (hLow : z = 2 * gTrivial)
    (hMixed : 2 ^ (n + 1) * gTrivial = h00 + h01 + h10 + h11)
    (h00Dual : h00 = common ^ m * g00)
    (h01Dual : h01 = common ^ m * g01)
    (h10Dual : h10 = common ^ m * g10)
    (h11Dual : h11 = common ^ m * g11) :
    2 ^ n * z = common ^ m * (g00 + g01 + g10 + g11) := by
  calc
    2 ^ n * z = 2 ^ n * (2 * gTrivial) := by rw [hLow]
    _ = (2 ^ n * 2) * gTrivial := by rw [mul_assoc]
    _ = 2 ^ (n + 1) * gTrivial := by rw [pow_succ]
    _ = h00 + h01 + h10 + h11 := hMixed
    _ = common ^ m * g00 + common ^ m * g01 +
          common ^ m * g10 + common ^ m * g11 := by
      rw [h00Dual, h01Dual, h10Dual, h11Dual]
    _ = common ^ m * (g00 + g01 + g10 + g11) := by
      simp only [mul_add]

theorem free_entropy_dual_relation_necSuf
    {A : Type*} [AddCommGroup A]
    (n m : ℕ) (ellTwo phi logTwo logZ logTwoPow logLeft logRight
      logCommonPow logCommon logS : A)
    (hPhi : phi = logZ)
    (hTwo : ellTwo = logTwo)
    (hTwoPow : n • logTwo = logTwoPow)
    (hLeftMul : logTwoPow + logZ = logLeft)
    (hFactor : logLeft = logRight)
    (hRightMul : logRight = logCommonPow + logS)
    (hCommonPow : logCommonPow = m • logCommon) :
    n • ellTwo + phi = m • logCommon + logS := by
  calc
    n • ellTwo + phi = n • logTwo + logZ := by rw [hPhi, hTwo]
    _ = logTwoPow + logZ := by rw [hTwoPow]
    _ = logLeft := hLeftMul
    _ = logRight := hFactor
    _ = logCommonPow + logS := hRightMul
    _ = m • logCommon + logS := by rw [hCommonPow]

end Ising2DLambda.NecSuf.FisherZero
