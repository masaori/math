/-
# `|d²f/dK² - (8/π) log(1/|κ(K)|)| ≤ 45` — 比熱の対数発散（章 020 の到達点）

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_012_theorem_specific_heat_log_divergence`（ラベル `specific_heat_log_divergence`）

**具体版**（人手証明と同じ抽象度）。

## 本ファイルの 2 つの役割

1. **橋渡し**（人手証明 Step 1）。章 018 の `Ising2D.onsager_exact_solution`（および章 012 の
   `Ising2D.onsager_free_energy_expression`）が与える自由エネルギーは
   `1/2 log(2 sinh 2K_2) + (1/4π)∫_0^{2π} γ_P(θ) dθ` という**極限**の形をしている。
   等方な場合 `P = isoParam K`（`K_1 = K_2 = K`）にこれを適用すると、`isotropic_A_equals_one`
   （`Ising2D.gammaFn_isoParam`）より被積分関数が `Ising2D.gammaK θ (kappaK K)` に一致するので、
   積分項は章 020 の `Ising2D.Gfun (kappaK K)` そのものになる。これが
   `Ising2D.fFun K := 1/2 log(2 sinh 2K) + Gfun (kappaK K)` であり、
   `Ising2D.onsager_free_energy_isoParam` / `Ising2D.onsager_exact_solution_isoParam` が
   「`fFun` は確かに Onsager の自由エネルギーである」ことを述べる。
   **この橋渡しに追加の仮定は要らない**（`γ` の同一視は恒等式である）。

2. **本体**（人手証明 Step 2〜6）。`fFun` を `K` について 2 回微分し、
   `Ising2D.second_derivative_log_divergence`（章 020）と
   `Ising2D.kappa_of_K_basic` 系の評価（`Part020/Claim006_KappaOfK.lean`）から
   `|f''(K) - (8/π) log(1/|κ(K)|)| ≤ 45` を出す。

## 原文との差

各段の定数は `Claim006_KappaOfK.lean` / `Theorem011_...` と同じく、原文の外部数値
（`cosh 0.2 ≤ 1.02007` 等）を持ち込まずに導いた値を使う。そのため原文の
`3.70 + 4.60 + 15.44 + 19.2 = 42.94` に対し本形式化では
`3.74 + 4.65 + 15.75 + 19.2 = 43.34` となるが、**結論の定数 45 は原文のまま成立する**。
-/
import Ising2D.Part020.Claim006_KappaOfK
import Ising2D.Part020.Theorem011_SecondDerivativeLogDivergence
import Ising2D.Part018.Theorem010_OnsagerExactSolution

namespace Ising2D

open Real Filter MeasureTheory
open scoped Topology

/-! ## 1. 橋渡し（人手証明 Step 1）: 章 012・018 の `f` と章 020 の `G ∘ κ` の同一視 -/

/-- **人手証明 Step 1 の恒等式**: 等方な場合の `γ(θ)`（章 012 の `gammaFn`）は
章 020 の `γ(θ, κ(K))`（`gammaK`）に一致する。`isotropic_A_equals_one` そのもの。 -/
theorem gammaFn_isoParam_eq_gammaK (K : ℝ) (hK : 0 < K) (θ : ℝ) :
    gammaFn (isoParam K hK) θ = gammaK θ (kappaK K) := by
  rw [gammaFn_isoParam K hK θ]
  rfl

/-- **人手証明 Step 1**: 等方な場合、自由エネルギーの積分項は `G(κ(K))` に一致する。 -/
theorem integral_gammaFn_isoParam (K : ℝ) (hK : 0 < K) :
    1 / (4 * Real.pi) * ∫ θ in (0:ℝ)..(2 * Real.pi), gammaFn (isoParam K hK) θ
      = Gfun (kappaK K) := by
  simp only [Gfun, gammaFn_isoParam_eq_gammaK K hK]

/-- 人手証明の `f(K) := (1/2)log(2 sinh 2K) + G(κ(K))`。 -/
noncomputable def fFun (K : ℝ) : ℝ :=
  1 / 2 * Real.log (2 * Real.sinh (2 * K)) + Gfun (kappaK K)

/-- **人手証明 Step 1**（章 012 との橋渡し）:
`(1/M) log Λ^{(δ)}_M → f(K)`（等方な場合）。 -/
theorem onsager_free_energy_isoParam (K : ℝ) (hK : 0 < K) {δ : ℝ} (hδ0 : 0 ≤ δ) (hδ1 : δ < 1) :
    Tendsto (fun M : ℕ => 1 / (M : ℝ) * Real.log (LambdaM (isoParam K hK) δ M)) atTop
      (𝓝 (fFun K)) := by
  have h := onsager_free_energy_expression (isoParam K hK) hδ0 hδ1
  rwa [integral_gammaFn_isoParam K hK] at h

/-- **人手証明 Step 1**（章 018 の結論との橋渡し）:
Onsager の厳密解の自由エネルギーは、等方な場合ちょうど `f(K)` である。
仮定は `Ising2D.onsager_exact_solution` と同じ 3 つだけ。 -/
theorem onsager_exact_solution_isoParam (K : ℝ) (hK : 0 < K) {Z : ℕ → ℕ → ℝ} {cM : ℕ → ℝ}
    (hc : ∀ m : ℕ, 2 ≤ m → cM m = LambdaM (isoParam K hK) (1 / 2) m)
    (hZ1 : ∀ m : ℕ, 2 ≤ m → ∀ N, cM m ^ N ≤ Z m N)
    (hZ2 : ∀ m : ℕ, 2 ≤ m → ∀ N, Z m N ≤ 2 ^ m * cM m ^ N) :
    (∀ m : ℕ, 2 ≤ m →
        Tendsto (fun N : ℕ => 1 / ((m : ℝ) * N) * Real.log (Z m N)) atTop
          (𝓝 (1 / (m : ℝ) * Real.log (cM m))))
      ∧ Tendsto (fun m : ℕ => 1 / (m : ℝ) * Real.log (cM m)) atTop (𝓝 (fFun K)) := by
  have h := onsager_exact_solution (isoParam K hK) hc hZ1 hZ2
  rw [integral_gammaFn_isoParam K hK] at h
  exact h

/-! ## 2. `f` の 1 階・2 階導関数（人手証明 Step 2, 3） -/

/-- `f'(K) = cosh 2K/sinh 2K + G'(κ(K))κ'(K)`。 -/
noncomputable def fFirst (K : ℝ) : ℝ :=
  Real.cosh (2 * K) / Real.sinh (2 * K) + Gfirst (kappaK K) * kappaDeriv K

