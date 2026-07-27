/-
# `κ(K)` の基本性質と臨界点 `K_c`

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_006_claim_kappa_of_K_basic`（ラベル `kappa_of_K_basic`）

**具体版**（人手証明と同じ抽象度）。抽象版は
`Ising2D/Abstract/MeanValueTwoSided.lean`（(5) の増分評価）と
`Ising2D/Abstract/HyperbolicBounds.lean`（数値評価に使う `cosh` の上下界）。

## 人手証明の数値評価との差（重要）

原文 (4)(5) は `cosh 0.2 ≤ 1.02007` のような**具体的な数値評価を外から持ち込んでいる**
（原文自身が `remark_real_analysis_escape_chapter_E` の末尾でそう宣言している）。
本形式化では**外から数値を持ち込まず**、`Ising2D.Abstract.cosh_le_inv_one_sub_sq_div_two`
（`cosh t ≤ (1-t²/2)⁻¹`、mathlib の `Real.cosh_le_exp_half_sq` から出る）と
`Ising2D.Abstract.one_add_sq_div_two_le_cosh` だけで評価する。
そのぶん定数はわずかに悪くなる（原文の値 → 本形式化の値）:

| 量 | 原文 | 本形式化 |
| --- | --- | --- |
| `sinh 2K` の下界 | `0.7353` | `0.7313` |
| `sinh 2K` の上界 | `1.3048` | `1.3091` |
| `κ'` の範囲 | `[3.53, 4.72]` | `[3.52, 4.74]` |
| `\|κ''\|` の上界 | `9.19` | `9.3` |
| `\|(κ'²)'\|` の上界 | `87` | `88.2` |
| `\|κ'²-16\|/\|κ\|` | `24.7` | `25.1` |

**この差は `second_derivative_log_divergence` の結論の定数 `6/5` を変えない**ことを
`Theorem011_SecondDerivativeLogDivergence.lean` で確認してある。
（`specific_heat_log_divergence`（原文 `critical_012`）は未形式化。
理由は `lean/docs/ch020-formalization.md` の「3. 形式化できなかった主張」を見よ。）

また原文は `|κ''|` の上界に「`t ↦ 4cosh t/sinh²t` が `t > 0` で単調減少」を使うが、
本形式化では `cosh 2K = √(1 + sinh²2K)` に直して
「`s ↦ 4√(1+s²)/s²` が `s > 0` で単調減少」という**代数的な**形で使う
（`sinh` の単調性しか要らず、微分が要らない）。
-/
import Ising2D.Part020.Definition002_KappaAndCritical
import Ising2D.Abstract.MeanValueTwoSided

namespace Ising2D

open Real

/-! ## 数値評価の下準備 -/

theorem sqrt_two_bounds : (1.4142135 : ℝ) ≤ Real.sqrt 2 ∧ Real.sqrt 2 ≤ 1.4142136 := by
  constructor
  · have h : Real.sqrt ((1.4142135 : ℝ) ^ 2) ≤ Real.sqrt 2 :=
      Real.sqrt_le_sqrt (by norm_num)
    rwa [Real.sqrt_sq (by norm_num)] at h
  · have h : Real.sqrt 2 ≤ Real.sqrt ((1.4142136 : ℝ) ^ 2) :=
      Real.sqrt_le_sqrt (by norm_num)
    rwa [Real.sqrt_sq (by norm_num)] at h

theorem cosh_02_bounds : (1.02 : ℝ) ≤ Real.cosh 0.2 ∧ Real.cosh 0.2 ≤ 1.0204082 := by
  constructor
  · have := Abstract.one_add_sq_div_two_le_cosh (0.2 : ℝ)
    norm_num at this ⊢
    linarith
  · have := Abstract.cosh_le_inv_one_sub_sq_div_two (t := (0.2 : ℝ)) (by norm_num)
    norm_num at this ⊢
    linarith

