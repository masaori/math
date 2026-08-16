/-
「倍数辺との平方の差の評価」の具体版が、必要十分版 `sq_le_sq_add_two_mul_of_between_necSuf`
（順序可換半環）の `K := ℕ`、`b := k a` への特殊化として得られることを明示する。
-/
import Ising2DLambda.ThermodynamicLimit.SquareDifferenceFromMultipleSideBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.SquareDifferenceFromMultipleSideBound

namespace Ising2DLambda.ThermodynamicLimit

/-- 具体版の鎖を必要十分版から導く（`K := ℕ`、`b := k a`）。 -/
theorem sq_le_multiple_sq_add_two_mul_nat_from_necSuf (a k L : ℕ) (h1 : k * a ≤ L)
    (h2 : L ≤ k * a + a) : L ^ 2 ≤ (k * a) ^ 2 + 2 * a * L :=
  NecSuf.ThermodynamicLimit.sq_le_sq_add_two_mul_of_between_necSuf
    (Nat.zero_le a) (Nat.zero_le (k * a)) (Nat.zero_le L) h1 h2

/-- 引き算の形も必要十分版から導く。 -/
theorem sq_sub_multiple_sq_le_two_mul_nat_from_necSuf (a k L : ℕ) (h1 : k * a ≤ L)
    (h2 : L ≤ k * a + a) : L ^ 2 - (k * a) ^ 2 ≤ 2 * a * L :=
  Nat.sub_le_iff_le_add.mpr (by
    have := sq_le_multiple_sq_add_two_mul_nat_from_necSuf a k L h1 h2
    omega)

end Ising2DLambda.ThermodynamicLimit
