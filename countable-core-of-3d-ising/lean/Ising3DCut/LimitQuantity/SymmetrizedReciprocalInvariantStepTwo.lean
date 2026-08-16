/-
「回文性で対称化した素指数データは逆数で不変である」
（`claim_symmetrized_prime_exponent_data_is_reciprocal_invariant`）の Lean 具体版・第二歩。

人手証明の第二歩「付値の乗法性」に対応する。第一歩で得る値の等式 Z_L(q) = q^{#E_L} · Z_L(1/q)
（両辺は正の有理数）から、各素数 p について
  padicValRat p (Z_L(q)) = #E_L · padicValRat p q + padicValRat p (Z_L(1/q))
を、積の付値は付値の和（`padicValRat.mul`）と冪の付値は付値の整数倍（`padicValRat.pow`）だけで示す。
第一歩（回文性の X=q 代入）と第四（q≠1 なら値が異なる）は次の tick で足す。
-/
import Mathlib.NumberTheory.Padics.PadicVal.Basic

namespace Ising3DCut.LimitQuantity

/-- 第二歩。`Zq = q ^ E * Zq'`、`q ≠ 0`、`Zq' ≠ 0` なら、各素数 `p` で
`padicValRat p Zq = E * padicValRat p q + padicValRat p Zq'`。 -/
theorem padicValRat_of_pow_mul {p E : ℕ} [Fact p.Prime] {q Zq Zq' : ℚ}
    (hq : q ≠ 0) (hZq' : Zq' ≠ 0) (h : Zq = q ^ E * Zq') :
    padicValRat p Zq = (E : ℤ) * padicValRat p q + padicValRat p Zq' := by
  subst h
  rw [padicValRat.mul (pow_ne_zero E hq) hZq', padicValRat.pow q (p := p)]

end Ising3DCut.LimitQuantity
