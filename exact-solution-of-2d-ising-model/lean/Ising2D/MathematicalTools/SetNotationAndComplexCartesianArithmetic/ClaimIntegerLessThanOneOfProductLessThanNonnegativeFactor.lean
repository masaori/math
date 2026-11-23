/-
# 0 以上の整数 c について x·c < c なら x < 1（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_00_09.ts`
（`calc_formulae_claim_integer_less_than_one_of_product_less_than_nonnegative_factor`、
ラベル **`int_less_than_one_of_product_less_than_nonnegative_factor`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| まず `x ≤ 0` を示す。ℤ の全順序 `x ≤ 0 ∨ 0 ≤ x` で分け、`x ≤ 0` のときはそれ | `hx_le` の `rcases le_total x 0` の一つ目の枝 |
| `0 ≤ x` のとき、ℤ の 0 以上の元の分解で `x = 0` か `0 ≤ n ∧ x = n + 1` | `hdec` |
| `x = 0` のとき、反射律 `0 ≤ 0` の左辺を `x` に替えて `x ≤ 0` | `calc` の `x = 0 ≤ 0`（`hx0` と `le_refl 0`） |
| `x = n + 1` のとき、順序と乗法の両立で `0 ≤ n·c`、鎖 `c = 0 + c ≤ n·c + c = n·c + 1·c = (n + 1)·c = x·c` | `hnc`・`hc_le` の `calc` の 5 段 |
| 主張の仮定 `x·c < c` を `def_int_strict_order` で `x·c + 1 ≤ c` に書き直す | `hxc1` |
| 鎖 `c + 1 ≤ x·c + 1 ≤ c` | `hc1` の `calc` の 2 段 |
| 鎖 `1 = 0 + 1 = ((−c) + c) + 1 = (−c) + (c + 1) = (c + 1) + (−c) ≤ c + (−c) = 0` | `h10` の `calc` の 6 段 |
| 反対称律に `int_zero_at_most_one` と `1 ≤ 0` で `0 = 1`、零元と単位元の相違で `⊥`、偽からは任意の命題 | `absurd … zero_ne_one` |
| 鎖 `x + 1 ≤ 0 + 1 = 1` と `def_int_strict_order` で `x < 1` | 最後の `calc` の 2 段と `int_lt_iff_add_one_le` |

- `set_and_algebra_notation` の ℤ の行のうち、全順序は `le_total`、反射律は `le_refl`、反対称律は `le_antisymm`、推移律は `calc` の `≤` の連結、
  順序と加法の両立 `x ≤ y ⇒ x + t ≤ y + t` は `add_le_add_left`（この mathlib では `b ≤ c ⇒ b + a ≤ c + a`）、順序と乗法の両立は `mul_nonneg`、
  和の単位元は `zero_add`、乗法の単位元 `1·y = y` は `one_mul`、分配律 `(y + z)·s = y·s + z·s` は `add_mul`、加法の逆元は `add_neg_cancel`・`neg_add_cancel`、
  加法の結合律は `add_assoc`、加法の交換律は `add_comm`、零元と単位元の相違は `zero_ne_one`、偽からは任意の命題が従うことは `absurd` で読む。
  0 以上の元の分解は、`ClaimLimitInNRow.lean` と同じく `eq_or_lt_of_le` と `omega` で読む（一覧の行を mathlib の上で確かめる段であり、人手の論法の段ではない）。
- `def_int_strict_order` は `int_lt_iff_add_one_le` で読む。mathlib の `Int.mul_lt_mul_right`・`lt_of_mul_lt_mul_right` は使わない（人手の論法をそのまま書くため）。

