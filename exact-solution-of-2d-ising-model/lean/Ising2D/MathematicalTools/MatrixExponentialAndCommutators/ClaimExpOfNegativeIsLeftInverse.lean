/-
# `exp(-A)exp(A) = I`（**具体版**）

対応する人手証明のラベル: `exp_of_negative_is_left_inverse`
（`structured-latex/content/009_eigenvalues_of_V.ts` の `eigenvalues_of_V_claim_exp_of_negative_is_left_inverse`）。

**必要十分版**: `Ising2D/NecSuf/ExpNegMulExp.lean`。具体版をその系として導くのは
`ClaimExpOfNegativeIsLeftInverseFromNecSuf.lean`（`TensorPow M` の系もそこに置く）。

## 人手証明との対応

| 人手 | Lean（具体版） | 必要十分版の対応する補題 |
| --- | --- | --- |
| 準備の第一の鎖 `((-A)A)_{kl} = … = (A(-A))_{kl}` の 8 行 | `neg_matrix_mul_self_apply` の `calc` の 8 段 | `neg_matrix_mul_self_apply'`（4 段目の積の可換律は `neg_one_mul_comm'`） |
| 「なので `(-A)A = A(-A)`」 | `neg_matrix_mul_self_comm`（`Matrix.ext`） | `neg_matrix_mul_self_comm'` |
| 準備の第二の鎖 `((-A)+A)_{kl} = … = O_{kl}` の 11 行 | `neg_matrix_add_self_apply` の `calc` の 11 段 | `neg_matrix_add_self_apply'`（`(-1)+1 = 0` の 4 段は 1 段） |
| 「なので `(-A)+A = O`」 | `neg_matrix_add_self`（`Matrix.ext`） | `neg_matrix_add_self'` |
| 指数の鎖の 3 行 | `matrixExp_neg_mul_matrixExp` の `calc` の 3 段 | `matrixExp_neg_mul_matrixExp'` |

- 成分の式との接点は `matrix_mul_apply_sum`（`mat_mult`）・`matrix_neg_apply`（`def_matrix_negation`）・
  `matrix_sum_apply`（`def_matrix_sum`）・`matrix_zero_apply`（`def_zero_matrix`）である。
- 人手の `-z := (-1_ℂ)·z`（`multiply_by_minus_one`）は、Lean の `ℂ` の符号反転が積で定義されていないので `neg_one_mul` で出す。
  「各項へ」の段は `Finset.sum_congr` で各項に同じ等式を当てる。
- 人手の `(-1, 0) + (1, 0) = (-1+1, 0+0)`（`definition_of_cc` の和）は、mathlib の `ℂ` の和の定義と同じ式なので `rfl`、
  `(-1_ℂ) = (-1, 0)`・`(0,0) = 0_ℂ`（`inclusion_rr_to_cc`）は構造体の欄ごとの等号（`Complex.ext`）、
  `ℝ` の四則 `-1+1 = 0`・`0+0 = 0` も欄ごとの等号で出す。
- 指数の鎖の 1 行目 `theorem_exp_product`（`K = ℂ`）と 3 行目 `theorem_exp_zero` は Lean の具体版が無く、
  mathlib の `Matrix.exp_add_of_commute`・`NormedSpace.exp_zero` を引く（`theorem_exp_product` の仮定 `AB = BA` には
  準備の `neg_matrix_mul_self_comm` をそのまま渡す）。
