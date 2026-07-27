/-
# 等分割リーマン和の積分への収束（抽象版）

対応する人手証明のラベル: `riemann_sum_to_integral`
具体版: `Ising2D/Part012/Theorem004_RiemannSumToIntegral.lean`

人手証明（`structured-latex/content/012_free_energy.ts` の
`freeenergy_004_theorem_riemann_sum_to_integral`）は

  `g : ℝ → ℝ` 連続・周期 `2π`、`δ ∈ [0,1)`、`t^{(M)}_μ := 2π(μ-δ)/M`
  ⟹ `|(1/M)Σ_{μ=1}^{M} g(t^{(M)}_μ) - (1/2π)∫_0^{2π} g| ≤ ω(2π/M) → 0`

を主張する。**本証明で実数解析へ移行するのはこの 1 点だけ**である。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

抽象化して分かったことは 3 つある。

1. **区間 `[0, 2π]` である必要はまったくない。** 任意の有界閉区間 `[a,b]`（`a ≤ b`）でよい。
   `2π` は「分点の幅 `(b-a)/M`」と「平均を取るときの割り算」にしか現れない。
2. **`g` の周期性は効いていない。** 人手証明は最後の括弧で
   「`δ = 0` のとき `t^{(M)}_M = 2π` が区間 `[0,2π]` の端点として現れることを許すために
   周期性を使っている」と述べているが、代表点は閉区間 `I_μ` に属していればよく、
   それが `[a,b]` の端点であっても評価はまったく変わらない。
   実際、以下の証明はどこでも `g(b) = g(a)` を使っていない。
   （周期性は人手証明の後段、`γ` に適用する場面でも本質的には不要である。）
3. **`δ ∈ [0,1)` の右端が開である必要はない。** `δ ∈ [0,1]` で通る。
   `δ = 1` は各小区間の**左**端点を代表点に取る場合にあたる。
   人手証明が `0 < 1-δ` を使うのは `t^{(M)}_μ` が `I_μ` の左端より真に大きいことを言うためだが、
   評価に必要なのは `t^{(M)}_μ ∈ I_μ`（閉区間）だけである。

残る本質は次の 3 つで、これは人手証明が (R1)(R2) として明示した外部事実と一致する。

* `g` が `[a,b]` 上連続であること（区間可積分性と一様連続性のため）
* 代表点が対応する小区間に属すること
* 積分の区間加法性・定数の積分・`|∫_I h| ≤ |I| · sup_I |h|`
-/
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Topology.UniformSpace.HeineCantor

namespace Ising2D.Abstract

open Set Filter MeasureTheory
open scoped Topology

/-! ## 分点と代表点 -/

/-- `[a,b]` を `M` 等分した分点 `a + (b-a)k/M`。人手証明の `I_μ = [2π(μ-1)/M, 2πμ/M]` の端点。 -/
noncomputable def node (a b : ℝ) (M : ℕ) (k : ℕ) : ℝ := a + (b - a) * k / M

/-- 第 `k` 小区間 `[node k, node (k+1)]` の代表点。
人手証明の `t^{(M)}_μ = 2π(μ-δ)/M` に `μ = k+1`, `a = 0`, `b = 2π` で対応する。 -/
noncomputable def tag (a b : ℝ) (M : ℕ) (δ : ℝ) (k : ℕ) : ℝ :=
  a + (b - a) * ((k : ℝ) + 1 - δ) / M

variable {a b : ℝ} {M : ℕ}

@[simp]
theorem node_zero : node a b M 0 = a := by simp [node]

theorem node_last (hM : M ≠ 0) : node a b M M = b := by
  have h : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [node, mul_div_assoc, div_self h, mul_one]
  ring

theorem node_succ_sub (hM : M ≠ 0) (k : ℕ) :
    node a b M (k + 1) - node a b M k = (b - a) / M := by
  have h : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.2 hM
  rw [node, node]
  push_cast
  field_simp
  ring

