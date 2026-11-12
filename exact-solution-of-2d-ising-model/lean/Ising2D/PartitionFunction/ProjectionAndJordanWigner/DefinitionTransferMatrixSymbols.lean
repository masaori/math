/-
# 転送行列の記号の定義（サイト局所作用素と Jordan–Wigner 文字列）

対応する人手証明:
`parts/004_転送行列/000_definition_転送行列の記号の定義.typ` (`<def_transfer_matrix_symbols>`)
（Pauli 行列そのものの成分表示は
`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` の証明冒頭にある）

Pauli 行列の積の 6 式（`pauliX_mul_pauliX`・`pauliY_mul_pauliY`・`pauliZ_mul_pauliZ`・`pauliZ_mul_pauliX`・
`pauliY_mul_pauliX`・`pauliY_mul_pauliZ_anticomm`）は、人手 `pauli_matrix_products`
（`structured-latex/content/006_Z_Y_anticommutation.ts`）の証明の鎖と 1 段ずつ対応する。準備の鎖は
`neg_I_mul_I`・`I_mul_neg_I`・`pauliX_mul_pauliZ_entries`・`pauliX_mul_pauliY_entries`・`pauliZ_mul_pauliY_entries`、
`σ^xσ^x = I`・`σ^yσ^y = I`・`σ^zσ^z = I` の 3 つの鎖に共通の最後の 2 段は `twoByTwo_one_eq_kroneckerDelta`・`twoByTwo_kroneckerDelta_eq_identity` である。

2 次の行列の転置の 4 つの主張（人手 `transpose_of_identity_matrix_of_order_two`・`transpose_of_pauli_x`・`transpose_of_pauli_z`・
`transpose_of_pauli_y`、同じファイル）は `identity_matrix_two_transpose`・`pauliX_transpose`・`pauliZ_transpose`・`pauliY_transpose` で、
人手の鎖と 1 段ずつ対応する（転置の成分の式は `matrix_transpose_apply`（`def_matrix_transpose`））。具体的な 2 次の行列の成分の計算なので、
必要十分版は置かない。

本ファイルでは、原文の記号のうち

* `σ^x_k, σ^y_k, σ^z_k`（第 `k` 因子だけが Pauli 行列で残りが単位行列のテンソル積）
* Jordan–Wigner 文字列 `Z_m = σ^x_1 ⋯ σ^x_{m-1} σ^z_m`（`Z_1 = σ^z_1`）、
  `Y_m = σ^x_1 ⋯ σ^x_{m-1} σ^y_m`（`Y_1 = σ^y_1`）
* `ε = σ^x_1 ⋯ σ^x_M`

を、`Ising2D/Basic.lean` で確定した表現 `TensorPow M = Matrix (Conf M) (Conf M) ℂ` 上で定義する。

## 添字づけの規約（原文との差）

原文はサイトを `1, …, M` で番号づけるが、Lean では `Fin M`（`0, …, M-1`）を使う。
対応は `原文の m` ↔ `Lean の ⟨m-1, _⟩`。したがって原文の `Z_1 = σ^z_1`（空の文字列）は
Lean では `Z 0 = sigmaZ 0` にあたり、`xString` の値が `1` になることで自動的に満たされる
（原文が場合分けとして書いている `Z_1 := σ^z_1` は、Lean では特別扱い不要）。

原文の `Z_{M+1} := Z_1`（周期性）は `Fin M` 上では添字の巡回そのものなので、
定義としては現れない（必要になる箇所で `Fin M` の演算として扱う）。

## 原文の記述に対する疑義（要確認）

`<def_transfer_matrix_symbols>` の
`ε := σ^x_1 ⋯ σ^x_M = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M`
は **和ではなく積** `(√-1)^M Z_1 Y_1 ⋯ Z_M Y_M` でなければならない。
実際 `Z_m Y_m = σ^z_m σ^y_m = -√-1 σ^x_m` なので

  `(√-1)^M Z_1 Y_1 ⋯ Z_M Y_M = (√-1)^M (-√-1)^M σ^x_1 ⋯ σ^x_M = σ^x_1 ⋯ σ^x_M = ε`

となり積なら正しいが、和の場合は `M = 2` で
`(√-1)^2 (Z_1 Y_1 + Z_2 Y_2) = √-1 (σ^x_1 + σ^x_2) ≠ σ^x_1 σ^x_2` となって成り立たない。
本ファイルでは `ε := σ^x_1 ⋯ σ^x_M`（左辺）を定義とし、積の形の等式を
`epsilon_eq_i_pow_smul_zyPrefixProduct` で形式化する。
-/
import Ising2D.Representation
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimTensorCommutationFromAllSites
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOne
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimMinusOneTimesMinusOneIsOneInCC
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerMultilinear

namespace Ising2D

/-! ## Pauli 行列（`Mat(2, ℂ)` の元）

`parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` の証明冒頭の定義。 -/

/-- Pauli 行列 `σ^x = !![0, 1; 1, 0]`。 -/
def pauliX : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]

/-- Pauli 行列 `σ^y = !![0, -√-1; √-1, 0]`。 -/
def pauliY : Matrix (Fin 2) (Fin 2) ℂ := !![0, -Complex.I; Complex.I, 0]

/-- Pauli 行列 `σ^z = !![1, 0; 0, -1]`。 -/
def pauliZ : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

section PauliRelations

/-! 以下は人手 `pauli_matrix_products`（`structured-latex/content/006_Z_Y_anticommutation.ts`）の証明を 1 段ずつ辿る。
`calc` の各段の根拠は人手の行末の根拠と同じである。行列の積の段（`mat_mult`）だけは成分の計算を `simp` に任せる。 -/

/-- 人手の準備の鎖 `(-i)·i = -(i·i) = -(-1) = 1`。 -/
theorem neg_I_mul_I : (-Complex.I) * Complex.I = 1 := by
  calc
    -- ℂ の乗法と符号の計算
    (-Complex.I) * Complex.I = -(Complex.I * Complex.I) := neg_mul _ _
    -- `i·i = -1`
    _ = -(-1) := by rw [Complex.I_mul_I]
    -- ℂ の符号の計算
    _ = 1 := neg_neg 1

/-- 人手の準備の鎖 `i·(-i) = (-i)·i = 1`。 -/
theorem I_mul_neg_I : Complex.I * (-Complex.I) = 1 := by
  calc
    -- ℂ の乗法の可換律
    Complex.I * (-Complex.I) = (-Complex.I) * Complex.I := mul_comm _ _
    -- 直前の鎖
    _ = 1 := neg_I_mul_I

/-- 人手の `σ^xσ^x = I`・`σ^yσ^y = I`・`σ^zσ^z = I` の 3 つの鎖に共通の段 `(1 0; 0 1) = (δ_{11} δ_{12}; δ_{21} δ_{22})`（`def_kronecker_delta`）。 -/
theorem twoByTwo_one_eq_kroneckerDelta :
    !![(1 : ℂ), 0; 0, 1] =
      !![kroneckerDelta (0 : Fin 2) 0, kroneckerDelta (0 : Fin 2) 1;
        kroneckerDelta (1 : Fin 2) 0, kroneckerDelta (1 : Fin 2) 1] := by
  rw [kroneckerDelta_self, kroneckerDelta_self, kroneckerDelta_of_ne (by decide),
    kroneckerDelta_of_ne (by decide)]

/-- 人手の `σ^xσ^x = I`・`σ^yσ^y = I`・`σ^zσ^z = I` の 3 つの鎖に共通の段 `(δ_{11} δ_{12}; δ_{21} δ_{22}) = I`（`def_identity_matrix`）。 -/
theorem twoByTwo_kroneckerDelta_eq_identity :
    !![kroneckerDelta (0 : Fin 2) 0, kroneckerDelta (0 : Fin 2) 1;
        kroneckerDelta (1 : Fin 2) 0, kroneckerDelta (1 : Fin 2) 1] =
      (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
  ext i j
  rw [identity_matrix_apply]
  fin_cases i <;> fin_cases j <;> rfl

/-- `σ^x σ^x = I`（人手 `pauli_matrix_products`）。 -/
@[simp]
theorem pauliX_mul_pauliX : pauliX * pauliX = 1 := by
  calc
    -- σ^x の定義
    pauliX * pauliX = !![0, 1; 1, 0] * !![0, 1; 1, 0] := rfl
    -- `mat_mult`
    _ = !![1, 0; 0, 1] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]
    -- `def_kronecker_delta`
    _ = _ := twoByTwo_one_eq_kroneckerDelta
    -- `def_identity_matrix`
    _ = 1 := twoByTwo_kroneckerDelta_eq_identity

