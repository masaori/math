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

`S_1^{(+)} := iK_1H_1^{(+)}` は `(Complex.I * K1) • H1plus M`、`S_2 := iK_2^*H_2` は `(Complex.I * K2star) • H2 M`、
`\tfrac12 S_1^{(+)}` は `(1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)` と書く。
`V^{(+)}` は `V_2` を `V2H2Form` で書いた `Ising2D.VPlus`（`EigenvalueProblem/ReductionToATheta/DefinitionVPlus.lean`。
人手の `V_2` の値では `VPlusOfTransfer_eq_VPlus`）である。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPositiveDefinite
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionVPlus
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimTraceCheckVprime

namespace Ising2D

open Matrix
open scoped ComplexOrder

section VPlus

variable {M : ℕ}

/-- **原文 `V_plus_is_positive_definite` の statement の表示（Step 1）**:
`V^{(+)} = (2s_2)^{M/2} exp(S_1^{(+)}/2) exp(S_2) exp(S_1^{(+)}/2)`。 -/
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
        -- `(V_1^{(+)})^{1/2}` の定義（`def_V1_plus_square_root`）
        rw [V1plusHalf]
    _ = matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) * V2H2Form M s2 K2star
          * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) := by
        -- `S_1^{(+)} = iK_1H_1^{(+)}`
        rw [smul_smul, ← mul_assoc (1 / 2 : ℂ)]
    _ = matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))
          * (((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) • matExp ((Complex.I * K2star) • H2 M))
          * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) := by
        -- `V_2` の表示（`V2_exponential_representation` の右辺）と `S_2 = iK_2^*H_2`
        rw [V2H2Form]
    _ = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
          • (matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))
              * matExp ((Complex.I * K2star) • H2 M)
              * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) := by
        -- `scalar_identity_commutes`（スカラーを前へ出す）
        rw [Matrix.mul_smul, Matrix.smul_mul]

/-- **原文 `V_plus_is_positive_definite` Step 2〜3**: `V^{(+)}` は正定値。 -/
theorem VPlus_posDef {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (VPlus M s2 K1 K2star).PosDef := by
  set B := matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) with hB
  set A := matExp ((Complex.I * K2star) • H2 M) with hA
  -- Step 2: `\tfrac12 S_1^{(+)}` はエルミート（`iH_is_real_symmetric` と実係数倍）
  have hS1 : ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)).IsHermitian := by
    have h : ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))ᴴ
        = (1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M) := by
      rw [Matrix.conjTranspose_smul, (S1plus_isHermitian hK1).eq]
      norm_num
    exact h
  -- Step 2: `B` はエルミート（`exp_hermitian_is_positive_definite` (1)）
  have hBherm : B.IsHermitian := by rw [hB, matExp]; exact hS1.exp
  -- Step 2: `B` は可逆
  have hBinj : Function.Injective B.mulVec := by
    rw [hB, matExp]
    exact Matrix.mulVec_injective_of_isUnit (Matrix.isUnit_exp _)
  -- Step 2: `A` は正定値（`exp_hermitian_is_positive_definite` (1)）
  have hApos : A.PosDef := by
    rw [hA, matExp]
    exact posDef_exp_of_isHermitian (S2_isHermitian hK2)
  -- Step 3: `B^* A B` は正定値（`exp_hermitian_is_positive_definite` (2)）、`B^* = B`
  have hBAB : (Bᴴ * A * B).PosDef := hApos.conjTranspose_mul_mul_same hBinj
  rw [hBherm.eq] at hBAB
  -- Step 3: `(2s_2)^{M/2} > 0` 倍も正定値（`exp_hermitian_is_positive_definite` (3)）
  rw [VPlus_eq_smul]
  refine posDef_smul_of_pos hBAB ?_
  have : (0 : ℝ) < 2 * s2 := by linarith
  exact Real.rpow_pos_of_pos this _

