/-
# `κ(K)` の基本性質と臨界点 `K_c`

人手証明（正本は `structured-latex/content/critical_point_and_log_divergence.ts`）:
- `critical_006_claim_kappa_of_K_basic`（ラベル `kappa_of_K_basic`）

**具体版**（人手証明と同じ抽象度）。必要十分版は
`Ising2D/NecSuf/MeanValueTwoSided.lean`（(5) の増分評価）と
`Ising2D/NecSuf/HyperbolicBounds.lean`（数値評価に使う `cosh` の上下界）。
(5) の具体版 `abs_kappaK_bounds`・`abs_kappaDerivSq_sub_le` は人手の (R3)(R4) の鎖どおりに書き、
`MeanValueTwoSided.lean` を使わない。その特殊化としての導出は `ClaimKappaOfKBasicFromNecSuf.lean` にある。

## 人手証明の数値評価との差（重要）

原文 (4)(5) は `cosh 0.2 ≤ 1.02007` のような**具体的な数値評価を外から持ち込んでいる**
（原文自身が `remark_real_analysis_escape_chapter_E` の末尾でそう宣言している）。
本形式化では**外から数値を持ち込まず**、`Ising2D.NecSuf.cosh_le_inv_one_sub_sq_div_two`
（`cosh t ≤ (1-t²/2)⁻¹`、mathlib の `Real.cosh_le_exp_half_sq` から出る）と
`Ising2D.NecSuf.one_add_sq_div_two_le_cosh` だけで評価する。
そのぶん定数はわずかに悪くなる（原文の値 → 本形式化の値）:

| 量 | 原文 | 本形式化 |
| --- | --- | --- |
| `sinh 2K` の下界 | `0.7353` | `0.7313` |
| `sinh 2K` の上界 | `1.3048` | `1.3091` |
| `κ'` の範囲 | `[3.53, 4.72]` | `[3.52, 4.74]` |
| `cosh(2K_c − 1/5)` の上界 | `1.2413` | `1.2431` |
| `\|κ''\|` の上界 | `9.19` | `9.3` |
| `\|(κ'²)'\|` の上界 | `87` | `88.2` |
| `\|κ'²-16\|/\|κ\|` | `24.7` | `25.1` |

**この差は `second_derivative_log_divergence` の結論の定数 `6/5` を変えない**ことを
`TheoremSecondDerivativeLogDivergence.lean` で確認してある。

`|κ''|` の上界は原文どおり、`h(t) = cosh t/sinh² t` の導関数が負であることと
(R3)(R4)（区間積分の単調性と微分積分学の基本定理）から `h` の単調減少を出し、
`cosh(2K_c − 1/5)` を加法定理で評価して得る（`hCoshOverSinhSq_antitone`・`cosh_two_Kc_sub_fifth_le`・`abs_kappaSecond_le`）。
-/
import Ising2D.CriticalPoint.CriticalPointAndLogDivergence.DefinitionKappaAndCritical
import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshSinhBasicProperties

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
  · have := NecSuf.one_add_sq_div_two_le_cosh (0.2 : ℝ)
    norm_num at this ⊢
    linarith
  · have := NecSuf.cosh_le_inv_one_sub_sq_div_two (t := (0.2 : ℝ)) (by norm_num)
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
    rw [cosh_sq_eq_one_add_sinh_sq, sinh_two_Kc]; norm_num
  have hpos : 0 < Real.cosh (2 * Kc) := cosh_pos_of_two_cosh_pos _
  have h := congrArg Real.sqrt hsq
  rwa [Real.sqrt_sq hpos.le] at h

theorem Kc_gt_tenth : (1:ℝ)/10 < Kc := by
  have h1 : Real.sinh (0.2 : ℝ) < Real.sinh (2 * Kc) := by
    rw [sinh_two_Kc]
    linarith [sinh_02_bounds.2]
  -- `2K_c ≤ 0.2` なら `sinh_strictly_increasing`（等号のときは等しい。`sinh_le_sinh_of_le`）で `sinh 2K_c ≤ sinh 0.2` となり `h1` に反する
  -- （この補題は Lean にだけある。人手の `K_c > 0` の背理法とは別の経路）
  have h2 : (0.2 : ℝ) < 2 * Kc := lt_of_not_ge fun hle => absurd h1 (not_lt.mpr (sinh_le_sinh_of_le hle))
  linarith

theorem Kc_pos : 0 < Kc := by linarith [Kc_gt_tenth]

/-! ## `κ(K)` の微分 -/

/-- `κ'(K) = 2 + 2/sinh 2K`（原文 (1)）。 -/
noncomputable def kappaDeriv (K : ℝ) : ℝ := 2 + 2 / Real.sinh (2 * K)

/-- `κ''(K) = -4 cosh 2K / sinh² 2K`（原文 (3)）。 -/
noncomputable def kappaSecond (K : ℝ) : ℝ :=
  -(4 * Real.cosh (2 * K)) / Real.sinh (2 * K) ^ 2

/-- 人手 `kappa_of_K_basic` (1) の証明の `(tanh)' = 1/cosh²`。`tanh = sinh/cosh` の商の微分。 -/
theorem hasDerivAt_tanh_real (K : ℝ) : HasDerivAt Real.tanh (1 / Real.cosh K ^ 2) K := by
  have hc : Real.cosh K ≠ 0 := ne_of_gt (cosh_pos_of_two_cosh_pos K)
  have hfun : Real.tanh = Real.sinh / Real.cosh := by
    funext x; exact Real.tanh_eq_sinh_div_cosh x
  have h := (Real.hasDerivAt_sinh K).div (Real.hasDerivAt_cosh K) hc
  -- `cosh² K - sinh² K = 1`
  have hv : (Real.cosh K * Real.cosh K - Real.sinh K * Real.sinh K) / Real.cosh K ^ 2
      = 1 / Real.cosh K ^ 2 := by
    rw [← cosh_sinh_basic_properties_2 K]; ring
  rw [hfun, ← hv]
  exact h

