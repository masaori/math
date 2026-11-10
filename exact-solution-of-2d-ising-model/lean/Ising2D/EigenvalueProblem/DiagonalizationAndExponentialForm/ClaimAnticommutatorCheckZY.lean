/-
# `check(Z)`, `check(Y)` の反交換関係（**具体版**）

対応する人手証明のラベル: `anticommutator_of_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evensector_005_claim_anticommutator_check_Z_Y`）

**必要十分版**は `Ising2D/NecSuf/AntiperiodicFourier.lean` の
`Ising2D.NecSuf.acomm_antiperiodic_fourier_clifford`（同じラベル）。
必要十分版からの導出は `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimAnticommutatorCheckZYFromNecSuf.lean`。

## 原文の主張（`μ, ν ∈ 𝓜̌`）

  `[check(Z)_μ, check(Z)_ν]₊ = 2M δ_{ν, M+1-μ} I`
  `[check(Z)_μ, check(Y)_ν]₊ = 0`
  `[check(Y)_μ, check(Y)_ν]₊ = 2M δ_{ν, M+1-μ} I`

## 形式化の方針

* まず `μ, ν ∈ ℤ` 全体で `δ^M_{(μ+ν,1)}`（合同式の形）で述べ、
  そのあと `def_check_index_set` (5)（`Ising2D.deltaMod_add_one_eq`）で
  `μ, ν ∈ 𝓜̌` の場合の `δ_{ν, M+1-μ}` に落とす。原文の構成と同じ順序である。
* 第 1〜3 式の証明は原文の一続きの式変形と 1 行ずつ対応する `calc` で書く（第 1・3 式の最後の
  `def_check_index_set` (5) の行は `_of_mem` の形が受け持つ）。
  各行の根拠は行の直前のコメントに原文の `(∵ …)` を写した。
* 第 1・3 式の `scalar_exp_product` → 準備 2 → `exp_sum` の 3 行は、人手の準備 2 の 2 本の鎖
  （実数の側 `anticomm_exponent_real_chain`、複素数の側 `anticomm_exponent_complex_chain`）を補題として立て、
  人手の行と 1 段ずつ対応させる。その前後の 2 段は人手の行ではなく読みである:
  `checkPhase M j λ` を人手の `e_{j,λ} = exp((-i)(j_ℝ θ~_λ)_ℂ)` と読む段（`checkPhase_eq_exp_neg_I_mul`。`ReductionToATheta/DefinitionHalfIntegerModes.lean`）と、
  `exp_sum` の Lean の形 `expPhase_sum`（`exp(-√-1·2π jk/M)` の和）を人手の読み
  「左辺の指数 `2πijκ/N` は `i(y_j)_ℂ`」の形に直した `exp_sum_as_I_mul_real`（`k ↦ -κ` で当て、`M ∣ x ⟺ M ∣ -x`）。
* 指数法則 `scalar_exp_product` の行は、`def_scalar_exp` の具体版が Lean に無いので mathlib の `Complex.exp_add` で表す
  （`ClaimConjugateIndex.lean` と同じ扱い）。
* 準備 2 の 2 本の鎖が実際に使うのは、実数の鎖では標数 2 でない体の等式（`1/2 + 1/2 = 1`）と `ℤ` からの環準同型が
  和・符号反転・`1` を保つこと（`π` は任意の元でよく、ℝ の順序・完備性は使わない）、複素数の鎖では可換環への環準同型
  （包含）が和・積を保つこと（`real_inclusion_add` と、`neg_I_mul_real_neg_eq_I_mul` が使う `real_inclusion_mul`）と、`-1`・`i` の積の計算（`neg_I_mul_eq_neg_of_I_mul`・`neg_I_mul_real_neg_eq_I_mul` が持つ）だけである。
  2 本の鎖ごとの必要十分版は置かない。主張全体の必要十分版 `acomm_antiperiodic_fourier_clifford` が、位相
  `exp((-i)(j_ℝθ~_λ)_ℂ)` を `ξ^{j(2λ-1)}` と抽象し、`scalar_exp_product` と準備 2 の 2 本の鎖を `ξ` の冪の指数の足し算
  `(2μ-1)+(2ν-1) = 2(μ+ν-1)` に吸収しているからである。必要十分版は `ξ` を `e^{-iθ~}` の向きに取り、指数和を
  `μ+ν-1` に直接当てるので、具体版の `κ = -(μ+ν-1)` と `deltaMod_neg_sub_one` の符号反転の段に当たる段が無い
  （段の対応はここだけ 1 段ずれる）。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimConjugateIndex
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionHalfIntegerModes
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimAnticommutatorZY
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExpSum
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimCosSinAndITimesAtNegatedReal

namespace Ising2D

variable {M : ℕ}

/-- 原文の行「`1 ≤ j, k ≤ M` では `δ^M_{(j,k)} = 1 ⟺ j = k`」:
二重和 `∑_j ∑_k c_j d_k · 2I δ^M_{(j,k)}` は `j = k` の項だけが残り `2I ∑_j c_j d_j` になる。 -/
theorem sum_sum_smul_two_deltaM_smul_one (c d : Fin M → ℂ) :
    ∑ j, ∑ k, (c j * d k) • ((2 * deltaM j k) • (1 : TensorPow M))
      = (2 * ∑ j, c j * d j) • (1 : TensorPow M) := by
  rw [Finset.mul_sum, Finset.sum_smul]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_eq_single_of_mem j (Finset.mem_univ j)]
  · rw [deltaM, if_pos rfl, smul_smul]
    congr 1
    ring
  · intro k _ hkj
    rw [deltaM, if_neg (Ne.symm hkj), mul_zero, zero_smul, smul_zero]

/-- 人手の行 `δ^{(M_col)}_{(κ,0)} = δ^{(M_col)}_{(μ+ν,1)}`（`κ = -((μ+ν)-1)`。`def_delta_M`）:
`κ - 0 = -((μ+ν)-1)` なので `κ ≡ 0 ⟺ μ+ν ≡ 1 (mod M_col)`。 -/
theorem deltaMod_neg_sub_one (M : ℕ) (μ ν : ℤ) :
    deltaMod M (-(μ + ν - 1)) 0 = deltaMod M (μ + ν) 1 := by
  rw [deltaMod, deltaMod, sub_zero]
  simp only [dvd_neg]