/-- **原文 `V_plus_is_invertible` の `R^{(+)}`**:
`R^{(+)} := (2s_2)^{-M/2} exp(-S_1^{(+)}/2) exp(-S_2) exp(-S_1^{(+)}/2)`。 -/
noncomputable def VPlusInv (M : ℕ) (K1 : ℂ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  ((((2 * s2) ^ (-((M : ℝ) / 2)) : ℝ) : ℂ)) •
    (matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)))
      * matExp (-((Complex.I * K2star) • H2 M))
      * matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))))

/-- **原文 `V_plus_is_invertible` Step 2 の `a^{-1} = (2s_2)^{-M/2}`**（`a := (2s_2)^{M/2}`、正の実数の冪の指数法則）。 -/
theorem rpow_neg_half_M_eq_inv {s2 : ℝ} (hs2 : 0 < s2) :
    ((((2 * s2) ^ (-((M : ℝ) / 2)) : ℝ) : ℂ))
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))⁻¹ := by
  rw [Real.rpow_neg (by linarith), Complex.ofReal_inv]

/-! ### 原文 `V_plus_is_invertible` Step 1（指数行列どうしの左右逆）

人手の 4 つの鎖は、どれも `theorem_exp_product`（`X` と `-X` は可換）・`X - X = O`・`theorem_exp_zero` の
3 行である。同じ 3 行を `X` と `-X` の順の 2 通りについて書き、4 つの左右逆はその代入として得る。 -/

/-- `exp(X) exp(-X) = I`（人手 Step 1 の第一・第三の鎖の型）。 -/
theorem matExp_mul_matExp_neg_eq_one (X : TensorPow M) : matExp X * matExp (-X) = 1 := by
  calc matExp X * matExp (-X)
      = matExp (X + -X) := by
        -- `theorem_exp_product`（`X` と `-X` は可換）
        rw [matExp, matExp, matExp, Matrix.exp_add_of_commute X (-X) (Commute.refl X).neg_right]
    _ = matExp 0 := by rw [add_neg_cancel]
    _ = 1 := by
        -- `theorem_exp_zero`
        rw [matExp]; exact NormedSpace.exp_zero

/-- `exp(-X) exp(X) = I`（人手 Step 1 の第二・第四の鎖の型）。 -/
theorem matExp_neg_mul_matExp_eq_one (X : TensorPow M) : matExp (-X) * matExp X = 1 := by
  calc matExp (-X) * matExp X
      = matExp (-X + X) := by
        -- `theorem_exp_product`（`-X` と `X` は可換）
        rw [matExp, matExp, matExp, Matrix.exp_add_of_commute (-X) X (Commute.refl X).neg_left]
    _ = matExp 0 := by rw [neg_add_cancel]
    _ = 1 := by
        -- `theorem_exp_zero`
        rw [matExp]; exact NormedSpace.exp_zero

/-- 人手 Step 1 の第一の左右逆 `E_+E_- = I`。 -/
theorem expHalfS1plus_mul_expNegHalfS1plus (K1 : ℂ) :
    matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))
      * matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) = 1 :=
  matExp_mul_matExp_neg_eq_one _

/-- 人手 Step 1 の第二の左右逆 `E_-E_+ = I`。 -/
theorem expNegHalfS1plus_mul_expHalfS1plus (K1 : ℂ) :
    matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)))
      * matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) = 1 :=
  matExp_neg_mul_matExp_eq_one _

/-- 人手 Step 1 の第三の左右逆 `A_+A_- = I`。 -/
theorem expS2_mul_expNegS2 (K2star : ℂ) :
    matExp ((Complex.I * K2star) • H2 M) * matExp (-((Complex.I * K2star) • H2 M)) = 1 :=
  matExp_mul_matExp_neg_eq_one _

/-- 人手 Step 1 の第四の左右逆 `A_-A_+ = I`。 -/
theorem expNegS2_mul_expS2 (K2star : ℂ) :
    matExp (-((Complex.I * K2star) • H2 M)) * matExp ((Complex.I * K2star) • H2 M) = 1 :=
  matExp_neg_mul_matExp_eq_one _

