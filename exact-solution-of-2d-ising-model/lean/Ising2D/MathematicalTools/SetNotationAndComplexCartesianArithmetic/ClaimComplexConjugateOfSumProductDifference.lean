/-
# 複素共役は有限和・積・差を保つ（具体版）

対応する人手証明（正本は `structured-latex/content/005_exp_conjugation_proof.ts`）:
- `exp_conjugation_claim_complex_conjugate_of_sum`（ラベル `complex_conjugate_of_sum`）
- `exp_conjugation_claim_complex_conjugate_of_product`（ラベル `complex_conjugate_of_product`）
- `exp_conjugation_claim_complex_conjugate_of_difference`（ラベル `complex_conjugate_of_difference`）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `complex_conjugate_of_sum` の準備（二つの和）の 5 行 | `complex_conjugate_of_add` の `calc` の 5 段 |
| 同じ主張の `m = 1` の 2 行 | `complex_conjugate_of_finite_sum_succ` の `zero` の `calc` の 2 段 |
| 同じ主張の帰納法の段の 4 行 | 同じ定理の `succ` の `calc` の 4 段 |
| `complex_conjugate_of_sum` を `m = 2` で引く行 | `complex_conjugate_of_sum_two`（`m = 2` の和を定義で開いて主張を当てる 3 段） |
| `complex_conjugate_of_product` の 8 行 | `complex_conjugate_of_product_eq` の `calc` の 8 段 |
| `complex_conjugate_of_difference` の準備（`-1_ℂ` の共役）の 4 行 | `complex_conjugate_of_neg_one` の `calc`（4 行と、略記の読み替えの 2 段） |
| 同じ主張の 7 行 | `complex_conjugate_of_difference_eq` の `calc` の 7 段 |

- 人手の複素共役 `def_complex_conjugate`（`\overline{(x,y)} := (x,-y)`）は Lean の `starRingEnd ℂ` である。
  `definition_of_cc` の台集合 `ℝ^2` の元 `(x,y)` は Lean の `⟨x, y⟩ : ℂ`（実部 `x`、虚部 `y` の構造体）で、
  `definition_of_cc` の和・積は mathlib の ℂ の和・積の定義と同じ式なので、それを開く段は `rfl` である。
  `def_complex_conjugate` を当てる段は `Complex.conj_re`・`Complex.conj_im`（共役の実部・虚部の定義の展開）で成分ごとに閉じる。
- 人手の `m ∈ ℤ_{≥1}` は Lean の `m + 1`、`z_1, …, z_m` は `z : Fin (m + 1) → ℂ` である。
  `def_finite_sum_of_complex_numbers` の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc`
  （`KroneckerProductAndMultiFactorBasis/ClaimRealInclusionPreservesFiniteSum.lean` の `real_inclusion_of_finite_sum_succ` と同じ読み替え）。
- 人手の「ℝ で `-(y+v) = (-y)+(-v)`」「ℝ で `(-y)(-v) = yv`」「ℝ で `-0 = 0`」「ℝ で `-(xv + yu) = (-(xv)) + (-(yu))`」
  「ℝ で `-(xv) = x(-v)`」「ℝ で `-(yu) = (-y)u`」は mathlib の `neg_add`・`neg_mul_neg`・`neg_zero`・`neg_add`・`mul_neg`・`neg_mul` で 1 段ずつ受ける。
- 人手 `multiply_by_minus_one`（`-z := (-1_ℂ)z`）・`def_complex_difference`（`z - w := z + (-w)`）は具体版が Lean に無く、
  mathlib の `neg_one_mul`・`sub_eq_add_neg` で受ける（ほかのファイルと同じ）。
  人手の `-1_ℂ` は `inclusion_rr_to_cc` の像 `(-1)_ℂ` の略記で、Lean の `((-1 : ℝ) : ℂ)` と `-1 : ℂ` の行き来は
  略記の読み替えの段（`Complex.ofReal_neg`・`Complex.ofReal_one`）で行う。

## 必要十分版

`complex_conjugate_of_finite_sum_succ` の帰納法は、和を保つ写像が左から足す有限和を保つことの必要十分版
`NecSuf.map_finSumLeft_of_map_add'`（`Ising2D/NecSuf/AdditiveMapPreservesFiniteSum.lean`）と同じ手順である
（`m = 1` の 2 段、帰納法の段の「和の定義 → 帰納法の仮定 → 二つの和 → 和の定義」）。具体版をその系として導くのは
同じフォルダの `ClaimComplexConjugateOfSumFromNecSuf.lean`。準備の二つの和は、必要十分版では仮定 `hadd` に当たる。

