/-
# 実数の包含の有限積は実数の包含（具体版）

正本: `structured-latex/content/000_calculation_formulae_20_29.ts`
（`calculation_formulae_claim_finite_product_of_real_inclusions_is_real`、ラベル **`finite_product_of_real_inclusions_is_real`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 2 行（`def_finite_product_of_complex_numbers` → 仮定を `j = 1` で）と `r := r_1` | `finite_product_of_real_inclusions_is_real` の `0` の場合の `calc` の 2 段と `⟨r1, _⟩` |
| `m → m+1` の 4 行（`def_finite_product_of_complex_numbers` → `s` の取り方 → 仮定を `j = m+1` で → `real_inclusion_preserves_product`（`a → s`, `b → r_{m+1}`））と `r := s r_{m+1}` | `m + 1` の場合の `calc` の 4 段と `⟨s * r', _⟩` |

- 人手の `z_1, …, z_m`（`m ≥ 1`）は Lean の `z : Fin (m + 1) → ℂ` である（人手の `m` は Lean の `m + 1`。添字は 0 始まりで、人手の `j` は `j - 1`）。
- 人手の有限積 `∏_{j=1}^{m} z_j`（`def_finite_product_of_complex_numbers`）は Lean の `∏ j, z j`（`Finset.prod`）である。
  定義の 2 つの式（1 個の積はその元、`m + 1` 個の積は `m` 個の積に右から掛けたもの）は `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む。
- `real_inclusion_preserves_product` は `real_inclusion_mul`（`ClaimRealInclusionPreservesProduct.lean`）である。

必要十分版は `Ising2D/NecSuf/KroneckerOfRealEntryMatrices.lean`、具体版をその特殊化として得るのは
`ClaimKroneckerOfRealEntryMatricesFromNecSuf.lean` である。
-/
import Mathlib.Algebra.BigOperators.Fin
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct

namespace Ising2D

/-- **人手 `finite_product_of_real_inclusions_is_real`**: 各 `z_j` が `(r_j)_ℂ`（`r_j ∈ ℝ`）なら、`∏_{j=1}^{m} z_j = r_ℂ` を満たす `r ∈ ℝ` がある。 -/
theorem finite_product_of_real_inclusions_is_real :
    ∀ (m : ℕ) (z : Fin (m + 1) → ℂ), (∀ j, ∃ r : ℝ, z j = (r : ℂ)) → ∃ r : ℝ, ∏ j, z j = (r : ℂ)
  | 0, z, hz => by
    obtain ⟨r1, h1⟩ := hz 0
    refine ⟨r1, ?_⟩
    calc ∏ j, z j
        = z 0 := Fin.prod_univ_one z                                        -- `def_finite_product_of_complex_numbers`
      _ = (r1 : ℂ) := h1                                                    -- 仮定を `j = 1` で
  | m + 1, z, hz => by
    obtain ⟨s, hs⟩ := finite_product_of_real_inclusions_is_real m (fun j => z (Fin.castSucc j))
      (fun j => hz (Fin.castSucc j))                                        -- 帰納法の仮定を `z_1, …, z_m` に
    obtain ⟨r', hr'⟩ := hz (Fin.last (m + 1))
    refine ⟨s * r', ?_⟩
    calc ∏ j, z j
        = (∏ j : Fin (m + 1), z (Fin.castSucc j)) * z (Fin.last (m + 1)) :=
          Fin.prod_univ_castSucc z                                          -- `def_finite_product_of_complex_numbers`
      _ = (s : ℂ) * z (Fin.last (m + 1)) := by rw [hs]                      -- `s` の取り方
      _ = (s : ℂ) * (r' : ℂ) := by rw [hr']                                 -- 仮定を `j = m+1` で
      _ = ((s * r' : ℝ) : ℂ) := real_inclusion_mul s r'                     -- `real_inclusion_preserves_product`（`a → s`, `b → r_{m+1}`）

end Ising2D
