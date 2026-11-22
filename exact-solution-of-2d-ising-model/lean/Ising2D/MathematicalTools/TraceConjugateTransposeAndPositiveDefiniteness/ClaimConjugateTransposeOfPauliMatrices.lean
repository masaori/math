/-
# 2 次の単位行列と Pauli 行列の共役転置（具体版）

正本: `structured-latex/content/009_eigenvalues_of_V.ts`

対応する人手証明:
- `conjugate_transpose_of_identity_matrix_of_order_two`: `I^* = I`（`I = I_{Mat(2,ℂ)}`。6 行の鎖）
- `conjugate_transpose_of_pauli_x`: `(σ^x)^* = σ^x`（4 行の鎖）
- `conjugate_transpose_of_pauli_z`: `(σ^z)^* = σ^z`（4 行の鎖）
- `conjugate_transpose_of_pauli_y`: `(σ^y)^* = σ^y`（準備の `\bar i = -i`（11 行）・`\overline{-i} = i`（12 行）と、6 行の鎖）

各 `calc` の段の根拠は人手の行末の根拠と同じである。共役転置の成分の式 `(A^*)_{kl} = \overline{A_{lk}}`
（`def_hermitian_positive_definite`）は mathlib の `Matrix.conjTranspose_apply` で読む。人手の `0_ℂ`・`1_ℂ`・`(-1)_ℂ` は
`inclusion_rr_to_cc` の略記 `r_ℂ`（`r = 0, 1, -1`）で、Lean の `(0 : ℂ)`・`(1 : ℂ)`・`(-1 : ℂ)` とは型の上で別の項なので、
`complex_conjugate_of_real_inclusion` を当てる段では `star_of_real_inclusion_abbrev` でその読み替えを挟む。
準備の `\bar i = -i` は、人手 `relation_of_gamma_2_theta_tilde` の「第二に」の同じ 11 行の鎖の具体版 `conj_I_eq_neg_I` を引く。

具体的な 2 次の行列の成分の計算なので、必要十分版は置かない（転置の `pauliX_transpose` ほかと同じ）。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionComplexConjugate
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealSymmetricMatrixIsHermitian
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionThetaGamma
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealDoubleNegation

namespace Ising2D

open Matrix

/-- 人手 `complex_conjugate_of_real_inclusion` を、略記 `r_ℂ` が Lean の別の項 `z` と書かれている成分へ当てる読み替え
（`r_ℂ = z` を仮定に取る）。 -/
private theorem star_of_real_inclusion_abbrev (r : ℝ) (z : ℂ) (hz : (r : ℂ) = z) : star z = z := by
  rw [← hz]
  exact complex_conjugate_of_real_inclusion r

private theorem real_inclusion_zero_abbrev : ((0 : ℝ) : ℂ) = (0 : ℂ) := Complex.ofReal_zero

private theorem real_inclusion_one_abbrev : ((1 : ℝ) : ℂ) = (1 : ℂ) := Complex.ofReal_one

private theorem real_inclusion_neg_one_abbrev : ((-1 : ℝ) : ℂ) = (-1 : ℂ) := by
  rw [Complex.ofReal_neg, Complex.ofReal_one]

