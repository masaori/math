/-
# `∂γ/∂κ = sinh κ / sinh γ`、`|∂γ/∂κ| ≤ 1`、および 2 階導関数

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_007_claim_gamma_derivatives_in_kappa`（ラベル `gamma_derivatives_in_kappa`）

**具体版**（人手証明と同じ抽象度）。必要十分版は不要（後述）。

## 形式化の方針

原文は等方な場合（`isotropic_A_equals_one`、`A = 1`）の 2 変数関数

  `S(θ,κ) := sinh²(κ/2) + sin²(θ/2)`,  `γ(θ,κ) := 2 arcsinh(√S)`

を考える。Lean でも同じものを `Ising2D.Sfun` / `Ising2D.gammaK` として定義する。
原文が `sinh γ`, `cosh γ` で書いている導関数は、Lean では**平方根の中身 `S` で書いた形**
（`Ising2D.dgammaK`, `Ising2D.d2gammaK`）を主定義とし、原文の形と一致することを
`dgammaK_eq_sinh_div_sinh` / `d2gammaK_eq` で確かめる。
これは 0 割りを避けるためではなく、`sinh γ = 2√(S(1+S))` を経由すると
微分の連鎖律が `S` について閉じるからである。

## 必要十分版を立てなかった理由

本主張の内容は「`κ ↦ 2 arcsinh(√(sinh²(κ/2)+c))` の 1 階・2 階導関数を計算する」ことであり、
効いているのは合成関数の微分と `arcsinh' = 1/√(1+y²)` だけである。
`sin²(θ/2)` は `κ` について定数としてしか効いておらず、実際 `θ` は
**「`κ` に依存しない非負定数 `c` を足す」以上の役割を持たない**。
この観察自体を必要十分版として切り出しても mathlib の `HasDerivAt` の合成規則を
書き写すだけになるので、対数発散の本体（`Ising2D/NecSuf/LogDivergentIntegral.lean`）と
Leibniz 則（`Ising2D/NecSuf/DiffUnderIntegral.lean`）を必要十分版として分離し、
ここは具体版のみとした。
-/
import Ising2D.Part020.Claim001_CoshAddHalfAngle
import Mathlib.Analysis.SpecialFunctions.Sqrt

namespace Ising2D

open Real

/-- 原文の `S(θ,κ) := sinh²(κ/2) + sin²(θ/2)`（等方な場合 `A = 1`）。 -/
noncomputable def Sfun (θ κ : ℝ) : ℝ := Real.sinh (κ / 2) ^ 2 + Real.sin (θ / 2) ^ 2

/-- `Q := S(1+S)`（`sinh γ = 2√Q` となる量）。 -/
noncomputable def Qfun (θ κ : ℝ) : ℝ := Sfun θ κ * (1 + Sfun θ κ)

/-- 原文の `γ(θ,κ) := 2 arcsinh(√S)`。 -/
noncomputable def gammaK (θ κ : ℝ) : ℝ := 2 * Real.arsinh (Real.sqrt (Sfun θ κ))

/-- `∂γ/∂κ`（原文 (2) の第 1 式を `S` で書いた形）。 -/
noncomputable def dgammaK (θ κ : ℝ) : ℝ := Real.sinh κ / (2 * Real.sqrt (Qfun θ κ))

/-- `∂²γ/∂κ²`（原文 (2) の第 2 式を `S` で書いた形）。 -/
noncomputable def d2gammaK (θ κ : ℝ) : ℝ :=
  Real.cosh κ / (2 * Real.sqrt (Qfun θ κ))
    - Real.sinh κ ^ 2 * (1 + 2 * Sfun θ κ) / (8 * Qfun θ κ * Real.sqrt (Qfun θ κ))

theorem Sfun_nonneg (θ κ : ℝ) : 0 ≤ Sfun θ κ := by
  simp only [Sfun]; positivity

theorem Sfun_pos_of_ne_zero {κ : ℝ} (θ : ℝ) (hκ : κ ≠ 0) : 0 < Sfun θ κ := by
  have h : Real.sinh (κ / 2) ≠ 0 := Real.sinh_ne_zero.2 (by simpa using hκ)
  have : 0 < Real.sinh (κ / 2) ^ 2 := by positivity
  simp only [Sfun]
  nlinarith [sq_nonneg (Real.sin (θ / 2))]

theorem Qfun_pos_of_ne_zero {κ : ℝ} (θ : ℝ) (hκ : κ ≠ 0) : 0 < Qfun θ κ := by
  have h := Sfun_pos_of_ne_zero θ hκ
  simp only [Qfun]; nlinarith

