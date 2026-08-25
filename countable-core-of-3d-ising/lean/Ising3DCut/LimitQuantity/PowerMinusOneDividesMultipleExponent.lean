import Mathlib

/-!
人手証明 `claim_power_minus_one_divides_multiple_exponent`（本文
`structured-latex/content/partition-values.ts`）の Lean 具体版。

人手証明は自然数 `k` についての帰納法ひとつで閉じており、次の四段からなる。
基底での証人の取り方、指数の加法と同じ底の冪の積、帰納段の分解、証人の更新である。
ここでは同じ四段を別々の定理として並べ、最後に帰納法で束ねる。
`c ^ n - 1` と `c ^ (n * k) - 1` はいずれも自然数だが、整除性の主張なので
差が素直に取れる整数の上で書く（人手証明の「主張は ℤ の整除性だけからなる」に対応）。
-/

namespace Ising3DCut.LimitQuantity

/-- 帰納法の基底。指数を `0` 倍した冪から `1` を引いた数は `0` であり、証人は `0` で取れる。 -/
theorem powerMinusOne_witness_zero (c : ℤ) (n : ℕ) :
    c ^ (n * 0) - 1 = (c ^ n - 1) * 0 := by
  simp

/-- 指数の加法。`n * (k + 1)` を `n * k + n` へ書き換え、同じ底の冪の積へ分ける段。 -/
theorem powerMinusOne_exponent_succ (c : ℤ) (n k : ℕ) :
    c ^ (n * (k + 1)) = c ^ (n * k) * c ^ n := by
  rw [Nat.mul_succ, pow_add]

/-- 帰納段の分解。人手証明の
`c^{n(k+1)}-1 = c^{nk}(c^n-1) + (c^{nk}-1)` にあたる一行。 -/
theorem powerMinusOne_succ_decompose (c : ℤ) (n k : ℕ) :
    c ^ (n * (k + 1)) - 1 = c ^ (n * k) * (c ^ n - 1) + (c ^ (n * k) - 1) := by
  rw [powerMinusOne_exponent_succ c n k]
  ring

/-- 証人の更新。`t_k` から `t_{k+1} := c^{nk} + t_k` を作る段。 -/
theorem powerMinusOne_witness_succ (c : ℤ) (n k : ℕ) (t : ℤ)
    (h : c ^ (n * k) - 1 = (c ^ n - 1) * t) :
    c ^ (n * (k + 1)) - 1 = (c ^ n - 1) * (c ^ (n * k) + t) := by
  rw [powerMinusOne_succ_decompose c n k, h]
  ring

/-- 人手証明と 1 対 1 に対応する主張。証人の存在を `k` についての帰納法で示す。 -/
theorem exists_witness_powerMinusOne_dvd_multiple_exponent (c : ℤ) (n k : ℕ) :
    ∃ t : ℤ, c ^ (n * k) - 1 = (c ^ n - 1) * t := by
  induction k with
  | zero => exact ⟨0, powerMinusOne_witness_zero c n⟩
  | succ k ih =>
      obtain ⟨t, ht⟩ := ih
      exact ⟨c ^ (n * k) + t, powerMinusOne_witness_succ c n k t ht⟩

/-- 底の冪から `1` を引いた数は、指数を自然数倍した冪から `1` を引いた数を割る。 -/
theorem powerMinusOne_dvd_multiple_exponent (c : ℤ) (n k : ℕ) :
    (c ^ n - 1) ∣ (c ^ (n * k) - 1) :=
  (exists_witness_powerMinusOne_dvd_multiple_exponent c n k).imp fun _ h => h

end Ising3DCut.LimitQuantity