theorem sinh_02_bounds : (0.2 : ℝ) ≤ Real.sinh 0.2 ∧ Real.sinh 0.2 ≤ 0.2040817 := by
  constructor
  · exact self_le_sinh_of_nonneg (by norm_num)
  · have h := sinh_le_mul_cosh_of_nonneg (t := (0.2 : ℝ)) (by norm_num)
    have hc := cosh_02_bounds.2
    nlinarith [h, hc]

/-! ## 臨界点 `K_c` -/

/-- 原文の臨界点 `K_c`（`sinh 2K_c = 1` で定まる）。 -/
noncomputable def Kc : ℝ := Real.arsinh 1 / 2

theorem sinh_two_Kc : Real.sinh (2 * Kc) = 1 := by
  rw [Kc, show 2 * (Real.arsinh 1 / 2) = Real.arsinh 1 by ring, Real.sinh_arsinh]

theorem cosh_two_Kc : Real.cosh (2 * Kc) = Real.sqrt 2 := by
  have hsq : Real.cosh (2 * Kc) ^ 2 = 2 := by
    rw [Real.cosh_sq, sinh_two_Kc]; norm_num
  have hpos : 0 < Real.cosh (2 * Kc) := Real.cosh_pos _
  have h := congrArg Real.sqrt hsq
  rwa [Real.sqrt_sq hpos.le] at h

theorem Kc_gt_tenth : (1:ℝ)/10 < Kc := by
  have h1 : Real.sinh (0.2 : ℝ) < Real.sinh (2 * Kc) := by
    rw [sinh_two_Kc]
    linarith [sinh_02_bounds.2]
  have := Real.sinh_lt_sinh.1 h1
  linarith

theorem Kc_pos : 0 < Kc := by linarith [Kc_gt_tenth]

/-! ## `κ(K)` の微分 -/

/-- `κ'(K) = 2 + 2/sinh 2K`（原文 (1)）。 -/
noncomputable def kappaDeriv (K : ℝ) : ℝ := 2 + 2 / Real.sinh (2 * K)

/-- `κ''(K) = -4 cosh 2K / sinh² 2K`（原文 (3)）。 -/
noncomputable def kappaSecond (K : ℝ) : ℝ :=
  -(4 * Real.cosh (2 * K)) / Real.sinh (2 * K) ^ 2

theorem kappaK_eq (K : ℝ) : kappaK K = 2 * K - Real.arsinh ((Real.sinh (2 * K))⁻¹) := by
  simp only [kappaK, KStar, one_div]; ring

/-- **人手証明 `kappa_of_K_basic` (1)**: `κ'(K) = 2 + 2/sinh 2K`。 -/
theorem hasDerivAt_kappaK {K : ℝ} (hK : 0 < K) : HasDerivAt kappaK (kappaDeriv K) K := by
  have hs : 0 < Real.sinh (2 * K) := Real.sinh_pos_iff.2 (by linarith)
  have hc : 0 < Real.cosh (2 * K) := Real.cosh_pos _
  have hcs : Real.cosh (2 * K) ^ 2 = Real.sinh (2 * K) ^ 2 + 1 := Real.cosh_sq _
  have hfun : kappaK = fun x : ℝ => 2 * x - Real.arsinh ((Real.sinh (2 * x))⁻¹) := by
    funext x; exact kappaK_eq x
  have h2 : HasDerivAt (fun x : ℝ => 2 * x) 2 K := by
    simpa using (hasDerivAt_id K).const_mul (2 : ℝ)
  have hsin : HasDerivAt (fun x : ℝ => Real.sinh (2 * x)) (Real.cosh (2 * K) * 2) K := h2.sinh
  have hone : HasDerivAt (fun x : ℝ => (Real.sinh (2 * x))⁻¹)
      (-(Real.cosh (2 * K) * 2) / Real.sinh (2 * K) ^ 2) K := hsin.inv (ne_of_gt hs)
  have harc := hone.arsinh
  have hroot : Real.sqrt (1 + ((Real.sinh (2 * K))⁻¹) ^ 2)
      = Real.cosh (2 * K) / Real.sinh (2 * K) := by
    have heq : (1 : ℝ) + ((Real.sinh (2 * K))⁻¹) ^ 2
        = (Real.cosh (2 * K) / Real.sinh (2 * K)) ^ 2 := by
      field_simp
      linarith [hcs]
    rw [heq, Real.sqrt_sq (by positivity)]
  have hval : (Real.sqrt (1 + ((Real.sinh (2 * K))⁻¹) ^ 2))⁻¹
      • (-(Real.cosh (2 * K) * 2) / Real.sinh (2 * K) ^ 2) = -(2 / Real.sinh (2 * K)) := by
    simp only [smul_eq_mul, hroot]
    field_simp
  rw [hval] at harc
  have hres := h2.sub harc
  have hv2 : (2 : ℝ) - -(2 / Real.sinh (2 * K)) = kappaDeriv K := by
    simp only [kappaDeriv]; ring
  rw [hv2] at hres
  rw [hfun]
  exact hres

