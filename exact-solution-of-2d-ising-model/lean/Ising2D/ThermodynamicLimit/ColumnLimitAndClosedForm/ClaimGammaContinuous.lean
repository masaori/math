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
本ファイルの `gamma_is_continuous` はその特殊化として導出してある。

人手証明の Step 1（`γ_1` の連続性）・Step 2（`arccosh` の連続性）・
Step 3（合成）に、それぞれ `continuous_gamma1R`、
mathlib の `Real.continuousOn_arcosh`、`gamma_is_continuous` が対応する。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimGamma1LowerBound

namespace Ising2D

open Real

/-- 人手証明 Step 1: `γ_1` は連続（定数と `cos` の 1 次式）。 -/
theorem continuous_gamma1R (K : IsingConst) : Continuous (gamma1R K) := by
  unfold gamma1R
  exact continuous_const.sub (continuous_const.mul Real.continuous_cos)

/-- 参照用ノートの周期性（もと人手証明 Step 1 後半）: `γ_1` は周期 `2π`。 -/
theorem gamma1R_periodic (K : IsingConst) (θ : ℝ) :
    gamma1R K (θ + 2 * Real.pi) = gamma1R K θ := by
  simp [gamma1R, Real.cos_add_two_pi]

/-- **人手証明 `gamma_is_continuous`**: `γ` は `ℝ` 上連続。
必要十分版 `NecSuf.continuous_arcosh_comp` の特殊化。 -/
theorem gamma_is_continuous (P : IsingParam) : Continuous (gammaFn P) :=
  NecSuf.continuous_arcosh_comp (continuous_gamma1R P.const) (one_le_gamma1R P)

/-- 参照用ノートの周期性（もと人手証明 `gamma_is_continuous` の後半）: `γ(θ + 2π) = γ(θ)`。 -/
theorem gammaFn_periodic (P : IsingParam) (θ : ℝ) :
    gammaFn P (θ + 2 * Real.pi) = gammaFn P θ := by
  unfold gammaFn
  rw [gamma1R_periodic]

end Ising2D
