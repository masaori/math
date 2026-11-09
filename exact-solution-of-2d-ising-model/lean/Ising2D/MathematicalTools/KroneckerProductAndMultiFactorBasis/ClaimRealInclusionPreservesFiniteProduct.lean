/-
# 実数の有限積の包含は包含の有限積に等しい（**具体版**）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_real_inclusion_preserves_finite_product`、ラベル **`real_inclusion_preserves_finite_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 2 行（`def_finite_product_of_complex_numbers` → `def_finite_product_of_real_numbers` を右辺から左辺へ） | `real_inclusion_preserves_finite_product` の `0` の節の `calc` の 2 段 |
| `m → m+1` の 4 行（`def_finite_product_of_complex_numbers` → 帰納法の仮定 → `real_inclusion_preserves_product` → `def_finite_product_of_real_numbers` を右辺から左辺へ） | `m + 1` の節の `calc` の 4 段 |

- 人手の `r_1, …, r_m`（`m ≥ 1`）は Lean の `r : Fin (m + 1) → ℝ` である（人手の `m` は Lean の `m + 1`。添字は 0 始まりで、人手の `j` は `j - 1`）。
- 人手の `r_ℂ`（`inclusion_rr_to_cc`）は Lean の `(r : ℂ)`（`Complex.ofReal r`）である。
- 人手の 2 つの有限積（`def_finite_product_of_complex_numbers`・`def_finite_product_of_real_numbers`）は Lean の `∏ j, …`
  （ℂ と ℝ の `Finset.prod`）で、定義の 2 つの式は `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む
  （`ClaimFiniteProductOfPositiveRealsIsPositive.lean` と同じ）。
- 因子の個数が `0` かもしれない積（Lean の `Fin M`、`M = 0` を含む）には `real_inclusion_preserves_finite_product_or_empty` を使う。
  人手の主張は `m ≥ 1` なので、`M = 0`（両辺が空の積 `1`、mathlib の `Finset.prod_empty`・`Complex.ofReal_one` で読む）は Lean だけの場合である。
- `real_inclusion_preserves_product` は具体版 `real_inclusion_mul`（`ClaimRealInclusionPreservesProduct.lean`）を引く。
  mathlib の `Complex.ofReal_prod`・`Complex.ofReal_mul` は使わない。

必要十分版は `Ising2D/NecSuf/MultiplicativeMapOfFiniteProduct.lean`、具体版をその系として導くのは
`ClaimRealInclusionPreservesFiniteProductFromNecSuf.lean`。
段の対応: `0` の節の 2 段は必要十分版 `NecSuf.finProdLeft_map_of_mul` の `0` の節の 2 段、`m + 1` の節の 4 段は同じく `r + 1` の節の 4 段（3 段目の `real_inclusion_mul` が必要十分版の仮定 `hmul`）に当たる。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

/-- **人手 `real_inclusion_preserves_finite_product`**: `Π_{j=1}^{m} (r_j)_ℂ = (Π_{j=1}^{m} r_j)_ℂ`
（人手の `m` は Lean の `m + 1`）。 -/
theorem real_inclusion_preserves_finite_product :
    ∀ (m : ℕ) (r : Fin (m + 1) → ℝ), ∏ j, ((r j : ℝ) : ℂ) = ((∏ j, r j : ℝ) : ℂ)
  | 0, r =>
    calc ∏ j, ((r j : ℝ) : ℂ)
        = ((r 0 : ℝ) : ℂ) := Fin.prod_univ_one _                             -- `def_finite_product_of_complex_numbers`
      _ = ((∏ j, r j : ℝ) : ℂ) := by rw [Fin.prod_univ_one]                  -- `def_finite_product_of_real_numbers` を右辺から左辺へ
  | m + 1, r =>
    calc ∏ j, ((r j : ℝ) : ℂ)
        = (∏ j : Fin (m + 1), ((r (Fin.castSucc j) : ℝ) : ℂ)) * ((r (Fin.last (m + 1)) : ℝ) : ℂ) :=
          Fin.prod_univ_castSucc _                                            -- `def_finite_product_of_complex_numbers`
      _ = ((∏ j : Fin (m + 1), r (Fin.castSucc j) : ℝ) : ℂ) * ((r (Fin.last (m + 1)) : ℝ) : ℂ) := by
          rw [real_inclusion_preserves_finite_product m]                      -- 帰納法の仮定（`r_1, …, r_m` に当てる）
      _ = (((∏ j : Fin (m + 1), r (Fin.castSucc j)) * r (Fin.last (m + 1)) : ℝ) : ℂ) :=
          real_inclusion_mul _ _                                              -- `real_inclusion_preserves_product`
                                                                              -- （`a → Π_{j=1}^{m} r_j`、`b → r_{m+1}`）
      _ = ((∏ j, r j : ℝ) : ℂ) :=
          congrArg (fun t : ℝ => (t : ℂ)) (Fin.prod_univ_castSucc r).symm     -- `def_finite_product_of_real_numbers` を右辺から左辺へ

/-- 因子の個数 `M` が `0` かもしれない有限積。`M ≥ 1` なら `real_inclusion_preserves_finite_product`（人手の主張）、
`M = 0` なら両辺が空の積 `1`（人手の主張に無い Lean だけの場合）。 -/
theorem real_inclusion_preserves_finite_product_or_empty :
    ∀ (M : ℕ) (r : Fin M → ℝ), ∏ j, ((r j : ℝ) : ℂ) = ((∏ j, r j : ℝ) : ℂ)
  | 0, r =>                                                                   -- 因子が無い（Lean だけの場合）
    calc ∏ j, ((r j : ℝ) : ℂ)
        = 1 := Finset.prod_empty                                              -- 空の積
      _ = ((1 : ℝ) : ℂ) := Complex.ofReal_one.symm                            -- `1_ℂ = (1_ℝ)_ℂ`
      _ = ((∏ j, r j : ℝ) : ℂ) := by rw [Finset.univ_eq_empty, Finset.prod_empty] -- 空の積を右辺から左辺へ
  | m + 1, r => real_inclusion_preserves_finite_product m r                   -- `real_inclusion_preserves_finite_product`

end Ising2D