theorem node_mono (hab : a ≤ b) (hM : M ≠ 0) {j k : ℕ} (h : j ≤ k) :
    node a b M j ≤ node a b M k := by
  have hM' : (0 : ℝ) < M := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hj : (j : ℝ) ≤ k := by exact_mod_cast h
  have hba : (0 : ℝ) ≤ b - a := sub_nonneg.2 hab
  unfold node
  gcongr

theorem node_mem_Icc (hab : a ≤ b) (hM : M ≠ 0) {k : ℕ} (hk : k ≤ M) :
    node a b M k ∈ Icc a b := by
  refine ⟨?_, ?_⟩
  · simpa using node_mono hab hM (Nat.zero_le k)
  · simpa [node_last hM] using node_mono hab hM hk

theorem node_le_tag (hab : a ≤ b) (hM : M ≠ 0) {δ : ℝ} (hδ1 : δ ≤ 1) (k : ℕ) :
    node a b M k ≤ tag a b M δ k := by
  have hM' : (0 : ℝ) < M := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hba : (0 : ℝ) ≤ b - a := sub_nonneg.2 hab
  have hk : (k : ℝ) ≤ (k : ℝ) + 1 - δ := by linarith
  unfold node tag
  gcongr

theorem tag_le_node_succ (hab : a ≤ b) (hM : M ≠ 0) {δ : ℝ} (hδ0 : 0 ≤ δ) (k : ℕ) :
    tag a b M δ k ≤ node a b M (k + 1) := by
  have hM' : (0 : ℝ) < M := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hba : (0 : ℝ) ≤ b - a := sub_nonneg.2 hab
  have hk : (k : ℝ) + 1 - δ ≤ ((k + 1 : ℕ) : ℝ) := by push_cast; linarith
  unfold node tag
  gcongr

/-! ## 主定理: 誤差評価 -/

/-- **人手証明 Step 1〜3 に 1 対 1 対応する誤差評価**（任意の有界閉区間・周期性不要版）。