/-- `σ^y σ^y = I`（人手 `pauli_matrix_products`）。 -/
@[simp]
theorem pauliY_mul_pauliY : pauliY * pauliY = 1 := by
  calc
    -- σ^y の定義
    pauliY * pauliY = !![0, -Complex.I; Complex.I, 0] * !![0, -Complex.I; Complex.I, 0] := rfl
    -- `mat_mult`
    _ = !![(-Complex.I) * Complex.I, 0; 0, Complex.I * (-Complex.I)] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]
    -- 上の準備
    _ = !![1, 0; 0, 1] := by rw [neg_I_mul_I, I_mul_neg_I]
    -- `def_kronecker_delta`
    _ = _ := twoByTwo_one_eq_kroneckerDelta
    -- `def_identity_matrix`
    _ = 1 := twoByTwo_kroneckerDelta_eq_identity

/-- `σ^z σ^z = I`（人手 `pauli_matrix_products`）。 -/
@[simp]
theorem pauliZ_mul_pauliZ : pauliZ * pauliZ = 1 := by
  calc
    -- σ^z の定義
    pauliZ * pauliZ = !![1, 0; 0, -1] * !![1, 0; 0, -1] := rfl
    -- `mat_mult`
    _ = !![1, 0; 0, (-1) * (-1)] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]
    -- ℂ で `(-1)·(-1) = 1`
    _ = !![1, 0; 0, 1] := by rw [mul_neg_one, neg_neg]
    -- `def_kronecker_delta`
    _ = _ := twoByTwo_one_eq_kroneckerDelta
    -- `def_identity_matrix`
    _ = 1 := twoByTwo_kroneckerDelta_eq_identity

/-- 人手の反可換性の準備 `σ^x σ^z = (0 -1; 1 0)`。 -/
theorem pauliX_mul_pauliZ_entries : pauliX * pauliZ = !![0, -1; 1, 0] := by
  calc
    -- σ^x, σ^z の定義
    pauliX * pauliZ = !![0, 1; 1, 0] * !![1, 0; 0, -1] := rfl
    -- `mat_mult`
    _ = !![0, -1; 1, 0] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]

/-- 人手の反可換性の準備 `σ^x σ^y = (i 0; 0 -i)`。 -/
theorem pauliX_mul_pauliY_entries : pauliX * pauliY = !![Complex.I, 0; 0, -Complex.I] := by
  calc
    -- σ^x, σ^y の定義
    pauliX * pauliY = !![0, 1; 1, 0] * !![0, -Complex.I; Complex.I, 0] := rfl
    -- `mat_mult`
    _ = !![Complex.I, 0; 0, -Complex.I] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]

/-- 人手の反可換性の準備 `σ^z σ^y = (0 -i; -i 0)`。 -/
theorem pauliZ_mul_pauliY_entries : pauliZ * pauliY = !![0, -Complex.I; -Complex.I, 0] := by
  calc
    -- σ^z, σ^y の定義
    pauliZ * pauliY = !![1, 0; 0, -1] * !![0, -Complex.I; Complex.I, 0] := rfl
    -- `mat_mult`
    _ = !![0, -Complex.I; (-1) * Complex.I, 0] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]
    -- `multiply_by_minus_one`（`-z := (-1)·z`）
    _ = !![0, -Complex.I; -Complex.I, 0] := by rw [neg_one_mul]

/-- `σ^z σ^x = -σ^x σ^z`（人手 `pauli_matrix_products`）。 -/
theorem pauliZ_mul_pauliX : pauliZ * pauliX = -(pauliX * pauliZ) := by
  calc
    -- σ^z, σ^x の定義
    pauliZ * pauliX = !![1, 0; 0, -1] * !![0, 1; 1, 0] := rfl
    -- `mat_mult`
    _ = !![0, 1; -1, 0] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]
    -- ℂ で `0 = -0`（`-z` は `multiply_by_minus_one` の記号）
    _ = !![-0, 1; -1, -0] := by rw [neg_zero]
    -- ℂ で `1 = -(-1)`
    _ = !![-0, -(-1); -1, -0] := by rw [neg_neg]
    -- `def_matrix_negation`
    _ = -!![0, -1; 1, 0] := by
      ext i j
      rw [matrix_neg_apply]
      fin_cases i <;> fin_cases j <;> rfl
    -- 上で計算した σ^x σ^z
    _ = -(pauliX * pauliZ) := by rw [pauliX_mul_pauliZ_entries]

/-- `σ^y σ^x = -σ^x σ^y`（人手 `pauli_matrix_products`）。 -/
theorem pauliY_mul_pauliX : pauliY * pauliX = -(pauliX * pauliY) := by
  calc
    -- σ^y, σ^x の定義
    pauliY * pauliX = !![0, -Complex.I; Complex.I, 0] * !![0, 1; 1, 0] := rfl
    -- `mat_mult`
    _ = !![-Complex.I, 0; 0, Complex.I] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]
    -- ℂ で `0 = -0`
    _ = !![-Complex.I, -0; -0, Complex.I] := by rw [neg_zero]
    -- ℂ で `i = -(-i)`
    _ = !![-Complex.I, -0; -0, -(-Complex.I)] := by rw [neg_neg]
    -- `def_matrix_negation`
    _ = -!![Complex.I, 0; 0, -Complex.I] := by
      ext i j
      rw [matrix_neg_apply]
      fin_cases i <;> fin_cases j <;> rfl
    -- 上で計算した σ^x σ^y
    _ = -(pauliX * pauliY) := by rw [pauliX_mul_pauliY_entries]

/-- `σ^y σ^z = -σ^z σ^y`（人手 `pauli_matrix_products`）。 -/
theorem pauliY_mul_pauliZ_anticomm : pauliY * pauliZ = -(pauliZ * pauliY) := by
  calc
    -- σ^y, σ^z の定義
    pauliY * pauliZ = !![0, -Complex.I; Complex.I, 0] * !![1, 0; 0, -1] := rfl
    -- `mat_mult`
    _ = !![0, (-Complex.I) * (-1); Complex.I, 0] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_two]
    -- ℂ で `(-i)·(-1) = i`
    _ = !![0, Complex.I; Complex.I, 0] := by rw [mul_neg_one, neg_neg]
    -- ℂ で `0 = -0`
    _ = !![-0, Complex.I; Complex.I, -0] := by rw [neg_zero]
    -- ℂ で `i = -(-i)`
    _ = !![-0, -(-Complex.I); -(-Complex.I), -0] := by rw [neg_neg]
    -- `def_matrix_negation`
    _ = -!![0, -Complex.I; -Complex.I, 0] := by
      ext i j
      rw [matrix_neg_apply]
      fin_cases i <;> fin_cases j <;> rfl
    -- 上で計算した σ^z σ^y
    _ = -(pauliZ * pauliY) := by rw [pauliZ_mul_pauliY_entries]

/-- 人手 `Z_Y_generate_algebra`（`eigenvalue_problem_diagonalization_and_exponential_form.ts`）の Step 1 の準備 (f): `ii = −1_ℂ`（人手の 4 行）。
Step 3 の `R_{12}`・`R_{21}` の鎖も使う。 -/
theorem zy_prep_I_mul_I : Complex.I * Complex.I = -1 :=
  calc Complex.I * Complex.I
      = (⟨0, 1⟩ : ℂ) * (⟨0, 1⟩ : ℂ) := rfl                             -- `def_imaginary_unit` を 2 か所へ
    _ = (⟨0 * 0 - 1 * 1, 0 * 1 + 1 * 0⟩ : ℂ) := rfl                   -- `definition_of_cc` の積
    _ = (⟨-1, 0⟩ : ℂ) := by norm_num                                  -- `ℝ` の四則
    _ = -1 := by
          rw [show (⟨-1, 0⟩ : ℂ) = ((-1 : ℝ) : ℂ) from rfl, Complex.ofReal_neg, Complex.ofReal_one]
                                                                      -- `-1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = -1`