theorem sqrt_Qfun_pos {κ : ℝ} (θ : ℝ) (hκ : κ ≠ 0) : 0 < Real.sqrt (Qfun θ κ) :=
  Real.sqrt_pos.2 (Qfun_pos_of_ne_zero θ hκ)

/-! ## 原文 (1): `sinh(γ/2) = √S` などの明示式 -/

theorem gammaK_nonneg (θ κ : ℝ) : 0 ≤ gammaK θ κ := by
  simp only [gammaK]
  have : 0 ≤ Real.arsinh (Real.sqrt (Sfun θ κ)) :=
    Real.arsinh_nonneg_iff.2 (Real.sqrt_nonneg _)
  linarith

/-- 人手証明 (1): `sinh(γ/2) = √S`。 -/
theorem sinh_half_gammaK (θ κ : ℝ) :
    Real.sinh (gammaK θ κ / 2) = Real.sqrt (Sfun θ κ) := by
  simp only [gammaK]
  rw [show 2 * Real.arsinh (Real.sqrt (Sfun θ κ)) / 2
      = Real.arsinh (Real.sqrt (Sfun θ κ)) by ring, Real.sinh_arsinh]

/-- 人手証明 (1): `cosh(γ/2) = √(1+S)`。 -/
theorem cosh_half_gammaK (θ κ : ℝ) :
    Real.cosh (gammaK θ κ / 2) = Real.sqrt (1 + Sfun θ κ) := by
  simp only [gammaK]
  rw [show 2 * Real.arsinh (Real.sqrt (Sfun θ κ)) / 2
      = Real.arsinh (Real.sqrt (Sfun θ κ)) by ring, Real.cosh_arsinh]
  congr 1
  rw [Real.sq_sqrt (Sfun_nonneg θ κ)]

/-- 人手証明 (1): `sinh γ = 2√(S(1+S))`。 -/
theorem sinh_gammaK (θ κ : ℝ) : Real.sinh (gammaK θ κ) = 2 * Real.sqrt (Qfun θ κ) := by
  have h := sinh_eq_two_sinh_half_mul_cosh_half (gammaK θ κ)
  rw [h, sinh_half_gammaK, cosh_half_gammaK, Qfun,
    Real.sqrt_mul (Sfun_nonneg θ κ)]
  ring

/-- 人手証明 (1): `cosh γ = 1 + 2S`。 -/
theorem cosh_gammaK (θ κ : ℝ) : Real.cosh (gammaK θ κ) = 1 + 2 * Sfun θ κ := by
  rw [cosh_eq_one_add_two_sinh_half_sq, sinh_half_gammaK, Real.sq_sqrt (Sfun_nonneg θ κ)]

/-! ## 原文 (2): 導関数 -/

/-- `κ ↦ S(θ,κ)` の導関数は `sinh κ / 2`。 -/
theorem hasDerivAt_Sfun (θ κ : ℝ) :
    HasDerivAt (fun x => Sfun θ x) (Real.sinh κ / 2) κ := by
  have hhalf : HasDerivAt (fun x : ℝ => x / 2) (1 / 2) κ := by
    simpa using (hasDerivAt_id κ).div_const 2
  have hs : HasDerivAt (fun x : ℝ => Real.sinh (x / 2)) (Real.cosh (κ / 2) * (1 / 2)) κ :=
    hhalf.sinh
  have hsq : HasDerivAt (fun x : ℝ => Real.sinh (x / 2) ^ 2)
      (2 * Real.sinh (κ / 2) ^ 1 * (Real.cosh (κ / 2) * (1 / 2))) κ := hs.pow 2
  have hval : 2 * Real.sinh (κ / 2) ^ 1 * (Real.cosh (κ / 2) * (1 / 2))
      = Real.sinh κ / 2 := by
    rw [sinh_eq_two_sinh_half_mul_cosh_half κ]; ring
  rw [hval] at hsq
  simpa [Sfun] using hsq.add_const (Real.sin (θ / 2) ^ 2)

/-- `κ ↦ Q(θ,κ)` の導関数。 -/
theorem hasDerivAt_Qfun (θ κ : ℝ) :
    HasDerivAt (fun x => Qfun θ x) ((1 + 2 * Sfun θ κ) * (Real.sinh κ / 2)) κ := by
  have hS := hasDerivAt_Sfun θ κ
  simp only [Qfun]
  have hval : Real.sinh κ / 2 * (1 + Sfun θ κ) + Sfun θ κ * (Real.sinh κ / 2)
      = (1 + 2 * Sfun θ κ) * (Real.sinh κ / 2) := by ring
  rw [← hval]
  exact hS.mul (hS.const_add 1)