- 人手の `n ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、主張はそのまま成り立つ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

namespace Ising2D

open Matrix

/-- **`exp_of_negative_is_left_inverse`** の準備の第一の鎖: `((-A)A)_{kl} = (A(-A))_{kl}`。 -/
theorem neg_matrix_mul_self_apply {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (k l : Fin n) :
    ((-A) * A) k l = (A * (-A)) k l :=
  calc ((-A) * A) k l
      = ∑ j, (-A) k j * A j l := matrix_mul_apply_sum _ _ _ _                  -- `mat_mult`
    _ = ∑ j, (-A k j) * A j l :=                                                -- `def_matrix_negation` を各項へ
        Finset.sum_congr rfl (fun j _ => by rw [matrix_neg_apply])
    _ = ∑ j, ((-1) * A k j) * A j l :=                                          -- `multiply_by_minus_one` を各項へ
        Finset.sum_congr rfl (fun j _ => by rw [neg_one_mul])
    _ = ∑ j, (A k j * (-1)) * A j l :=                                          -- 積の可換律を各項へ（`complex_numbers_form_a_field`）
        Finset.sum_congr rfl (fun j _ => by rw [mul_comm (-1 : ℂ) (A k j)])
    _ = ∑ j, A k j * ((-1) * A j l) :=                                          -- 積の結合律を各項へ（`complex_numbers_form_a_field`）
        Finset.sum_congr rfl (fun j _ => mul_assoc _ _ _)
    _ = ∑ j, A k j * (-A j l) :=                                                -- `multiply_by_minus_one` を各項へ
        Finset.sum_congr rfl (fun j _ => by rw [neg_one_mul])
    _ = ∑ j, A k j * (-A) j l :=                                                -- `def_matrix_negation` を各項へ
        Finset.sum_congr rfl (fun j _ => by rw [matrix_neg_apply])
    _ = (A * (-A)) k l := (matrix_mul_apply_sum _ _ _ _).symm                  -- `mat_mult`

/-- 準備の「なので `(-A)A = A(-A)`」。 -/
theorem neg_matrix_mul_self_comm {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) :
    (-A) * A = A * (-A) :=
  Matrix.ext (neg_matrix_mul_self_apply A)   -- 全ての成分が一致する

/-- **`exp_of_negative_is_left_inverse`** の準備の第二の鎖: `((-A)+A)_{kl} = O_{kl}`。 -/
theorem neg_matrix_add_self_apply {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (k l : Fin n) :
    ((-A) + A) k l = (0 : Matrix (Fin n) (Fin n) ℂ) k l :=
  calc ((-A) + A) k l
      = (-A) k l + A k l := matrix_sum_apply _ _ _ _                           -- `def_matrix_sum`
    _ = (-A k l) + A k l := by rw [matrix_neg_apply]                           -- `def_matrix_negation`
    _ = (-1) * A k l + A k l := by rw [neg_one_mul]                            -- `multiply_by_minus_one`
    _ = (-1) * A k l + 1 * A k l := by rw [one_mul]                            -- `1_ℂ` は乗法の単位元（`complex_numbers_form_a_field`）
    _ = ((-1) + 1) * A k l := (add_mul _ _ _).symm                             -- 分配律（`complex_numbers_form_a_field`）
    _ = ((⟨-1, 0⟩ : ℂ) + ⟨1, 0⟩) * A k l := by                                -- `inclusion_rr_to_cc`
        -- `1_ℂ = (1, 0)` は定義上の等号。Lean の `-1 : ℂ` は `1_ℂ` の符号反転なので、欄は ℂ の符号反転の定義で読む
        congr 2
        exact Complex.ext (by rw [Complex.neg_re, Complex.one_re]) (by rw [Complex.neg_im, Complex.one_im, neg_zero])
    _ = (⟨-1 + 1, 0 + 0⟩ : ℂ) * A k l := rfl                                   -- `definition_of_cc` の和
    _ = (⟨0, 0⟩ : ℂ) * A k l := by                                             -- ℝ の四則
        congr 1; exact Complex.ext (neg_add_cancel (1 : ℝ)) (add_zero (0 : ℝ))
    _ = 0 * A k l := rfl                                                       -- `inclusion_rr_to_cc`
    _ = 0 := zero_mul _                                                        -- `complex_zero_times_is_zero`
    _ = (0 : Matrix (Fin n) (Fin n) ℂ) k l := (matrix_zero_apply _ _).symm    -- `def_zero_matrix`

/-- 準備の「なので `(-A)+A = O`」。 -/
theorem neg_matrix_add_self {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) :
    (-A) + A = 0 :=
  Matrix.ext (neg_matrix_add_self_apply A)   -- 全ての成分が一致する

/-- **`exp_of_negative_is_left_inverse`**: `exp(-A)exp(A) = I`。 -/
theorem matrixExp_neg_mul_matrixExp {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) :
    NormedSpace.exp (-A) * NormedSpace.exp A = 1 :=
  calc NormedSpace.exp (-A) * NormedSpace.exp A
      = NormedSpace.exp ((-A) + A) :=                                          -- `theorem_exp_product`（`K = ℂ`）と準備の `(-A)A = A(-A)`
        (Matrix.exp_add_of_commute (-A) A (neg_matrix_mul_self_comm A)).symm
    _ = NormedSpace.exp (0 : Matrix (Fin n) (Fin n) ℂ) := by                   -- 準備の `(-A)+A = O`
        rw [neg_matrix_add_self]
    _ = 1 := NormedSpace.exp_zero                                              -- `theorem_exp_zero`

end Ising2D