/-- 人手 `Z_Y_generate_algebra` の Step 1 の準備 (g): `(−i) i = 1_ℂ`。Step 1 の第 3 式 `pauliX_eq` と Step 3 の `R_{12}` の鎖が使う。 -/
theorem zy_prep_neg_I_mul_I : (-Complex.I) * Complex.I = 1 := by
  calc (-Complex.I) * Complex.I
      = -(Complex.I * Complex.I) := neg_I_mul_eq_neg_of_I_mul _         -- `negative_i_times_complex_is_negation_of_i_times`（`z → i`）
    _ = -(-1) := by rw [zy_prep_I_mul_I]                                -- (f)
    _ = (-1) * (-1) := (neg_one_mul (-1)).symm                          -- `multiply_by_minus_one`（`z → −1_ℂ`）
    _ = 1 := complex_minus_one_mul_minus_one                            -- `minus_one_times_minus_one_is_one_in_cc`

/-- 人手 `Z_Y_generate_algebra` の Step 1 の第 2 式 `σ^yσ^z = iσ^x`。人手の鎖の 14 行と 1 段ずつ対応する。 -/
theorem pauliY_mul_pauliZ : pauliY * pauliZ = Complex.I • pauliX := by
  calc
    -- `pauli_matrix_products` の σ^y, σ^z
    pauliY * pauliZ = !![0, -Complex.I; Complex.I, 0] * !![1, 0; 0, -1] := rfl
    -- `mat_mult`
    _ = !![0 * 1 + (-Complex.I) * 0, 0 * 0 + (-Complex.I) * (-1);
          Complex.I * 1 + 0 * 0, Complex.I * 0 + 0 * (-1)] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp only [Matrix.mul_apply, Fin.sum_univ_two] <;> rfl
    -- `complex_zero_times_is_zero`（`z → 1, 0, 0, -1`）を 4 か所へ
    _ = !![0 + (-Complex.I) * 0, 0 + (-Complex.I) * (-1);
          Complex.I * 1 + 0, Complex.I * 0 + 0] := by simp only [zero_mul]
    -- 加法の単位元を 4 か所へ
    _ = !![(-Complex.I) * 0, (-Complex.I) * (-1); Complex.I * 1, Complex.I * 0] := by
      simp only [zero_add, add_zero]
    -- 積の可換律を 2 か所へ
    _ = !![0 * (-Complex.I), (-1) * (-Complex.I); Complex.I * 1, Complex.I * 0] := by
      rw [mul_comm (-Complex.I) 0, mul_comm (-Complex.I) (-1)]
    -- `complex_zero_times_is_zero`（`z → -i`）
    _ = !![0, (-1) * (-Complex.I); Complex.I * 1, Complex.I * 0] := by rw [zero_mul]
    -- `multiply_by_minus_one`（`z → -i`）を右辺から左辺へ
    _ = !![0, -(-Complex.I); Complex.I * 1, Complex.I * 0] := by rw [neg_one_mul]
    -- `double_negation_in_cc`（`z → i`）
    _ = !![0, Complex.I; Complex.I * 1, Complex.I * 0] := by rw [neg_neg]
    -- `complex_zero_times_is_zero`（`z → i`）を右辺から左辺へ
    _ = !![0 * Complex.I, Complex.I; Complex.I * 1, Complex.I * 0] := by rw [zero_mul]
    -- 積の可換律
    _ = !![Complex.I * 0, Complex.I; Complex.I * 1, Complex.I * 0] := by rw [mul_comm (0 : ℂ) Complex.I]
    -- 積の単位元を右辺から左辺へ
    _ = !![Complex.I * 0, Complex.I * 1; Complex.I * 1, Complex.I * 0] := by rw [mul_one]
    -- `def_matrix_scalar_multiple` を右辺から左辺へ
    _ = Complex.I • !![0, 1; 1, 0] := by
      ext i j
      rw [matrix_smul_apply]
      fin_cases i <;> fin_cases j <;> rfl
    -- `pauli_matrix_products` の σ^x
    _ = Complex.I • pauliX := rfl

/-- 人手 `Z_Y_generate_algebra` の Step 1 の第 3 式 `σ^x = (-i)(σ^yσ^z)`。人手の鎖の 4 行と 1 段ずつ対応する。 -/
theorem pauliX_eq : pauliX = (-Complex.I) • (pauliY * pauliZ) := by
  calc pauliX
      = (1 : ℂ) • pauliX := (matrix_one_smul pauliX).symm
                                                        -- `scalar_multiple_by_one`（`A → σ^x`）を右辺から左辺へ
    _ = ((-Complex.I) * Complex.I) • pauliX := by rw [zy_prep_neg_I_mul_I]
                                                        -- (g) を右辺から左辺へ
    _ = (-Complex.I) • (Complex.I • pauliX) := (smul_smul _ _ _).symm
                                                        -- `scalar_multiple_is_associative`（`a → -i`, `b → i`, `A → σ^x`）を右辺から左辺へ。具体版が無いので mathlib の `smul_smul`
    _ = (-Complex.I) • (pauliY * pauliZ) := by rw [pauliY_mul_pauliZ]
                                                        -- 第 2 式を右辺から左辺へ

/-- `σ^z σ^y = -i σ^x`。人手 `V1_in_Z_Y_epsilon` の Step 0 の第 3 の鎖と `V2_in_Z_Y` の Step 0 の鎖
（`partition_function_projection_and_jordan_wigner.ts`）と `iH_is_real_symmetric` の Step 0 の第 1 の鎖
（`eigenvalue_problem_eigenvalues_of_V_plus.ts`。3 本は同じ鎖）の各段と 1 対 1 に対応する。 -/
theorem pauliZ_mul_pauliY : pauliZ * pauliY = (-Complex.I) • pauliX := by
  calc
    -- `pauli_matrix_products`（Pauli 行列）
    pauliZ * pauliY = !![1, 0; 0, -1] * !![0, -Complex.I; Complex.I, 0] := rfl
    -- `mat_mult`
    _ = !![1 * 0 + 0 * Complex.I, 1 * (-Complex.I) + 0 * 0;
          0 * 0 + (-1) * Complex.I, 0 * (-Complex.I) + (-1) * 0] := by
      ext i j
      fin_cases i <;> fin_cases j <;> simp only [Matrix.mul_apply, Fin.sum_univ_two] <;> rfl
    -- `complex_zero_times_is_zero`（4 か所へ同時に適用）
    _ = !![1 * 0 + 0, 1 * (-Complex.I) + 0; 0 + (-1) * Complex.I, 0 + (-1) * 0] := by
      simp only [zero_mul]
    -- `0_ℂ` は加法の単位元（`complex_numbers_form_a_field`。4 か所へ同時に適用）
    _ = !![1 * 0, 1 * (-Complex.I); (-1) * Complex.I, (-1) * 0] := by
      simp only [zero_add, add_zero]
    -- `complex_times_zero_is_zero`（2 か所へ同時に適用）
    _ = !![0, 1 * (-Complex.I); (-1) * Complex.I, 0] := by simp only [mul_zero]
    -- `complex_times_zero_is_zero`（右辺の `(-i)·0` へ。2 か所へ同時に適用）
    _ = !![(-Complex.I) * 0, 1 * (-Complex.I); (-1) * Complex.I, (-Complex.I) * 0] := by
      rw [mul_zero (-Complex.I)]
    -- 積の可換律（`complex_numbers_form_a_field`）
    _ = !![(-Complex.I) * 0, (-Complex.I) * 1; (-1) * Complex.I, (-Complex.I) * 0] := by
      rw [mul_comm (-Complex.I) 1]
    -- `multiply_by_minus_one`（`-z := (-1)·z`）
    _ = !![(-Complex.I) * 0, (-Complex.I) * 1; -Complex.I, (-Complex.I) * 0] := by
      rw [neg_one_mul Complex.I]
    -- `1_ℂ` は積の単位元（`complex_numbers_form_a_field`）
    _ = !![(-Complex.I) * 0, (-Complex.I) * 1; (-Complex.I) * 1, (-Complex.I) * 0] := by
      rw [mul_one (-Complex.I)]
    -- `def_matrix_scalar_multiple`
    _ = (-Complex.I) • !![0, 1; 1, 0] := by
      ext i j
      rw [matrix_smul_apply]
      fin_cases i <;> fin_cases j <;> rfl
    -- `pauli_matrix_products`（Pauli 行列）
    _ = (-Complex.I) • pauliX := rfl

end PauliRelations

section PauliTransposes

open Matrix