/-- 人手 `kappa_of_K_basic` (1) の証明の `dK^*/dK = -1/sinh 2K`（`K > 0`）。
`K^* = -(1/2) log(tanh K)`（`def_second_dual_coupling_constant`）を、`log` の微分と合成関数の微分、
`(tanh)' = 1/cosh²`、倍角公式 `sinh_double_angle_formula`（具体版 `sinh_eq_two_sinh_half_mul_cosh_half`）の順に使って微分する。 -/
theorem hasDerivAt_Kstar {K : ℝ} (hK : 0 < K) :
    HasDerivAt Kstar (-(1 / Real.sinh (2 * K))) K := by
  have ht : 0 < Real.tanh K := tanh_pos hK
  have hs : 0 < Real.sinh K := real_sinh_pos_of_pos hK
  have hc : 0 < Real.cosh K := cosh_pos_of_two_cosh_pos K
  -- `log` の微分と合成関数の微分
  have h := (HasDerivAt.log (hasDerivAt_tanh_real K) (ne_of_gt ht)).const_mul (-(1 / 2 : ℝ))
  have hfun : Kstar = fun x => -(1 / 2) * Real.log (Real.tanh x) := by
    funext x; rfl
  -- `tanh = sinh/cosh` と倍角公式、`ℝ` の四則
  have hv : -(1 / 2 : ℝ) * (1 / Real.cosh K ^ 2 / Real.tanh K) = -(1 / Real.sinh (2 * K)) :=
    calc -(1 / 2 : ℝ) * (1 / Real.cosh K ^ 2 / Real.tanh K)
        = -(1 / 2 : ℝ) * (Real.cosh K / Real.sinh K) * (1 / Real.cosh K ^ 2) := by
          -- `1/tanh = cosh/sinh`
          rw [Real.tanh_eq_sinh_div_cosh]; field_simp
      _ = -(1 / (2 * Real.sinh K * Real.cosh K)) := by
          -- `ℝ` の四則
          field_simp
      _ = -(1 / Real.sinh (2 * K)) := by
          -- `sinh_double_angle_formula` を `x = 2K` で。続く `2K/2 = K` の書き換えは、人手のこの行が根拠を書いていない段
          rw [sinh_eq_two_sinh_half_mul_cosh_half (2 * K), mul_div_cancel_left₀ K two_ne_zero]
  rw [hfun, ← hv]
  exact h

/-- **人手証明 `kappa_of_K_basic` (1)**: `κ'(K) = 2 - 2 dK^*/dK = 2 + 2/sinh 2K`。 -/
theorem hasDerivAt_kappaK {K : ℝ} (hK : 0 < K) : HasDerivAt kappaK (kappaDeriv K) K := by
  have h2 : HasDerivAt (fun x : ℝ => 2 * x) 2 K := by
    simpa using (hasDerivAt_id K).const_mul (2 : ℝ)
  have hres := h2.sub ((hasDerivAt_Kstar hK).const_mul 2)
  have hv : (2 : ℝ) - 2 * -(1 / Real.sinh (2 * K)) = kappaDeriv K := by
    simp only [kappaDeriv]; ring
  rw [hv] at hres
  have hfun : kappaK = fun x : ℝ => 2 * x - 2 * Kstar x := rfl
  rw [hfun]
  exact hres

/-- **人手証明 `kappa_of_K_basic` (3)**: `κ''(K) = -4 cosh 2K/sinh² 2K`。 -/
theorem hasDerivAt_kappaDeriv {K : ℝ} (hK : 0 < K) :
    HasDerivAt kappaDeriv (kappaSecond K) K := by
  have hs : 0 < Real.sinh (2 * K) := real_sinh_pos_of_pos (by linarith)
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

/-- **人手証明 `kappa_of_K_basic` (2)**: `κ(K_c) = 0`。
`sinh 2K_c = 1` から `s_1 s_2 = sinh² 2K_c = 1` で、`critical_point_iff_kappa_zero` の (1) ⟹ (3)。 -/
theorem kappaK_Kc : kappaK Kc = 0 := by
  have h1 : Real.sinh (2 * Kc) * Real.sinh (2 * Kc) = 1 := by
    rw [sinh_two_Kc]; norm_num
  have hcrit := critical_point_iff_kappa_zero Kc_pos Kc_pos
  exact hcrit.2.1 (hcrit.1.1 h1)

/-- **人手証明 `kappa_of_K_basic` (2)**: `κ(K) = 0 ⟺ K = K_c`（`K > 0`）。
`κ(K) = 0` なら `critical_point_iff_kappa_zero` の (3) ⟹ (1) で `sinh² 2K = 1`、
`sinh 2K > 0` より `sinh 2K = 1 = sinh 2K_c`、`sinh` の単射性で `K = K_c`。 -/
theorem kappaK_eq_zero_iff {K : ℝ} (hK : 0 < K) : kappaK K = 0 ↔ K = Kc := by
  constructor
  · intro h
    have hcrit := critical_point_iff_kappa_zero hK hK
    have h1 : Real.sinh (2 * K) * Real.sinh (2 * K) = 1 := hcrit.1.2 (hcrit.2.2 h)
    have hs : 0 < Real.sinh (2 * K) := real_sinh_pos_of_pos (by linarith)
    have h3 : Real.sinh (2 * K) = 1 := by nlinarith [h1, hs]
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

