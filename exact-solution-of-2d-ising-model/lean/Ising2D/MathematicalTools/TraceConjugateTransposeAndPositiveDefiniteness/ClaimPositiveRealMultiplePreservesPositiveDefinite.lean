/-
# 正定値行列の正の実数倍は正定値（**具体版**）

正本: `structured-latex/content/009_eigenvalues_of_V.ts`
の `eigenvalues_of_V_claim_positive_real_multiple_preserves_positive_definite`（ラベル **`positive_real_multiple_preserves_positive_definite`**）。

人手の `x^*Ay` は `def_conjugate_bilinear_value`（Lean の `conjugateBilinearValue`）、正定値は `def_hermitian_positive_definite`
（mathlib の `Matrix.PosDef` との読み替えは `posDef_conjugateBilinearValue_pos`・`posDef_of_conjugateBilinearValue_pos`）、
`α_ℂ` は `inclusion_rr_to_cc`（Lean の `(α : ℂ)`。実部 `α`、虚部 `0` の構造体）による。

**必要十分版**: `Ising2D/NecSuf/PositiveMultiplePreservesPositiveDefinite.lean`。具体版をその特殊化として導くのと、
`TensorPow M`（添字 `Conf M`）の系は `ClaimPositiveRealMultiplePreservesPositiveDefiniteFromNecSuf.lean` に置く。

## 人手証明との対応

| 人手 | Lean（具体版） |
| --- | --- |
| エルミート性（`real_multiple_of_hermitian_is_hermitian`） | `real_multiple_isHermitian` |
| 正値性の 13 行の鎖 | `conjugate_bilinear_value_of_positive_real_multiple` の `calc` の 13 段 |
| `α, r ∈ ℝ_{>0}` なので `αr ∈ ℝ_{>0}` | `mul_pos` |

- 人手の鎖の「分配律を項の数だけ繰り返す」（`complex_numbers_form_a_field`）は、mathlib の `Finset.mul_sum` を、
  人手と同じ 1 行に当たる段の中でだけ使う。積の結合律・可換律も同じ根拠で、`mul_assoc`・`mul_comm` を各項へ 1 回ずつ引く。
- 10〜13 段目（`α_ℂ r_ℂ = (αr)_ℂ`）は、`ClaimRealInclusionPreservesProduct.lean` の `real_inclusion_mul` の鎖と同じ計算である。
  人手がこのブロックの鎖の中に 4 行で書いているので、ここでも同じ 4 段で書く（`real_inclusion_mul` の 3・4 段目の ℝ の計算が、
  人手の 12 行目「ℝ の四則」の 1 段に当たる）。
- 人手の `n ∈ ℤ_{≥1}` は効かないので仮定に置かない（`n = 0` でも主張は成り立つ）。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimCongruencePreservesPositiveDefinite
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealMultipleOfHermitianIsHermitian

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-- **人手 `positive_real_multiple_preserves_positive_definite` の正値性の 13 行の鎖**:
`x^*Ax = r_ℂ` なら `x^*(α_ℂA)x = (αr)_ℂ`。 -/
theorem conjugate_bilinear_value_of_positive_real_multiple {n : ℕ} (α : ℝ) (A : Matrix (Fin n) (Fin n) ℂ)
    (x : Fin n → ℂ) {r : ℝ} (hr : conjugateBilinearValue x A x = (r : ℂ)) :
    conjugateBilinearValue x ((α : ℂ) • A) x = ((α * r : ℝ) : ℂ) :=
  calc conjugateBilinearValue x ((α : ℂ) • A) x
      = ∑ k, ∑ l, (star (x k) * ((α : ℂ) • A) k l) * x l := rfl                 -- `def_conjugate_bilinear_value`
    _ = ∑ k, ∑ l, (star (x k) * ((α : ℂ) * A k l)) * x l := rfl                 -- `def_matrix_scalar_multiple` を各項へ
    _ = ∑ k, ∑ l, ((star (x k) * (α : ℂ)) * A k l) * x l := by
        simp only [← mul_assoc (star (x _))]                                      -- 積の結合律を各項へ
    _ = ∑ k, ∑ l, (((α : ℂ) * star (x k)) * A k l) * x l := by
        simp only [mul_comm (star (x _)) (α : ℂ)]                                 -- 積の可換律を各項へ
    _ = ∑ k, ∑ l, ((α : ℂ) * (star (x k) * A k l)) * x l := by
        simp only [mul_assoc (α : ℂ) (star (x _)) (A _ _)]                        -- 積の結合律を各項へ
    _ = ∑ k, ∑ l, (α : ℂ) * ((star (x k) * A k l) * x l) := by
        simp only [mul_assoc (α : ℂ) (star (x _) * A _ _)]                        -- 積の結合律を各項へ
    _ = (α : ℂ) * ∑ k, ∑ l, (star (x k) * A k l) * x l := by
        simp only [Finset.mul_sum]                                                -- 分配律を項の数だけ繰り返す
    _ = (α : ℂ) * conjugateBilinearValue x A x := rfl                             -- `def_conjugate_bilinear_value`
    _ = (α : ℂ) * (r : ℂ) := by rw [hr]                                           -- `r` の取り方
    _ = (⟨α, 0⟩ : ℂ) * ⟨r, 0⟩ := rfl                                              -- `inclusion_rr_to_cc`
    _ = ⟨α * r - 0 * 0, α * 0 + 0 * r⟩ := rfl                                     -- `definition_of_cc` の積
    _ = ⟨α * r, 0⟩ := Complex.ext (by simp only [mul_zero, sub_zero])
        (by simp only [mul_zero, zero_mul, add_zero])                             -- ℝ の四則
    _ = ((α * r : ℝ) : ℂ) := rfl                                                  -- `inclusion_rr_to_cc`

/-- **人手 `positive_real_multiple_preserves_positive_definite`**: `A` が正定値、`α ∈ ℝ_{>0}` なら `α_ℂA` は正定値。 -/
theorem positive_real_multiple_preserves_positive_definite {n : ℕ} {A : Matrix (Fin n) (Fin n) ℂ}
    (hA : A.PosDef) {α : ℝ} (hα : 0 < α) : ((α : ℂ) • A).PosDef := by
  refine posDef_of_conjugateBilinearValue_pos (real_multiple_isHermitian α hA.isHermitian) fun x hx => ?_  -- エルミート性
  -- `A` が正定値なので `x^*Ax = r_ℂ` を満たす `r ∈ ℝ_{>0}` がある
  obtain ⟨r, hr, hrA⟩ := posDef_conjugateBilinearValue_pos hA hx
  exact ⟨α * r, mul_pos hα hr, conjugate_bilinear_value_of_positive_real_multiple α A x hrA⟩  -- 正の実数の積は正

end Ising2D