/-- **人手証明 `kappa_of_K_basic` (3)**: `κ''(K) = -4 cosh 2K/sinh² 2K`。 -/
theorem hasDerivAt_kappaDeriv {K : ℝ} (hK : 0 < K) :
    HasDerivAt kappaDeriv (kappaSecond K) K := by
  have hs : 0 < Real.sinh (2 * K) := Real.sinh_pos_iff.2 (by linarith)
  have h2 : HasDerivAt (fun x : ℝ => 2 * x) 2 K := by
    simpa using (hasDerivAt_id K).const_mul (2 : ℝ)
  have hsin : HasDerivAt (fun x : ℝ => Real.sinh (2 * x)) (Real.cosh (2 * K) * 2) K := h2.sinh
  have hone : HasDerivAt (fun x : ℝ => 2 / Real.sinh (2 * x))
      (2 * (-(Real.cosh (2 * K) * 2) / Real.sinh (2 * K) ^ 2)) K := by
    have := (hsin.inv (ne_of_gt hs)).const_mul (2 : ℝ)
    simpa [div_eq_mul_inv] using this
  have hres := hone.const_add (2 : ℝ)
  have hv : (2 : ℝ) * (-(Real.cosh (2 * K) * 2) / Real.sinh (2 * K) ^ 2) = kappaSecond K := by
    simp only [kappaSecond]; ring
  rw [hv] at hres
  exact hres

/-- **人手証明 `kappa_of_K_basic` (2)**: `κ(K_c) = 0`。 -/
theorem kappaK_Kc : kappaK Kc = 0 := by
  rw [kappaK_eq, sinh_two_Kc]
  norm_num
  rw [Kc]
  ring

/-- **人手証明 `kappa_of_K_basic` (2)**: `κ(K) = 0 ⟺ K = K_c`（`K > 0`）。 -/
theorem kappaK_eq_zero_iff {K : ℝ} (hK : 0 < K) : kappaK K = 0 ↔ K = Kc := by
  constructor
  · intro h
    have hs : 0 < Real.sinh (2 * K) := Real.sinh_pos_iff.2 (by linarith)
    have h1 : Real.arsinh ((Real.sinh (2 * K))⁻¹) = 2 * K := by
      rw [kappaK_eq] at h; linarith
    have h2 : Real.sinh (Real.arsinh ((Real.sinh (2 * K))⁻¹)) = (Real.sinh (2 * K))⁻¹ :=
      Real.sinh_arsinh _
    rw [h1] at h2
    have h3 : Real.sinh (2 * K) = 1 := by
      have hne : Real.sinh (2 * K) ≠ 0 := ne_of_gt hs
      field_simp at h2
      nlinarith [h2, hs]
    have h4 : Real.sinh (2 * K) = Real.sinh (2 * Kc) := by rw [h3, sinh_two_Kc]
    have := sinh_injective_real h4
    linarith
  · intro h; rw [h]; exact kappaK_Kc

/-! ## `|K - K_c| ≤ 1/10` での数値評価 -/

/-- 原文 (4)(5) が考える近傍 `|K - K_c| ≤ 1/10`。 -/
noncomputable def Dnbhd : Set ℝ := Set.Icc (Kc - 1/10) (Kc + 1/10)