/-- 人手 `kappa_of_K_basic` (4) の端点の式の複号 `−`: `sinh(2K_c − 1/5) = cosh(1/5) − √2 sinh(1/5)`。
人手の鎖の 1 行目（`sinh_addition_formula` の複号 −）が `sinh_sub_formula`、
2 行目（`K_c` の定義と `cosh 2K_c = √2`）が `sinh_two_Kc`・`cosh_two_Kc` と `ring`（`1·a = a`）。 -/
theorem sinh_two_Kc_sub_fifth :
    Real.sinh (2 * Kc - 0.2) = Real.cosh 0.2 - Real.sqrt 2 * Real.sinh 0.2 := by
  rw [sinh_sub_formula, sinh_two_Kc, cosh_two_Kc]; ring

/-- 人手 `kappa_of_K_basic` (4) の「一つ目の鎖の 2 行目以降は `K` に依らないので
`sinh(2K_c − 1/5) ≥ 0.7353` でもある」（本形式化の定数は `0.7313`）。 -/
theorem sinh_two_Kc_sub_fifth_ge : (0.7313 : ℝ) ≤ Real.sinh (2 * Kc - 0.2) := by
  have hs2 := sqrt_two_bounds
  have hc02 := cosh_02_bounds
  have hs02 := sinh_02_bounds
  have hspos : (0 : ℝ) < Real.sinh 0.2 := by linarith [hs02.1]
  calc Real.sinh (2 * Kc - 0.2)
      = Real.cosh 0.2 - Real.sqrt 2 * Real.sinh 0.2 :=
        -- 上の端点の式の複号 −
        sinh_two_Kc_sub_fifth
    _ ≥ 1.02 - Real.sqrt 2 * Real.sinh 0.2 := by
        -- `cosh(1/5) ≥ 1.02`
        linarith [hc02.1]
    _ ≥ 1.02 - 1.4142136 * Real.sinh 0.2 := by
        -- `√2 ≤ 1.4142136` と `sinh(1/5) > 0`
        have := mul_le_mul_of_nonneg_right hs2.2 hspos.le
        linarith
    _ ≥ 1.02 - 1.4142136 * 0.2040817 := by
        -- `sinh(1/5) ≤ 0.2040817`
        have := mul_le_mul_of_nonneg_left hs02.2 (by norm_num : (0 : ℝ) ≤ 1.4142136)
        linarith
    _ ≥ 0.7313 := by
        -- `ℚ` の四則と大小
        norm_num

/-- 人手 `kappa_of_K_basic` (4) の「同じ理由で `2K_c − 1/5 > 0`」。
`2K_c − 1/5 ≤ 0` なら `sinh_strictly_increasing`（等号のときは等しい。`sinh_le_sinh_of_le`）と
`sinh_zero`（Lean では mathlib の `Real.sinh_zero`）で `sinh(2K_c − 1/5) ≤ 0 < 0.7313` となり、
`sinh_two_Kc_sub_fifth_ge` に反する。 -/
theorem two_Kc_sub_fifth_pos : (0 : ℝ) < 2 * Kc - 0.2 := by
  refine lt_of_not_ge fun hle => ?_
  have h1 : Real.sinh (2 * Kc - 0.2) ≤ Real.sinh 0 := sinh_le_sinh_of_le hle
  rw [Real.sinh_zero] at h1
  linarith [sinh_two_Kc_sub_fifth_ge]

/-- **人手証明 `kappa_of_K_basic` (4)**: `0.7313 ≤ sinh 2K ≤ 1.3091`。 -/
theorem sinh_two_K_bounds {K : ℝ} (hK : K ∈ Dnbhd) :
    (0.7313 : ℝ) ≤ Real.sinh (2 * K) ∧ Real.sinh (2 * K) ≤ 1.3091 := by
  have hl : Kc - 1/10 ≤ K := hK.1
  have hu : K ≤ Kc + 1/10 := hK.2
  have hs2 := sqrt_two_bounds
  have hc02 := cosh_02_bounds
  have hs02 := sinh_02_bounds
  have hhigh : Real.sinh (2 * Kc + 0.2) = Real.cosh 0.2 + Real.sqrt 2 * Real.sinh 0.2 := by
    -- 人手 (4) の端点の式の複号 + の側。読み方は `sinh_two_Kc_sub_fifth` と同じ。
    rw [sinh_add_formula, sinh_two_Kc, cosh_two_Kc]; ring
  constructor
  · -- `2K_c − 1/5 ≤ 2K` と `sinh_strictly_increasing`（等号のときは等しい）、続く行は `sinh_two_Kc_sub_fifth_ge`
    have hmono : Real.sinh (2 * Kc - 0.2) ≤ Real.sinh (2 * K) :=
      sinh_le_sinh_of_le (by norm_num at hl ⊢; linarith)
    linarith [sinh_two_Kc_sub_fifth_ge]
  · -- `2K ≤ 2K_c + 1/5` と `sinh_strictly_increasing`（等号のときは等しい）
    have hmono : Real.sinh (2 * K) ≤ Real.sinh (2 * Kc + 0.2) :=
      sinh_le_sinh_of_le (by norm_num at hu ⊢; linarith)
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

/-- 人手 `kappa_of_K_basic` (4) の証明の `h : ℝ_{>0} → ℝ, h(t) := cosh t / sinh² t`
（Lean では全実数の上の関数として置き、`t > 0` でだけ使う）。 -/
noncomputable def hCoshOverSinhSq (t : ℝ) : ℝ := Real.cosh t / Real.sinh t ^ 2

