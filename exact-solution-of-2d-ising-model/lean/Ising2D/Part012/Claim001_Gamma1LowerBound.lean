/-
# `γ_1(θ) ≥ cosh(2K_1 - 2K_2^*) ≥ 1`（すべての実数 `θ`）と `γ(θ) := arccosh(γ_1(θ))`

人手証明（正本は `structured-latex/content/012_free_energy.ts`）:
- `freeenergy_001_claim_gamma1_lower_bound_all_theta`（ラベル `gamma1_lower_bound_all_theta`）

**具体版**（人手証明と同じ抽象度）。必要十分版は `Ising2D/NecSuf/CoshLowerBound.lean`
（`Ising2D.NecSuf.cosh_sub_le_cosh_mul_cosh_sub` / `one_le_cosh_mul_cosh_sub`）と
`Ising2D/NecSuf/Arcosh.lean`（`Ising2D.NecSuf.continuous_arcosh_comp`）。
具体版は必要十分版の系として導出してある（`gamma1R_ge_cosh_sub` の証明を参照）。

## 形式化の方針

* 既存の `Ising2D.gamma1 : IsingConst → ℝ → ℂ`（`Part008/Definition019_ThetaGamma.lean`）は
  `A(θ)` の成分として使うため ℂ に埋め込んだ形になっている。本章では実数として扱いたいので
  実数版 `gamma1R` を置き、`gamma1_eq_ofReal` で両者が同じ値であることを確認する。
* 人手証明は `c_1 = cosh 2K_1`, `s_1 = sinh 2K_1`, `c_2^* = cosh 2K_2^*`, `s_2^* = sinh 2K_2^*`
  と `K_1, K_2, K_2^* > 0` を前提に置く。既存の `IsingConst` は 5 個の実数を束ねただけなので、
  この前提を `IsingParam` として明示的に持たせ、`IsingParam.const` で `IsingConst` へ移す。
  これにより「どの結論がどの前提に依存するか」が形式化の側で可視化される
  （`Part008/Definition019_ThetaGamma.lean` と同じ方針）。
* `arccosh` について: `lean/README.md` は「mathlib に無い」と記載しているが、
  本リポジトリが固定している mathlib（`v4.32.1`）には `Real.arcosh` が存在し、
  定義も人手証明 Step 2 の明示式 `log(x + √(x^2-1))` とまったく同じである。
  自前定義はせず mathlib のものを使う（詳細は `Ising2D/NecSuf/Arcosh.lean` 冒頭）。

## 他章への依存について

本ファイルは他章（011 章の `c(M)` や分配関数の挟み撃ち）に依存しない。
-/
import Ising2D.Part008.Definition019_ThetaGamma
import Ising2D.NecSuf.Arcosh
import Ising2D.NecSuf.CoshLowerBound

namespace Ising2D

/-- 人手証明が置いている前提 `K_1, K_2, K_2^* ∈ ℝ_{>0}`（`def_transfer_matrix_symbols`）。 -/
structure IsingParam where
  K1 : ℝ
  K2 : ℝ
  K2star : ℝ
  K1_pos : 0 < K1
  K2_pos : 0 < K2
  K2star_pos : 0 < K2star

/-- `IsingParam` から `IsingConst` を作る（原文の `c_1 = cosh 2K_1` 等）。 -/
noncomputable def IsingParam.const (P : IsingParam) : IsingConst where
  c1 := Real.cosh (2 * P.K1)
  s1 := Real.sinh (2 * P.K1)
  c2 := Real.cosh (2 * P.K2)
  c2star := Real.cosh (2 * P.K2star)
  s2star := Real.sinh (2 * P.K2star)

/-- `γ_1(θ) = c_1c_2^* - s_1s_2^* cos θ` の実数版。 -/
noncomputable def gamma1R (K : IsingConst) (θ : ℝ) : ℝ :=
  K.c1 * K.c2star - K.s1 * K.s2star * Real.cos θ

/-- 既存の ℂ 版 `gamma1` は `gamma1R` の埋め込みである（定義の突き合わせ）。 -/
theorem gamma1_eq_ofReal (K : IsingConst) (θ : ℝ) : gamma1 K θ = ((gamma1R K θ : ℝ) : ℂ) := rfl