theorem Dnbhd_convex : Convex ℝ Dnbhd := convex_Icc _ _

theorem pos_of_mem_Dnbhd {K : ℝ} (hK : K ∈ Dnbhd) : 0 < K := by
  have h : Kc - 1/10 ≤ K := hK.1
  linarith [Kc_gt_tenth]

/-- **人手証明 `kappa_of_K_basic` (4)**: `0.7313 ≤ sinh 2K ≤ 1.3091`。 -/
theorem sinh_two_K_bounds {K : ℝ} (hK : K ∈ Dnbhd) :
    (0.7313 : ℝ) ≤ Real.sinh (2 * K) ∧ Real.sinh (2 * K) ≤ 1.3091 := by
  have hl : Kc - 1/10 ≤ K := hK.1
  have hu : K ≤ Kc + 1/10 := hK.2
  have hs2 := sqrt_two_bounds
  have hc02 := cosh_02_bounds
  have hs02 := sinh_02_bounds
  have hlow : Real.sinh (2 * Kc - 0.2) = Real.cosh 0.2 - Real.sqrt 2 * Real.sinh 0.2 := by
    rw [Real.sinh_sub, sinh_two_Kc, cosh_two_Kc]; ring
  have hhigh : Real.sinh (2 * Kc + 0.2) = Real.cosh 0.2 + Real.sqrt 2 * Real.sinh 0.2 := by
    rw [Real.sinh_add, sinh_two_Kc, cosh_two_Kc]; ring
  constructor
  · have hmono : Real.sinh (2 * Kc - 0.2) ≤ Real.sinh (2 * K) :=
      Real.sinh_le_sinh.2 (by norm_num at hl ⊢; linarith)
    rw [hlow] at hmono
    nlinarith [hs2.1, hs2.2, hc02.1, hc02.2, hs02.1, hs02.2, hmono]
  · have hmono : Real.sinh (2 * K) ≤ Real.sinh (2 * Kc + 0.2) :=
      Real.sinh_le_sinh.2 (by norm_num at hu ⊢; linarith)
    rw [hhigh] at hmono
    nlinarith [hs2.1, hs2.2, hc02.1, hc02.2, hs02.1, hs02.2, hmono]

/-- **人手証明 `kappa_of_K_basic` (4)**: `3.52 ≤ κ'(K) ≤ 4.74`。 -/
theorem kappaDeriv_bounds {K : ℝ} (hK : K ∈ Dnbhd) :
    (3.52 : ℝ) ≤ kappaDeriv K ∧ kappaDeriv K ≤ 4.74 := by
  obtain ⟨hl, hu⟩ := sinh_two_K_bounds hK
  have hs : 0 < Real.sinh (2 * K) := by linarith
  simp only [kappaDeriv]
  constructor
  · have h : (1.52 : ℝ) ≤ 2 / Real.sinh (2 * K) := by
      rw [le_div_iff₀ hs]; linarith
    linarith
  · have h : 2 / Real.sinh (2 * K) ≤ 2.74 := by
      rw [div_le_iff₀ hs]; linarith
    linarith

/-- **人手証明 `kappa_of_K_basic` (4)**: `|κ''(K)| ≤ 9.3`。
原文の「`4cosh t/sinh²t` の単調減少」を、`cosh 2K = √(1+sinh²2K)` に直した
代数的な形（`4√(1+s²)/s²` の `s` についての単調減少）で使う。 -/
theorem abs_kappaSecond_le {K : ℝ} (hK : K ∈ Dnbhd) : |kappaSecond K| ≤ 9.3 := by
  obtain ⟨hl, hu⟩ := sinh_two_K_bounds hK
  have hs : 0 < Real.sinh (2 * K) := by linarith
  have hc : 0 < Real.cosh (2 * K) := Real.cosh_pos _
  have hcs : Real.cosh (2 * K) ^ 2 = Real.sinh (2 * K) ^ 2 + 1 := Real.cosh_sq _
  have hkey : 4 * Real.cosh (2 * K) ≤ 9.3 * Real.sinh (2 * K) ^ 2 := by
    nlinarith [hcs, hc, hs, hl, sq_nonneg (Real.sinh (2 * K) ^ 2 - 0.5348)]
  simp only [kappaSecond]
  rw [abs_div, abs_of_nonneg (by positivity : (0:ℝ) ≤ Real.sinh (2 * K) ^ 2), abs_neg,
    abs_of_nonneg (by positivity : (0:ℝ) ≤ 4 * Real.cosh (2 * K)),
    div_le_iff₀ (by positivity)]
  linarith

