/-
「半格子ずれた四つのモード和は同じ積分へ収束する」（`claim_shifted_mode_riemann_sums`）の証明の後半
（小区画の誤差評価）の必要十分版。

具体版と同じ手順（`[0,T]²` 上の一様連続性で `η` を取る、`T/L₀ < η` となる `L₀` を取る、
`I − h²Σf(t) = Σ_{k,l}∫_{C_{k,l}}(f(x) − f(t_{k,l}))dx`、積分の三角不等式、各小区画での一様評価、
小区画の面積の和 `T²`）を、次の仮定だけで行う。

- `f : ℝ × ℝ → E` は連続（具体版の `f_q`）。値の住処は `ℝ` でなくてよく、完備なノルム空間 `E` で足りる。
  使うのは、連続性から得る `[0,T]²` 上の一様連続性・各変数についての積分可能性・
  片方の変数で積分した関数の連続性と、ノルムの三角不等式だけである。
  連続性を `[0,T]²` 上に弱めないのは、片方の変数で積分した関数の連続性を全域で引くためである。
- `T > 0`（具体版の `2π`）。`π` の性質は使わない。
- 標本点のずれ `α, β ∈ [0,1]`（具体版の `a/2, b/2`）。使うのは標本点が小区画に属することだけで、
  `0 ≤ α` と `α ≤ 1` の両方が要る（どちらかを外すと標本点が小区画の外へ出て、一様評価が使えない）。
-/
import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.Topology.UniformSpace.HeineCantor
import Mathlib.Topology.Order.Compact

namespace Ising2DLambda.NecSuf.RealEscape

open Filter Topology intervalIntegral
open scoped Interval

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]

/-- 標本点和 `h_L² Σ_{k,l<L} f(h_L(k+α), h_L(l+β))`（`h_L := T/L`）。 -/
noncomputable def shiftedRiemannSumNecSuf (f : ℝ × ℝ → E) (T α β : ℝ) (L : ℕ) : E :=
  (T / L) ^ 2 • ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
    f (T / L * (k + α), T / L * (l + β))

/-- 小区画の一辺 `(h k, h(k+1)]` の点と標本点 `h(k+α)` の差は `h` 以下で、`k < L` なら両者は `[0, hL]` に属する。 -/
theorem cell_sample_close_necSuf {h α x : ℝ} {k L : ℕ} (hh : 0 < h) (hα0 : 0 ≤ α) (hα1 : α ≤ 1)
    (hk : k < L) (hx : x ∈ Ι (h * k) (h * ((k + 1 : ℕ) : ℝ))) :
    |x - h * (k + α)| ≤ h ∧ x ∈ Set.Icc 0 (h * L) ∧ h * (k + α) ∈ Set.Icc 0 (h * L) := by
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

/-- 小区画の誤差評価: `[0,T]²` の二点が `dist ≤ T/L` なら `‖f x − f y‖ ≤ ε'` のとき、
`‖I − h_L² Σ f(t_{k,l})‖ ≤ T² ε'`。 -/
theorem shiftedRiemannSum_error_le_necSuf (f : ℝ × ℝ → E) (hf : Continuous f)
    (T α β : ℝ) (hT : 0 < T) (hα0 : 0 ≤ α) (hα1 : α ≤ 1) (hβ0 : 0 ≤ β) (hβ1 : β ≤ 1)
    (L : ℕ) (hL : 0 < L) (ε' : ℝ)
    (hε : ∀ x ∈ Set.Icc 0 T ×ˢ Set.Icc 0 T, ∀ y ∈ Set.Icc 0 T ×ˢ Set.Icc 0 T,
      dist x y ≤ T / L → ‖f x - f y‖ ≤ ε') :
    ‖(∫ θ₁ in (0 : ℝ)..T, ∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂)) - shiftedRiemannSumNecSuf f T α β L‖
      ≤ T ^ 2 * ε' := by
  set h : ℝ := T / L with hh_def
  have hLpos : (0 : ℝ) < L := by exact_mod_cast hL
  have hh : 0 < h := div_pos hT hLpos
  have hhL : h * L = T := by rw [hh_def]; field_simp
  -- 小区画の端点 `c k := h k`
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
  -- 標本点 `t_{k,l}`
  set t : ℕ → ℕ → ℝ × ℝ := fun k l => (h * (k + α), h * (l + β)) with ht_def
  -- 一行目: `C_{k,l}` は境界を除き正方形を分割する
  have hI : (∫ θ₁ in (0 : ℝ)..T, ∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂)) =
      ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
        ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), f (θ₁, θ₂) := by
    have hinner : ∀ θ₁ : ℝ, (∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂)) =
        ∑ l ∈ Finset.range L, ∫ θ₂ in c l..c (l + 1), f (θ₁, θ₂) := by
      intro θ₁
      rw [← hc0, ← hcL]
      exact (sum_integral_adjacent_intervals fun l _ => (hsec θ₁).intervalIntegrable _ _).symm
    calc (∫ θ₁ in (0 : ℝ)..T, ∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂))
        = ∑ k ∈ Finset.range L, ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂) := by
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
  have hS : shiftedRiemannSumNecSuf f T α β L =
      ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
        ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), f (t k l) := by
    simp only [integral_const, hlen]
    rw [shiftedRiemannSumNecSuf, Finset.smul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [pow_two, mul_smul]
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
  -- 各小区画での一様評価
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
            obtain ⟨h1, h1x, h1t⟩ := cell_sample_close_necSuf hh hα0 hα1 hk' hθ₁
            obtain ⟨h2, h2x, h2t⟩ := cell_sample_close_necSuf hh hβ0 hβ1 hl' hθ₂
            rw [hhL] at h1x h1t h2x h2t
            refine hε (θ₁, θ₂) ⟨h1x, h2x⟩ (t k l) ⟨h1t, h2t⟩ ?_
            rw [Prod.dist_eq, Real.dist_eq, Real.dist_eq]
            exact max_le h1 h2)
        rw [hlen, abs_of_pos hh] at hin
        exact hin)
    rw [hlen, abs_of_pos hh] at hbound
    exact hbound
  calc ‖(∫ θ₁ in (0 : ℝ)..T, ∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂)) - shiftedRiemannSumNecSuf f T α β L‖
      = ‖∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
          ∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), (f (θ₁, θ₂) - f (t k l))‖ := by
        rw [hI, hS, ← Finset.sum_sub_distrib]
        simp_rw [← Finset.sum_sub_distrib, hdiff]
    -- 積分の三角不等式（有限和のノルム）
    _ ≤ ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L,
          ‖∫ θ₁ in c k..c (k + 1), ∫ θ₂ in c l..c (l + 1), (f (θ₁, θ₂) - f (t k l))‖ :=
        (norm_sum_le _ _).trans (Finset.sum_le_sum fun k _ => norm_sum_le _ _)
    -- 各小区画での一様評価
    _ ≤ ∑ k ∈ Finset.range L, ∑ l ∈ Finset.range L, ε' * h * h :=
        Finset.sum_le_sum fun k hk => Finset.sum_le_sum fun l hl => hcell k hk l hl
    -- 小区画の面積の和は `T²`
    _ = T ^ 2 * ε' := by
        simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul]
        rw [← hhL]; ring