/-! 以下は人手 `transpose_of_identity_matrix_of_order_two`・`transpose_of_pauli_x`・`transpose_of_pauli_z`・`transpose_of_pauli_y`
（`structured-latex/content/006_Z_Y_anticommutation.ts`）の鎖を 1 段ずつ辿る。`calc` の各段の根拠は人手の行末の根拠と同じである。 -/

/-- 人手 `transpose_of_identity_matrix_of_order_two`: `I^⊤ = I`（`I = I_{Mat(2,ℂ)}`）。 -/
theorem identity_matrix_two_transpose : (1 : Matrix (Fin 2) (Fin 2) ℂ)ᵀ = 1 := by
  calc
    -- `def_matrix_transpose`（`m = n = 2`）
    (1 : Matrix (Fin 2) (Fin 2) ℂ)ᵀ =
        !![(1 : Matrix (Fin 2) (Fin 2) ℂ) 0 0, (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 0;
          (1 : Matrix (Fin 2) (Fin 2) ℂ) 0 1, (1 : Matrix (Fin 2) (Fin 2) ℂ) 1 1] := by
      ext p q
      rw [matrix_transpose_apply]
      fin_cases p <;> fin_cases q <;> rfl
    -- `def_identity_matrix`（`n = 2`）
    _ = !![kroneckerDelta (0 : Fin 2) 0, kroneckerDelta (1 : Fin 2) 0;
          kroneckerDelta (0 : Fin 2) 1, kroneckerDelta (1 : Fin 2) 1] := by
      simp only [identity_matrix_apply]
    -- `def_kronecker_delta`
    _ = !![(1 : ℂ), 0; 0, 1] := by
      rw [kroneckerDelta_self, kroneckerDelta_self, kroneckerDelta_of_ne (by decide),
        kroneckerDelta_of_ne (by decide)]
    -- `def_kronecker_delta`
    _ = _ := twoByTwo_one_eq_kroneckerDelta
    -- `def_identity_matrix`（`n = 2`）
    _ = 1 := twoByTwo_kroneckerDelta_eq_identity

/-- 人手 `transpose_of_pauli_x`: `(σ^x)^⊤ = σ^x`。 -/
@[simp]
theorem pauliX_transpose : pauliXᵀ = pauliX := by
  calc
    -- `def_matrix_transpose`（`m = n = 2`）
    pauliXᵀ = !![pauliX 0 0, pauliX 1 0; pauliX 0 1, pauliX 1 1] := by
      ext p q
      rw [matrix_transpose_apply]
      fin_cases p <;> fin_cases q <;> rfl
    -- `pauli_matrix_products` の σ^x の成分
    _ = !![0, 1; 1, 0] := rfl
    -- `pauli_matrix_products` の σ^x
    _ = pauliX := rfl

/-- 人手 `transpose_of_pauli_z`: `(σ^z)^⊤ = σ^z`。 -/
@[simp]
theorem pauliZ_transpose : pauliZᵀ = pauliZ := by
  calc
    -- `def_matrix_transpose`（`m = n = 2`）
    pauliZᵀ = !![pauliZ 0 0, pauliZ 1 0; pauliZ 0 1, pauliZ 1 1] := by
      ext p q
      rw [matrix_transpose_apply]
      fin_cases p <;> fin_cases q <;> rfl
    -- `pauli_matrix_products` の σ^z の成分
    _ = !![1, 0; 0, -1] := rfl
    -- `pauli_matrix_products` の σ^z
    _ = pauliZ := rfl

/-- 人手 `transpose_of_pauli_y`: `(σ^y)^⊤ = -σ^y`。 -/
@[simp]
theorem pauliY_transpose : pauliYᵀ = -pauliY := by
  calc
    -- `def_matrix_transpose`（`m = n = 2`）
    pauliYᵀ = !![pauliY 0 0, pauliY 1 0; pauliY 0 1, pauliY 1 1] := by
      ext p q
      rw [matrix_transpose_apply]
      fin_cases p <;> fin_cases q <;> rfl
    -- `pauli_matrix_products` の σ^y の成分
    _ = !![0, Complex.I; -Complex.I, 0] := rfl
    -- ℂ で `0 = -0`（`-z` は `multiply_by_minus_one` の記号）
    _ = !![-0, Complex.I; -Complex.I, -0] := by rw [neg_zero]
    -- ℂ で `i = -(-i)`（`-z` は `multiply_by_minus_one` の記号）
    _ = !![-0, -(-Complex.I); -Complex.I, -0] := by rw [neg_neg]
    -- `def_matrix_negation`
    _ = -!![0, -Complex.I; Complex.I, 0] := by
      ext i j
      rw [matrix_neg_apply]
      fin_cases i <;> fin_cases j <;> rfl
    -- `pauli_matrix_products` の σ^y
    _ = -pauliY := rfl

end PauliTransposes

/-! ## サイト局所作用素 `σ^a_k`

原文の `σ^a_k := I ⊗ ⋯ ⊗ σ^a (k 番目) ⊗ ⋯ ⊗ I` を、
`Ising2D.siteProd`（`Ising2D/Representation.lean`）で作る。
`siteProd` は多重線型写像なので、第 `k` 成分だけを動かす線型写像
`MultilinearMap.toLinearMap` としてまとめて定義できる。 -/

section SiteOp

variable {M : ℕ}

/-- 第 `k` テンソル因子だけを `A` に置き換えたテンソル積
`I ⊗ ⋯ ⊗ A (k 番目) ⊗ ⋯ ⊗ I ∈ Mat(2, ℂ)^{⊗M}`。

`A` について線型であることは `siteProd` の多重線型性から自動的に従う。 -/
noncomputable def siteOp (k : Fin M) : Matrix (Fin 2) (Fin 2) ℂ →ₗ[ℂ] TensorPow M :=
  (siteProd M).toLinearMap 1 k

theorem siteOp_apply (k : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k A = siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k A) :=
  rfl

/-- `I` を置いたら単位元。 -/
@[simp]
theorem siteOp_one (k : Fin M) : siteOp k (1 : Matrix (Fin 2) (Fin 2) ℂ) = 1 := by
  rw [siteOp_apply]
  have h : Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k 1 = 1 := by
    funext i; by_cases h : i = k <;> simp [h]
  rw [h, siteProd_one]

/-- 同じサイトの積は、そのサイトの `Mat(2, ℂ)` の積になる（人手 `Z_Y_generate_algebra` の Step 1 の第 4 式
`σ_k^a σ_k^b = I ⊠ ⋯ ⊠ (σ^a σ^b) ⊠ ⋯ ⊠ I`）。人手は `σ^a, σ^b` で述べ、証明は Pauli 行列の性質を使わないので、
Lean は `A, B ∈ Mat(2, ℂ)` で述べる。人手の鎖の 3 行と 1 段ずつ対応する。 -/
theorem siteOp_mul_same (k : Fin M) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k A * siteOp k B = siteOp k (A * B) := by
  calc siteOp k A * siteOp k B
      = siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k A)
          * siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k B) := rfl
                                                        -- `def_site_pauli_matrices` の `σ_k^a`・`σ_k^b`
    _ = siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k A
          * Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k B) := (siteProd_mul M _ _).symm
                                                        -- `kronecker_product_rule` (1)
    _ = siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k (A * B)) := by
      -- `identity_matrix_is_left_unit_of_mat_mult`（`m, n → 2`, `A → I`）を第 `k` 因子以外の各因子へ
      congr 1
      funext i
      by_cases h : i = k
      · rw [h, Pi.mul_apply, Function.update_self, Function.update_self, Function.update_self]
      · rw [Pi.mul_apply, Function.update_of_ne h, Function.update_of_ne h, Function.update_of_ne h, Pi.one_apply]
        exact identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)
    _ = siteOp k (A * B) := rfl                         -- `siteOp` の定義

/-- **人手 `distinct_site_pauli_matrices_commute`**（`structured-latex/content/partition_function_transfer_matrix_representation.ts`）:
相異なるサイト `k ≠ l` に置いた作用素は可換。人手は `A → σ^a`、`B → σ^b`（`a, b ∈ {x, y, z}`）で述べ、証明は Pauli 行列の性質を使わないので、
Lean は `A, B ∈ Mat(2, ℂ)` で述べる（`Z_Y_generate_algebra` の Step 1 もこの形で使う）。

