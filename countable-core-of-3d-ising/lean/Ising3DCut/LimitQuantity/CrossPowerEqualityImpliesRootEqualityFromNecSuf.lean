/-
「交差べき等式は乗根の一致を決める」の Lean 必要十分版からの導出。

具体版で正の実数を使う理由は、対象の二つの正の乗根について正の自然数乗が
単射になることを供給するためだけである。その局所的な単射性を抽象版へ渡し、
本文と同じ六段の計算は抽象版に一度だけ担わせる。極限は使わない。
-/
import Ising3DCut.LimitQuantity.CrossPowerEqualityImpliesRootEquality
import Ising3DCut.NecSuf.CrossPowerEqualityAbstract

namespace Ising3DCut.LimitQuantity

/-- 具体版は、対象の二つの正の実数における累乗の単射性を
必要十分版へ渡す特殊化として導出できる。 -/
theorem cross_power_equality_implies_posRoot_equality_fromNecSuf
    (A B : ℝ) (hA : 0 < A) (hB : 0 < B)
    (N M : ℕ) (hN : N ≠ 0) (hM : M ≠ 0)
    (hcross : A ^ M = B ^ N) :
    posRoot A N = posRoot B M := by
  apply NecSuf.cross_power_equality_implies_root_equality_abstract
      (posRoot A N) (posRoot B M) A B N M
      (posRoot_pow A hA N hN) (posRoot_pow B hB M hM) hcross
  intro hpowers
  exact (pow_left_inj₀
    (posRoot_pos A hA N).le
    (posRoot_pos B hB M).le
    (Nat.mul_ne_zero hN hM)).1 hpowers

end Ising3DCut.LimitQuantity