/-- 人手 `conjugate_transpose_of_identity_matrix_of_order_two`: `I^* = I`（`I = I_{Mat(2,ℂ)}`）。 -/
theorem identity_matrix_two_conjTranspose : (1 : Matrix (Fin 2) (Fin 2) ℂ)ᴴ = 1 := by
  calc
    -- `def_hermitian_positive_definite`（`n = 2`）
    (1 : Matrix (Fin 2) (Fin 2) ℂ)ᴴ =
        !![star ((1 : Matrix (Fin 2) (Fin 2) ℂ) 0 0), star ((1 : Matrix (Fin 2) (Fin 2) ℂ) 1 0);
          star ((1 : Matrix (Fin 2) (Fin 2) ℂ) 0 1), star ((1 : Matrix (Fin 2) (Fin 2) ℂ) 1 1)] := by
      ext p q
      rw [Matrix.conjTranspose_apply]
      fin_cases p <;> fin_cases q <;> rfl
    -- `def_identity_matrix`（`n = 2`）
    _ = !![star (kroneckerDelta (0 : Fin 2) 0), star (kroneckerDelta (1 : Fin 2) 0);
          star (kroneckerDelta (0 : Fin 2) 1), star (kroneckerDelta (1 : Fin 2) 1)] := by
      simp only [identity_matrix_apply]
    -- `def_kronecker_delta`
    _ = !![star (1 : ℂ), star 0; star 0, star 1] := by
      rw [kroneckerDelta_self, kroneckerDelta_self, kroneckerDelta_of_ne (by decide),
        kroneckerDelta_of_ne (by decide)]
    -- `complex_conjugate_of_real_inclusion` を `r = 1, 0` で 4 成分へ同時に
    _ = !![(1 : ℂ), 0; 0, 1] := by
      rw [star_of_real_inclusion_abbrev 1 1 real_inclusion_one_abbrev,
        star_of_real_inclusion_abbrev 0 0 real_inclusion_zero_abbrev]
    -- `def_kronecker_delta`
    _ = _ := twoByTwo_one_eq_kroneckerDelta
    -- `def_identity_matrix`（`n = 2`）
    _ = 1 := twoByTwo_kroneckerDelta_eq_identity

/-- 人手 `conjugate_transpose_of_pauli_x`: `(σ^x)^* = σ^x`。 -/
@[simp]
theorem pauliX_conjTranspose : pauliXᴴ = pauliX := by
  calc
    -- `def_hermitian_positive_definite`（`n = 2`）
    pauliXᴴ = !![star (pauliX 0 0), star (pauliX 1 0); star (pauliX 0 1), star (pauliX 1 1)] := by
      ext p q
      rw [Matrix.conjTranspose_apply]
      fin_cases p <;> fin_cases q <;> rfl
    -- `def_pauli_matrices` の σ^x の成分
    _ = !![star (0 : ℂ), star 1; star 1, star 0] := rfl
    -- `complex_conjugate_of_real_inclusion` を `r = 0, 1` で 4 成分へ同時に
    _ = !![(0 : ℂ), 1; 1, 0] := by
      rw [star_of_real_inclusion_abbrev 0 0 real_inclusion_zero_abbrev,
        star_of_real_inclusion_abbrev 1 1 real_inclusion_one_abbrev]
    -- `def_pauli_matrices` の σ^x
    _ = pauliX := rfl

/-- 人手 `conjugate_transpose_of_pauli_z`: `(σ^z)^* = σ^z`。 -/
@[simp]
theorem pauliZ_conjTranspose : pauliZᴴ = pauliZ := by
  calc
    -- `def_hermitian_positive_definite`（`n = 2`）
    pauliZᴴ = !![star (pauliZ 0 0), star (pauliZ 1 0); star (pauliZ 0 1), star (pauliZ 1 1)] := by
      ext p q
      rw [Matrix.conjTranspose_apply]
      fin_cases p <;> fin_cases q <;> rfl
    -- `def_pauli_matrices` の σ^z の成分
    _ = !![star (1 : ℂ), star 0; star 0, star (-1)] := rfl
    -- `complex_conjugate_of_real_inclusion` を `r = 1, 0, -1` で 4 成分へ同時に
    _ = !![(1 : ℂ), 0; 0, -1] := by
      rw [star_of_real_inclusion_abbrev 1 1 real_inclusion_one_abbrev,
        star_of_real_inclusion_abbrev 0 0 real_inclusion_zero_abbrev,
        star_of_real_inclusion_abbrev (-1) (-1) real_inclusion_neg_one_abbrev]
    -- `def_pauli_matrices` の σ^z
    _ = pauliZ := rfl

