/-
# `(V_1^{(+)})^{1/2}` の定義と平方根性、偶セクターの転送行列 `V^{(+)}` の定義

対応する人手証明（正本は `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`）:

* `bridge_definition_V1_pm_square_root`（ラベル **`def_V1_plus_square_root`**）
  — `(V_1^{(+)})^{1/2} := exp((i/2) K_1 H_1^{(+)})`（`Ising2D.V1plusHalf`）
* `bridge_claim_V1_pm_square_root_squares_to_V1_pm`（ラベル **`V1_plus_square_root_property`**）
  — `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}`（`Ising2D.V1_plus_square_root_property`。この主張の正本は
  `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）
* `evensectorT_definition_V_plus`（ラベル **`def_V_plus`**）
  — `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}`（`Ising2D.VPlusOfTransfer`。
  `V_2` は `def_transfer_matrix` の `V_2`）

`(i/2) K_1` は Lean では `(1/2) * √-1 * K_1` と書く。一般の行列の平方根は一意でないので、
人手と同じく最初から `exp(X/2)` を定義に採る。

章 014〜018 の `VPlus M s2 K1 K2star`（`EigenvalueProblem/ReductionToATheta/DefinitionVPlus.lean`）は、`V_2` を
`V2_exponential_representation` の右辺の式 `V2H2Form`（`s2`, `K2star` を独立な引数とする一般化）で
書いた補助の一般形である。`s2 = sinh 2K_2`, `K2star = K_2^*` で本ファイルの `VPlusOfTransfer` と
一致する（`Ising2D.VPlusOfTransfer_eq_VPlus`、`EigenvalueProblem/ReductionToATheta/DefinitionVPlus.lean`）。

## `V1_plus_square_root_property` の人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備の `c + c = iκ` の 10 行 | `c_add_c_eq_I_mul` の 10 段（5 行目の `one_plus_one_is_two_in_cc` は `complex_one_add_one_eq_ofReal_two`。人手の `2_ℂ` は `def_V1_plus_square_root` の `(2_ℝ)_ℂ` で、Lean の `((2 : ℝ) : ℂ)`） |
| 主張の 9 行 `((V_1^{(+)})^{1/2})^2 = ⋯ = V_1^{(+)}` | `V1_plus_square_root_property` の 9 段 |

- 人手の `κ := (K_1)_ℂ` は、Lean の `K1 : ℂ` がはじめから複素数なので `κ = K1` と置くだけである。
- 人手の `c`・`X`・`c_1, c_2` は、`c = i·2_ℂ^{-1}κ`・`X = cH_1^{(+)}` の等式を持つ変数として置き、「`c` の定義」「`X` の定義」の行を
  その等式による書き換えの段にした。`c_1, c_2` は `![c, c] : Fin 2 → ℂ` の 2 つの成分で、`c_1 = c_2 = c` は定義から（`rfl`）出る。
- 準備の `XX = XX`（等号の反射律）は `Commute.refl`。
- 主張の 2 行目の `def_V1_plus_square_root` は、Lean の定義の係数 `(1/2 : ℂ) * √-1 * K_1` を人手の読み `i·2_ℂ^{-1}` へ直す
  `V1plusHalf_coeff_eq` を通す（Lean の `(1 / 2 : ℂ)` を `((1/2 : ℝ) : ℂ)` と読み、`real_inclusion_of_one_half_is_inverse_of_two`
  と積の可換律で `i·2_ℂ^{-1}` にする）。定義の係数を人手の形に替えるのは状態台帳の別の件である。
- `theorem_exp_product` は Lean の具体版が無く、ほかのファイルと同じく mathlib の `Matrix.exp_add_of_commute` を引く。
- `def_finite_sum_of_matrices`・`def_finite_sum_of_complex_numbers` の `r = 1` と `r + 1 = 2` の段は、ほかのファイルと同じく
  `Fin.sum_univ_castSucc`・`Fin.sum_univ_one` で出す。`finite_sum_of_scalar_multiples_of_one_matrix`（`r → 2`）は
  `TensorPow M` の系 `finite_sum_smul_one_tensorPow`（人手の `r` は Lean の `r + 1`）。
- `ℂ` の体の公理（`complex_numbers_form_a_field`）は mathlib の `mul_add`・`mul_one`・`mul_comm`・`mul_assoc`・`inv_mul_cancel₀`・`one_mul`。
  `2_ℂ ≠ 0_ℂ` は `real_inclusion_two_ne_zero`。
- 人手の主張の前置き `M_col ≥ 2` は証明で使わないので、Lean の主張は `M` に条件を付けない。

必要十分版は置かない。平方根性の核「可換な `X, X` について `exp X exp X = exp(X+X)`」は mathlib の
`Matrix.exp_add_of_commute` そのものであり、残りは具体的な二つの数 `c + c` の計算と二項の有限和の展開で、ほどく構造が無い。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionTransferMatrix
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimOnePlusOneIsTwoInCC
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionOfOneHalfIsInverseOfTwo
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultiplesOfOneMatrixFromNecSuf

namespace Ising2D

variable {M : ℕ}

/-- **人手本文 `def_V1_plus_square_root`**: `(V_1^{(+)})^{1/2} := exp((i/2) K_1 H_1^{(+)})`。
人手は `i/2 := i·2_ℂ^{-1}` とし、`(i/2)K_1H_1^{(+)}` を `ℂ` の元 `(i/2)(K_1)_ℂ` によるスカラー倍と読む。
Lean は係数を `(1 / 2 : ℂ) * Complex.I * K1` と書き、`K1 : ℂ` なので包含は書かない。Lean の `(1 / 2 : ℂ)` は人手の
`(1/2)_ℂ = 2_ℂ^{-1}`（`real_inclusion_of_one_half_is_inverse_of_two`）に当たり、並びは `((1/2)_ℂ i)K_1` で人手と交換律の分だけ違う。 -/
noncomputable def V1plusHalf (M : ℕ) (K1 : ℂ) : TensorPow M :=
  matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)

/-- `(V_1^{(+)})^{1/2}` は一般形 `V1pmHalf` の `η = -1`。 -/
theorem V1plusHalf_eq_V1pmHalf (K1 : ℂ) : V1plusHalf M K1 = V1pmHalf M K1 (-1) := rfl

/-- **人手 `V1_plus_square_root_property` の準備**: `c := (i·2_ℂ^{-1})κ` について `c + c = iκ` の 10 行。 -/
theorem c_add_c_eq_I_mul (κ c : ℂ) (hc : c = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * κ) :
    c + c = Complex.I * κ :=
  calc c + c
      = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * κ + (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * κ := by
        rw [hc]                                         -- `c` の定義を 2 箇所へ
    _ = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * (κ + κ) := (mul_add _ _ _).symm
                                                        -- 分配律
    _ = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * (κ * 1 + κ * 1) := by
        rw [mul_one]                                    -- `1_ℂ` は積の単位元。2 箇所へ
    _ = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * (κ * (1 + 1)) := by
        rw [mul_add κ]                                  -- 分配律
    _ = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * (κ * ((2 : ℝ) : ℂ)) := by
        rw [complex_one_add_one_eq_ofReal_two]          -- `one_plus_one_is_two_in_cc`（`2_ℂ` は `def_V1_plus_square_root` の `(2_ℝ)_ℂ`）
    _ = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * (((2 : ℝ) : ℂ) * κ) := by
        rw [mul_comm κ]                                 -- 積の可換律
    _ = Complex.I * (((2 : ℝ) : ℂ)⁻¹ * (((2 : ℝ) : ℂ) * κ)) := mul_assoc _ _ _
                                                        -- 積の結合律
    _ = Complex.I * ((((2 : ℝ) : ℂ)⁻¹ * ((2 : ℝ) : ℂ)) * κ) := by
        rw [mul_assoc]                                  -- 積の結合律
    _ = Complex.I * (1 * κ) := by
        rw [inv_mul_cancel₀ real_inclusion_two_ne_zero] -- `2_ℂ^{-1}` は `2_ℂ ≠ 0_ℂ` の逆元
    _ = Complex.I * κ := by
        rw [one_mul]                                    -- `1_ℂ` は積の単位元

/-- `def_V1_plus_square_root` の `i/2` の読み `i·2_ℂ^{-1}`: Lean の定義の係数 `(1/2 : ℂ) * √-1` を人手の `i·2_ℂ^{-1}` へ直す。
Lean の `(1 / 2 : ℂ)` を `((1/2 : ℝ) : ℂ)` と読み（包含が商・`1`・`2` を保つ mathlib の `Complex.ofReal_div`・`Complex.ofReal_one`・`Complex.ofReal_ofNat`）、
`real_inclusion_of_one_half_is_inverse_of_two` と積の可換律を引く。 -/
theorem V1plusHalf_coeff_eq (K1 : ℂ) :
    (1 / 2 : ℂ) * Complex.I * K1 = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * K1 :=
  calc (1 / 2 : ℂ) * Complex.I * K1
      = ((1 / 2 : ℝ) : ℂ) * Complex.I * K1 := by
        rw [Complex.ofReal_div, Complex.ofReal_one, Complex.ofReal_ofNat]
                                                        -- Lean の `(1/2 : ℂ)` を `(1/2)_ℂ` と読む
    _ = ((2 : ℝ) : ℂ)⁻¹ * Complex.I * K1 := by
        rw [real_inclusion_half_eq_inv_two]             -- `real_inclusion_of_one_half_is_inverse_of_two`
    _ = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * K1 := by
        rw [mul_comm ((2 : ℝ) : ℂ)⁻¹ Complex.I]         -- 積の可換律

/-- **人手本文 `V1_plus_square_root_property`**: `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}`（`A^2 := AA`）。
人手の主張の 9 行と 1 対 1 の `calc`（対応はファイル冒頭の表）。 -/
theorem V1_plus_square_root_property (K1 : ℂ) :
    V1plusHalf M K1 ^ 2 = V1plus M K1 := by
  -- 準備: `κ := (K_1)_ℂ`（Lean の `K1` はそのまま）、`c := (i·2_ℂ^{-1})κ`、`X := cH_1^{(+)}`、`c_1 := c`、`c_2 := c`
  obtain ⟨c, hc⟩ : ∃ c : ℂ, c = (Complex.I * ((2 : ℝ) : ℂ)⁻¹) * K1 := ⟨_, rfl⟩
  obtain ⟨X, hX⟩ : ∃ X : TensorPow M, X = c • H1plus M := ⟨_, rfl⟩
  -- 準備の `XX = XX`（等号の反射律）
  have hXX : Commute X X := Commute.refl X
  calc V1plusHalf M K1 ^ 2
      = V1plusHalf M K1 * V1plusHalf M K1 := sq _       -- `A^2 := AA`
    _ = matExp X * matExp X := by
        rw [V1plusHalf, V1plusHalf_coeff_eq, ← hc, ← hX]
                                                        -- `def_V1_plus_square_root`（係数の読み `i/2 := i·2_ℂ^{-1}` は `V1plusHalf_coeff_eq`）と `c`・`X` の定義を 2 箇所へ
    _ = matExp (X + X) := (Matrix.exp_add_of_commute X X hXX).symm
                                                        -- `theorem_exp_product`（`n → 2^{M_col}`、`K → ℂ`、`A, B → X`）と準備の `XX = XX`
    _ = matExp (c • H1plus M + c • H1plus M) := by
        rw [hX]                                         -- `X` の定義を 2 箇所へ
    _ = matExp (∑ j : Fin 2, (![c, c] j) • H1plus M) := by
        rw [Fin.sum_univ_castSucc, Fin.sum_univ_one]; rfl
                                                        -- `c_1 = c_2 = c` と `def_finite_sum_of_matrices`（`r → 1`、`X_j → c_jH_1^{(+)}`）の `r = 1` と `r + 1 = 2` の段
    _ = matExp ((∑ j : Fin 2, ![c, c] j) • H1plus M) := by
        rw [finite_sum_smul_one_tensorPow 1]            -- `finite_sum_of_scalar_multiples_of_one_matrix`（`m, n → 2^{M_col}`、`r → 2`、`A → H_1^{(+)}`）
    _ = matExp ((c + c) • H1plus M) := by
        rw [Fin.sum_univ_castSucc, Fin.sum_univ_one]; rfl
                                                        -- `def_finite_sum_of_complex_numbers`（`m → 1`、`z_j → c_j`）の `m = 1` と `m + 1 = 2` の段と `c_1 = c_2 = c`
    _ = matExp ((Complex.I * K1) • H1plus M) := by
        rw [c_add_c_eq_I_mul K1 c hc]                   -- 準備の `c + c = iκ`
    _ = V1plus M K1 := (V1plus_exponential_representation M K1).symm
                                                        -- `V1_plus_exponential_representation`

/-- `(V_1^{(+)})^{1/2}` を単元として（逆元は `exp(-(i/2)K_1H_1^{(+)})`）。 -/
noncomputable def V1plusHalfUnits (M : ℕ) (K1 : ℂ) : (TensorPow M)ˣ :=
  matExpUnits (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)

@[simp]
theorem V1plusHalfUnits_val (K1 : ℂ) :
    ((V1plusHalfUnits M K1 : (TensorPow M)ˣ) : TensorPow M) = V1plusHalf M K1 := rfl

/-- 単元としても一般形の `η = -1`。 -/
theorem V1plusHalfUnits_eq_V1pmHalfUnits (K1 : ℂ) :
    V1plusHalfUnits M K1 = V1pmHalfUnits M K1 (-1) := rfl

/-- **人手本文 `def_V_plus`**: `V^{(+)} := (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}`
（`V_2` は `def_transfer_matrix` の `V_2`）。 -/
noncomputable def VPlusOfTransfer (M : ℕ) (K1 : ℂ) (K2 : ℝ) : TensorPow M :=
  V1plusHalf M K1 * V2 M K2 * V1plusHalf M K1

end Ising2D