/-- `f''(K) = -2/sinh²2K + G''(κ(K))κ'(K)² + G'(κ(K))κ''(K)`。 -/
noncomputable def fSecond (K : ℝ) : ℝ :=
  -(2 / Real.sinh (2 * K) ^ 2)
    + (Gsecond (kappaK K) * kappaDeriv K ^ 2 + Gfirst (kappaK K) * kappaSecond K)

/-- **人手証明 Step 2**: `(1/2 log(2 sinh 2K))' = cosh 2K/sinh 2K`。 -/
theorem hasDerivAt_logTerm {K : ℝ} (hK : 0 < K) :
    HasDerivAt (fun x : ℝ => 1 / 2 * Real.log (2 * Real.sinh (2 * x)))
      (Real.cosh (2 * K) / Real.sinh (2 * K)) K := by
  have hs : 0 < Real.sinh (2 * K) := Real.sinh_pos_iff.2 (by linarith)
  have h2 : HasDerivAt (fun x : ℝ => 2 * x) 2 K := by
    simpa using (hasDerivAt_id K).const_mul (2 : ℝ)
  have hsin : HasDerivAt (fun x : ℝ => Real.sinh (2 * x)) (Real.cosh (2 * K) * 2) K := h2.sinh
  have hmul : HasDerivAt (fun x : ℝ => 2 * Real.sinh (2 * x))
      (2 * (Real.cosh (2 * K) * 2)) K := hsin.const_mul (2 : ℝ)
  have hlog := hmul.log (by positivity)
  have hres := hlog.const_mul (1 / 2 : ℝ)
  have hv : (1 / 2 : ℝ) * (2 * (Real.cosh (2 * K) * 2) / (2 * Real.sinh (2 * K)))
      = Real.cosh (2 * K) / Real.sinh (2 * K) := by
    field_simp
  rwa [hv] at hres

