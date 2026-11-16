/-
章「実数体への脱出と熱力学極限」の「半格子ずれた四つのモード和は同じ積分へ収束する」
（`claim_shifted_mode_riemann_sums`）の証明の後半（小区画の誤差評価）の具体版。

  人手証明                                                          このファイル
  h_L := 2π/L                                                       `angleStep`
  a/2, b/2（(a,b) ∈ 𝒮 の成分）                                       `spinHalfOffset`
  t^{a,b}_{L,k,l} := (h_L(k+a/2), h_L(l+b/2))                        `shiftedSamplePoint`
  h_L² Σ_{k,l} f_q(t^{a,b}_{L,k,l})                                   `shiftedAngleRiemannSum`
  I := ∫₀^{2π}∫₀^{2π} f_q(θ₁,θ₂) dθ₂ dθ₁                              `dispersionAngleDoubleIntegral`
  標本点は小区画 C_{L,k,l} に属し、座標の差は h_L 以下                 `cell_sample_close`
  |I − h_L²Σf_q(t)| = |Σ_{k,l}∫_{C_{L,k,l}}(f_q(x) − f_q(t))dx|
    ≤ Σ∫|f_q(x) − f_q(t)| ≤ ε/(8π²)·Σ area(C_{L,k,l}) = ε/2           `shiftedAngleRiemannSum_error_le`
  一様連続性で η、Archimedes 性で 2π/L₀ < η、全ての L ≥ L₀ で誤差 < ε  `shiftedAngleRiemannSum_tendsto`

脱出理由: 連続極限（実数の角の格子和と Riemann 積分、辺長を無限大へ送る極限）。
`f_q` の連続性は `claim_dispersion_angle_log_continuous` の具体版 `dispersion_angle_log_continuous` を引く。
積分は mathlib の区間積分の累次積分で、小区画への分割は隣接区間の積分の和
（`sum_integral_adjacent_intervals`）、片方の変数で積分した関数の連続性は
`continuous_parametric_intervalIntegral_of_continuous'`、一様連続性は Heine–Cantor
（`IsCompact.uniformContinuousOn_of_continuous`）である。
必要十分版の定理・定義は使わない。
-/
import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.Topology.UniformSpace.HeineCantor
import Mathlib.Topology.Order.Compact
import Ising2DLambda.RealEscape.DispersionAngleLogContinuous
import Ising2DLambda.KacWard.Basic

namespace Ising2DLambda.RealEscape

open Filter Topology intervalIntegral
open scoped Interval
open Ising2DLambda.KacWard

/-- `h_L := 2π/L`。 -/
noncomputable def angleStep (L : ℕ) : ℝ := 2 * Real.pi / L

/-- スピン構造の成分 `c ∈ {0,1}` の半分 `c/2`。 -/
noncomputable def spinHalfOffset (c : Bool) : ℝ := (if c then 1 else 0) / 2

theorem spinHalfOffset_mem (c : Bool) : 0 ≤ spinHalfOffset c ∧ spinHalfOffset c ≤ 1 := by
  cases c <;> norm_num [spinHalfOffset]

/-- `t^{a,b}_{L,k,l} := (h_L(k+a/2), h_L(l+b/2))`。 -/
noncomputable def shiftedSamplePoint (L : ℕ) (s : SpinStructure) (k l : ℕ) : ℝ × ℝ :=
  (angleStep L * (k + spinHalfOffset s.1), angleStep L * (l + spinHalfOffset s.2))

