/-
# 定数 `c` の決定（偶セクター）（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`constant_c_value_even_sector`（`evenEigen_009_claim_constant_c_value_even_sector`）。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備の `H := (1/2)_ℂ S_1` の成分の鎖 8 行（`H + H = S_1`） | `half_smul_add_half_smul` の `calc` の 8 段 |
| 準備の `exp(H)exp(H) = exp(S_1)` の 2 行、`exp(-H)exp(-H) = exp(-S_1)` の 3 行 | `matExp_half_mul_matExp_half`・`matExp_neg_half_mul_matExp_neg_half` |
| 準備の `τ`・`τ'` | `tauPlus`・`tauPlusPrime` |
| Step 1 の第一の鎖 6 行・第二の鎖 6 行 | `trace_VPlus_eq_tauPlus`・`trace_VPlusInv_eq_tauPlusPrime` |
| Step 2 の鎖 8 行（`τ' = τ`） | `tauPlusPrime_eq_tauPlus` |
| Step 3 の `V^{(+)}W = I`・`WV^{(+)} = I` の鎖 7 行ずつ、逆元の一意性、二つのトレースの鎖 3 行ずつ | `VPlus_mul_W`・`W_mul_VPlus`・`VPlusInv_eq_W`・`trace_VPlus_eq_c_mul`・`trace_VPlusInv_eq_cinv_mul` |
| Step 4・Step 5 の ℂ の鎖（`w`・`c^2w`・`c^2`・`c = ρ_ℂ`・`(ρρ, 0)`）と `ρ = a`、最後の第一の鎖の 2 行（`c = ρ_ℂ = a_ℂ`） | `constant_c_steps_four_five` |
| 最後の第一の鎖の 3・4 行（`a` の定義、`s_2 = sinh 2K_2`）と第二の鎖（`V^{(+)} = cV̌'` への代入） | 主張の型の `s2`（`constant_c_value_even_sector`）と `VPlus_eq_smul_checkVprime_const`（`ClaimVPlusDataFromEigenvaluesOfVPlus.lean`。`s2 → sinh 2K_2` と `V^{(+)} = cV̌'` の書き換え） |
| 主張 | `constant_c_value_even_sector` |

必要十分版は `Ising2D/NecSuf/ConstantC.lean` の `NecSuf.const_eq_of_trace_chains`（Step 4・Step 5 の手順のまま、`ℂ` を零を持つ群、
`ℝ` を順序体、包含を積と `0`・`1` を保つ単射に上げたもの）。`constant_c_steps_four_five` をその特殊化として得る導出は
`ClaimConstantCEvenSectorFromNecSuf.lean`。Step 1〜3 は `S_1^{(+)}, S_2, U, V̌'` というこの模型の具体的な行列の計算で、
使う一般論（トレースの性質、共役、スカラー倍）はそれぞれの具体版・必要十分版が受け持つ。

## 記号

`S_1 := S_1^{(+)} = i(K_1)_ℂH_1^{(+)}` は `(Complex.I * K1) • H1plus M`、`S_2 = i(K_2^*)_ℂH_2` は `(Complex.I * K2star) • H2 M`、
`H := (1/2)_ℂS_1` は `(1 / 2 : ℂ) • S_1` と書く（`ClaimVPlusPositiveDefinite.lean` の `VPlus_eq_smul` と同じ書き方。Lean の `(1 / 2 : ℂ)` は
ℂ の数値リテラルの割り算で、準備の成分の鎖の 4 段目でこれを人手の `(1/2)_ℂ = (1/2, 0)` に読み替える）。
`a := (2s_2)^{M/2}` は `(2 * s2) ^ ((M : ℝ) / 2)`、`(V^{(+)})^{-1}` は `V_plus_is_invertible` の `R^{(+)}` の Lean の `VPlusInv`、
`V̌' ∈ R^×` は `F.VprimeUnits g`（`def_check_Vprime` (2)）である。
人手の `t`（`trace_of_check_Vprime` の右辺の正の実数）と `r`（`trace_V_plus_is_positive` の `tr(V^{(+)}) = r_ℂ`）は、
Lean ではそれぞれ `F.trace_Vprime_pos g`・`trace_VPlus_pos` の存在の主張から取り出す。

## Lean の仮定 `hVeq` について

