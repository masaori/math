/-
# 逆元の複素共役は複素共役の逆元（具体版）

正本: `structured-latex/content/005_exp_conjugation_proof.ts`
（`exp_conjugation_claim_complex_conjugate_of_inverse`、ラベル **`complex_conjugate_of_inverse`**）。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備（`\overline{w} ∈ ℂ^×`）: `\overline{w} = (x,-y)`、`(0,0)` なら `x = 0` かつ `-y = 0` で `y = 0`、`w = (0,0)` と矛盾 | `complex_conjugate_ne_zero` |
| 準備（`\overline{w}\,\overline{w^{-1}} = 1_ℂ`）の 3 行 | `complex_conjugate_mul_complex_conjugate_inv` の `calc` の 3 段 |
| 主張の 5 行 | `complex_conjugate_of_inverse` の `calc` の 5 段 |

- 人手の複素共役 `def_complex_conjugate` は Lean の `starRingEnd ℂ`、`multiplicative_group_of_cc` の逆元は `ℂ` の `⁻¹`
  （`w ≠ 0` のもとで `mul_inv_cancel₀`・`inv_mul_cancel₀` が逆元の性質）である。
- 人手 `complex_numbers_form_a_field` の積の単位元・結合律は `one_mul`・`mul_one`・`mul_assoc` で 1 段ずつ受ける。

## 必要十分版

置かない。主鎖は、積を保ち `1` を `1` へ送る写像が、可逆元の逆元を像の逆元へ送るという、群の準同型の 1 つの性質の計算そのもので、
取り払える構造をこの説明以上に示す計算が無い（`complex_minus_one_mul_minus_one` と同じ扱い）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifference
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealSymmetricMatrixIsHermitian

namespace Ising2D

/-- 人手 `complex_conjugate_of_inverse` の準備: `w ∈ ℂ^×` なら `\overline{w} ∈ ℂ^×`。
`w = (x,y)`、`\overline{w} = (x,-y)` が `(0,0)` なら、成分ごとに `x = 0`・`-y = 0`、`ℝ` で `y = -(-y) = -0 = 0` となり `w = (0,0)` に反する。 -/
theorem complex_conjugate_ne_zero {w : ℂ} (hw : w ≠ 0) : (starRingEnd ℂ) w ≠ 0 := by
  intro h
  have hx : w.re = 0 :=
    calc w.re
        = ((starRingEnd ℂ) w).re := (Complex.conj_re w).symm
                                      -- `def_complex_conjugate`: `\overline{w} = (x,-y)` の第 1 成分は `x`
      _ = (0 : ℂ).re := congrArg Complex.re h
                                      -- 仮定 `\overline{w} = (0,0)` の第 1 成分（`definition_of_cc` の等号は成分ごと）
      _ = 0 := Complex.zero_re
  have hy' : -w.im = 0 :=
    calc -w.im
        = ((starRingEnd ℂ) w).im := (Complex.conj_im w).symm
                                      -- `def_complex_conjugate`: `\overline{w}` の第 2 成分は `-y`
      _ = (0 : ℂ).im := congrArg Complex.im h
                                      -- 仮定の第 2 成分
      _ = 0 := Complex.zero_im
  have hy : w.im = 0 :=
    calc w.im
        = -(-w.im) := (neg_neg _).symm  -- ℝ で `y = -(-y)`
      _ = -0 := by rw [hy']             -- `-y = 0`
      _ = 0 := neg_zero                 -- ℝ で `-0 = 0`
  exact hw (Complex.ext (hx.trans Complex.zero_re.symm) (hy.trans Complex.zero_im.symm))
                                      -- `w = (0,0)` は `w ∈ ℂ^×` に反する

/-- 人手 `complex_conjugate_of_inverse` の準備: `\overline{w}\,\overline{w^{-1}} = 1_ℂ`（人手の 3 行）。 -/
theorem complex_conjugate_mul_complex_conjugate_inv {w : ℂ} (hw : w ≠ 0) :
    (starRingEnd ℂ) w * (starRingEnd ℂ) w⁻¹ = 1 :=
  calc (starRingEnd ℂ) w * (starRingEnd ℂ) w⁻¹
      = (starRingEnd ℂ) (w * w⁻¹) := (complex_conjugate_of_product_eq w w⁻¹).symm
                                      -- 1 行目: `complex_conjugate_of_product`（`z → w`, `w → w^{-1}` を同時に）を右辺から左辺へ
    _ = (starRingEnd ℂ) 1 := by rw [mul_inv_cancel₀ hw]
                                      -- 2 行目: `multiplicative_group_of_cc` の逆元（`w ∈ ℂ^×`）
    _ = (starRingEnd ℂ) ((1 : ℝ) : ℂ) := by rw [Complex.ofReal_one]
                                      -- `1_ℂ` は略記 `r_ℂ` の `r = 1`（Lean のリテラル `(1 : ℂ)` との読み替え）
    _ = ((1 : ℝ) : ℂ) := complex_conjugate_of_real_inclusion 1
                                      -- 3 行目: `complex_conjugate_of_real_inclusion`（`r → 1`）
    _ = 1 := Complex.ofReal_one       -- 略記の読み替え

/-- **人手 `complex_conjugate_of_inverse`**: `w ∈ ℂ^×` について `\overline{w^{-1}} = (\overline{w})^{-1}`（人手の 5 行）。 -/
theorem complex_conjugate_of_inverse {w : ℂ} (hw : w ≠ 0) :
    (starRingEnd ℂ) w⁻¹ = ((starRingEnd ℂ) w)⁻¹ :=
  calc (starRingEnd ℂ) w⁻¹
      = 1 * (starRingEnd ℂ) w⁻¹ := (one_mul _).symm
                                      -- 1 行目: `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = (((starRingEnd ℂ) w)⁻¹ * (starRingEnd ℂ) w) * (starRingEnd ℂ) w⁻¹ := by
        rw [inv_mul_cancel₀ (complex_conjugate_ne_zero hw)]
                                      -- 2 行目: `multiplicative_group_of_cc` の逆元（`\overline{w} ∈ ℂ^×`）を右辺から左辺へ
    _ = ((starRingEnd ℂ) w)⁻¹ * ((starRingEnd ℂ) w * (starRingEnd ℂ) w⁻¹) := mul_assoc _ _ _
                                      -- 3 行目: `complex_numbers_form_a_field` の積の結合律
    _ = ((starRingEnd ℂ) w)⁻¹ * 1 := by rw [complex_conjugate_mul_complex_conjugate_inv hw]
                                      -- 4 行目: 準備の `\overline{w}\,\overline{w^{-1}} = 1_ℂ`
    _ = ((starRingEnd ℂ) w)⁻¹ := mul_one _
                                      -- 5 行目: `complex_numbers_form_a_field` の積の単位元

end Ising2D