/-- `s_1 = sinh 2K_1 > 0`（原文 `K_1 > 0` から）。 -/
theorem IsingParam.s1_pos (P : IsingParam) : 0 < P.const.s1 := by
  have : 0 < 2 * P.K1 := by linarith [P.K1_pos]
  simpa [IsingParam.const] using Real.sinh_pos_iff.2 this

/-- `s_2^* = sinh 2K_2^* > 0`（原文 `K_2^* > 0` から）。 -/
theorem IsingParam.s2star_pos (P : IsingParam) : 0 < P.const.s2star := by
  have : 0 < 2 * P.K2star := by linarith [P.K2star_pos]
  simpa [IsingParam.const] using Real.sinh_pos_iff.2 this

/-- **人手証明 `gamma1_lower_bound_all_theta` の第 1 の不等式**（`∀θ ∈ ℝ`）:
`γ_1(θ) ≥ cosh(2K_1 - 2K_2^*)`。必要十分版 `NecSuf.cosh_sub_le_cosh_mul_cosh_sub` の系。 -/
theorem gamma1R_ge_cosh_sub (P : IsingParam) (θ : ℝ) :
    Real.cosh (2 * P.K1 - 2 * P.K2star) ≤ gamma1R P.const θ := by
  have hs : 0 ≤ Real.sinh (2 * P.K1) * Real.sinh (2 * P.K2star) := by
    have h1 := P.s1_pos
    have h2 := P.s2star_pos
    simp only [IsingParam.const] at h1 h2
    positivity
  simpa [gamma1R, IsingParam.const] using
    NecSuf.cosh_sub_le_cosh_mul_cosh_sub (u := 2 * P.K1) (v := 2 * P.K2star)
      (x := Real.cos θ) (Real.cos_le_one θ) hs

/-- **人手証明 `gamma1_lower_bound_all_theta` の第 2 の不等式**: `γ_1(θ) ≥ 1`（`∀θ ∈ ℝ`）。 -/
theorem one_le_gamma1R (P : IsingParam) (θ : ℝ) : 1 ≤ gamma1R P.const θ :=
  le_trans (Real.one_le_cosh _) (gamma1R_ge_cosh_sub P θ)

/-- **人手証明 `gamma1_lower_bound_all_theta` そのもの**（2 つの不等式を並べた形）。 -/
theorem gamma1_lower_bound_all_theta (P : IsingParam) (θ : ℝ) :
    Real.cosh (2 * P.K1 - 2 * P.K2star) ≤ gamma1R P.const θ ∧ 1 ≤ gamma1R P.const θ :=
  ⟨gamma1R_ge_cosh_sub P θ, one_le_gamma1R P θ⟩

/-- 原文 `γ(θ) := arccosh(γ_1(θ))`（`def_gamma_theta_mu` の実数 `θ` への拡張）。 -/
noncomputable def gammaFn (P : IsingParam) (θ : ℝ) : ℝ :=
  Real.arcosh (gamma1R P.const θ)

/-- 原文 `onsager_free_energy_expression` に現れる `γ` の明示形。 -/
theorem gammaFn_eq (P : IsingParam) (θ : ℝ) :
    gammaFn P θ = Real.arcosh (Real.cosh (2 * P.K1) * Real.cosh (2 * P.K2star)
      - Real.sinh (2 * P.K1) * Real.sinh (2 * P.K2star) * Real.cos θ) := rfl

/-- `γ(θ) ∈ ℝ_{≥0}`（人手証明 `gamma1_lower_bound_all_theta` の結論の後半）。 -/
theorem gammaFn_nonneg (P : IsingParam) (θ : ℝ) : 0 ≤ gammaFn P θ :=
  Real.arcosh_nonneg (one_le_gamma1R P θ)

/-- `γ` が実際に `γ_1` の `arccosh` であること（`cosh γ(θ) = γ_1(θ)`）。 -/
theorem cosh_gammaFn (P : IsingParam) (θ : ℝ) :
    Real.cosh (gammaFn P θ) = gamma1R P.const θ :=
  Real.cosh_arcosh (one_le_gamma1R P θ)

end Ising2D