/-- `claim_shifted_mode_riemann_sums` の後半の必要十分版: 標本点和は `[0,T]²` 上の積分へ収束する。 -/
theorem shiftedRiemannSum_tendsto_necSuf (f : ℝ × ℝ → E) (hf : Continuous f)
    (T α β : ℝ) (hT : 0 < T) (hα0 : 0 ≤ α) (hα1 : α ≤ 1) (hβ0 : 0 ≤ β) (hβ1 : β ≤ 1) :
    Tendsto (shiftedRiemannSumNecSuf f T α β) atTop
      (𝓝 (∫ θ₁ in (0 : ℝ)..T, ∫ θ₂ in (0 : ℝ)..T, f (θ₁, θ₂))) := by
  rw [Metric.tendsto_atTop]
  intro ε hε
  have hT2 : 0 < T ^ 2 := by positivity
  -- `[0,T]²` 上の一様連続性から `η`
  have hunif : UniformContinuousOn f (Set.Icc 0 T ×ˢ Set.Icc 0 T) :=
    (isCompact_Icc.prod isCompact_Icc).uniformContinuousOn_of_continuous hf.continuousOn
  obtain ⟨η, hη, hu⟩ := Metric.uniformContinuousOn_iff.1 hunif (ε / (2 * T ^ 2)) (by positivity)
  -- Archimedes 性から `T/L₀ < η`
  obtain ⟨L₀, hL₀⟩ := exists_nat_gt (T / η)
  refine ⟨L₀, fun L hL => ?_⟩
  have hL₀pos : (0 : ℝ) < L₀ := lt_trans (div_pos hT hη) hL₀
  have hLpos' : (0 : ℝ) < L := lt_of_lt_of_le hL₀pos (by exact_mod_cast hL)
  have hLpos : 0 < L := by exact_mod_cast hLpos'
  have hstep : T / L < η := by
    calc T / L ≤ T / L₀ := div_le_div_of_nonneg_left hT.le hL₀pos (by exact_mod_cast hL)
      _ < η := by rw [div_lt_iff₀ hL₀pos]; rw [div_lt_iff₀ hη] at hL₀; linarith
  have hbound := shiftedRiemannSum_error_le_necSuf f hf T α β hT hα0 hα1 hβ0 hβ1 L hLpos
    (ε / (2 * T ^ 2)) (fun x hx y hy hxy => by
      rw [← dist_eq_norm]
      exact (hu x hx y hy (lt_of_le_of_lt hxy hstep)).le)
  rw [dist_eq_norm, norm_sub_rev]
  calc _ ≤ T ^ 2 * (ε / (2 * T ^ 2)) := hbound
    _ = ε / 2 := by field_simp
    _ < ε := by linarith

end Ising2DLambda.NecSuf.RealEscape
