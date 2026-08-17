/-
「一次因子の冪どうしが互いに素であること（Bezout 恒等式の伝播の二度適用）」の必要十分版。

具体版と同じ手順（`bezout_power_propagation_necSuf` を `n:=m` で一度、
入れ替えた組に `n:=k` でもう一度）。必要なのは可換環だけである。
体・多項式環・代数閉性・Q̄ の元であることは要らない。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarBezoutPowerPropagation
import Mathlib.Tactic.LinearCombination

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

theorem linear_factor_powers_bezout_necSuf {R : Type*} [CommRing R] (a b p q : R)
    (hpq : p * a + q * b = 1) (k m : ℕ) :
    ∃ P Q : R, P * a ^ (k + 1) + Q * b ^ (m + 1) = 1 := by
  obtain ⟨P1, Q1, h1⟩ := bezout_power_propagation_necSuf a b p q hpq m
  have h1' : Q1 * b ^ (m + 1) + P1 * a = 1 := by linear_combination h1
  obtain ⟨P2, Q2, h2⟩ := bezout_power_propagation_necSuf (b ^ (m + 1)) a Q1 P1 h1' k
  refine ⟨Q2, P2, ?_⟩
  linear_combination h2

end Ising2DLambda.NecSuf.ThermodynamicLimit
