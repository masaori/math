/-
# `γ_2(θ~_μ) ≠ 0`（例外なし）（**具体版**）

対応する人手証明のラベル: `gamma_2_theta_tilde_nonzero`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_002_claim_gamma2_nonzero`）

**必要十分版**: `Ising2D/NecSuf/OddModePhase.lean`
（`Ising2D.NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd`）。
具体版はその系として導出する（`gamma2_thetaTilde_ne_zero` の証明を参照）。

## この章の最大の価値

整数運動量 `θ_μ = 2πμ/M` では `γ_2(θ_μ) = 0` が起こりうる
（`Ising2D.gamma2_eq_zero_iff`、`Part008/Definition019_ThetaGamma.lean`。
臨界点 `c_1 = s_1c_2` かつ `θ_μ = 0`）ため、008 章・009 章はそこを例外として
別扱いしていた。**半整数運動量ではこの例外が起こらない。**

理由は 1 行に集約できる: `sin θ~_μ = 0` は `M θ~_μ = (2μ-1)π` が `π` の**奇数**倍であることから
`cos θ~_μ = -1` を強制し（必要十分版）、そのとき Step 1 の連立条件の第 2 式
`c_1 cos θ~_μ = s_1c_2` は `-c_1 = s_1c_2` となるが、`K_1, K_2 > 0` の下で
左辺は負・右辺は正で矛盾する。

## 形式化の方針

* 人手証明の Step 1（零点の必要条件）は既存の `Ising2D.gamma2_eq_zero_iff` そのものである
  （原文 008 章の `gamma_2_theta_is_0` の修正版として既に形式化済み）。
  したがって本ファイルで新たに必要なのは Step 2〜Step 4 だけである。
* 正値性の前提は `Ising2D.IsingParam`（`K_1, K_2, K_2^* > 0`、
  `Part012/Claim001_Gamma1LowerBound.lean`）を使う。人手証明が Step 0 で
  `K_2^* = -½log(tanh K_2) > 0` を導いている部分に対応する。
* **人手証明は `μ ∈ 𝓜̌ = {1,…,M}` に限って述べているが、Lean の証明は `μ ∈ ℤ` 全体で通る**
  （`μ` の範囲はどこにも効かない）。人手証明と 1 対 1 に対応する `𝓜̌` 版も別に立てる
  （`gamma2_thetaTilde_ne_zero_checkIndex`）。
-/
import Ising2D.Part015.Definition001_GammaTilde
import Ising2D.NecSuf.OddModePhase

namespace Ising2D

variable (P : IsingParam)

/-- `c_1 = cosh 2K_1 > 0`。 -/
theorem IsingParam.c1_pos : 0 < P.const.c1 := by
  simpa [IsingParam.const] using Real.cosh_pos (2 * P.K1)

/-- `c_2 = cosh 2K_2 > 0`。 -/
theorem IsingParam.c2_pos : 0 < P.const.c2 := by
  simpa [IsingParam.const] using Real.cosh_pos (2 * P.K2)

/-- **人手証明 `gamma_2_theta_tilde_nonzero` の Step 2 + Step 3**:
`sin θ~_μ = 0` なら `cos θ~_μ = -1`。必要十分版 `NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd` の系。 -/
theorem cos_thetaTilde_eq_neg_one_of_sin_eq_zero {M : ℕ} (hM : M ≠ 0) (μ : ℤ)
    (hsin : Real.sin (thetaTilde M μ) = 0) : Real.cos (thetaTilde M μ) = -1 :=
  NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd (N := (M : ℤ)) (m := 2 * μ - 1)
    (odd_two_mul_sub_one μ) (by exact_mod_cast thetaTilde_mul_M M hM μ) hsin

/-- **人手証明 `gamma_2_theta_tilde_nonzero`**: `γ_2(θ~_μ) ≠ 0`（`μ ∈ ℤ` 全体で成り立つ）。 -/
theorem gamma2_thetaTilde_ne_zero {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    gamma2 P.const (thetaTilde M μ) ≠ 0 := by
  intro h
  rcases (gamma2_eq_zero_iff P.const (thetaTilde M μ)).1 h with hs | ⟨hsin, hcos⟩
  · -- Step 0: `s_2^* = sinh 2K_2^* > 0` に反する
    exact absurd hs (ne_of_gt P.s2star_pos)
  · -- Step 2〜Step 4
    have hcosval := cos_thetaTilde_eq_neg_one_of_sin_eq_zero hM μ hsin
    rw [hcosval] at hcos
    -- `-c_1 - s_1c_2 = 0` だが `c_1, s_1, c_2 > 0`
    have h1 := P.c1_pos
    have h2 := P.s1_pos
    have h3 := P.c2_pos
    nlinarith [hcos, h1, h2, h3]

/-- `γ_2(-θ~_μ) ≠ 0`（人手証明の statement 末尾）。 -/
theorem gamma2_neg_thetaTilde_ne_zero {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    gamma2 P.const (-thetaTilde M μ) ≠ 0 := fun h =>
  gamma2_thetaTilde_ne_zero P hM μ ((gamma2_neg_eq_zero_iff _ _).1 h)

/-- 人手証明と 1 対 1 に対応する形（`μ ∈ 𝓜̌`）。
**`μ` の範囲は証明に効いていない**ことが上の一般形から分かる。 -/
theorem gamma2_thetaTilde_ne_zero_checkIndex {M : ℕ} (hM : M ≠ 0) {μ : ℤ}
    (_hμ : CheckIndex M μ) : gamma2 P.const (thetaTilde M μ) ≠ 0 :=
  gamma2_thetaTilde_ne_zero P hM μ

end Ising2D