/-- **人手証明 Step 2**: `(cosh 2K/sinh 2K)' = -2/sinh²2K`。 -/
theorem hasDerivAt_logTermDeriv {K : ℝ} (hK : 0 < K) :
    HasDerivAt (fun x : ℝ => Real.cosh (2 * x) / Real.sinh (2 * x))
      (-(2 / Real.sinh (2 * K) ^ 2)) K := by
  have hs : 0 < Real.sinh (2 * K) := Real.sinh_pos_iff.2 (by linarith)
  have h2 : HasDerivAt (fun x : ℝ => 2 * x) 2 K := by
    simpa using (hasDerivAt_id K).const_mul (2 : ℝ)
  have hsin : HasDerivAt (fun x : ℝ => Real.sinh (2 * x)) (Real.cosh (2 * K) * 2) K := h2.sinh
  have hcos : HasDerivAt (fun x : ℝ => Real.cosh (2 * x)) (Real.sinh (2 * K) * 2) K := h2.cosh
  have hdiv := hcos.div hsin (ne_of_gt hs)
  have hv : (Real.sinh (2 * K) * 2 * Real.sinh (2 * K)
        - Real.cosh (2 * K) * (Real.cosh (2 * K) * 2)) / Real.sinh (2 * K) ^ 2
      = -(2 / Real.sinh (2 * K) ^ 2) := by
    have hid : Real.cosh (2 * K) ^ 2 - Real.sinh (2 * K) ^ 2 = 1 :=
      Real.cosh_sq_sub_sinh_sq (2 * K)
    field_simp
    nlinarith [hid]
  rwa [hv] at hdiv

/-- **人手証明 Step 3**: `f` は 1 回微分可能で `f' = fFirst`。 -/
theorem hasDerivAt_fFun {K : ℝ} (hK : 0 < K) (hκ : kappaK K ≠ 0) :
    HasDerivAt fFun (fFirst K) K := by
  have h1 := hasDerivAt_logTerm hK
  have h2 : HasDerivAt (fun x : ℝ => Gfun (kappaK x)) (Gfirst (kappaK K) * kappaDeriv K) K :=
    (hasDerivAt_Gfun hκ).comp K (hasDerivAt_kappaK hK)
  exact h1.add h2

/-- **人手証明 Step 3**（合成関数の 2 階微分）: `fFirst` は微分可能で `fFirst' = fSecond`。 -/
theorem hasDerivAt_fFirst {K : ℝ} (hK : 0 < K) (hκ : kappaK K ≠ 0) :
    HasDerivAt fFirst (fSecond K) K := by
  have h1 := hasDerivAt_logTermDeriv hK
  have h2 : HasDerivAt (fun x : ℝ => Gfirst (kappaK x)) (Gsecond (kappaK K) * kappaDeriv K) K :=
    (hasDerivAt_Gfirst hκ).comp K (hasDerivAt_kappaK hK)
  have h3 := h2.mul (hasDerivAt_kappaDeriv hK)
  have hv : Gsecond (kappaK K) * kappaDeriv K * kappaDeriv K
      + Gfirst (kappaK K) * kappaSecond K
      = Gsecond (kappaK K) * kappaDeriv K ^ 2 + Gfirst (kappaK K) * kappaSecond K := by ring
  rw [hv] at h3
  exact h1.add h3

/-- `K ≠ K_c` かつ `K > 0` なら、その近傍で `f' = fFirst` が成り立つ。 -/
theorem eventually_hasDerivAt_fFun {K : ℝ} (hK : 0 < K) (hKc : K ≠ Kc) :
    ∀ᶠ x in 𝓝 K, HasDerivAt fFun (fFirst x) x := by
  have hpos : ∀ᶠ x in 𝓝 K, (0:ℝ) < x :=
    (isOpen_lt continuous_const continuous_id).mem_nhds hK
  have hne : ∀ᶠ x in 𝓝 K, x ≠ Kc := (isOpen_ne (x := Kc)).mem_nhds hKc
  filter_upwards [hpos, hne] with x hx hxc
  exact hasDerivAt_fFun hx (fun h => hxc ((kappaK_eq_zero_iff hx).1 h))