/-- 人手 (4) の証明の `h'(t) = (−1 − cosh² t)/sinh³ t`（`t > 0`）。
人手の鎖の 1 行目（微分の公式の商）が `HasDerivAt.div`、2 行目（微分の公式の積）が `HasDerivAt.mul`、
3 行目（`cosh_derivative`・`sinh_derivative`）が mathlib の `Real.hasDerivAt_cosh`・`Real.hasDerivAt_sinh` で、
Lean ではこの 3 行が導関数の値を作る段に入り、下の `calc` は値の側の残りの行
（`ℝ` の乗法の交換律、`ℝ` の四則（`sinh t ≠ 0`）、`cosh_sinh_basic_properties` (2) の `sinh² t = cosh² t − 1`）を 1 行ずつ追う。 -/
theorem hasDerivAt_hCoshOverSinhSq {t : ℝ} (ht : 0 < t) :
    HasDerivAt hCoshOverSinhSq ((-1 - Real.cosh t ^ 2) / Real.sinh t ^ 3) t := by
  have hs : Real.sinh t > 0 := real_sinh_pos_of_pos ht
  have hss : Real.sinh t * Real.sinh t ≠ 0 := by positivity
  -- 微分の公式の積: `(sinh·sinh)' = sinh' sinh + sinh sinh'`
  have hprod := (Real.hasDerivAt_sinh t).mul (Real.hasDerivAt_sinh t)
  -- 微分の公式の商
  have hquot := (Real.hasDerivAt_cosh t).div hprod hss
  have hfun : hCoshOverSinhSq = fun x => Real.cosh x / (Real.sinh x * Real.sinh x) := by
    funext x; simp only [hCoshOverSinhSq, pow_two]
  have hv :
      (Real.sinh t * (Real.sinh t * Real.sinh t)
          - Real.cosh t * (Real.cosh t * Real.sinh t + Real.sinh t * Real.cosh t))
        / (Real.sinh t * Real.sinh t) ^ 2
      = (-1 - Real.cosh t ^ 2) / Real.sinh t ^ 3 :=
    calc (Real.sinh t * (Real.sinh t * Real.sinh t)
            - Real.cosh t * (Real.cosh t * Real.sinh t + Real.sinh t * Real.cosh t))
          / (Real.sinh t * Real.sinh t) ^ 2
        = (Real.sinh t * Real.sinh t ^ 2 - Real.cosh t * (2 * Real.sinh t * Real.cosh t))
            / Real.sinh t ^ 4 := by
          -- `ℝ` の乗法の交換律（人手の 2 行目の `2 sinh t sinh'(t)` と `sinh^4 t`）
          ring
      _ = (Real.sinh t ^ 2 - 2 * Real.cosh t ^ 2) / Real.sinh t ^ 3 := by
          -- `ℝ` の四則（`sinh t ≠ 0`）
          field_simp
      _ = (-1 - Real.cosh t ^ 2) / Real.sinh t ^ 3 := by
          -- `cosh_sinh_basic_properties` (2) の `sinh² t = cosh² t − 1`
          rw [show Real.sinh t ^ 2 = Real.cosh t ^ 2 - 1 by
            linarith [cosh_sinh_basic_properties_2 t]]
          ring
  rw [hfun, ← hv]
  exact hquot

/-- 人手 (4) の証明の `h'(t) < 0`（`t > 0`）: `−1 − cosh² t ≤ −1 < 0`、`sinh³ t > 0`。 -/
theorem hCoshOverSinhSq_deriv_neg {t : ℝ} (ht : 0 < t) :
    (-1 - Real.cosh t ^ 2) / Real.sinh t ^ 3 < 0 := by
  have hs : Real.sinh t > 0 := real_sinh_pos_of_pos ht
  have hnum : -1 - Real.cosh t ^ 2 < 0 := by nlinarith [sq_nonneg (Real.cosh t)]
  exact div_neg_of_neg_of_pos hnum (by positivity)

/-- 人手 (4) の証明の「`0 < a ≤ b` なら `h(b) ≤ h(a)`」。
人手の鎖 `h(b) − h(a) = ∫_a^b h' ≤ ∫_a^b 0 = 0` と 1 対 1:
1 行目（(R4) を `F = h` で）が `intervalIntegral.integral_eq_sub_of_hasDerivAt`、
2 行目（(R3) の単調性と `h'(t) < 0`）が `intervalIntegral.integral_mono_on`、
3 行目（(R4) を定数関数 `F = 0` で）が同じ `intervalIntegral.integral_eq_sub_of_hasDerivAt` と `hasDerivAt_const`。
`h'` の連続（人手「微分可能な関数の商として微分可能なので連続」）は、
`cosh`・`sinh` の連続と `sinh t ≠ 0` からの商の連続で読む。 -/
theorem hCoshOverSinhSq_antitone {a b : ℝ} (ha : 0 < a) (hab : a ≤ b) :
    hCoshOverSinhSq b ≤ hCoshOverSinhSq a := by
  have hpos : ∀ t ∈ Set.uIcc a b, 0 < t := by
    intro t ht
    rw [Set.uIcc_of_le hab] at ht
    exact lt_of_lt_of_le ha ht.1
  have hderiv : ∀ t ∈ Set.uIcc a b,
      HasDerivAt hCoshOverSinhSq ((-1 - Real.cosh t ^ 2) / Real.sinh t ^ 3) t :=
    fun t ht => hasDerivAt_hCoshOverSinhSq (hpos t ht)
  have hcont : ContinuousOn (fun t => (-1 - Real.cosh t ^ 2) / Real.sinh t ^ 3) (Set.uIcc a b) := by
    refine ContinuousOn.div (by fun_prop) (by fun_prop) ?_
    intro t ht
    exact pow_ne_zero 3 (ne_of_gt (real_sinh_pos_of_pos (hpos t ht)))
  have hint : IntervalIntegrable (fun t => (-1 - Real.cosh t ^ 2) / Real.sinh t ^ 3) MeasureTheory.volume a b :=
    hcont.intervalIntegrable
  have hdiff : hCoshOverSinhSq b - hCoshOverSinhSq a ≤ 0 :=
    calc hCoshOverSinhSq b - hCoshOverSinhSq a
        = ∫ t in a..b, (-1 - Real.cosh t ^ 2) / Real.sinh t ^ 3 := by
          -- (R4) を `F = h` で
          rw [intervalIntegral.integral_eq_sub_of_hasDerivAt hderiv hint]
      _ ≤ ∫ _ in a..b, (0 : ℝ) := by
          -- (R3) の単調性と `h'(t) < 0`
          refine intervalIntegral.integral_mono_on hab hint intervalIntegrable_const ?_
          intro t ht
          exact (hCoshOverSinhSq_deriv_neg (lt_of_lt_of_le ha ht.1)).le
      _ = 0 - 0 := by
          -- (R4) を定数関数 `F = 0` で
          exact intervalIntegral.integral_eq_sub_of_hasDerivAt (f := fun _ : ℝ => (0 : ℝ))
            (fun t _ => hasDerivAt_const t (0 : ℝ)) intervalIntegrable_const
      _ = 0 := sub_self 0
  linarith

