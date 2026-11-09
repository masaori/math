/-
# 左逆行列をもつ `B` による `B^*(AB)` は正定値（**具体版**）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `conjugate_bilinear_value_of_congruence`（`x^*(B^*(AB))y = (Bx)^*A(By)`）
- `congruence_preserves_positive_definite`

人手の `x^*Ay` は `def_conjugate_bilinear_value`（Lean の `conjugateBilinearValue`）、共役転置・エルミート・正定値は
`def_hermitian_positive_definite`（mathlib の `Matrix.conjTranspose`・`Matrix.PosDef` と同じもの。読み替えは
`ClaimTraceOfPositiveDefiniteIsPositive.lean` の `dotProduct_mulVec_eq_conjugateBilinearValue`・`posDef_conjugateBilinearValue_pos`
と、このファイルの `posDef_of_conjugateBilinearValue_pos`）による。

**必要十分版**: `Ising2D/NecSuf/CongruencePreservesPositiveDefinite.lean`。具体版をその特殊化として導くのと、
`TensorPow M`（添字 `Conf M`）の系は `ClaimCongruencePreservesPositiveDefiniteFromNecSuf.lean` に置く。

## 人手証明との対応

| 人手 | Lean（具体版） |
| --- | --- |
| `conjugate_bilinear_value_of_congruence` の 14 行の鎖 | `conjugate_bilinear_value_of_congruence` の `calc` の 14 段 |
| 準備の `(B^*)^* = B` の 6 行の成分の鎖 | `conjTranspose_conjTranspose_apply` の `calc` の 6 段、`conjTranspose_conjTranspose_eq` |
| 準備の `B'0 = 0` の 5 行の成分の鎖 | `mulVec_zero_apply` の `calc` の 5 段、`mulVec_zero_eq` |
| エルミート性の 5 行の鎖 | `congruence_isHermitian` の `calc` の 5 段 |
| 正値性の `Bx = 0` を仮定した 5 行の鎖（背理法） | `mulVec_ne_zero_of_left_inverse` の `calc` の 5 段 |
| 正値性の最後の 2 行の鎖と `x^*(B^*(AB))x ∈ ℝ_{>0}` | `congruence_preserves_positive_definite` の `calc` の 2 段 |

- 人手の `complex_conjugate_of_product`・`complex_conjugate_of_sum` の具体版（`MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimComplexConjugateOfSumProductDifference.lean`）は `starRingEnd ℂ` の形で、
  有限和は添字 `Fin (m + 1)` の和である。このファイルは `star` の形で、和の添字が `Fin n`（`n = 0` を含む）なので、まだ同じ主張の mathlib の一段の補題
  `star_mul'`・`star_sum` を引く（具体版への差し替えは状態台帳の残り）。`star_preserves_norm_and_limits` (1) の第 1 式（`(AB)^* = B^*A^*`）は具体版
  `matrix_conjTranspose_mul`（`ClaimStarPreservesNormAndLimits.lean`）を引く。`mat_mult_associative` も具体版が無いので、既存の慣行どおり `Matrix.mul_assoc`
  （行列と数ベクトルの積では `Matrix.mulVec_mulVec`）を 1 段に 1 回ずつ引く。
- 人手の鎖の「分配律を項の数だけ繰り返す」「加法の結合律・交換律による有限和の順序の入れ替え」（`complex_numbers_form_a_field`）は、
  mathlib の `Finset.mul_sum`・`Finset.sum_mul`・`Finset.sum_comm` を、人手と同じ 1 行に当たる段の中でだけ使う。