/-- **人手証明 Step 3**: `d²f/dK²` が存在して `fSecond` に等しい。 -/
theorem hasDerivAt_deriv_fFun {K : ℝ} (hK : 0 < K) (hKc : K ≠ Kc) :
    HasDerivAt (deriv fFun) (fSecond K) K := by
  have hκ : kappaK K ≠ 0 := fun h => hKc ((kappaK_eq_zero_iff hK).1 h)
  have heq : deriv fFun =ᶠ[𝓝 K] fFirst := by
    filter_upwards [eventually_hasDerivAt_fFun hK hKc] with x hx
    exact hx.deriv
  exact (hasDerivAt_fFirst hK hκ).congr_of_eventuallyEq heq

theorem deriv_deriv_fFun {K : ℝ} (hK : 0 < K) (hKc : K ≠ Kc) :
    deriv (deriv fFun) K = fSecond K := (hasDerivAt_deriv_fFun hK hKc).deriv

/-! ## 3. 各項の評価（人手証明 Step 2, 3, 4, 5） -/

/-- **人手証明 Step 2**: `|(1/2 log(2 sinh 2K))''| ≤ 3.74`（原文は `3.70`）。 -/
theorem abs_logTerm_second_le {K : ℝ} (hK : K ∈ Dnbhd) :
    |(-(2 / Real.sinh (2 * K) ^ 2))| ≤ 3.74 := by
  obtain ⟨hl, _⟩ := sinh_two_K_bounds hK
  have hs : 0 < Real.sinh (2 * K) := by linarith
  rw [abs_neg, abs_of_nonneg (by positivity)]
  rw [div_le_iff₀ (by positivity)]
  nlinarith [hl, hs]

/-- **人手証明 Step 3**: `|G'(κ)κ''| ≤ 4.65`（原文は `4.60`）。 -/
theorem abs_Gfirst_mul_kappaSecond_le {K : ℝ} (hK : K ∈ Dnbhd) (hκ : kappaK K ≠ 0) :
    |Gfirst (kappaK K) * kappaSecond K| ≤ 4.65 := by
  rw [abs_mul]
  have h1 := abs_Gfirst_le hκ
  have h2 := abs_kappaSecond_le hK
  nlinarith [abs_nonneg (Gfirst (kappaK K)), abs_nonneg (kappaSecond K), h1, h2]

/-- `|G''(κ)| ≤ (1/2π)log(1/|κ|) + 6/5`（`second_derivative_log_divergence` の系）。 -/
theorem abs_Gsecond_le {κ : ℝ} (h0 : κ ≠ 0) (h1 : |κ| ≤ 1/2) :
    |Gsecond κ| ≤ (1 / (2 * Real.pi)) * Real.log (1 / |κ|) + 6/5 := by
  have h := abs_le.1 (second_derivative_log_divergence h0 h1)
  have hkpos : 0 < |κ| := abs_pos.2 h0
  have hL0 : 0 ≤ Real.log (1 / |κ|) := by
    apply Real.log_nonneg
    rw [le_div_iff₀ hkpos]; linarith
  have hterm : 0 ≤ (1 / (2 * Real.pi)) * Real.log (1 / |κ|) :=
    mul_nonneg (by positivity) hL0
  rw [abs_le]
  constructor <;> linarith [h.1, h.2]