人手は `V_plus_eq_c_check_Vprime` の `c ∈ ℂ^×` を引いて `c ≠ 0` を得る。Lean の `constant_c_value_even_sector` は
`c ≠ 0` を仮定 `hcne` として受け取る。`c ≠ 0` を持たない `V^{(+)} = cV̌'` だけを持つ使う側（`TheoremEigenvaluesVPlus.lean` ほか）には、
`V^{(+)}` の可逆性から `c ≠ 0` を出す `c_ne_zero_of_VPlus_eq_smul` を置く（人手の行は無い。使う側の仮定が人手の `c ∈ ℂ^×` を
持たないことの橋渡しである）。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusPositiveDefinite
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimSignFlipConjugation
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimPositiveRealSquareInjective
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfSumOverBinaryWords
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationDistributesOverMatrixSumFromNecSuf

namespace Ising2D

open Matrix
open scoped ComplexOrder

section ConstantCEven

variable {M : ℕ}

/-! ### 準備 -/

/-- 人手の準備の成分の鎖: `H + H = S_1`（`H := (1/2)_ℂ S_1`）。`S` は一般の行列で書き、`S = S_1^{(+)}` で使う。 -/
theorem half_smul_add_half_smul (S : TensorPow M) : (1 / 2 : ℂ) • S + (1 / 2 : ℂ) • S = S := by
  ext k l
  calc ((1 / 2 : ℂ) • S + (1 / 2 : ℂ) • S) k l
      = ((1 / 2 : ℂ) • S) k l + ((1 / 2 : ℂ) • S) k l := rfl          -- `def_matrix_sum`
    _ = (1 / 2 : ℂ) * S k l + (1 / 2 : ℂ) * S k l := rfl              -- `def_matrix_scalar_multiple`
    _ = ((1 / 2 : ℂ) + (1 / 2 : ℂ)) * S k l := (add_mul _ _ _).symm   -- 分配律（`complex_numbers_form_a_field`）
    _ = ((⟨1 / 2, 0⟩ : ℂ) + ⟨1 / 2, 0⟩) * S k l := by
        -- `inclusion_rr_to_cc`（Lean の `(1 / 2 : ℂ)` を人手の `(1/2)_ℂ = (1/2, 0)` に読み替える）
        rw [show (1 / 2 : ℂ) = ⟨1 / 2, 0⟩ from Complex.ext (by norm_num) (by norm_num)]
    _ = (⟨1 / 2 + 1 / 2, 0 + 0⟩ : ℂ) * S k l := rfl                   -- `definition_of_cc` の和
    _ = (⟨1, 0⟩ : ℂ) * S k l := by
        -- ℝ の四則
        rw [show (1 / 2 + 1 / 2 : ℝ) = 1 by norm_num, add_zero]
    _ = (1 : ℂ) * S k l := rfl                                        -- `inclusion_rr_to_cc`（`1_ℂ = (1, 0)`）
    _ = S k l := one_mul _                                            -- `1_ℂ` は乗法の単位元

/-- 人手の準備の `exp(H)exp(H) = exp(S_1)`。 -/
theorem matExp_half_mul_matExp_half (S : TensorPow M) :
    matExp ((1 / 2 : ℂ) • S) * matExp ((1 / 2 : ℂ) • S) = matExp S :=
  calc matExp ((1 / 2 : ℂ) • S) * matExp ((1 / 2 : ℂ) • S)
      = matExp ((1 / 2 : ℂ) • S + (1 / 2 : ℂ) • S) :=
        -- `theorem_exp_product`（`K → ℂ`、`A, B → H`）と `HH = HH`。Lean の具体版は無く、mathlib の `Matrix.exp_add_of_commute`
        (Matrix.exp_add_of_commute _ _ (Commute.refl _)).symm
    _ = matExp S := by rw [half_smul_add_half_smul]                   -- `H + H = S_1`

/-- 人手の準備の `exp(-H)exp(-H) = exp(-S_1)`。 -/
theorem matExp_neg_half_mul_matExp_neg_half (S : TensorPow M) :
    matExp (-((1 / 2 : ℂ) • S)) * matExp (-((1 / 2 : ℂ) • S)) = matExp (-S) :=
  calc matExp (-((1 / 2 : ℂ) • S)) * matExp (-((1 / 2 : ℂ) • S))
      = matExp ((-((1 / 2 : ℂ) • S)) + (-((1 / 2 : ℂ) • S))) :=
        -- `theorem_exp_product`（`K → ℂ`、`A, B → -H`）と `(-H)(-H) = (-H)(-H)`。mathlib の `Matrix.exp_add_of_commute`
        (Matrix.exp_add_of_commute _ _ (Commute.refl _)).symm
    _ = matExp (-((1 / 2 : ℂ) • S + (1 / 2 : ℂ) • S)) := by
        -- `negation_distributes_over_matrix_sum`（`A, B → H`）を右辺から左辺へ（`TensorPow M` の系 `neg_add_tensorPow`）
        rw [neg_add_tensorPow]
    _ = matExp (-S) := by rw [half_smul_add_half_smul]                -- `H + H = S_1`

