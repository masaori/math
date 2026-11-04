/-
# `V^{(+)}` は正定値（**具体版**）

対応する人手証明（`V_plus_is_positive_definite`、`V_plus_is_invertible`、`trace_V_plus_is_positive` は
`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`、
`V_plus_inverse_is_positive_definite`、`V_plus_inverse_positive_and_trace_positivity` は
`structured-latex/notes/claims_unused_by_chapter_goals_not_adopted.ts`（本文から参照用ノートへ退避した主張。この Lean は形式化の記録として残す））。

**必要十分版は置かない。** この主張は `S_1^{(+)}, S_2` というこの模型の具体的な対象についての
主張であり、取り払える一般構造が無い。使っている一般論（エルミート行列の `exp` が正定値、
`B^* A B` が正定値、正実数倍が正定値）は数学的道具立て「トレース・共役転置・正定値性」の
`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPositiveDefinite.lean` で既に「任意の有限次元複素行列」について
述べてあり、そこがこの主張の必要十分版にあたる。

## 記号

`S_1^{(+)} := i(K_1)_ℂH_1^{(+)}` は `(Complex.I * K1) • H1plus M`、`S_2 := i(K_2^*)_ℂH_2` は `(Complex.I * K2star) • H2 M`、
`\tfrac12 S_1^{(+)} = (\tfrac12)_ℂ S_1^{(+)}` は `(1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)` と書く（Lean の `K1`・`K2star` は
はじめから `ℂ` の元で、包含 `(·)_ℂ` は書かない。`(1 / 2 : ℂ)` が人手の `(\tfrac12)_ℂ` に当たる）。
`V^{(+)}` は `V_2` を `V2H2Form` で書いた `Ising2D.VPlus`（`EigenvalueProblem/ReductionToATheta/DefinitionVPlus.lean`。
人手の `V_2` の値では `VPlusOfTransfer_eq_VPlus`）である。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveDefinite
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimIHPauliForm
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionVPlus
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimTraceCheckVprime
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegationFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfNegativeIsLeftInverseFromNecSuf

namespace Ising2D

open Matrix
open scoped ComplexOrder

section VPlus

variable {M : ℕ}

/-- **原文 `V_plus_is_positive_definite` の statement の表示（Step 1）**:
`V^{(+)} = ((2s_2)^{M/2})_ℂ exp(½S_1^{(+)}) exp(S_2) exp(½S_1^{(+)})`。
`calc` の 1 段目が人手の最後の鎖の 1 行目（`def_V_plus`）、2〜4 段目が `(V_1^{(+)})^{1/2}` の鎖の 9 行、5 段目が `V_2` の鎖の 4 行、
6・7 段目が最後の鎖の 3・4 行目である。人手の最後の鎖の 2 行目（上の二つの鎖の代入）は、2〜5 段目に分かれて入っている。`(V_1^{(+)})^{1/2}` の鎖の 9 行のうち、Lean で書き換えが要るのは
1 行目（`def_V1_plus_square_root`）・6 行目（ℂ の積の結合律）・7 行目（`scalar_multiple_is_associative`）だけである。ほかの行は次の理由で要らないが、
3〜5 行目は Lean と 1 対 1 でない（下の 2 つ目の項目。状態台帳の `V1plusHalf` の係数の書き方の件）。
- 2 行目（`K_1` の包含 `(K_1)_ℂ`）: Lean の `K1 : ℂ` がはじめから複素数である。
- 3〜5 行目（`i/2 = i·2_ℂ^{-1}` の読み、`real_inclusion_of_one_half_is_inverse_of_two` で `i(1/2)_ℂ`、交換律で `(1/2)_ℂ i`）:
  `V1plusHalf` の定義がはじめから人手の 5 行目の形 `((1/2)_ℂ i)K_1` で書いてある。ただし Lean の `(1 / 2 : ℂ)` は ℂ の数値リテラルの割り算で、
  型の上では `((2 : ℝ) : ℂ)⁻¹`（人手の `2_ℂ^{-1}`）とも `((1 / 2 : ℝ) : ℂ)`（人手の `(1/2)_ℂ`）とも別の式であり、
  `real_inclusion_half_eq_inv_two` をこの `calc` に通していない。並びも人手の `i·2_ℂ^{-1}` と交換律の分だけずれている。