/-- **原文 `V_plus_is_invertible` Step 2**: `VPlusInv` は `V^{(+)}` の右逆。 -/
theorem VPlus_mul_VPlusInv {K1 K2star : ℂ} {s2 : ℝ} (hs2 : 0 < s2) :
    VPlus M s2 K1 K2star * VPlusInv M K1 s2 K2star = 1 := by
  set a : ℂ := (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) with ha
  have hane : a ≠ 0 := rpow_two_s2_ne_zero hs2 M
  set Ep := matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) with hEp
  set Em := matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) with hEm
  set Ap := matExp ((Complex.I * K2star) • H2 M) with hAp
  set Am := matExp (-((Complex.I * K2star) • H2 M)) with hAm
  have hEpEm : Ep * Em = 1 := expHalfS1plus_mul_expNegHalfS1plus K1
  have hApAm : Ap * Am = 1 := expS2_mul_expNegS2 K2star
  calc VPlus M s2 K1 K2star * VPlusInv M K1 s2 K2star
      = (a • (Ep * Ap * Ep)) * (a⁻¹ • (Em * Am * Em)) := by
        -- `V^{(+)}` と `R^{(+)}` の表示、`(2s_2)^{-M/2} = a^{-1}`
        rw [VPlus_eq_smul, VPlusInv, rpow_neg_half_M_eq_inv hs2]
    _ = (a * a⁻¹) • (Ep * Ap * Ep * (Em * Am * Em)) := by
        -- `scalar_identity_commutes` とスカラー倍の結合法則
        rw [smul_mul_smul_comm]
    _ = Ep * Ap * Ep * (Em * Am * Em) := by rw [mul_inv_cancel₀ hane, one_smul]
    _ = Ep * Ap * (Ep * Em) * Am * Em := by noncomm_ring
    _ = Ep * Ap * 1 * Am * Em := by rw [hEpEm]
    _ = Ep * Ap * Am * Em := by rw [mul_one]
    _ = Ep * (Ap * Am) * Em := by noncomm_ring
    _ = Ep * 1 * Em := by rw [hApAm]
    _ = Ep * Em := by rw [mul_one]
    _ = 1 := hEpEm

/-- **原文 `V_plus_is_invertible` Step 3**: `VPlusInv` は `V^{(+)}` の左逆。 -/
theorem VPlusInv_mul_VPlus {K1 K2star : ℂ} {s2 : ℝ} (hs2 : 0 < s2) :
    VPlusInv M K1 s2 K2star * VPlus M s2 K1 K2star = 1 := by
  set a : ℂ := (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) with ha
  have hane : a ≠ 0 := rpow_two_s2_ne_zero hs2 M
  set Ep := matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) with hEp
  set Em := matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) with hEm
  set Ap := matExp ((Complex.I * K2star) • H2 M) with hAp
  set Am := matExp (-((Complex.I * K2star) • H2 M)) with hAm
  have hEmEp : Em * Ep = 1 := expNegHalfS1plus_mul_expHalfS1plus K1
  have hAmAp : Am * Ap = 1 := expNegS2_mul_expS2 K2star
  calc VPlusInv M K1 s2 K2star * VPlus M s2 K1 K2star
      = (a⁻¹ • (Em * Am * Em)) * (a • (Ep * Ap * Ep)) := by
        -- `R^{(+)}` と `V^{(+)}` の表示、`(2s_2)^{-M/2} = a^{-1}`
        rw [VPlus_eq_smul, VPlusInv, rpow_neg_half_M_eq_inv hs2]
    _ = (a⁻¹ * a) • (Em * Am * Em * (Ep * Ap * Ep)) := by
        -- `scalar_identity_commutes` とスカラー倍の結合法則
        rw [smul_mul_smul_comm]
    _ = Em * Am * Em * (Ep * Ap * Ep) := by rw [inv_mul_cancel₀ hane, one_smul]
    _ = Em * Am * (Em * Ep) * Ap * Ep := by noncomm_ring
    _ = Em * Am * 1 * Ap * Ep := by rw [hEmEp]
    _ = Em * Am * Ap * Ep := by rw [mul_one]
    _ = Em * (Am * Ap) * Ep := by noncomm_ring
    _ = Em * 1 * Ep := by rw [hAmAp]
    _ = Em * Ep := by rw [mul_one]
    _ = 1 := hEmEp

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
  exact Real.rpow_pos_of_pos this _

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