/-- `h_L² Σ_{k,l=0}^{L-1} f_q(t^{a,b}_{L,k,l})`。 -/
noncomputable def shiftedAngleRiemannSum (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (s : SpinStructure) (L : ℕ) : ℝ :=
  angleStep L ^ 2 * ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
    dispersionAngleLog q hq0 hq1 (shiftedSamplePoint L s k l)

/-- `I := ∫₀^{2π}∫₀^{2π} f_q(θ₁,θ₂) dθ₂ dθ₁`。 -/
noncomputable def dispersionAngleDoubleIntegral (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) : ℝ :=
  ∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi, dispersionAngleLog q hq0 hq1 (θ₁, θ₂)

/-- 標本点は小区画に属する: 一辺 `(h k, h(k+1)]` の点と `h(k+c/2)` の差は `h` 以下で、`k < L` なら
両者は `[0, hL]` に属する（`c/2 ∈ [0,1]`）。 -/
theorem cell_sample_close {h x : ℝ} {c : Bool} {k L : ℕ} (hh : 0 < h)
    (hk : k < L) (hx : x ∈ Ι (h * k) (h * ((k + 1 : ℕ) : ℝ))) :
    |x - h * (k + spinHalfOffset c)| ≤ h ∧ x ∈ Set.Icc 0 (h * L) ∧
      h * (k + spinHalfOffset c) ∈ Set.Icc 0 (h * L) := by
  obtain ⟨hα0, hα1⟩ := spinHalfOffset_mem c
  have hkL : ((k + 1 : ℕ) : ℝ) ≤ L := by exact_mod_cast hk
  have hle : h * k ≤ h * ((k + 1 : ℕ) : ℝ) := by
    apply mul_le_mul_of_nonneg_left _ hh.le; push_cast; linarith
  rw [Set.uIoc_of_le hle] at hx
  obtain ⟨hx0, hx1⟩ := hx
  push_cast at hx1 hkL
  have hk0 : (0 : ℝ) ≤ k := Nat.cast_nonneg k
  refine ⟨abs_le.2 ⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩
  · nlinarith
  · nlinarith
  · nlinarith
  · nlinarith
  · nlinarith
  · nlinarith

/-- 小区画の誤差評価: `[0,2π]²` の二点が `dist ≤ h_L` なら `|f_q(x) − f_q(y)| ≤ ε'` のとき、
`|I − h_L² Σ f_q(t^{a,b}_{L,k,l})| ≤ (2π)² ε'`。 -/
theorem shiftedAngleRiemannSum_error_le (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1)
    (s : SpinStructure) (L : ℕ) (hL : 0 < L) (ε' : ℝ)
    (hε : ∀ x ∈ Set.Icc 0 (2 * Real.pi) ×ˢ Set.Icc 0 (2 * Real.pi),
      ∀ y ∈ Set.Icc 0 (2 * Real.pi) ×ˢ Set.Icc 0 (2 * Real.pi),
      dist x y ≤ angleStep L →
        |dispersionAngleLog q hq0 hq1 x - dispersionAngleLog q hq0 hq1 y| ≤ ε') :
    |dispersionAngleDoubleIntegral q hq0 hq1 - shiftedAngleRiemannSum q hq0 hq1 s L|
      ≤ (2 * Real.pi) ^ 2 * ε' := by
  set f : ℝ × ℝ → ℝ := dispersionAngleLog q hq0 hq1 with hf_def
  -- claim_dispersion_angle_log_continuous
  have hf : Continuous f := (dispersion_angle_log_continuous q hq0 hq1).2
  set T : ℝ := 2 * Real.pi with hT_def
  have hT : 0 < T := by positivity
  set h : ℝ := angleStep L with hh_def
  have hLpos : (0 : ℝ) < L := by exact_mod_cast hL
  have hh : 0 < h := div_pos hT hLpos
  have hhL : h * L = T := by rw [hh_def, angleStep, hT_def]; field_simp
  -- 小区画の端点 `c k := h_L k`
  set c : ℕ → ℝ := fun k => h * k with hc_def
  have hc0 : c 0 = 0 := by simp [hc_def]
  have hcL : c L = T := hhL
  have hlen : ∀ k : ℕ, c (k + 1) - c k = h := by intro k; simp [hc_def]; ring
  -- 片方の変数で積分した関数の連続性
  have hpar : ∀ a b : ℝ, Continuous fun θ₁ => ∫ θ₂ in a..b, f (θ₁, θ₂) := fun a b =>
    continuous_parametric_intervalIntegral_of_continuous' (f := Function.curry f)
      (by rwa [Function.uncurry_curry]) a b
  have hsec : ∀ θ₁ : ℝ, Continuous fun θ₂ => f (θ₁, θ₂) := fun θ₁ =>
    hf.comp (continuous_const.prodMk continuous_id)
  -- 標本点 `t^{a,b}_{L,k,l}`
  set t : ℕ → ℕ → ℝ × ℝ := fun k l => shiftedSamplePoint L s k l with ht_def
  -- 一行目: `C_{L,k,l}` は境界を除き正方形を分割する
  have hI : dispersionAngleDoubleIntegral q hq0 hq1 =
      ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
        ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), f (θ₁, θ₂) := by
    have hinner : ∀ θ₁ : ℝ, (∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂)) =
        ∑ l ∈ Finset.range L, ∫ θ₂ in c l..c (l + 1), f (θ₁, θ₂) := by
      intro θ₁
      rw [← hc0, ← hcL]
      exact (sum_integral_adjacent_intervals fun l _ => (hsec θ₁).intervalIntegrable _ _).symm
    calc dispersionAngleDoubleIntegral q hq0 hq1
        = ∫ θ₁ in (0 : ℝ)..T, ∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂) := rfl
      _ = ∑ k ∈ Finset.range L, ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂) := by
          rw [← hc0, ← hcL]
          exact (sum_integral_adjacent_intervals fun k _ =>
            (hpar (c 0) (c L)).intervalIntegrable _ _).symm
      _ = ∑ k ∈ Finset.range L, ∫ θ₁ in c k..c (k + 1),
            ∑ l ∈ Finset.range L, ∫ θ₂ in c l..c (l + 1), f (θ₁, θ₂) := by
          simp_rw [hinner]
      _ = ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
            ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), f (θ₁, θ₂) := by
          refine Finset.sum_congr rfl fun k _ => ?_
          exact integral_finsetSum fun l _ => (hpar _ _).intervalIntegrable _ _
  have hS : shiftedAngleRiemannSum q hq0 hq1 s L =
      ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
        ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), f (t k l) := by
    simp only [integral_const, hlen, smul_eq_mul]
    rw [shiftedAngleRiemannSum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [pow_two, mul_assoc]
  have hdiff : ∀ k l : ℕ,
      (∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), f (θ₁, θ₂)) -
        (∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), f (t k l)) =
      ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), (f (θ₁, θ₂) - f (t k l)) := by
    intro k l
    rw [← integral_sub ((hpar _ _).intervalIntegrable _ _)
      (continuous_const.intervalIntegrable _ _)]
    refine integral_congr fun θ₁ _ => ?_
    exact (integral_sub ((hsec θ₁).intervalIntegrable _ _)
      (continuous_const.intervalIntegrable _ _)).symm
  -- 各小区画での一様評価と積分の単調性
  have hcell : ∀ k ∈ Finset.range L, ∀ l ∈ Finset.range L,
      ‖∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), (f (θ₁, θ₂) - f (t k l))‖
        ≤ ε' * h * h := by
    intro k hk l hl
    have hk' := Finset.mem_range.1 hk
    have hl' := Finset.mem_range.1 hl
    have hbound := norm_integral_le_of_norm_le_const (a := c k) (b := c (k + 1)) (C := ε' * h)
      (f := fun θ₁ => ∫ θ₂ in c l..c (l + 1), (f (θ₁, θ₂) - f (t k l))) (by
        intro θ₁ hθ₁
        have hin := norm_integral_le_of_norm_le_const (a := c l) (b := c (l + 1)) (C := ε')
          (f := fun θ₂ => f (θ₁, θ₂) - f (t k l)) (by
            intro θ₂ hθ₂
            obtain ⟨h1, h1x, h1t⟩ := cell_sample_close (c := s.1) hh hk' hθ₁
            obtain ⟨h2, h2x, h2t⟩ := cell_sample_close (c := s.2) hh hl' hθ₂
            rw [hhL] at h1x h1t h2x h2t
            rw [Real.norm_eq_abs]
            refine hε (θ₁, θ₂) ⟨h1x, h2x⟩ (t k l) ⟨h1t, h2t⟩ ?_
            rw [Prod.dist_eq, Real.dist_eq, Real.dist_eq]
            exact max_le h1 h2)
        rw [hlen, abs_of_pos hh] at hin
        exact hin)
    rw [hlen, abs_of_pos hh] at hbound
    exact hbound
  rw [← Real.norm_eq_abs]
  calc ‖dispersionAngleDoubleIntegral q hq0 hq1 - shiftedAngleRiemannSum q hq0 hq1 s L‖
      = ‖∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
          ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), (f (θ₁, θ₂) - f (t k l))‖ := by
        rw [hI, hS, ← Finset.sum_sub_distrib]
        simp_rw [← Finset.sum_sub_distrib, hdiff]
    -- 積分の三角不等式
    _ ≤ ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
          ‖∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), (f (θ₁, θ₂) - f (t k l))‖ :=
        (norm_sum_le _ _).trans (Finset.sum_le_sum fun k _ => norm_sum_le _ _)
    -- 各小区画での一様評価と積分の単調性
    _ ≤ ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L, ε' * h * h :=
        Finset.sum_le_sum fun k hk => Finset.sum_le_sum fun l hl => hcell k hk l hl
    -- Σ area(C_{L,k,l}) = (2π)²
    _ = T ^ 2 * ε' := by
        simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul]
        rw [← hhL]; ring