/-- **人手証明 `gamma_derivatives_in_kappa` (2) の第 1 式**:
`κ ≠ 0` のとき `∂γ/∂κ = sinh κ / (2√(S(1+S)))`。 -/
theorem hasDerivAt_gammaK {κ : ℝ} (θ : ℝ) (hκ : κ ≠ 0) :
    HasDerivAt (fun x => gammaK θ x) (dgammaK θ κ) κ := by
  have hS0 : 0 < Sfun θ κ := Sfun_pos_of_ne_zero θ hκ
  have hsS : 0 < Real.sqrt (Sfun θ κ) := Real.sqrt_pos.2 hS0
  have hroot : HasDerivAt (fun x => Real.sqrt (Sfun θ x))
      (Real.sinh κ / 2 / (2 * Real.sqrt (Sfun θ κ))) κ :=
    (hasDerivAt_Sfun θ κ).sqrt (ne_of_gt hS0)
  have harc := hroot.arsinh
  have h := harc.const_mul (2 : ℝ)
  have hsq : Real.sqrt (Sfun θ κ) ^ 2 = Sfun θ κ := Real.sq_sqrt (Sfun_nonneg θ κ)
  have hs1 : Real.sqrt (1 + Real.sqrt (Sfun θ κ) ^ 2) = Real.sqrt (1 + Sfun θ κ) := by
    rw [hsq]
  have h1S : 0 < Real.sqrt (1 + Sfun θ κ) := Real.sqrt_pos.2 (by linarith)
  have hQ : Real.sqrt (Qfun θ κ) = Real.sqrt (Sfun θ κ) * Real.sqrt (1 + Sfun θ κ) := by
    rw [Qfun, Real.sqrt_mul (Sfun_nonneg θ κ)]
  have hval : 2 * ((Real.sqrt (1 + Real.sqrt (Sfun θ κ) ^ 2))⁻¹
      • (Real.sinh κ / 2 / (2 * Real.sqrt (Sfun θ κ)))) = dgammaK θ κ := by
    simp only [smul_eq_mul, hs1, dgammaK, hQ]
    field_simp
  rw [hval] at h
  simpa [gammaK] using h

/-- 原文の形との一致: `∂γ/∂κ = sinh κ / sinh γ`。 -/
theorem dgammaK_eq_sinh_div_sinh (θ κ : ℝ) :
    dgammaK θ κ = Real.sinh κ / Real.sinh (gammaK θ κ) := by
  rw [sinh_gammaK, dgammaK]

/-- **人手証明 `gamma_derivatives_in_kappa` (2) の第 2 式**（2 階導関数）。 -/
theorem hasDerivAt_dgammaK {κ : ℝ} (θ : ℝ) (hκ : κ ≠ 0) :
    HasDerivAt (fun x => dgammaK θ x) (d2gammaK θ κ) κ := by
  have hQ0 : 0 < Qfun θ κ := Qfun_pos_of_ne_zero θ hκ
  have hsQ : 0 < Real.sqrt (Qfun θ κ) := Real.sqrt_pos.2 hQ0
  have hsq : Real.sqrt (Qfun θ κ) ^ 2 = Qfun θ κ := Real.sq_sqrt hQ0.le
  have hroot : HasDerivAt (fun x => Real.sqrt (Qfun θ x))
      ((1 + 2 * Sfun θ κ) * (Real.sinh κ / 2) / (2 * Real.sqrt (Qfun θ κ))) κ :=
    (hasDerivAt_Qfun θ κ).sqrt (ne_of_gt hQ0)
  have hden : HasDerivAt (fun x => 2 * Real.sqrt (Qfun θ x))
      (2 * ((1 + 2 * Sfun θ κ) * (Real.sinh κ / 2) / (2 * Real.sqrt (Qfun θ κ)))) κ :=
    hroot.const_mul 2
  have hdne : (2 : ℝ) * Real.sqrt (Qfun θ κ) ≠ 0 := by positivity
  have h := (Real.hasDerivAt_sinh κ).div hden hdne
  have hval : (Real.cosh κ * (2 * Real.sqrt (Qfun θ κ))
      - Real.sinh κ * (2 * ((1 + 2 * Sfun θ κ) * (Real.sinh κ / 2)
          / (2 * Real.sqrt (Qfun θ κ)))))
      / (2 * Real.sqrt (Qfun θ κ)) ^ 2 = d2gammaK θ κ := by
    simp only [d2gammaK]
    set s : ℝ := Real.sqrt (Qfun θ κ) with hsdef
    rw [← hsq]
    field_simp
    ring
  rw [hval] at h
  exact h