人手との対応: 人手のサイト `j, k` は Lean の `k, l` である。準備の `x_i`・`y_i` は `Function.update 1 k A`・`Function.update 1 l B`、`σ_j^a = x_1⊠⋯⊠x_{M_col}` の表示は
`siteOp` の定義の展開（`rfl`。`def_site_pauli_matrices`）。`y_ix_i = x_iy_i` の 3 つの場合（人手の `i = j`・`i = k`・どちらでもない）は `hsite` の 3 つの枝（`i = k`・`i = l`・どちらでもない）で、
`i = k`・`i = l` の枝は人手の 4 行（`x_i, y_i` の定義・単位行列の左右の単位元・`x_i, y_i` の定義）と同じ順の `calc`。
最後の 3 行の鎖は `calc` の 3 段で、中の段が `tensor_commutation_from_all_sites`（`siteProd_commute_of_sitewise_commute`）。
必要十分版は `NecSuf/SitewiseCommute.lean` の `update_mul_comm_of_ne`、導出は `ClaimDistinctSitePauliMatricesCommuteFromNecSuf.lean`。 -/
theorem siteOp_mul_comm {k l : Fin M} (hkl : k ≠ l) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteOp k A * siteOp l B = siteOp l B * siteOp k A := by
  have hsite : ∀ i, Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) l B i
        * Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k A i
      = Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k A i
        * Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) l B i := by
    intro i
    by_cases hik : i = k
    · -- `i = k`（`k ≠ l` より `i ≠ l`）
      have hil : i ≠ l := by rw [hik]; exact hkl
      rw [Function.update_of_ne hil, hik, Function.update_self]
      show (1 : Matrix (Fin 2) (Fin 2) ℂ) * A = A * (1 : Matrix (Fin 2) (Fin 2) ℂ)  -- `x_i, y_i` の定義
      calc (1 : Matrix (Fin 2) (Fin 2) ℂ) * A
          = A := identity_matrix_mul A                    -- `identity_matrix_is_left_unit_of_mat_mult`（`m, n → 2`, `A → σ^a`）
        _ = A * (1 : Matrix (Fin 2) (Fin 2) ℂ) := (mul_identity_matrix A).symm
                                                          -- `identity_matrix_is_right_unit_of_mat_mult` を右辺から左辺へ
    · by_cases hil : i = l
      · -- `i = l`（`k ≠ l` より `i ≠ k`）
        rw [Function.update_of_ne hik, hil, Function.update_self]
        show B * (1 : Matrix (Fin 2) (Fin 2) ℂ) = (1 : Matrix (Fin 2) (Fin 2) ℂ) * B  -- `x_i, y_i` の定義
        calc B * (1 : Matrix (Fin 2) (Fin 2) ℂ)
            = B := mul_identity_matrix B                  -- `identity_matrix_is_right_unit_of_mat_mult`（`m, n → 2`, `A → σ^b`）
          _ = (1 : Matrix (Fin 2) (Fin 2) ℂ) * B := (identity_matrix_mul B).symm
                                                          -- `identity_matrix_is_left_unit_of_mat_mult` を右辺から左辺へ
      · -- `i ≠ k` かつ `i ≠ l`: 両辺とも `I I`（`x_i, y_i` の定義）
        rw [Function.update_of_ne hik, Function.update_of_ne hil]
  calc siteOp k A * siteOp l B
      = siteProd M (Function.update 1 k A) * siteProd M (Function.update 1 l B) := rfl
                                                          -- 準備の `σ_j^a`・`σ_k^b` の表示（`def_site_pauli_matrices`）
    _ = siteProd M (Function.update 1 l B) * siteProd M (Function.update 1 k A) :=
        siteProd_commute_of_sitewise_commute _ _ hsite    -- `tensor_commutation_from_all_sites`（`M → M_col`）と全ての `i` の `y_ix_i = x_iy_i`
    _ = siteOp l B * siteOp k A := rfl                    -- 準備の `σ_j^a`・`σ_k^b` の表示

/-- 原文の `σ^x_k`。 -/
noncomputable def sigmaX (k : Fin M) : TensorPow M := siteOp k pauliX

/-- 原文の `σ^y_k`。 -/
noncomputable def sigmaY (k : Fin M) : TensorPow M := siteOp k pauliY

/-- 原文の `σ^z_k`。 -/
noncomputable def sigmaZ (k : Fin M) : TensorPow M := siteOp k pauliZ

/-- `σ^x_k σ^x_k = I`（人手 `Z_Y_generate_algebra` の Step 1 の `σ_k^xσ_k^x` の鎖の 3 行）。 -/
@[simp]
theorem sigmaX_mul_self (k : Fin M) : sigmaX k * sigmaX k = 1 := by
  calc sigmaX k * sigmaX k
      = siteOp k (pauliX * pauliX) := siteOp_mul_same k pauliX pauliX
                                                        -- 第 4 式（`a, b → x`）
    _ = siteOp k (1 : Matrix (Fin 2) (Fin 2) ℂ) := by rw [pauliX_mul_pauliX]
                                                        -- 第 1 式
    _ = 1 := siteOp_one k                               -- `kronecker_product_rule` (2)

/-- `σ^x_k = (-i)(σ^y_k σ^z_k)`（人手 `Z_Y_generate_algebra` の Step 1 の `σ_k^x` の鎖の 4 行）。 -/
theorem sigmaX_eq (k : Fin M) : sigmaX k = (-Complex.I) • (sigmaY k * sigmaZ k) := by
  calc sigmaX k
      = siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k pauliX) := rfl
                                                        -- `def_site_pauli_matrices` の `σ_k^x`
    _ = siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k
          ((-Complex.I) • (pauliY * pauliZ))) := by rw [← pauliX_eq]
                                                        -- 第 3 式
    _ = (-Complex.I) • siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) k
          (pauliY * pauliZ)) := siteProd_update_smul _ k (-Complex.I) (pauliY * pauliZ)
                                                        -- `kronecker_multilinear` の `r = 1` の場合（`j → k`, `c → -i`, `A_k → σ^yσ^z`, `i ≠ k` の `A_i → I`）。具体版 `siteProd_update_smul`
    _ = (-Complex.I) • (sigmaY k * sigmaZ k) := by
      rw [sigmaY, sigmaZ, siteOp_mul_same, siteOp_apply]
                                                        -- 第 4 式（`a → y`, `b → z`）を右辺から左辺へ

end SiteOp

/-! ## Jordan–Wigner 文字列 `Z_m`, `Y_m` と `ε` -/

section JordanWigner

variable {M : ℕ}

/-- `Z_m`, `Y_m` を作る「サイト成分の族」。

サイト `i` の成分は
* `i < m` なら `σ^x`（Jordan–Wigner 文字列の部分）
* `i = m` なら `A`（`Z_m` なら `σ^z`、`Y_m` なら `σ^y`）
* `i > m` なら `I`