- 人手の `n ∈ ℤ_{≥1}` は効かないので仮定に置かない（`n = 0` でも主張は成り立つ）。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfPositiveDefiniteIsPositive
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimStarPreservesNormAndLimits

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-- `def_hermitian_positive_definite` の正定値の条件の逆向きの読み: 人手の `x^*Ax ∈ ℝ_{>0}`（`x^*Ax = r_ℂ` を満たす
`r ∈ ℝ_{>0}` がある）から mathlib の `0 < star x ⬝ᵥ (A *ᵥ x)` を得る（`ℂ` の順序 `ComplexOrder` で `0 < r_ℂ ↔ 0 < r`）。 -/
theorem posDef_of_conjugateBilinearValue_pos {n : ℕ} {A : Matrix (Fin n) (Fin n) ℂ} (hH : A.IsHermitian)
    (hpos : ∀ x : Fin n → ℂ, x ≠ 0 → ∃ r : ℝ, 0 < r ∧ conjugateBilinearValue x A x = (r : ℂ)) :
    A.PosDef := by
  refine Matrix.PosDef.of_dotProduct_mulVec_pos hH fun x hx => ?_
  obtain ⟨r, hr, hval⟩ := hpos x hx
  rw [dotProduct_mulVec_eq_conjugateBilinearValue, hval]
  exact Complex.zero_lt_real.mpr hr