/-- **準備 2 の実数の鎖**: `j_ℝθ~_μ + j_ℝθ~_ν = -(2π j_ℝ κ_ℝ / (M_col)_ℝ)`（`κ = -(μ+ν-1)`）。
人手の `j` は Lean の `k` である。人手の 20 行に 1 段ずつ対応する（`2π` は Lean では積 `2 * Real.pi`）。 -/
theorem anticomm_exponent_real_chain (k μ ν : ℤ) :
    (k : ℝ) * thetaTilde M μ + (k : ℝ) * thetaTilde M ν
      = -(2 * Real.pi * (k : ℝ) * ((-(μ + ν - 1) : ℤ) : ℝ) / ((M : ℤ) : ℝ)) :=
  calc (k : ℝ) * thetaTilde M μ + (k : ℝ) * thetaTilde M ν
      = (k : ℝ) * (thetaTilde M μ + thetaTilde M ν) := (mul_add _ _ _).symm  -- ℝ の分配法則
    _ = (k : ℝ) * (2 * Real.pi * ((μ : ℝ) - 1 / 2) / ((M : ℤ) : ℝ)
          + 2 * Real.pi * ((ν : ℝ) - 1 / 2) / ((M : ℤ) : ℝ)) := by
        rw [thetaTilde, thetaTilde]                                   -- θ~ の定義を 2 箇所へ
    _ = (k : ℝ) * ((2 * Real.pi * ((μ : ℝ) - 1 / 2) + 2 * Real.pi * ((ν : ℝ) - 1 / 2))
          / ((M : ℤ) : ℝ)) := by
        rw [← add_div]          -- `(M_col)_ℝ ≠ 0` を分母とする分数の和（Lean の `add_div` は `≠ 0` を要しない）
    _ = (k : ℝ) * (2 * Real.pi * (((μ : ℝ) - 1 / 2) + ((ν : ℝ) - 1 / 2)) / ((M : ℤ) : ℝ)) := by
        rw [← mul_add]                                                -- ℝ の分配法則
    _ = (k : ℝ) * (2 * Real.pi * (((μ : ℝ) + (-(1 / 2))) + ((ν : ℝ) + (-(1 / 2))))
          / ((M : ℤ) : ℝ)) := by
        rw [sub_eq_add_neg (μ : ℝ), sub_eq_add_neg (ν : ℝ)]           -- 差は加法の逆元の和を 2 箇所へ
    _ = (k : ℝ) * (2 * Real.pi * ((μ : ℝ) + ((-(1 / 2)) + ((ν : ℝ) + (-(1 / 2)))))
          / ((M : ℤ) : ℝ)) := by
        rw [add_assoc (μ : ℝ)]                                        -- ℝ の加法の結合律
    _ = (k : ℝ) * (2 * Real.pi * ((μ : ℝ) + (((ν : ℝ) + (-(1 / 2))) + (-(1 / 2))))
          / ((M : ℤ) : ℝ)) := by
        rw [add_comm (-(1 / 2) : ℝ) ((ν : ℝ) + (-(1 / 2)))]           -- ℝ の加法の交換律
    _ = (k : ℝ) * (2 * Real.pi * ((μ : ℝ) + ((ν : ℝ) + ((-(1 / 2)) + (-(1 / 2)))))
          / ((M : ℤ) : ℝ)) := by
        rw [add_assoc (ν : ℝ)]                                        -- ℝ の加法の結合律
    _ = (k : ℝ) * (2 * Real.pi * (((μ : ℝ) + (ν : ℝ)) + ((-(1 / 2)) + (-(1 / 2))))
          / ((M : ℤ) : ℝ)) := by
        rw [← add_assoc (μ : ℝ)]                                      -- ℝ の加法の結合律
    _ = (k : ℝ) * (2 * Real.pi * (((μ : ℝ) + (ν : ℝ)) + (-(1 / 2 + 1 / 2))) / ((M : ℤ) : ℝ)) := by
        rw [neg_add]                                                  -- `(-a)+(-b) = -(a+b)`
    _ = (k : ℝ) * (2 * Real.pi * (((μ : ℝ) + (ν : ℝ)) + (-1)) / ((M : ℤ) : ℝ)) := by
        rw [add_halves]                                               -- `1/2 + 1/2 = 1_ℝ`
    _ = (k : ℝ) * (2 * Real.pi * ((μ : ℝ) + (ν : ℝ) - 1) / ((M : ℤ) : ℝ)) := by
        rw [← sub_eq_add_neg]                                         -- 差は加法の逆元の和
    _ = (k : ℝ) * (2 * Real.pi * (-(-((μ : ℝ) + (ν : ℝ) - 1))) / ((M : ℤ) : ℝ)) := by
        rw [neg_neg]                                                  -- `-(-x) = x`
    _ = (k : ℝ) * (2 * Real.pi * (-((-(μ + ν - 1) : ℤ) : ℝ)) / ((M : ℤ) : ℝ)) := by
        rw [Int.cast_neg, Int.cast_sub, Int.cast_add, Int.cast_one]   -- `ℤ → ℝ` は和・符号反転・`1` を保つ
    _ = (k : ℝ) * (2 * Real.pi * (-((-(μ + ν - 1) : ℤ) : ℝ))) / ((M : ℤ) : ℝ) :=
        (mul_div_assoc _ _ _).symm                                    -- `a(b/c) = (ab)/c`
    _ = (k : ℝ) * (-(2 * Real.pi * ((-(μ + ν - 1) : ℤ) : ℝ))) / ((M : ℤ) : ℝ) := by
        rw [mul_neg (2 * Real.pi)]                                    -- `a(-b) = -(ab)`
    _ = (-((k : ℝ) * (2 * Real.pi * ((-(μ + ν - 1) : ℤ) : ℝ)))) / ((M : ℤ) : ℝ) := by
        rw [mul_neg (k : ℝ)]                                          -- `a(-b) = -(ab)`
    _ = (-((k : ℝ) * (2 * Real.pi) * ((-(μ + ν - 1) : ℤ) : ℝ))) / ((M : ℤ) : ℝ) := by
        rw [← mul_assoc (k : ℝ)]                                      -- ℝ の積の結合律
    _ = (-(2 * Real.pi * (k : ℝ) * ((-(μ + ν - 1) : ℤ) : ℝ))) / ((M : ℤ) : ℝ) := by
        rw [mul_comm (k : ℝ) (2 * Real.pi)]                           -- ℝ の積の交換律
    _ = -(2 * Real.pi * (k : ℝ) * ((-(μ + ν - 1) : ℤ) : ℝ) / ((M : ℤ) : ℝ)) := neg_div _ _
                                                                      -- `(-a)/c = -(a/c)`