- 8・9 行目（`S_1^{(+)}` の置き方、主張の略記）: Lean は `(1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)` をそのまま書く。
- `V_2` の鎖の 2 つの包含の行: 2 行目と同じ理由。
人手の括弧の省略（`mat_mult_associative`）は、Lean の積が左結合なので要らない。 -/
theorem VPlus_eq_smul (s2 : ℝ) (K1 K2star : ℂ) :
    VPlus M s2 K1 K2star
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
        • (matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))
            * matExp ((Complex.I * K2star) • H2 M)
            * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) := by
  calc VPlus M s2 K1 K2star
      = V1plusHalf M K1 * V2H2Form M s2 K2star * V1plusHalf M K1 := by
        -- `def_V_plus`
        rw [VPlus]
    _ = matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) * V2H2Form M s2 K2star
          * matExp (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) := by
        -- `(V_1^{(+)})^{1/2}` の鎖の 1 行目（`def_V1_plus_square_root`）。2〜5 行目は Lean では書き換えが要らない（上の説明）
        rw [V1plusHalf]
    _ = matExp (((1 / 2 : ℂ) * (Complex.I * K1)) • H1plus M) * V2H2Form M s2 K2star
          * matExp (((1 / 2 : ℂ) * (Complex.I * K1)) • H1plus M) := by
        -- `(V_1^{(+)})^{1/2}` の鎖の 6 行目（ℂ の積の結合律 `((1/2)_ℂ i)K_1 = (1/2)_ℂ(iK_1)`）
        rw [mul_assoc (1 / 2 : ℂ) Complex.I K1]
    _ = matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) * V2H2Form M s2 K2star
          * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) := by
        -- `(V_1^{(+)})^{1/2}` の鎖の 7 行目 `scalar_multiple_is_associative`（`a → (1/2)_ℂ`、`b → i(K_1)_ℂ`、`A → H_1^{(+)}`。
        -- Lean の具体版は無く、mathlib の `smul_smul`）。8・9 行目は書き換えが要らない
        rw [← smul_smul]
    _ = matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))
          * (((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) • matExp ((Complex.I * K2star) • H2 M))
          * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) := by
        -- `V_2` の鎖（`V2_exponential_representation` の右辺、`K_2^*` の包含、`S_2 = i(K_2^*)_ℂH_2`）。人手の最後の鎖の「上の二つの鎖」の代入
        rw [V2H2Form]
    _ = (((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
          • (matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))
              * matExp ((Complex.I * K2star) • H2 M)))
          * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) := by
        -- `scalar_multiple_factors_out_of_right_factor`（`B(cA) = c(BA)`）
        rw [mul_smul_matrix_tensorPow]
    _ = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
          • (matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))
              * matExp ((Complex.I * K2star) • H2 M)
              * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) := by
        -- `scalar_multiple_factors_out_of_left_factor`（`(c(BA))B = c((BA)B)`）
        rw [smul_mul_matrix_tensorPow]

