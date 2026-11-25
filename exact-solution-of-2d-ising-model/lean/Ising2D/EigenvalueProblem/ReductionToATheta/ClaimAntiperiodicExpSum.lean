/-
# 半整数運動量の指数和（**具体版**）

対応する人手証明のラベル: `antiperiodic_exp_sum`
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensector_002_claim_antiperiodic_exp_sum`）

**必要十分版**は `Ising2D/NecSuf/AntiperiodicFourier.lean`（名前空間 `Ising2D.NecSuf`、
同じラベル `antiperiodic_exp_sum`）の
`Ising2D.NecSuf.sum_zpow_antiperiodic_delta_difference`。
必要十分版からの導出は `Ising2D/EigenvalueProblem/ReductionToATheta/ClaimAntiperiodicExpSumFromNecSuf.lean`。

## 原文の主張（`M ∈ ℤ_{≥2}`、`μ ∈ ℤ`）

原文の有限和では、標準包含による像が `M` となる一意な自然数 `M_ℕ` を項数と法に用いる。
以下の Lean の `M : ℕ` は、この `M_ℕ` を表す。

  `θ~_μ := 2π(μ - 1/2)/M ∈ ℝ`
  `∑_{μ=1}^{M} e^{i k θ~_μ} = M(-1)^l  (k = lM),  0  (k ≢ 0 mod M)`

## 形式化の方針

* 位相因子は既存の `Ising2D.expPhase`（`expPhase N k = exp(-2π√-1 k/N)`、
  `EigenvalueProblem/ReductionToATheta/ClaimExpSum.lean`）を `N = 2M` で使う:

    `e^{-i j θ~_μ} = exp(-π√-1 j(2μ-1)/M) = expPhase (2M) (j(2μ-1))`

  これを `Ising2D.checkPhase M j μ` と名づける。**`e^{-iθ~}` は 1 の `2M` 乗根であり、
  半整数運動量とはその奇数周波数のことである**、というのがこの書き方の中身である
  （必要十分版の冒頭コメント参照）。
* 実数の `θ~_μ` は `Ising2D.thetaTilde` として定義し、
  `checkPhase_eq_exp` で `checkPhase` と一致することを示す（原文の記号との橋渡し）。
* 和の添字は `Fin M`（`0,…,M-1`）で、原文の `μ` の整数像 `μ_ℤ` は名前を付けた写像の像 `finIndexToZZ M μ`（`ι_{ℕ→ℤ}(μ.val) + 1_ℤ`、
  `def_index_set_from_one_to_n`）と書く。
* 原文は `M ≥ 2` を仮定しているが、本ファイルの主張に必要なのは `M ≠ 0` だけである。
* `antiperiodic_exp_sum_not_dvd`（`M ∤ k`）の `calc` と `antiperiodic_exp_sum_dvd` の `l` が偶数・奇数の 2 本の `calc` は、
  人手の鎖（7 行・10 行・8 行）と 1 段ずつ対応する（段のコメントに人手の行を書いた）。ただし偶数の 10 行目・奇数の 8 行目の
  根拠 `(-1_ℂ)^l = ±1_ℂ`（人手は `(-1)^{l+2} = (-1)^l` と `(-1)^0`・`(-1)^1` の値から導く）は、mathlib の `Even.neg_one_zpow`・
  `Odd.neg_one_zpow` を当てた `hpow` のままで、人手の手順と対応していない。偶数の 5 行目の `real_inclusion_preserves_product` は具体版 `real_inclusion_mul`、
  8 行目の `2_ℂ - 1_ℂ = 1_ℂ` は `two_real_inclusion_sub_one` である。人手の `n_ℂ := (n_ℝ)_ℂ` は、Lean では
  `(n : ℂ)`（`Nat.cast`）と `((n : ℝ) : ℂ)` が別の項なので、4 行目・5 行目で `Complex.ofReal_natCast` により読み替える。
  人手のこのブロックで実数の包含の性質の主張（`real_inclusion_preserves_*`）を引くのはこの 5 行目だけである。
* 人手の準備の鎖（`(2n)_ℤ = 2_ℤ·n_ℤ`、`(2_ℤ·a)_ℝ = 2_ℝ·a_ℝ`、`(2(M_col)_ℕ)_ℝ = 2_ℝ(M_col)_ℝ`、`(2μ − 1)_ℤ = 2_ℤμ_ℤ − 1_ℤ`、
  `((2μ − 1)_ℤ)_ℝ = 2_ℝ(μ_ℤ)_ℝ − 1_ℝ`）は、使う証明の中の `have`（`htwoZ`・`htwoR`・`h2MR`・`hoddZ`・`hoddR`）として
  `ι_{ℕ→ℤ}`・`ι_{ℤ→ℝ}` の主張を引いて示す（主張の形の定理にすると、その型の ℕ・ℤ の数字と `Int.cast` が未定義の記号の台帳に行を足すため）。
  使う所は、`expPhase_two_mul`（T_{2M} の分母と偶数番目の周波数）、奇偶の分割（`hodd`・`heven`）、`antiperiodic_complex_exp_sum_eq_checkPhase`
  （奇数番目の項と分母）、整除の段の `(2M)_ℝ` である。`checkPhase_eq_exp` はほかの章の主張も使うので、`push_cast` のまま残す。
  `antiperiodic_complex_exp_sum_eq_checkPhase` で `((-k)(2μ − 1))_ℝ` を `inclusion_zz_to_rr_preserves_product` で積に割る段は Lean だけの段
  （人手は `k_ℝ` と `(r_ℤ)_ℝ` を初めから別に書く）で、その後の `field_simp` は人手の `k_ℝθ~_μ` の 6 行の鎖を 1 手でまとめており、未対応である。
  人手の ℕ の差 `2μ − 1` が定まることの段（`2μ = 1 + (d + μ)` の 5 行と `(2μ − 1) + 1 = 2μ` の 2 行）は、Lean が `2μ + 1` と書いて差を使わないので持たない。
  人手の証明の `N_ℝ ≥ ((1_ℕ)_ℤ)_ℝ = 1_ℝ > 0_ℝ` の段は、`expPhase_two_mul` の `M_ℂ ≠ 0`（`hMR`。`N → M`）で `inclusion_nn_to_zz_preserves_order`・
  `inclusion_nn_to_zz_image_is_nonnegative`・`inclusion_zz_to_rr_is_monotone_on_nonnegatives` を引いて示す。ほかの補題の `M_ℂ ≠ 0` は `Nat.cast_ne_zero` のままである。
  人手の前置きの `(M_col)_ℝ ≥ 2_ℝ` の段は、Lean が `M ≠ 0` だけを使うので持たない。
  残りの `push_cast`（`k` の像、`expPhase_zpow`・`expPhase_two_mul_half` の周波数、`2_ℝ` による約分の前の整理）は、
  `expPhase` で書くための Lean 側の橋の計算である。
  ただし整除の補題（`antiperiodic_exp_sum_dvd` の 2 本の `hdelta2`、`antiperiodic_exp_sum_not_dvd` の `hk2`）の
  `push_cast`・`ring` は、人手の整除の行（`2M ∣ lM ⟺ 2 ∣ l`・`M ≠ 0` による約分・`2M ∣ k` なら `M ∣ k` の対偶）と未対応である。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExpSum
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionIntegerStrictOrder
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerAbsoluteValueIsNonnegative
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerAbsoluteValueZeroImpliesZero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerZeroTimesIsZero
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerAbsoluteValueOfProductWithNonnegative
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimIntegerLessThanOneOfProductLessThanNonnegativeFactor
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersImageIsNonnegative
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersPreservesProduct
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersPreservesOrder
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimInclusionOfIntegersIntoRealNumbers
import Mathlib.Analysis.SpecialFunctions.Complex.Circle

namespace Ising2D

variable {M : ℕ}

/-! ## 位相因子の補助（`expPhase` を `2M` で使う） -/

/-- `expPhase N (l a) = (expPhase N a)^l`（`l : ℤ`）。 -/
theorem expPhase_zpow (N : ℕ) (l a : ℤ) : expPhase N (l * a) = (expPhase N a) ^ l := by
  rw [expPhase, expPhase, ← Complex.exp_int_mul]
  congr 1
  push_cast
  ring

/-- `2M` 乗根の偶数周波数は `M` 乗根そのもの: `expPhase (2M) (2n) = expPhase M n`。 -/
theorem expPhase_two_mul (hM : M ≠ 0) (n : ℤ) : expPhase (2 * M) (2 * n) = expPhase M n := by
  -- 人手証明の「正の自然数 `N` について `((1_ℕ)_ℤ)_ℝ ≤ N_ℝ`、`((1_ℕ)_ℤ)_ℝ = 1_ℝ` なので `N_ℝ ≥ 1_ℝ > 0_ℝ`、`N_ℝ ≠ 0_ℝ`」（`N → M`）。
  have hMR : ((inclusionNNtoZZ M : ℤ) : ℝ) ≠ 0 := by
    have h1M : 1 ≤ M := Nat.one_le_iff_ne_zero.mpr hM                    -- `M ≠ 0` から `1_ℕ ≤ M`（Lean は `M ≠ 0` で受け取るので、Lean だけの段）
    have hge : ((inclusionNNtoZZ 1 : ℤ) : ℝ) ≤ ((inclusionNNtoZZ M : ℤ) : ℝ) :=
      inclusion_zz_to_rr_is_monotone_on_nonnegatives _ _
        (inclusion_nn_to_zz_image_is_nonnegative 1) (inclusion_nn_to_zz_image_is_nonnegative M)
        (inclusion_nn_to_zz_preserves_order 1 M h1M)
        -- `inclusion_nn_to_zz_preserves_order`（`x → 1_ℕ, y → N`）・`inclusion_nn_to_zz_image_is_nonnegative`（`n → 1_ℕ`、`n → N`）・
        -- `inclusion_zz_to_rr_is_monotone_on_nonnegatives`（`a → (1_ℕ)_ℤ, b → N_ℤ`）
    have hone : ((inclusionNNtoZZ 1 : ℤ) : ℝ) = 1 :=
      calc ((inclusionNNtoZZ 1 : ℤ) : ℝ)
          = ((inclusionNNtoZZ (0 + 1) : ℤ) : ℝ) := by rw [Nat.zero_add 1]   -- ℕ の加法の単位元 `0 + x = x`（`x → 1_ℕ`）を右辺から左辺へ
        _ = ((inclusionNNtoZZ 0 + 1 : ℤ) : ℝ) := rfl                        -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → 0_ℕ`）
        _ = (((0 : ℤ) + 1 : ℤ) : ℝ) := rfl                                  -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ`
        _ = ((1 : ℤ) : ℝ) := by rw [zero_add (1 : ℤ)]                       -- ℤ の和の単位元 `0 + x = x`（`x → 1_ℤ`）
        _ = 1 := inclusion_zz_to_rr_of_one_intCast                          -- `inclusion_zz_to_rr_of_one`
    have hge1 : (1 : ℝ) ≤ ((inclusionNNtoZZ M : ℤ) : ℝ) := by rw [← hone]; exact hge
    exact ne_of_gt (lt_of_lt_of_le zero_lt_one hge1)                       -- `N_ℝ ≥ 1_ℝ > 0_ℝ` なので `N_ℝ ≠ 0_ℝ`
  -- `n_ℂ := (n_ℝ)_ℂ` と `(M_col)_ℕ` の像の読み替え（Lean の `(M : ℂ)` は `Nat.cast` なので、Lean だけの段）。
  have hMC : ((M : ℕ) : ℂ) ≠ 0 := by
    rw [← Complex.ofReal_natCast, Complex.ofReal_ne_zero, ← Int.cast_natCast (R := ℝ) M,
      ← inclusionNNtoZZ_eq_natCast M]
    exact hMR
  -- 人手証明の準備の鎖 `(2n)_ℤ = 2_ℤ·n_ℤ`（`n ∈ ℕ`）。
  have htwoZ : ∀ n : ℕ, inclusionNNtoZZ (2 * n) = 2 * inclusionNNtoZZ n := fun n =>
    calc inclusionNNtoZZ (2 * n)
        = inclusionNNtoZZ 2 * inclusionNNtoZZ n :=
          inclusion_nn_to_zz_preserves_product 2 n                          -- `inclusion_nn_to_zz_preserves_product`（`x → 2, y → n`）
      _ = inclusionNNtoZZ (1 + 1) * inclusionNNtoZZ n := rfl               -- ℕ の数字 `2 := 1 + 1`
      _ = (inclusionNNtoZZ 1 + 1) * inclusionNNtoZZ n := rfl               -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → 1_ℕ`）
      _ = (inclusionNNtoZZ (0 + 1) + 1) * inclusionNNtoZZ n := by
          rw [Nat.zero_add 1]                                               -- ℕ の加法の単位元 `0 + x = x`（`x → 1_ℕ`）を右辺から左辺へ
      _ = ((inclusionNNtoZZ 0 + 1) + 1) * inclusionNNtoZZ n := rfl         -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → 0_ℕ`）
      _ = ((0 + 1) + 1) * inclusionNNtoZZ n := rfl                         -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ`
      _ = (1 + 1) * inclusionNNtoZZ n := by rw [zero_add (1 : ℤ)]          -- ℤ の和の単位元 `0 + x = x`（`x → 1_ℤ`）
      _ = 2 * inclusionNNtoZZ n := rfl                                     -- `def_power_of_integer` の `2_ℤ := 1_ℤ + 1_ℤ` を右辺から左辺へ（最後の行の略記 `n_ℤ` は Lean では同じ項）
  -- 人手証明の準備の鎖 `(2_ℤ·a)_ℝ = 2_ℝ·a_ℝ`（`a ∈ ℤ`）。
  have htwoR : ∀ a : ℤ, (((2 : ℤ) * a : ℤ) : ℝ) = 2 * (a : ℝ) := fun a =>
    calc (((2 : ℤ) * a : ℤ) : ℝ)
        = ((2 : ℤ) : ℝ) * (a : ℝ) := inclusion_zz_to_rr_preserves_product 2 a  -- `inclusion_zz_to_rr_preserves_product`（`a → 2_ℤ, b → a`）
      _ = (((1 : ℤ) + 1 : ℤ) : ℝ) * (a : ℝ) := rfl                          -- `def_power_of_integer` の `2_ℤ := 1_ℤ + 1_ℤ`
      _ = (((1 : ℤ) : ℝ) + ((1 : ℤ) : ℝ)) * (a : ℝ) := by
          rw [inclusion_zz_to_rr_preserves_sum 1 1]                         -- `inclusion_zz_to_rr_preserves_sum`（`a, b → 1_ℤ`）
      _ = ((1 : ℝ) + 1) * (a : ℝ) := by
          rw [inclusion_zz_to_rr_of_one_intCast]                            -- `inclusion_zz_to_rr_of_one` を 2 か所へ
      _ = 2 * (a : ℝ) := by rw [← real_two_eq_one_add_one]                 -- `def_real_two` の `2 := 1 + 1` を右辺から左辺へ
  -- 人手証明の準備の鎖 `(2(M_col)_ℕ)_ℝ = ((2(M_col)_ℕ)_ℤ)_ℝ = (2_ℤM_col)_ℝ = 2_ℝ(M_col)_ℝ`。Lean の `(n : ℝ)` は `Nat.cast` なので、
  -- 人手の略記 `n_ℝ := (n_ℤ)_ℝ` へは `Int.cast_natCast` と `inclusionNNtoZZ_eq_natCast` で移す（Lean だけの段）。
  have h2MR : ((2 * M : ℕ) : ℝ) = 2 * (M : ℝ) :=
    calc ((2 * M : ℕ) : ℝ)
        = ((inclusionNNtoZZ (2 * M) : ℤ) : ℝ) := by
          rw [inclusionNNtoZZ_eq_natCast, Int.cast_natCast]                 -- 略記 `n_ℝ := (n_ℤ)_ℝ`（`n → 2(M_col)_ℕ`）
      _ = (((2 : ℤ) * inclusionNNtoZZ M : ℤ) : ℝ) := by rw [htwoZ M]       -- `(2(M_col)_ℕ)_ℤ = 2_ℤ·M_col`
      _ = 2 * ((inclusionNNtoZZ M : ℤ) : ℝ) := htwoR (inclusionNNtoZZ M)    -- `(2M_col)_ℝ = 2_ℝ(M_col)_ℝ`
      _ = 2 * (M : ℝ) := by
          rw [inclusionNNtoZZ_eq_natCast, Int.cast_natCast]                 -- `(M_col)_ℕ` の定義と略記 `n_ℝ` を右辺から左辺へ
  rw [expPhase, expPhase]
  congr 1
  -- 人手の T_{2M} の鎖の `(2(M_col)_ℕ)_ℝ = 2_ℝ(M_col)_ℝ` と、奇偶の分割の行の `((2μ)_ℤ)_ℝ = 2_ℝ(μ_ℤ)_ℝ`（周波数 `2n`）。
  -- `n_ℂ := (n_ℝ)_ℂ` の読みは `Complex.ofReal_natCast`・`Complex.ofReal_intCast`。残りの `push_cast`・`field_simp` は人手の「`2_ℝ ≠ 0_ℝ` による約分」の段である。
  rw [← Complex.ofReal_natCast (2 * M), h2MR, ← Complex.ofReal_intCast (2 * n), htwoR n]
  push_cast
  field_simp

