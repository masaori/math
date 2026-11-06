/-
# 可逆元の積は可逆（`def_invertible_elements_of_R` (ii)、具体版）

正本: `structured-latex/content/008_TV1_hatZ_hatY_part1.ts`

* `TV1_hatZ_hatY_009_definition_invertible_elements`（ラベル **`def_invertible_elements_of_R`**）の (ii) の
  「`g_1, g_2 ∈ R^×` なら `g_1g_2 ∈ R^×`」と、その証明の 2 本の 6 行の鎖

人手の `R = Mat(2^M,ℂ)` は、具体版では添字 `Fin n` の複素正方行列（`n → 2^M`）で述べる。
人手の「`g` が可逆」は「`gh = I` かつ `hg = I` となる `h` がある」であり、Lean では単元 `⟨g, h, gh = I, hg = I⟩` を
値 `g` に持つこと（`IsUnit g`）として読む。単元の 4 つの成分が、人手の定義の `g`・`h` と 2 つの等式そのものである。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| (ii) の 1 本目の鎖 `(g_1g_2)h = I`（`h := g_2^{-1}g_1^{-1}`。代入・`mat_mult_associative` 2 回・`g_2g_2^{-1} = I`・`identity_matrix_is_right_unit_of_mat_mult`・`g_1g_1^{-1} = I`） | `invertible_product_right_inverse` の `calc` の 6 段 |
| (ii) の 2 本目の鎖 `h(g_1g_2) = I`（代入・`mat_mult_associative` 2 回・`g_1^{-1}g_1 = I`・`identity_matrix_is_right_unit_of_mat_mult`・`g_2^{-1}g_2 = I`） | `invertible_product_left_inverse` の `calc` の 6 段 |
| (ii) の結論「`g_1g_2 ∈ R^×`」（`def_invertible_elements_of_R` の定義を `h := g_2^{-1}g_1^{-1}` で） | `invertible_product_isUnit` |

- `mat_mult_associative` は具体版が無く、mathlib の `Matrix.mul_assoc` を引く（既存の慣行どおり）。
- 人手の「`(g_1g_2)^{-1} = g_2^{-1}g_1^{-1}`」（逆元の一意性による）は、ここでは置かない。通しの証明が使うのは
  `g_1g_2 ∈ R^×` だけである。

必要十分版は `Ising2D/NecSuf/InvertibleElementsProduct.lean`、具体版をその特殊化として得るのと
`TensorPow M`（添字 `Conf M`）の系は `DefinitionInvertibleElementsProductFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct

namespace Ising2D

variable {n : ℕ}

/-- **人手 `def_invertible_elements_of_R` (ii) の 1 本目の鎖**: `g_1h_1 = I`、`g_2h_2 = I` なら
`(g_1g_2)(h_2h_1) = I`（`h_1 = g_1^{-1}`、`h_2 = g_2^{-1}`、`h := g_2^{-1}g_1^{-1}`）。 -/
theorem invertible_product_right_inverse {g1 g2 h1 h2 : Matrix (Fin n) (Fin n) ℂ}
    (hg1 : g1 * h1 = 1) (hg2 : g2 * h2 = 1) :
    (g1 * g2) * (h2 * h1) = 1 :=
  calc (g1 * g2) * (h2 * h1)
      = (g1 * g2) * (h2 * h1) := rfl                                -- `h = g_2^{-1}g_1^{-1}` の代入
    _ = ((g1 * g2) * h2) * h1 := (Matrix.mul_assoc _ _ _).symm      -- `mat_mult_associative`
    _ = (g1 * (g2 * h2)) * h1 := by rw [Matrix.mul_assoc g1 g2 h2]  -- `mat_mult_associative`
    _ = (g1 * 1) * h1 := by rw [hg2]                                -- `g_2g_2^{-1} = I`
    _ = g1 * h1 := by rw [mul_identity_matrix]                      -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = 1 := hg1                                                    -- `g_1g_1^{-1} = I`

/-- **人手 `def_invertible_elements_of_R` (ii) の 2 本目の鎖**: `h_1g_1 = I`、`h_2g_2 = I` なら
`(h_2h_1)(g_1g_2) = I`。 -/
theorem invertible_product_left_inverse {g1 g2 h1 h2 : Matrix (Fin n) (Fin n) ℂ}
    (hh1 : h1 * g1 = 1) (hh2 : h2 * g2 = 1) :
    (h2 * h1) * (g1 * g2) = 1 :=
  calc (h2 * h1) * (g1 * g2)
      = (h2 * h1) * (g1 * g2) := rfl                                -- `h = g_2^{-1}g_1^{-1}` の代入
    _ = ((h2 * h1) * g1) * g2 := (Matrix.mul_assoc _ _ _).symm      -- `mat_mult_associative`
    _ = (h2 * (h1 * g1)) * g2 := by rw [Matrix.mul_assoc h2 h1 g1]  -- `mat_mult_associative`
    _ = (h2 * 1) * g2 := by rw [hh1]                                -- `g_1^{-1}g_1 = I`
    _ = h2 * g2 := by rw [mul_identity_matrix]                      -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = 1 := hh2                                                    -- `g_2^{-1}g_2 = I`

/-- **人手 `def_invertible_elements_of_R` (ii)**: `g_1, g_2 ∈ R^×` なら `g_1g_2 ∈ R^×`
（`h := g_2^{-1}g_1^{-1}` が 2 本の鎖で `g_1g_2` の逆元の条件を満たす）。 -/
theorem invertible_product_isUnit {g1 g2 : Matrix (Fin n) (Fin n) ℂ}
    (hg1 : IsUnit g1) (hg2 : IsUnit g2) : IsUnit (g1 * g2) := by
  obtain ⟨u1, rfl⟩ := hg1
  obtain ⟨u2, rfl⟩ := hg2
  exact ⟨⟨(u1 : Matrix (Fin n) (Fin n) ℂ) * u2, ((u2⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ)
      * ((u1⁻¹ : (Matrix (Fin n) (Fin n) ℂ)ˣ) : Matrix (Fin n) (Fin n) ℂ),
    invertible_product_right_inverse u1.mul_inv u2.mul_inv,
    invertible_product_left_inverse u1.inv_mul u2.inv_mul⟩, rfl⟩

end Ising2D
