/-
「Bezout 恒等式は、もう一方の元の冪についても構成できる（帰納法）」の必要十分版。

具体版と同じ手順（n についての帰納法。出発点は b^1=b、一歩は b^{(n+1)+1}=b・b^{n+1}
（冪の約束）と分配則・可換則・結合則の並べ替え、帰納法の仮定）。
必要なのは可換環だけである。体・多項式環・代数閉性・Q̄ の元であることは要らない。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

theorem bezout_power_propagation_necSuf {R : Type*} [CommRing R] (a b p q : R)
    (hpq : p * a + q * b = 1) :
    ∀ n : ℕ, ∃ P Q : R, P * a + Q * b ^ (n + 1) = 1 := by
  intro n
  induction n with
  | zero =>
    refine ⟨p, q, ?_⟩
    calc p * a + q * b ^ (0 + 1) = p * a + q * b ^ 1 := by rw [Nat.zero_add]
      _ = p * a + q * b := by rw [pow_one]
      _ = 1 := hpq
  | succ n ih =>
    obtain ⟨Pn, Qn, hn⟩ := ih
    refine ⟨Pn * p * a + Qn * p * b ^ (n + 1) + Pn * q * b, Qn * q, ?_⟩
    have hb : b ^ ((n + 1) + 1) = b * b ^ (n + 1) := pow_succ' b (n + 1)
    calc (Pn * p * a + Qn * p * b ^ (n + 1) + Pn * q * b) * a + Qn * q * b ^ ((n + 1) + 1)
        = (Pn * p * a + Qn * p * b ^ (n + 1) + Pn * q * b) * a + Qn * q * (b * b ^ (n + 1)) := by
          rw [hb]
      _ = (p * a + q * b) * (Pn * a + Qn * b ^ (n + 1)) := by ring
      _ = 1 * 1 := by rw [hpq, hn]
      _ = 1 := by ring

end Ising2DLambda.NecSuf.ThermodynamicLimit
