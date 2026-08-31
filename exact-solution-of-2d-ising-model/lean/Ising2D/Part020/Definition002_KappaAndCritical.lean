/-
# `κ := 2K_1 - 2K_2^*`、`A := sinh 2K_1 sinh 2K_2^*` と臨界条件

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_002_definition_kappa`（ラベル `def_kappa`）
- `critical_002a_definition_critical_sinh_product_A`（ラベル `def_critical_sinh_product_A`）
- `critical_003_claim_gamma_kappa_identity`（ラベル `gamma_kappa_identity`）
- `critical_004_claim_critical_point_iff_kappa_zero`（ラベル `critical_point_iff_kappa_zero`）
- `critical_005_claim_isotropic_setting`（ラベル `isotropic_A_equals_one`）

**具体版**（人手証明と同じ抽象度）。`γ` は 012 章で形式化済みの `Ising2D.gammaFn`
（`Part012/Claim001_Gamma1LowerBound.lean`）をそのまま使う。

## 原文との対応で明示した前提

原文 `def_transfer_matrix_symbols` は `K_2^*` を `sinh 2K_2 sinh 2K_2^* = 1` で定める。
既存の `Ising2D.IsingParam` は `K_1, K_2, K_2^*` の正値性しか持たないので、
この双対関係が要る主張（`critical_point_iff_kappa_zero`, `isotropic_A_equals_one`）では
`Ising2D.KStar`（`K^* := arsinh(1/sinh 2K)/2`）を明示的に導入し、
`K_2^* = KStar K_2` を仮定として書く。これは原文の定義そのものである。
-/
import Ising2D.Part012.Claim001_Gamma1LowerBound
import Ising2D.Part020.Claim001_CoshAddHalfAngle

namespace Ising2D

open Real

/-- 原文 `def_kappa` の `κ := 2K_1 - 2K_2^*`。 -/
noncomputable def kappaP (P : IsingParam) : ℝ := 2 * P.K1 - 2 * P.K2star

/-- 原文 `def_critical_sinh_product_A` の `A := s_1 s_2^* = sinh 2K_1 sinh 2K_2^*`。 -/
noncomputable def AP (P : IsingParam) : ℝ :=
  Real.sinh (2 * P.K1) * Real.sinh (2 * P.K2star)

/-- 原文 `def_critical_sinh_product_A`: `A > 0`。 -/
theorem AP_pos (P : IsingParam) : 0 < AP P :=
  mul_pos P.s1_pos P.s2star_pos

/-- `1 - cos θ = 2 sin²(θ/2)`（原文の倍角公式の使用箇所）。 -/
theorem one_sub_cos_eq (θ : ℝ) : 1 - Real.cos θ = 2 * Real.sin (θ / 2) ^ 2 := by
  have h := Real.cos_two_mul (θ / 2)
  rw [show 2 * (θ / 2) = θ by ring] at h
  have hs := Real.sin_sq_add_cos_sq (θ / 2)
  rw [h]; nlinarith [hs]

/-- **人手証明 `gamma_kappa_identity` の第 1 式**:
`γ_1(θ) = cosh κ + 2A sin²(θ/2)`。 -/
theorem gamma1R_eq_cosh_kappa_add (P : IsingParam) (θ : ℝ) :
    gamma1R P.const θ = Real.cosh (kappaP P) + 2 * AP P * Real.sin (θ / 2) ^ 2 := by
  have hcs : Real.cosh (kappaP P)
      = Real.cosh (2 * P.K1) * Real.cosh (2 * P.K2star)
        - Real.sinh (2 * P.K1) * Real.sinh (2 * P.K2star) := by
    rw [kappaP]; exact Real.cosh_sub _ _
  have hcos := one_sub_cos_eq θ
  simp only [gamma1R, IsingParam.const, AP]
  linear_combination (-1 : ℝ) * hcs
    + (Real.sinh (2 * P.K1) * Real.sinh (2 * P.K2star)) * hcos

/-- 原文の `S := sinh²(κ/2) + A sin²(θ/2)`。 -/
noncomputable def Sparam (P : IsingParam) (θ : ℝ) : ℝ :=
  Real.sinh (kappaP P / 2) ^ 2 + AP P * Real.sin (θ / 2) ^ 2

theorem Sparam_nonneg (P : IsingParam) (θ : ℝ) : 0 ≤ Sparam P θ := by
  have := (AP_pos P).le
  have : 0 ≤ AP P * Real.sin (θ / 2) ^ 2 := by positivity
  simp only [Sparam]
  nlinarith [sq_nonneg (Real.sinh (kappaP P / 2))]

/-- **人手証明 `gamma_kappa_identity` の第 2 式**:
`sinh²(γ(θ)/2) = sinh²(κ/2) + A sin²(θ/2)`。 -/
theorem sinh_half_gammaFn_sq (P : IsingParam) (θ : ℝ) :
    Real.sinh (gammaFn P θ / 2) ^ 2 = Sparam P θ := by
  have h1 : Real.cosh (gammaFn P θ) = 1 + 2 * Real.sinh (gammaFn P θ / 2) ^ 2 :=
    cosh_eq_one_add_two_sinh_half_sq _
  have h2 : Real.cosh (kappaP P) = 1 + 2 * Real.sinh (kappaP P / 2) ^ 2 :=
    cosh_eq_one_add_two_sinh_half_sq _
  have h3 := cosh_gammaFn P θ
  have h4 := gamma1R_eq_cosh_kappa_add P θ
  simp only [Sparam]
  linear_combination (-1/2 : ℝ) * h1 + (1/2 : ℝ) * h2 + (1/2 : ℝ) * h3 + (1/2 : ℝ) * h4

/-- **人手証明 `gamma_kappa_identity` の第 3 式**:
`γ(θ) = 2 arcsinh(√(sinh²(κ/2) + A sin²(θ/2)))`。 -/
theorem gammaFn_eq_two_arsinh (P : IsingParam) (θ : ℝ) :
    gammaFn P θ = 2 * Real.arsinh (Real.sqrt (Sparam P θ)) := by
  have hnn : 0 ≤ gammaFn P θ := gammaFn_nonneg P θ
  have hhalf : 0 ≤ gammaFn P θ / 2 := by linarith
  have hsnn : 0 ≤ Real.sinh (gammaFn P θ / 2) := Real.sinh_nonneg_iff.2 hhalf
  have hsq := sinh_half_gammaFn_sq P θ
  have hval : Real.sinh (gammaFn P θ / 2) = Real.sqrt (Sparam P θ) := by
    rw [← hsq, Real.sqrt_sq hsnn]
  have := (sinh_eq_iff_eq_arsinh (gammaFn P θ / 2) (Real.sqrt (Sparam P θ))).1 hval
  linarith [this]

/-- `κ` についての偶関数性（原文の「`κ` を `-κ` に置き換えても値が変わらない」）。
`Sparam` が `sinh²(κ/2)` を通してしか `κ` に依存しないことの明示。 -/
theorem Sparam_even (κ A θ : ℝ) :
    Real.sinh (-κ / 2) ^ 2 + A * Real.sin (θ / 2) ^ 2
      = Real.sinh (κ / 2) ^ 2 + A * Real.sin (θ / 2) ^ 2 := by
  rw [show -κ / 2 = -(κ / 2) by ring, Real.sinh_neg]
  ring

/-! ## 臨界条件 -/

/-- 原文 `def_transfer_matrix_symbols` の `K^*`（`sinh 2K sinh 2K^* = 1` で定まる）。 -/
noncomputable def KStar (K : ℝ) : ℝ := Real.arsinh (1 / Real.sinh (2 * K)) / 2

theorem sinh_two_KStar (K : ℝ) : Real.sinh (2 * KStar K) = 1 / Real.sinh (2 * K) := by
  rw [KStar, show 2 * (Real.arsinh (1 / Real.sinh (2 * K)) / 2)
    = Real.arsinh (1 / Real.sinh (2 * K)) by ring, Real.sinh_arsinh]

/-- 原文の定義そのもの: `sinh 2K sinh 2K^* = 1`（`K > 0`）。 -/
theorem sinh_two_mul_sinh_two_KStar {K : ℝ} (hK : 0 < K) :
    Real.sinh (2 * K) * Real.sinh (2 * KStar K) = 1 := by
  have hs : 0 < Real.sinh (2 * K) := Real.sinh_pos_iff.2 (by linarith)
  rw [sinh_two_KStar]
  field_simp

theorem KStar_pos {K : ℝ} (hK : 0 < K) : 0 < KStar K := by
  have hs : 0 < Real.sinh (2 * K) := Real.sinh_pos_iff.2 (by linarith)
  have : 0 < 1 / Real.sinh (2 * K) := by positivity
  have := Real.arsinh_pos_iff.2 this
  simp only [KStar]
  linarith

/-- **人手証明 `critical_point_iff_kappa_zero`**:
`sinh 2K_1 sinh 2K_2 = 1 ⟺ K_1 = K_2^* ⟺ κ = 0`。 -/
theorem critical_point_iff_kappa_zero {K1 K2 : ℝ} (_hK1 : 0 < K1) (hK2 : 0 < K2) :
    (Real.sinh (2 * K1) * Real.sinh (2 * K2) = 1 ↔ K1 = KStar K2) ∧
    (K1 = KStar K2 ↔ 2 * K1 - 2 * KStar K2 = 0) := by
  have hs2 : 0 < Real.sinh (2 * K2) := Real.sinh_pos_iff.2 (by linarith)
  constructor
  · constructor
    · intro h
      have h1 : Real.sinh (2 * K1) = 1 / Real.sinh (2 * K2) := by
        field_simp at h ⊢; linarith [h]
      rw [← sinh_two_KStar K2] at h1
      have := sinh_injective_real h1
      linarith
    · intro h
      rw [h]
      have := sinh_two_mul_sinh_two_KStar hK2
      linarith [this, sinh_two_KStar K2]
  · constructor
    · intro h; rw [h]; ring
    · intro h; linarith

/-! ## 等方な場合 -/

/-- 等方な場合 `K_1 = K_2 = K`（`K_2^* = K^*`）の `IsingParam`。 -/
noncomputable def isoParam (K : ℝ) (hK : 0 < K) : IsingParam where
  K1 := K
  K2 := K
  K2star := KStar K
  K1_pos := hK
  K2_pos := hK
  K2star_pos := KStar_pos hK

/-- **人手証明 `isotropic_A_equals_one`**: 等方な場合 `A = 1`。 -/
theorem AP_isoParam (K : ℝ) (hK : 0 < K) : AP (isoParam K hK) = 1 := by
  simp only [AP, isoParam]
  exact sinh_two_mul_sinh_two_KStar hK

/-- 等方な場合の `κ(K) = 2K - 2K^*`。 -/
noncomputable def kappaK (K : ℝ) : ℝ := 2 * K - 2 * KStar K

theorem kappaP_isoParam (K : ℝ) (hK : 0 < K) : kappaP (isoParam K hK) = kappaK K := rfl

/-- **人手証明 `isotropic_A_equals_one` の表示**:
等方な場合 `γ(θ) = 2 arcsinh(√(sinh²(κ/2) + sin²(θ/2)))`。 -/
theorem gammaFn_isoParam (K : ℝ) (hK : 0 < K) (θ : ℝ) :
    gammaFn (isoParam K hK) θ
      = 2 * Real.arsinh (Real.sqrt (Real.sinh (kappaK K / 2) ^ 2 + Real.sin (θ / 2) ^ 2)) := by
  rw [gammaFn_eq_two_arsinh]
  simp only [Sparam, AP_isoParam, kappaP_isoParam, one_mul]

end Ising2D