/-- **人手 `conjugate_bilinear_value_of_congruence`**: `x^*(B^*(AB))y = (Bx)^*A(By)`（14 行の鎖と同じ並び）。 -/
theorem conjugate_bilinear_value_of_congruence {n : ℕ} (A B : Matrix (Fin n) (Fin n) ℂ) (x y : Fin n → ℂ) :
    conjugateBilinearValue x (Bᴴ * (A * B)) y = conjugateBilinearValue (B *ᵥ x) A (B *ᵥ y) :=
  calc conjugateBilinearValue x (Bᴴ * (A * B)) y
      = ∑ k, ∑ l, (star (x k) * (Bᴴ * (A * B)) k l) * y l := rfl                -- `def_conjugate_bilinear_value`
    _ = ∑ k, ∑ l, (star (x k) * ∑ j, Bᴴ k j * (A * B) j l) * y l := by
        simp only [matrix_mul_apply_sum Bᴴ (A * B)]                               -- `mat_mult`
    _ = ∑ k, ∑ l, (star (x k) * ∑ j, star (B j k) * (A * B) j l) * y l := rfl   -- `def_hermitian_positive_definite` を各項へ
    _ = ∑ k, ∑ l, (star (x k) * ∑ j, star (B j k) * ∑ m, A j m * B m l) * y l := by
        simp only [matrix_mul_apply_sum A B]                                      -- `mat_mult` を各項へ
    _ = ∑ k, ∑ l, ∑ j, ∑ m, (star (x k) * (star (B j k) * (A j m * B m l))) * y l := by
        simp only [Finset.mul_sum, Finset.sum_mul]                                -- 分配律を項の数だけ繰り返す
    _ = ∑ k, ∑ l, ∑ j, ∑ m, star (x k) * star (B j k) * A j m * B m l * y l := by
        simp only [← mul_assoc]                                                   -- 積の結合律を各項へ
    _ = ∑ j, ∑ m, ∑ k, ∑ l, star (x k) * star (B j k) * A j m * B m l * y l := by
        -- 加法の結合律・交換律による有限和の順序の入れ替え（`k,l,j,m` → `j,m,k,l`）
        refine (Finset.sum_congr rfl fun _ _ => Finset.sum_comm).trans ?_          -- `k,l,j,m` → `k,j,l,m`
        refine (Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
          Finset.sum_comm).trans ?_                                               -- `k,j,l,m` → `k,j,m,l`
        refine Finset.sum_comm.trans ?_                                           -- `k,j,m,l` → `j,k,m,l`
        exact Finset.sum_congr rfl fun _ _ => Finset.sum_comm                     -- `j,k,m,l` → `j,m,k,l`
    _ = ∑ j, ∑ m, ∑ k, ∑ l, star (B j k) * star (x k) * A j m * B m l * y l := by
        simp only [mul_comm (star (x _)) (star (B _ _))]                          -- 積の可換律を各項へ
    _ = ∑ j, ∑ m, ∑ k, ∑ l, (star (B j k) * star (x k) * A j m) * (B m l * y l) := by
        simp only [mul_assoc (star (B _ _) * star (x _) * A _ _)]                 -- 積の結合律を各項へ
    _ = ∑ j, ∑ m, (∑ k, star (B j k) * star (x k)) * A j m * (∑ l, B m l * y l) := by
        -- 分配律を項の数だけ繰り返す
        refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun m _ => ?_
        rw [Finset.sum_mul, Finset.sum_mul_sum]
    _ = ∑ j, ∑ m, (∑ k, star (B j k * x k)) * A j m * (∑ l, B m l * y l) := by
        simp only [star_mul']                                                     -- `complex_conjugate_of_product` を各項へ
    _ = ∑ j, ∑ m, star (∑ k, B j k * x k) * A j m * (∑ l, B m l * y l) := by
        simp only [star_sum]                                                      -- `complex_conjugate_of_sum` の `m = n`
    _ = ∑ j, ∑ m, star ((B *ᵥ x) j) * A j m * (B *ᵥ y) m := by
        simp only [mulVec_apply_sum B]                                            -- `mat_mult`
    _ = conjugateBilinearValue (B *ᵥ x) A (B *ᵥ y) := rfl                         -- `def_conjugate_bilinear_value`

/-- 人手 `congruence_preserves_positive_definite` の準備の成分の鎖: `((B^*)^*)_{kl} = B_{kl}`
（`B_{kl} = (a,b)`、`a, b ∈ ℝ` と書いて 6 行）。 -/
theorem conjTranspose_conjTranspose_apply {n : ℕ} (B : Matrix (Fin n) (Fin n) ℂ) (k l : Fin n) :
    Bᴴᴴ k l = B k l :=
  calc Bᴴᴴ k l
      = star (Bᴴ l k) := rfl                                                      -- `def_hermitian_positive_definite`
    _ = star (star (B k l)) := rfl                                                -- `def_hermitian_positive_definite`
    _ = star (⟨(B k l).re, -(B k l).im⟩ : ℂ) := rfl                              -- `def_complex_conjugate`
    _ = ⟨(B k l).re, -(-(B k l).im)⟩ := rfl                                      -- `def_complex_conjugate`
    _ = ⟨(B k l).re, (B k l).im⟩ := by rw [neg_neg]                              -- `ℝ` で `-(-b) = b`
    _ = B k l := rfl                                                              -- `B_{kl} = (a,b)` の置き方

/-- 人手の準備の `(B^*)^* = B`（全ての成分が等しい）。 -/
theorem conjTranspose_conjTranspose_eq {n : ℕ} (B : Matrix (Fin n) (Fin n) ℂ) : Bᴴᴴ = B :=
  Matrix.ext (conjTranspose_conjTranspose_apply B)

/-- 人手 `congruence_preserves_positive_definite` の準備の成分の鎖: `(B'0)_k = 0_k`（5 行）。 -/
theorem mulVec_zero_apply {n : ℕ} (B' : Matrix (Fin n) (Fin n) ℂ) (k : Fin n) :
    (B' *ᵥ (0 : Fin n → ℂ)) k = (0 : Fin n → ℂ) k :=
  calc (B' *ᵥ (0 : Fin n → ℂ)) k
      = ∑ j, B' k j * (0 : Fin n → ℂ) j := mulVec_apply_sum B' 0 k              -- `mat_mult`
    _ = ∑ j, B' k j * (0 : ℂ) := by simp only [vec_zero_apply]                   -- `def_zero_matrix` を各項へ
    _ = ∑ _j : Fin n, (0 : ℂ) := by simp only [mul_zero]                         -- `complex_times_zero_is_zero` を各項へ
    _ = 0 := Finset.sum_const_zero                                                -- `finite_sum_of_complex_zeros`
    _ = (0 : Fin n → ℂ) k := (vec_zero_apply k).symm                              -- `def_zero_matrix`

/-- 人手の準備の `B'0 = 0`（全ての成分が等しい）。 -/
theorem mulVec_zero_eq {n : ℕ} (B' : Matrix (Fin n) (Fin n) ℂ) : B' *ᵥ (0 : Fin n → ℂ) = 0 :=
  funext (mulVec_zero_apply B')

/-- 人手 `congruence_preserves_positive_definite` のエルミート性の 5 行の鎖: `(B^*(AB))^* = B^*(AB)`。 -/
theorem congruence_isHermitian {n : ℕ} {A : Matrix (Fin n) (Fin n) ℂ} (hA : Aᴴ = A)
    (B : Matrix (Fin n) (Fin n) ℂ) : (Bᴴ * (A * B))ᴴ = Bᴴ * (A * B) :=
  calc (Bᴴ * (A * B))ᴴ
      = (A * B)ᴴ * Bᴴᴴ := matrix_conjTranspose_mul _ _                           -- `star_preserves_norm_and_limits` (1) の第 1 式
    _ = (Bᴴ * Aᴴ) * Bᴴᴴ := by rw [matrix_conjTranspose_mul A B]                 -- `star_preserves_norm_and_limits` (1) の第 1 式
    _ = (Bᴴ * A) * Bᴴᴴ := by rw [hA]                                             -- `A` は正定値なのでエルミート、`A^* = A`
    _ = (Bᴴ * A) * B := by rw [conjTranspose_conjTranspose_eq B]                -- 準備の `(B^*)^* = B`
    _ = Bᴴ * (A * B) := Matrix.mul_assoc _ _ _                                    -- `mat_mult_associative`

/-- 人手 `congruence_preserves_positive_definite` の正値性の前半: `B'B = I`、`x ≠ 0` なら `Bx ≠ 0`
（`Bx = 0` と仮定した 5 行の鎖が `x = 0` を与え、`x ≠ 0` に反する）。 -/
theorem mulVec_ne_zero_of_left_inverse {n : ℕ} {B B' : Matrix (Fin n) (Fin n) ℂ} (hB : B' * B = 1)
    {x : Fin n → ℂ} (hx : x ≠ 0) : B *ᵥ x ≠ 0 := by
  intro hBx
  apply hx
  calc x
      = (1 : Matrix (Fin n) (Fin n) ℂ) *ᵥ x := (identity_matrix_mulVec x).symm   -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = (B' * B) *ᵥ x := by rw [hB]                                               -- `B'B = I`
    _ = B' *ᵥ (B *ᵥ x) := (Matrix.mulVec_mulVec _ _ _).symm                       -- `mat_mult_associative`
    _ = B' *ᵥ 0 := by rw [hBx]                                                    -- `Bx = 0` の仮定
    _ = 0 := mulVec_zero_eq B'                                                    -- 準備の `B'0 = 0`

/-- **人手 `congruence_preserves_positive_definite`**: `A` が正定値で `B'B = I` なら `B^*(AB)` は正定値。 -/
theorem congruence_preserves_positive_definite {n : ℕ} {A B B' : Matrix (Fin n) (Fin n) ℂ}
    (hA : A.PosDef) (hB : B' * B = 1) : (Bᴴ * (A * B)).PosDef := by
  refine posDef_of_conjugateBilinearValue_pos (congruence_isHermitian hA.isHermitian.eq B) fun x hx => ?_
  -- `Bx ≠ 0` なので、`A` が正定値なので `(Bx)^*A(Bx) = r_ℂ` を満たす `r ∈ ℝ_{>0}` がある
  obtain ⟨r, hr, hrA⟩ := posDef_conjugateBilinearValue_pos hA (mulVec_ne_zero_of_left_inverse hB hx)
  refine ⟨r, hr, ?_⟩
  calc conjugateBilinearValue x (Bᴴ * (A * B)) x
      = conjugateBilinearValue (B *ᵥ x) A (B *ᵥ x) :=
        conjugate_bilinear_value_of_congruence A B x x                            -- `conjugate_bilinear_value_of_congruence` の `y = x`
    _ = (r : ℂ) := hrA                                                            -- `r` の取り方

end Ising2D