/-- **人手の準備の `τ`**: `τ := tr(exp(S_1) exp(S_2))`。 -/
noncomputable def tauPlus (M : ℕ) (K1 K2star : ℂ) : ℂ :=
  (matExp ((Complex.I * K1) • H1plus M) * matExp ((Complex.I * K2star) • H2 M)).trace

/-- **人手の準備の `τ'`**: `τ' := tr(exp(-S_1) exp(-S_2))`。 -/
noncomputable def tauPlusPrime (M : ℕ) (K1 K2star : ℂ) : ℂ :=
  (matExp (-((Complex.I * K1) • H1plus M)) * matExp (-((Complex.I * K2star) • H2 M))).trace

/-! ### Step 1 -/

/-- **人手 Step 1 の第一の鎖**: `tr(V^{(+)}) = a_ℂ τ`。 -/
theorem trace_VPlus_eq_tauPlus (K1 : ℂ) (s2 : ℝ) (K2star : ℂ) :
    (VPlus M s2 K1 K2star).trace
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) * tauPlus M K1 K2star := by
  set a : ℂ := (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) with ha
  set E := matExp ((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M)) with hE
  set B := matExp ((Complex.I * K2star) • H2 M) with hB
  calc (VPlus M s2 K1 K2star).trace
      = (a • ((E * B) * E)).trace := by rw [VPlus_eq_smul]             -- `V_plus_is_positive_definite` の表示
    _ = a * ((E * B) * E).trace := trace_smul_tensorPow _ _            -- `trace_of_scalar_multiple`（`α → a_ℂ`）
    _ = a * (E * (E * B)).trace := by
        -- `trace_basic_properties` (2)（`A → exp(H)exp(S_2)`、`B → exp(H)`）
        rw [trace_cyclic (E * B) E]
    _ = a * ((E * E) * B).trace := by
        -- `mat_mult_associative`（Lean の具体版は無く、mathlib の `Matrix.mul_assoc`）
        rw [Matrix.mul_assoc E E B]
    _ = a * (matExp ((Complex.I * K1) • H1plus M) * B).trace := by
        -- 準備の `exp(H)exp(H) = exp(S_1)`
        rw [hE, matExp_half_mul_matExp_half]
    _ = a * tauPlus M K1 K2star := rfl                                -- `τ` の定義

/-- **人手 Step 1 の第二の鎖**: `tr((V^{(+)})^{-1}) = (a^{-1})_ℂ τ'`。 -/
theorem trace_VPlusInv_eq_tauPlusPrime (K1 : ℂ) (s2 : ℝ) (K2star : ℂ) :
    (VPlusInv M K1 s2 K2star).trace
      = (((((2 * s2) ^ ((M : ℝ) / 2))⁻¹ : ℝ) : ℂ)) * tauPlusPrime M K1 K2star := by
  set b : ℂ := ((((2 * s2) ^ ((M : ℝ) / 2))⁻¹ : ℝ) : ℂ) with hb
  set E := matExp (-((1 / 2 : ℂ) • ((Complex.I * K1) • H1plus M))) with hE
  set B := matExp (-((Complex.I * K2star) • H2 M)) with hB
  calc (VPlusInv M K1 s2 K2star).trace
      = (b • ((E * B) * E)).trace := by rw [VPlusInv]                  -- `V_plus_is_invertible` の `(V^{(+)})^{-1} = R^{(+)}`
    _ = b * ((E * B) * E).trace := trace_smul_tensorPow _ _            -- `trace_of_scalar_multiple`（`α → (a^{-1})_ℂ`）
    _ = b * (E * (E * B)).trace := by
        -- `trace_basic_properties` (2)（`A → exp(-H)exp(-S_2)`、`B → exp(-H)`）
        rw [trace_cyclic (E * B) E]
    _ = b * ((E * E) * B).trace := by
        -- `mat_mult_associative`（mathlib の `Matrix.mul_assoc`）
        rw [Matrix.mul_assoc E E B]
    _ = b * (matExp (-((Complex.I * K1) • H1plus M)) * B).trace := by
        -- 準備の `exp(-H)exp(-H) = exp(-S_1)`
        rw [hE, matExp_neg_half_mul_matExp_neg_half]
    _ = b * tauPlusPrime M K1 K2star := rfl                           -- `τ'` の定義

/-! ### Step 2 -/