積・差・`-1_ℂ` の共役には必要十分版を置かない。積と `-1_ℂ` の共役は実部・虚部の成分の計算そのもので、
取り払える構造が無い（`definition_of_cc` の積の式と `def_complex_conjugate` の式が効いている）。
差は「和を保つ・積を保つ・`\overline{-1} = -1`・`-x = (-1)x`・`x - y = x + (-y)`」を 1 回ずつ当てるだけで、
`NecSuf/MatrixConjugationNegSub.lean` が同じ形の仮定（`hsub`・和と積を保つこと）で行列の共役について既に示している。
-/
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- 人手 `complex_conjugate_of_sum` の準備（二つの和）: `\overline{z + w} = \overline{z} + \overline{w}`（人手の 5 行）。
`z = (x,y)`、`w = (u,v)` は Lean の `⟨z.re, z.im⟩`・`⟨w.re, w.im⟩`。 -/
theorem complex_conjugate_of_add (z w : ℂ) :
    (starRingEnd ℂ) (z + w) = (starRingEnd ℂ) z + (starRingEnd ℂ) w :=
  calc (starRingEnd ℂ) (z + w)
      = (starRingEnd ℂ) (⟨z.re + w.re, z.im + w.im⟩ : ℂ) := rfl
                                                  -- 1 行目: `definition_of_cc` の和
    _ = (⟨z.re + w.re, -(z.im + w.im)⟩ : ℂ) :=
        Complex.ext (Complex.conj_re _) (Complex.conj_im _)
                                                  -- 2 行目: `def_complex_conjugate`
    _ = (⟨z.re + w.re, (-z.im) + (-w.im)⟩ : ℂ) := by
        rw [neg_add]                              -- 3 行目: ℝ で `-(y+v) = (-y)+(-v)`
    _ = (⟨z.re, -z.im⟩ : ℂ) + (⟨w.re, -w.im⟩ : ℂ) := rfl
                                                  -- 4 行目: `definition_of_cc` の和
    _ = (starRingEnd ℂ) z + (starRingEnd ℂ) w :=
        congrArg₂ (· + ·)
          (Complex.ext (Complex.conj_re z).symm (Complex.conj_im z).symm)
          (Complex.ext (Complex.conj_re w).symm (Complex.conj_im w).symm)
                                                  -- 5 行目: `def_complex_conjugate`（2 項へ）

/-- **人手 `complex_conjugate_of_sum`**: `\overline{Σ_{j=1}^{m} z_j} = Σ_{j=1}^{m} \overline{z_j}`
（`m ∈ ℤ_{≥1}` は Lean の `m + 1`）。`m` についての帰納法。 -/
theorem complex_conjugate_of_finite_sum_succ (m : ℕ) (z : Fin (m + 1) → ℂ) :
    (starRingEnd ℂ) (∑ j, z j) = ∑ j, (starRingEnd ℂ) (z j) := by
  induction m with
  | zero =>                                                                        -- 人手の `m = 1`
    calc (starRingEnd ℂ) (∑ j : Fin 1, z j)
        = (starRingEnd ℂ) (z 0) := by rw [Fin.sum_univ_one]                        -- `def_finite_sum_of_complex_numbers`
      _ = ∑ j : Fin 1, (starRingEnd ℂ) (z j) := by rw [Fin.sum_univ_one]           -- `def_finite_sum_of_complex_numbers`
  | succ m ih =>                                                                   -- 人手の `m → m + 1`
    calc (starRingEnd ℂ) (∑ j : Fin (m + 2), z j)
        = (starRingEnd ℂ) ((∑ j : Fin (m + 1), z j.castSucc) + z (Fin.last (m + 1))) := by
          rw [Fin.sum_univ_castSucc]                                               -- `def_finite_sum_of_complex_numbers`
      _ = (starRingEnd ℂ) (∑ j : Fin (m + 1), z j.castSucc) + (starRingEnd ℂ) (z (Fin.last (m + 1))) :=
          complex_conjugate_of_add _ _                                             -- 準備の二つの和
      _ = (∑ j : Fin (m + 1), (starRingEnd ℂ) (z j.castSucc)) + (starRingEnd ℂ) (z (Fin.last (m + 1))) := by
          rw [ih (fun j => z j.castSucc)]                                          -- 帰納法の仮定
      _ = ∑ j : Fin (m + 2), (starRingEnd ℂ) (z j) :=
          (Fin.sum_univ_castSucc (fun j => (starRingEnd ℂ) (z j))).symm            -- `def_finite_sum_of_complex_numbers`