`ε` は「区間 `[a,b]` 内で距離が `(b-a)/M` 以下の 2 点での値の差の上界」であり、
人手証明の `ω(2π/M)` を仮定の形で持ったもの。 -/
theorem abs_integral_sub_riemann_sum_le
    {g : ℝ → ℝ} (hg : Continuous g) (hab : a ≤ b)
    {δ : ℝ} (hδ0 : 0 ≤ δ) (hδ1 : δ ≤ 1) (hM : M ≠ 0) {ε : ℝ}
    (hε : ∀ s ∈ Icc a b, ∀ t ∈ Icc a b, |s - t| ≤ (b - a) / M → |g s - g t| ≤ ε) :
    |(∫ t in a..b, g t) - (b - a) / M * ∑ k ∈ Finset.range M, g (tag a b M δ k)|
      ≤ (b - a) * ε := by
  have hM' : (0 : ℝ) < M := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hba : (0 : ℝ) ≤ b - a := sub_nonneg.2 hab
  have hL : (0 : ℝ) ≤ (b - a) / M := by positivity
  -- (R2) 区間加法性
  have hsplit : ∑ k ∈ Finset.range M, ∫ t in (node a b M k)..(node a b M (k + 1)), g t
      = ∫ t in a..b, g t := by
    have h := intervalIntegral.sum_integral_adjacent_intervals
      (f := g) (μ := volume) (a := node a b M) (n := M)
      (fun k _ => hg.intervalIntegrable _ _)
    rw [h, node_zero, node_last hM]
  -- 各小区間での誤差（人手証明 Step 2）
  have hterm : ∀ k ∈ Finset.range M,
      |(∫ t in (node a b M k)..(node a b M (k + 1)), g t)
        - (b - a) / M * g (tag a b M δ k)| ≤ (b - a) / M * ε := by
    intro k hk
    have hkM : k + 1 ≤ M := Finset.mem_range.1 hk
    have hkM' : k ≤ M := Nat.le_of_succ_le hkM
    have huv : node a b M (k + 1) - node a b M k = (b - a) / M := node_succ_sub hM k
    have hle : node a b M k ≤ node a b M (k + 1) := node_mono hab hM (Nat.le_succ k)
    have hu : node a b M k ∈ Icc a b := node_mem_Icc hab hM hkM'
    have hv : node a b M (k + 1) ∈ Icc a b := node_mem_Icc hab hM hkM
    have hc1 : node a b M k ≤ tag a b M δ k := node_le_tag hab hM hδ1 k
    have hc2 : tag a b M δ k ≤ node a b M (k + 1) := tag_le_node_succ hab hM hδ0 k
    have hcmem : tag a b M δ k ∈ Icc a b := ⟨le_trans hu.1 hc1, le_trans hc2 hv.2⟩
    have hrw : (∫ t in (node a b M k)..(node a b M (k + 1)), g t)
        - (b - a) / M * g (tag a b M δ k)
        = ∫ t in (node a b M k)..(node a b M (k + 1)), (g t - g (tag a b M δ k)) := by
      rw [intervalIntegral.integral_sub (hg.intervalIntegrable _ _)
        (intervalIntegrable_const), intervalIntegral.integral_const, huv]
      simp [smul_eq_mul]
    rw [hrw]
    have hbound : ∀ t ∈ Set.uIoc (node a b M k) (node a b M (k + 1)),
        ‖g t - g (tag a b M δ k)‖ ≤ ε := by
      intro t ht
      rw [Set.uIoc_of_le hle] at ht
      have htmem : t ∈ Icc a b := ⟨le_trans hu.1 (le_of_lt ht.1), le_trans ht.2 hv.2⟩
      have hdist : |t - tag a b M δ k| ≤ (b - a) / M :=
        abs_le.2 ⟨by linarith [ht.1, hc2], by linarith [ht.2, hc1]⟩
      simpa [Real.norm_eq_abs] using hε t htmem _ hcmem hdist
    have hnorm := intervalIntegral.norm_integral_le_of_norm_le_const hbound
    rw [Real.norm_eq_abs] at hnorm
    have habs : |node a b M (k + 1) - node a b M k| = (b - a) / M := by
      rw [huv, abs_of_nonneg hL]
    rw [habs] at hnorm
    linarith
  -- 総和（人手証明 Step 3）
  have hcollect : (∫ t in a..b, g t) - (b - a) / M * ∑ k ∈ Finset.range M, g (tag a b M δ k)
      = ∑ k ∈ Finset.range M, ((∫ t in (node a b M k)..(node a b M (k + 1)), g t)
          - (b - a) / M * g (tag a b M δ k)) := by
    rw [Finset.sum_sub_distrib, hsplit, ← Finset.mul_sum]
  rw [hcollect]
  calc |∑ k ∈ Finset.range M, ((∫ t in (node a b M k)..(node a b M (k + 1)), g t)
          - (b - a) / M * g (tag a b M δ k))|
      ≤ ∑ k ∈ Finset.range M, |(∫ t in (node a b M k)..(node a b M (k + 1)), g t)
          - (b - a) / M * g (tag a b M δ k)| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ _k ∈ Finset.range M, (b - a) / M * ε := Finset.sum_le_sum hterm
    _ = (b - a) * ε := by
        have hMne : (M : ℝ) ≠ 0 := ne_of_gt hM'
        rw [Finset.sum_const, Finset.card_range, nsmul_eq_mul]
        field_simp

/-! ## 連続度 `ω` -/

/-- `g` の `[a,b]` 上の連続度 `ω(h)`（人手証明の `ω`）。 -/
noncomputable def modulus (g : ℝ → ℝ) (a b h : ℝ) : ℝ :=
  sSup {r : ℝ | ∃ s ∈ Icc a b, ∃ t ∈ Icc a b, |s - t| ≤ h ∧ r = |g s - g t|}

