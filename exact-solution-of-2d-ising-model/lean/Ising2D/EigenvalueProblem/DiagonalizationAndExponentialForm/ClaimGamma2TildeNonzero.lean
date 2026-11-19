/-
# `γ_2(θ~_μ) ≠ 0`（例外なし）（**具体版**）

対応する人手証明のラベル: `gamma_2_theta_tilde_nonzero`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_002_claim_gamma2_nonzero`）

**必要十分版**: `Ising2D/NecSuf/OddModePhase.lean`
（`Ising2D.NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd`）。
具体版はその系として導出する（`gamma2_thetaTilde_ne_zero` の証明を参照）。

## この章の最大の価値

整数運動量 `θ_μ = 2πμ/M` では `γ_2(θ_μ) = 0` が起こりうる
（`Ising2D.gamma2_eq_zero_iff`、`EigenvalueProblem/ReductionToATheta/DefinitionThetaGamma.lean`。
臨界点 `c_1 = s_1c_2` かつ `θ_μ = 0`）ため、008 章・009 章はそこを例外として
別扱いしていた。**半整数運動量ではこの例外が起こらない。**

理由は 1 行に集約できる: `sin θ~_μ = 0` は `M θ~_μ = (2μ-1)π` が `π` の**奇数**倍であることから
`cos θ~_μ = -1` を強制し（必要十分版）、そのとき Step 1 の連立条件の第 1 式
`c_1 cos θ~_μ = s_1c_2` は `-c_1 = s_1c_2` となるが、`K_1, K_2 > 0` の下で
左辺は負・右辺は正で矛盾する。

## 形式化の方針

* 人手証明の Step 1（零点の必要条件）は既存の `Ising2D.gamma2_eq_zero_iff` そのものである
  （原文 008 章の `gamma_2_theta_is_0` の修正版として既に形式化済み）。ただし同値の鎖の 5 行目の根拠
  （`c_1cos θ − s_1c_2 = 0` と `c_1cos θ = s_1c_2` の同値を示す二つの鎖）は本ファイルの
  `gamma2_step1_first_equation_iff` に置く。本ファイルで新たに必要なのは、これと Step 2〜Step 4 である。
* 正値性の前提は `Ising2D.IsingParam`（`K_1, K_2, K_2^* > 0`、
  `EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimGamma1LowerBound.lean`）を使う。人手証明が Step 0 で
  `K_2^* = -½log(tanh K_2) > 0` を導いている部分に対応する。
* **人手証明は `μ ∈ 𝓜̌ = {1,…,M}` に限って述べているが、Lean の証明は `μ ∈ ℤ` 全体で通る**
  （`μ` の範囲はどこにも効かない）。人手証明と 1 対 1 に対応する `𝓜̌` 版も別に立てる
  （`gamma2_thetaTilde_ne_zero_checkIndex`）。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.DefinitionGamma1Gamma2OfThetaTilde
import Ising2D.NecSuf.OddModePhase
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusOneTimesIsNegation

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

/-- **人手証明 `gamma_2_theta_tilde_nonzero` の Step 1**: `c_1 cos θ − s_1c_2 = 0` と `c_1 cos θ = s_1c_2` の
同値を示す二つの鎖（同値の鎖の 5 行目の根拠）。人手の 8 行と 3 行に 1 段ずつ対応する。
ℝ の加法の単位元・逆元・交換律・結合律は `set_and_algebra_notation` の順序体の公理、差は `def_real_difference`。 -/
theorem gamma2_step1_first_equation_iff (θ : ℝ) :
    P.const.c1 * Real.cos θ - P.const.s1 * P.const.c2 = 0 ↔
      P.const.c1 * Real.cos θ = P.const.s1 * P.const.c2 := by
  constructor
  · intro h
    calc P.const.c1 * Real.cos θ
        = P.const.c1 * Real.cos θ + 0 := (add_zero _).symm
                                        -- ℝ の加法の単位元 `x + 0 = x`（`x → c_1cos θ`）を右辺から左辺へ
      _ = P.const.c1 * Real.cos θ + (P.const.s1 * P.const.c2 + -(P.const.s1 * P.const.c2)) := by
          rw [add_neg_cancel]           -- ℝ の加法の逆元 `x + (−x) = 0`（`x → s_1c_2`）を右辺から左辺へ
      _ = P.const.c1 * Real.cos θ + (-(P.const.s1 * P.const.c2) + P.const.s1 * P.const.c2) := by
          rw [add_comm (P.const.s1 * P.const.c2)]
                                        -- ℝ の加法の交換律（`x → s_1c_2`、`y → −(s_1c_2)`）
      _ = (P.const.c1 * Real.cos θ + -(P.const.s1 * P.const.c2)) + P.const.s1 * P.const.c2 :=
          (add_assoc _ _ _).symm        -- ℝ の加法の結合律（`x → c_1cos θ`、`y → −(s_1c_2)`、`t → s_1c_2`）を右辺から左辺へ
      _ = (P.const.c1 * Real.cos θ - P.const.s1 * P.const.c2) + P.const.s1 * P.const.c2 := by
          rw [← sub_eq_add_neg]         -- `def_real_difference`（`y → c_1cos θ`、`z → s_1c_2`）を右辺から左辺へ
      _ = 0 + P.const.s1 * P.const.c2 := by rw [h]
                                        -- 仮定 `c_1cos θ − s_1c_2 = 0`
      _ = P.const.s1 * P.const.c2 + 0 := add_comm _ _
                                        -- ℝ の加法の交換律（`x → 0`、`y → s_1c_2`）
      _ = P.const.s1 * P.const.c2 := add_zero _
                                        -- ℝ の加法の単位元（`x → s_1c_2`）
  · intro h
    calc P.const.c1 * Real.cos θ - P.const.s1 * P.const.c2
        = P.const.c1 * Real.cos θ + -(P.const.s1 * P.const.c2) := sub_eq_add_neg _ _
                                        -- `def_real_difference`（`y → c_1cos θ`、`z → s_1c_2`）
      _ = P.const.s1 * P.const.c2 + -(P.const.s1 * P.const.c2) := by rw [h]
                                        -- 仮定 `c_1cos θ = s_1c_2`
      _ = 0 := add_neg_cancel _         -- ℝ の加法の逆元（`x → s_1c_2`）

/-- **人手証明 `gamma_2_theta_tilde_nonzero`**: `γ_2(θ~_μ) ≠ 0`（`μ ∈ ℤ` 全体で成り立つ）。 -/
theorem gamma2_thetaTilde_ne_zero {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    gamma2 P.const (thetaTilde M μ) ≠ 0 := by
  intro h
  rcases (gamma2_eq_zero_iff P.const (thetaTilde M μ)).1 h with hs | ⟨hsin, hcos⟩
  · -- Step 0: `s_2^* = sinh 2K_2^* > 0` に反する
    exact absurd hs (ne_of_gt P.s2star_pos)
  · -- Step 2 + Step 3: `cos θ~_μ = -1`
    have hcosval := cos_thetaTilde_eq_neg_one_of_sin_eq_zero hM μ hsin
    -- Step 1 の連立条件の第 1 式 `c_1 cos θ = s_1c_2`（`gamma2_eq_zero_iff` は差が 0 の形で返すので、
    -- 人手の同値の鎖の 5 行目 `c_1cos θ - s_1c_2 = 0 ⟺ c_1cos θ = s_1c_2` の段を、その根拠の二つの鎖
    -- `gamma2_step1_first_equation_iff` の前者から後者への向きで踏む）
    have hstep1 : P.const.c1 * Real.cos (thetaTilde M μ) = P.const.s1 * P.const.c2 :=
      (gamma2_step1_first_equation_iff P (thetaTilde M μ)).1 hcos
    -- Step 4: `s_1c_2` の鎖
    have hchain : P.const.s1 * P.const.c2 = -P.const.c1 :=
      calc P.const.s1 * P.const.c2
          = P.const.c1 * Real.cos (thetaTilde M μ) := hstep1.symm
                                                  -- Step 1 の連立条件の第 1 式
        _ = P.const.c1 * (-1) := by rw [hcosval]  -- Step 3 の `cos θ~_μ = -1`
        _ = (-1) * P.const.c1 := mul_comm _ _     -- ℝ の乗法の可換律（`set_and_algebra_notation`）
        _ = -P.const.c1 := real_minus_one_times_is_negation _
                                                  -- `real_minus_one_times_is_negation`（`a → c_1`）
    -- Step 4: 矛盾の鎖 `0 < s_1c_2 = -c_1 < 0`
    have hlt : (0 : ℝ) < 0 :=
      calc (0 : ℝ)
          < P.const.s1 * P.const.c2 := mul_pos P.s1_pos P.c2_pos
                                                  -- Step 0 の `s_1 > 0`、`c_2 > 0` と正数の積
        _ = -P.const.c1 := hchain                 -- 直前の鎖
        _ < 0 := neg_neg_of_pos P.c1_pos          -- Step 0 の `c_1 > 0`
    exact lt_irrefl 0 hlt

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