/-- **人手 Step 2**: `τ' = τ`。人手の `T_U(A) := (UA)U^{-1}`（`mat_conj`）は、Lean では `Uflip M * A * UflipInv M`
（左結合の積で `(UA)U^{-1}`）と直接書くので、人手の 5 行目（`T_U` の定義を開く）は Lean では書き換えが要らない。 -/
theorem tauPlusPrime_eq_tauPlus (K1 K2star : ℂ) :
    tauPlusPrime M K1 K2star = tauPlus M K1 K2star := by
  set S1 := (Complex.I * K1) • H1plus M with hS1
  set S2 := (Complex.I * K2star) • H2 M with hS2
  calc tauPlusPrime M K1 K2star
      = (matExp (-S1) * matExp (-S2)).trace := rfl                     -- `τ'` の定義
    _ = (matExp (Uflip M * S1 * UflipInv M) * matExp (Uflip M * S2 * UflipInv M)).trace := by
        -- `sign_flip_conjugation` の `US_1^{(+)}U^{-1} = -S_1^{(+)}`、`US_2U^{-1} = -S_2` を右辺から左辺へ
        rw [Uflip_conj_S1plus, Uflip_conj_S2]
    _ = ((Uflip M * matExp S1 * UflipInv M) * (Uflip M * matExp S2 * UflipInv M)).trace := by
        -- `conjugation_commutes_with_matrix_exp`（`B → U`、`X → S_1, S_2`）を右辺から左辺へ（`Uflip_conj_matExp`）
        rw [Uflip_conj_matExp S1, Uflip_conj_matExp S2]
    _ = (Uflip M * (matExp S1 * matExp S2) * UflipInv M).trace := by
        -- `conjugation_is_ring_homomorphism` の乗法的（`B → U`）を右辺から左辺へ（`Uflip_conj_mul`）
        rw [Uflip_conj_mul]
    _ = (Uflip M * ((matExp S1 * matExp S2) * UflipInv M)).trace := by
        -- `mat_mult_associative`（mathlib の `Matrix.mul_assoc`）
        rw [Matrix.mul_assoc (Uflip M) (matExp S1 * matExp S2) (UflipInv M)]
    _ = (matExp S1 * matExp S2).trace :=
        -- `trace_basic_properties` (4)（`P → U`、`P' → U^{-1}`）と `U^{-1}U = I`
        trace_similarity_invariant _ _ _ UflipInv_mul
    _ = tauPlus M K1 K2star := rfl                                    -- `τ` の定義

/-! ### Step 3 -/

/-- 人手 Step 3 の `W := c^{-1}(V̌')^{-1}`。 -/
noncomputable def constantCW (F : CheckFermiSetup M) (g : CheckIdx M → ℝ) (c : ℂ) : TensorPow M :=
  c⁻¹ • (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)

/-- **人手 Step 3 の第一の鎖**: `V^{(+)}W = I`。 -/
theorem VPlus_mul_W (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ} (hcne : c ≠ 0)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    VPlus M s2 K1 K2star * constantCW F g c = 1 := by
  set u := F.VprimeUnits g with hu
  calc VPlus M s2 K1 K2star * constantCW F g c
      = (c • (u : TensorPow M)) * (c⁻¹ • ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M)) := by
        -- `V_plus_eq_c_check_Vprime` と `W` の定義
        rw [hVeq, constantCW, hu, F.VprimeUnits_val]
    _ = c • ((u : TensorPow M) * (c⁻¹ • ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M))) :=
        smul_mul_matrix_tensorPow _ _ _                               -- `scalar_multiple_factors_out_of_left_factor`
    _ = c • (c⁻¹ • ((u : TensorPow M) * ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M))) := by
        rw [mul_smul_matrix_tensorPow]                                -- `scalar_multiple_factors_out_of_right_factor`
    _ = (c * c⁻¹) • ((u : TensorPow M) * ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M)) := by
        -- `scalar_multiple_is_associative`（Lean の具体版は無く、mathlib の `smul_smul`）
        rw [smul_smul]
    _ = (1 : ℂ) • ((u : TensorPow M) * ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M)) := by
        rw [mul_inv_cancel₀ hcne]                                     -- `c^{-1}` は `c` の逆元
    _ = (1 : ℂ) • (1 : TensorPow M) := by rw [Units.mul_inv]          -- `def_invertible_elements_of_R` の `(V̌')^{-1}`
    _ = 1 := one_smul_tensorPow _                                     -- `scalar_multiple_by_one`

