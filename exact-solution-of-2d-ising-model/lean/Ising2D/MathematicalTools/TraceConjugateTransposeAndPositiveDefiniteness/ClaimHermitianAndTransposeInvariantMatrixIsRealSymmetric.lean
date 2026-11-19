/-
# エルミートかつ転置で不変な複素行列は実対称（具体版）

正本: `structured-latex/content/009_eigenvalues_of_V.ts`
（`eigenvalues_of_V_claim_hermitian_and_transpose_invariant_matrix_is_real_symmetric`、
ラベル **`hermitian_and_transpose_invariant_matrix_is_real_symmetric`**）。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `A_{kl} = (a, b)` を満たす `a, b ∈ ℝ` を取る（`definition_of_cc`） | `a := z.re`、`b := z.im`、`hab : z = ⟨a, b⟩`（`Complex.eta`） |
| 7 行の鎖の 3〜6 行目（共役転置の定義（`k → l`, `l → k`）→ `A^* = A` → `def_matrix_transpose` → `A^⊤ = A`） | `hermitian_and_transpose_invariant_matrix_is_real_symmetric` の `calc` の 4 段（`\overline{A_{kl}} = A_{kl}` を作る） |
| 7 行の鎖の 1・2・7 行目（`def_complex_conjugate`（`x → a`, `y → b`）→ `a, b` の取り方 → … → `a, b` の取り方） | `exists_real_of_star_eq` の 1 つ目の `calc` の 4 段（3 段目が、上の 3〜6 行目の結論 `h`） |
| 第 2 成分から `−b = b`（`ℂ = ℝ^2` の元の等号は成分ごと） | `congrArg Complex.im` |
| `b = 0` の 10 行の鎖（乗法の単位元 → 逆元 `2^{-1}·2 = 1`（`real_two_is_nonzero`）→ 乗法の結合律 → `def_real_two` → 分配則 → 乗法の単位元 → `−b = b` → 加法の可換則 → `def_real_difference` の加法の逆元 → `real_times_zero_is_zero`（`x → 2^{-1}`）） | `exists_real_of_star_eq` の 2 つ目の `calc` の 10 段（逆元の段は具体版 `real_two_is_nonzero`、最後の段は具体版 `real_times_zero_is_zero 2⁻¹`） |
| `A_{kl} = (a, b) = (a, 0) = a_ℂ` の 3 行と、`def_matrix_with_real_entries`（`r → a`） | `exists_real_of_star_eq` の 3 つ目の `calc` の 3 段と `⟨a, _⟩` |
| `A^⊤ = A` と合わせて `def_real_symmetric_complex_matrix` | `⟨_, hT⟩` |

- 人手の共役転置（`def_hermitian_positive_definite`）は mathlib の `Matrix.conjTranspose`（`Aᴴ k l = star (A l k)` が定義から `rfl`）、
  複素共役（`def_complex_conjugate`）は `ℂ` の `star`（`star ⟨x, y⟩ = ⟨x, -y⟩` が定義から `rfl`）、
  `inclusion_rr_to_cc` の `a_ℂ = (a, 0)` は `(a : ℂ) = ⟨a, 0⟩`（定義から `rfl`）である。
- 人手は `a, b` を取ってから 7 行の 1 本の鎖を書く。Lean はこの 1 本の鎖を `\overline{A_{kl}}` の行で 2 か所に分けた。
  3〜6 行目（`\overline{A_{kl}} = A_{kl}`。仮定 `A^* = A`・`A^⊤ = A` を使う段）を主定理の `calc` に、
  1・2・7 行目と `−b = b` 以降の段を、成分 `z := A_{kl}` と 3〜6 行目の結論 `\overline{z} = z` を受け取る補題 `exists_real_of_star_eq` に置く
  （`a, b` の取り方は補題の中で行う）。分けたのは、この補題が必要十分版の仮定 `hS`（共役で動かない元は性質 `S` に入る）を
  `ℂ` について与える段でもあり、具体版を必要十分版の特殊化として得るときに同じ補題を渡すためである。
- 人手の添字 `k, l ∈ {1, …, n}` は添字の型 `n` の元である（`DefinitionRealSymmetricComplexMatrix.lean` の注意）。