theorem bddAbove_modulusSet {g : ℝ → ℝ} (hg : Continuous g) (a b h : ℝ) :
    BddAbove {r : ℝ | ∃ s ∈ Icc a b, ∃ t ∈ Icc a b, |s - t| ≤ h ∧ r = |g s - g t|} := by
  obtain ⟨C, hC⟩ := (isCompact_Icc (a := a) (b := b)).exists_bound_of_continuousOn
    hg.continuousOn
  refine ⟨2 * C, ?_⟩
  rintro r ⟨s, hs, t, ht, -, rfl⟩
  have h1 := hC s hs
  have h2 := hC t ht
  rw [Real.norm_eq_abs] at h1 h2
  have h3 : |g s - g t| ≤ |g s| + |g t| := by
    simpa [sub_eq_add_neg, abs_neg] using abs_add_le (g s) (-g t)
  linarith

theorem le_modulus {g : ℝ → ℝ} (hg : Continuous g) {a b h s t : ℝ}
    (hs : s ∈ Icc a b) (ht : t ∈ Icc a b) (hst : |s - t| ≤ h) :
    |g s - g t| ≤ modulus g a b h :=
  le_csSup (bddAbove_modulusSet hg a b h) ⟨s, hs, t, ht, hst, rfl⟩

theorem modulus_nonneg {g : ℝ → ℝ} (hg : Continuous g) {a b h : ℝ} (hab : a ≤ b) (hh : 0 ≤ h) :
    0 ≤ modulus g a b h := by
  have h0 := le_modulus hg (g := g) (h := h) (s := a) (t := a)
    ⟨le_refl a, hab⟩ ⟨le_refl a, hab⟩ (by simpa using hh)
  simpa using h0

theorem modulus_le {g : ℝ → ℝ} {a b h ε : ℝ} (hab : a ≤ b) (hh : 0 ≤ h)
    (hε : ∀ s ∈ Icc a b, ∀ t ∈ Icc a b, |s - t| ≤ h → |g s - g t| ≤ ε) :
    modulus g a b h ≤ ε := by
  refine csSup_le ⟨0, ⟨a, ⟨le_refl a, hab⟩, a, ⟨le_refl a, hab⟩, by simpa using hh, by simp⟩⟩ ?_
  rintro r ⟨s, hs, t, ht, hst, rfl⟩
  exact hε s hs t ht hst

/-- **人手証明 statement の評価そのもの**（`ε` を `ω` に取った形）。 -/
theorem abs_integral_sub_riemann_sum_le_modulus
    {g : ℝ → ℝ} (hg : Continuous g) (hab : a ≤ b)
    {δ : ℝ} (hδ0 : 0 ≤ δ) (hδ1 : δ ≤ 1) (hM : M ≠ 0) :
    |(∫ t in a..b, g t) - (b - a) / M * ∑ k ∈ Finset.range M, g (tag a b M δ k)|
      ≤ (b - a) * modulus g a b ((b - a) / M) :=
  abs_integral_sub_riemann_sum_le hg hab hδ0 hδ1 hM
    (fun _ hs _ ht hst => le_modulus hg hs ht hst)