/-- 人手 (4) の証明の `cosh(2K_c − 1/5) ≤ 1.2413`（本形式化の定数は `1.2431`）。人手の 6 行の鎖と 1 対 1。 -/
theorem cosh_two_Kc_sub_fifth_le : Real.cosh (2 * Kc - 0.2) ≤ 1.2431 := by
  have hs2 := sqrt_two_bounds
  have hc02 := cosh_02_bounds
  have hs02 := sinh_02_bounds
  have hcpos : (0 : ℝ) < Real.cosh 0.2 := by linarith [hc02.1]
  calc Real.cosh (2 * Kc - 0.2)
      = Real.cosh (2 * Kc) * Real.cosh 0.2 - Real.sinh (2 * Kc) * Real.sinh 0.2 :=
        -- `cosh_addition_formula` の複号 −
        cosh_sub_formula _ _
    _ = Real.sqrt 2 * Real.cosh 0.2 - Real.sinh 0.2 := by
        -- 準備の `cosh 2K_c = √2` と `K_c` の定義（`sinh 2K_c = 1`）
        rw [cosh_two_Kc, sinh_two_Kc, one_mul]
    _ ≤ 1.4142136 * Real.cosh 0.2 - Real.sinh 0.2 := by
        -- `√2 ≤ 1.4142136` と `cosh(1/5) > 0`
        have := mul_le_mul_of_nonneg_right hs2.2 hcpos.le
        linarith
    _ ≤ 1.4142136 * 1.0204082 - Real.sinh 0.2 := by
        -- `cosh(1/5) ≤ 1.0204082`
        have := mul_le_mul_of_nonneg_left hc02.2 (by norm_num : (0 : ℝ) ≤ 1.4142136)
        linarith
    _ ≤ 1.4142136 * 1.0204082 - 0.2 := by
        -- `sinh(1/5) ≥ 0.2`
        linarith [hs02.1]
    _ ≤ 1.2431 := by
        -- `ℚ` の四則と大小
        norm_num