必要十分版は `Ising2D/NecSuf/LtOneOfMulLtSelfOfCases.lean`、具体版をその系として導くのは
`ClaimIntegerLessThanOneOfProductLessThanNonnegativeFactorFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerZeroAtMostOne
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIntegerStrictOrder

namespace Ising2D

/-- **人手 `int_less_than_one_of_product_less_than_nonnegative_factor`**: `x, c ∈ ℤ`、`0 ≤ c`、`x·c < c` なら `x < 1`
（人手の論法: `x ≤ 0` を全順序と 0 以上の元の分解で示し、`x = n + 1` の側は `1 ≤ 0` から矛盾）。 -/
theorem int_less_than_one_of_product_less_than_nonnegative_factor (x c : ℤ) (hc : 0 ≤ c)
    (hxc : x * c < c) : x < 1 := by
  have hx_le : x ≤ 0 := by
    rcases le_total x 0 with hx | hx                                         -- ℤ の全順序（`x → x, y → 0`）
    · exact hx                                                               -- `x ≤ 0` のときはそれ
    · have hdec : x = 0 ∨ ∃ n : ℤ, 0 ≤ n ∧ x = n + 1 := by                  -- ℤ の 0 以上の元の分解（`x → x`）
        rcases eq_or_lt_of_le hx with h | h
        · exact Or.inl h.symm
        · exact Or.inr ⟨x - 1, by omega, by omega⟩
      rcases hdec with hx0 | ⟨n, hn, hxn⟩
      · calc x
            = 0 := hx0                                                       -- 場合の仮定 `x = 0`
          _ ≤ 0 := le_refl 0                                                 -- ℤ の順序の反射律 `0 ≤ 0`
      · have hnc : 0 ≤ n * c := mul_nonneg hn hc                            -- ℤ の順序と乗法の両立（`x → n, y → c`）
        have hc_le : c ≤ x * c :=
          calc c
              = 0 + c := (zero_add c).symm                                   -- ℤ の和の単位元（`y → c`）を右辺から左辺へ
            _ ≤ n * c + c := add_le_add_left hnc c                           -- ℤ の順序と加法の両立（`x → 0, y → n·c, t → c`）
            _ = n * c + 1 * c := by rw [one_mul c]                           -- ℤ の乗法の単位元（`y → c`）を右辺から左辺へ
            _ = (n + 1) * c := (add_mul n 1 c).symm                          -- ℤ の分配律（`y → n, z → 1, s → c`）を右辺から左辺へ
            _ = x * c := by rw [hxn]                                         -- 場合の仮定 `x = n + 1` を右辺から左辺へ
        have hxc1 : x * c + 1 ≤ c := (int_lt_iff_add_one_le (x * c) c).mp hxc   -- `def_int_strict_order`（`x → x·c, y → c`）
        have hc1 : c + 1 ≤ c :=
          calc c + 1
              ≤ x * c + 1 := add_le_add_left hc_le 1                         -- `c ≤ x·c` に ℤ の順序と加法の両立（`t → 1`）
            _ ≤ c := hxc1                                                    -- `x·c + 1 ≤ c` と ℤ の順序の推移律
        have h10 : (1 : ℤ) ≤ 0 :=
          calc (1 : ℤ)
              = 0 + 1 := (zero_add 1).symm                                   -- ℤ の和の単位元（`y → 1`）を右辺から左辺へ
            _ = ((-c) + c) + 1 := by rw [neg_add_cancel c]                   -- ℤ の加法の逆元 `(−y)+y = 0`（`y → c`）を右辺から左辺へ
            _ = (-c) + (c + 1) := add_assoc (-c) c 1                         -- ℤ の加法の結合律
            _ = (c + 1) + (-c) := add_comm (-c) (c + 1)                      -- ℤ の加法の交換律
            _ ≤ c + (-c) := add_le_add_left hc1 (-c)                         -- `c + 1 ≤ c` に ℤ の順序と加法の両立（`t → −c`）
            _ = 0 := add_neg_cancel c                                        -- ℤ の加法の逆元（`y → c`）
        exact absurd (le_antisymm int_zero_at_most_one h10) zero_ne_one     -- 反対称律で `0 = 1`、零元と単位元の相違で `⊥`、偽から任意の命題
  have hx1 : x + 1 ≤ 1 :=
    calc x + 1
        ≤ 0 + 1 := add_le_add_left hx_le 1                                   -- `x ≤ 0` に ℤ の順序と加法の両立（`t → 1`）
      _ = 1 := zero_add 1                                                    -- ℤ の和の単位元（`y → 1`）
  exact (int_lt_iff_add_one_le x 1).mpr hx1                                 -- `def_int_strict_order`（`x → x, y → 1`）

end Ising2D
