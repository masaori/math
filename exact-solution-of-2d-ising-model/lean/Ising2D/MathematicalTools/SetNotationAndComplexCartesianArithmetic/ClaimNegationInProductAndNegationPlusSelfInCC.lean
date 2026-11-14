/-
# `z(-w) = -(zw)`・`(-z)w = -(zw)`・`(-x) + x = 0_ℂ`（ℂ、具体版）

正本: `structured-latex/content/000_calculation_formulae_30_44.ts`
- `calculation_formulae_claim_complex_times_negation_is_negation_of_product_in_cc`
  （ラベル **`complex_times_negation_is_negation_of_product_in_cc`**）
- `calculation_formulae_claim_negation_times_complex_is_negation_of_product_in_cc`
  （ラベル **`negation_times_complex_is_negation_of_product_in_cc`**）
- `calculation_formulae_claim_negation_plus_self_is_zero_in_cc`（ラベル **`negation_plus_self_is_zero_in_cc`**）

Lean でこれらを引くのは `ClaimTwoSidedInverseOfTwoByTwo.lean` の成分の鎖（人手 `matrix_times_adjugate_two_by_two`・
`adjugate_times_matrix_two_by_two`）である。`neg_add_self_complex` は、ほかに `ClaimZYLinearlyIndependent.lean`
（人手 `Z_Y_linearly_independent`）、`ClaimZeroMatrixProductAndSumEquations.lean`（人手 `matrix_summand_from_sum_equation`）、
`ClaimDetATilde.lean`（人手 `det_A_theta_tilde`）も引く。
人手では `anticommutator_of_check_psi` の準備 4 の (i)・(ii) が前の 2 つを、準備 5 と `frobenius_inner_product_axioms` が
`negation_plus_self_is_zero_in_cc` を引くが、Lean の `ClaimAnticommutatorCheckPsi.lean` は準備 4・5 を 1 段ずつは形式化しておらず、
`frobenius_inner_product_axioms` には Lean の具体版が無いので、そこに対応する参照は無い。

## 人手証明との対応

`mul_neg_eq_neg_mul_complex`（人手 `complex_times_negation_is_negation_of_product_in_cc` の 5 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `multiply_by_minus_one`（`z → w`） | 1 段目（`neg_one_mul`） |
| 2 行目: 積の結合律を右辺から左辺へ | 2 段目（`mul_assoc` を右辺から左辺へ） |
| 3 行目: 積の可換律 | 3 段目（`mul_comm z (-1)`） |
| 4 行目: 積の結合律 | 4 段目（`mul_assoc`） |
| 5 行目: `multiply_by_minus_one`（`z → zw`）を右辺から左辺へ | 5 段目（`neg_one_mul`） |

`neg_mul_eq_neg_mul_complex`（人手 `negation_times_complex_is_negation_of_product_in_cc` の 3 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `multiply_by_minus_one`（`z → z`） | 1 段目（`neg_one_mul`） |
| 2 行目: 積の結合律 | 2 段目（`mul_assoc`） |
| 3 行目: `multiply_by_minus_one`（`z → zw`）を右辺から左辺へ | 3 段目（`neg_one_mul`） |

`neg_add_self_complex`（人手 `negation_plus_self_is_zero_in_cc` の 8 行）:

| 人手 | Lean |
| --- | --- |
| 1 行目: `multiply_by_minus_one`（`z → x`） | 1 段目（`neg_one_mul`） |
| 2 行目: 積の単位元を右辺から左辺へ | 2 段目（`one_mul`） |
| 3 行目: 右からの分配律を右辺から左辺へ | 3 段目（`add_mul` を右辺から左辺へ） |
| 4 行目: `inclusion_rr_to_cc` を 2 箇所へ同時適用 | 4 段目（`Complex.ext` で成分ごと） |
| 5 行目: `definition_of_cc` の和 | 5 段目（`rfl`） |
| 6 行目: `ℝ` の四則 | 6 段目（`norm_num`） |
| 7 行目: `inclusion_rr_to_cc` を右辺から左辺へ | 7 段目（`rfl`） |
| 8 行目: `complex_zero_times_is_zero` | 8 段目（`zero_mul`） |