/-- **原文 `V_plus_is_positive_definite` Step 2〜3**: `V^{(+)}` は正定値。 -/
theorem VPlus_posDef {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (VPlus M s2 K1 K2star).PosDef := by
  set B := matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) with hB
  set A := matExp ((Complex.I * K2star) • H2 M) with hA
  -- Step 2: `\tfrac12 S_1^{(+)}` はエルミート（`iH_is_real_symmetric` と実係数倍）。`S_2` は `iH_is_real_symmetric` と `real_symmetric_matrix_is_hermitian`（`S2_isHermitian`）
  have hS1 : ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)).IsHermitian := by
    have h : ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))ᴴ
        = (1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M) := by
      rw [Matrix.conjTranspose_smul, (S1plus_isHermitian hK1).eq]
      norm_num
    exact h
  -- Step 2: `B` はエルミート（`exp_hermitian_is_positive_definite`）
  have hBherm : B.IsHermitian := by rw [hB, matExp]; exact hS1.exp
  -- Step 2: `B` は可逆
  have hBinj : Function.Injective B.mulVec := by
    rw [hB, matExp]
    exact Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  -- Step 2: `A` は正定値（`exp_hermitian_is_positive_definite`）
  have hApos : A.PosDef := by
    rw [hA, matExp]
    exact posDef_exp_of_isHermitian (S2_isHermitian hK2)
  -- Step 3: `B^* A B` は正定値（`congruence_preserves_positive_definite`）、`B^* = B`（`def_hermitian_positive_definite` のエルミートの定義）。
  -- 人手の Step 3 の鎖 `c((BA)B) = c(B(AB)) = c(B^*(AB))` と係数の行とは、まだ 1 対 1 でない（状態台帳の `VPlus_posDef` の件）
  have hBAB : (Bᴴ * A * B).PosDef := hApos.conjTranspose_mul_mul_same hBinj
  rw [hBherm.eq] at hBAB
  -- Step 3: `(2s_2)^{M/2} > 0` 倍も正定値（`positive_real_multiple_preserves_positive_definite`）
  rw [VPlus_eq_smul]
  refine posDef_smul_of_pos hBAB ?_
  have : (0 : ℝ) < 2 * s2 := by linarith
  exact Real.rpow_pos_of_pos this _

/-- **原文 `V_plus_is_invertible` の `R^{(+)}`**:
`R^{(+)} := ((2s_2)^{-M/2})_ℂ exp(-½S_1^{(+)}) exp(-S_2) exp(-½S_1^{(+)})`。
人手の主張は `(2s_2)^{-M/2} := ((2s_2)^{M/2})^{-1} ∈ ℝ`（`ℝ` の逆数）と置くので、係数を同じ式で書く。 -/
noncomputable def VPlusInv (M : ℕ) (K1 : ℂ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  (((((2 * s2) ^ ((M : ℝ) / 2))⁻¹ : ℝ) : ℂ)) •
    (matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)))
      * matExp (-((Complex.I * K2star) • H2 M))
      * matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))))

/-- `a := (2s_2)^{M/2} ∈ ℝ_{>0}` は `0` でない（人手 Step 2 の `a ∈ ℝ_{>0}`）。 -/
theorem real_rpow_two_s2_ne_zero {s2 : ℝ} (hs2 : 0 < s2) :
    (2 * s2) ^ ((M : ℝ) / 2) ≠ 0 :=
  (Real.rpow_pos_of_pos (by linarith) _).ne'

/-! ### 原文 `V_plus_is_invertible` Step 1（指数行列どうしの左右逆）

人手の 4 つの鎖は、`E_-E_+`・`A_-A_+` が `exp_of_negative_is_left_inverse` の 1 行、`E_+E_-`・`A_+A_-` が
`matrix_double_negation` で `exp(X) = exp(-(-X))` と書き直してから `exp_of_negative_is_left_inverse`（`A → -X`）を引く 2 行である。
同じ形を一般の `X` について書き、4 つの左右逆はその代入として得る（人手の各鎖の 1 行目「`E_±`・`A_±` の置き方」は、
下の `expHalfS1plus_mul_expNegHalfS1plus` などの代入が担う）。`exp_of_negative_is_left_inverse` は
`MathematicalTools/MatrixExponentialAndCommutators/ClaimExpOfNegativeIsLeftInverse.lean` の具体版の `TensorPow M` の系
`matExp_neg_mul_matExp_tensorPow`（`ClaimExpOfNegativeIsLeftInverseFromNecSuf.lean`）を引く。 -/

