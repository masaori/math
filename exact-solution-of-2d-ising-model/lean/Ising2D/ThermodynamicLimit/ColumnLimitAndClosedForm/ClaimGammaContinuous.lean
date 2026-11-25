/-
# `γ` は `ℝ` 上で連続（と、周期 `2π` をもつこと）

人手証明（正本は `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`）:
- `freeenergy_002_claim_gamma_is_continuous`（ラベル `gamma_is_continuous`。連続性だけを述べる）
- 周期 `2π` をもつことは、本文のどこからも使われないので参照用ノート
  `structured-latex/notes/claims_unused_by_chapter_goals_not_adopted.ts` の
  `note_freeenergy_002_claim_gamma_is_2pi_periodic_unused_by_chapter_goals` へ移してある。
  `gamma1R_periodic`・`gammaFn_periodic` はその内容の形式化である。

**具体版**（人手証明と同じ抽象度）。必要十分版は `Ising2D/NecSuf/Arcosh.lean` の
`Ising2D.NecSuf.continuous_arcosh_comp`（定義域は任意の位相空間でよい）。
`gamma_is_continuous` をその特殊化として得る導出は `ClaimGammaContinuousFromNecSuf.lean` の
`gamma_is_continuous_of_necSuf`。本ファイルは必要十分版を使わない。

人手証明の Step 1（`γ_1` の連続性）は `continuous_gamma1R`、Step 2（`arccosh` の `[1,∞)` 上の連続性）と
Step 3（合成）は `gamma_is_continuous` の証明の中の同名の段が対応する。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimGamma1LowerBound

namespace Ising2D

open Real

/-- 人手証明 Step 1: `γ_1` は連続（定数と `cos` の 1 次式）。全実数上の `cos` とその連続性、連続関数の積と差の
連続性は本文が `remark_real_analysis_escape_point` の (R0) として前提に置くもので、mathlib で受ける。 -/
theorem continuous_gamma1R (K : IsingConst) : Continuous (gamma1R K) := by
  unfold gamma1R
  exact continuous_const.sub (continuous_const.mul Real.continuous_cos)

/-- 参照用ノートの周期性（もと人手証明 Step 1 後半）: `γ_1` は周期 `2π`。 -/
theorem gamma1R_periodic (K : IsingConst) (θ : ℝ) :
    gamma1R K (θ + 2 * Real.pi) = gamma1R K θ := by
  simp [gamma1R, Real.cos_add_two_pi]

/-- **人手証明 `gamma_is_continuous`**: `γ` は `ℝ` 上連続。人手証明の Step 1・Step 2・Step 3 に
1 対 1 に対応する。連続関数の積・差・和・合成の連続性、
`√ : ℝ_{≥0} → ℝ` と `log : ℝ_{>0} → ℝ` の連続性は、本文が `remark_real_analysis_escape_point` の (R0) として
前提に置くもので、mathlib で受ける。定数関数・恒等写像の連続性と、連続写像を定義域の部分集合へ
制限しても連続であることは、本文では連続の定義から直ちに従うとしている段で、これも mathlib で受ける。 -/
theorem gamma_is_continuous (P : IsingParam) : Continuous (gammaFn P) := by
  -- Step 1: `γ_1 : ℝ → ℝ` は連続
  have hstep1 : Continuous (gamma1R P.const) := continuous_gamma1R P.const
  -- Step 2: `arccosh` は `[1,∞)` 上連続
  -- `def_arccosh` の右辺が定まることの鎖の一行目: `y ≥ 1` なら `y² − 1 ≥ 0`
  have hsq_nonneg : ∀ y ∈ Set.Ici (1 : ℝ), 0 ≤ y ^ 2 - 1 := fun y hy =>
    sub_nonneg.2 (one_le_pow₀ (Set.mem_Ici.1 hy))
  -- `[1,∞) → ℝ, y ↦ y² − 1` は連続（恒等写像の積と定数関数の差、`[1,∞)` への制限）。値は `ℝ_{≥0}` に入る
  have hmul : Continuous fun y : ℝ => y * y - 1 :=
    (continuous_id.mul continuous_id).sub continuous_const
  have hsq : ContinuousOn (fun y : ℝ => y ^ 2 - 1) (Set.Ici 1) :=
    hmul.continuousOn.congr fun y _ => by show y ^ 2 - 1 = y * y - 1; rw [sq y]
    -- `y² = y·y`
  -- `[1,∞) → ℝ, y ↦ √(y² − 1)` は連続（前の写像の値が `√ : ℝ_{≥0} → ℝ` の定義域に入るので、その連続性と合成）
  have hsqrt : ContinuousOn (fun y : ℝ => √(y ^ 2 - 1)) (Set.Ici 1) :=
    (Real.continuous_sqrt.continuousOn (s := Set.Ici 0)).comp hsq
      fun y hy => Set.mem_Ici.2 (hsq_nonneg y hy)
  -- `[1,∞) → ℝ, y ↦ y + √(y² − 1)` は連続（連続関数の和）
  have hsum : ContinuousOn (fun y : ℝ => y + √(y ^ 2 - 1)) (Set.Ici 1) :=
    continuousOn_id.add hsqrt
  -- `def_arccosh` の右辺が定まることの鎖の二行目: `y ≥ 1`, `√(y²−1) ≥ 0` から `y + √(y²−1) ≥ 1 > 0`。
  -- 値は `ℝ_{>0}` に入る
  have hpos : ∀ y ∈ Set.Ici (1 : ℝ), 0 < y + √(y ^ 2 - 1) := fun y hy =>
    lt_of_lt_of_le one_pos (le_add_of_le_of_nonneg hy (Real.sqrt_nonneg _))
  -- `arccosh : [1,∞) → ℝ` は連続（前の写像の値が `log : ℝ_{>0} → ℝ` の定義域に入るので、その連続性と合成）
  have hstep2 : ContinuousOn Real.arcosh (Set.Ici 1) := by
    show ContinuousOn (fun y : ℝ => Real.log (y + √(y ^ 2 - 1))) (Set.Ici 1)
    -- `def_arccosh`: `arccosh(y) = log(y + √(y²−1))`
    exact (Real.continuousOn_log.mono fun x hx => ne_of_gt (Set.mem_Ioi.1 hx)).comp hsum
      fun y hy => Set.mem_Ioi.2 (hpos y hy)
    -- `log : ℝ_{>0} → ℝ` の連続性（`ℝ_{>0}` は `log` の定義域 `{x ≠ 0}` に含まれる）と合成
  -- Step 3: 合成。`γ(θ) = arccosh(γ_1(θ))`（`def_gamma_theta`）
  show Continuous fun θ => Real.arcosh (gamma1R P.const θ)
  -- `γ_1(ℝ) ⊆ [1,∞)`（`gamma1_lower_bound_all_theta`）なので、Step 1 と Step 2 の合成は `ℝ` 上連続
  exact hstep2.comp_continuous hstep1 fun θ => Set.mem_Ici.2 (one_le_gamma1R P θ)

/-- 参照用ノートの周期性（もと人手証明 `gamma_is_continuous` の後半）: `γ(θ + 2π) = γ(θ)`。 -/
theorem gammaFn_periodic (P : IsingParam) (θ : ℝ) :
    gammaFn P (θ + 2 * Real.pi) = gammaFn P θ := by
  unfold gammaFn
  rw [gamma1R_periodic]

end Ising2D
