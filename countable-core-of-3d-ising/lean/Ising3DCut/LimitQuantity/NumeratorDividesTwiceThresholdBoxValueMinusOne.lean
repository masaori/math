/-
人手証明「分子は閾値の箱の値から 1 を引いた数の 2 倍を割る」
（ラベル `claim_numerator_divides_twice_threshold_box_value_minus_one`）の Lean 具体版。

人手証明と同じ順で進む。
準備段: 有限個の項からなる和 `∑_{k<n} c ^ k` を置く。
第一段: 等式 `(c - 1) * ∑_{k<n} c ^ k = c ^ n - 1` を示す。
        人手証明はこれを「分配法則 → 添字の付け替え → 共通項の相殺 → c^0 = 1」の四段で書いている。
        自然数の引き算を避けるため、ここでは相殺を項の個数についての帰納法として一項ずつ行い、
        加法の形 `(∑_{k<n} c ^ k) * (c - 1) + 1 = c ^ n` で示す。相殺する共通項は
        帰納法の各段で一つずつ消えるので、消える項の集まりは人手証明と同じである。
第二段: 和が自然数なので、第一段の等式から `(c - 1) ∣ (c ^ n - 1)` が従う。
第三段: 整除の両辺を 2 倍しても整除は保たれるので `2 * (c - 1) ∣ 2 * (c ^ n - 1)`。
第四段: 仮定 `a ∣ 2 * (c - 1)` と整除の推移律から `a ∣ 2 * (c ^ n - 1)`。
着地: 仮定 `Z = c ^ n` を代入して `a ∣ 2 * (Z - 1)` を得る。

扱うのは自然数の有限和・有限積と整除だけであり、箱の大きさの極限も無限和も現れない。
-/
import Mathlib

namespace Ising3DCut.LimitQuantity

/-- 準備段。有限個の項からなる和 `∑_{k<n} c ^ k`。 -/
def geometricPartialSum (c n : ℕ) : ℕ := ∑ k ∈ Finset.range n, c ^ k

/-- 第一段（加法の形）。`1 ≤ c` のとき `(∑_{k<n} c ^ k) * (c - 1) + 1 = c ^ n`。
人手証明の相殺を、項の個数についての帰納法として一項ずつ行う。 -/
theorem geometricPartialSum_mul_pred_add_one {c : ℕ} (hc : 1 ≤ c) (n : ℕ) :
    geometricPartialSum c n * (c - 1) + 1 = c ^ n := by
  induction n with
  | zero => simp [geometricPartialSum]
  | succ k ih =>
      have hsum : geometricPartialSum c (k + 1)
          = geometricPartialSum c k + c ^ k := by
        unfold geometricPartialSum
        exact Finset.sum_range_succ _ _
      have hone : 1 + (c - 1) = c := by omega
      calc geometricPartialSum c (k + 1) * (c - 1) + 1
          = (geometricPartialSum c k + c ^ k) * (c - 1) + 1 := by rw [hsum]
        _ = (geometricPartialSum c k * (c - 1) + 1) + c ^ k * (c - 1) := by ring
        _ = c ^ k + c ^ k * (c - 1) := by rw [ih]
        _ = c ^ k * (1 + (c - 1)) := by ring
        _ = c ^ k * c := by rw [hone]
        _ = c ^ (k + 1) := by ring

/-- 第二段。第一段の等式から、和を商として `(c - 1) ∣ (c ^ n - 1)` が従う。 -/
theorem pred_dvd_pow_sub_one {c : ℕ} (hc : 1 ≤ c) (n : ℕ) :
    (c - 1) ∣ (c ^ n - 1) := by
  have h := geometricPartialSum_mul_pred_add_one hc n
  refine ⟨geometricPartialSum c n, ?_⟩
  rw [Nat.mul_comm (c - 1) (geometricPartialSum c n)]
  omega

/-- 人手証明の着地。`a ∣ 2 (c - 1)` と `Z = c ^ n` から `a ∣ 2 (Z - 1)` を得る。

`a` は分子、`c` は点数乗表示の底、`n` は閾値の箱の点の数、`Z` は閾値の箱での値である。
箱の大きさは閾値の一つに固定されており、他の箱の情報は使わない。 -/
theorem numerator_divides_twice_threshold_box_value_minus_one
    {a c n Z : ℕ} (hc : 1 ≤ c)
    (hdvd : a ∣ 2 * (c - 1)) (hZ : Z = c ^ n) :
    a ∣ 2 * (Z - 1) := by
  -- 第二段
  have hstep : (c - 1) ∣ (c ^ n - 1) := pred_dvd_pow_sub_one hc n
  -- 第三段: 整除の両辺を 2 倍する
  have hdouble : 2 * (c - 1) ∣ 2 * (c ^ n - 1) := mul_dvd_mul_left 2 hstep
  -- 第四段: 整除の推移律
  have htrans : a ∣ 2 * (c ^ n - 1) := hdvd.trans hdouble
  -- 着地: 閾値の箱の値を代入する
  rw [hZ]
  exact htrans

end Ising3DCut.LimitQuantity
