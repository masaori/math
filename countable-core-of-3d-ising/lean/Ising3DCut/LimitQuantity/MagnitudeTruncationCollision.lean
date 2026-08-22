/-
「大きさによる切り詰めは値の衝突を持つ」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち
  1. `u := 2 ^ N`, `w := 2 ^ (N + 1)` と置き、いずれも正の有理数であること、
  2. 素数 `2` での成分は `v_2(u) = N`, `v_2(w) = N + 1` であり、
     高さ `N` で頭打ちにすると `min N N = N` と `min (N + 1) N = N` でともに `N` になること、
  3. `2` 以外の素数 `p` では `v_p(u) = 0 = v_p(w)` であり、頭打ちにしてもともに `0` になること、
  4. `2 ^ N < 2 ^ (N + 1)` より `u ≠ w` であること、
の四段をそのままなぞる。素指数の計算そのものは
`MagnitudeTruncatedPrimeExponentsNotSufficient` に置いた
`padicValRat_two_pow` と `padicValRat_ne_two_pow` を引く。

添字は人手証明の素数全体の集合 `ℙ` に合わせて素数の部分型で取る
（素数でない添字は人手証明の主張に現れない）。
-/
import Ising3DCut.LimitQuantity.MagnitudeTruncatedPrimeExponentsNotSufficient

namespace Ising3DCut.LimitQuantity

/-- 素指数データの、高さ `N` による切り詰め。素数ごとの指数を `N` で頭打ちにする。 -/
noncomputable def magnitudeTruncation (N : ℕ) (a : ℚ) : {p : ℕ // Nat.Prime p} → ℤ :=
  fun p => min (padicValRat (p : ℕ) a) (N : ℤ)

/-- 任意の高さ `N ≥ 1` について、素指数データの高さ `N` による切り詰めは値の衝突を持つ。 -/
theorem magnitude_truncation_has_a_value_collision (N : ℕ) (hN : 1 ≤ N) :
    ∃ u w : ℚ, 0 < u ∧ 0 < w ∧ u ≠ w ∧
      magnitudeTruncation N u = magnitudeTruncation N w := by
  -- 第一段: `u := 2 ^ N`, `w := 2 ^ (N + 1)` と置く。いずれも正の有理数である。
  refine ⟨((2 ^ N : ℕ) : ℚ), ((2 ^ (N + 1) : ℕ) : ℚ), ?_, ?_, ?_, ?_⟩
  · exact_mod_cast Nat.pow_pos (n := N) (by norm_num : 0 < 2)
  · exact_mod_cast Nat.pow_pos (n := N + 1) (by norm_num : 0 < 2)
  · -- 第四段: `2 ^ N < 2 ^ (N + 1)` なので二つは異なる。
    have hlt : (2 : ℕ) ^ N < 2 ^ (N + 1) :=
      Nat.pow_lt_pow_right (by norm_num) (Nat.lt_succ_self N)
    intro h
    have : (2 : ℕ) ^ N = 2 ^ (N + 1) := by exact_mod_cast h
    omega
  · -- 第二段・第三段: 各素数での成分を比べる。
    funext p
    show min (padicValRat (p : ℕ) ((2 ^ N : ℕ) : ℚ)) (N : ℤ)
        = min (padicValRat (p : ℕ) ((2 ^ (N + 1) : ℕ) : ℚ)) (N : ℤ)
    by_cases hp : (p : ℕ) = 2
    · -- 第二段: 素数 `2` での成分。`min N N = N` と `min (N + 1) N = N` でともに `N` になる。
      rw [hp, padicValRat_two_pow N, padicValRat_two_pow (N + 1)]
      have h2 : ((N + 1 : ℕ) : ℤ) = (N : ℤ) + 1 := by push_cast; ring
      rw [h2, min_self]
      omega
    · -- 第三段: `2` 以外の素数での成分。どちらも `v_p = 0` なので頭打ちも一致する。
      rw [padicValRat_ne_two_pow (p : ℕ) N p.2 hp,
        padicValRat_ne_two_pow (p : ℕ) (N + 1) p.2 hp]

end Ising3DCut.LimitQuantity
