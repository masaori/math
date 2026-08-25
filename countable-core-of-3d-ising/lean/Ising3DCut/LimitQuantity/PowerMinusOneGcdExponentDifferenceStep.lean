import Mathlib

/-!
人手証明 `claim_power_minus_one_gcd_exponent_difference_step`（本文
`structured-latex/content/partition-values.ts`）の Lean 具体版。

人手証明は次の四段からなる。冪差の分解
`c^m-1 = c^{m-n}(c^n-1) + (c^{m-n}-1)`、還元前の最大公約数が還元後の最大公約数を割ること、
還元後の最大公約数が還元前の最大公約数を割ること、互いに割り合う自然数の一致である。
ここでは同じ四段を別々の定理として並べ、最後に等式へ束ねる。
差を素直に取るため冪は整数の上で書き、最大公約数は `Int.gcd` の値（自然数）で扱う。
人手証明の `m>n` は、`m=(m-n)+n` を経由するので指数を `d+n` と `n` の形で書く。
-/

namespace Ising3DCut.LimitQuantity

/-- 冪差の分解。人手証明の
`c^{(m-n)+n}-1 = c^{m-n}(c^n-1) + (c^{m-n}-1)` にあたる一行。 -/
theorem powerMinusOne_gcd_decompose (c : ℤ) (d n : ℕ) :
    c ^ (d + n) - 1 = c ^ d * (c ^ n - 1) + (c ^ d - 1) := by
  rw [pow_add]
  ring

/-- 還元前の最大公約数は、指数の差の冪差を割る。人手証明の
`d ∣ (c^m-1) - q(c^n-1) = c^{m-n}-1` にあたる段。 -/
theorem powerMinusOne_gcd_dvd_difference_power (c : ℤ) (d n : ℕ) :
    ((Int.gcd (c ^ (d + n) - 1) (c ^ n - 1) : ℕ) : ℤ) ∣ c ^ d - 1 := by
  have h₁ : ((Int.gcd (c ^ (d + n) - 1) (c ^ n - 1) : ℕ) : ℤ) ∣ c ^ (d + n) - 1 :=
    Int.gcd_dvd_left _ _
  have h₂ : ((Int.gcd (c ^ (d + n) - 1) (c ^ n - 1) : ℕ) : ℤ) ∣ c ^ n - 1 :=
    Int.gcd_dvd_right _ _
  have h₃ : ((Int.gcd (c ^ (d + n) - 1) (c ^ n - 1) : ℕ) : ℤ) ∣ c ^ d * (c ^ n - 1) :=
    Dvd.dvd.mul_left h₂ _
  have h₄ :
      c ^ d - 1 = (c ^ (d + n) - 1) - c ^ d * (c ^ n - 1) := by
    rw [powerMinusOne_gcd_decompose c d n]; ring
  rw [h₄]
  exact dvd_sub h₁ h₃

/-- 還元前の最大公約数は還元後の最大公約数を割る。 -/
theorem powerMinusOne_gcd_dvd_reduced (c : ℤ) (d n : ℕ) :
    Int.gcd (c ^ (d + n) - 1) (c ^ n - 1) ∣ Int.gcd (c ^ d - 1) (c ^ n - 1) :=
  Int.dvd_gcd (powerMinusOne_gcd_dvd_difference_power c d n) (Int.gcd_dvd_right _ _)

/-- 還元後の最大公約数は還元前の最大公約数を割る。人手証明の
`e ∣ q(c^n-1) + (c^{m-n}-1) = c^m-1` にあたる段。 -/
theorem powerMinusOne_gcd_reduced_dvd (c : ℤ) (d n : ℕ) :
    Int.gcd (c ^ d - 1) (c ^ n - 1) ∣ Int.gcd (c ^ (d + n) - 1) (c ^ n - 1) := by
  have h₁ : ((Int.gcd (c ^ d - 1) (c ^ n - 1) : ℕ) : ℤ) ∣ c ^ d - 1 := Int.gcd_dvd_left _ _
  have h₂ : ((Int.gcd (c ^ d - 1) (c ^ n - 1) : ℕ) : ℤ) ∣ c ^ n - 1 := Int.gcd_dvd_right _ _
  have h₃ : ((Int.gcd (c ^ d - 1) (c ^ n - 1) : ℕ) : ℤ) ∣ c ^ d * (c ^ n - 1) :=
    Dvd.dvd.mul_left h₂ _
  have h₄ : ((Int.gcd (c ^ d - 1) (c ^ n - 1) : ℕ) : ℤ) ∣ c ^ (d + n) - 1 := by
    rw [powerMinusOne_gcd_decompose c d n]
    exact dvd_add h₃ h₁
  exact Int.dvd_gcd h₄ h₂

/-- 人手証明と 1 対 1 に対応する主張。互いに割り合う自然数は一致する。 -/
theorem powerMinusOne_gcd_exponent_difference_step (c : ℤ) (d n : ℕ) :
    Int.gcd (c ^ (d + n) - 1) (c ^ n - 1) = Int.gcd (c ^ d - 1) (c ^ n - 1) :=
  Nat.dvd_antisymm (powerMinusOne_gcd_dvd_reduced c d n)
    (powerMinusOne_gcd_reduced_dvd c d n)

/-- 指数の差の形で書き直した版。`m > n` のとき `m = (m-n)+n` である。 -/
theorem powerMinusOne_gcd_exponent_difference_step_of_lt (c : ℤ) (m n : ℕ) (h : n < m) :
    Int.gcd (c ^ m - 1) (c ^ n - 1) = Int.gcd (c ^ (m - n) - 1) (c ^ n - 1) := by
  have hm : m - n + n = m := Nat.sub_add_cancel (le_of_lt h)
  have := powerMinusOne_gcd_exponent_difference_step c (m - n) n
  rw [hm] at this
  exact this

end Ising3DCut.LimitQuantity