/-- **人手 Step 3 の第二の鎖**: `WV^{(+)} = I`。 -/
theorem W_mul_VPlus (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ} (hcne : c ≠ 0)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    constantCW F g c * VPlus M s2 K1 K2star = 1 := by
  set u := F.VprimeUnits g with hu
  calc constantCW F g c * VPlus M s2 K1 K2star
      = (c⁻¹ • ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M)) * (c • (u : TensorPow M)) := by
        -- `W` の定義と `V_plus_eq_c_check_Vprime`
        rw [hVeq, constantCW, hu, F.VprimeUnits_val]
    _ = c⁻¹ • (((u⁻¹ : (TensorPow M)ˣ) : TensorPow M) * (c • (u : TensorPow M))) :=
        smul_mul_matrix_tensorPow _ _ _                               -- `scalar_multiple_factors_out_of_left_factor`
    _ = c⁻¹ • (c • (((u⁻¹ : (TensorPow M)ˣ) : TensorPow M) * (u : TensorPow M))) := by
        rw [mul_smul_matrix_tensorPow]                                -- `scalar_multiple_factors_out_of_right_factor`
    _ = (c⁻¹ * c) • (((u⁻¹ : (TensorPow M)ˣ) : TensorPow M) * (u : TensorPow M)) := by
        -- `scalar_multiple_is_associative`（mathlib の `smul_smul`）
        rw [smul_smul]
    _ = (1 : ℂ) • (((u⁻¹ : (TensorPow M)ˣ) : TensorPow M) * (u : TensorPow M)) := by
        rw [inv_mul_cancel₀ hcne]                                     -- `c^{-1}` は `c` の逆元
    _ = (1 : ℂ) • (1 : TensorPow M) := by rw [Units.inv_mul]          -- `def_invertible_elements_of_R` の `(V̌')^{-1}`
    _ = 1 := one_smul_tensorPow _                                     -- `scalar_multiple_by_one`

/-- 人手 Step 3 の「`def_invertible_elements_of_R` の逆元の一意性より `(V^{(+)})^{-1} = W`」。
`V_plus_is_invertible` の単元 `u`（`↑u = V^{(+)}`、`↑u⁻¹ = R^{(+)}`）と、上の 2 本の鎖で作る単元（`↑· = V^{(+)}`、`↑·⁻¹ = W`）は
値が同じなので一致し（単元は値で決まる。Lean の具体版は無く、mathlib の `Units.ext`）、逆元も一致する。 -/
theorem VPlusInv_eq_W (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ} (hs2 : 0 < s2) (hcne : c ≠ 0)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    VPlusInv M K1 s2 K2star = constantCW F g c := by
  obtain ⟨u, hu, huinv⟩ := VPlus_isUnit_and_inv_eq (M := M) (K1 := K1) (K2star := K2star) hs2
  let w : (TensorPow M)ˣ :=
    ⟨VPlus M s2 K1 K2star, constantCW F g c, VPlus_mul_W F g hcne hVeq, W_mul_VPlus F g hcne hVeq⟩
  have huw : u = w := Units.ext hu
  calc VPlusInv M K1 s2 K2star
      = ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M) := huinv.symm          -- `V_plus_is_invertible` の `(V^{(+)})^{-1} = R^{(+)}`
    _ = ((w⁻¹ : (TensorPow M)ˣ) : TensorPow M) := by rw [huw]          -- 逆元の一意性（`u = w`）
    _ = constantCW F g c := rfl                                       -- `w` の逆元は `W`

/-- **人手 Step 3 の第一のトレースの鎖**: `tr(V^{(+)}) = c t_ℂ`。 -/
theorem trace_VPlus_eq_c_mul (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ} {t : ℝ}
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) (ht : (F.Vprime g).trace = (t : ℂ)) :
    (VPlus M s2 K1 K2star).trace = c * (t : ℂ) :=
  calc (VPlus M s2 K1 K2star).trace
      = (c • F.Vprime g).trace := by rw [hVeq]                         -- `V_plus_eq_c_check_Vprime`
    _ = c * (F.Vprime g).trace := trace_smul_tensorPow _ _             -- `trace_of_scalar_multiple`（`α → c`）
    _ = c * (t : ℂ) := by rw [ht]                                     -- `trace_of_check_Vprime` と `t` の置き方

/-- **人手 Step 3 の第二のトレースの鎖**: `tr((V^{(+)})^{-1}) = c^{-1} t_ℂ`。 -/
theorem trace_VPlusInv_eq_cinv_mul (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ} {t : ℝ} (hs2 : 0 < s2) (hcne : c ≠ 0)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) (ht : (F.Vprime g).trace = (t : ℂ)) :
    (VPlusInv M K1 s2 K2star).trace = c⁻¹ * (t : ℂ) :=
  calc (VPlusInv M K1 s2 K2star).trace
      = (constantCW F g c).trace := by rw [VPlusInv_eq_W F g hs2 hcne hVeq]  -- `(V^{(+)})^{-1} = W`
    _ = c⁻¹ * (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M).trace :=
        trace_smul_tensorPow _ _                                      -- `trace_of_scalar_multiple`（`α → c^{-1}`）
    _ = c⁻¹ * (t : ℂ) := by
        -- `trace_of_check_Vprime`（`tr((V̌')^{-1}) = tr(V̌')`）と `t` の置き方
        rw [F.VprimeUnits_inv g, F.trace_Vprime_inv g, ht]