/-- **人手証明 `kappa_of_K_basic` (4)**: `|κ''(K)| ≤ 9.3`（原文は `9.19`）。人手の 8 行の鎖と 1 対 1。 -/
theorem abs_kappaSecond_le {K : ℝ} (hK : K ∈ Dnbhd) : |kappaSecond K| ≤ 9.3 := by
  have hl : Kc - 1/10 ≤ K := hK.1
  have hs : 0 < Real.sinh (2 * K) := by linarith [(sinh_two_K_bounds hK).1]
  have hc : 0 < Real.cosh (2 * K) := cosh_pos_of_two_cosh_pos _
  have h0 := two_Kc_sub_fifth_pos
  have hle : 2 * Kc - 0.2 ≤ 2 * K := by norm_num at hl ⊢; linarith
  have hsc := sinh_two_Kc_sub_fifth_ge
  have hscpos : (0 : ℝ) < Real.sinh (2 * Kc - 0.2) ^ 2 := by positivity
  calc |kappaSecond K|
      = |-(4 * Real.cosh (2 * K)) / Real.sinh (2 * K) ^ 2| := by
        -- (3)
        rfl
    _ = 4 * Real.cosh (2 * K) / Real.sinh (2 * K) ^ 2 := by
        -- `cosh 2K > 0`（`cosh_sinh_basic_properties` (1)）、`sinh² 2K > 0`
        rw [neg_div, abs_neg, abs_of_pos (div_pos (mul_pos (by norm_num) hc) (pow_pos hs 2))]
    _ = 4 * hCoshOverSinhSq (2 * K) := by
        -- `h` の定義
        simp only [hCoshOverSinhSq]; ring
    _ ≤ 4 * hCoshOverSinhSq (2 * Kc - 0.2) := by
        -- `0 < 2K_c − 1/5 ≤ 2K` と `h` の単調減少
        have := hCoshOverSinhSq_antitone h0 hle
        linarith
    _ = 4 * Real.cosh (2 * Kc - 0.2) / Real.sinh (2 * Kc - 0.2) ^ 2 := by
        -- `h` の定義
        simp only [hCoshOverSinhSq]; ring
    _ ≤ 4 * 1.2431 / Real.sinh (2 * Kc - 0.2) ^ 2 := by
        -- 上の `cosh(2K_c − 1/5) ≤ 1.2431`
        have := cosh_two_Kc_sub_fifth_le
        exact div_le_div_of_nonneg_right (by linarith) hscpos.le
    _ ≤ 4 * 1.2431 / 0.7313 ^ 2 := by
        -- `sinh(2K_c − 1/5) ≥ 0.7313 > 0`
        have h7 : (0.7313 : ℝ) ^ 2 ≤ Real.sinh (2 * Kc - 0.2) ^ 2 :=
          pow_le_pow_left₀ (by norm_num) hsc 2
        exact div_le_div_of_nonneg_left (by norm_num) (by norm_num) h7
    _ ≤ 9.3 := by
        -- `ℚ` の四則と大小
        norm_num

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
`3.52|K-K_c| ≤ |κ(K)| ≤ 4.74|K-K_c| ≤ 0.474`（原文の定数は `3.53`・`4.72`・`0.472`）。
人手の準備（`a := min{K, K_c}`、`b := max{K, K_c}`、`b − a = |K − K_c|`、`[a, b]` の点で (4) を使えること、
`κ(b) − κ(a) = |κ(K) − κ(K_c)|`）と 13 行の鎖と 1 対 1。
(R4)（微分積分学の基本定理）は `intervalIntegral.integral_eq_sub_of_hasDerivAt`、
(R3)（積分の単調性）は `intervalIntegral.integral_mono_on` で読む。 -/
theorem abs_kappaK_bounds {K : ℝ} (hK : K ∈ Dnbhd) :
    (3.52 : ℝ) * |K - Kc| ≤ |kappaK K| ∧ |kappaK K| ≤ 4.74 * |K - Kc| ∧ |kappaK K| ≤ 0.474 := by
  -- 準備: `a := min{K, K_c}`、`b := max{K, K_c}`
  set a := min K Kc
  set b := max K Kc
  have hab : a ≤ b := min_le_max
  have huIcc : Set.uIcc a b = Set.Icc a b := Set.uIcc_of_le hab
  -- `b − a = |K − K_c|`
  have hba : b - a = |K - Kc| := max_sub_min_eq_abs' K Kc
  -- `t ∈ [a, b]` は `|t − K_c| ≤ |K − K_c| ≤ 1/10` を満たすので (4) を `t` で使える
  -- （Lean では `D = [K_c − 1/10, K_c + 1/10]` の両端と `a`・`b` の大小で読む）
  have hmem : ∀ t ∈ Set.Icc a b, t ∈ Dnbhd := by
    intro t ht
    have h1 : Kc - 1/10 ≤ K := hK.1
    have h2 : K ≤ Kc + 1/10 := hK.2
    have hma : Kc - 1/10 ≤ a := le_min h1 (by linarith)
    have hmb : b ≤ Kc + 1/10 := max_le h2 (by linarith)
    exact ⟨le_trans hma ht.1, le_trans ht.2 hmb⟩
  -- (R4) を `F(t) = c t` で: `∫_a^b c dt = c b − c a`
  have hconst : ∀ c : ℝ, (∫ _ in a..b, c) = c * b - c * a := fun c =>
    intervalIntegral.integral_eq_sub_of_hasDerivAt (f := fun t => c * t)
      (fun t _ => by simpa using (hasDerivAt_id t).const_mul c) intervalIntegrable_const
  -- (1) より `κ'` は連続（Lean では (3) の微分可能性から読む）
  have hcont : ContinuousOn kappaDeriv (Set.uIcc a b) := by
    intro t ht
    rw [huIcc] at ht
    exact (hasDerivAt_kappaDeriv (pos_of_mem_Dnbhd (hmem t ht))).continuousAt.continuousWithinAt
  have hint : IntervalIntegrable kappaDeriv MeasureTheory.volume a b := hcont.intervalIntegrable
  -- (R4) を `F = κ` で: `∫_a^b κ'(t) dt = κ(b) − κ(a)`
  have hFTC : (∫ t in a..b, kappaDeriv t) = kappaK b - kappaK a :=
    intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun t ht => hasDerivAt_kappaK (pos_of_mem_Dnbhd (hmem t (huIcc ▸ ht)))) hint
  -- (1) の `κ` の単調増加を `a ≤ b` に使う。(1) の単調増加は具体版の宣言を持たないので、
  -- (1) の証明の鎖 `κ(b) − κ(a) = ∫_a^b κ' ≥ ∫_a^b 2 = 2b − 2a ≥ 0`（(R4)・(R3) と `κ'(t) = 2 + 2/sinh 2t ≥ 2`）で受ける
  have hmono : kappaK a ≤ kappaK b := by
    have h2 : (∫ _ in a..b, (2 : ℝ)) ≤ ∫ t in a..b, kappaDeriv t := by
      refine intervalIntegral.integral_mono_on hab intervalIntegrable_const hint ?_
      intro t ht
      have hs : 0 < Real.sinh (2 * t) :=
        real_sinh_pos_of_pos (by linarith [pos_of_mem_Dnbhd (hmem t ht)])
      have : (0 : ℝ) ≤ 2 / Real.sinh (2 * t) := by positivity
      simp only [kappaDeriv]
      linarith
    rw [hconst, hFTC] at h2
    linarith
  -- `κ(b) − κ(a) = |κ(K) − κ(K_c)|`（`{a, b} = {K, K_c}` と `κ` の単調増加）
  have hbaκ : kappaK b - kappaK a = |kappaK K - kappaK Kc| := by
    rcases le_total K Kc with h | h
    · have ha' : a = K := min_eq_left h
      have hb' : b = Kc := max_eq_right h
      rw [ha', hb'] at hmono ⊢
      rw [abs_of_nonpos (by linarith)]
      ring
    · have ha' : a = Kc := min_eq_right h
      have hb' : b = K := max_eq_left h
      rw [ha', hb'] at hmono ⊢
      rw [abs_of_nonneg (by linarith)]
  -- 人手の鎖の 1〜6 行目
  have hlow : (3.52 : ℝ) * |K - Kc| ≤ |kappaK K| :=
    calc (3.52 : ℝ) * |K - Kc|
        = 3.52 * (b - a) := by
          -- `b − a = |K − K_c|`
          rw [hba]
      _ = ∫ _ in a..b, (3.52 : ℝ) := by
          -- (R4) を `F(t) = 3.52 t` で
          rw [hconst]; ring
      _ ≤ ∫ t in a..b, kappaDeriv t := by
          -- (R3) の単調性と (4) の `κ'(t) ≥ 3.52`
          refine intervalIntegral.integral_mono_on hab intervalIntegrable_const hint ?_
          intro t ht
          exact (kappaDeriv_bounds (hmem t ht)).1
      _ = kappaK b - kappaK a := by
          -- (R4) を `F = κ` で
          exact hFTC
      _ = |kappaK K - kappaK Kc| := by
          -- 上の `κ(b) − κ(a)` の表示
          exact hbaκ
      _ = |kappaK K| := by
          -- (2) の `κ(K_c) = 0`
          rw [kappaK_Kc, sub_zero]
  -- 人手の鎖の 7〜11 行目
  have hup : |kappaK K| ≤ 4.74 * |K - Kc| :=
    calc |kappaK K|
        = kappaK b - kappaK a := by
          -- (2) の `κ(K_c) = 0` と上の `κ(b) − κ(a)` の表示
          rw [hbaκ, kappaK_Kc, sub_zero]
      _ = ∫ t in a..b, kappaDeriv t := by
          -- (R4) を `F = κ` で
          exact hFTC.symm
      _ ≤ ∫ _ in a..b, (4.74 : ℝ) := by
          -- (R3) の単調性と (4) の `κ'(t) ≤ 4.74`
          refine intervalIntegral.integral_mono_on hab hint intervalIntegrable_const ?_
          intro t ht
          exact (kappaDeriv_bounds (hmem t ht)).2
      _ = 4.74 * (b - a) := by
          -- (R4) を `F(t) = 4.74 t` で
          rw [hconst]; ring
      _ = 4.74 * |K - Kc| := by
          -- `b − a = |K − K_c|`
          rw [hba]
  -- 人手の鎖の 12〜13 行目。人手の仮定 `|K − K_c| ≤ 1/10` は、Lean では仮定 `K ∈ D = [K_c − 1/10, K_c + 1/10]` から読む
  have hsmall : |K - Kc| ≤ 1/10 := by
    have h1 : Kc - 1/10 ≤ K := hK.1
    have h2 : K ≤ Kc + 1/10 := hK.2
    rw [abs_le]
    constructor <;> linarith
  have hfin : |kappaK K| ≤ 0.474 :=
    calc |kappaK K|
        ≤ 4.74 * |K - Kc| := hup
      _ ≤ 4.74 * (1/10) := by
          -- `|K − K_c| ≤ 1/10`
          exact mul_le_mul_of_nonneg_left hsmall (by norm_num)
      _ = 0.474 := by
          -- `ℚ` の四則
          norm_num
  exact ⟨hlow, hup, hfin⟩

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