- 人手 `multiply_by_minus_one`（`-z := (-1_ℂ)z`）は Lean では定義ではなく mathlib の `Neg ℂ` であり、
  両者の一致は `neg_one_mul` の 1 段で受ける（同じフォルダの `ClaimDoubleNegationAndReversedDifferenceInCC.lean` と同じ扱い）。
- `mul_neg`・`neg_mul`・`neg_add_cancel` の 1 行で済ませない。mathlib のそれらは環の公理から出しており、
  人手の鎖（`(-1_ℂ)` との積を通る）と対応しないためである。

必要十分版は `Ising2D/NecSuf/NegationInProductAndNegationPlusSelf.lean`、そこからの導出は同じフォルダの
`ClaimNegationInProductAndNegationPlusSelfInCCFromNecSuf.lean` にある。
-/
import Mathlib.Data.Complex.Basic
import Mathlib.Tactic.NormNum

namespace Ising2D

/-- **人手 `complex_times_negation_is_negation_of_product_in_cc`**: `z(-w) = -(zw)`（人手の 5 行）。 -/
theorem mul_neg_eq_neg_mul_complex (z w : ℂ) : z * (-w) = -(z * w) :=
  calc z * (-w)
      = z * ((-1) * w) := by rw [neg_one_mul]   -- 1 行目: `multiply_by_minus_one`（`z → w`）
    _ = (z * (-1)) * w := (mul_assoc _ _ _).symm  -- 2 行目: 積の結合律を右辺から左辺へ
    _ = ((-1) * z) * w := by rw [mul_comm z (-1)] -- 3 行目: 積の可換律
    _ = (-1) * (z * w) := mul_assoc _ _ _         -- 4 行目: 積の結合律
    _ = -(z * w) := neg_one_mul _                 -- 5 行目: `multiply_by_minus_one`（`z → zw`）を右辺から左辺へ

/-- **人手 `negation_times_complex_is_negation_of_product_in_cc`**: `(-z)w = -(zw)`（人手の 3 行）。 -/
theorem neg_mul_eq_neg_mul_complex (z w : ℂ) : (-z) * w = -(z * w) :=
  calc (-z) * w
      = ((-1) * z) * w := by rw [neg_one_mul]     -- 1 行目: `multiply_by_minus_one`（`z → z`）
    _ = (-1) * (z * w) := mul_assoc _ _ _         -- 2 行目: 積の結合律
    _ = -(z * w) := neg_one_mul _                 -- 3 行目: `multiply_by_minus_one`（`z → zw`）を右辺から左辺へ

/-- **人手 `negation_plus_self_is_zero_in_cc`**: `(-x) + x = 0_ℂ`（人手の 8 行）。 -/
theorem neg_add_self_complex (x : ℂ) : (-x) + x = 0 :=
  calc (-x) + x
      = (-1) * x + x := by rw [neg_one_mul]                       -- 1 行目: `multiply_by_minus_one`（`z → x`）
    _ = (-1) * x + 1 * x := by rw [one_mul]                       -- 2 行目: 積の単位元を右辺から左辺へ
    _ = ((-1) + 1) * x := (add_mul _ _ _).symm                    -- 3 行目: 右からの分配律を右辺から左辺へ
    _ = ((⟨-1, 0⟩ : ℂ) + ⟨1, 0⟩) * x := by
        congr 2 <;> apply Complex.ext <;> simp                    -- 4 行目: `inclusion_rr_to_cc` を 2 箇所へ同時適用
    _ = (⟨-1 + 1, 0 + 0⟩ : ℂ) * x := rfl                          -- 5 行目: `definition_of_cc` の和
    _ = (⟨0, 0⟩ : ℂ) * x := by norm_num                           -- 6 行目: `ℝ` の四則
    _ = 0 * x := rfl                                              -- 7 行目: `inclusion_rr_to_cc` を右辺から左辺へ
    _ = 0 := zero_mul _                                           -- 8 行目: `complex_zero_times_is_zero`

end Ising2D