/-- **反周期性の正体**: `expPhase (2M) M = -1`（`= e^{-iπ}`）。 -/
theorem expPhase_two_mul_half (hM : M ≠ 0) : expPhase (2 * M) (M : ℤ) = -1 := by
  have hMC : ((M : ℕ) : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have harg : -(2 * (Real.pi : ℂ) * Complex.I * (((M : ℤ) : ℂ))) / ((2 * M : ℕ) : ℂ)
      = -((Real.pi : ℂ) * Complex.I) := by
    push_cast
    field_simp
  rw [expPhase, harg, Complex.exp_neg, Complex.exp_pi_mul_I]
  norm_num

/-- `expPhase (2M) (-M) = -1`。 -/
theorem expPhase_two_mul_neg_half (hM : M ≠ 0) : expPhase (2 * M) (-(M : ℤ)) = -1 := by
  rw [show (-(M : ℤ)) = (-1 : ℤ) * (M : ℤ) by ring, expPhase_zpow, expPhase_two_mul_half hM]
  norm_num

/-! ## 半整数運動量 `θ~_μ` と位相因子 `check` -/

/-- **原文の `θ~_μ := 2π(μ_ℝ - 1/2)/(M_col)_ℝ ∈ ℝ`**。

原文の `(M_col)_ℝ` は `M_col ∈ ℤ` の `ι_{ℤ→ℝ}` による像で、`M_col = ι_{ℕ→ℤ}(M_ℕ)` である。
Lean の `M : ℕ` は `M_ℕ` を表すので、分母は `ℕ → ℤ → ℝ` の像 `((M : ℤ) : ℝ)` と書く
（`ℕ → ℝ` の直接の像 `(M : ℝ)` は原文に無い写像である）。 -/
noncomputable def thetaTilde (M : ℕ) (μ : ℤ) : ℝ := 2 * Real.pi * ((μ : ℝ) - 1 / 2) / ((M : ℤ) : ℝ)

/-- **原文の位相因子 `e^{-i k θ~_μ}`**。`2M` 乗根の**奇数**周波数 `k(2μ-1)` である。 -/
noncomputable def checkPhase (M : ℕ) (k μ : ℤ) : ℂ := expPhase (2 * M) (k * (2 * μ - 1))

/-- `checkPhase` が原文の `e^{-i k θ~_μ}` そのものであること。 -/
theorem checkPhase_eq_exp (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k μ = Complex.exp (-(Complex.I * (k : ℂ) * (thetaTilde M μ : ℂ))) := by
  have hMC : ((M : ℕ) : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  rw [checkPhase, expPhase, thetaTilde]
  congr 1
  push_cast
  field_simp

@[simp]
theorem checkPhase_zero_left (M : ℕ) (μ : ℤ) : checkPhase M 0 μ = 1 := by
  simp [checkPhase]

/-- 位相因子は掛けると周波数が足される。 -/
theorem checkPhase_add_left (M : ℕ) (k l μ : ℤ) :
    checkPhase M (k + l) μ = checkPhase M k μ * checkPhase M l μ := by
  rw [checkPhase, checkPhase, checkPhase, ← expPhase_add]
  congr 1
  ring

/-- **原文 `half_integer_phase_antiperiodicity`（反周期性）**: `e^{-iM θ~_μ} = -1`。

人手の `M_col ∈ ℤ` は名前を付けた写像の像 `ι_{ℕ→ℤ}(M)`（`inclusionNNtoZZ`、`inclusion_nn_to_zz`）。
`M(2μ-1) = 2M·μ - M` と分けて、前半は `2M` 乗根の周期（`= 1`）、
後半が `expPhase (2M) (-M) = -1` になる。 -/
theorem checkPhase_M (hM : M ≠ 0) (μ : ℤ) : checkPhase M (inclusionNNtoZZ M) μ = -1 := by
  -- Lean だけの段: 像 `ι_{ℕ→ℤ}(M)` を、以下の計算が使う Lean の `Nat.cast` の `(M : ℤ)` へ移す
  rw [inclusionNNtoZZ_eq_natCast]
  have hsplit : ((M : ℤ) * (2 * μ - 1)) = (μ * (2 * (M : ℤ))) + (-(M : ℤ)) := by ring
  have hfull : expPhase (2 * M) (μ * (2 * (M : ℤ))) = 1 := by
    rw [expPhase_zpow]
    have : expPhase (2 * M) (2 * (M : ℤ)) = 1 := by
      have h2M : ((2 * M : ℕ) : ℤ) = 2 * (M : ℤ) := by push_cast; ring
      exact (expPhase_eq_one_iff (by omega) _).2 (by rw [h2M])
    rw [this, one_zpow]
  rw [checkPhase, hsplit, expPhase_add, hfull, one_mul, expPhase_two_mul_neg_half hM]

/-- 添字 `μ` について `M` 周期（`half_integer_checkZ_periodicity` と
`half_integer_checkY_periodicity` に共通する位相因子の部分）。 -/
theorem checkPhase_period (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k (μ + (M : ℤ)) = checkPhase M k μ := by
  have hsplit : (k * (2 * (μ + (M : ℤ)) - 1)) = k * (2 * μ - 1) + (k * (2 * (M : ℤ))) := by ring
  have hone : expPhase (2 * M) (k * (2 * (M : ℤ))) = 1 := by
    rw [expPhase_zpow]
    have : expPhase (2 * M) (2 * (M : ℤ)) = 1 := by
      have h2M : ((2 * M : ℕ) : ℤ) = 2 * (M : ℤ) := by push_cast; ring
      exact (expPhase_eq_one_iff (by omega) _).2 (by rw [h2M])
    rw [this, one_zpow]
  rw [checkPhase, checkPhase, hsplit, expPhase_add, hone, mul_one]

/-! ## `0` 始まりの指数和（`exp_sum` の言い換え） -/

/-- `∑_{μ=0}^{M-1} exp(-2π√-1 μ k/M) = M δ^M_{(k,0)}`。

既存の `expPhase_sum`（`∑_{μ=1}^{M}`）と値が等しいこと（`μ=0` の項と `μ=M` の項が
どちらも `1`）を、位相因子を 1 つずらして示す。 -/
theorem expPhase_sum_zero_based (hM : M ≠ 0) (k : ℤ) :
    ∑ μ : Fin M, expPhase M (((μ : ℕ) : ℤ) * k) = (M : ℂ) * deltaMod M k 0 := by
  have hterm : ∀ μ : Fin M,
      expPhase M (((μ : ℕ) : ℤ) * k)
        = expPhase M (finIndexToZZ M μ * k) * expPhase M (-k) := by
    intro μ
    rw [← expPhase_add]
    congr 1
    simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
    ring
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finset.sum_mul, expPhase_sum hM]
  by_cases hd : (M : ℤ) ∣ k
  · rw [deltaMod, sub_zero, if_pos hd, mul_one,
      (expPhase_eq_one_iff hM (-k)).2 ((dvd_neg).2 hd), mul_one]
  · rw [deltaMod, sub_zero, if_neg hd, mul_zero, zero_mul]

/-- 長さ `2M` の有限和を、偶数番目と奇数番目へ分ける。人手証明の有限和の奇偶分割に対応する。 -/
private theorem sum_range_even_odd {A : Type*} [AddCommMonoid A] (f : ℕ → A) (M : ℕ) :
    ∑ r ∈ Finset.range (2 * M), f r =
      (∑ μ ∈ Finset.range M, f (2 * μ)) + ∑ μ ∈ Finset.range M, f (2 * μ + 1) := by
  induction M with
  | zero => simp
  | succ M ih =>
      rw [show 2 * (M + 1) = 2 * M + 2 by omega]
      simp only [Finset.sum_range_succ]
      rw [ih]
      abel

/-- 人手証明の奇偶分割そのもの:

`2M` 項の整数運動量指数和から偶数番目の `M` 項を引くと、半整数運動量指数和になる。 -/
theorem antiperiodic_exp_sum_delta_difference (hM : M ≠ 0) (k : ℤ) :
    ∑ μ : Fin M, checkPhase M (-k) (finIndexToZZ M μ) =
      ((2 * M : ℕ) : ℂ) * deltaMod (2 * M) k 0 - (M : ℂ) * deltaMod M k 0 := by
  have h2M : 2 * M ≠ 0 := by omega
  -- 人手証明の準備の鎖 `(2n)_ℤ = 2_ℤ·n_ℤ`（`n ∈ ℕ`）。
  have htwoZ : ∀ n : ℕ, inclusionNNtoZZ (2 * n) = 2 * inclusionNNtoZZ n := fun n =>
    calc inclusionNNtoZZ (2 * n)
        = inclusionNNtoZZ 2 * inclusionNNtoZZ n :=
          inclusion_nn_to_zz_preserves_product 2 n                          -- `inclusion_nn_to_zz_preserves_product`（`x → 2, y → n`）
      _ = inclusionNNtoZZ (1 + 1) * inclusionNNtoZZ n := rfl               -- ℕ の数字 `2 := 1 + 1`
      _ = (inclusionNNtoZZ 1 + 1) * inclusionNNtoZZ n := rfl               -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → 1_ℕ`）
      _ = (inclusionNNtoZZ (0 + 1) + 1) * inclusionNNtoZZ n := by
          rw [Nat.zero_add 1]                                               -- ℕ の加法の単位元 `0 + x = x`（`x → 1_ℕ`）を右辺から左辺へ
      _ = ((inclusionNNtoZZ 0 + 1) + 1) * inclusionNNtoZZ n := rfl         -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → 0_ℕ`）
      _ = ((0 + 1) + 1) * inclusionNNtoZZ n := rfl                         -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ`
      _ = (1 + 1) * inclusionNNtoZZ n := by rw [zero_add (1 : ℤ)]          -- ℤ の和の単位元 `0 + x = x`（`x → 1_ℤ`）
      _ = 2 * inclusionNNtoZZ n := rfl                                     -- `def_power_of_integer` の `2_ℤ := 1_ℤ + 1_ℤ` を右辺から左辺へ（最後の行の略記 `n_ℤ` は Lean では同じ項）
  -- 人手証明の準備の鎖 `(2μ - 1)_ℤ = 2_ℤ·μ_ℤ - 1_ℤ`（`μ ∈ ℕ`, `1 ≤ μ`）の 7 行と、Lean だけの 1 段（下の 8 段目）。以下のコードの束縛変数 `μ` は Lean の和の添字 `μ' ∈ {0,…,M-1}` で、人手の `μ` は `μ' + 1_ℕ` で、
  -- その像 `μ_ℤ = ι_{ℕ→ℤ}(μ' + 1_ℕ)` は `inclusion_nn_to_zz` の定義の式で `ι_{ℕ→ℤ}(μ') + 1_ℤ`（`finIndexToZZ` の値）。人手の ℕ の差 `2μ - 1` は
  -- ℕ の差を使わずに `2μ' + 1` と書く（人手の `(2μ - 1) + 1 = 2μ` は、Lean では ℕ の和と積の再帰の式で `(2μ' + 1) + 1 = 2(μ' + 1)` が定義として成り立つこと）。
  -- コメントの中では Lean の添字を `μ'`、人手の添字を `μ` と書き分ける。
  have hoddZ : ∀ μ : ℕ, inclusionNNtoZZ (2 * μ + 1) = 2 * (inclusionNNtoZZ μ + 1) - 1 := fun μ =>
    calc inclusionNNtoZZ (2 * μ + 1)
        = inclusionNNtoZZ (2 * μ + 1) + 0 := (add_zero _).symm             -- ℤ の和の単位元
      _ = inclusionNNtoZZ (2 * μ + 1) + (1 + (-1)) := by
          rw [add_neg_cancel (1 : ℤ)]                                       -- ℤ の加法の逆元
      _ = (inclusionNNtoZZ (2 * μ + 1) + 1) + (-1) := (add_assoc _ _ _).symm  -- ℤ の加法の結合律
      _ = inclusionNNtoZZ (2 * μ + 1 + 1) + (-1) := rfl                    -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ` を右辺から左辺へ
      _ = inclusionNNtoZZ (2 * (μ + 1)) + (-1) := rfl                      -- `(2μ - 1) + 1 = 2μ`
      _ = 2 * inclusionNNtoZZ (μ + 1) + (-1) := by rw [htwoZ (μ + 1)]      -- 準備の鎖 `(2n)_ℤ = 2_ℤ·n_ℤ`（`n → μ`。人手の `μ` は Lean の `μ' + 1_ℕ`）
      _ = 2 * (inclusionNNtoZZ μ + 1) + (-1) := rfl                        -- Lean だけの段: 人手の `μ_ℤ` を `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → μ'`）で `finIndexToZZ` の値の形に書く
      _ = 2 * (inclusionNNtoZZ μ + 1) - 1 := (int_sub_eq_add_neg _ _).symm -- `def_int_difference` を右辺から左辺へ
  -- 人手の `T_{2M}` の項の番号 `r ∈ {1,…,2(M_col)_ℕ}` の像 `r_ℤ` は、Lean の添字 `r'` に対して `ι_{ℕ→ℤ}(r') + 1_ℤ` と書く。
  have hsplit := sum_range_even_odd
    (fun r : ℕ => expPhase (2 * M) ((inclusionNNtoZZ r + 1) * (-k))) M
  have hodd :
      ∑ μ ∈ Finset.range M,
          expPhase (2 * M) ((inclusionNNtoZZ (2 * μ) + 1) * (-k)) =
        ∑ μ : Fin M, checkPhase M (-k) (finIndexToZZ M μ) := by
    -- 和の添字を、Lean の `Fin M` から ℕ の範囲 `{0,…,M-1}` へ移す（`finIndexToZZ` の定義 `i ↦ ι(i.val) + 1_ℤ`。Lean だけの段）
    rw [show (∑ μ : Fin M, checkPhase M (-k) (finIndexToZZ M μ))
        = ∑ μ ∈ Finset.range M, checkPhase M (-k) (inclusionNNtoZZ μ + 1) from
      Fin.sum_univ_eq_sum_range (fun μ : ℕ => checkPhase M (-k) (inclusionNNtoZZ μ + 1)) M]
    apply Finset.sum_congr rfl
    intro μ _
    rw [checkPhase]
    congr 1
    -- 人手の奇偶の分割の行の `(2μ - 1)_ℤ = 2_ℤμ_ℤ - 1_ℤ`（準備の鎖）。`ι(2μ') + 1_ℤ = ι(2μ' + 1_ℕ)` は `inclusion_nn_to_zz` の定義の式、
    -- 最後は ℤ の乗法の交換律。
    rw [show inclusionNNtoZZ (2 * μ) + 1 = inclusionNNtoZZ (2 * μ + 1) from rfl, hoddZ μ, mul_comm]
  have heven :
      ∑ μ ∈ Finset.range M,
          expPhase (2 * M) ((inclusionNNtoZZ (2 * μ + 1) + 1) * (-k)) =
        ∑ μ : Fin M, expPhase M (finIndexToZZ M μ * (-k)) := by
    -- 和の添字を、Lean の `Fin M` から ℕ の範囲へ移す（`finIndexToZZ` の定義。Lean だけの段）
    rw [show (∑ μ : Fin M, expPhase M (finIndexToZZ M μ * (-k)))
        = ∑ μ ∈ Finset.range M, expPhase M ((inclusionNNtoZZ μ + 1) * (-k)) from
      Fin.sum_univ_eq_sum_range (fun μ : ℕ => expPhase M ((inclusionNNtoZZ μ + 1) * (-k))) M]
    apply Finset.sum_congr rfl
    intro μ _
    rw [← expPhase_two_mul hM]
    congr 1
    -- 人手の奇偶の分割の行の `(2μ)_ℤ = 2_ℤμ_ℤ`（準備の鎖）。`ι(2μ' + 1) + 1_ℤ = ι(2(μ' + 1))` と `ι(μ' + 1) = ι(μ') + 1_ℤ` は
    -- `inclusion_nn_to_zz` の定義の式、最後は ℤ の乗法の結合律。
    rw [show inclusionNNtoZZ (2 * μ + 1) + 1 = inclusionNNtoZZ (2 * (μ + 1)) from rfl, htwoZ (μ + 1),
      show inclusionNNtoZZ (μ + 1) = inclusionNNtoZZ μ + 1 from rfl, mul_assoc]
  have hfull :
      ∑ r ∈ Finset.range (2 * M),
          expPhase (2 * M) ((inclusionNNtoZZ r + 1) * (-k)) =
        ((2 * M : ℕ) : ℂ) * deltaMod (2 * M) k 0 := by
    -- 和の添字を ℕ の範囲から Lean の `Fin (2M)` へ移し（`finIndexToZZ` の定義。Lean だけの段）、`exp_sum` を `2(M_col)_ℕ` に当てる
    rw [show (∑ r ∈ Finset.range (2 * M), expPhase (2 * M) ((inclusionNNtoZZ r + 1) * (-k)))
        = ∑ r : Fin (2 * M), expPhase (2 * M) (finIndexToZZ (2 * M) r * (-k)) from
      (Fin.sum_univ_eq_sum_range
        (fun r : ℕ => expPhase (2 * M) ((inclusionNNtoZZ r + 1) * (-k))) (2 * M)).symm,
      expPhase_sum h2M (-k), deltaMod, deltaMod, sub_zero, sub_zero]
    simp only [dvd_neg]   -- Lean だけの段: `expPhase` の符号の向き（`k ↦ -k`）を `M ∣ -k ⟺ M ∣ k` で戻す
  -- `exp_sum` を `(M_col)_ℕ` に当てる
  have hMsum :
      ∑ μ : Fin M, expPhase M (finIndexToZZ M μ * (-k)) =
        (M : ℂ) * deltaMod M k 0 := by
    rw [expPhase_sum hM (-k), deltaMod, deltaMod, sub_zero, sub_zero]
    simp only [dvd_neg]   -- Lean だけの段: `expPhase` の符号の向き（`k ↦ -k`）を `M ∣ -k ⟺ M ∣ k` で戻す
  calc
    ∑ μ : Fin M, checkPhase M (-k) (finIndexToZZ M μ)
        = ∑ μ ∈ Finset.range M,
            expPhase (2 * M) ((inclusionNNtoZZ (2 * μ) + 1) * (-k)) := hodd.symm
    _
        = (∑ r ∈ Finset.range (2 * M),
            expPhase (2 * M) ((inclusionNNtoZZ r + 1) * (-k))) -
          ∑ μ ∈ Finset.range M,
            expPhase (2 * M) ((inclusionNNtoZZ (2 * μ + 1) + 1) * (-k)) := by
              rw [hsplit]
              ring
    _ = ((2 * M : ℕ) : ℂ) * deltaMod (2 * M) k 0 -
          ∑ μ ∈ Finset.range M,
            expPhase (2 * M) ((inclusionNNtoZZ (2 * μ + 1) + 1) * (-k)) := by rw [hfull]
    _ = ((2 * M : ℕ) : ℂ) * deltaMod (2 * M) k 0 -
          ∑ μ : Fin M, expPhase M (finIndexToZZ M μ * (-k)) := by rw [heven]
    _ = ((2 * M : ℕ) : ℂ) * deltaMod (2 * M) k 0 -
          (M : ℂ) * deltaMod M k 0 := by rw [hMsum]

/-! ## `antiperiodic_exp_sum` 本体 -/

/-- **`antiperiodic_exp_sum` の形式化**:

  `∑_{μ=1}^{M} e^{i k θ~_μ} = e^{-iπk/M} · M δ^M_{(k,0)}`

（左辺の `e^{ikθ~_μ}` は `checkPhase M (-k) (finIndexToZZ M μ)`。）

原文は右辺を「`k = lM` なら `M(-1)^l`、そうでなければ `0`」と場合分けして書いているが、
`M ∤ k` のときは `δ^M_{(k,0)} = 0` で両者は一致し、`k = lM` のときの前因子
`expPhase (2M) (-k) = (-1)^l` は下の `antiperiodic_exp_sum_dvd` で評価する。

これは定数位相を括り出す補助的な閉形式であり、人手証明の奇偶分割は
`antiperiodic_exp_sum_delta_difference` が直接形式化する。 -/
theorem antiperiodic_exp_sum (hM : M ≠ 0) (k : ℤ) :
    ∑ μ : Fin M, checkPhase M (-k) (finIndexToZZ M μ)
      = expPhase (2 * M) (-k) * ((M : ℂ) * deltaMod M k 0) := by
  have hterm : ∀ μ : Fin M,
      checkPhase M (-k) (finIndexToZZ M μ)
        = expPhase (2 * M) (-k) * expPhase M (((μ : ℕ) : ℤ) * (-k)) := by
    intro μ
    rw [checkPhase, ← expPhase_two_mul hM (((μ : ℕ) : ℤ) * (-k)), ← expPhase_add]
    congr 1
    -- 人手の添字の像 `finIndexToZZ M μ` を Lean の添字の値へ戻して `0` 始まりの和に揃える（この補助的な閉形式だけの Lean の段）
    rw [finIndexToZZ, inclusionNNtoZZ_eq_natCast]
    ring
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, ← Finset.mul_sum,
    expPhase_sum_zero_based hM (-k)]
  congr 2
  rw [deltaMod, deltaMod, sub_zero, sub_zero]
  simp only [dvd_neg]

/-- 原文の `Complex.exp` の有限和と、計算に使う `checkPhase` の有限和は同じである。 -/
theorem antiperiodic_complex_exp_sum_eq_checkPhase (hM : M ≠ 0) (k : ℤ) :
    ∑ μ : Fin M, Complex.exp (Complex.I * (k : ℂ) *
        (thetaTilde M (finIndexToZZ M μ) : ℂ))
      = ∑ μ : Fin M, checkPhase M (-k) (finIndexToZZ M μ) := by
  have hMC : ((M : ℕ) : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  -- 人手証明の準備の鎖 `(2n)_ℤ = 2_ℤ·n_ℤ`（`n ∈ ℕ`）。
  have htwoZ : ∀ n : ℕ, inclusionNNtoZZ (2 * n) = 2 * inclusionNNtoZZ n := fun n =>
    calc inclusionNNtoZZ (2 * n)
        = inclusionNNtoZZ 2 * inclusionNNtoZZ n :=
          inclusion_nn_to_zz_preserves_product 2 n                          -- `inclusion_nn_to_zz_preserves_product`（`x → 2, y → n`）
      _ = inclusionNNtoZZ (1 + 1) * inclusionNNtoZZ n := rfl               -- ℕ の数字 `2 := 1 + 1`
      _ = (inclusionNNtoZZ 1 + 1) * inclusionNNtoZZ n := rfl               -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → 1_ℕ`）
      _ = (inclusionNNtoZZ (0 + 1) + 1) * inclusionNNtoZZ n := by
          rw [Nat.zero_add 1]                                               -- ℕ の加法の単位元 `0 + x = x`（`x → 1_ℕ`）を右辺から左辺へ
      _ = ((inclusionNNtoZZ 0 + 1) + 1) * inclusionNNtoZZ n := rfl         -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → 0_ℕ`）
      _ = ((0 + 1) + 1) * inclusionNNtoZZ n := rfl                         -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ`
      _ = (1 + 1) * inclusionNNtoZZ n := by rw [zero_add (1 : ℤ)]          -- ℤ の和の単位元 `0 + x = x`（`x → 1_ℤ`）
      _ = 2 * inclusionNNtoZZ n := rfl                                     -- `def_power_of_integer` の `2_ℤ := 1_ℤ + 1_ℤ` を右辺から左辺へ（最後の行の略記 `n_ℤ` は Lean では同じ項）
  -- 人手証明の準備の鎖 `(2_ℤ·a)_ℝ = 2_ℝ·a_ℝ`（`a ∈ ℤ`）。
  have htwoR : ∀ a : ℤ, (((2 : ℤ) * a : ℤ) : ℝ) = 2 * (a : ℝ) := fun a =>
    calc (((2 : ℤ) * a : ℤ) : ℝ)
        = ((2 : ℤ) : ℝ) * (a : ℝ) := inclusion_zz_to_rr_preserves_product 2 a  -- `inclusion_zz_to_rr_preserves_product`（`a → 2_ℤ, b → a`）
      _ = (((1 : ℤ) + 1 : ℤ) : ℝ) * (a : ℝ) := rfl                          -- `def_power_of_integer` の `2_ℤ := 1_ℤ + 1_ℤ`
      _ = (((1 : ℤ) : ℝ) + ((1 : ℤ) : ℝ)) * (a : ℝ) := by
          rw [inclusion_zz_to_rr_preserves_sum 1 1]                         -- `inclusion_zz_to_rr_preserves_sum`（`a, b → 1_ℤ`）
      _ = ((1 : ℝ) + 1) * (a : ℝ) := by
          rw [inclusion_zz_to_rr_of_one_intCast]                            -- `inclusion_zz_to_rr_of_one` を 2 か所へ
      _ = 2 * (a : ℝ) := by rw [← real_two_eq_one_add_one]                 -- `def_real_two` の `2 := 1 + 1` を右辺から左辺へ
  -- 人手証明の準備の鎖 `(2(M_col)_ℕ)_ℝ = ((2(M_col)_ℕ)_ℤ)_ℝ = (2_ℤM_col)_ℝ = 2_ℝ(M_col)_ℝ`。Lean の `(n : ℝ)` は `Nat.cast` なので、
  -- 人手の略記 `n_ℝ := (n_ℤ)_ℝ` へは `Int.cast_natCast` と `inclusionNNtoZZ_eq_natCast` で移す（Lean だけの段）。
  have h2MR : ((2 * M : ℕ) : ℝ) = 2 * (M : ℝ) :=
    calc ((2 * M : ℕ) : ℝ)
        = ((inclusionNNtoZZ (2 * M) : ℤ) : ℝ) := by
          rw [inclusionNNtoZZ_eq_natCast, Int.cast_natCast]                 -- 略記 `n_ℝ := (n_ℤ)_ℝ`（`n → 2(M_col)_ℕ`）
      _ = (((2 : ℤ) * inclusionNNtoZZ M : ℤ) : ℝ) := by rw [htwoZ M]       -- `(2(M_col)_ℕ)_ℤ = 2_ℤ·M_col`
      _ = 2 * ((inclusionNNtoZZ M : ℤ) : ℝ) := htwoR (inclusionNNtoZZ M)    -- `(2M_col)_ℝ = 2_ℝ(M_col)_ℝ`
      _ = 2 * (M : ℝ) := by
          rw [inclusionNNtoZZ_eq_natCast, Int.cast_natCast]                 -- `(M_col)_ℕ` の定義と略記 `n_ℝ` を右辺から左辺へ
  -- 人手証明の準備の鎖 `((2μ - 1)_ℤ)_ℝ = 2_ℝ(μ_ℤ)_ℝ - 1_ℝ` の 4 行（`m → μ_ℤ`）。
  have hoddR : ∀ m : ℤ, (((2 : ℤ) * m - 1 : ℤ) : ℝ) = 2 * (m : ℝ) - 1 := fun m =>
    calc (((2 : ℤ) * m - 1 : ℤ) : ℝ)
        = (((2 : ℤ) * m : ℤ) : ℝ) - ((1 : ℤ) : ℝ) :=
          inclusion_zz_to_rr_preserves_difference _ _                       -- `inclusion_zz_to_rr_preserves_difference`（`a → 2_ℤm, b → 1_ℤ`）
      _ = 2 * (m : ℝ) - ((1 : ℤ) : ℝ) := by rw [htwoR m]                   -- 準備の鎖 `(2_ℤ·a)_ℝ = 2_ℝ·a_ℝ`（`a → m`）
      _ = 2 * (m : ℝ) - 1 := by rw [inclusion_zz_to_rr_of_one_intCast]      -- `inclusion_zz_to_rr_of_one`
  apply Finset.sum_congr rfl
  intro μ _
  rw [checkPhase, expPhase, thetaTilde]
  congr 1
  -- 人手の奇偶の分割の行の `((2μ - 1)_ℤ)_ℝ = 2_ℝ(μ_ℤ)_ℝ - 1_ℝ` と T_{2M} の鎖の `(2(M_col)_ℕ)_ℝ = 2_ℝ(M_col)_ℝ`
  -- （`inclusion_zz_to_rr_preserves_product` で `((-k)(2μ - 1))_ℝ = (-k)_ℝ((2μ - 1))_ℝ`）。残りの `push_cast`・`field_simp` は、
  -- 人手の `k_ℝθ~_μ` の鎖（分子と分母に `2_ℝ` を掛ける段と ℝ の積の交換律・結合律）である。
  rw [← Complex.ofReal_intCast (-k * (2 * (finIndexToZZ M μ) - 1)), inclusion_zz_to_rr_preserves_product,
    hoddR, ← Complex.ofReal_natCast (2 * M), h2MR]
  push_cast
  field_simp

/-- **本文と同じ `Complex.exp` で書いた、奇偶分割によるデルタ差**。 -/
theorem antiperiodic_complex_exp_sum_delta_difference (hM : M ≠ 0) (k : ℤ) :
    ∑ μ : Fin M, Complex.exp (Complex.I * (k : ℂ) *
        (thetaTilde M (finIndexToZZ M μ) : ℂ))
      = ((2 * M : ℕ) : ℂ) * deltaMod (2 * M) k 0 - (M : ℂ) * deltaMod M k 0 := by
  rw [antiperiodic_complex_exp_sum_eq_checkPhase hM k,
    antiperiodic_exp_sum_delta_difference hM k]

/-- **原文と同じ `Complex.exp` で書いた `antiperiodic_exp_sum`**。 -/
theorem antiperiodic_complex_exp_sum (hM : M ≠ 0) (k : ℤ) :
    ∑ μ : Fin M, Complex.exp (Complex.I * (k : ℂ) *
        (thetaTilde M (finIndexToZZ M μ) : ℂ))
      = expPhase (2 * M) (-k) * ((M : ℂ) * deltaMod M k 0) := by
  rw [antiperiodic_complex_exp_sum_eq_checkPhase hM k, antiperiodic_exp_sum hM k]

/-- `antiperiodic_exp_sum` を、周波数をそのまま（符号を反転せずに）書いた形。
以降の計算ではこちらの形で使う。 -/
theorem sum_checkPhase (hM : M ≠ 0) (n : ℤ) :
    ∑ μ : Fin M, checkPhase M n (finIndexToZZ M μ)
      = expPhase (2 * M) n * ((M : ℂ) * deltaMod M n 0) := by
  have h := antiperiodic_exp_sum hM (-n)
  rw [neg_neg] at h
  rw [h]
  congr 2
  rw [deltaMod, deltaMod, sub_zero, sub_zero]
  simp only [dvd_neg]

/-- 人手 `antiperiodic_exp_sum` の `l` が偶数の鎖の 8 行目の根拠
`2_ℂ - 1_ℂ = (2_ℝ - 1_ℝ, 0_ℝ) = (1_ℝ, 0_ℝ) = 1_ℂ`（`inclusion_rr_to_cc`・`definition_of_cc`・
`def_complex_difference`）。 -/
theorem two_real_inclusion_sub_one : ((2 : ℝ) : ℂ) - 1 = 1 :=
  calc ((2 : ℝ) : ℂ) - 1
      = (⟨2 - 1, 0 - 0⟩ : ℂ) := rfl
        -- `inclusion_rr_to_cc`（`2_ℂ = (2_ℝ, 0_ℝ)`）・`definition_of_cc`（`1_ℂ = (1_ℝ, 0_ℝ)`）・`def_complex_difference`
    _ = ⟨1, 0⟩ := Complex.ext (by norm_num) (sub_self (0 : ℝ))
        -- ℝ で `2 - 1 = 1`。人手は第 2 成分の `0_ℝ - 0_ℝ = 0_ℝ` を書かずに `0_ℝ` としている
    _ = 1 := rfl                                                        -- `inclusion_rr_to_cc`

/-- **`antiperiodic_exp_sum` の `k = lM` の場合**: `∑_{μ=1}^{M} e^{i l M θ~_μ} = M(-1)^l`。 -/
theorem antiperiodic_exp_sum_dvd (hM : M ≠ 0) (l : ℤ) :
    ∑ μ : Fin M, checkPhase M (-(l * (M : ℤ))) (finIndexToZZ M μ)
      = (M : ℂ) * (-1 : ℂ) ^ l := by
  have hdelta : deltaMod M (l * (M : ℤ)) 0 = 1 := by
    rw [deltaMod, sub_zero, if_pos ⟨l, by ring⟩]
  have hsum := antiperiodic_exp_sum_delta_difference hM (l * (M : ℤ))
  -- 人手証明の準備の鎖 `(2n)_ℤ = 2_ℤ·n_ℤ`（`n ∈ ℕ`）。
  have htwoZ : ∀ n : ℕ, inclusionNNtoZZ (2 * n) = 2 * inclusionNNtoZZ n := fun n =>
    calc inclusionNNtoZZ (2 * n)
        = inclusionNNtoZZ 2 * inclusionNNtoZZ n :=
          inclusion_nn_to_zz_preserves_product 2 n                          -- `inclusion_nn_to_zz_preserves_product`（`x → 2, y → n`）
      _ = inclusionNNtoZZ (1 + 1) * inclusionNNtoZZ n := rfl               -- ℕ の数字 `2 := 1 + 1`
      _ = (inclusionNNtoZZ 1 + 1) * inclusionNNtoZZ n := rfl               -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → 1_ℕ`）
      _ = (inclusionNNtoZZ (0 + 1) + 1) * inclusionNNtoZZ n := by
          rw [Nat.zero_add 1]                                               -- ℕ の加法の単位元 `0 + x = x`（`x → 1_ℕ`）を右辺から左辺へ
      _ = ((inclusionNNtoZZ 0 + 1) + 1) * inclusionNNtoZZ n := rfl         -- `inclusion_nn_to_zz` の `ι(m + 1_ℕ) := ι(m) + 1_ℤ`（`m → 0_ℕ`）
      _ = ((0 + 1) + 1) * inclusionNNtoZZ n := rfl                         -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ`
      _ = (1 + 1) * inclusionNNtoZZ n := by rw [zero_add (1 : ℤ)]          -- ℤ の和の単位元 `0 + x = x`（`x → 1_ℤ`）
      _ = 2 * inclusionNNtoZZ n := rfl                                     -- `def_power_of_integer` の `2_ℤ := 1_ℤ + 1_ℤ` を右辺から左辺へ（最後の行の略記 `n_ℤ` は Lean では同じ項）
  -- 人手証明の準備の鎖 `(2_ℤ·a)_ℝ = 2_ℝ·a_ℝ`（`a ∈ ℤ`）。
  have htwoR : ∀ a : ℤ, (((2 : ℤ) * a : ℤ) : ℝ) = 2 * (a : ℝ) := fun a =>
    calc (((2 : ℤ) * a : ℤ) : ℝ)
        = ((2 : ℤ) : ℝ) * (a : ℝ) := inclusion_zz_to_rr_preserves_product 2 a  -- `inclusion_zz_to_rr_preserves_product`（`a → 2_ℤ, b → a`）
      _ = (((1 : ℤ) + 1 : ℤ) : ℝ) * (a : ℝ) := rfl                          -- `def_power_of_integer` の `2_ℤ := 1_ℤ + 1_ℤ`
      _ = (((1 : ℤ) : ℝ) + ((1 : ℤ) : ℝ)) * (a : ℝ) := by
          rw [inclusion_zz_to_rr_preserves_sum 1 1]                         -- `inclusion_zz_to_rr_preserves_sum`（`a, b → 1_ℤ`）
      _ = ((1 : ℝ) + 1) * (a : ℝ) := by
          rw [inclusion_zz_to_rr_of_one_intCast]                            -- `inclusion_zz_to_rr_of_one` を 2 か所へ
      _ = 2 * (a : ℝ) := by rw [← real_two_eq_one_add_one]                 -- `def_real_two` の `2 := 1 + 1` を右辺から左辺へ
  -- 人手証明の準備の鎖 `(2(M_col)_ℕ)_ℝ = ((2(M_col)_ℕ)_ℤ)_ℝ = (2_ℤM_col)_ℝ = 2_ℝ(M_col)_ℝ`。Lean の `(n : ℝ)` は `Nat.cast` なので、
  -- 人手の略記 `n_ℝ := (n_ℤ)_ℝ` へは `Int.cast_natCast` と `inclusionNNtoZZ_eq_natCast` で移す（Lean だけの段）。
  have h2MR : ((2 * M : ℕ) : ℝ) = 2 * (M : ℝ) :=
    calc ((2 * M : ℕ) : ℝ)
        = ((inclusionNNtoZZ (2 * M) : ℤ) : ℝ) := by
          rw [inclusionNNtoZZ_eq_natCast, Int.cast_natCast]                 -- 略記 `n_ℝ := (n_ℤ)_ℝ`（`n → 2(M_col)_ℕ`）
      _ = (((2 : ℤ) * inclusionNNtoZZ M : ℤ) : ℝ) := by rw [htwoZ M]       -- `(2(M_col)_ℕ)_ℤ = 2_ℤ·M_col`
      _ = 2 * ((inclusionNNtoZZ M : ℤ) : ℝ) := htwoR (inclusionNNtoZZ M)    -- `(2M_col)_ℝ = 2_ℝ(M_col)_ℝ`
      _ = 2 * (M : ℝ) := by
          rw [inclusionNNtoZZ_eq_natCast, Int.cast_natCast]                 -- `(M_col)_ℕ` の定義と略記 `n_ℝ` を右辺から左辺へ
  by_cases hl : Even l
  · have hdelta2 : deltaMod (2 * M) (l * (M : ℤ)) 0 = 1 := by
      rw [deltaMod, sub_zero, if_pos]
      rcases hl.two_dvd with ⟨q, hq⟩
      use q
      push_cast at hq ⊢
      calc
        l * (M : ℤ) = (2 * q) * (M : ℤ) := by rw [hq]
        _ = 2 * (M : ℤ) * q := by ring
    have hpow : (-1 : ℂ) ^ l = 1 := hl.neg_one_zpow
    calc
      ∑ μ : Fin M, checkPhase M (-(l * (M : ℤ))) (finIndexToZZ M μ) =
          ((2 * M : ℕ) : ℂ) * deltaMod (2 * M) (l * (M : ℤ)) 0 -
            (M : ℂ) * deltaMod M (l * (M : ℤ)) 0 := hsum              -- 人手の直前の鎖「`S = T_{2M} - T_M`」の結果
      _ = ((2 * M : ℕ) : ℂ) * 1 - (M : ℂ) * 1 := by rw [hdelta2, hdelta]       -- 1 行目
      _ = ((2 * M : ℕ) : ℂ) - (M : ℂ) * 1 := by rw [mul_one]                    -- 2 行目
      _ = ((2 * M : ℕ) : ℂ) - (M : ℂ) := by rw [mul_one]                        -- 3 行目
      _ = (((2 : ℝ) * (M : ℝ) : ℝ) : ℂ) - (M : ℂ) := by                         -- 4 行目
            -- `n_ℂ := (n_ℝ)_ℂ` の読み（`Complex.ofReal_natCast`）と準備の鎖 `(2(M_col)_ℕ)_ℝ = 2_ℝ(M_col)_ℝ`
            rw [← Complex.ofReal_natCast (2 * M), h2MR]
      _ = ((2 : ℝ) : ℂ) * (M : ℂ) - (M : ℂ) := by                               -- 5 行目
            -- `real_inclusion_preserves_product`。`((M)_ℝ)_ℂ` を `(M)_ℂ` と読む
            rw [← real_inclusion_mul, Complex.ofReal_natCast]
      _ = ((2 : ℝ) : ℂ) * (M : ℂ) - 1 * (M : ℂ) := by rw [one_mul]              -- 6 行目
      _ = (((2 : ℝ) : ℂ) - 1) * (M : ℂ) := by rw [sub_mul]                      -- 7 行目
      _ = 1 * (M : ℂ) := by rw [two_real_inclusion_sub_one]                     -- 8 行目
      _ = (M : ℂ) * 1 := by rw [mul_comm]                                       -- 9 行目
      _ = (M : ℂ) * (-1 : ℂ) ^ l := by rw [hpow]                                -- 10 行目
  · have hodd : Odd l := Int.not_even_iff_odd.mp hl
    have hdelta2 : deltaMod (2 * M) (l * (M : ℤ)) 0 = 0 := by
      rw [deltaMod, sub_zero, if_neg]
      intro hd
      rcases hd with ⟨q, hq⟩
      have hMint : (M : ℤ) ≠ 0 := by exact_mod_cast hM
      have heq : l * (M : ℤ) = (2 * q) * (M : ℤ) := by
        rw [hq]
        push_cast
        ring
      have hlq : l = 2 * q := mul_right_cancel₀ hMint heq
      exact hl ⟨q, by rw [hlq, two_mul]⟩
    have hpow : (-1 : ℂ) ^ l = -1 := hodd.neg_one_zpow
    calc
      ∑ μ : Fin M, checkPhase M (-(l * (M : ℤ))) (finIndexToZZ M μ) =
          ((2 * M : ℕ) : ℂ) * deltaMod (2 * M) (l * (M : ℤ)) 0 -
            (M : ℂ) * deltaMod M (l * (M : ℤ)) 0 := hsum              -- 人手の直前の鎖「`S = T_{2M} - T_M`」の結果
      _ = ((2 * M : ℕ) : ℂ) * 0 - (M : ℂ) * 1 := by rw [hdelta2, hdelta]       -- 1 行目
      _ = 0 - (M : ℂ) * 1 := by rw [mul_zero]                                   -- 2 行目 `complex_times_zero_is_zero`（`z → (2M_col)_ℂ`。具体版は無く `mul_zero`）
      _ = 0 - (M : ℂ) := by rw [mul_one]                                        -- 3 行目
      _ = 0 + (-(M : ℂ)) := by rw [sub_eq_add_neg]                              -- 4 行目 `def_complex_difference`
      _ = -(M : ℂ) := by rw [zero_add]                                          -- 5 行目 `complex_zero_plus_is_original`（`z → -(M_col)_ℂ`。具体版は無く `zero_add`）
      _ = (-1) * (M : ℂ) := by rw [neg_one_mul]                                 -- 6 行目 `multiply_by_minus_one`
      _ = (M : ℂ) * (-1) := by rw [mul_comm]                                    -- 7 行目
      _ = (M : ℂ) * (-1 : ℂ) ^ l := by rw [hpow]                                -- 8 行目

/-- **原文と同じ `Complex.exp` で書いた `k = lM` の場合**。 -/
theorem antiperiodic_complex_exp_sum_dvd (hM : M ≠ 0) (l : ℤ) :
    ∑ μ : Fin M, Complex.exp (Complex.I * ((l * (M : ℤ) : ℤ) : ℂ) *
        (thetaTilde M (finIndexToZZ M μ) : ℂ))
      = (M : ℂ) * (-1 : ℂ) ^ l := by
  rw [antiperiodic_complex_exp_sum_eq_checkPhase hM (l * (M : ℤ)),
    antiperiodic_exp_sum_dvd hM l]

/-- **`antiperiodic_exp_sum` の `M ∤ k` の場合**: 和は `0`。 -/
theorem antiperiodic_exp_sum_not_dvd (hM : M ≠ 0) {k : ℤ} (hk : ¬ (M : ℤ) ∣ k) :
    ∑ μ : Fin M, checkPhase M (-k) (finIndexToZZ M μ) = 0 := by
  -- 人手証明の準備の鎖 `(2(M_col)_ℕ)_ℤ = 2_ℤ·M_col` の 11 行。
  -- 1 行目（略記 `n_ℤ`）は Lean の `((2 * M : ℕ) : ℤ)` が `Nat.cast` なので `inclusionNNtoZZ_eq_natCast` で `ι_{ℕ→ℤ}` の形へ移す段、
  -- 最後の 2 行（略記 `n_ℤ` を右辺から左辺へ、`(M_col)_ℕ` の定義）は同じ補題で `Nat.cast` の形へ戻す 1 段である。
  have h2M : ((2 * M : ℕ) : ℤ) = 2 * (M : ℤ) :=
    calc ((2 * M : ℕ) : ℤ)
        = inclusionNNtoZZ (2 * M) := (inclusionNNtoZZ_eq_natCast (2 * M)).symm  -- 略記 `n_ℤ := ι_{ℕ→ℤ}(n)`（`n → 2·(M_col)_ℕ`）
      _ = inclusionNNtoZZ 2 * inclusionNNtoZZ M :=
          inclusion_nn_to_zz_preserves_product 2 M                          -- `inclusion_nn_to_zz_preserves_product`（`x → 2, y → (M_col)_ℕ`）
      _ = inclusionNNtoZZ (1 + 1) * inclusionNNtoZZ M := rfl               -- ℕ の数字 `2 := 1 + 1`
      _ = (inclusionNNtoZZ 1 + 1) * inclusionNNtoZZ M := rfl               -- `inclusion_nn_to_zz` の `ι(n + 1_ℕ) := ι(n) + 1_ℤ`（`n → 1_ℕ`）
      _ = (inclusionNNtoZZ (0 + 1) + 1) * inclusionNNtoZZ M := by
          rw [Nat.zero_add 1]                                               -- ℕ の加法の単位元 `0 + x = x`（`x → 1_ℕ`）を右辺から左辺へ
      _ = ((inclusionNNtoZZ 0 + 1) + 1) * inclusionNNtoZZ M := rfl         -- `inclusion_nn_to_zz` の `ι(n + 1_ℕ) := ι(n) + 1_ℤ`（`n → 0_ℕ`）
      _ = ((0 + 1) + 1) * inclusionNNtoZZ M := rfl                         -- `inclusion_nn_to_zz` の `ι(0_ℕ) := 0_ℤ`
      _ = (1 + 1) * inclusionNNtoZZ M := by rw [zero_add (1 : ℤ)]          -- ℤ の和の単位元 `0 + x = x`（`x → 1_ℤ`）
      _ = 2 * inclusionNNtoZZ M := rfl                                     -- `def_power_of_integer` の `2_ℤ := 1_ℤ + 1_ℤ` を右辺から左辺へ
      _ = 2 * (M : ℤ) := by rw [inclusionNNtoZZ_eq_natCast M]              -- 略記 `n_ℤ` を右辺から左辺へ・`(M_col)_ℕ` の定義
  -- 人手の「`2M_col ∣ k` なら `M_col ∣ k` となることの対偶から `2M_col ∤ k`」。`M_col ∣ 2M_col` は ℤ の乗法の交換律 `2M_col = M_col·2`。
  have hk2 : ¬ (2 * (M : ℤ)) ∣ k := by
    intro hd
    apply hk
    exact dvd_trans ⟨2, mul_comm 2 (M : ℤ)⟩ hd
  have hdelta2 : deltaMod (2 * M) k 0 = 0 := by
    rw [deltaMod, sub_zero, if_neg (by rw [h2M]; exact hk2)]
  have hdelta : deltaMod M k 0 = 0 := by rw [deltaMod, sub_zero, if_neg hk]
  calc ∑ μ : Fin M, checkPhase M (-k) (finIndexToZZ M μ)
      = ((2 * M : ℕ) : ℂ) * deltaMod (2 * M) k 0 - (M : ℂ) * deltaMod M k 0 :=
        antiperiodic_exp_sum_delta_difference hM k                    -- 人手の直前の鎖「`S = T_{2M} - T_M`」の結果
    _ = ((2 * M : ℕ) : ℂ) * 0 - (M : ℂ) * 0 := by rw [hdelta2, hdelta]  -- 1 行目
    _ = 0 - (M : ℂ) * 0 := by rw [mul_zero]                             -- 2 行目 `complex_times_zero_is_zero`（`z → (2M_col)_ℂ`。具体版は無く `mul_zero`）
    _ = (0 : ℂ) - 0 := by rw [mul_zero]                                 -- 3 行目 `complex_times_zero_is_zero`（`z → (M_col)_ℂ`）
    _ = (0 : ℂ) + (-0) := by rw [sub_eq_add_neg]                        -- 4 行目 `def_complex_difference`
    _ = -(0 : ℂ) := by rw [zero_add]                                    -- 5 行目 `complex_zero_plus_is_original`（`z → -0_ℂ`。具体版は無く `zero_add`）
    _ = (-1) * (0 : ℂ) := by rw [neg_one_mul]                           -- 6 行目 `multiply_by_minus_one`
    _ = 0 := by rw [mul_zero]                                           -- 7 行目 `complex_times_zero_is_zero`（`z → -1_ℂ`）

/-- **原文と同じ `Complex.exp` で書いた `M ∤ k` の場合**。 -/
theorem antiperiodic_complex_exp_sum_not_dvd (hM : M ≠ 0) {k : ℤ}
    (hk : ¬ (M : ℤ) ∣ k) :
    ∑ μ : Fin M, Complex.exp (Complex.I * (k : ℂ) *
        (thetaTilde M (finIndexToZZ M μ) : ℂ)) = 0 := by
  rw [antiperiodic_complex_exp_sum_eq_checkPhase hM k,
    antiperiodic_exp_sum_not_dvd hM hk]

/-- **原文の「とくに」の非零の場合**: `|k| < M` かつ `k ≠ 0` なら和は `0`。 -/
theorem antiperiodic_exp_sum_nonzero_of_abs_lt (hM : M ≠ 0) {k : ℤ}
    (hklt : |k| < (M : ℤ)) (hk0 : k ≠ 0) :
    ∑ μ : Fin M, checkPhase M (-k) (finIndexToZZ M μ) = 0 := by
  apply antiperiodic_exp_sum_not_dvd hM
  intro hd
  rcases hd with ⟨l, hl⟩
  -- 人手証明の `k = lM_col`。Lean の整除 `M ∣ k` は `k = M·l` を与えるので、ℤ の乗法の交換律で並べ替える。
  have hk_lM : k = l * (M : ℤ) := by rw [hl, mul_comm]
  have hk_abs : |k| = |l * (M : ℤ)| := by rw [hk_lM]
  -- 人手証明の `0_ℤ ≤ M_col` の 3 行。2 行目（略記 `n_ℤ`）と 3 行目（`(M_col)_ℕ` の定義）は、Lean の `(M : ℤ)` は `Nat.cast M` で、`inclusionNNtoZZ_eq_natCast` により `ι_{ℕ→ℤ}(M)` と等しいので段が要らない。
  have hM_nonneg : (0 : ℤ) ≤ (M : ℤ) :=
    calc (0 : ℤ) ≤ inclusionNNtoZZ M := inclusion_nn_to_zz_image_is_nonnegative M  -- `inclusion_nn_to_zz_image_is_nonnegative`（`n → (M_col)_ℕ`）
      _ = (M : ℤ) := inclusionNNtoZZ_eq_natCast M                      -- 具体版の `ι_{ℕ→ℤ}` を `Nat.cast` の形へ移す（Lean だけの段）
  -- 人手証明の `|lM_col| = |l|M_col`（`int_absolute_value_of_product_with_nonnegative`、`x → l, y → M_col`、`0 ≤ M_col`）。
  have habs_product : |l * (M : ℤ)| = |l| * (M : ℤ) :=
    int_absolute_value_of_product_with_nonnegative l (M : ℤ) hM_nonneg
  -- 人手証明の鎖 `|l|M_col = |lM_col| = |k| < M_col`。
  have habs_mul : |l| * (M : ℤ) < (M : ℤ) := by
    calc
      |l| * (M : ℤ) = |l * (M : ℤ)| := habs_product.symm
      _ = |k| := hk_abs.symm
      _ < (M : ℤ) := hklt
  -- 人手証明の `|l| < 1_ℤ`（`int_less_than_one_of_product_less_than_nonnegative_factor`、`x → |l|, c → M_col`、`0 ≤ M_col` と `|l|M_col < M_col`）。
  have hl_abs_lt_one : |l| < 1 :=
    int_less_than_one_of_product_less_than_nonnegative_factor |l| (M : ℤ) hM_nonneg habs_mul
  have hl_abs_nonneg : 0 ≤ |l| := int_absolute_value_is_nonnegative l   -- `int_absolute_value_is_nonnegative`（`x → l`）
  -- 人手証明の `|l| + 1_ℤ ≤ 1_ℤ`（`def_int_strict_order` で `|l| < 1_ℤ` を書き直す）。
  have hl_add_one_le : |l| + 1 ≤ 1 := (int_lt_iff_add_one_le |l| 1).mp hl_abs_lt_one
  -- 人手証明の `|l| ≤ 0_ℤ` を導く 5 行。
  have hl_abs_nonpos : |l| ≤ 0 :=
    calc |l| = |l| + 0 := (add_zero |l|).symm                         -- `ℤ` の和の単位元（`x → |l|`）
      _ = |l| + (1 + -1) := by rw [add_neg_cancel 1]                  -- `ℤ` の加法逆元（`x → 1_ℤ`）
      _ = (|l| + 1) + -1 := (add_assoc |l| 1 (-1)).symm               -- `ℤ` の加法の結合律
      _ ≤ 1 + -1 := add_le_add_left hl_add_one_le (-1)                -- `ℤ` の順序と加法の両立（`t → -1_ℤ`）
      _ = 0 := add_neg_cancel 1                                       -- `ℤ` の加法逆元（`x → 1_ℤ`）
  -- 人手証明の `|l| = 0_ℤ`（`ℤ` の順序の反対称律）。
  have hl_abs_zero : |l| = 0 := le_antisymm hl_abs_nonpos hl_abs_nonneg
  have hl_zero : l = 0 := int_absolute_value_zero_implies_zero l hl_abs_zero   -- `int_absolute_value_zero_implies_zero`（`x → l`）
  -- 人手証明の `k = lM_col = 0_ℤ·M_col = 0_ℤ`。
  have hk_zero : k = 0 :=
    calc k = l * (M : ℤ) := hk_lM                                         -- `k = lM_col`
      _ = 0 * (M : ℤ) := by rw [hl_zero]                                  -- `l = 0_ℤ`
      _ = 0 := int_zero_times_is_zero (M : ℤ)                             -- `int_zero_times_is_zero`（`x → M_col`）
  exact hk0 hk_zero

/-- **原文と同じ `Complex.exp` で書いた「とくに」の非零の場合**。 -/
theorem antiperiodic_complex_exp_sum_nonzero_of_abs_lt (hM : M ≠ 0) {k : ℤ}
    (hklt : |k| < (M : ℤ)) (hk0 : k ≠ 0) :
    ∑ μ : Fin M, Complex.exp (Complex.I * (k : ℂ) *
        (thetaTilde M (finIndexToZZ M μ) : ℂ)) = 0 := by
  rw [antiperiodic_complex_exp_sum_eq_checkPhase hM k,
    antiperiodic_exp_sum_nonzero_of_abs_lt hM hklt hk0]

/-- **原文の「とくに」の零の場合**: `k = 0` なら和は `M`。 -/
theorem antiperiodic_exp_sum_zero (_hM : M ≠ 0) :
    ∑ μ : Fin M, checkPhase M 0 (finIndexToZZ M μ) = (M : ℂ) := by
  calc
    ∑ μ : Fin M, checkPhase M 0 (finIndexToZZ M μ)
        = (M : ℂ) * (-1 : ℂ) ^ (0 : ℤ) := by
            simpa using antiperiodic_exp_sum_dvd _hM 0
    _ = (M : ℂ) * 1 := by rw [zpow_zero]
    _ = (M : ℂ) := by rw [mul_one]

/-- **原文と同じ `Complex.exp` で書いた「とくに」の零の場合**。 -/
theorem antiperiodic_complex_exp_sum_zero (hM : M ≠ 0) :
    ∑ μ : Fin M, Complex.exp (Complex.I * (0 : ℂ) *
        (thetaTilde M (finIndexToZZ M μ) : ℂ)) = (M : ℂ) := by
  calc
    ∑ μ : Fin M, Complex.exp (Complex.I * (0 : ℂ) *
        (thetaTilde M (finIndexToZZ M μ) : ℂ))
        = ∑ μ : Fin M, checkPhase M 0 (finIndexToZZ M μ) := by
            simpa only [Int.cast_zero, neg_zero] using
              antiperiodic_complex_exp_sum_eq_checkPhase hM 0
    _ = (M : ℂ) := antiperiodic_exp_sum_zero hM

end Ising2D