である。`siteProd` に流し込むと原文の `σ^x_1 ⋯ σ^x_{m-1} A_m` になる
（`Z_eq_xString_mul` / `Y_eq_xString_mul` 参照）。 -/
def jwFamily (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    Fin M → Matrix (Fin 2) (Fin 2) ℂ :=
  fun i => if (i : ℕ) < (m : ℕ) then pauliX else if i = m then A else 1

theorem jwFamily_of_lt {m i : Fin M} {A : Matrix (Fin 2) (Fin 2) ℂ}
    (h : (i : ℕ) < (m : ℕ)) : jwFamily m A i = pauliX := by
  simp [jwFamily, h]

@[simp]
theorem jwFamily_self (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    jwFamily m A m = A := by
  simp [jwFamily]

theorem jwFamily_of_gt {m i : Fin M} {A : Matrix (Fin 2) (Fin 2) ℂ}
    (h : (m : ℕ) < (i : ℕ)) : jwFamily m A i = 1 := by
  have h1 : ¬ ((i : ℕ) < (m : ℕ)) := by omega
  have h2 : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
  simp [jwFamily, h1, h2]

/-- 原文の `Z_m := σ^x_1 ⋯ σ^x_{m-1} σ^z_m`（`Z_1 := σ^z_1`）。
Lean の添字は 0 始まりで、`Z 0 = σ^z_0` が原文の `Z_1` にあたる。 -/
noncomputable def Z (m : Fin M) : TensorPow M := siteProd M (jwFamily m pauliZ)

/-- 原文の `Y_m := σ^x_1 ⋯ σ^x_{m-1} σ^y_m`（`Y_1 := σ^y_1`）。 -/
noncomputable def Y (m : Fin M) : TensorPow M := siteProd M (jwFamily m pauliY)

/-- Jordan–Wigner 文字列。人手の 1 始まりのサイトで `P_m = σ^x_1 ⋯ σ^x_m`（Lean の 0 始まりの添字で `i < m` なるサイト全部）。
人手の `Z_m = P_{m-1}σ_m^z` の `P_{m-1}` は、Lean の `Z ⟨m-1, _⟩` では `xString M (m-1)` にあたる。 -/
noncomputable def xString (M : ℕ) (m : ℕ) : TensorPow M :=
  siteProd M (fun i => if (i : ℕ) < m then pauliX else 1)

/-- 空の文字列は単位元（原文の `P_0 := I`）。 -/
@[simp]
theorem xString_zero : xString M 0 = 1 := by
  rw [xString]
  have h : (fun i : Fin M => if (i : ℕ) < 0 then pauliX else 1) = 1 := by
    funext i; simp
  rw [h, siteProd_one]

/-- 文字列は 1 サイトずつ伸ばせる: 人手の `P_{m+1} = P_m σ^x_{m+1}`（Lean の 0 始まりのサイト `m` が人手のサイト `m+1`）。 -/
theorem xString_succ (m : ℕ) (h : m < M) :
    xString M (m + 1) = xString M m * sigmaX ⟨m, h⟩ := by
  rw [xString, xString, sigmaX, siteOp_apply, ← siteProd_mul]
  congr 1
  funext i
  simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
  rcases lt_trichotomy (i : ℕ) m with hi | hi | hi
  · have hne : i ≠ (⟨m, h⟩ : Fin M) := Fin.ne_of_val_ne (show (i : ℕ) ≠ m by omega)
    rw [if_pos (by omega : (i : ℕ) < m + 1), if_pos hi, if_neg hne, mul_one]
  · have he : i = (⟨m, h⟩ : Fin M) := Fin.val_injective hi
    rw [if_pos (by omega : (i : ℕ) < m + 1), if_neg (by omega : ¬ ((i : ℕ) < m)),
      if_pos he, one_mul]
  · have hne : i ≠ (⟨m, h⟩ : Fin M) := Fin.ne_of_val_ne (show (i : ℕ) ≠ m by omega)
    rw [if_neg (by omega : ¬ ((i : ℕ) < m + 1)), if_neg (by omega : ¬ ((i : ℕ) < m)),
      if_neg hne, mul_one]

/-- `P_m P_m = I` を、クロネッカー積の因子ごとに `σ^xσ^x = I` を当てて示した形。
人手 `Z_Y_generate_algebra` Step 2 の二乗の式の鎖と 1 対 1 の具体版は `sigmaXPrefixProduct_mul_self`（`ClaimZYGenerateAlgebra.lean`）。 -/
@[simp]
theorem xString_mul_self (m : ℕ) : xString M m * xString M m = 1 := by
  rw [xString, ← siteProd_mul]
  have h : ((fun i : Fin M => if (i : ℕ) < m then pauliX else 1) *
      (fun i : Fin M => if (i : ℕ) < m then pauliX else 1)) = 1 := by
    funext i
    by_cases hi : (i : ℕ) < m <;> simp [Pi.mul_apply, hi]
  rw [h, siteProd_one]

/-- 原文どおりの分解 `σ^x_1 ⋯ σ^x_{m-1} A_m = (σ^x_1 ⋯ σ^x_{m-1}) · A_m`。
`Z_m`（`A = σ^z`）と `Y_m`（`A = σ^y`）に共通の補題。 -/
theorem jw_eq_xString_mul (m : Fin M) (A : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (jwFamily m A) = xString M (m : ℕ) * siteOp m A := by
  rw [xString, siteOp_apply, ← siteProd_mul]
  congr 1
  funext i
  simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
  rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
  · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
    rw [jwFamily_of_lt h, if_pos h, if_neg hne, mul_one]
  · have he : i = m := Fin.val_injective h
    subst he
    rw [jwFamily_self, if_neg (lt_irrefl _), if_pos rfl, one_mul]
  · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
    rw [jwFamily_of_gt h, if_neg (by omega : ¬ ((i : ℕ) < (m : ℕ))), if_neg hne, mul_one]

/-- 原文どおりの分解 `Z_m = (σ^x_1 ⋯ σ^x_{m-1}) σ^z_m`。 -/
theorem Z_eq_xString_mul (m : Fin M) : Z m = xString M (m : ℕ) * sigmaZ m := by
  calc
    -- 本文: `Z_m` の定義を、接頭文字列とサイト行列の積へ書き換える。
    Z m = siteProd M (jwFamily m pauliZ) := rfl
    -- 本文: 各因子を、接頭文字列の因子とサイト行列の因子との積へ分ける。
    _ = siteProd M ((fun i : Fin M => if (i : ℕ) < (m : ℕ) then pauliX else 1) *
        Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliZ) := by
      congr 1
      funext i
      simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
      rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_lt h, if_pos h, if_neg hne, mul_one]
      · have he : i = m := Fin.val_injective h
        subst i
        rw [jwFamily_self, if_neg (lt_irrefl _), if_pos rfl, one_mul]
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_gt h, if_neg (by omega), if_neg hne, mul_one]
    -- 本文: クロネッカー積の積の規則を逆向きに適用する。
    _ = siteProd M (fun i : Fin M => if (i : ℕ) < (m : ℕ) then pauliX else 1) *
        siteProd M (Function.update 1 m pauliZ) := siteProd_mul M _ _
    -- 本文: 前半を `P_{m-1}`、後半をサイト行列 `σ_m^z` へ戻す。
    _ = xString M (m : ℕ) * siteOp m pauliZ := by rw [xString, siteOp_apply]
    -- 本文: サイト行列を `σ_m^z` の定義へ戻す。
    _ = xString M (m : ℕ) * sigmaZ m := rfl

/-- 原文どおりの分解 `Y_m = (σ^x_1 ⋯ σ^x_{m-1}) σ^y_m`。 -/
theorem Y_eq_xString_mul (m : Fin M) : Y m = xString M (m : ℕ) * sigmaY m := by
  calc
    -- 本文: `Y_m` の定義を、接頭文字列とサイト行列の積へ書き換える。
    Y m = siteProd M (jwFamily m pauliY) := rfl
    -- 本文: 各因子を、接頭文字列の因子とサイト行列の因子との積へ分ける。
    _ = siteProd M ((fun i : Fin M => if (i : ℕ) < (m : ℕ) then pauliX else 1) *
        Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliY) := by
      congr 1
      funext i
      simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
      rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_lt h, if_pos h, if_neg hne, mul_one]
      · have he : i = m := Fin.val_injective h
        subst i
        rw [jwFamily_self, if_neg (lt_irrefl _), if_pos rfl, one_mul]
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_gt h, if_neg (by omega), if_neg hne, mul_one]
    -- 本文: クロネッカー積の積の規則を逆向きに適用する。
    _ = siteProd M (fun i : Fin M => if (i : ℕ) < (m : ℕ) then pauliX else 1) *
        siteProd M (Function.update 1 m pauliY) := siteProd_mul M _ _
    -- 本文: 前半を `P_{m-1}`、後半をサイト行列 `σ_m^y` へ戻す。
    _ = xString M (m : ℕ) * siteOp m pauliY := by rw [xString, siteOp_apply]
    -- 本文: サイト行列を `σ_m^y` の定義へ戻す。
    _ = xString M (m : ℕ) * sigmaY m := rfl

/-- 原文の `Z_1 = σ^z_1`（Lean の添字では `Z 0 = σ^z_0`）。
原文では場合分けで与えているが、`xString` の空積が `I` になるので自動的に従う。 -/
theorem Z_zero (h : 0 < M) : Z (⟨0, h⟩ : Fin M) = sigmaZ ⟨0, h⟩ := by
  rw [Z_eq_xString_mul]
  simp

/-- 原文の `Y_1 = σ^y_1`（Lean の添字では `Y 0 = σ^y_0`）。 -/
theorem Y_zero (h : 0 < M) : Y (⟨0, h⟩ : Fin M) = sigmaY ⟨0, h⟩ := by
  rw [Y_eq_xString_mul]
  simp