/-- 人手 `complex_conjugate_of_sum` を `m = 2` で引く形: `\overline{z_1 + z_2} = \overline{z_1} + \overline{z_2}`。
`z_1 + z_2` を `def_finite_sum_of_complex_numbers` の `Σ_{j=1}^{2}` と読み、主張を当て、読みを戻す。 -/
theorem complex_conjugate_of_sum_two (z₁ z₂ : ℂ) :
    (starRingEnd ℂ) (z₁ + z₂) = (starRingEnd ℂ) z₁ + (starRingEnd ℂ) z₂ :=
  calc (starRingEnd ℂ) (z₁ + z₂)
      = (starRingEnd ℂ) (∑ j : Fin 2, ![z₁, z₂] j) := by
        rw [Fin.sum_univ_two]; rfl                -- `def_finite_sum_of_complex_numbers` の `m = 2` を右辺から左辺へ
    _ = ∑ j : Fin 2, (starRingEnd ℂ) (![z₁, z₂] j) :=
        complex_conjugate_of_finite_sum_succ 1 ![z₁, z₂]
                                                  -- `complex_conjugate_of_sum` の `m = 2`
    _ = (starRingEnd ℂ) z₁ + (starRingEnd ℂ) z₂ := by
        rw [Fin.sum_univ_two]; rfl                -- `def_finite_sum_of_complex_numbers` の `m = 2`

/-- **人手 `complex_conjugate_of_product`**: `\overline{zw} = \overline{z}\,\overline{w}`（人手の 8 行）。
`z = (x,y)`、`w = (u,v)` は Lean の `⟨z.re, z.im⟩`・`⟨w.re, w.im⟩`。 -/
theorem complex_conjugate_of_product_eq (z w : ℂ) :
    (starRingEnd ℂ) (z * w) = (starRingEnd ℂ) z * (starRingEnd ℂ) w :=
  calc (starRingEnd ℂ) (z * w)
      = (starRingEnd ℂ) (⟨z.re * w.re - z.im * w.im, z.re * w.im + z.im * w.re⟩ : ℂ) := rfl
                                                  -- 1 行目: `definition_of_cc` の積
    _ = (⟨z.re * w.re - z.im * w.im, -(z.re * w.im + z.im * w.re)⟩ : ℂ) :=
        Complex.ext (Complex.conj_re _) (Complex.conj_im _)
                                                  -- 2 行目: `def_complex_conjugate`
    _ = (⟨z.re * w.re - (-z.im) * (-w.im), -(z.re * w.im + z.im * w.re)⟩ : ℂ) := by
        rw [neg_mul_neg]                          -- 3 行目: ℝ で `(-y)(-v) = yv`
    _ = (⟨z.re * w.re - (-z.im) * (-w.im), (-(z.re * w.im)) + (-(z.im * w.re))⟩ : ℂ) := by
        rw [neg_add]                              -- 4 行目: ℝ で `-(xv + yu) = (-(xv)) + (-(yu))`
    _ = (⟨z.re * w.re - (-z.im) * (-w.im), z.re * (-w.im) + (-(z.im * w.re))⟩ : ℂ) := by
        rw [← mul_neg z.re w.im]                  -- 5 行目: ℝ で `-(xv) = x(-v)`
    _ = (⟨z.re * w.re - (-z.im) * (-w.im), z.re * (-w.im) + (-z.im) * w.re⟩ : ℂ) := by
        rw [← neg_mul z.im w.re]                  -- 6 行目: ℝ で `-(yu) = (-y)u`
    _ = (⟨z.re, -z.im⟩ : ℂ) * (⟨w.re, -w.im⟩ : ℂ) := rfl
                                                  -- 7 行目: `definition_of_cc` の積
    _ = (starRingEnd ℂ) z * (starRingEnd ℂ) w :=
        congrArg₂ (· * ·)
          (Complex.ext (Complex.conj_re z).symm (Complex.conj_im z).symm)
          (Complex.ext (Complex.conj_re w).symm (Complex.conj_im w).symm)
                                                  -- 8 行目: `def_complex_conjugate`（2 因子へ）

