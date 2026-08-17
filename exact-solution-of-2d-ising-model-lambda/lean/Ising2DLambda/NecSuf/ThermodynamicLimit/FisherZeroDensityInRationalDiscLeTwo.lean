/-
「有理円板内の格子点数あたりの Fisher 零点数は 2 を超えない」
（`claim_fisher_zero_density_in_rational_disc_le_two`）の必要十分版。

具体版と同じ手順（一続き四段）で進む:
  a / d ≤ b / d（仮定 `hab : a ≤ b` を正の分母 d で割る）
  b / d ≤ (2 d) / d（仮定 `hb : b ≤ 2 d` を正の分母 d で割る）
  (2 d) / d = 2（d ≠ 0 による約分）
具体版では a = N_L、b = |F_L|、d = L^2。

必要な構造は「正の元で割っても不等号が保たれること」と「約分」であり、
順序体（`Field`＋線型順序＋順序と環構造の両立）で述べる。ℚ であることは使わない。
-/
import Mathlib.Algebra.Order.Field.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 必要十分版: 順序体で `a ≤ b`、`b ≤ 2 d`、`0 < d` なら `a / d ≤ 2`。 -/
theorem div_le_two_of_le_of_le_two_mul_necSuf
    {K : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K]
    (a b d : K) (hd : 0 < d) (hab : a ≤ b) (hb : b ≤ 2 * d) :
    a / d ≤ 2 := by
  calc a / d
      ≤ b / d := div_le_div_of_nonneg_right hab hd.le
    _ ≤ (2 * d) / d := div_le_div_of_nonneg_right hb hd.le
    _ = 2 := mul_div_cancel_right₀ (2 : K) hd.ne'

end Ising2DLambda.NecSuf.ThermodynamicLimit
