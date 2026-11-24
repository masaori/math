/-
# `γ_2(θ~_μ) ≠ 0`（例外なし）（**具体版**）

対応する人手証明のラベル: `gamma_2_theta_tilde_nonzero`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_002_claim_gamma2_nonzero`）

**必要十分版**: `Ising2D/NecSuf/OddModePhase.lean`
（`Ising2D.NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd`）。
`cos_thetaTilde_eq_neg_one_of_sin_eq_zero` をその特殊化として得る導出は `ClaimGamma2TildeNonzeroFromNecSuf.lean`。

## この章の最大の価値

整数運動量 `θ_μ = 2πμ/M` では `γ_2(θ_μ) = 0` が起こりうる
（`Ising2D.gamma2_eq_zero_iff`、`EigenvalueProblem/ReductionToATheta/DefinitionThetaGamma.lean`。
臨界点 `c_1 = s_1c_2` かつ `θ_μ = 0`）ため、008 章・009 章はそこを例外として
別扱いしていた。**半整数運動量ではこの例外が起こらない。**

理由は次のとおりである: `sin θ~_μ = 0` なら `θ~_μ = kπ`（`k ∈ ℤ`）で、`θ~_μ` の定義から `2μ − 1 = kM` となり、
`2μ − 1` が奇数なので `k` も奇数、ゆえに `cos θ~_μ = cos(kπ) = −1`（`cos_thetaTilde_eq_neg_one_of_sin_eq_zero`）。
そのとき Step 1 の連立条件の第 1 式
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
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealMinusOneTimesIsNegation

namespace Ising2D

variable (P : IsingParam)

/-- `c_1 = cosh 2K_1 > 0`。 -/
theorem IsingParam.c1_pos : 0 < P.const.c1 :=
  -- 人手: `indexed_hyperbolic_abbreviations_positive` の `c_1 > 0`（`Kstar K1` が人手の `K_1^*`（`def_first_dual_coupling_constant`）に当たる）
  (indexedHyperbolicAbbreviations_pos P.K1_pos P.K2_pos (Kstar_pos P.K1_pos) P.K2star_pos).1

/-- `c_2 = cosh 2K_2 > 0`。 -/
theorem IsingParam.c2_pos : 0 < P.const.c2 :=
  -- 人手: `indexed_hyperbolic_abbreviations_positive` の `c_2 > 0`
  (indexedHyperbolicAbbreviations_pos P.K1_pos P.K2_pos (Kstar_pos P.K1_pos) P.K2star_pos).2.2.2.2.1

/-- **人手証明 `gamma_2_theta_tilde_nonzero` の Step 2 + Step 3**:
`sin θ~_μ = 0` なら `cos θ~_μ = -1`。人手の Step 2 の鎖（`sin θ~_μ = 0` から `2μ − 1 = kM_col` までの 5 行）と、
`k` が奇数であることの鎖（3 行）と、Step 3 の鎖（3 行）に 1 対 1 に対応する。人手の鎖は `⟺` で書かれているが、
ここで使うのは左から右への向きだけである。
必要十分版 `NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd` との対応: 1 行目は同じ、2〜5 行目は必要十分版の `N·k = m` の段、
`k` が奇数であることの鎖と Step 3 の鎖は同じである。
`sin t = 0 ⟹ ∃k ∈ ℤ, t = kπ` と `cos(kπ) = (−1)^k` は人手が名前で引く ℝ の三角関数の性質で、mathlib の
`Real.sin_eq_zero_iff`・`Real.cos_int_mul_pi` で受け取る。
`thetaTilde_mul_M` を必要十分版 `NecSuf.cos_eq_neg_one_of_sin_eq_zero_of_odd` に渡す導出は
`ClaimGamma2TildeNonzeroFromNecSuf.lean` の `cos_thetaTilde_eq_neg_one_of_sin_eq_zero_of_necSuf`。 -/
theorem cos_thetaTilde_eq_neg_one_of_sin_eq_zero {M : ℕ} (hM : M ≠ 0) (μ : ℤ)
    (hsin : Real.sin (thetaTilde M μ) = 0) : Real.cos (thetaTilde M μ) = -1 := by
  have hMR : ((M : ℤ) : ℝ) ≠ 0 := by exact_mod_cast hM
  have hpi : Real.pi ≠ 0 := ne_of_gt Real.pi_pos
    -- `pi_is_positive`
  -- Step 2 の鎖の 1 行目: `sin θ~_μ = 0 ⟹ ∃k ∈ ℤ, θ~_μ = kπ`
  obtain ⟨k, hk⟩ : ∃ k : ℤ, thetaTilde M μ = (k : ℝ) * Real.pi := by
    obtain ⟨n, hn⟩ := Real.sin_eq_zero_iff.1 hsin
    exact ⟨n, hn.symm⟩
    -- `sin t = 0 ⟺ ∃k ∈ ℤ, t = kπ`（`t → θ~_μ`）
  -- 2 行目: `2π(μ − 1/2)/M_col = kπ`
  have h2 : 2 * Real.pi * ((μ : ℝ) - 1 / 2) / ((M : ℤ) : ℝ) = (k : ℝ) * Real.pi := hk
    -- `antiperiodic_exp_sum` の `θ~_μ` の定義
  -- 3 行目: `2(μ − 1/2)/M_col = k`
  have h3 : 2 * ((μ : ℝ) - 1 / 2) / ((M : ℤ) : ℝ) = (k : ℝ) :=
    calc 2 * ((μ : ℝ) - 1 / 2) / ((M : ℤ) : ℝ)
        = Real.pi * (2 * ((μ : ℝ) - 1 / 2) / ((M : ℤ) : ℝ)) / Real.pi :=
          (mul_div_cancel_left₀ _ hpi).symm
      _ = (2 * Real.pi * ((μ : ℝ) - 1 / 2) / ((M : ℤ) : ℝ)) / Real.pi := by
          rw [← mul_div_assoc, mul_left_comm, ← mul_assoc]
      _ = ((k : ℝ) * Real.pi) / Real.pi := by rw [h2]
      _ = (k : ℝ) := mul_div_cancel_right₀ (k : ℝ) hpi
    -- 両辺を `π > 0`（`pi_is_positive`）で割る（両辺の `π · ( ) / π` の約分に `π ≠ 0` を使う）
  -- 4 行目: `2(μ − 1/2) = kM_col`
  have h4 : 2 * ((μ : ℝ) - 1 / 2) = (k : ℝ) * ((M : ℤ) : ℝ) := (div_eq_iff hMR).1 h3
    -- 両辺を `M_col ≠ 0` 倍する
  -- 5 行目: `2μ − 1 = kM_col`
  have h5 : 2 * (μ : ℝ) - 1 = (k : ℝ) * ((M : ℤ) : ℝ) := by
    rw [← h4]; ring
    -- 分配律 `2(μ − 1/2) = 2μ − 1`
  -- Lean だけの段: 5 行目の両辺は整数の像なので、ℤ の等式として読む（`ι_{ℤ→ℝ}` の単射と和・積の保存）。
  -- 人手はこの段を書かずに 5 行目を ℤ の等式として次の鎖で使っている（状態台帳の残る件）
  have h5Z : 2 * μ - 1 = k * (M : ℤ) := by exact_mod_cast h5
  -- `k` が奇数であることの鎖の 1 行目: `kM_col = 2(μ − 1) + 1`
  have h6 : k * (M : ℤ) = 2 * (μ - 1) + 1 := by
    rw [← h5Z]; ring
    -- `2μ − 1 = 2(μ − 1) + 1`
  -- 2 行目: `kM_col` は奇数
  have h7 : Odd (k * (M : ℤ)) := ⟨μ - 1, h6⟩
    -- 奇数の定義
  -- 3 行目: `k` は奇数
  have hkodd : Odd k := by
    rcases Int.even_or_odd k with ⟨l, hl⟩ | h
    · exact absurd h7 (Int.not_odd_iff_even.2 ⟨l * (M : ℤ), by rw [hl]; ring⟩)
      -- `k = 2l` なら `kM_col = 2(lM_col)` は偶数で、整数は偶数か奇数のどちらか一方
      -- （mathlib の `Even k` は `k = l + l` の形で与えられる）
    · exact h
  -- Step 3 の鎖
  calc Real.cos (thetaTilde M μ)
      = Real.cos ((k : ℝ) * Real.pi) := by rw [hk]
                                        -- Step 2 の `θ~_μ = kπ`
    _ = (-1 : ℝ) ^ k := Real.cos_int_mul_pi k
                                        -- `k ∈ ℤ` に対し `cos(kπ) = (−1)^k`
    _ = -1 := hkodd.neg_one_zpow        -- Step 2 より `k` は奇数

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
