/-
# 具体版 `calc_of_TxT_check_Z_Y` を必要十分版 `NecSuf.exp_conj_two_dim_actsBy` の特殊化として得る

対応する人手証明のラベル: **`calc_of_TxT_check_Z_Y`**・**`T_actions_on_check_Z_Y`**
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`）。

人手証明と 1 対 1 に対応する具体版は `EigenvalueProblem/ReductionToATheta/ClaimTActionsOnCheck.lean` の
`actsBy_TConj_V1plusHalf`・`actsBy_TConj_V2H2Form_check`・`actsBy_TConj_V2_check`（人手の `V_2`）である（4 式を `def_T_g` → `exp_X_Y_exp_-X` →
`extract_taylor_coefficient_of_check_Z_Y` で示し、2 列に並べる）。本ファイルは同じ主張を
必要十分版 `Ising2D/NecSuf/TVAction.lean` の特殊化として導出し、README 4 節の要件 4 を満たす。

渡す `(α, β, s)` は次のとおりで、作用行列 `twoDimConjMat α β s` が `B_1(θ~_μ)`, `B_2` に一致すること
（`B1mat_eq_twoDimConjMat`, `B2mat_eq_twoDimConjMat`）が係数の突き合わせそのものである。

| | `α` | `β` | `s` | 作用行列 |
| --- | --- | --- | --- | --- |
| `T_{(V_1^{(+)})^{1/2}}` | `i K_1 e^{-iθ~_μ}` | `-i K_1 e^{iθ~_μ}` | `K_1` | `B_1(θ~_μ)` |
| `T_{V_2}` | `-2i K_2^*` | `2i K_2^*` | `2K_2^*` | `B_2` |

`V_2` の前因子 `(2s_2)^{M/2}` が共役で打ち消えることは `NecSuf.conj_smul_eq`（任意の ℂ-代数）による。

`B1mat_eq_twoDimConjMat`・`B2mat_eq_twoDimConjMat`・`actsBy_TConj_matExpUnits`・`actsBy_TConj_smulUnits` は
運動量の取り方に依らない補題なので、本文から退避した整数運動量の経路の記録
（`RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean`）もここから使う。
-/
import Ising2D.NecSuf.TVAction
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimTActionsOnCheck
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimCoefficientConversionFromNecSuf

namespace Ising2D

open Ising2D.NecSuf (sinhc twoDimConjMat)

variable {M : ℕ}

/-! ## `B_1(θ)`, `B_2` が必要十分版の作用行列であること -/

/-- **`extract_taylor_coefficient_of_check_Z_Y` (h1.z)(h1.y) の係数と `def_B1_theta_B2` の `B_1(θ)` の突き合わせ**:
`α = i K_1 e^{-iθ}`, `β = -i K_1 e^{iθ}`, `s = K_1` のとき、必要十分版の作用行列
`twoDimConjMat α β s` は `B_1(θ)` に一致する。

要点は `K_1 · sinhc(K_1) = sinh(K_1)`（`NecSuf.mul_sinhc`）だけである。 -/
theorem B1mat_eq_twoDimConjMat (K1 θ : ℂ) :
    B1mat K1 θ = twoDimConjMat
      (Complex.I * K1 * Complex.exp (-θ * Complex.I))
      (-Complex.I * K1 * Complex.exp (θ * Complex.I)) K1 := by
  have h := NecSuf.mul_sinhc K1
  -- 非対角成分だけが `sinhc` を含む。`K_1 sinhc(K_1) = sinh(K_1)` で `sinh` へ直す。
  have e01 : -Complex.I * K1 * Complex.exp (θ * Complex.I) * sinhc K1
      = -Complex.I * Complex.exp (θ * Complex.I) * Complex.sinh K1 := by
    linear_combination (-Complex.I * Complex.exp (θ * Complex.I)) * h
  have e10 : Complex.I * K1 * Complex.exp (-θ * Complex.I) * sinhc K1
      = Complex.I * Complex.exp (-θ * Complex.I) * Complex.sinh K1 := by
    linear_combination (Complex.I * Complex.exp (-θ * Complex.I)) * h
  simp only [B1mat, twoDimConjMat, e01, e10]

/-- **`extract_taylor_coefficient_of_check_Z_Y` (h2.z)(h2.y) の係数と `def_B1_theta_B2` の `B_2` の突き合わせ**:
`α = -2i K_2^*`, `β = 2i K_2^*`, `s = 2K_2^*` のとき、必要十分版の作用行列は `B_2` に一致する。 -/
theorem B2mat_eq_twoDimConjMat (K2star : ℂ) :
    B2mat K2star = twoDimConjMat
      (-(2 * Complex.I * K2star)) (2 * Complex.I * K2star) (2 * K2star) := by
  have h := NecSuf.mul_sinhc (2 * K2star)
  have e01 : 2 * Complex.I * K2star * sinhc (2 * K2star)
      = Complex.I * Complex.sinh (2 * K2star) := by
    linear_combination Complex.I * h
  have e10 : -(2 * Complex.I * K2star) * sinhc (2 * K2star)
      = -Complex.I * Complex.sinh (2 * K2star) := by
    linear_combination (-Complex.I) * h
  simp only [B2mat, twoDimConjMat, e01, e10]

/-! ## exp 共役が `ActsBy` で作用すること（必要十分版の特殊化） -/

open scoped Matrix.Norms.Operator in
set_option backward.isDefEq.respectTransparency false in
/-- 必要十分版 `NecSuf.exp_conj_two_dim_actsBy` を `Mat(2,ℂ)^{⊗M}`（`l^∞` 作用素ノルム）へ特殊化したもの。 -/
private theorem exp_conj_two_dim_actsBy_tensorPow {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) :
    NormedSpace.exp X * z * NormedSpace.exp (-X)
        = twoDimConjMat α β s 0 0 • z + twoDimConjMat α β s 1 0 • y ∧
      NormedSpace.exp X * y * NormedSpace.exp (-X)
        = twoDimConjMat α β s 0 1 • z + twoDimConjMat α β s 1 1 • y :=
  NecSuf.exp_conj_two_dim_actsBy hz hy hs

set_option backward.isDefEq.respectTransparency false in
/-- **必要十分版 `NecSuf.exp_conj_two_dim_actsBy` の具体版**: `ad X` が `span{z, y}` を保つとき、
共役 `T_{exp X}` は `(z, y)` に `twoDimConjMat α β s` で作用する。 -/
theorem actsBy_TConj_matExpUnits {X z y : TensorPow M} {α β s : ℂ}
    (hz : X * z - z * X = α • y) (hy : X * y - y * X = β • z) (hs : s ^ 2 = α * β) :
    ActsBy (TConj (matExpUnits X)).toLinearMap z y (twoDimConjMat α β s) :=
  exp_conj_two_dim_actsBy_tensorPow hz hy hs

/-- **原文「`(2s_2)^{M/2}` のスカラーは共役で打ち消し合う」の具体版**
（必要十分版は `NecSuf.conj_smul_eq`）。 -/
theorem actsBy_TConj_smulUnits {c : ℂ} (hc : c ≠ 0) {u : (TensorPow M)ˣ}
    {z y : TensorPow M} {B : Matrix (Fin 2) (Fin 2) ℂ}
    (h : ActsBy (TConj u).toLinearMap z y B) :
    ActsBy (TConj (smulUnits c hc u)).toLinearMap z y B := by
  obtain ⟨h1, h2⟩ := h
  constructor
  · show (c • (u : TensorPow M)) * z * (c⁻¹ • ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M)) = _
    rw [NecSuf.conj_smul_eq hc]
    exact h1
  · show (c • (u : TensorPow M)) * y * (c⁻¹ • ((u⁻¹ : (TensorPow M)ˣ) : TensorPow M)) = _
    rw [NecSuf.conj_smul_eq hc]
    exact h2

/-! ## 具体版の特殊化としての導出 -/

/-- `ad((i/2)K_1H_1^{(+)})` が `span{check(Z)_μ, check(Y)_μ}` を保つこと（係数を `e^{-iθ~_μ}` の指数表示で）。 -/
theorem ad_V1plusHalf_checkZ_exp (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) * checkZ M μ -
        checkZ M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)
      = (Complex.I * K1 * Complex.exp (-((thetaTilde M μ : ℝ) : ℂ) * Complex.I)) •
          checkY M μ := by
  rw [ad_V1plusHalf_checkZ hM K1 μ, checkPhase_one_eq_exp hM μ]

/-- 同上（`y` 側）。 -/
theorem ad_V1plusHalf_checkY_exp (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) * checkY M μ -
        checkY M μ * (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M)
      = (-Complex.I * K1 * Complex.exp (((thetaTilde M μ : ℝ) : ℂ) * Complex.I)) •
          checkZ M μ := by
  rw [ad_V1plusHalf_checkY hM K1 μ, checkPhase_neg_one_eq_exp hM μ]

/-- `e^{-iθ} e^{iθ} = 1`。 -/
private theorem exp_neg_mul_exp_check (θ : ℂ) :
    Complex.exp (-θ * Complex.I) * Complex.exp (θ * Complex.I) = 1 := by
  rw [← Complex.exp_add]
  simp

/-- **`calc_of_TxT_check_Z_Y` の第 1 式を必要十分版の特殊化として得たもの**
（主張は `actsBy_TConj_V1plusHalf` と同じ）。 -/
theorem actsBy_TConj_V1plusHalf_fromNecSuf (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) :
    ActsBy (TConj (V1plusHalfUnits M K1)).toLinearMap (checkZ M μ) (checkY M μ)
      (B1mat K1 ((thetaTilde M μ : ℝ) : ℂ)) := by
  rw [B1mat_eq_twoDimConjMat]
  refine actsBy_TConj_matExpUnits (ad_V1plusHalf_checkZ_exp hM K1 μ)
    (ad_V1plusHalf_checkY_exp hM K1 μ) ?_
  have h := exp_neg_mul_exp_check ((thetaTilde M μ : ℝ) : ℂ)
  have hI : Complex.I * Complex.I = -1 := Complex.I_mul_I
  linear_combination (-(K1 ^ 2)) * h +
    (K1 ^ 2 * Complex.exp (-((thetaTilde M μ : ℝ) : ℂ) * Complex.I) *
      Complex.exp (((thetaTilde M μ : ℝ) : ℂ) * Complex.I)) * hI

/-- **`calc_of_TxT_check_Z_Y` の第 2 式を必要十分版の特殊化として得たもの**
（主張は `actsBy_TConj_V2H2Form_check` と同じ）。 -/
theorem actsBy_TConj_V2H2Form_check_fromNecSuf {s2 : ℝ} (hs2 : 0 < s2)
    (K2star : ℂ) (μ : ℤ) :
    ActsBy (TConj (V2H2FormUnits M hs2 K2star)).toLinearMap (checkZ M μ) (checkY M μ)
      (B2mat K2star) := by
  rw [B2mat_eq_twoDimConjMat]
  refine actsBy_TConj_smulUnits _ ?_
  exact actsBy_TConj_matExpUnits (ad_V2H2Form_checkZ K2star μ) (ad_V2H2Form_checkY K2star μ)
    (sK2_sq K2star)

/-- **`calc_of_TxT_check_Z_Y` の第 2 式（人手の `V_2`）を必要十分版の特殊化として得たもの**
（主張は `actsBy_TConj_V2_check` と同じ）。 -/
theorem actsBy_TConj_V2_check_fromNecSuf {K2 : ℝ} (hK2 : 0 < K2) (μ : ℤ) :
    ActsBy (TConj (V2Units M hK2)).toLinearMap (checkZ M μ) (checkY M μ)
      (B2mat ((Kstar K2 : ℝ) : ℂ)) := by
  rw [V2Units_eq_V2H2FormUnits]
  exact actsBy_TConj_V2H2Form_check_fromNecSuf _ _ μ

end Ising2D