/-- `exp(X) exp(-X) = I`（人手 Step 1 の第一・第三の鎖）。 -/
theorem matExp_mul_matExp_neg_eq_one (X : TensorPow M) : matExp X * matExp (-X) = 1 := by
  calc matExp X * matExp (-X)
      = matExp (-(-X)) * matExp (-X) := by
        -- `matrix_double_negation`（`A → X`）
        rw [neg_neg_tensorPow]
    _ = 1 := by
        -- `exp_of_negative_is_left_inverse`（`A → -X`）
        exact matExp_neg_mul_matExp_tensorPow (-X)

/-- 人手 Step 1 の第一の左右逆 `E_+E_- = I`。 -/
theorem expHalfS1plus_mul_expNegHalfS1plus (K1 : ℂ) :
    matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))
      * matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) = 1 :=
  matExp_mul_matExp_neg_eq_one _

/-- 人手 Step 1 の第二の左右逆 `E_-E_+ = I`。 -/
theorem expNegHalfS1plus_mul_expHalfS1plus (K1 : ℂ) :
    matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)))
      * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) = 1 :=
  matExp_neg_mul_matExp_tensorPow _

/-- 人手 Step 1 の第三の左右逆 `A_+A_- = I`。 -/
theorem expS2_mul_expNegS2 (K2star : ℂ) :
    matExp ((Complex.I * K2star) • H2 M) * matExp (-((Complex.I * K2star) • H2 M)) = 1 :=
  matExp_mul_matExp_neg_eq_one _

/-- 人手 Step 1 の第四の左右逆 `A_-A_+ = I`。 -/
theorem expNegS2_mul_expS2 (K2star : ℂ) :
    matExp (-((Complex.I * K2star) • H2 M)) * matExp ((Complex.I * K2star) • H2 M) = 1 :=
  matExp_neg_mul_matExp_tensorPow _