/-- 人手 `conjugate_transpose_of_pauli_y` の準備の `\overline{-i} = i`（12 行の鎖）。 -/
theorem star_neg_I_eq_I : star (-Complex.I) = Complex.I :=
  calc star (-Complex.I)
      = star ((-1 : ℂ) * Complex.I) := by
        rw [neg_one_mul]                                       -- 1 行目: `multiply_by_minus_one`
    _ = star ((-1 : ℂ) * (⟨0, 1⟩ : ℂ)) := rfl                 -- 2 行目: `def_imaginary_unit` の `i := (0,1)`
    _ = star (((-1 : ℝ) : ℂ) * (⟨0, 1⟩ : ℂ)) := by
        rw [real_inclusion_neg_one_abbrev]                     -- 3 行目の読み: `-1_ℂ` を `(-1)_ℂ` と読む（`inclusion_rr_to_cc` の略記）
    _ = star ((⟨-1, 0⟩ : ℂ) * (⟨0, 1⟩ : ℂ)) := rfl            -- 3 行目: `inclusion_rr_to_cc` の `(-1)_ℂ = (-1,0)`
    _ = star (⟨(-1) * 0 - 0 * 1, (-1) * 1 + 0 * 0⟩ : ℂ) := rfl -- 4 行目: `definition_of_cc` の積
    _ = star (⟨(-1) * 0 - 0, (-1) * 1 + 0 * 0⟩ : ℂ) := by
        rw [real_zero_times_is_zero 1]                         -- 5 行目: `real_zero_times_is_zero`（`x → 1`）
    _ = star (⟨0 - 0, (-1) * 1 + 0⟩ : ℂ) := by
        rw [real_times_zero_is_zero (-1), real_times_zero_is_zero 0]
                                                               -- 6 行目: `real_times_zero_is_zero` を 2 箇所へ（`x → -1, 0`）
    _ = star (⟨0, (-1) * 1 + 0⟩ : ℂ) := by
        rw [real_minus_zero_is_self 0]                         -- 7 行目: `real_minus_zero_is_self`（`a → 0`）
    _ = star (⟨0, (-1) * 1⟩ : ℂ) := by rw [add_zero]          -- 8 行目: `0` は `ℝ` の加法の単位元 `x + 0 = x`（`x → (-1) * 1`）
    _ = star (⟨0, -1⟩ : ℂ) := by rw [mul_one]                 -- 9 行目: `1` は `ℝ` の乗法の単位元 `x * 1 = x`（`x → -1`）
    _ = (⟨0, -(-1)⟩ : ℂ) := complex_star_mk _ _
                                                               -- 10 行目: `def_complex_conjugate`
    _ = (⟨0, 1⟩ : ℂ) := by rw [real_double_negation 1]        -- 11 行目: `real_double_negation`（`a → 1`）
    _ = Complex.I := rfl                                       -- 12 行目: `def_imaginary_unit` の `i := (0,1)`

/-- 人手 `conjugate_transpose_of_pauli_y`: `(σ^y)^* = σ^y`。 -/
@[simp]
theorem pauliY_conjTranspose : pauliYᴴ = pauliY := by
  calc
    -- `def_hermitian_positive_definite`（`n = 2`）
    pauliYᴴ = !![star (pauliY 0 0), star (pauliY 1 0); star (pauliY 0 1), star (pauliY 1 1)] := by
      ext p q
      rw [Matrix.conjTranspose_apply]
      fin_cases p <;> fin_cases q <;> rfl
    -- `def_pauli_matrices` の σ^y の成分
    _ = !![star (0 : ℂ), star Complex.I; star (-Complex.I), star 0] := rfl
    -- `complex_conjugate_of_real_inclusion` を `r = 0` で 2 成分へ同時に
    _ = !![(0 : ℂ), star Complex.I; star (-Complex.I), 0] := by
      rw [star_of_real_inclusion_abbrev 0 0 real_inclusion_zero_abbrev]
    -- 準備の `\bar i = -i`（人手 `relation_of_gamma_2_theta_tilde` の「第二に」と同じ 11 行の鎖。具体版は `conj_I_eq_neg_I`）
    _ = !![(0 : ℂ), -Complex.I; star (-Complex.I), 0] := by
      rw [conj_I_eq_neg_I]
    -- 準備の `\overline{-i} = i`
    _ = !![(0 : ℂ), -Complex.I; Complex.I, 0] := by
      rw [star_neg_I_eq_I]
    -- `def_pauli_matrices` の σ^y
    _ = pauliY := rfl

end Ising2D