/-! ### Step 4・Step 5 -/

/-- **人手 Step 4・Step 5 の ℂ の鎖**。Step 1〜3 の 5 つの等式と準備の `tr(V^{(+)}) = r_ℂ` から `c = a_ℂ`。
`T`・`T'` は人手の `tr(V^{(+)})`・`w := tr((V^{(+)})^{-1})`、`τ`・`τ'` は準備の `τ`・`τ'` である。 -/
theorem constant_c_steps_four_five {c τ τ' T T' : ℂ} {a r t : ℝ} (hcne : c ≠ 0)
    (hT : T = (a : ℂ) * τ) (hT' : T' = ((a⁻¹ : ℝ) : ℂ) * τ') (hτ : τ' = τ)
    (hTc : T = c * (t : ℂ)) (hT'c : T' = c⁻¹ * (t : ℂ)) (hTr : T = (r : ℂ))
    (ha : 0 < a) (hr : 0 < r) (ht : 0 < t) : c = (a : ℂ) := by
  have hane : a ≠ 0 := ne_of_gt ha
  have htne : t ≠ 0 := ne_of_gt ht
  -- Step 4: `w` を実数の像で表す
  have hw : T' = ((a⁻¹ * (a⁻¹ * r) : ℝ) : ℂ) :=
    calc T' = ((a⁻¹ : ℝ) : ℂ) * τ' := hT'                              -- Step 1 の第二の鎖
      _ = ((a⁻¹ : ℝ) : ℂ) * τ := by rw [hτ]                            -- Step 2
      _ = ((a⁻¹ : ℝ) : ℂ) * (1 * τ) := by rw [one_mul]                 -- `1_ℂ` は乗法の単位元
      _ = ((a⁻¹ : ℝ) : ℂ) * (((a⁻¹ * a : ℝ) : ℂ) * τ) := by
          rw [inv_mul_cancel₀ hane, Complex.ofReal_one]               -- ℝ で `a^{-1}a = 1`
      _ = ((a⁻¹ : ℝ) : ℂ) * ((((a⁻¹ : ℝ) : ℂ) * (a : ℂ)) * τ) := by
          rw [real_inclusion_mul a⁻¹ a]                               -- `real_inclusion_preserves_product` を右辺から左辺へ
      _ = ((a⁻¹ : ℝ) : ℂ) * (((a⁻¹ : ℝ) : ℂ) * ((a : ℂ) * τ)) := by
          rw [mul_assoc ((a⁻¹ : ℝ) : ℂ) (a : ℂ) τ]                    -- 乗法の結合律
      _ = ((a⁻¹ : ℝ) : ℂ) * (((a⁻¹ : ℝ) : ℂ) * T) := by rw [hT]        -- Step 1 の第一の鎖を右辺から左辺へ
      _ = ((a⁻¹ : ℝ) : ℂ) * (((a⁻¹ : ℝ) : ℂ) * (r : ℂ)) := by rw [hTr] -- 準備の `tr(V^{(+)}) = r_ℂ`
      _ = ((a⁻¹ : ℝ) : ℂ) * ((a⁻¹ * r : ℝ) : ℂ) := by
          rw [real_inclusion_mul a⁻¹ r]                               -- `real_inclusion_preserves_product`
      _ = ((a⁻¹ * (a⁻¹ * r) : ℝ) : ℂ) := real_inclusion_mul _ _        -- `real_inclusion_preserves_product`
  -- `q > 0`（ℝ の順序）と `w = (q, 0) ≠ (0, 0)`（成分ごとの等号）
  have hq : 0 < a⁻¹ * (a⁻¹ * r) := mul_pos (inv_pos.2 ha) (mul_pos (inv_pos.2 ha) hr)
  have hwne : T' ≠ 0 := by
    rw [hw]
    intro h0
    have hre := congrArg Complex.re h0                                -- `definition_of_cc` の元の等号は成分ごと
    rw [Complex.ofReal_re, Complex.zero_re] at hre
    exact (ne_of_gt hq) hre
  -- Step 4: `c^2 w = (a^2)_ℂ w`
  have hcw : (c * c) * T' = ((a * a : ℝ) : ℂ) * T' :=
    calc (c * c) * T' = (c * c) * (c⁻¹ * (t : ℂ)) := by rw [hT'c]       -- `c^2` の定義と Step 3 の第二の鎖
      _ = c * (c * (c⁻¹ * (t : ℂ))) := mul_assoc _ _ _                 -- 乗法の結合律
      _ = c * ((c * c⁻¹) * (t : ℂ)) := by rw [mul_assoc c c⁻¹]         -- 乗法の結合律
      _ = c * (1 * (t : ℂ)) := by rw [mul_inv_cancel₀ hcne]            -- `c^{-1}` は `c` の逆元
      _ = c * (t : ℂ) := by rw [one_mul]                               -- `1_ℂ` は乗法の単位元
      _ = T := hTc.symm                                                -- Step 3 の第一の鎖を右辺から左辺へ
      _ = (a : ℂ) * τ := hT                                            -- Step 1 の第一の鎖
      _ = (a : ℂ) * (1 * τ) := by rw [one_mul]                         -- `1_ℂ` は乗法の単位元
      _ = (a : ℂ) * (((a * a⁻¹ : ℝ) : ℂ) * τ) := by
          rw [mul_inv_cancel₀ hane, Complex.ofReal_one]               -- ℝ で `aa^{-1} = 1`
      _ = (a : ℂ) * (((a : ℂ) * ((a⁻¹ : ℝ) : ℂ)) * τ) := by
          rw [real_inclusion_mul a a⁻¹]                               -- `real_inclusion_preserves_product` を右辺から左辺へ
      _ = (a : ℂ) * ((a : ℂ) * (((a⁻¹ : ℝ) : ℂ) * τ)) := by
          rw [mul_assoc (a : ℂ) ((a⁻¹ : ℝ) : ℂ) τ]                    -- 乗法の結合律
      _ = (a : ℂ) * ((a : ℂ) * (((a⁻¹ : ℝ) : ℂ) * τ')) := by rw [hτ]   -- Step 2 を右辺から左辺へ
      _ = (a : ℂ) * ((a : ℂ) * T') := by rw [hT']                      -- Step 1 の第二の鎖を右辺から左辺へ
      _ = ((a : ℂ) * (a : ℂ)) * T' := (mul_assoc _ _ _).symm           -- 乗法の結合律
      _ = ((a * a : ℝ) : ℂ) * T' := by
          rw [real_inclusion_mul a a]                                 -- `real_inclusion_preserves_product` と `a^2` の定義
  -- Step 4: `c^2 = (a^2)_ℂ`
  have hc2 : c * c = ((a * a : ℝ) : ℂ) :=
    calc c * c = (c * c) * 1 := (mul_one _).symm                       -- `1_ℂ` は乗法の単位元
      _ = (c * c) * (T' * T'⁻¹) := by rw [mul_inv_cancel₀ hwne]        -- `w^{-1}` は `w` の逆元
      _ = ((c * c) * T') * T'⁻¹ := (mul_assoc _ _ _).symm              -- 乗法の結合律
      _ = (((a * a : ℝ) : ℂ) * T') * T'⁻¹ := by rw [hcw]               -- 上の鎖
      _ = ((a * a : ℝ) : ℂ) * (T' * T'⁻¹) := mul_assoc _ _ _           -- 乗法の結合律
      _ = ((a * a : ℝ) : ℂ) * 1 := by rw [mul_inv_cancel₀ hwne]        -- `w^{-1}` は `w` の逆元
      _ = ((a * a : ℝ) : ℂ) := mul_one _                               -- `1_ℂ` は乗法の単位元
  -- Step 5: `ρ := rt^{-1} ∈ ℝ_{>0}`（ℝ の順序）と `c = ρ_ℂ`
  set ρ : ℝ := r * t⁻¹ with hρdef
  have hρpos : 0 < ρ := mul_pos hr (inv_pos.2 ht)
  have hcρ : c = (ρ : ℂ) :=
    calc c = c * 1 := (mul_one _).symm                                 -- `1_ℂ` は乗法の単位元
      _ = c * ((t * t⁻¹ : ℝ) : ℂ) := by
          rw [mul_inv_cancel₀ htne, Complex.ofReal_one]               -- ℝ で `tt^{-1} = 1`
      _ = c * ((t : ℂ) * ((t⁻¹ : ℝ) : ℂ)) := by
          rw [real_inclusion_mul t t⁻¹]                               -- `real_inclusion_preserves_product` を右辺から左辺へ
      _ = (c * (t : ℂ)) * ((t⁻¹ : ℝ) : ℂ) := (mul_assoc _ _ _).symm    -- 乗法の結合律
      _ = T * ((t⁻¹ : ℝ) : ℂ) := by rw [hTc]                           -- Step 3 の第一の鎖を右辺から左辺へ
      _ = (r : ℂ) * ((t⁻¹ : ℝ) : ℂ) := by rw [hTr]                     -- 準備の `tr(V^{(+)}) = r_ℂ`
      _ = ((r * t⁻¹ : ℝ) : ℂ) := real_inclusion_mul _ _                -- `real_inclusion_preserves_product`
      _ = (ρ : ℂ) := rfl                                               -- `ρ` の定義
  -- Step 5: `(ρρ, 0) = (aa, 0)`
  have hρρ : (⟨ρ * ρ, 0⟩ : ℂ) = ⟨a * a, 0⟩ :=
    calc (⟨ρ * ρ, 0⟩ : ℂ)
        = ((ρ * ρ : ℝ) : ℂ) := rfl                                     -- `inclusion_rr_to_cc`
      _ = (ρ : ℂ) * (ρ : ℂ) := (real_inclusion_mul _ _).symm           -- `real_inclusion_preserves_product` を右辺から左辺へ
      _ = c * c := by rw [← hcρ]                                       -- 上の鎖の `c = ρ_ℂ`
      _ = c ^ 2 := (sq c).symm                                         -- `c^2` の定義
      _ = ((a * a : ℝ) : ℂ) := by rw [sq]; exact hc2                   -- Step 4
      _ = ⟨a * a, 0⟩ := rfl                                            -- `inclusion_rr_to_cc` と `a^2` の定義
  -- `definition_of_cc` の元の等号は成分ごとなので `ρρ = aa`、すなわち `ρ^2 = a^2`
  have hsq : ρ ^ 2 = a ^ 2 := by
    rw [sq, sq]
    exact congrArg Complex.re hρρ
  have hρa : ρ = a :=
    (positive_real_square_injective hρpos ha).1 hsq                   -- `positive_real_square_injective`（`a → ρ`、`b → a`）
  calc c = (ρ : ℂ) := hcρ                                              -- 上の鎖
    _ = (a : ℂ) := by rw [hρa]                                         -- `ρ = a`

/-! ### 主張 -/

/-- 使う側の仮定 `V^{(+)} = cV̌'` が人手の `c ∈ ℂ^×` を持たないときの橋渡し: `V^{(+)}` は可逆（`V_plus_is_invertible`）なので
`c ≠ 0`（`c = 0` なら `V^{(+)} = 0` で、`V^{(+)}R^{(+)} = I` に反する）。人手の行は無い。 -/
theorem c_ne_zero_of_VPlus_eq_smul (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ} (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) : c ≠ 0 := by
  intro h0
  have h1 := VPlus_mul_VPlusInv (M := M) (K1 := K1) (K2star := K2star) hs2
  rw [hVeq, h0, zero_smul, zero_mul] at h1
  exact zero_ne_one h1

/-- **人手 `constant_c_value_even_sector`**: `V^{(+)} = cV̌'`（`c ∈ ℂ^×`）の `c` は `((2s_2)^{M/2})_ℂ`。

人手の準備の `t`・`r` を取り出し、Step 1〜3 の 5 つの等式を作って Step 4・Step 5 の `constant_c_steps_four_five` に渡す。
人手の最後の第一の鎖の 3・4 行（`a` の定義、`s_2 = sinh 2K_2`）と第二の鎖（`V^{(+)} = cV̌'` への代入）は、Lean では主張の型の `s2` と、
使う側の `VPlus_eq_smul_checkVprime_const`（`ClaimVPlusDataFromEigenvaluesOfVPlus.lean`）の書き換えが受け持つ。 -/
theorem constant_c_value_even_sector (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) (hcne : c ≠ 0)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    c = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) := by
  -- 準備: `a ∈ ℝ_{>0}`（`def_second_transfer_matrix_prefactor`）、`t`（`trace_of_check_Vprime`）、`r`（`trace_V_plus_is_positive`）
  have hapos : 0 < (2 * s2) ^ ((M : ℝ) / 2) := Real.rpow_pos_of_pos (by linarith) _
  obtain ⟨t, htpos, ht⟩ := F.trace_Vprime_pos g
  obtain ⟨r, hrpos, hr⟩ := trace_VPlus_pos hK1 hK2 hs2
  exact constant_c_steps_four_five hcne
    (trace_VPlus_eq_tauPlus K1 s2 K2star)                             -- Step 1 の第一の鎖
    (trace_VPlusInv_eq_tauPlusPrime K1 s2 K2star)                     -- Step 1 の第二の鎖
    (tauPlusPrime_eq_tauPlus K1 K2star)                               -- Step 2
    (trace_VPlus_eq_c_mul F g hVeq ht)                                -- Step 3 の第一のトレースの鎖
    (trace_VPlusInv_eq_cinv_mul F g hs2 hcne hVeq ht)                 -- Step 3 の第二のトレースの鎖
    hr hapos hrpos htpos

end ConstantCEven

end Ising2D