/-- 原文の形との一致: `∂²γ/∂κ² = cosh κ/sinh γ - sinh²κ cosh γ/sinh³γ`。 -/
theorem d2gammaK_eq {κ : ℝ} (θ : ℝ) (hκ : κ ≠ 0) :
    d2gammaK θ κ = Real.cosh κ / Real.sinh (gammaK θ κ)
      - Real.sinh κ ^ 2 * Real.cosh (gammaK θ κ) / Real.sinh (gammaK θ κ) ^ 3 := by
  have hQ0 : 0 < Qfun θ κ := Qfun_pos_of_ne_zero θ hκ
  have hsQ : 0 < Real.sqrt (Qfun θ κ) := Real.sqrt_pos.2 hQ0
  have hsq : Real.sqrt (Qfun θ κ) ^ 2 = Qfun θ κ := Real.sq_sqrt hQ0.le
  rw [sinh_gammaK, cosh_gammaK, d2gammaK]
  have h3 : (2 * Real.sqrt (Qfun θ κ)) ^ 3 = 8 * Qfun θ κ * Real.sqrt (Qfun θ κ) := by
    have hx : (2 * Real.sqrt (Qfun θ κ)) ^ 3
        = 8 * Real.sqrt (Qfun θ κ) ^ 2 * Real.sqrt (Qfun θ κ) := by ring
    rw [hx, hsq]
  rw [h3]

/-! ## 原文 (3): `|∂γ/∂κ| ≤ 1` -/

/-- `Q ≥ sinh²κ/4`（原文 (3) の `sinh γ ≥ |sinh κ|`）。 -/
theorem sinh_sq_div_four_le_Qfun (θ κ : ℝ) : Real.sinh κ ^ 2 / 4 ≤ Qfun θ κ := by
  have hs : Real.sinh κ = 2 * Real.sinh (κ / 2) * Real.cosh (κ / 2) :=
    sinh_eq_two_sinh_half_mul_cosh_half κ
  have hc : Real.cosh (κ / 2) ^ 2 = Real.sinh (κ / 2) ^ 2 + 1 := Real.cosh_sq (κ / 2)
  have hS : Real.sinh (κ / 2) ^ 2 ≤ Sfun θ κ := by
    simp only [Sfun]; nlinarith [sq_nonneg (Real.sin (θ / 2))]
  have hSnn : 0 ≤ Sfun θ κ := Sfun_nonneg θ κ
  have hkey : Real.sinh (κ / 2) ^ 2 * (1 + Real.sinh (κ / 2) ^ 2) ≤ Qfun θ κ := by
    simp only [Qfun]
    nlinarith [hS, hSnn, sq_nonneg (Real.sinh (κ / 2))]
  have hval : Real.sinh κ ^ 2 / 4 = Real.sinh (κ / 2) ^ 2 * (1 + Real.sinh (κ / 2) ^ 2) := by
    rw [hs]; nlinarith [hc]
  linarith [hval.le, hval.ge, hkey]

/-- **人手証明 `gamma_derivatives_in_kappa` (3)**: `|∂γ/∂κ| ≤ 1`（`κ ≠ 0`）。 -/
theorem abs_dgammaK_le_one {κ : ℝ} (θ : ℝ) (hκ : κ ≠ 0) : |dgammaK θ κ| ≤ 1 := by
  have hQ0 : 0 < Qfun θ κ := Qfun_pos_of_ne_zero θ hκ
  have hsQ : 0 < Real.sqrt (Qfun θ κ) := Real.sqrt_pos.2 hQ0
  have hsq : Real.sqrt (Qfun θ κ) ^ 2 = Qfun θ κ := Real.sq_sqrt hQ0.le
  have hbig : Real.sinh κ ^ 2 / 4 ≤ Qfun θ κ := sinh_sq_div_four_le_Qfun θ κ
  have habs : |Real.sinh κ| ≤ 2 * Real.sqrt (Qfun θ κ) := by
    nlinarith [sq_abs (Real.sinh κ), abs_nonneg (Real.sinh κ), hsq, hsQ]
  rw [dgammaK, abs_div, abs_of_pos (by positivity : (0:ℝ) < 2 * Real.sqrt (Qfun θ κ)),
    div_le_one (by positivity)]
  exact habs

/-! ## 原文 (4): 連続性 -/

theorem continuous_Sfun : Continuous fun p : ℝ × ℝ => Sfun p.1 p.2 := by
  unfold Sfun; fun_prop

theorem continuous_Qfun : Continuous fun p : ℝ × ℝ => Qfun p.1 p.2 := by
  unfold Qfun; exact continuous_Sfun.mul (continuous_const.add continuous_Sfun)