/-- 人手 `complex_conjugate_of_difference` の準備: `\overline{-1_ℂ} = -1_ℂ`（人手の 4 行と、略記の読み替えの 2 段）。 -/
theorem complex_conjugate_of_neg_one : (starRingEnd ℂ) (-1 : ℂ) = -1 :=
  calc (starRingEnd ℂ) (-1 : ℂ)
      = (starRingEnd ℂ) (((-1 : ℝ)) : ℂ) := by
        rw [Complex.ofReal_neg, Complex.ofReal_one] -- `-1_ℂ` を `(-1)_ℂ` と読む（`inclusion_rr_to_cc` の略記）
    _ = (starRingEnd ℂ) (⟨-1, 0⟩ : ℂ) := rfl     -- 1 行目: `inclusion_rr_to_cc` の `r_ℂ = (r, 0)`（`r = -1`）
    _ = (⟨-1, -0⟩ : ℂ) := Complex.ext (Complex.conj_re _) (Complex.conj_im _)
                                                  -- 2 行目: `def_complex_conjugate`
    _ = (⟨-1, 0⟩ : ℂ) := by rw [neg_zero]         -- 3 行目: ℝ で `-0 = 0`
    _ = (((-1 : ℝ)) : ℂ) := rfl                  -- 4 行目: `inclusion_rr_to_cc` の `r_ℂ = (r, 0)`（`r = -1`）
    _ = -1 := by
        rw [Complex.ofReal_neg, Complex.ofReal_one] -- `(-1)_ℂ` を `-1_ℂ` と書く（`inclusion_rr_to_cc` の略記）

/-- **人手 `complex_conjugate_of_difference`**: `\overline{z - w} = \overline{z} - \overline{w}`（人手の 7 行）。 -/
theorem complex_conjugate_of_difference_eq (z w : ℂ) :
    (starRingEnd ℂ) (z - w) = (starRingEnd ℂ) z - (starRingEnd ℂ) w :=
  calc (starRingEnd ℂ) (z - w)
      = (starRingEnd ℂ) (z + -w) := by
        rw [sub_eq_add_neg]                       -- 1 行目: `def_complex_difference`
    _ = (starRingEnd ℂ) z + (starRingEnd ℂ) (-w) :=
        complex_conjugate_of_sum_two z (-w)       -- 2 行目: `complex_conjugate_of_sum` の `m = 2`
    _ = (starRingEnd ℂ) z + (starRingEnd ℂ) ((-1 : ℂ) * w) := by
        rw [neg_one_mul]                          -- 3 行目: `multiply_by_minus_one`（`z → w`）
    _ = (starRingEnd ℂ) z + (starRingEnd ℂ) (-1 : ℂ) * (starRingEnd ℂ) w := by
        rw [complex_conjugate_of_product_eq]      -- 4 行目: `complex_conjugate_of_product`
    _ = (starRingEnd ℂ) z + (-1 : ℂ) * (starRingEnd ℂ) w := by
        rw [complex_conjugate_of_neg_one]         -- 5 行目: 準備の `\overline{-1_ℂ} = -1_ℂ`
    _ = (starRingEnd ℂ) z + -((starRingEnd ℂ) w) := by
        rw [neg_one_mul]                          -- 6 行目: `multiply_by_minus_one`（`z → \overline{w}`）
    _ = (starRingEnd ℂ) z - (starRingEnd ℂ) w := by
        rw [← sub_eq_add_neg]                     -- 7 行目: `def_complex_difference`

end Ising2D
