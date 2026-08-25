import Mathlib
import Ising3DCut.LimitQuantity.PowerMinusOneGcdEqualsPowerOfExponentGcd

/-!
人手証明 `claim_numerator_divides_twice_base_minus_one`（本文
`structured-latex/content/partition-values.ts`）の Lean 具体版。

人手証明は次の並びである。
準備の一段として `gcd(2u,2v)=2gcd(u,v)` を両方向の整除で示す。
つづいて隣り合う二つの箱へ既存の整除を当て、公約数が最大公約数を割ることから
`a ∣ gcd(2(c^m-1), 2(c^n-1))` を得る。
最後に、その最大公約数を三段（二倍の外出し、指数の最大公約数への到達、指数が一）で
`2(c-1)` へ書き換える。

ここでは同じ並びをそのまま書く。箱の大きさに依存する部分は指数 `m,n` の互いに素性として
仮定に入れてあり、結論に指数は現れない。冪の差は整数の上で書き、最大公約数は
`Int.gcd` の値（自然数）で扱う。
-/

namespace Ising3DCut.LimitQuantity

/-- 準備。自然数 `u,v` について `gcd(2u,2v)=2gcd(u,v)`。
人手証明の「両方向の整除で挟む」段にあたる。 -/
theorem gcd_two_mul_eq_two_mul_gcd (u v : ℕ) :
    Nat.gcd (2 * u) (2 * v) = 2 * Nat.gcd u v := by
  refine Nat.dvd_antisymm ?_ ?_
  · -- `2 ∣ gcd(2u,2v)` なので `gcd(2u,2v)=2e` と書け、`e ∣ u` かつ `e ∣ v` が従う。
    obtain ⟨e, he⟩ : 2 ∣ Nat.gcd (2 * u) (2 * v) :=
      Nat.dvd_gcd ⟨u, rfl⟩ ⟨v, rfl⟩
    have hu : e ∣ u := by
      have h2e : 2 * e ∣ 2 * u := he ▸ Nat.gcd_dvd_left (2 * u) (2 * v)
      exact (mul_dvd_mul_iff_left (by norm_num : (2 : ℕ) ≠ 0)).1 h2e
    have hv : e ∣ v := by
      have h2e : 2 * e ∣ 2 * v := he ▸ Nat.gcd_dvd_right (2 * u) (2 * v)
      exact (mul_dvd_mul_iff_left (by norm_num : (2 : ℕ) ≠ 0)).1 h2e
    calc Nat.gcd (2 * u) (2 * v) = 2 * e := he
      _ ∣ 2 * Nat.gcd u v := mul_dvd_mul_left 2 (Nat.dvd_gcd hu hv)
  · -- 逆向き。`gcd(u,v)` は `u` と `v` を割るので `2gcd(u,v)` は `2u` と `2v` を割る。
    exact Nat.dvd_gcd (mul_dvd_mul_left 2 (Nat.gcd_dvd_left u v))
      (mul_dvd_mul_left 2 (Nat.gcd_dvd_right u v))

/-- 準備を整数の側へ移した一段。`Int.gcd` は `natAbs` の最大公約数なので、
二倍を外へ出す等式はそのまま移る。 -/
theorem int_gcd_two_mul_eq_two_mul_gcd (x y : ℤ) :
    (Int.gcd (2 * x) (2 * y) : ℤ) = 2 * (Int.gcd x y : ℤ) := by
  unfold Int.gcd
  have h2 : Int.natAbs 2 = 2 := rfl
  rw [Int.natAbs_mul, Int.natAbs_mul, h2, gcd_two_mul_eq_two_mul_gcd]
  push_cast
  ring

/-- 人手証明と 1 対 1 に対応する主張。互いに素な正の指数 `m,n` について、
`a` が `2(c^m-1)` と `2(c^n-1)` の両方を割るなら、`a` は `2(c-1)` を割る。
結論に指数（箱の大きさ）は現れない。 -/
theorem numerator_divides_twice_base_minus_one
    (a : ℤ) (c : ℤ) (hc : 1 ≤ c) (m n : ℕ) (hm : 0 < m) (hn : 0 < n)
    (hcop : Nat.gcd m n = 1)
    (ham : a ∣ 2 * (c ^ m - 1)) (han : a ∣ 2 * (c ^ n - 1)) :
    a ∣ 2 * (c - 1) := by
  -- 公約数は最大公約数を割る。
  have hgcd : a ∣ (Int.gcd (2 * (c ^ m - 1)) (2 * (c ^ n - 1)) : ℤ) :=
    Int.dvd_coe_gcd ham han
  -- 最大公約数を三段で `2(c-1)` へ書き換える。
  have hchain : (Int.gcd (2 * (c ^ m - 1)) (2 * (c ^ n - 1)) : ℤ) = 2 * (c - 1) := by
    calc (Int.gcd (2 * (c ^ m - 1)) (2 * (c ^ n - 1)) : ℤ)
        = 2 * (Int.gcd (c ^ m - 1) (c ^ n - 1) : ℤ) :=
          int_gcd_two_mul_eq_two_mul_gcd _ _
      _ = 2 * (c ^ Nat.gcd m n - 1) := by
          rw [powerMinusOne_gcd_equals_power_of_exponent_gcd c hc m n hm hn]
      _ = 2 * (c ^ (1 : ℕ) - 1) := by rw [hcop]
      _ = 2 * (c - 1) := by rw [pow_one]
  exact hchain ▸ hgcd

end Ising3DCut.LimitQuantity