/-- **人手証明 `kappa_of_K_basic` (5) の第 2 式**: `|κ'(K)² - 16| ≤ 25.1 |κ(K)|`（原文の定数は `24.7`）。
人手の準備（`a`・`b` は第 1 式と同じ、`G := κ'²` の `G' = 2κ'κ''` とその連続、`κ'(K_c) = 4` の 3 行の鎖、
`∫_a^b G'` の 4 行の挟み込み）と 7 行の鎖と 1 対 1。 -/
theorem abs_kappaDerivSq_sub_le {K : ℝ} (hK : K ∈ Dnbhd) :
    |kappaDeriv K ^ 2 - 16| ≤ 25.1 * |kappaK K| := by
  -- 準備: `a := min{K, K_c}`、`b := max{K, K_c}`（第 1 式と同じ）
  set a := min K Kc
  set b := max K Kc
  have hab : a ≤ b := min_le_max
  have huIcc : Set.uIcc a b = Set.Icc a b := Set.uIcc_of_le hab
  -- `b − a = |K − K_c|`
  have hba : b - a = |K - Kc| := max_sub_min_eq_abs' K Kc
  -- `t ∈ [a, b]` で (4) を使える
  have hmem : ∀ t ∈ Set.Icc a b, t ∈ Dnbhd := by
    intro t ht
    have h1 : Kc - 1/10 ≤ K := hK.1
    have h2 : K ≤ Kc + 1/10 := hK.2
    have hma : Kc - 1/10 ≤ a := le_min h1 (by linarith)
    have hmb : b ≤ Kc + 1/10 := max_le h2 (by linarith)
    exact ⟨le_trans hma ht.1, le_trans ht.2 hmb⟩
  -- (R4) を `F(t) = c t` で: `∫_a^b c dt = c b − c a`
  have hconst : ∀ c : ℝ, (∫ _ in a..b, c) = c * b - c * a := fun c =>
    intervalIntegral.integral_eq_sub_of_hasDerivAt (f := fun t => c * t)
      (fun t _ => by simpa using (hasDerivAt_id t).const_mul c) intervalIntegrable_const
  -- `G' = 2κ'κ''` の連続: `κ'` は微分可能（(3)）、`κ'' = −4cosh(2·)/sinh²(2·)` は微分可能な関数の商
  have hcontG : ContinuousOn (fun t => 2 * kappaDeriv t * kappaSecond t) (Set.uIcc a b) := by
    intro t ht
    rw [huIcc] at ht
    have htpos : 0 < t := pos_of_mem_Dnbhd (hmem t ht)
    have hs : 0 < Real.sinh (2 * t) := real_sinh_pos_of_pos (by linarith)
    have h1 : ContinuousAt kappaDeriv t := (hasDerivAt_kappaDeriv htpos).continuousAt
    have h2 : ContinuousAt (fun x => -(4 * Real.cosh (2 * x)) / Real.sinh (2 * x) ^ 2) t :=
      ContinuousAt.div (by fun_prop) (by fun_prop) (pow_ne_zero 2 hs.ne')
    exact ((continuousAt_const.mul h1).mul h2).continuousWithinAt
  have hintG : IntervalIntegrable (fun t => 2 * kappaDeriv t * kappaSecond t)
      MeasureTheory.volume a b := hcontG.intervalIntegrable
  -- (R4) を `F = G` で: `∫_a^b G'(t) dt = G(b) − G(a)`
  have hFTC : (∫ t in a..b, 2 * kappaDeriv t * kappaSecond t) = kappaDerivSq b - kappaDerivSq a :=
    intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun t ht => hasDerivAt_kappaDerivSq (pos_of_mem_Dnbhd (hmem t (huIcc ▸ ht)))) hintG
  -- `κ'(K_c) = 4`
  have hK4 : kappaDeriv Kc = 4 :=
    calc kappaDeriv Kc
        = 2 + 2 / Real.sinh (2 * Kc) := by
          -- (1) の `κ'` の表示を `K = K_c` で読む
          rfl
      _ = 2 + 2 / 1 := by
          -- `K_c` の定義
          rw [sinh_two_Kc]
      _ = 4 := by
          -- `ℝ` の四則
          norm_num
  -- (4) より `t ∈ [a, b]` で `−88.2 ≤ G'(t) ≤ 88.2`
  have hGb : ∀ t ∈ Set.Icc a b,
      -88.2 ≤ 2 * kappaDeriv t * kappaSecond t ∧ 2 * kappaDeriv t * kappaSecond t ≤ 88.2 :=
    fun t ht => abs_le.1 (abs_deriv_kappaDerivSq_le (hmem t ht))
  -- `∫_a^b G'` の挟み込み。人手の 1 本の 4 行の鎖を、1〜2 行目（`hsand_lo`）と 2〜4 行目（`hsand_hi`）に分けて書く
  -- （2 行目は人手では二つの不等号の間にある `∫_a^b G'` そのもの）
  have hsand_lo : -88.2 * (b - a) ≤ ∫ t in a..b, 2 * kappaDeriv t * kappaSecond t :=
    calc -88.2 * (b - a)
        = ∫ _ in a..b, (-88.2 : ℝ) := by
          -- (R4) を `F(t) = −88.2 t` で
          rw [hconst]; ring
      _ ≤ ∫ t in a..b, 2 * kappaDeriv t * kappaSecond t := by
          -- (R3) の単調性と `−88.2 ≤ G'(t)`
          refine intervalIntegral.integral_mono_on hab intervalIntegrable_const hintG ?_
          intro t ht
          exact (hGb t ht).1
  have hsand_hi : (∫ t in a..b, 2 * kappaDeriv t * kappaSecond t) ≤ 88.2 * (b - a) :=
    calc (∫ t in a..b, 2 * kappaDeriv t * kappaSecond t)
        ≤ ∫ _ in a..b, (88.2 : ℝ) := by
          -- (R3) の単調性と `G'(t) ≤ 88.2`
          refine intervalIntegral.integral_mono_on hab hintG intervalIntegrable_const ?_
          intro t ht
          exact (hGb t ht).2
      _ = 88.2 * (b - a) := by
          -- (R4) を `F(t) = 88.2 t` で
          rw [hconst]; ring
  have hlow : (3.52 : ℝ) * |K - Kc| ≤ |kappaK K| := (abs_kappaK_bounds hK).1
  calc |kappaDeriv K ^ 2 - 16|
      = |kappaDerivSq K - kappaDerivSq Kc| := by
        -- `G` の定義と `κ'(K_c) = 4`
        simp only [kappaDerivSq]
        rw [hK4]
        norm_num
    _ = |kappaDerivSq b - kappaDerivSq a| := by
        -- `{a, b} = {K, K_c}` と `|−x| = |x|`
        rcases le_total K Kc with h | h
        · have ha' : a = K := min_eq_left h
          have hb' : b = Kc := max_eq_right h
          rw [ha', hb', abs_sub_comm]
        · have ha' : a = Kc := min_eq_right h
          have hb' : b = K := max_eq_left h
          rw [ha', hb']
    _ = |∫ t in a..b, 2 * kappaDeriv t * kappaSecond t| := by
        -- (R4) を `F = G` で
        rw [hFTC]
    _ ≤ 88.2 * (b - a) := by
        -- 上の `∫_a^b G'` の挟み込みと絶対値の定義
        rw [abs_le]
        constructor
        · linarith [hsand_lo]
        · exact hsand_hi
    _ = 88.2 * |K - Kc| := by
        -- `b − a = |K − K_c|`
        rw [hba]
    _ ≤ 88.2 * (|kappaK K| / 3.52) := by
        -- 上の `3.52|K − K_c| ≤ |κ(K)|`
        refine mul_le_mul_of_nonneg_left ?_ (by norm_num)
        rw [le_div_iff₀ (by norm_num)]
        linarith
    _ ≤ 25.1 * |kappaK K| := by
        -- `ℚ` の四則と大小
        have heq : (88.2 : ℝ) * (|kappaK K| / 3.52) = (88.2 / 3.52) * |kappaK K| := by ring
        rw [heq]
        exact mul_le_mul_of_nonneg_right (by norm_num) (abs_nonneg _)

end Ising2D