theorem continuous_gammaK : Continuous fun p : ℝ × ℝ => gammaK p.1 p.2 := by
  unfold gammaK
  exact continuous_const.mul (Real.continuous_arsinh.comp continuous_Sfun.sqrt)

/-- **人手証明 `gamma_derivatives_in_kappa` (4)**（`∂γ/∂κ` の連続性）。 -/
theorem continuousOn_dgammaK :
    ContinuousOn (fun p : ℝ × ℝ => dgammaK p.1 p.2)
      ((Set.univ : Set ℝ) ×ˢ {κ : ℝ | κ ≠ 0}) := by
  unfold dgammaK
  apply ContinuousOn.div
  · exact (Real.continuous_sinh.comp continuous_snd).continuousOn
  · exact (continuous_const.mul continuous_Qfun.sqrt).continuousOn
  · rintro ⟨θ, κ⟩ hp
    have hκ : κ ≠ 0 := hp.2
    have h := sqrt_Qfun_pos θ hκ
    simp only
    positivity

/-- **人手証明 `gamma_derivatives_in_kappa` (4)**（`∂²γ/∂κ²` の連続性）。 -/
theorem continuousOn_d2gammaK :
    ContinuousOn (fun p : ℝ × ℝ => d2gammaK p.1 p.2)
      ((Set.univ : Set ℝ) ×ˢ {κ : ℝ | κ ≠ 0}) := by
  unfold d2gammaK
  apply ContinuousOn.sub
  · apply ContinuousOn.div
    · exact (Real.continuous_cosh.comp continuous_snd).continuousOn
    · exact (continuous_const.mul continuous_Qfun.sqrt).continuousOn
    · rintro ⟨θ, κ⟩ hp
      have h := sqrt_Qfun_pos θ hp.2
      simp only
      positivity
  · apply ContinuousOn.div
    · exact (((Real.continuous_sinh.comp continuous_snd).pow 2).mul
        (continuous_const.add (continuous_const.mul continuous_Sfun))).continuousOn
    · exact ((continuous_const.mul continuous_Qfun).mul continuous_Qfun.sqrt).continuousOn
    · rintro ⟨θ, κ⟩ hp
      have h1 := Qfun_pos_of_ne_zero θ hp.2
      have h2 := sqrt_Qfun_pos θ hp.2
      simp only
      positivity

/-! ## `θ` を動かしたときの連続性（積分のために使う） -/

theorem continuous_Sfun_fixed (κ : ℝ) : Continuous fun θ : ℝ => Sfun θ κ := by
  unfold Sfun; fun_prop

theorem continuous_Qfun_fixed (κ : ℝ) : Continuous fun θ : ℝ => Qfun θ κ := by
  unfold Qfun
  exact (continuous_Sfun_fixed κ).mul (continuous_const.add (continuous_Sfun_fixed κ))

theorem continuous_sqrtQfun_fixed (κ : ℝ) :
    Continuous fun θ : ℝ => Real.sqrt (Qfun θ κ) := (continuous_Qfun_fixed κ).sqrt

theorem continuous_gammaK_fixed (κ : ℝ) : Continuous fun θ : ℝ => gammaK θ κ := by
  unfold gammaK
  exact continuous_const.mul (Real.continuous_arsinh.comp (continuous_Sfun_fixed κ).sqrt)

theorem continuous_dgammaK_fixed {κ : ℝ} (hκ : κ ≠ 0) :
    Continuous fun θ : ℝ => dgammaK θ κ := by
  unfold dgammaK
  refine continuous_const.div (continuous_const.mul (continuous_sqrtQfun_fixed κ)) ?_
  intro θ
  have := sqrt_Qfun_pos θ hκ
  positivity

theorem continuous_d2gammaK_fixed {κ : ℝ} (hκ : κ ≠ 0) :
    Continuous fun θ : ℝ => d2gammaK θ κ := by
  unfold d2gammaK
  refine Continuous.sub ?_ ?_
  · refine continuous_const.div (continuous_const.mul (continuous_sqrtQfun_fixed κ)) ?_
    intro θ
    have := sqrt_Qfun_pos θ hκ
    positivity
  · refine Continuous.div ?_ ?_ ?_
    · exact continuous_const.mul (continuous_const.add
        (continuous_const.mul (continuous_Sfun_fixed κ)))
    · exact (continuous_const.mul (continuous_Qfun_fixed κ)).mul (continuous_sqrtQfun_fixed κ)
    · intro θ
      have h1 := Qfun_pos_of_ne_zero θ hκ
      have h2 := sqrt_Qfun_pos θ hκ
      positivity

end Ising2D