/-! ## 増分の評価（原文 (5)） -/

theorem interior_Dnbhd : interior Dnbhd = Set.Ioo (Kc - 1/10) (Kc + 1/10) := by
  simp only [Dnbhd, interior_Icc]

theorem mem_Dnbhd_of_mem_interior {K : ℝ} (hK : K ∈ interior Dnbhd) : K ∈ Dnbhd := by
  rw [interior_Dnbhd] at hK
  exact ⟨hK.1.le, hK.2.le⟩

theorem Kc_mem_Dnbhd : Kc ∈ Dnbhd := Set.mem_Icc.2 ⟨by linarith, by linarith⟩

theorem deriv_kappaK_on {K : ℝ} (hK : K ∈ Dnbhd) : deriv kappaK K = kappaDeriv K :=
  (hasDerivAt_kappaK (pos_of_mem_Dnbhd hK)).deriv

theorem continuousOn_kappaK : ContinuousOn kappaK Dnbhd := by
  intro K hK
  exact ((hasDerivAt_kappaK (pos_of_mem_Dnbhd hK)).continuousAt).continuousWithinAt

theorem differentiableOn_kappaK : DifferentiableOn ℝ kappaK (interior Dnbhd) := by
  intro K hK
  exact ((hasDerivAt_kappaK
    (pos_of_mem_Dnbhd (mem_Dnbhd_of_mem_interior hK))).differentiableAt).differentiableWithinAt

/-- **人手証明 `kappa_of_K_basic` (5) の第 1 式**:
`3.52|K-K_c| ≤ |κ(K)| ≤ 4.74|K-K_c| ≤ 0.474`。 -/
theorem abs_kappaK_bounds {K : ℝ} (hK : K ∈ Dnbhd) :
    (3.52 : ℝ) * |K - Kc| ≤ |kappaK K| ∧ |kappaK K| ≤ 4.74 * |K - Kc| ∧ |kappaK K| ≤ 0.474 := by
  have hb := Abstract.abs_sub_bounds_of_deriv_bounds (D := Dnbhd) Dnbhd_convex
    (f := kappaK) (clo := 3.52) (chi := 4.74) continuousOn_kappaK differentiableOn_kappaK
    (fun x hx => by
      rw [deriv_kappaK_on (mem_Dnbhd_of_mem_interior hx)]
      exact (kappaDeriv_bounds (mem_Dnbhd_of_mem_interior hx)).1)
    (fun x hx => by
      rw [deriv_kappaK_on (mem_Dnbhd_of_mem_interior hx)]
      exact (kappaDeriv_bounds (mem_Dnbhd_of_mem_interior hx)).2)
    (by norm_num) Kc_mem_Dnbhd hK
  rw [kappaK_Kc, sub_zero] at hb
  have habs : |K - Kc| ≤ 0.1 := by
    have h1 : Kc - 1/10 ≤ K := hK.1
    have h2 : K ≤ Kc + 1/10 := hK.2
    rw [abs_le]
    constructor <;> [linarith; linarith]
  exact ⟨hb.1, hb.2, by nlinarith [hb.2, habs, abs_nonneg (K - Kc)]⟩

/-- `κ'(K)² - 16` の評価に使う関数 `K ↦ κ'(K)²`。 -/
noncomputable def kappaDerivSq (K : ℝ) : ℝ := kappaDeriv K ^ 2

