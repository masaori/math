/-
「有限個の素数への切り詰めは値の衝突を持つ」の Lean 具体版。

人手証明と 1 対 1 に対応させる。すなわち
  1. `P` は有限集合なので `P` に属さない素数 `r` が存在する（素数は無限に多く存在する）、
  2. `u := 1`, `w := r` と置き、いずれも正の有理数であること、
  3. すべての `p ∈ P` で `v_p(u) = 0` かつ `v_p(w) = 0` であること、
  4. `r ≥ 2` より `u ≠ w` であること、
の四段をそのままなぞる。
-/
import Ising3DCut.LimitQuantity.FinitelyManyPrimesNotSufficient

namespace Ising3DCut.LimitQuantity

/-- 素指数データの、素数からなる有限集合 `P` への切り詰め。 -/
noncomputable def primeTruncation (P : Finset ℕ) (a : ℚ) : {p // p ∈ P} → ℤ :=
  fun p => padicValRat p a

-- 人手証明の第一段（素数は無限に多く存在するので `P` に属さない素数が取れる）と
-- 第三段の `w = r` の側（相異なる素数 `p ≠ r` について `v_p(r) = 0`）は、
-- すでに `FinitelyManyPrimesNotSufficient` に `exists_prime_not_mem` と
-- `padicValRat_prime_ne` として書いてあるので、そのまま引く。

/-- 素数からなる任意の有限集合 `P` について、素指数データの `P` への切り詰めは
値の衝突を持つ。 -/
theorem finite_prime_truncation_has_a_value_collision
    (P : Finset ℕ) (hP : ∀ p ∈ P, Nat.Prime p) :
    ∃ u w : ℚ, 0 < u ∧ 0 < w ∧ u ≠ w ∧ primeTruncation P u = primeTruncation P w := by
  -- 第一段: `P` に属さない素数 `r` を取る。
  obtain ⟨r, hr, hrP⟩ := exists_prime_not_mem P
  -- 第二段: `u := 1`, `w := r` と置く。いずれも正の有理数である。
  refine ⟨1, (r : ℚ), one_pos, ?_, ?_, ?_⟩
  · exact_mod_cast hr.pos
  · -- 第四段: `r` は素数なので `r ≥ 2`、したがって `1 ≠ r`。
    have h2 : 2 ≤ r := hr.two_le
    intro h
    have : (1 : ℚ) = ((r : ℕ) : ℚ) := h
    have : (1 : ℕ) = r := by exact_mod_cast this
    omega
  · -- 第三段: すべての `p ∈ P` で `v_p(1) = 0 = v_p(r)`。
    funext p
    have hpP : (p : ℕ) ∈ P := p.2
    have hp : Nat.Prime (p : ℕ) := hP _ hpP
    have hne : (p : ℕ) ≠ r := fun h => hrP (h ▸ hpP)
    show padicValRat (p : ℕ) (1 : ℚ) = padicValRat (p : ℕ) ((r : ℕ) : ℚ)
    rw [padicValRat.one, padicValRat_prime_ne _ _ hp hr hne]

end Ising3DCut.LimitQuantity