/-- **準備 2 の複素数の鎖**: `(-i)(a)_ℂ + (-i)(b)_ℂ = i(y)_ℂ`（`a + b = -y`。人手では `a = j_ℝθ~_μ`、
`b = j_ℝθ~_ν`、`y = y_j`、`h` は直前の実数の鎖 `anticomm_exponent_real_chain`）。人手の 5 行に 1 段ずつ対応する。
2 段目の二項の和の像は具体版 `real_inclusion_add`（人手 `real_inclusion_preserves_finite_sum` を `m = 2` で）、
4 段目は `neg_I_mul_eq_neg_of_I_mul`（人手 `negative_i_times_complex_is_negation_of_i_times`、`z → (-y_j)_ℂ`）、
5 段目は `neg_I_mul_real_neg_eq_I_mul`（人手 `negation_of_i_times_negated_real_is_i_times`、`θ → y_j`）である。 -/
theorem anticomm_exponent_complex_chain {a b y : ℝ} (h : a + b = -y) :
    (-Complex.I) * (a : ℂ) + (-Complex.I) * (b : ℂ) = Complex.I * (y : ℂ) :=
  calc (-Complex.I) * (a : ℂ) + (-Complex.I) * (b : ℂ)
      = (-Complex.I) * ((a : ℂ) + (b : ℂ)) := (mul_add _ _ _).symm    -- ℂ の分配法則
    _ = (-Complex.I) * ((a + b : ℝ) : ℂ) := by
        rw [real_inclusion_add]                                       -- `real_inclusion_preserves_finite_sum`（m = 2）
    _ = (-Complex.I) * ((-y : ℝ) : ℂ) := by rw [h]                    -- 直前の実数の鎖
    _ = -(Complex.I * ((-y : ℝ) : ℂ)) :=
        neg_I_mul_eq_neg_of_I_mul _                                   -- `negative_i_times_complex_is_negation_of_i_times`（`z → (-y_j)_ℂ`）
    _ = Complex.I * (y : ℂ) :=
        neg_I_mul_real_neg_eq_I_mul y                                 -- `negation_of_i_times_negated_real_is_i_times`（`θ → y_j`）