theorem hasDerivAt_kappaDerivSq {K : ℝ} (hK : 0 < K) :
    HasDerivAt kappaDerivSq (2 * kappaDeriv K * kappaSecond K) K := by
  have h := (hasDerivAt_kappaDeriv hK).mul (hasDerivAt_kappaDeriv hK)
  have hv : kappaSecond K * kappaDeriv K + kappaDeriv K * kappaSecond K
      = 2 * kappaDeriv K * kappaSecond K := by ring
  rw [hv] at h
  have hfun : kappaDerivSq = fun x : ℝ => kappaDeriv x * kappaDeriv x := by
    funext x; simp only [kappaDerivSq]; ring
  rw [hfun]
  exact h

theorem kappaDerivSq_Kc : kappaDerivSq Kc = 16 := by
  simp only [kappaDerivSq, kappaDeriv, sinh_two_Kc]
  norm_num

theorem abs_deriv_kappaDerivSq_le {K : ℝ} (hK : K ∈ Dnbhd) :
    |2 * kappaDeriv K * kappaSecond K| ≤ 88.2 := by
  obtain ⟨h1, h2⟩ := kappaDeriv_bounds hK
  have h3 := abs_kappaSecond_le hK
  have hpos : (0:ℝ) ≤ kappaDeriv K := by linarith
  rw [abs_mul, abs_mul, abs_of_nonneg (by norm_num : (0:ℝ) ≤ (2:ℝ)),
    abs_of_nonneg hpos]
  nlinarith [h2, h3, abs_nonneg (kappaSecond K)]

theorem continuousOn_kappaDerivSq : ContinuousOn kappaDerivSq Dnbhd := by
  intro K hK
  exact ((hasDerivAt_kappaDerivSq (pos_of_mem_Dnbhd hK)).continuousAt).continuousWithinAt

theorem differentiableOn_kappaDerivSq : DifferentiableOn ℝ kappaDerivSq (interior Dnbhd) := by
  intro K hK
  exact ((hasDerivAt_kappaDerivSq
    (pos_of_mem_Dnbhd (mem_Dnbhd_of_mem_interior hK))).differentiableAt).differentiableWithinAt

/-- **人手証明 `kappa_of_K_basic` (5) の第 2 式**: `|κ'(K)² - 16| ≤ 25.1 |κ(K)|`。 -/
theorem abs_kappaDerivSq_sub_le {K : ℝ} (hK : K ∈ Dnbhd) :
    |kappaDeriv K ^ 2 - 16| ≤ 25.1 * |kappaK K| := by
  have hb := Abstract.abs_sub_le_of_abs_deriv_le (D := Dnbhd) Dnbhd_convex
    (f := kappaDerivSq) (C := 88.2) continuousOn_kappaDerivSq differentiableOn_kappaDerivSq
    (fun x hx => by
      rw [(hasDerivAt_kappaDerivSq (pos_of_mem_Dnbhd (mem_Dnbhd_of_mem_interior hx))).deriv]
      exact abs_deriv_kappaDerivSq_le (mem_Dnbhd_of_mem_interior hx))
    Kc_mem_Dnbhd hK
  rw [kappaDerivSq_Kc] at hb
  have hlow := (abs_kappaK_bounds hK).1
  have : |K - Kc| ≤ |kappaK K| / 3.52 := by
    rw [le_div_iff₀ (by norm_num)]; linarith
  have hfin : (88.2 : ℝ) * |K - Kc| ≤ 25.1 * |kappaK K| := by
    have h2 : (88.2 : ℝ) * |K - Kc| ≤ 88.2 * (|kappaK K| / 3.52) := by
      exact mul_le_mul_of_nonneg_left this (by norm_num)
    have h3 : (88.2 : ℝ) * (|kappaK K| / 3.52) ≤ 25.1 * |kappaK K| := by
      have heq : (88.2 : ℝ) * (|kappaK K| / 3.52) = (88.2 / 3.52) * |kappaK K| := by ring
      rw [heq]
      exact mul_le_mul_of_nonneg_right (by norm_num) (abs_nonneg _)
    linarith
  simp only [kappaDerivSq] at hb
  linarith

end Ising2D