/-- **人手証明 Step 4**: `|(κ'² - 16)G''(κ)| ≤ 15.75`（原文は `15.44`）。 -/
theorem abs_kappaDerivSq_sub_mul_Gsecond_le {K : ℝ} (hK : K ∈ Dnbhd) (hκ : kappaK K ≠ 0) :
    |(kappaDeriv K ^ 2 - 16) * Gsecond (kappaK K)| ≤ 15.75 := by
  have hbnd := abs_kappaK_bounds hK
  have hka : |kappaK K| ≤ 0.474 := hbnd.2.2
  have hkpos : 0 < |kappaK K| := abs_pos.2 hκ
  have hhalf : |kappaK K| ≤ 1/2 := by linarith
  set L : ℝ := Real.log (1 / |kappaK K|) with hLdef
  have hL0 : 0 ≤ L := by
    rw [hLdef]
    apply Real.log_nonneg
    rw [le_div_iff₀ hkpos]; linarith
  -- |κ| log(1/|κ|) ≤ 1/e ≤ 0.36788
  have hexp : (Real.exp 1)⁻¹ ≤ 0.36788 := by
    have h := Real.exp_one_gt_d9
    have hp : (0:ℝ) < Real.exp 1 := Real.exp_pos 1
    rw [inv_le_comm₀ hp (by norm_num)]
    linarith
  have hkL : |kappaK K| * L ≤ 0.36788 := by
    have h := Abstract.mul_log_inv_le hkpos
    rw [hLdef, one_div]
    linarith [h, hexp]
  have hinv2pi : 1 / (2 * Real.pi) ≤ 0.1592 := by
    have hpil : (3.141592:ℝ) < Real.pi := Real.pi_gt_d6
    rw [div_le_iff₀ (by positivity)]
    nlinarith [hpil]
  have hGa := abs_Gsecond_le hκ hhalf
  rw [← hLdef] at hGa
  have hq := abs_kappaDerivSq_sub_le hK
  rw [abs_mul]
  have hstep : |kappaDeriv K ^ 2 - 16| * |Gsecond (kappaK K)|
      ≤ (25.1 * |kappaK K|) * ((1 / (2 * Real.pi)) * L + 6/5) :=
    mul_le_mul hq hGa (abs_nonneg _) (by positivity)
  have hprod : (1 / (2 * Real.pi)) * (|kappaK K| * L) ≤ 0.1592 * 0.36788 :=
    mul_le_mul hinv2pi hkL (mul_nonneg (abs_nonneg _) hL0) (by norm_num)
  have hexpand : (25.1 * |kappaK K|) * ((1 / (2 * Real.pi)) * L + 6/5)
      = 25.1 * ((1 / (2 * Real.pi)) * (|kappaK K| * L)) + 30.12 * |kappaK K| := by ring
  rw [hexpand] at hstep
  nlinarith [hstep, hprod, hka]

/-- **人手証明 Step 5**: `|16 G''(κ) - (8/π)log(1/|κ|)| ≤ 19.2`。 -/
theorem abs_sixteen_Gsecond_sub_le {κ : ℝ} (h0 : κ ≠ 0) (h1 : |κ| ≤ 1/2) :
    |16 * (Gsecond κ - (1 / (2 * Real.pi)) * Real.log (1 / |κ|))| ≤ 19.2 := by
  rw [abs_mul, abs_of_nonneg (by norm_num : (0:ℝ) ≤ 16)]
  have h := second_derivative_log_divergence h0 h1
  linarith [h]

/-! ## 4. 総合（人手証明 Step 6） -/

/-- **人手証明 `specific_heat_log_divergence` の中心の評価**:
`|f''(K) - (8/π)log(1/|κ(K)|)| ≤ 45`。 -/
theorem abs_fSecond_sub_le {K : ℝ} (hK : K ∈ Dnbhd) (hKc : K ≠ Kc) :
    |fSecond K - (8 / Real.pi) * Real.log (1 / |kappaK K|)| ≤ 45 := by
  have hKpos : 0 < K := pos_of_mem_Dnbhd hK
  have hκ : kappaK K ≠ 0 := fun h => hKc ((kappaK_eq_zero_iff hKpos).1 h)
  have hka : |kappaK K| ≤ 0.474 := (abs_kappaK_bounds hK).2.2
  have hhalf : |kappaK K| ≤ 1/2 := by linarith
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have hpiq : (8:ℝ) / Real.pi = 16 * (1 / (2 * Real.pi)) := by field_simp; ring
  set a1 : ℝ := -(2 / Real.sinh (2 * K) ^ 2) with ha1
  set a2 : ℝ := Gfirst (kappaK K) * kappaSecond K with ha2
  set a3 : ℝ := (kappaDeriv K ^ 2 - 16) * Gsecond (kappaK K) with ha3
  set a4 : ℝ := 16 * (Gsecond (kappaK K)
    - (1 / (2 * Real.pi)) * Real.log (1 / |kappaK K|)) with ha4
  have hdec : fSecond K - (8 / Real.pi) * Real.log (1 / |kappaK K|)
      = a1 + a2 + a3 + a4 := by
    rw [hpiq, fSecond, ha1, ha2, ha3, ha4]; ring
  rw [hdec]
  have h1 := abs_logTerm_second_le hK
  have h2 := abs_Gfirst_mul_kappaSecond_le hK hκ
  have h3 := abs_kappaDerivSq_sub_mul_Gsecond_le hK hκ
  have h4 := abs_sixteen_Gsecond_sub_le hκ hhalf
  rw [← ha1] at h1
  rw [← ha2] at h2
  rw [← ha3] at h3
  rw [← ha4] at h4
  calc |a1 + a2 + a3 + a4| ≤ |a1 + a2 + a3| + |a4| := abs_add_le _ _
    _ ≤ (|a1 + a2| + |a3|) + |a4| := by linarith [abs_add_le (a1 + a2) a3]
    _ ≤ ((|a1| + |a2|) + |a3|) + |a4| := by linarith [abs_add_le a1 a2]
    _ ≤ ((3.74 + 4.65) + 15.75) + 19.2 := by linarith
    _ ≤ 45 := by norm_num