/-- **原文 `V_plus_is_invertible` Step 2**: `VPlusInv` は `V^{(+)}` の右逆。 -/
theorem VPlus_mul_VPlusInv {K1 K2star : ℂ} {s2 : ℝ} (hs2 : 0 < s2) :
    VPlus M s2 K1 K2star * VPlusInv M K1 s2 K2star = 1 := by
  -- 人手 Step 2: `a := (2s_2)^{M/2} ∈ ℝ`、`a ∈ ℝ_{>0}`。スカラー倍の係数は包含 `a_ℂ`・`(a^{-1})_ℂ`。
  set a : ℝ := (2 * s2) ^ ((M : ℝ) / 2) with ha
  have hane : a ≠ 0 := real_rpow_two_s2_ne_zero hs2
  set Ep := matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) with hEp
  set Em := matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) with hEm
  set Ap := matExp ((Complex.I * K2star) • H2 M) with hAp
  set Am := matExp (-((Complex.I * K2star) • H2 M)) with hAm
  have hEpEm : Ep * Em = 1 := expHalfS1plus_mul_expNegHalfS1plus K1
  have hApAm : Ap * Am = 1 := expS2_mul_expNegS2 K2star
  calc VPlus M s2 K1 K2star * VPlusInv M K1 s2 K2star
      = ((a : ℂ) • (Ep * Ap * Ep)) * (((a⁻¹ : ℝ) : ℂ) • (Em * Am * Em)) := by
        -- `V^{(+)}` と `R^{(+)}` の表示（`R^{(+)}` の係数は主張の置き方 `(2s_2)^{-M/2} = a^{-1}`）
        rw [VPlus_eq_smul, VPlusInv]
    _ = (a : ℂ) • ((Ep * Ap * Ep) * (((a⁻¹ : ℝ) : ℂ) • (Em * Am * Em))) := by
        -- `scalar_multiple_factors_out_of_left_factor`
        rw [smul_mul_matrix_tensorPow]
    _ = (a : ℂ) • (((a⁻¹ : ℝ) : ℂ) • ((Ep * Ap * Ep) * (Em * Am * Em))) := by
        -- `scalar_multiple_factors_out_of_right_factor`
        rw [mul_smul_matrix_tensorPow]
    _ = ((a : ℂ) * ((a⁻¹ : ℝ) : ℂ)) • ((Ep * Ap * Ep) * (Em * Am * Em)) := by
        -- `scalar_multiple_is_associative`（Lean の具体版は無く、mathlib の `smul_smul`）
        rw [smul_smul]
    _ = ((a * a⁻¹ : ℝ) : ℂ) • ((Ep * Ap * Ep) * (Em * Am * Em)) := by
        -- `real_inclusion_preserves_product`（`a → a`、`b → a^{-1}`。具体版 `real_inclusion_mul`）
        rw [real_inclusion_mul]
    _ = ((1 : ℝ) : ℂ) • ((Ep * Ap * Ep) * (Em * Am * Em)) := by
        -- `ℝ` で `aa^{-1} = 1`
        rw [mul_inv_cancel₀ hane]
    _ = (1 : ℂ) • ((Ep * Ap * Ep) * (Em * Am * Em)) := by
        -- `1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = 1`
        rw [Complex.ofReal_one]
    _ = (Ep * Ap * Ep) * (Em * Am * Em) := by
        -- `scalar_multiple_by_one`（具体版 `matrix_one_smul` の `TensorPow M` の系）
        rw [one_smul_tensorPow]
    _ = ((Ep * Ap * Ep) * (Em * Am)) * Em := by
        -- `mat_mult_associative`（Lean の具体版は無く、mathlib の `Matrix.mul_assoc` を 1 回）
        rw [Matrix.mul_assoc (Ep * Ap * Ep) (Em * Am) Em]
    _ = ((Ep * Ap) * (Ep * (Em * Am))) * Em := by
        -- `mat_mult_associative`
        rw [Matrix.mul_assoc (Ep * Ap) Ep (Em * Am)]
    _ = ((Ep * Ap) * ((Ep * Em) * Am)) * Em := by
        -- `mat_mult_associative`
        rw [Matrix.mul_assoc Ep Em Am]
    _ = ((Ep * Ap) * (1 * Am)) * Em := by rw [hEpEm]
    _ = ((Ep * Ap) * Am) * Em := by
        -- `identity_matrix_is_left_unit_of_mat_mult` を `A_-` へ適用
        rw [identity_matrix_mul_tensorPow]
    _ = (Ep * (Ap * Am)) * Em := by
        -- `mat_mult_associative`
        rw [Matrix.mul_assoc Ep Ap Am]
    _ = (Ep * 1) * Em := by rw [hApAm]
    _ = Ep * Em := by
        -- `identity_matrix_is_right_unit_of_mat_mult` を `E_+` へ適用
        rw [mul_identity_matrix_tensorPow]
    _ = 1 := hEpEm

