/-
「回文性で対称化した素指数データは逆数で不変である」
（`claim_symmetrized_prime_exponent_data_is_reciprocal_invariant`）の Lean 具体版・第三歩。

人手証明の第三歩「定義に代入して Λ の加法で整理する」に対応する。素指数データ λ は各素数ごとに
整数値（p 進付値）を返すので、Λ の等式は各素数についての整数の等式である。ここでは
第二の等式 λ(Z_L(q)) = #E_L λ(q) + λ(Z_L(1/q)) と λ(1/q) = -λ(q)（`padicValRat.inv`）だけを仮定に取り、
σ_L(q) := 2 λ(Z_L(q)) - #E_L λ(q) が σ_L(1/q) と一致することを整数の加法で示す。
第一・第二歩（回文性の代入と付値の乗法性）は次の tick で足す。
-/
import Mathlib.NumberTheory.Padics.PadicVal.Basic

namespace Ising3DCut.LimitQuantity

/-- 第三歩の整数算術の骨格。`a = e*b + c` かつ `b' = -b` なら `2a - e b = 2c - e b'`。 -/
theorem symmetrized_eq_of_palindrome_step {a b b' c e : ℤ}
    (h : a = e * b + c) (hb : b' = -b) :
    2 * a - e * b = 2 * c - e * b' := by
  subst h; subst hb; ring

/-- 第三歩。各素数 `p` で `padicValRat p (Zq) = E * padicValRat p q + padicValRat p (Zq')`
（`Zq'` は `Z_L(1/q)` の値）なら、対称化した量は `q` と `1/q` で一致する。 -/
theorem symmetrized_padicValRat_reciprocal_invariant
    {p E : ℕ} [Fact p.Prime] {q Zq Zq' : ℚ}
    (h : padicValRat p Zq = (E : ℤ) * padicValRat p q + padicValRat p Zq') :
    2 * padicValRat p Zq - (E : ℤ) * padicValRat p q =
      2 * padicValRat p Zq' - (E : ℤ) * padicValRat p q⁻¹ := by
  exact symmetrized_eq_of_palindrome_step h (padicValRat.inv (p := p) q)

end Ising3DCut.LimitQuantity