必要十分版は `Ising2D/NecSuf/StarFixedEntriesOfHermitianSymmetric.lean`、
具体版をその特殊化として得るのは `ClaimHermitianAndTransposeInvariantMatrixIsRealSymmetricFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionRealSymmetricComplexMatrix
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesZeroIsZero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTwoIsNonzero
import Mathlib.LinearAlgebra.Matrix.Hermitian

namespace Ising2D

open Matrix

/-- 人手の 7 行の鎖の 1・2・7 行目と、それ以降の段: `\overline{z} = z` を満たす `z ∈ ℂ` は `a_ℂ`（`a ∈ ℝ`）の形である。 -/
theorem exists_real_of_star_eq (z : ℂ) (h : star z = z) : ∃ a : ℝ, z = (a : ℂ) := by
  set a := z.re
  set b := z.im
  have hab : z = ⟨a, b⟩ := (Complex.eta z).symm                             -- `definition_of_cc` で `z = (a, b)` の `a, b` を取る
  have hpair : (⟨a, -b⟩ : ℂ) = ⟨a, b⟩ :=
    calc (⟨a, -b⟩ : ℂ)
        = star (⟨a, b⟩ : ℂ) := rfl                                          -- 鎖の 1 行目 `def_complex_conjugate`（`x → a`, `y → b`）
      _ = star z := by rw [← hab]                                           -- 鎖の 2 行目 `a, b` の取り方 `z = (a, b)`
      _ = z := h                                                            -- 鎖の 3〜6 行目（主定理の `calc`）
      _ = ⟨a, b⟩ := hab                                                     -- 鎖の 7 行目 `a, b` の取り方 `z = (a, b)`
  have hneg : -b = b := congrArg Complex.im hpair                           -- 第 2 成分（`ℂ = ℝ^2` の元の等号は成分ごと）
  have hb : b = 0 :=
    calc b
        = 1 * b := (one_mul b).symm                                         -- 乗法の単位元 `1·a = a`（`a → b`）を右辺から左辺へ
      _ = (2⁻¹ * 2) * b := by rw [inv_mul_cancel₀ real_two_is_nonzero]      -- 乗法の逆元 `a^{-1}·a = 1`（`a → 2`。`real_two_is_nonzero`）を右辺から左辺へ
      _ = 2⁻¹ * (2 * b) := mul_assoc _ _ _                                  -- 乗法の結合律
      _ = 2⁻¹ * ((1 + 1) * b) := by rw [one_add_one_eq_two]                 -- `def_real_two`
      _ = 2⁻¹ * (1 * b + 1 * b) := by rw [add_mul]                          -- 分配則 `(x + y)c = xc + yc`（`x, y → 1`, `c → b`）
      _ = 2⁻¹ * (b + b) := by rw [one_mul]                                  -- 乗法の単位元（`a → b`）を 2 か所へ同時に
      _ = 2⁻¹ * ((-b) + b) := by rw [hneg]                                  -- `-b = b` を右辺から左辺へ（和の第 1 項）
      _ = 2⁻¹ * (b + (-b)) := by rw [add_comm (-b) b]                       -- 加法の可換則
      _ = 2⁻¹ * 0 := by rw [add_neg_cancel]                                 -- `def_real_difference` の加法の逆元 `z + (-z) = 0`（`z → b`）
      _ = 0 := real_times_zero_is_zero 2⁻¹                                  -- `real_times_zero_is_zero`（`x → 2^{-1}`）
  refine ⟨a, ?_⟩                                                            -- `def_matrix_with_real_entries`（`r → a`）
  calc z
      = ⟨a, b⟩ := hab                                                       -- `a, b` の取り方
    _ = ⟨a, 0⟩ := by rw [hb]                                                -- `b = 0`
    _ = (a : ℂ) := rfl                                                      -- `inclusion_rr_to_cc`

/-- **人手 `hermitian_and_transpose_invariant_matrix_is_real_symmetric`**: `A^* = A` かつ `A^⊤ = A` なら `A` は実対称。 -/
theorem hermitian_and_transpose_invariant_matrix_is_real_symmetric {n : Type*} (A : Matrix n n ℂ)
    (hH : Aᴴ = A) (hT : Aᵀ = A) : MatrixIsRealSymmetric A := by
  refine ⟨fun k l => ?_, hT⟩
  have hconj : star (A k l) = A k l :=
    calc star (A k l)
        = Aᴴ l k := rfl                                                     -- `def_hermitian_positive_definite` の共役転置（`k → l`, `l → k`）
      _ = A l k := by rw [hH]                                               -- `A^* = A`
      _ = Aᵀ k l := rfl                                                     -- `def_matrix_transpose`（`p → k`, `q → l`）
      _ = A k l := by rw [hT]                                               -- `A^⊤ = A`
  exact exists_real_of_star_eq (A k l) hconj

end Ising2D
