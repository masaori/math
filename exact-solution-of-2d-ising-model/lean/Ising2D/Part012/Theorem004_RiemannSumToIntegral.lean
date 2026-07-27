/-
# 等間隔点の平均は積分に収束する（★実数解析への移行点）

人手証明（正本は `structured-latex/content/012_free_energy.ts`）:
- `freeenergy_004_theorem_riemann_sum_to_integral`（ラベル `riemann_sum_to_integral`）

**具体版**（人手証明と同じ抽象度: 区間 `[0,2π]`、周期 `2π` の連続関数、`δ ∈ [0,1)`）。
抽象版は `Ising2D/Abstract/RiemannSum.lean`
（`Ising2D.Abstract.abs_integral_sub_riemann_sum_le` /
`Ising2D.Abstract.abs_integral_sub_riemann_sum_le_modulus` /
`Ising2D.Abstract.tendsto_riemann_sum`）。
本ファイルの主張はすべて抽象版の特殊化として導出してある。

**本証明で実数解析（Riemann 積分）へ移行するのはこの主張だけである。**
人手証明が (R1)(R2) として挙げた外部事実に対応する mathlib の補題:

| 人手証明 | mathlib |
| --- | --- |
| (R1) Heine–Cantor（有界閉区間上の連続関数は一様連続） | `IsCompact.uniformContinuousOn_of_continuous`（`isCompact_Icc` と併用）、`Metric.uniformContinuousOn_iff` |
| (R2) 連続関数の Riemann 可積分性 | `Continuous.intervalIntegrable` |
| (R2) 区間加法性 `∫_a^c = ∫_a^b + ∫_b^c` | `intervalIntegral.sum_integral_adjacent_intervals` |
| (R2) 評価 `|∫_I g| ≤ |I| sup_I |g|` | `intervalIntegral.norm_integral_le_of_norm_le_const` |
| (R2) 定数の積分 `∫_a^b λ dt = λ(b-a)` | `intervalIntegral.integral_const` |

すなわち **(R1)(R2) はいずれも mathlib に存在し、外部から新たに公理を持ち込む必要は無かった。**

## 添字について

人手証明は `μ = 1,…,M` で和を取る。Lean 側の抽象版は `k ∈ Finset.range M`（`μ = k+1`）で
書いてあるので、本ファイルで `Finset.Icc 1 M` の形へ移し替える
（`sum_Icc_eq_sum_range_tag`）。値は同じである。
-/
import Ising2D.Abstract.RiemannSum

namespace Ising2D

open Filter MeasureTheory
open scoped Topology

/-- 人手証明の代表点 `t^{(M)}_μ := 2π(μ-δ)/M`。 -/
noncomputable def tagPoint (δ : ℝ) (M : ℕ) (μ : ℕ) : ℝ := 2 * Real.pi * ((μ : ℝ) - δ) / M

/-- 抽象版の代表点（`a = 0`, `b = 2π`, `μ = k+1`）と一致することの確認。 -/
theorem tag_eq_tagPoint (δ : ℝ) (M : ℕ) (k : ℕ) :
    Abstract.tag 0 (2 * Real.pi) M δ k = tagPoint δ M (k + 1) := by
  unfold Abstract.tag tagPoint
  push_cast
  ring

/-- 添字の付け替え `μ = k+1`（`Finset.Icc 1 M` ↔ `Finset.range M`）。 -/
theorem sum_Icc_one_eq_sum_range (f : ℕ → ℝ) (M : ℕ) :
    ∑ μ ∈ Finset.Icc 1 M, f μ = ∑ k ∈ Finset.range M, f (k + 1) := by
  induction M with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ← ih, ← Finset.Ico_add_one_right_eq_Icc,
      ← Finset.Ico_add_one_right_eq_Icc, Finset.sum_Ico_succ_top (by omega)]

/-- 上を代表点に適用した形。 -/
theorem sum_Icc_eq_sum_range_tag (g : ℝ → ℝ) (δ : ℝ) (M : ℕ) :
    ∑ μ ∈ Finset.Icc 1 M, g (tagPoint δ M μ)
      = ∑ k ∈ Finset.range M, g (Abstract.tag 0 (2 * Real.pi) M δ k) := by
  rw [sum_Icc_one_eq_sum_range (fun μ => g (tagPoint δ M μ)) M]
  exact Finset.sum_congr rfl fun k _ => by rw [tag_eq_tagPoint]

/-- **人手証明 `riemann_sum_to_integral` の誤差評価そのもの**:
`|(1/M)Σ_{μ=1}^{M} g(t^{(M)}_μ) - (1/2π)∫_0^{2π} g| ≤ ω(2π/M)`。