/-- **原文 `V_plus_is_invertible` Step 3**: `VPlusInv` は `V^{(+)}` の左逆。 -/
theorem VPlusInv_mul_VPlus {K1 K2star : ℂ} {s2 : ℝ} (hs2 : 0 < s2) :
    VPlusInv M K1 s2 K2star * VPlus M s2 K1 K2star = 1 := by
  -- 人手 Step 2: `a := (2s_2)^{M/2} ∈ ℝ`、`a ∈ ℝ_{>0}`。スカラー倍の係数は包含 `a_ℂ`・`(a^{-1})_ℂ`。
  set a : ℝ := (2 * s2) ^ ((M : ℝ) / 2) with ha
  have hane : a ≠ 0 := real_rpow_two_s2_ne_zero hs2
  set Ep := matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) with hEp
  set Em := matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) with hEm
  set Ap := matExp ((Complex.I * K2star) • H2 M) with hAp
  set Am := matExp (-((Complex.I * K2star) • H2 M)) with hAm
  have hEmEp : Em * Ep = 1 := expNegHalfS1plus_mul_expHalfS1plus K1
  have hAmAp : Am * Ap = 1 := expNegS2_mul_expS2 K2star
  calc VPlusInv M K1 s2 K2star * VPlus M s2 K1 K2star
      = (((a⁻¹ : ℝ) : ℂ) • (Em * Am * Em)) * ((a : ℂ) • (Ep * Ap * Ep)) := by
        -- `R^{(+)}` と `V^{(+)}` の表示（`R^{(+)}` の係数は主張の置き方 `(2s_2)^{-M/2} = a^{-1}`）
        rw [VPlus_eq_smul, VPlusInv]
    _ = ((a⁻¹ : ℝ) : ℂ) • ((Em * Am * Em) * ((a : ℂ) • (Ep * Ap * Ep))) := by
        -- `scalar_multiple_factors_out_of_left_factor`
        rw [smul_mul_matrix_tensorPow]
    _ = ((a⁻¹ : ℝ) : ℂ) • ((a : ℂ) • ((Em * Am * Em) * (Ep * Ap * Ep))) := by
        -- `scalar_multiple_factors_out_of_right_factor`
        rw [mul_smul_matrix_tensorPow]
    _ = (((a⁻¹ : ℝ) : ℂ) * (a : ℂ)) • ((Em * Am * Em) * (Ep * Ap * Ep)) := by
        -- `scalar_multiple_is_associative`（Lean の具体版は無く、mathlib の `smul_smul`）
        rw [smul_smul]
    _ = ((a⁻¹ * a : ℝ) : ℂ) • ((Em * Am * Em) * (Ep * Ap * Ep)) := by
        -- `real_inclusion_preserves_product`（`a → a^{-1}`、`b → a`。具体版 `real_inclusion_mul`）
        rw [real_inclusion_mul]
    _ = ((1 : ℝ) : ℂ) • ((Em * Am * Em) * (Ep * Ap * Ep)) := by
        -- `ℝ` で `a^{-1}a = 1`
        rw [inv_mul_cancel₀ hane]
    _ = (1 : ℂ) • ((Em * Am * Em) * (Ep * Ap * Ep)) := by
        -- `1_ℂ` は `inclusion_rr_to_cc` の略記 `r_ℂ` の `r = 1`
        rw [Complex.ofReal_one]
    _ = (Em * Am * Em) * (Ep * Ap * Ep) := by
        -- `scalar_multiple_by_one`（具体版 `matrix_one_smul` の `TensorPow M` の系）
        rw [one_smul_tensorPow]
    _ = ((Em * Am * Em) * (Ep * Ap)) * Ep := by
        -- `mat_mult_associative`（Lean の具体版は無く、mathlib の `Matrix.mul_assoc` を 1 回）
        rw [Matrix.mul_assoc (Em * Am * Em) (Ep * Ap) Ep]
    _ = ((Em * Am) * (Em * (Ep * Ap))) * Ep := by
        -- `mat_mult_associative`
        rw [Matrix.mul_assoc (Em * Am) Em (Ep * Ap)]
    _ = ((Em * Am) * ((Em * Ep) * Ap)) * Ep := by
        -- `mat_mult_associative`
        rw [Matrix.mul_assoc Em Ep Ap]
    _ = ((Em * Am) * (1 * Ap)) * Ep := by rw [hEmEp]
    _ = ((Em * Am) * Ap) * Ep := by
        -- `identity_matrix_is_left_unit_of_mat_mult` を `A_+` へ適用
        rw [identity_matrix_mul_tensorPow]
    _ = (Em * (Am * Ap)) * Ep := by
        -- `mat_mult_associative`
        rw [Matrix.mul_assoc Em Am Ap]
    _ = (Em * 1) * Ep := by rw [hAmAp]
    _ = Em * Ep := by
        -- `identity_matrix_is_right_unit_of_mat_mult` を `E_-` へ適用
        rw [mul_identity_matrix_tensorPow]
    _ = 1 := hEmEp


