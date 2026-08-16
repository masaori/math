/-
章「熱力学極限」の「倍数辺との平方の差の評価」（`claim_square_difference_from_multiple_side_bound`）の
具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                                          このファイル
  a, k, L ∈ ℕ, k a ≤ L ≤ k a + a について L² ≤ (k a)² + 2 a L         `sq_le_multiple_sq_add_two_mul_nat`
    L² = L·L                        (冪の定義)                        第 1 段
       ≤ (k a + a)·L                (L ≤ k a + a に L を掛ける)        第 2 段
       = k a·L + a·L                (分配則)                          第 3 段
       ≤ k a·(k a + a) + a·L        (L ≤ k a + a に k a を掛ける)      第 4 段
       = (k a)² + a·(k a) + a·L     (分配則・可換性・冪の定義)          第 5 段
       ≤ (k a)² + a·L + a·L         (k a ≤ L に a を掛ける)            第 6 段
       = (k a)² + 2 a L             (ℕ の四則)                        第 7 段
  したがって L² − (k a)² ≤ 2 a L（ℕ の引き算。(k a)² ≤ L²）           `sq_sub_multiple_sq_le_two_mul_nat`

住処は ℕ のみで、ℝ / ℂ は現れない。
-/
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace Ising2DLambda.ThermodynamicLimit

/-- `claim_square_difference_from_multiple_side_bound` の本体の鎖。`k a ≤ L ≤ k a + a` なら
`L² ≤ (k a)² + 2 a L`。 -/
theorem sq_le_multiple_sq_add_two_mul_nat (a k L : ℕ) (h1 : k * a ≤ L) (h2 : L ≤ k * a + a) :
    L ^ 2 ≤ (k * a) ^ 2 + 2 * a * L := by
  calc
    L ^ 2 = L * L := sq L                                                     -- 第 1 段
    _ ≤ (k * a + a) * L := Nat.mul_le_mul_right L h2                          -- 第 2 段
    _ = k * a * L + a * L := add_mul _ _ _                                     -- 第 3 段
    _ ≤ k * a * (k * a + a) + a * L :=
          Nat.add_le_add_right (Nat.mul_le_mul_left (k * a) h2) _              -- 第 4 段
    _ = (k * a) ^ 2 + a * (k * a) + a * L := by ring                          -- 第 5 段
    _ ≤ (k * a) ^ 2 + a * L + a * L :=
          Nat.add_le_add_right (Nat.add_le_add_left (Nat.mul_le_mul_left a h1) _) _  -- 第 6 段
    _ = (k * a) ^ 2 + 2 * a * L := by ring                                    -- 第 7 段

/-- `claim_square_difference_from_multiple_side_bound`。`k a ≤ L ≤ k a + a` なら
`L² − (k a)² ≤ 2 a L`（ℕ の引き算）。 -/
theorem sq_sub_multiple_sq_le_two_mul_nat (a k L : ℕ) (h1 : k * a ≤ L) (h2 : L ≤ k * a + a) :
    L ^ 2 - (k * a) ^ 2 ≤ 2 * a * L :=
  Nat.sub_le_iff_le_add.mpr (by
    have := sq_le_multiple_sq_add_two_mul_nat a k L h1 h2
    linarith)

end Ising2DLambda.ThermodynamicLimit