/-- **人手証明 `specific_heat_log_divergence` そのもの**:
`0 < |K - K_c| ≤ 1/10` なる `K` について `f` は 2 回微分可能で

  `|d²f/dK²(K) - (8/π) log(1/|κ(K)|)| ≤ 45`。

`f` は `Ising2D.fFun`（= Onsager の自由エネルギー、`Ising2D.onsager_exact_solution_isoParam`）。 -/
theorem specific_heat_log_divergence {K : ℝ} (hK : K ∈ Dnbhd) (hKc : K ≠ Kc) :
    HasDerivAt (deriv fFun) (fSecond K) K
      ∧ deriv (deriv fFun) K = fSecond K
      ∧ |deriv (deriv fFun) K - (8 / Real.pi) * Real.log (1 / |kappaK K|)| ≤ 45 := by
  have hKpos : 0 < K := pos_of_mem_Dnbhd hK
  refine ⟨hasDerivAt_deriv_fFun hKpos hKc, deriv_deriv_fFun hKpos hKc, ?_⟩
  rw [deriv_deriv_fFun hKpos hKc]
  exact abs_fSecond_sub_le hK hKc

/-- **人手証明 `specific_heat_log_divergence` の帰結（下からの発散）**:
`d²f/dK² ≥ (8/π)log(1/|κ(K)|) - 45`。`K → K_c` で `|κ(K)| → 0` なので右辺は `+∞` に発散する。 -/
theorem fSecond_ge {K : ℝ} (hK : K ∈ Dnbhd) (hKc : K ≠ Kc) :
    (8 / Real.pi) * Real.log (1 / |kappaK K|) - 45 ≤ deriv (deriv fFun) K := by
  have h := (specific_heat_log_divergence hK hKc).2.2
  linarith [(abs_le.1 h).1]

/-! ## 5. `|K - K_c|` による表示（人手証明 Step 7）と極限（Step 8） -/

/-- `log 4.74 ≤ 1.5636`（外部の数値を持ち込まず `log 2` と `log y ≤ y - 1` だけから）。 -/
theorem log_474_le : Real.log 4.74 ≤ 1.5636 := by
  have hfac : (4.74 : ℝ) = 4 * (11/10) * (237/220) := by norm_num
  have h4 : Real.log (4:ℝ) = 2 * Real.log 2 := by
    rw [show (4:ℝ) = 2 ^ 2 by norm_num, Real.log_pow]
    push_cast; ring
  have hsplit : Real.log (4.74 : ℝ)
      = Real.log 4 + Real.log (11/10) + Real.log (237/220) := by
    rw [hfac, Real.log_mul (by norm_num) (by norm_num), Real.log_mul (by norm_num) (by norm_num)]
  have h1 : Real.log ((11:ℝ)/10) ≤ 1/10 := by
    have := Real.log_le_sub_one_of_pos (show (0:ℝ) < 11/10 by norm_num)
    linarith
  have h2 : Real.log ((237:ℝ)/220) ≤ 17/220 := by
    have := Real.log_le_sub_one_of_pos (show (0:ℝ) < 237/220 by norm_num)
    linarith
  have hlog2 : Real.log 2 < 0.6931471808 := Real.log_two_lt_d9
  rw [hsplit, h4]
  linarith