/-- 同じサイト `m` に載せた 2 つの Jordan–Wigner 文字列の積は、文字列部分が
`σ^x σ^x = I` で消えて、サイト `m` の 1 因子だけが残る。 -/
theorem jw_mul_jw_same (m : Fin M) (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    siteProd M (jwFamily m A) * siteProd M (jwFamily m B) = siteOp m (A * B) := by
  rw [← siteProd_mul, siteOp_apply]
  congr 1
  funext i
  simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
  rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
  · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
    rw [jwFamily_of_lt h, jwFamily_of_lt h, pauliX_mul_pauliX, if_neg hne]
  · rw [Fin.val_injective h, jwFamily_self, jwFamily_self, if_pos rfl]
  · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
    rw [jwFamily_of_gt h, jwFamily_of_gt h, mul_one, if_neg hne]

/-- **人手 `iH_is_real_symmetric` Step 1 の `Z_mY_m = (-i)σ^x_m` の 8 行の鎖**（`global_spin_flip_jordan_wigner_representation` の
`Z_mY_m` の鎖も同じ道で、そちらは 1・2 行目を 1 行にまとめている）。

人手との対応: 人手の準備の `Z_m`・`Y_m` のクロネッカー積表示（`def_jordan_wigner_Z_matrices`・`def_jordan_wigner_Y_matrices` と
`site_pauli_prefix_product_kronecker_form`）は、Lean では `Z`・`Y` の定義そのもの（`siteProd` に `jwFamily` を入れたもの）なので、
`calc` の 1・2 段は `rfl` である（Lean の `Z`・`Y` が人手の積 `∏_{j=1}^{m}F_j^{(z)}`・`∏_{j=1}^{m}F_j^{(y)}` に等しいことは、
`site_pauli_prefix_product_kronecker_form` の具体版を使う `Z_eq_finiteMatrixProduct`・`Y_eq_finiteMatrixProduct`（`ClaimSitePauliPrefixProductKroneckerForm.lean`）が持つ）。
人手の `m` は Lean の `m`（0 始まり）で、人手の「第 `1` から第 `m-1` 因子」「第 `m+1` 以降の因子」は Lean の `i < m`・`m < i` である。 -/
theorem Z_mul_Y_same (m : Fin M) : Z m * Y m = (-Complex.I) • sigmaX m := by
  calc
    Z m * Y m = siteProd M (jwFamily m pauliZ) * Y m := rfl
                                                        -- 準備の `Z_m` の表示
    _ = siteProd M (jwFamily m pauliZ) * siteProd M (jwFamily m pauliY) := rfl
                                                        -- 準備の `Y_m` の表示
    _ = siteProd M (fun i =>
        if (i : ℕ) < (m : ℕ) then pauliX * pauliX
        else if i = m then pauliZ * pauliY else 1 * 1) := by
      rw [← siteProd_mul]                               -- `kronecker_product_rule` (1)（`M → M_col`）
      congr 1
      funext i
      simp only [Pi.mul_apply]
      rcases lt_trichotomy (i : ℕ) (m : ℕ) with h | h | h
      · rw [jwFamily_of_lt h, jwFamily_of_lt h, if_pos h]
      · have he : i = m := Fin.val_injective h
        rw [he, jwFamily_self, jwFamily_self, if_neg (lt_irrefl _), if_pos rfl]
      · have hne : i ≠ m := fun he => absurd (congrArg Fin.val he) (by omega)
        rw [jwFamily_of_gt h, jwFamily_of_gt h, if_neg (by omega), if_neg hne]
    _ = siteProd M (fun i =>
        if (i : ℕ) < (m : ℕ) then 1
        else if i = m then pauliZ * pauliY else 1 * 1) := by
      rw [pauliX_mul_pauliX]                            -- `pauli_matrix_products` の `σ^xσ^x = I`（第 1 から第 `m-1` 因子へ同時に適用）
    _ = siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m (pauliZ * pauliY)) := by
      rw [identity_matrix_mul (1 : Matrix (Fin 2) (Fin 2) ℂ)]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`（`m, n → 2`, `A → I`。第 `m+1` 以降の因子へ同時に適用）
      congr 1                                           -- 両辺は同じ因子の並び `I⊠⋯⊠I⊠(σ^zσ^y)⊠I⊠⋯⊠I`（`Function.update` は `ite` の書き方の違いだけ）
      funext i
      by_cases he : i = m
      · rw [he, Function.update_self, if_neg (lt_irrefl _), if_pos rfl]
      · rw [Function.update_of_ne he, if_neg he]
        by_cases hlt : (i : ℕ) < (m : ℕ)
        · rw [if_pos hlt]; rfl
        · rw [if_neg hlt]; rfl
    _ = siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m ((-Complex.I) • pauliX)) := by
      rw [pauliZ_mul_pauliY]                            -- Step 0 の `σ^zσ^y = (-i)σ^x`
    _ = (-Complex.I) • siteProd M (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliX) :=
      siteProd_update_smul _ m (-Complex.I) pauliX
                                                        -- `kronecker_multilinear` の `r = 1` の場合（`j → m`, `c → -i`, `A_m → σ^x`）。具体版 `siteProd_update_smul`
    _ = (-Complex.I) • sigmaX m := rfl                  -- `def_site_pauli_matrices`（`k → m`, `a → x`）

/-- `σ^x_m = √-1 Z_m Y_m`（上の言い換え）。 -/
theorem sigmaX_eq_smul_Z_mul_Y (m : Fin M) : sigmaX m = Complex.I • (Z m * Y m) := by
  rw [Z_mul_Y_same, smul_smul, mul_neg, Complex.I_mul_I, neg_neg, one_smul]

/-- サイト作用素を左から順に掛けた接頭積。本文の有限帰納法で扱う左辺をそのまま表す。 -/
noncomputable def sigmaXPrefixProduct (M : ℕ) : ℕ → TensorPow M
  | 0 => 1
  | m + 1 => sigmaXPrefixProduct M m * if h : m < M then sigmaX ⟨m, h⟩ else 1

/-- 原文の `ε := σ^x_1 ⋯ σ^x_M`。

定義をサイト作用素の左からの接頭積そのものにすることで、下の有限帰納法が
`ε` の積表示を各因子のクロネッカー積へ変換する本文の段と一対一に対応する。

原文はさらに `ε = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M` と書いているが、これは
**和ではなく積**でなければならない（ファイル冒頭の「原文の記述に対する疑義」参照）。
積であることの根拠は `sigmaX_eq_smul_Z_mul_Y`（`σ^x_m = √-1 Z_m Y_m`）と
`xString_succ_eq`（文字列を 1 因子ずつ `√-1 Z_m Y_m` で伸ばせる）である。 -/
noncomputable def epsilon (M : ℕ) : TensorPow M := sigmaXPrefixProduct M M

/-- 本文の有限帰納法に対応し、サイト作用素の接頭積を各因子のクロネッカー積へ直す。 -/
theorem sigmaXPrefixProduct_eq_xString (m : ℕ) (hm : m ≤ M) :
    sigmaXPrefixProduct M m = xString M m := by
  induction m with
  | zero =>
      calc
        -- 本文第一帰納法の初項: `P_0` は空積なので単位行列である。
        sigmaXPrefixProduct M 0 = 1 := rfl
        -- 本文: 単位行列を全因子が `I` のクロネッカー積へ直す。
        _ = siteProd M (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) := (siteProd_one M).symm
        _ = siteProd M (fun i => if (i : ℕ) < 0 then pauliX else 1) := by
          apply congrArg (siteProd M)
          funext i
          simp
        _ = xString M 0 := rfl
  | succ m ih =>
      have hlt : m < M := Nat.lt_of_succ_le hm
      calc
        -- 本文第一帰納法: `P_{m+1}=P_m σ_{m+1}^x`。
        sigmaXPrefixProduct M (m + 1) =
            sigmaXPrefixProduct M m * sigmaX ⟨m, hlt⟩ := by
          rw [sigmaXPrefixProduct, dif_pos hlt]
        -- 本文: 帰納法の仮定を代入する。
        _ = xString M m * sigmaX ⟨m, hlt⟩ := by
          rw [ih (Nat.le_of_lt hlt)]
        -- 本文: 接頭積とサイト行列をそれぞれクロネッカー積へ展開する。
        _ = siteProd M (fun i => if (i : ℕ) < m then pauliX else 1) *
            siteProd M (Function.update 1 (⟨m, hlt⟩ : Fin M) pauliX) := by
          rw [xString, sigmaX, siteOp_apply]
        -- 本文: クロネッカー積の積を因子ごとの積へ移す。
        _ = siteProd M ((fun i : Fin M => if (i : ℕ) < m then pauliX else 1) *
            (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ)
              (⟨m, hlt⟩ : Fin M) pauliX)) :=
          (siteProd_mul M _ _).symm
        -- 本文: `σˣI=Iσˣ=σˣ` と `II=I` を各因子へ適用する。
        _ = siteProd M (fun i => if (i : ℕ) < m + 1 then pauliX else 1) := by
          congr 1
          funext i
          simp only [Pi.mul_apply, Function.update_apply, Pi.one_apply]
          rcases lt_trichotomy (i : ℕ) m with hi | hi | hi
          · have hne : i ≠ (⟨m, hlt⟩ : Fin M) :=
              Fin.ne_of_val_ne (show (i : ℕ) ≠ m by omega)
            rw [if_pos hi, if_neg hne, mul_one, if_pos (by omega)]
          · have he : i = (⟨m, hlt⟩ : Fin M) := Fin.val_injective hi
            rw [if_neg (by omega), if_pos he, one_mul, if_pos (by omega)]
          · have hne : i ≠ (⟨m, hlt⟩ : Fin M) :=
              Fin.ne_of_val_ne (show (i : ℕ) ≠ m by omega)
            rw [if_neg (by omega), if_neg hne, mul_one, if_neg (by omega)]
        _ = xString M (m + 1) := rfl

/-- 本文の有限帰納法の終端: `ε` は全因子が `σˣ` のクロネッカー積である。 -/
theorem epsilon_eq_siteProd_pauliX_by_induction :
    epsilon M = siteProd M (fun _ => pauliX) := by
  calc
    epsilon M = sigmaXPrefixProduct M M := rfl
    _ = xString M M := sigmaXPrefixProduct_eq_xString (M := M) M (Nat.le_refl M)
    _ = siteProd M (fun _ => pauliX) := by
      rw [xString]
      congr 1
      funext i
      rw [if_pos i.isLt]

/-- **`<epsilon_square_identity>` の人手証明と一対一に対応する具体版**:
有限帰納法でサイト積を全 `σˣ` 因子へ直し、クロネッカー積の積、`(σˣ)²=I₂`、
単位因子のクロネッカー積を順に適用する。 -/
theorem epsilon_mul_self : epsilon M * epsilon M = 1 := by
  rw [epsilon_eq_siteProd_pauliX_by_induction, ← siteProd_mul]
  have h : (fun _ : Fin M => pauliX) * (fun _ : Fin M => pauliX) = 1 := by
    funext i
    simp [Pi.mul_apply]
  rw [h, siteProd_one]

/-- `ε` の積表示の再帰形: `P_{m+1} = P_m · (√-1 Z_m Y_m)`。

これを `m = 0, …, M-1` と重ねれば `ε = P_M = (√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`（**積**）になる。
原文の `+`（和）では成り立たない。 -/
theorem xString_succ_eq (m : ℕ) (h : m < M) :
    xString M (m + 1) = xString M m * (Complex.I • (Z (⟨m, h⟩ : Fin M) * Y ⟨m, h⟩)) := by
  rw [xString_succ m h, sigmaX_eq_smul_Z_mul_Y]

/-- `Z_0Y_0,\ldots,Z_{m-1}Y_{m-1}` を添字順に左から掛けた接頭積。
本文の `Q_m` に対応する。 -/
noncomputable def zyPrefixProduct (M : ℕ) : ℕ → TensorPow M
  | 0 => 1
  | m + 1 => zyPrefixProduct M m *
      if h : m < M then Z (⟨m, h⟩ : Fin M) * Y ⟨m, h⟩ else 1

/-- **`<global_spin_flip_jordan_wigner_representation>` の第二の有限帰納法に対応する具体版**:
本文と同じ向きの `Q_m=(-√-1)^mP_m` を、局所積
`Z_mY_m=-√-1 σ^x_m` から空積・帰納段の順に示す。 -/
theorem zyPrefixProduct_eq_neg_i_pow_smul_xString (m : ℕ) (hm : m ≤ M) :
    zyPrefixProduct M m = (-Complex.I) ^ m • xString M m := by
  induction m with
  | zero =>
      calc
        -- 本文第二帰納法の初項: `Q_0` は空積なので単位行列である。
        zyPrefixProduct M 0 = 1 := rfl
        -- 本文: `(-i)^0=1`。
        _ = (-Complex.I) ^ 0 • (1 : TensorPow M) := by simp
        -- 本文: `P_0` の定義を代入する。
        _ = (-Complex.I) ^ 0 • xString M 0 := by rw [xString_zero]
  | succ m ih =>
      have hlt : m < M := Nat.lt_of_succ_le hm
      calc
        -- 本文第二帰納法: `Q_{m+1}=Q_m(Z_{m+1}Y_{m+1})`。
        zyPrefixProduct M (m + 1) =
            zyPrefixProduct M m * (Z ⟨m, hlt⟩ * Y ⟨m, hlt⟩) := by
          rw [zyPrefixProduct, dif_pos hlt]
        -- 本文: 帰納法の仮定を代入する。
        _ = ((-Complex.I) ^ m • xString M m) *
            (Z ⟨m, hlt⟩ * Y ⟨m, hlt⟩) := by
          rw [ih (Nat.le_of_lt hlt)]
        -- 本文: 局所積 `Z_{m+1}Y_{m+1}=-iσ_{m+1}^x` を代入する。
        _ = ((-Complex.I) ^ m • xString M m) *
            ((-Complex.I) • sigmaX ⟨m, hlt⟩) := by
          rw [Z_mul_Y_same]
        -- 本文: 左のスカラー作用を行列積の外へ出す。
        _ = (-Complex.I) ^ m •
            (xString M m * ((-Complex.I) • sigmaX ⟨m, hlt⟩)) := by
          rw [Matrix.smul_mul]
        -- 本文: 右因子のスカラー作用を内側の積の外へ出す。
        _ = (-Complex.I) ^ m •
            ((-Complex.I) • (xString M m * sigmaX ⟨m, hlt⟩)) := by
          rw [Matrix.mul_smul]
        -- 本文: 二つのスカラー作用を合成する。
        _ = (((-Complex.I) ^ m * (-Complex.I)) •
            (xString M m * sigmaX ⟨m, hlt⟩)) := by
          rw [smul_smul]
        -- 本文: `(-i)` の冪の再帰を適用する。
        _ = (-Complex.I) ^ (m + 1) •
            (xString M m * sigmaX ⟨m, hlt⟩) := by rw [pow_succ]
        -- 本文: `P_{m+1}` の定義を代入する。
        _ = (-Complex.I) ^ (m + 1) • xString M (m + 1) := by
          rw [xString_succ m hlt]

/-- 全スピン反転行列の Jordan--Wigner 表示（原文の右辺は和でなく積）。 -/
theorem epsilon_eq_i_pow_smul_zyPrefixProduct :
    epsilon M = Complex.I ^ M • zyPrefixProduct M M := by
  calc
    -- 本文終端: 全スピン反転行列の定義を接頭積 `P_M` へ直す。
    epsilon M = sigmaXPrefixProduct M M := rfl
    _ = xString M M := sigmaXPrefixProduct_eq_xString (M := M) M (Nat.le_refl M)
    -- 本文: `P_M=1^MP_M`。
    _ = (1 : ℂ) ^ M • xString M M := by simp
    -- 本文: `i(-i)=1` を底へ代入する。
    _ = (Complex.I * (-Complex.I)) ^ M • xString M M := by
      rw [mul_neg, Complex.I_mul_I, neg_neg]
    -- 本文: 積の冪を二つの冪の積へ分ける。
    _ = (Complex.I ^ M * (-Complex.I) ^ M) • xString M M := by rw [mul_pow]
    -- 本文: スカラー作用の合成として `i^M` を外側へ出す。
    _ = Complex.I ^ M • ((-Complex.I) ^ M • xString M M) := by rw [mul_smul]
    -- 本文: 第二帰納法の終端 `Q_M=(-i)^MP_M` を代入する。
    _ = Complex.I ^ M • zyPrefixProduct M M := by
      rw [zyPrefixProduct_eq_neg_i_pow_smul_xString (M := M) M (Nat.le_refl M)]

end JordanWigner

end Ising2D