/-- `claim_shifted_mode_riemann_sums` の後半（小区画の誤差評価）の具体版:
`h_L² Σ_{k,l} f_q(t^{a,b}_{L,k,l}) → I`。 -/
theorem shiftedAngleRiemannSum_tendsto (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (s : SpinStructure) :
    Tendsto (shiftedAngleRiemannSum q hq0 hq1 s) atTop
      (𝓝 (dispersionAngleDoubleIntegral q hq0 hq1)) := by
  rw [Metric.tendsto_atTop]
  intro ε hε
  have hpi : 0 < Real.pi ^ 2 := by positivity
  -- claim_dispersion_angle_log_continuous と [0,2π]² のコンパクト性から一様連続
  have hunif : UniformContinuousOn (dispersionAngleLog q hq0 hq1)
      (Set.Icc 0 (2 * Real.pi) ×ˢ Set.Icc 0 (2 * Real.pi)) :=
    (isCompact_Icc.prod isCompact_Icc).uniformContinuousOn_of_continuous
      (dispersion_angle_log_continuous q hq0 hq1).2.continuousOn
  -- |f_q(x) − f_q(y)| < ε/(8π²) となる η
  obtain ⟨η, hη, hu⟩ := Metric.uniformContinuousOn_iff.1 hunif (ε / (8 * Real.pi ^ 2))
    (by positivity)
  -- 自然数の Archimedes 性から 2π/L₀ < η
  obtain ⟨L₀, hL₀⟩ := exists_nat_gt (2 * Real.pi / η)
  refine ⟨L₀, fun L hL => ?_⟩
  have hT : 0 < 2 * Real.pi := by positivity
  have hL₀pos : (0 : ℝ) < L₀ := lt_trans (div_pos hT hη) hL₀
  have hLpos' : (0 : ℝ) < L := lt_of_lt_of_le hL₀pos (by exact_mod_cast hL)
  have hLpos : 0 < L := by exact_mod_cast hLpos'
  -- h_L ≤ h_{L₀} < η
  have hstep : angleStep L < η := by
    calc angleStep L ≤ angleStep L₀ :=
          div_le_div_of_nonneg_left hT.le hL₀pos (by exact_mod_cast hL)
      _ < η := by
          rw [angleStep, div_lt_iff₀ hL₀pos]; rw [div_lt_iff₀ hη] at hL₀; linarith
  have hbound := shiftedAngleRiemannSum_error_le q hq0 hq1 s L hLpos (ε / (8 * Real.pi ^ 2))
    (fun x hx y hy hxy => by
      rw [← Real.dist_eq]
      exact (hu x hx y hy (lt_of_le_of_lt hxy hstep)).le)
  rw [Real.dist_eq, abs_sub_comm]
  calc _ ≤ (2 * Real.pi) ^ 2 * (ε / (8 * Real.pi ^ 2)) := hbound
    _ = ε / 2 := by field_simp; ring
    _ < ε := by linarith

end Ising2DLambda.RealEscape
