/-
# `γ` は `ℝ` 上で連続で周期 `2π` をもつ

人手証明（正本は `structured-latex/content/012_free_energy.ts`）:
- `freeenergy_002_claim_gamma_is_continuous`（ラベル `gamma_is_continuous`）

**具体版**（人手証明と同じ抽象度）。抽象版は `Ising2D/Abstract/Arcosh.lean` の
`Ising2D.Abstract.continuous_arcosh_comp`（定義域は任意の位相空間でよい）。
本ファイルの `gamma_is_continuous` はその特殊化として導出してある。

人手証明の Step 1（`γ_1` の連続性と周期性）・Step 2（`arccosh` の連続性）・
Step 3（合成）に、それぞれ `continuous_gamma1R` / `gamma1R_periodic`、
mathlib の `Real.continuousOn_arcosh`、`gamma_is_continuous` が対応する。
-/
import Ising2D.Part012.Claim001_Gamma1LowerBound

namespace Ising2D

open Real

/-- 人手証明 Step 1 前半: `γ_1` は連続（定数と `cos` の 1 次式）。 -/
theorem continuous_gamma1R (K : IsingConst) : Continuous (gamma1R K) := by
  unfold gamma1R
  exact continuous_const.sub (continuous_const.mul Real.continuous_cos)

/-- 人手証明 Step 1 後半: `γ_1` は周期 `2π`。 -/
theorem gamma1R_periodic (K : IsingConst) (θ : ℝ) :
    gamma1R K (θ + 2 * Real.pi) = gamma1R K θ := by
  simp [gamma1R, Real.cos_add_two_pi]

/-- **人手証明 `gamma_is_continuous` の前半**: `γ` は `ℝ` 上連続。
抽象版 `Abstract.continuous_arccosh_comp` の特殊化。 -/
theorem gamma_is_continuous (P : IsingParam) : Continuous (gammaFn P) :=
  Abstract.continuous_arcosh_comp (continuous_gamma1R P.const) (one_le_gamma1R P)

/-- **人手証明 `gamma_is_continuous` の後半**: `γ(θ + 2π) = γ(θ)`。 -/
theorem gammaFn_periodic (P : IsingParam) (θ : ℝ) :
    gammaFn P (θ + 2 * Real.pi) = gammaFn P θ := by
  unfold gammaFn
  rw [gamma1R_periodic]

end Ising2D
