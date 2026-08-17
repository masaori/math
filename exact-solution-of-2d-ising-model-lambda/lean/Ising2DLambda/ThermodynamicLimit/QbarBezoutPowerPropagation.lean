/-
章「熱力学極限」の「Bezout 恒等式は、もう一方の元の冪についても構成できる（帰納法）」
（`claim_qbar_bezout_power_propagation`）の具体版。

  人手証明                                                          このファイル
  n についての帰納法。出発点 n = 0:
    P:=p, Q:=q。P a+Q b^1 = p a+q b^1 = p a+q b = 1                `pow_one`, `hpq`
  一歩: P_{n+1}:=P_n p a+Q_n p b^{n+1}+P_n q b, Q_{n+1}:=Q_n q
        b^{(n+1)+1} = b·b^{n+1}（冪の約束）                        `pow_succ'`
        分配則を二回・可換則・結合則で並べ替え・分配則              `ring`
        (p a+q b)(P_n a+Q_n b^{n+1}) = 1・1 = 1                    `hpq`, `ih`

住処: Q̄（実数体・複素数体は現れない）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

/-- `p*a+q*b=1` ならば、任意の `n` について `P*a+Q*b^(n+1)=1` を満たす `P,Q` が存在する。 -/
theorem qbarBezoutPowerPropagation (a b p q : QbarPoly) (hpq : p * a + q * b = 1) :
    ∀ n : ℕ, ∃ P Q : QbarPoly, P * a + Q * b ^ (n + 1) = 1 := by
  intro n
  induction n with
  | zero =>
    -- 出発点: P:=p, Q:=q。P a+Q b^1 = p a+q b = 1
    refine ⟨p, q, ?_⟩
    calc p * a + q * b ^ (0 + 1) = p * a + q * b ^ 1 := by rw [Nat.zero_add]
      _ = p * a + q * b := by rw [pow_one]
      _ = 1 := hpq
  | succ n ih =>
    obtain ⟨Pn, Qn, hn⟩ := ih
    refine ⟨Pn * p * a + Qn * p * b ^ (n + 1) + Pn * q * b, Qn * q, ?_⟩
    -- b^{(n+1)+1} = b·b^{n+1}
    have hb : b ^ ((n + 1) + 1) = b * b ^ (n + 1) := pow_succ' b (n + 1)
    calc (Pn * p * a + Qn * p * b ^ (n + 1) + Pn * q * b) * a + Qn * q * b ^ ((n + 1) + 1)
        = (Pn * p * a + Qn * p * b ^ (n + 1) + Pn * q * b) * a + Qn * q * (b * b ^ (n + 1)) := by
          rw [hb]
      _ = (p * a + q * b) * (Pn * a + Qn * b ^ (n + 1)) := by ring
      _ = 1 * 1 := by rw [hpq, hn]
      _ = 1 := by ring

end Ising2DLambda.ThermodynamicLimit