/-- （読み）人手の `exp_sum` を `N` と `κ` で当てた形:
`∑_{j=1}^{N} exp(i(y_j)_ℂ) = (M_col)_ℂ δ^{(M_col)}_{(κ,0)}`（`y_j = 2π j_ℝ κ_ℝ / (M_col)_ℝ`）。
人手は「`exp_sum` の左辺の指数 `2πijκ/N` は `i(y_j)_ℂ`」と読む。Lean の `exp_sum` の具体版 `expPhase_sum` は
`exp(-√-1·2π jk/M)` の和で述べてあるので、`k ↦ -κ` で当て、`M ∣ x ⟺ M ∣ -x` で `δ` を戻す。 -/
theorem exp_sum_as_I_mul_real (hM : M ≠ 0) (κ : ℤ) :
    ∑ j : Fin M, Complex.exp (Complex.I
        * ((2 * Real.pi * ((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * (κ : ℝ) / ((M : ℤ) : ℝ) : ℝ) : ℂ))
      = (M : ℂ) * deltaMod M κ 0 := by
  have hterm : ∀ j : Fin M,
      Complex.exp (Complex.I
          * ((2 * Real.pi * ((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * (κ : ℝ) / ((M : ℤ) : ℝ) : ℝ) : ℂ))
        = expPhase M (((j : ℕ) + 1 : ℤ) * (-κ)) := by
    intro j
    rw [expPhase]
    congr 1
    push_cast
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, expPhase_sum hM (-κ), deltaMod, deltaMod,
    sub_zero, sub_zero]
  simp only [dvd_neg]

/-! ## 原文の 3 つの反交換関係（`μ, ν ∈ ℤ` 版） -/

/-- **原文第 1 式（合同式版）**: `[check(Z)_μ, check(Z)_ν]₊ = 2M δ^M_{(μ+ν,1)} I`。 -/
theorem acomm_checkZ_checkZ (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (checkZ M μ) (checkZ M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
  calc acomm (checkZ M μ) (checkZ M ν)
      -- (∵ def_half_integer_checkZ)
      = acomm (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Z j)
          (∑ k : Fin M, checkPhase M (((k : ℕ) : ℤ) + 1) ν • Z k) := by
        rw [checkZ, checkZ]
      -- (∵ 反交換子の ℂ 双線型性)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • acomm (Z j) (Z k) :=
        acomm_sum_smul _ _ _ _
      -- (∵ anticommutator_of_Z_and_Y)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • ((2 * deltaM j k) • (1 : TensorPow M)) := by
        simp_rw [anticomm_Z_Z]
      -- (∵ 1 ≤ j, k ≤ M では δ^M_{(j,k)} = 1 ⟺ j = k)
    _ = (2 * ∑ j : Fin M,
          checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((j : ℕ) : ℤ) + 1) ν)
            • (1 : TensorPow M) :=
        sum_sum_smul_two_deltaM_smul_one _ _
      -- （読み）checkPhase M j λ は人手の e_{j,λ} = exp((-i)(j_ℝ θ~_λ)_ℂ) そのもの
    _ = (2 * ∑ j : Fin M,
          Complex.exp ((-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * thetaTilde M μ : ℝ) : ℂ))
            * Complex.exp ((-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * thetaTilde M ν : ℝ) : ℂ)))
            • (1 : TensorPow M) := by
        simp_rw [checkPhase_eq_exp_neg_I_mul hM]
      -- (∵ scalar_exp_product を K = ℂ で各 j へ同時適用。Lean は mathlib の Complex.exp_add)
    _ = (2 * ∑ j : Fin M,
          Complex.exp ((-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * thetaTilde M μ : ℝ) : ℂ)
            + (-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * thetaTilde M ν : ℝ) : ℂ)))
            • (1 : TensorPow M) := by
        simp_rw [← Complex.exp_add]
      -- (∵ 準備 2 の複素数の鎖を各 j へ同時適用)
    _ = (2 * ∑ j : Fin M,
          Complex.exp (Complex.I * ((2 * Real.pi * ((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ)
            * ((-(μ + ν - 1) : ℤ) : ℝ) / ((M : ℤ) : ℝ) : ℝ) : ℂ)))
            • (1 : TensorPow M) := by
        congr 2
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [anticomm_exponent_complex_chain (anticomm_exponent_real_chain (((j : ℕ) : ℤ) + 1) μ ν)]
      -- (∵ exp_sum を N と κ で。準備 2 の読み)
    _ = (2 * ((M : ℂ) * deltaMod M (-(μ + ν - 1)) 0)) • (1 : TensorPow M) := by
        rw [exp_sum_as_I_mul_real hM]
      -- (∵ def_delta_M)
    _ = (2 * ((M : ℂ) * deltaMod M (μ + ν) 1)) • (1 : TensorPow M) := by
        rw [deltaMod_neg_sub_one]
      -- (∵ ℂ の積の結合律)
    _ = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
        rw [mul_assoc]

/-- **原文第 3 式（合同式版）**: `[check(Y)_μ, check(Y)_ν]₊ = 2M δ^M_{(μ+ν,1)} I`。 -/
theorem acomm_checkY_checkY (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (checkY M μ) (checkY M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
  calc acomm (checkY M μ) (checkY M ν)
      -- (∵ def_half_integer_checkY)
      = acomm (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Y j)
          (∑ k : Fin M, checkPhase M (((k : ℕ) : ℤ) + 1) ν • Y k) := by
        rw [checkY, checkY]
      -- (∵ 反交換子の ℂ 双線型性)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • acomm (Y j) (Y k) :=
        acomm_sum_smul _ _ _ _
      -- (∵ anticommutator_of_Z_and_Y)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • ((2 * deltaM j k) • (1 : TensorPow M)) := by
        simp_rw [anticomm_Y_Y]
      -- (∵ 1 ≤ j, k ≤ M では δ^M_{(j,k)} = 1 ⟺ j = k)
    _ = (2 * ∑ j : Fin M,
          checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((j : ℕ) : ℤ) + 1) ν)
            • (1 : TensorPow M) :=
        sum_sum_smul_two_deltaM_smul_one _ _
      -- （読み）checkPhase M j λ は人手の e_{j,λ} = exp((-i)(j_ℝ θ~_λ)_ℂ) そのもの
    _ = (2 * ∑ j : Fin M,
          Complex.exp ((-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * thetaTilde M μ : ℝ) : ℂ))
            * Complex.exp ((-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * thetaTilde M ν : ℝ) : ℂ)))
            • (1 : TensorPow M) := by
        simp_rw [checkPhase_eq_exp_neg_I_mul hM]
      -- (∵ scalar_exp_product を K = ℂ で各 j へ同時適用。Lean は mathlib の Complex.exp_add)
    _ = (2 * ∑ j : Fin M,
          Complex.exp ((-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * thetaTilde M μ : ℝ) : ℂ)
            + (-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ) * thetaTilde M ν : ℝ) : ℂ)))
            • (1 : TensorPow M) := by
        simp_rw [← Complex.exp_add]
      -- (∵ 準備 2 の複素数の鎖を各 j へ同時適用)
    _ = (2 * ∑ j : Fin M,
          Complex.exp (Complex.I * ((2 * Real.pi * ((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ)
            * ((-(μ + ν - 1) : ℤ) : ℝ) / ((M : ℤ) : ℝ) : ℝ) : ℂ)))
            • (1 : TensorPow M) := by
        congr 2
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [anticomm_exponent_complex_chain (anticomm_exponent_real_chain (((j : ℕ) : ℤ) + 1) μ ν)]
      -- (∵ exp_sum を N と κ で。準備 2 の読み)
    _ = (2 * ((M : ℂ) * deltaMod M (-(μ + ν - 1)) 0)) • (1 : TensorPow M) := by
        rw [exp_sum_as_I_mul_real hM]
      -- (∵ def_delta_M)
    _ = (2 * ((M : ℂ) * deltaMod M (μ + ν) 1)) • (1 : TensorPow M) := by
        rw [deltaMod_neg_sub_one]
      -- (∵ ℂ の積の結合律)
    _ = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
        rw [mul_assoc]

/-- **原文第 2 式**: `[check(Z)_μ, check(Y)_ν]₊ = 0`（二重和のすべての項が `0`）。 -/
theorem acomm_checkZ_checkY (μ ν : ℤ) : acomm (checkZ M μ) (checkY M ν) = 0 := by
  calc acomm (checkZ M μ) (checkY M ν)
      -- (∵ def_half_integer_checkZ, def_half_integer_checkY)
      = acomm (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Z j)
          (∑ k : Fin M, checkPhase M (((k : ℕ) : ℤ) + 1) ν • Y k) := by
        rw [checkZ, checkY]
      -- (∵ 反交換子の ℂ 双線型性)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • acomm (Z j) (Y k) :=
        acomm_sum_smul _ _ _ _
      -- (∵ anticommutator_of_Z_and_Y)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • (0 : TensorPow M) := by
        simp_rw [anticomm_Z_Y]
      -- (∵ ℂ の四則)
    _ = 0 := by
        simp_rw [smul_zero, Finset.sum_const_zero]

/-- `[check(Y)_μ, check(Z)_ν]₊ = 0`（上の左右を入れ替えた形）。 -/
theorem acomm_checkY_checkZ (μ ν : ℤ) : acomm (checkY M μ) (checkZ M ν) = 0 := by
  rw [acomm_comm]; exact acomm_checkZ_checkY ν μ

/-! ## `μ, ν ∈ 𝓜̌` に絞った形（原文の主張そのもの） -/

/-- **原文第 1 式**: `μ, ν ∈ 𝓜̌` では `[check(Z)_μ, check(Z)_ν]₊ = 2M δ_{ν, M+1-μ} I`。 -/
theorem acomm_checkZ_checkZ_of_mem (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν) :
    acomm (checkZ M μ) (checkZ M ν)
      = (2 * (M : ℂ) * (if ν = (M : ℤ) + 1 - μ then 1 else 0)) • (1 : TensorPow M) := by
  rw [acomm_checkZ_checkZ hM, deltaMod_add_one_eq hM hμ hν]

/-- **原文第 3 式**: `μ, ν ∈ 𝓜̌` では `[check(Y)_μ, check(Y)_ν]₊ = 2M δ_{ν, M+1-μ} I`。 -/
theorem acomm_checkY_checkY_of_mem (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν) :
    acomm (checkY M μ) (checkY M ν)
      = (2 * (M : ℂ) * (if ν = (M : ℤ) + 1 - μ then 1 else 0)) • (1 : TensorPow M) := by
  rw [acomm_checkY_checkY hM, deltaMod_add_one_eq hM hμ hν]

end Ising2D
