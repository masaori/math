/-
「符号への潰しは値の衝突を持つ」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち
  1. `u := 2`, `w := 4` と置き、いずれも正の有理数であること、
  2. 素数 `2` での成分では `v_2(u) = 1`, `v_2(w) = 2` で、どちらも正なので符号は
     ともに `1` であること、
  3. `2` 以外の素数 `p` では `v_p(u) = 0 = v_p(w)` なので符号はともに `0` であること、
  4. `w - u = 2 > 0` より `u ≠ w` であること、
の四段をそのままなぞる。符号は `Int.sign` を使わず、人手証明と同じく
「負なら -1、零なら 0、正なら 1」を場合分けで定める写像として置く。
-/
import Ising3DCut.LimitQuantity.MagnitudeTruncatedPrimeExponentsNotSufficient

namespace Ising3DCut.LimitQuantity

/-- 整数の符号。人手証明の `sgn` と同じ場合分けで定める。 -/
def intSign (n : ℤ) : ℤ := if n < 0 then -1 else if n = 0 then 0 else 1

/-- 人手証明の「零は符号 `0`」の段。 -/
theorem intSign_zero : intSign 0 = 0 := by
  simp [intSign]

/-- 人手証明の「正の整数は符号 `1`」の段。 -/
theorem intSign_of_pos {n : ℤ} (hn : 0 < n) : intSign n = 1 := by
  have h1 : ¬ n < 0 := not_lt.2 hn.le
  have h2 : n ≠ 0 := ne_of_gt hn
  simp [intSign, h1, h2]

/-- 素指数データの、各成分の符号だけへの潰し。 -/
noncomputable def signCollapse (a : ℚ) : ℕ → ℤ :=
  fun p => intSign (padicValRat p a)

/-- 素指数を符号だけへ潰す写像は値の衝突を持つ。 -/
theorem sign_collapse_has_a_value_collision :
    ∃ u w : ℚ, 0 < u ∧ 0 < w ∧ u ≠ w ∧
      ∀ p : ℕ, p.Prime → signCollapse u p = signCollapse w p := by
  -- 第一段: `u := 2`, `w := 4` と置く。いずれも正の有理数である。
  refine ⟨((2 ^ 1 : ℕ) : ℚ), ((2 ^ 2 : ℕ) : ℚ), by norm_num, by norm_num, ?_, ?_⟩
  · -- 第四段: `w - u = 4 - 2 = 2 > 0` なので `u ≠ w`。
    norm_num
  · intro p hp
    show intSign (padicValRat p ((2 ^ 1 : ℕ) : ℚ)) = intSign (padicValRat p ((2 ^ 2 : ℕ) : ℚ))
    by_cases hp2 : p = 2
    · -- 第二段: 素数 `2` での成分。`v_2(u) = 1`, `v_2(w) = 2` はどちらも正なので符号は `1`。
      subst hp2
      rw [padicValRat_two_pow 1, padicValRat_two_pow 2]
      rw [intSign_of_pos (by norm_num), intSign_of_pos (by norm_num)]
    · -- 第三段: `2` 以外の素数での成分。両方の素指数が `0` なので符号はともに `0`。
      rw [padicValRat_ne_two_pow p 1 hp hp2, padicValRat_ne_two_pow p 2 hp hp2]

end Ising3DCut.LimitQuantity