/-- **原文 `V_plus_is_invertible` の最後の行**: Step 2・Step 3 の二つの積と `def_invertible_elements_of_R`
（`g → V^{(+)}`、`h → R^{(+)}`）から、`V^{(+)} ∈ R^×` かつ `(V^{(+)})^{-1} = R^{(+)}`。 -/
theorem VPlus_isUnit_and_inv_eq {K1 K2star : ℂ} {s2 : ℝ} (hs2 : 0 < s2) :
    ∃ u : (TensorPow M)ˣ, (u : TensorPow M) = VPlus M s2 K1 K2star
      ∧ ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M) = VPlusInv M K1 s2 K2star :=
  ⟨⟨VPlus M s2 K1 K2star, VPlusInv M K1 s2 K2star, VPlus_mul_VPlusInv hs2, VPlusInv_mul_VPlus hs2⟩,
    rfl, rfl⟩

/-- **原文 `V_plus_inverse_is_positive_definite`**:
`(V^{(+)})^{-1}` も正定値。

証明は Step 2〜3 をそのまま `-\tfrac12 S_1^{(+)}`, `-S_2` に適用するだけである。 -/
theorem VPlusInv_posDef {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (VPlusInv M K1 s2 K2star).PosDef := by
  set E := matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) with hE
  set B := matExp (-((Complex.I * K2star) • H2 M)) with hB
  -- `-\tfrac12 S_1^{(+)}` はエルミート
  have hS1 : (-(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1plus M))).IsHermitian := by
    have h : (-(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1plus M)))ᴴ
        = -(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1plus M)) := by
      rw [Matrix.conjTranspose_neg, Matrix.conjTranspose_smul,
        (S1plus_isHermitian hK1).eq]
      norm_num
    exact h
  have hEeq : E = NormedSpace.exp (-(((1 / 2 : ℂ)) • ((Complex.I * K1) • H1plus M))) := by
    rw [hE, matExp]
  have hEherm : E.IsHermitian := by rw [hEeq]; exact hS1.exp
  have hEinj : Function.Injective E.mulVec := by
    rw [hEeq]
    exact Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  -- `-S_2` はエルミートなので `exp(-S_2)` は正定値
  have hS2 : (-((Complex.I * K2star) • H2 M)).IsHermitian := by
    have h : (-((Complex.I * K2star) • H2 M))ᴴ = -((Complex.I * K2star) • H2 M) := by
      rw [Matrix.conjTranspose_neg, (S2_isHermitian hK2).eq]
    exact h
  have hBpos : B.PosDef := by
    rw [hB, matExp]
    exact posDef_exp_of_isHermitian hS2
  have hEBE : (Eᴴ * B * E).PosDef := hBpos.conjTranspose_mul_mul_same hEinj
  rw [hEherm.eq] at hEBE
  rw [VPlusInv]
  refine posDef_smul_of_pos hEBE ?_
  have : (0 : ℝ) < 2 * s2 := by linarith
  exact inv_pos.mpr (Real.rpow_pos_of_pos this _)

/-- **原文 `trace_V_plus_is_positive`**: `tr(V^{(+)}) > 0`。 -/
theorem trace_VPlus_pos {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (VPlus M s2 K1 K2star).trace :=
  (VPlus_posDef hK1 hK2 hs2).trace_pos

/-- **原文 `V_plus_inverse_positive_and_trace_positivity`**:
`tr((V^{(+)})^{-1}) > 0`。 -/
theorem trace_VPlusInv_pos {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (VPlusInv M K1 s2 K2star).trace :=
  (VPlusInv_posDef hK1 hK2 hs2).trace_pos

end VPlus

end Ising2D
