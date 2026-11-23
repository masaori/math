/-
章「道具: 可算な代数の足場」の「定数項一の形式的平方根は一意である」
（`claim_formal_square_root_unique`。本文から参照用ノートへ退避した主張）の具体版。

人手証明と同じ因数分解と零積性を使う。住処は Qbar[[X]] であり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization
import Mathlib.RingTheory.PowerSeries.NoZeroDivisors

namespace Ising2DLambda.KacWard

open PowerSeries Ising2DLambda.AlgebraicEigenvalue

/-- Qbar[[X]] で定数項 1 の形式的平方根は一意である。 -/
theorem formalSquareRoot_unique (D S T : PowerSeries Qbar)
    (hS0 : constantCoeff S = 1) (hT0 : constantCoeff T = 1)
    (hSsq : S * S = D) (hTsq : T * T = D) : S = T := by
  -- 人手証明: (S − T)(S + T) = S² − T² = D − D = 0
  have hprod : (S - T) * (S + T) = 0 := by
    calc
      (S - T) * (S + T) = S * S - T * T := by ring
      _ = D - D := by rw [hSsq, hTsq]
      _ = 0 := sub_self D
  -- 人手証明: Qbar[[X]] は零因子を持たないので S − T = 0 または S + T = 0
  rcases mul_eq_zero.mp hprod with hdiff | hsum
  · exact sub_eq_zero.mp hdiff
  · -- 人手証明: 後者なら定数項を取って 1 + 1 = 0、すなわち Qbar で 2 = 0 となり矛盾
    have hconst := congrArg constantCoeff hsum
    rw [map_add, hS0, hT0, map_zero, one_add_one_eq_two] at hconst
    exact absurd hconst (by norm_num : (2 : Qbar) ≠ 0)

end Ising2DLambda.KacWard
