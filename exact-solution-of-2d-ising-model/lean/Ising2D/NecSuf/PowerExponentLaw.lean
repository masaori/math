/-
# 冪の指数法則 `a^{p+q} = a^pa^q`（必要十分版）

具体版: `Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimMatrixPowerExponentLaw.lean`
（人手 `matrix_power_exponent_law`）。具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimMatrixPowerExponentLawFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `q = 0` の 3 行（`p + 0 = p` → 右単位律 → `A^0 := I`） | `power_exponent_law'` の `0` の `calc` の 3 段 |
| `q + 1` の 5 行（加法の結合則 → `A^{m+1} := A^mA` → 帰納法の仮定 → 結合則 → `A^{m+1} := A^mA`） | `power_exponent_law'` の `q + 1` の `calc` の 5 段 |

## 何が効いているか / 効いていないか

- 効いているのは、乗法の**結合則**（`q + 1` の 4 段目）と**右単位律** `a·1 = a`（`q = 0` の 2 段目）だけである。
- 左単位律 `1·a = a` は使っていない。型クラスを `Monoid` に置いたのは、Lean の冪 `a^n`（`pow_zero`・`pow_succ`）が
  `Monoid` の上で定義されるためで、論証が左単位律を要るからではない。
- 行列であること、係数が `ℂ` であること、乗法の可換則・加法・逆元は効いていない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **冪の指数法則**（具体版 `matrix_power_exponent_law`）: `a^{p+q} = a^pa^q`（`q` についての帰納法）。 -/
theorem power_exponent_law' {G : Type*} [Monoid G] (a : G) (p : ℕ) :
    ∀ q : ℕ, a ^ (p + q) = a ^ p * a ^ q
  | 0 =>
    calc a ^ (p + 0)
        = a ^ p := by rw [Nat.add_zero]                                     -- `p + 0 = p`
      _ = a ^ p * 1 := (mul_one _).symm                                     -- 右単位律
      _ = a ^ p * a ^ 0 := by rw [pow_zero]                                 -- `a^0 := 1`
  | q + 1 =>
    calc a ^ (p + (q + 1))
        = a ^ ((p + q) + 1) := by rw [Nat.add_assoc]                        -- 加法の結合則
      _ = a ^ (p + q) * a := pow_succ a (p + q)                             -- `a^{m+1} := a^ma`（`m → p + q`）
      _ = (a ^ p * a ^ q) * a := by rw [power_exponent_law' a p q]          -- 帰納法の仮定
      _ = a ^ p * (a ^ q * a) := mul_assoc _ _ _                            -- 乗法の結合則
      _ = a ^ p * a ^ (q + 1) := by rw [pow_succ a q]                       -- `a^{m+1} := a^ma`（`m → q`）

end Ising2D.NecSuf