/-- **人手証明 Step 7 の各点評価**: `|log(1/|κ(K)|) - log(1/|K-K_c|)| ≤ 1.5636`。 -/
theorem abs_log_kappa_sub_log_dist_le {K : ℝ} (hK : K ∈ Dnbhd) (hKc : K ≠ Kc) :
    |Real.log (1 / |kappaK K|) - Real.log (1 / |K - Kc|)| ≤ 1.5636 := by
  have ht : 0 < |K - Kc| := abs_pos.2 (sub_ne_zero.2 hKc)
  obtain ⟨hlo, hhi, -⟩ := abs_kappaK_bounds hK
  have hkpos : 0 < |kappaK K| := by nlinarith [ht, hlo]
  have hratio : Real.log (1 / |kappaK K|) - Real.log (1 / |K - Kc|)
      = -Real.log (|kappaK K| / |K - Kc|) := by
    rw [Real.log_div (ne_of_gt hkpos) (ne_of_gt ht), Real.log_div one_ne_zero (ne_of_gt hkpos),
      Real.log_div one_ne_zero (ne_of_gt ht), Real.log_one]
    ring
  rw [hratio, abs_neg]
  have hq1 : (3.52:ℝ) ≤ |kappaK K| / |K - Kc| := by rw [le_div_iff₀ ht]; linarith
  have hq2 : |kappaK K| / |K - Kc| ≤ 4.74 := by rw [div_le_iff₀ ht]; linarith
  have hlb : (0:ℝ) ≤ Real.log (|kappaK K| / |K - Kc|) :=
    Real.log_nonneg (by linarith)
  have hub : Real.log (|kappaK K| / |K - Kc|) ≤ 1.5636 :=
    le_trans (Real.log_le_log (by linarith) hq2) log_474_le
  rw [abs_of_nonneg hlb]
  exact hub

/-- **人手証明 Step 7**: `|d²f/dK²(K) - (8/π)log(1/|K-K_c|)| ≤ 49`。 -/
theorem specific_heat_log_divergence_dist {K : ℝ} (hK : K ∈ Dnbhd) (hKc : K ≠ Kc) :
    |deriv (deriv fFun) K - (8 / Real.pi) * Real.log (1 / |K - Kc|)| ≤ 49 := by
  have hpil : (3.141592:ℝ) < Real.pi := Real.pi_gt_d6
  have hpi : (0:ℝ) < Real.pi := Real.pi_pos
  have h45 := (specific_heat_log_divergence hK hKc).2.2
  have hlog := abs_log_kappa_sub_log_dist_le hK hKc
  have hcoef : (8:ℝ) / Real.pi ≤ 2.5465 := by
    rw [div_le_iff₀ hpi]; nlinarith [hpil]
  have hcoefnn : (0:ℝ) ≤ 8 / Real.pi := by positivity
  have hmid : |(8 / Real.pi) * Real.log (1 / |kappaK K|)
      - (8 / Real.pi) * Real.log (1 / |K - Kc|)| ≤ 3.9821 := by
    rw [show (8 / Real.pi) * Real.log (1 / |kappaK K|)
        - (8 / Real.pi) * Real.log (1 / |K - Kc|)
        = (8 / Real.pi) * (Real.log (1 / |kappaK K|) - Real.log (1 / |K - Kc|)) by ring,
      abs_mul, abs_of_nonneg hcoefnn]
    nlinarith [hlog, hcoef, hcoefnn, abs_nonneg (Real.log (1 / |kappaK K|)
      - Real.log (1 / |K - Kc|))]
  calc |deriv (deriv fFun) K - (8 / Real.pi) * Real.log (1 / |K - Kc|)|
      ≤ |deriv (deriv fFun) K - (8 / Real.pi) * Real.log (1 / |kappaK K|)|
        + |(8 / Real.pi) * Real.log (1 / |kappaK K|)
          - (8 / Real.pi) * Real.log (1 / |K - Kc|)| := by
        have := abs_add_le (deriv (deriv fFun) K - (8 / Real.pi) * Real.log (1 / |kappaK K|))
          ((8 / Real.pi) * Real.log (1 / |kappaK K|)
            - (8 / Real.pi) * Real.log (1 / |K - Kc|))
        simpa using this
    _ ≤ 45 + 3.9821 := by linarith
    _ ≤ 49 := by norm_num

