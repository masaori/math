/-
人手証明「有理点が整数のとき分子は多重度ゼロの値から 1 を引いた数の 2 倍を割る」
（ラベル `claim_integer_point_numerator_divides_twice_zero_multiplicity_minus_one`）の Lean 具体版。

人手証明と同じ順で進む。
準備段: 有限個の自然数の和 `S = ∑_{m<E} Ω(m+1) * a ^ m` を置く。
第一段: 分配多項式の定義への代入と `m = 0` の項の分離により
        `∑_{m<E+1} Ω(m) * a ^ m = Ω 0 + a * S` を示す。
第二段: 両辺から 1 を引いて 2 倍し、`2 (Z - 1) = 2 (Ω 0 - 1) + 2 a S` を得る。
第三段: 仮定 `a ∣ 2 (Z - 1)` と `a ∣ 2 a S` の差から `a ∣ 2 (Ω 0 - 1)` を得る。

扱うのは自然数の有限和と整除だけであり、箱の大きさの極限も無限和も現れない。
箱の大きさは閾値の一つに固定されている。
-/
import Mathlib

namespace Ising3DCut.LimitQuantity

/-- 準備段。人手証明の `S = ∑_{m=1}^{#E} Ω(m) a^{m-1}` を、添字をずらして書いたもの。 -/
def shiftedMultiplicitySum (Omega : ℕ → ℕ) (a E : ℕ) : ℕ :=
  ∑ m ∈ Finset.range E, Omega (m + 1) * a ^ m

/-- 第一段。分配多項式の有限和から `m = 0` の項を分離すると `Ω 0 + a * S` になる。 -/
theorem partition_sum_split_zero_term (Omega : ℕ → ℕ) (a E : ℕ) :
    (∑ m ∈ Finset.range (E + 1), Omega m * a ^ m)
      = Omega 0 + a * shiftedMultiplicitySum Omega a E := by
  have hsplit : (∑ m ∈ Finset.range (E + 1), Omega m * a ^ m)
      = (∑ m ∈ Finset.range E, Omega (m + 1) * a ^ (m + 1)) + Omega 0 * a ^ 0 :=
    Finset.sum_range_succ' (fun m => Omega m * a ^ m) E
  have hfactor : (∑ m ∈ Finset.range E, Omega (m + 1) * a ^ (m + 1))
      = a * shiftedMultiplicitySum Omega a E := by
    unfold shiftedMultiplicitySum
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl ?_
    intro m _
    ring
  rw [hsplit, hfactor]
  simp [Nat.add_comm]

/-- 人手証明の着地。分配多項式の値についての整除から、定数項についての整除を得る。

`a` は整数の有理点（正の自然数）、`Omega` は多重度、`E` は閾値の箱の辺の数、
`Z` は閾値の箱でのその点における分配多項式の値である。
右辺 `2 (Ω 0 - 1)` は `a` を含まず、箱の大きさだけで決まる。 -/
theorem integer_point_numerator_divides_twice_zero_multiplicity_minus_one
    {a E Z : ℕ} {Omega : ℕ → ℕ} (hOmega : 1 ≤ Omega 0)
    (hZ : Z = ∑ m ∈ Finset.range (E + 1), Omega m * a ^ m)
    (hdvd : a ∣ 2 * (Z - 1)) :
    a ∣ 2 * (Omega 0 - 1) := by
  set S := shiftedMultiplicitySum Omega a E with hS
  -- 第一段
  have hsplit : Z = Omega 0 + a * S := by
    rw [hZ, hS]
    exact partition_sum_split_zero_term Omega a E
  -- 第二段: 両辺から 1 を引いて 2 倍する
  have hEq : 2 * (Z - 1) = 2 * (Omega 0 - 1) + 2 * (a * S) := by
    omega
  -- 第三段: 差についての整除
  have hmul : a ∣ 2 * (a * S) := ⟨2 * S, by ring⟩
  have hsum : a ∣ 2 * (Omega 0 - 1) + 2 * (a * S) := by
    rw [← hEq]; exact hdvd
  have hfinal : a ∣ 2 * (Omega 0 - 1) + 2 * (a * S) - 2 * (a * S) :=
    Nat.dvd_sub hsum hmul
  simpa using hfinal
