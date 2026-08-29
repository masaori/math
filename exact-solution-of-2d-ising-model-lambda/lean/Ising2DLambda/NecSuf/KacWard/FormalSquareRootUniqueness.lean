/-
必要十分版: 零因子を持たない可換環上で、2 が零でなければ、定数項 1 の形式的平方根は一意である。

人手証明と同じ手順を使う。
  S² = T² から (S - T)(S + T) = 0
  零積性により S - T = 0 または S + T = 0
  後者は定数項を取ると 2 = 0 となり仮定に反する

使う構造は可換環、零積性、2 ≠ 0 だけである。体・順序・代数閉性は使わない。
-/
import Mathlib.RingTheory.PowerSeries.NoZeroDivisors

namespace Ising2DLambda.NecSuf.KacWard

open PowerSeries

/-- 定数項 1 の形式的平方根は一意である。 -/
theorem formalSquareRoot_unique_necSuf {R : Type} [CommRing R] [NoZeroDivisors R]
    (hTwo : (2 : R) ≠ 0) (D S T : PowerSeries R)
    (hS0 : constantCoeff S = 1) (hT0 : constantCoeff T = 1)
    (hSsq : S * S = D) (hTsq : T * T = D) : S = T := by
  have hprod : (S - T) * (S + T) = 0 := by
    calc
      (S - T) * (S + T) = S * S - T * T := by ring
      _ = D - D := by rw [hSsq, hTsq]
      _ = 0 := sub_self D
  rcases mul_eq_zero.mp hprod with hdiff | hsum
  · exact sub_eq_zero.mp hdiff
  · have hconst := congrArg constantCoeff hsum
    simp [hS0, hT0] at hconst
    exact absurd (by simpa [one_add_one_eq_two] using hconst) hTwo

end Ising2DLambda.NecSuf.KacWard