/-- `K → K_c`（`K ≠ K_c`）のとき `log(1/|K-K_c|) → +∞`。 -/
theorem tendsto_log_inv_dist_atTop :
    Tendsto (fun K : ℝ => Real.log (1 / |K - Kc|)) (𝓝[≠] Kc) atTop := by
  have habs : Tendsto (fun K : ℝ => |K - Kc|) (𝓝[≠] Kc) (𝓝[>] 0) := by
    rw [tendsto_nhdsWithin_iff]
    constructor
    · have hs : Tendsto (fun K : ℝ => K - Kc) (𝓝 Kc) (𝓝 0) := by
        have h := (Filter.tendsto_id (x := 𝓝 Kc)).sub
          (tendsto_const_nhds (x := Kc) (f := 𝓝 Kc))
        simpa using h
      have h2 : Tendsto (fun K : ℝ => K - Kc) (𝓝[≠] Kc) (𝓝 0) :=
        hs.mono_left (nhdsWithin_le_nhds (s := {Kc}ᶜ))
      simpa using h2.abs
    · filter_upwards [self_mem_nhdsWithin] with K hK
      exact abs_pos.2 (sub_ne_zero.2 hK)
  have hinv : Tendsto (fun x : ℝ => 1 / x) (𝓝[>] (0:ℝ)) atTop := by
    simpa [one_div] using tendsto_inv_nhdsGT_zero
  exact Real.tendsto_log_atTop.comp (hinv.comp habs)

/-- **人手証明 Step 8**（対数発散の係数）:

  `lim_{K → K_c} (d²f/dK²)(K) / log(1/|K-K_c|) = 8/π`。

台は `D \ {K_c}`（`D = [K_c - 1/10, K_c + 1/10]`）に制限する。 -/
theorem specific_heat_ratio_tendsto :
    Tendsto (fun K : ℝ => deriv (deriv fFun) K / Real.log (1 / |K - Kc|))
      (𝓝[Dnbhd \ {Kc}] Kc) (𝓝 (8 / Real.pi)) := by
  have hsub : 𝓝[Dnbhd \ {Kc}] Kc ≤ 𝓝[≠] Kc :=
    nhdsWithin_mono _ (fun x hx => hx.2)
  have hlog : Tendsto (fun K : ℝ => Real.log (1 / |K - Kc|)) (𝓝[Dnbhd \ {Kc}] Kc) atTop :=
    tendsto_log_inv_dist_atTop.mono_left hsub
  -- |ratio - 8/π| ≤ 49 / log(1/|K-K_c|)（log > 0 の範囲で）
  have hbound : ∀ᶠ K in 𝓝[Dnbhd \ {Kc}] Kc,
      |deriv (deriv fFun) K / Real.log (1 / |K - Kc|) - 8 / Real.pi|
        ≤ 49 / Real.log (1 / |K - Kc|) := by
    filter_upwards [self_mem_nhdsWithin, hlog.eventually_gt_atTop 0] with K hK hpos
    have hKD : K ∈ Dnbhd := hK.1
    have hKc : K ≠ Kc := hK.2
    have h49 := specific_heat_log_divergence_dist hKD hKc
    set L : ℝ := Real.log (1 / |K - Kc|) with hL
    have hdiff : deriv (deriv fFun) K / L - 8 / Real.pi
        = (deriv (deriv fFun) K - (8 / Real.pi) * L) / L := by
      field_simp
    rw [hdiff, abs_div, abs_of_pos hpos]
    gcongr
  have hzero : Tendsto (fun K : ℝ => (49:ℝ) / Real.log (1 / |K - Kc|))
      (𝓝[Dnbhd \ {Kc}] Kc) (𝓝 0) := by
    have h0 : Tendsto (fun K : ℝ => (Real.log (1 / |K - Kc|))⁻¹)
        (𝓝[Dnbhd \ {Kc}] Kc) (𝓝 0) := hlog.inv_tendsto_atTop
    have h1 := h0.const_mul (49:ℝ)
    rw [mul_zero] at h1
    exact h1.congr (fun K => (div_eq_mul_inv (49:ℝ) _).symm)
  rw [← tendsto_sub_nhds_zero_iff]
  exact squeeze_zero_norm' (by simpa [Real.norm_eq_abs] using hbound) hzero

end Ising2D
