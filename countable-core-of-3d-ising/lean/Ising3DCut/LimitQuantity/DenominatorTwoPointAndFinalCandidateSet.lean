/-
人手証明「分母 2 の有理点と整数の有理点を合わせた候補は三つに限られる」
（ラベル `claim_denominator_two_point_and_final_candidate_set`）の Lean 具体版。

分母 2 側の有限和の分離、両辺から一を引いて二倍する等式、奇数の分子が
2 の有限冪を割ることから分子が一に定まる段を、人手証明と同じ順で置く。
扱うのは有限和・自然数冪・整数の整除だけである。
-/
import Mathlib

namespace Ising3DCut.LimitQuantity

/-- 分母を払った有限和のうち、定数項以外から分子 `a` をくくり出した商。 -/
def denominatorTwoTailSum (Omega : ℕ → ℕ) (a E : ℕ) : ℕ :=
  ∑ m ∈ Finset.range E, Omega (m + 1) * a ^ m * 2 ^ (E - (m + 1))

/-- 分母を払った分配多項式の有限和は、定数項と分子 `a` の倍数へ分かれる。 -/
theorem denominatorTwo_scaled_partition_sum_split (Omega : ℕ → ℕ) (a E : ℕ) :
    (∑ m ∈ Finset.range (E + 1), Omega m * a ^ m * 2 ^ (E - m))
      = 2 ^ E * Omega 0 + a * denominatorTwoTailSum Omega a E := by
  rw [Finset.sum_range_succ']
  simp only [pow_zero, mul_one, Nat.sub_zero]
  rw [Nat.add_comm]
  rw [Nat.mul_comm (Omega 0)]
  unfold denominatorTwoTailSum
  rw [Finset.mul_sum]
  congr 1
  apply Finset.sum_congr rfl
  intro m _
  ring

/-- 分母を払った等式の両辺から `2^E` を引いて二倍する段。 -/
theorem denominatorTwo_scaled_difference_identity
    {a S omega w : ℤ} {E : ℕ}
    (h : (2 : ℤ) ^ E * w = (2 : ℤ) ^ E * omega + a * S) :
    (2 : ℤ) ^ (E + 1) * (w - 1)
      = (2 : ℤ) ^ (E + 1) * (omega - 1) + 2 * a * S := by
  calc
    (2 : ℤ) ^ (E + 1) * (w - 1)
        = 2 * ((2 : ℤ) ^ E * w - (2 : ℤ) ^ E) := by ring
    _ = 2 * ((2 : ℤ) ^ E * omega + a * S - (2 : ℤ) ^ E) := by rw [h]
    _ = (2 : ℤ) ^ (E + 1) * (omega - 1) + 2 * a * S := by ring

/-- 分母 2 の既約な分子は、導出済みの整除を満たすなら 1 である。 -/
theorem denominatorTwo_numerator_eq_one
    {a E : ℕ} (hcoprime : Nat.Coprime a 2) (hdvd : a ∣ 2 ^ (E + 1)) :
    a = 1 := by
  have hcoprimePower : Nat.Coprime a (2 ^ (E + 1)) := hcoprime.pow_right _
  exact Nat.eq_one_of_dvd_coprimes hcoprimePower dvd_rfl hdvd

/-- 整数側の整除 `q ∣ 2` から、正の整数候補は `1, 2` だけになる。 -/
theorem positive_integer_dvd_two_candidates {q : ℕ} (hq : 0 < q) (hdvd : q ∣ 2) :
    q = 1 ∨ q = 2 := by
  have hle : q ≤ 2 := Nat.le_of_dvd (by norm_num) hdvd
  omega

end Ising3DCut.LimitQuantity