`ω` は `Ising2D.Abstract.modulus g 0 (2π) (2π/M)`（人手証明の連続度の定義そのまま）。 -/
theorem riemann_sum_to_integral_error
    {g : ℝ → ℝ} (hg : Continuous g) {δ : ℝ} (hδ0 : 0 ≤ δ) (hδ1 : δ < 1)
    {M : ℕ} (hM : M ≠ 0) :
    |1 / (M : ℝ) * ∑ μ ∈ Finset.Icc 1 M, g (tagPoint δ M μ)
      - 1 / (2 * Real.pi) * ∫ t in (0:ℝ)..(2 * Real.pi), g t|
      ≤ Abstract.modulus g 0 (2 * Real.pi) (2 * Real.pi / M) := by
  have hpi : (0 : ℝ) < 2 * Real.pi := by positivity
  have hMpos : (0 : ℝ) < M := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hmain := Abstract.abs_integral_sub_riemann_sum_le_modulus (g := g) (a := 0)
    (b := 2 * Real.pi) hg (le_of_lt hpi) hδ0 (le_of_lt hδ1) hM
  simp only [sub_zero] at hmain
  rw [sum_Icc_eq_sum_range_tag]
  have hMne : (M : ℝ) ≠ 0 := ne_of_gt hMpos
  have hpine : (2 : ℝ) * Real.pi ≠ 0 := ne_of_gt hpi
  set S := ∑ k ∈ Finset.range M, g (Abstract.tag 0 (2 * Real.pi) M δ k) with hS
  set I := ∫ t in (0:ℝ)..(2 * Real.pi), g t with hI
  have hrw : 1 / (M : ℝ) * S - 1 / (2 * Real.pi) * I
      = -(1 / (2 * Real.pi)) * (I - 2 * Real.pi / M * S) := by
    field_simp
    ring
  rw [hrw, abs_mul, abs_neg, abs_of_pos (show (0:ℝ) < 1 / (2 * Real.pi) by positivity)]
  calc 1 / (2 * Real.pi) * |I - 2 * Real.pi / M * S|
      ≤ 1 / (2 * Real.pi) * (2 * Real.pi * Abstract.modulus g 0 (2 * Real.pi)
          (2 * Real.pi / M)) := mul_le_mul_of_nonneg_left hmain (by positivity)
    _ = Abstract.modulus g 0 (2 * Real.pi) (2 * Real.pi / M) := by field_simp

/-- **(R1) の帰結**: 連続度 `ω(2π/M)` は `M → ∞` で `0` に収束する。 -/
theorem tendsto_modulus_gamma {g : ℝ → ℝ} (hg : Continuous g) :
    Tendsto (fun M : ℕ => Abstract.modulus g 0 (2 * Real.pi) (2 * Real.pi / M))
      atTop (𝓝 0) := by
  have hpi : (0 : ℝ) ≤ 2 * Real.pi := by positivity
  have h := Abstract.tendsto_modulus_atTop (g := g) (a := 0) (b := 2 * Real.pi) hg hpi
  simpa using h

/-- **人手証明 `riemann_sum_to_integral` の結論**:
`(1/M)Σ_{μ=1}^{M} g(t^{(M)}_μ) → (1/2π)∫_0^{2π} g`。

`δ ∈ [0,1)` は任意なので、整数運動量（`δ = 0`）でも半整数運動量（`δ = 1/2`）でも
極限は同じ値である（`riemann_sum_to_integral_indep_delta`）。 -/
theorem riemann_sum_to_integral
    {g : ℝ → ℝ} (hg : Continuous g) {δ : ℝ} (hδ0 : 0 ≤ δ) (hδ1 : δ < 1) :
    Tendsto (fun M : ℕ => 1 / (M : ℝ) * ∑ μ ∈ Finset.Icc 1 M, g (tagPoint δ M μ))
      atTop (𝓝 (1 / (2 * Real.pi) * ∫ t in (0:ℝ)..(2 * Real.pi), g t)) := by
  have hpi : (0 : ℝ) < 2 * Real.pi := by positivity
  have h := Abstract.tendsto_riemann_sum (g := g) (a := 0) (b := 2 * Real.pi) hg
    (by simpa using hpi) hδ0 (le_of_lt hδ1)
  simp only [sub_zero] at h
  refine h.congr fun M => ?_
  rw [sum_Icc_eq_sum_range_tag]

/-- 人手証明の「とくに `δ = 0` と `δ = 1/2` のどちらでも極限は同じ値である」。 -/
theorem riemann_sum_to_integral_indep_delta
    {g : ℝ → ℝ} (hg : Continuous g) {δ₁ δ₂ : ℝ}
    (h1 : 0 ≤ δ₁) (h1' : δ₁ < 1) (h2 : 0 ≤ δ₂) (h2' : δ₂ < 1) {L₁ L₂ : ℝ}
    (hL₁ : Tendsto (fun M : ℕ => 1 / (M : ℝ) * ∑ μ ∈ Finset.Icc 1 M, g (tagPoint δ₁ M μ))
      atTop (𝓝 L₁))
    (hL₂ : Tendsto (fun M : ℕ => 1 / (M : ℝ) * ∑ μ ∈ Finset.Icc 1 M, g (tagPoint δ₂ M μ))
      atTop (𝓝 L₂)) : L₁ = L₂ := by
  have e1 := tendsto_nhds_unique hL₁ (riemann_sum_to_integral hg h1 h1')
  have e2 := tendsto_nhds_unique hL₂ (riemann_sum_to_integral hg h2 h2')
  rw [e1, e2]

end Ising2D
