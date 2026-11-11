/-
# `-(-z) = z`・`b - a = -(a - b)`（ℂ、具体版）

正本: `structured-latex/content/000_calculation_formulae_30_44.ts`
- `calculation_formulae_claim_double_negation_in_cc`（ラベル **`double_negation_in_cc`**）
- `calculation_formulae_claim_reversed_difference_is_negation_of_difference_in_cc`
  （ラベル **`reversed_difference_is_negation_of_difference_in_cc`**）

## 人手証明との対応

`complex_double_negation`（人手 `double_negation_in_cc` の 5 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `multiply_by_minus_one`（`z → -z`） | `calc` の 1 段目（`neg_one_mul` を右辺から左辺へ） |
| 2 行目: `multiply_by_minus_one`（`z → z`） | 2 段目（`neg_one_mul z` を右辺から左辺へ） |
| 3 行目: `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ | 3 段目（`mul_assoc` を右辺から左辺へ） |
| 4 行目: `minus_one_times_minus_one_is_one_in_cc` | 4 段目（`complex_minus_one_mul_minus_one`） |
| 5 行目: `complex_numbers_form_a_field` の積の単位元 | 5 段目（`one_mul`） |

`complex_reversed_difference`（人手 `reversed_difference_is_negation_of_difference_in_cc` の 10 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `def_complex_difference`（`z → b`, `w → a`） | 1 段目（`sub_eq_add_neg`） |
| 2 行目: 加法の可換律 | 2 段目（`add_comm`） |
| 3 行目: 積の単位元を右辺から左辺へ | 3 段目（`one_mul` を右辺から左辺へ） |
| 4 行目: `minus_one_times_minus_one_is_one_in_cc` を右辺から左辺へ | 4 段目（`complex_minus_one_mul_minus_one`） |
| 5 行目: 積の結合律 | 5 段目（`mul_assoc`） |
| 6 行目: `multiply_by_minus_one`（`z → b`）を右辺から左辺へ | 6 段目（`neg_one_mul b`） |
| 7 行目: `multiply_by_minus_one`（`z → a`） | 7 段目（`neg_one_mul a` を右辺から左辺へ） |
| 8 行目: 左からの分配律を右辺から左辺へ | 8 段目（`mul_add` を右辺から左辺へ） |
| 9 行目: `multiply_by_minus_one`（`z → a + (-b)`）を右辺から左辺へ | 9 段目（`neg_one_mul`） |
| 10 行目: `def_complex_difference`（`z → a`, `w → b`）を右辺から左辺へ | 10 段目（`sub_eq_add_neg` を右辺から左辺へ） |

- 人手 `multiply_by_minus_one`（`-z := (-1_ℂ)z`）は Lean では定義ではなく mathlib の `Neg ℂ` であり、
  両者の一致は `neg_one_mul` の 1 段で受ける（同じフォルダの `ClaimCosSinAndITimesAtNegatedReal.lean` と同じ扱い）。
- 人手 `def_complex_difference`（`z - w := z + (-w)`）は `sub_eq_add_neg` の 1 段で受ける。
- `-(-z) = z` を `neg_neg`、`b - a = -(a - b)` を `neg_sub` の 1 行で済ませない。mathlib のそれらは加法群の公理から出しており、
  人手の鎖（`(-1_ℂ)(-1_ℂ) = 1_ℂ` を通る）と対応しないためである。

必要十分版は `Ising2D/NecSuf/DoubleNegationAndReversedDifference.lean`、そこからの導出は同じフォルダの
`ClaimDoubleNegationAndReversedDifferenceInCCFromNecSuf.lean` にある。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimMinusOneTimesMinusOneIsOneInCC

namespace Ising2D

/-- **人手 `double_negation_in_cc`**: `z ∈ ℂ` で `-(-z) = z`（人手の 5 行）。 -/
theorem complex_double_negation (z : ℂ) : -(-z) = z :=
  calc -(-z)
      = (-1 : ℂ) * (-z) := (neg_one_mul (-z)).symm                -- 1 行目: `multiply_by_minus_one`（`z → -z`）
    _ = (-1 : ℂ) * ((-1 : ℂ) * z) := by rw [neg_one_mul z]         -- 2 行目: `multiply_by_minus_one`（`z → z`）
    _ = ((-1 : ℂ) * (-1 : ℂ)) * z := (mul_assoc _ _ _).symm        -- 3 行目: 積の結合律を右辺から左辺へ
    _ = 1 * z := by rw [complex_minus_one_mul_minus_one]           -- 4 行目: `minus_one_times_minus_one_is_one_in_cc`
    _ = z := one_mul z                                             -- 5 行目: 積の単位元

/-- **人手 `reversed_difference_is_negation_of_difference_in_cc`**: `a, b ∈ ℂ` で `b - a = -(a - b)`（人手の 10 行）。 -/
theorem complex_reversed_difference (a b : ℂ) : b - a = -(a - b) :=
  calc b - a
      = b + -a := sub_eq_add_neg b a                               -- 1 行目: `def_complex_difference`（`z → b`, `w → a`）
    _ = -a + b := add_comm _ _                                     -- 2 行目: 加法の可換律
    _ = -a + 1 * b := by rw [one_mul]                              -- 3 行目: 積の単位元を右辺から左辺へ
    _ = -a + ((-1 : ℂ) * (-1 : ℂ)) * b := by
        rw [complex_minus_one_mul_minus_one]                       -- 4 行目: `minus_one_times_minus_one_is_one_in_cc` を右辺から左辺へ
    _ = -a + (-1 : ℂ) * ((-1 : ℂ) * b) := by rw [mul_assoc]        -- 5 行目: 積の結合律
    _ = -a + (-1 : ℂ) * (-b) := by rw [neg_one_mul b]              -- 6 行目: `multiply_by_minus_one`（`z → b`）を右辺から左辺へ
    _ = (-1 : ℂ) * a + (-1 : ℂ) * (-b) := by rw [neg_one_mul a]    -- 7 行目: `multiply_by_minus_one`（`z → a`）
    _ = (-1 : ℂ) * (a + -b) := (mul_add _ _ _).symm                -- 8 行目: 左からの分配律を右辺から左辺へ
    _ = -(a + -b) := neg_one_mul _                                 -- 9 行目: `multiply_by_minus_one`（`z → a + (-b)`）を右辺から左辺へ
    _ = -(a - b) := by rw [sub_eq_add_neg]                         -- 10 行目: `def_complex_difference`（`z → a`, `w → b`）を右辺から左辺へ

end Ising2D