/-- **(R1) Heine–Cantor の帰結**: `ω(( b-a)/M) → 0`。 -/
theorem tendsto_modulus_atTop {g : ℝ → ℝ} (hg : Continuous g) (hab : a ≤ b) :
    Tendsto (fun M : ℕ => modulus g a b ((b - a) / M)) atTop (𝓝 0) := by
  have hba : (0 : ℝ) ≤ b - a := sub_nonneg.2 hab
  rw [Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨δ₀, hδ₀pos, hδ₀⟩ := Metric.uniformContinuousOn_iff.1
    ((isCompact_Icc (a := a) (b := b)).uniformContinuousOn_of_continuous hg.continuousOn)
    (ε / 2) (by linarith)
  obtain ⟨N, hN⟩ := exists_nat_gt ((b - a) / δ₀)
  refine ⟨N + 1, fun n hn => ?_⟩
  have hnpos : (0 : ℝ) < n := by
    have : 0 < n := lt_of_lt_of_le (Nat.succ_pos N) hn
    exact_mod_cast this
  have hlt : (b - a) / n < δ₀ := by
    have hNn : ((N : ℝ)) < n := by
      have : (N : ℕ) < n := lt_of_lt_of_le (Nat.lt_succ_self N) hn
      exact_mod_cast this
    have h1 : (b - a) / δ₀ < n := lt_trans hN hNn
    rw [div_lt_iff₀ hδ₀pos] at h1
    rw [div_lt_iff₀ hnpos]
    linarith
  have hhnn : (0 : ℝ) ≤ (b - a) / n := by positivity
  have hle : modulus g a b ((b - a) / n) ≤ ε / 2 := by
    refine modulus_le hab hhnn fun s hs t ht hst => ?_
    have hd : dist s t < δ₀ := by
      rw [Real.dist_eq]
      linarith
    have := hδ₀ s hs t ht hd
    rw [Real.dist_eq] at this
    linarith
  have h0 := modulus_nonneg hg hab (h := (b - a) / n) hhnn
  rw [Real.dist_eq, sub_zero, abs_of_nonneg h0]
  linarith

/-- **抽象版の収束**: 等分割リーマン和は積分の平均値に収束する。
周期性は不要、区間は任意の `[a,b]`（`a < b`）、`δ ∈ [0,1]`。 -/
theorem tendsto_riemann_sum {g : ℝ → ℝ} (hg : Continuous g) (hab : a < b)
    {δ : ℝ} (hδ0 : 0 ≤ δ) (hδ1 : δ ≤ 1) :
    Tendsto (fun M : ℕ => (1 / (M : ℝ)) * ∑ k ∈ Finset.range M, g (tag a b M δ k))
      atTop (𝓝 ((1 / (b - a)) * ∫ t in a..b, g t)) := by
  have hba : (0 : ℝ) < b - a := sub_pos.2 hab
  rw [tendsto_iff_dist_tendsto_zero]
  refine squeeze_zero' (Filter.Eventually.of_forall fun _ => dist_nonneg) ?_
    (tendsto_modulus_atTop hg (le_of_lt hab))
  filter_upwards [Filter.eventually_ge_atTop 1] with M hM1
  have hM : M ≠ 0 := Nat.one_le_iff_ne_zero.1 hM1
  have hMpos : (0 : ℝ) < M := by exact_mod_cast Nat.pos_of_ne_zero hM
  have hMne : (M : ℝ) ≠ 0 := ne_of_gt hMpos
  have hbane : b - a ≠ 0 := ne_of_gt hba
  have hmain := abs_integral_sub_riemann_sum_le_modulus hg (le_of_lt hab) hδ0 hδ1 hM
  set S := ∑ k ∈ Finset.range M, g (tag a b M δ k) with hS
  set I := ∫ t in a..b, g t with hI
  have heq : (1 / (M : ℝ)) * S - (1 / (b - a)) * I
      = -(1 / (b - a)) * (I - (b - a) / M * S) := by
    field_simp
    ring
  rw [Real.dist_eq, heq, abs_mul, abs_neg,
    abs_of_pos (show (0 : ℝ) < 1 / (b - a) by positivity)]
  calc (1 / (b - a)) * |I - (b - a) / M * S|
      ≤ (1 / (b - a)) * ((b - a) * modulus g a b ((b - a) / M)) :=
        mul_le_mul_of_nonneg_left hmain (by positivity)
    _ = modulus g a b ((b - a) / M) := by field_simp

end Ising2D.Abstract
