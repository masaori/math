/-
# 積分記号下の微分（Leibniz の規則）— 抽象版

対応する人手証明のラベル: `remark_real_analysis_escape_chapter_E` の **(R5)**、および
それを使う `second_derivative_log_divergence`
（正本は `structured-latex/content/020_critical_point.ts`）

具体版: `Ising2D/Part020/Theorem011_SecondDerivativeLogDivergence.lean`

## 人手証明が外から持ち込むと宣言している事実と、mathlib の対応

人手証明は 020 章で追加する実数解析の事実を (R3)〜(R6) の 4 つだけに限定している。
それぞれの mathlib での所在は次のとおり（調査結果。見つからなかったものは無い）。

| 原文 | 内容 | mathlib |
| --- | --- | --- |
| (R3) 線型性 | `∫(λg+νh) = λ∫g+ν∫h` | `intervalIntegral.integral_add`, `integral_smul`, `integral_sub` |
| (R3) 単調性 | 各点で `g ≤ h` ⇒ `∫g ≤ ∫h` | `intervalIntegral.integral_mono_on` |
| (R4) 微分積分学の基本定理 | `F' = g` 連続 ⇒ `∫_a^b g = F(b)-F(a)` | `intervalIntegral.integral_eq_sub_of_hasDerivAt` |
| (R5) 積分記号下の微分 | 下記 | **そのままの形は無い**。`intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le`（優関数版）から本ファイルで導く |
| (R6) 置換積分（`θ ↦ 2π-θ`） | `∫_a^b g(d-t)dt = ∫_{d-b}^{d-a} g` | `intervalIntegral.integral_comp_sub_left` |

**(R5) だけが mathlib に「連続性だけを仮定した形」で無い。** mathlib が持っているのは
優関数（dominating function）を明示的に与える形
`intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le`
（`Mathlib/Analysis/Calculus/ParametricIntervalIntegral.lean`）である。
人手証明の (R5) は「有界閉長方形上で連続」という仮定なので、
**コンパクト集合上の連続関数が有界であること**から優関数を定数として取れば導ける。
本ファイルはその導出を行う。

探して見つからなかった名前（参考）: `intervalIntegral.hasDerivAt_integral_of_continuousOn`,
`intervalIntegral.deriv_integral`, `hasDerivAt_integral_of_continuous`（いずれも存在しない）。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明は (R5) を `[a,b]×[x_1,x_2]`（有界閉長方形）で述べているが、効いているのは

* 積分区間がコンパクトであること
* パラメータ `x` の動く範囲が `x_0` の**近傍**であること（閉区間である必要はない）
* `g` と `∂g/∂x` がその上で連続であること

の 3 つだけである。`γ` が Ising 模型に由来することも、`arsinh` で書けることも、
被積分関数が `θ` について偶関数であることも効いていない。
-/
import Mathlib.Analysis.Calculus.ParametricIntervalIntegral
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

namespace Ising2D.Abstract

open MeasureTheory Metric Set intervalIntegral
open scoped Topology Interval

/-- **抽象版（人手証明の (R5)）**: `g` と `∂g/∂x` が `uIcc a b × s`（`s` は開集合）上で連続なら、
`x ↦ ∫_a^b g(t,x) dt` は `s` 上微分可能で、その導関数は `∫_a^b ∂g/∂x(t,x) dt`。

mathlib には連続性だけを仮定したこの形が無いので、優関数版
`intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le` から導く
（優関数はコンパクト長方形上での `∂g/∂x` の上限という定数で取れる）。 -/
theorem hasDerivAt_integral_of_continuousOn
    {g g' : ℝ → ℝ → ℝ} {a b x₀ : ℝ} {s : Set ℝ} (hs : IsOpen s) (hx₀ : x₀ ∈ s)
    (hg : ∀ x ∈ s, ContinuousOn (fun t => g t x) (uIcc a b))
    (hg' : ContinuousOn (fun p : ℝ × ℝ => g' p.1 p.2) (uIcc a b ×ˢ s))
    (hderiv : ∀ t ∈ uIcc a b, ∀ x ∈ s, HasDerivAt (fun y => g t y) (g' t x) x) :
    HasDerivAt (fun x => ∫ t in a..b, g t x) (∫ t in a..b, g' t x₀) x₀ := by
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.1 hs x₀ hx₀
  set r : ℝ := ε / 2 with hrdef
  have hr : 0 < r := by positivity
  have hcb : closedBall x₀ r ⊆ s := by
    refine subset_trans ?_ hball
    intro y hy
    simp only [Metric.mem_closedBall] at hy
    simp only [Metric.mem_ball]
    linarith [hy, hε]
  have hbs : ball x₀ r ⊆ s := subset_trans Metric.ball_subset_closedBall hcb
  have hKcompact : IsCompact (uIcc a b ×ˢ closedBall x₀ r) :=
    isCompact_uIcc.prod (isCompact_closedBall _ _)
  have hg'K : ContinuousOn (fun p : ℝ × ℝ => g' p.1 p.2) (uIcc a b ×ˢ closedBall x₀ r) :=
    hg'.mono (Set.prod_mono_right hcb)
  obtain ⟨C, hC⟩ := hKcompact.exists_bound_of_continuousOn hg'K
  -- 各仮定を確認する
  have hmeasSet : MeasurableSet (Ι a b) := measurableSet_uIoc
  have hF_meas : ∀ᶠ x in 𝓝 x₀,
      AEStronglyMeasurable (fun t => g t x) (volume.restrict (Ι a b)) := by
    filter_upwards [hs.mem_nhds hx₀] with x hx
    exact ((hg x hx).mono uIoc_subset_uIcc).aestronglyMeasurable hmeasSet
  have hF_int : IntervalIntegrable (fun t => g t x₀) volume a b :=
    (hg x₀ hx₀).intervalIntegrable
  have hg'cont : ContinuousOn (fun t => g' t x₀) (uIcc a b) := by
    have hmap : ContinuousOn (fun t : ℝ => (t, x₀)) (uIcc a b) := by fun_prop
    have := hg'.comp hmap (fun t ht => Set.mk_mem_prod ht hx₀)
    exact this
  have hF'_meas : AEStronglyMeasurable (fun t => g' t x₀) (volume.restrict (Ι a b)) :=
    (hg'cont.mono uIoc_subset_uIcc).aestronglyMeasurable hmeasSet
  have h_bound : ∀ᵐ t ∂(volume : Measure ℝ), t ∈ Ι a b →
      ∀ x ∈ ball x₀ r, ‖g' t x‖ ≤ C := by
    filter_upwards with t ht x hx
    exact hC (t, x) (Set.mk_mem_prod (uIoc_subset_uIcc ht) (Metric.ball_subset_closedBall hx))
  have h_diff : ∀ᵐ t ∂(volume : Measure ℝ), t ∈ Ι a b →
      ∀ x ∈ ball x₀ r, HasDerivAt (fun y => g t y) (g' t x) x := by
    filter_upwards with t ht x hx
    exact hderiv t (uIoc_subset_uIcc ht) x (hbs hx)
  exact (intervalIntegral.hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (bound := fun _ => C) (Metric.ball_mem_nhds x₀ hr) hF_meas hF_int hF'_meas h_bound
    intervalIntegrable_const h_diff).2

end Ising2D.Abstract
