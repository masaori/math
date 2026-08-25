import Mathlib
import Ising3DCut.LimitQuantity.PowerMinusOneGcdReachesExponentGcd

/-!
人手証明 `claim_power_minus_one_gcd_equals_power_of_exponent_gcd`（本文
`structured-latex/content/partition-values.ts`）の Lean 具体版。

人手証明は、準備の一段（`gcd(a,a)=a` を両方向の整除から示す）と、
直前に閉じた到達形の主張へそれを当てる三段の式変形からなる。
ここでは同じ並びで、準備を両方向の整除として書き、本体を同じ三段として書く。
到達形は `PowerMinusOneGcdReachesExponentGcd.lean` の定理をそのまま引く。
冪の差は整数の上で書き、最大公約数は `Int.gcd` の値（自然数）で扱うので、
主張は `Int.gcd` の値を整数へ移した等式として述べる。
-/

namespace Ising3DCut.LimitQuantity

/-- 準備。自然数 `a` について `gcd(a,a)=a`。
人手証明の「`a ∣ gcd(a,a)` と `gcd(a,a) ∣ a` の両方向の整除」にあたる段。 -/
theorem gcd_self_eq_of_dvd_antisymm (a : ℕ) : Nat.gcd a a = a :=
  Nat.dvd_antisymm (Nat.gcd_dvd_left a a) (Nat.dvd_gcd dvd_rfl dvd_rfl)

/-- 準備。整数 `a` が非負のとき `Int.gcd a a` を整数へ移すと `a` に戻る。
上の自然数の段を `Int.gcd` の定義（`natAbs` の最大公約数）へ当てただけの一段である。 -/
theorem int_gcd_self_eq_of_nonneg (a : ℤ) (ha : 0 ≤ a) : (Int.gcd a a : ℤ) = a := by
  unfold Int.gcd
  rw [gcd_self_eq_of_dvd_antisymm a.natAbs]
  exact Int.natAbs_of_nonneg ha

/-- 人手証明と 1 対 1 に対応する主張。冪から一を引いた二つの数の最大公約数は、
指数の最大公約数の冪から一を引いた数に等しい。 -/
theorem powerMinusOne_gcd_equals_power_of_exponent_gcd
    (c : ℤ) (hc : 1 ≤ c) (m n : ℕ) (hm : 0 < m) (hn : 0 < n) :
    (Int.gcd (c ^ m - 1) (c ^ n - 1) : ℤ) = c ^ Nat.gcd m n - 1 := by
  -- 右辺が非負であること。`g := gcd m n` は正の自然数であり `1 ≤ c` から `1 ≤ c ^ g`。
  have hnonneg : (0 : ℤ) ≤ c ^ Nat.gcd m n - 1 := by
    have : (1 : ℤ) ≤ c ^ Nat.gcd m n := one_le_pow₀ hc
    linarith
  calc (Int.gcd (c ^ m - 1) (c ^ n - 1) : ℤ)
      = (Int.gcd (c ^ Nat.gcd m n - 1) (c ^ Nat.gcd m n - 1) : ℤ) := by
        rw [powerMinusOne_gcd_reaches_exponent_gcd c m n hm hn]
    _ = c ^ Nat.gcd m n - 1 := int_gcd_self_eq_of_nonneg _ hnonneg

end Ising3DCut.LimitQuantity
