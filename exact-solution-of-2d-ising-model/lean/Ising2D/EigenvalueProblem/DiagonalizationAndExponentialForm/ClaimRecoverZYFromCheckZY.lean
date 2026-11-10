/-
# `check(Z), check(Y)` から `Z_j, Y_j` を復元する（**具体版**）

対応する人手証明のラベル: `recover_Z_Y_from_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evensector_006_claim_recover_Z_Y`）

**必要十分版**は `Ising2D/NecSuf/AntiperiodicFourier.lean` の
`Ising2D.NecSuf.inverse_dft_antiperiodic`（同じラベル）。
必要十分版からの導出は `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimRecoverZYFromCheckZYFromNecSuf.lean`。

## 原文の主張（`j ∈ {1,…,M}`）

  `Z_j = (1/M) ∑_{μ=1}^{M} check(Z)_μ e^{ij θ~_μ}`,
  `Y_j = (1/M) ∑_{μ=1}^{M} check(Y)_μ e^{ij θ~_μ}`

とくに `check(Z)_1,…,check(Z)_M, check(Y)_1,…,check(Y)_M` は `Mat(2^M, ℂ)` を
単位的 `ℂ` 代数として生成する。

## 形式化の方針

整数運動量版（`RoutesNotAdopted/IntegerMomentum/ClaimRecoverZYFromHatZHatY.lean`）と同じく、まず族 `x : Fin M → TensorPow M`
に対する一般形（`inverse_dft_check`）を証明し、それを `Z`, `Y` に適用する。
`inverse_dft_check` は人手の第 1 式の鎖のうち、`c = (M_col)_ℂ^{-1}` を掛ける前の部分（`def_half_integer_checkZ` で開いた後から
`antiperiodic_exp_sum` の「とくに」を整数 `0` で当てるまで）と 1 行ずつ対応する `calc` で書く。人手の `j`・`k` は Lean の
`m`・`j` で、人手の `j_ℤ` は Lean の `((m : ℕ) : ℤ) + 1` である。最初の行（`def_half_integer_checkZ`・`def_half_integer_checkY`
で開く行）は `recover_checkZ`・`recover_checkY` の `simp_rw [checkZ]`・`simp_rw [checkY]` が、最後の 3 行（`scalar_multiple_is_associative`、
`c` は逆元、`scalar_multiple_by_one`）は `Z_eq_inverse_dft_check`・`Y_eq_inverse_dft_check` が受け持つ。

* 人手の準備 2 の 2 本の鎖は、実数の側を `recover_exponent_real_chain`、複素数の側を `recover_exponent_complex_chain`
  として立て、`scalar_exp_product` の次の行で当てる。人手の準備 1 は `recover_off_diagonal_term`。
* `checkPhase M (-j) λ` を人手の `f_{j,λ} = exp(i(j_ℝ θ~_λ)_ℂ)` と読む段（`checkPhase_neg_eq_exp_I_mul`）、
  `checkPhase M k λ` を `e_{k,λ}` と読む段（`checkPhase_eq_exp_neg_I_mul`）、和 `∑ exp(i(n_ℝ θ~)_ℂ)` を
  `antiperiodic_exp_sum` の Lean の形 `∑ exp(i n_ℂ θ~_ℂ)` に直す段（`exp_I_mul_int_mul_real`）は人手の行ではなく読みである。
* 指数法則 `scalar_exp_product` の行は、`def_scalar_exp` の具体版が Lean に無いので mathlib の `Complex.exp_add` で表す
  （`ClaimConjugateIndex.lean`・`ClaimAnticommutatorCheckZY.lean` と同じ扱い）。
  `finite_sum_of_scalar_multiples`・`scalar_multiple_is_associative`・`finite_double_sum_of_matrices_interchange`・
  `finite_sum_of_scalar_multiples_of_one_matrix`・`finite_sum_of_matrices_with_single_nonzero_term` の行も具体版が無く、
  mathlib の `Finset.smul_sum`・`smul_smul`・`Finset.sum_comm`・`Finset.sum_smul`・`Finset.sum_eq_single_of_mem` で表す。
* 準備 2 の 2 本の鎖が実際に使うのは、実数の鎖では環の等式（`-(yx) = (-y)x`、分配法則、差は加法の逆元の和。可換性は使わない）と
  `ℤ` からの環準同型が差を保つこと（`x` は任意の実数でよく、ℝ の順序・完備性は使わない）、複素数の鎖では `(-i)z = -(iz)` と
  `i(-θ)_ℂ = -(iθ_ℂ)`（既存の主張の具体版 2 本。後者の中で ℂ の積の交換律を 1 回と、包含が積を保つこと
  `real_inclusion_mul` を使う）、分配法則、包含が和を保つこと（`real_inclusion_add`）だけである。
  2 本の鎖ごとの必要十分版は置かない。主張全体の必要十分版 `inverse_dft_antiperiodic` が、位相を `ξ` の冪と抽象し、
  読みの段（`checkPhase` を `exp` の形に直す段）と `scalar_exp_product` と準備 2 の 2 本の鎖を `ξ` の冪の指数の足し算
  1 段に吸収しているからである（具体版の calc の 3 段が必要十分版の 1 段に当たる。ほかの段は同じ順で対応する）。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimConjugateIndex
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimAnticommutatorCheckZY
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimZYGenerateAlgebra
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimCosSinAndITimesAtNegatedReal

namespace Ising2D

variable {M : ℕ}

/-- （読み）`checkPhase M (-k) λ` は人手の準備の `f_{k,λ} = exp(i(k_ℝ θ~_λ)_ℂ)` そのもの。
`checkPhase_eq_exp_neg_I_mul` の `exp((-i)(((-k)_ℝ) θ~_λ)_ℂ)` を、`ℤ → ℝ` が符号反転を保つこと・`(-a)b = -(ab)`・
`neg_I_mul_real_inclusion_neg`（人手 `conjugate_index_of_check_Z_Y` の準備の第二の鎖 `(-i)(-x)_ℂ = i x_ℂ`）で直す。 -/
theorem checkPhase_neg_eq_exp_I_mul (hM : M ≠ 0) (k l : ℤ) :
    checkPhase M (-k) l = Complex.exp (Complex.I * (((k : ℝ) * thetaTilde M l : ℝ) : ℂ)) := by
  rw [checkPhase_eq_exp_neg_I_mul hM, Int.cast_neg, neg_mul (k : ℝ), neg_I_mul_real_inclusion_neg]

/-- **準備 2 の実数の鎖**: `j_ℝx + (-(k_ℝx)) = (j_ℤ - k_ℤ)_ℝ x`。
人手の `j`・`k` は Lean の `k`・`l`（`ℤ` の元。人手の `j_ℝ = (j_ℤ)_ℝ`）。人手の 4 行に 1 段ずつ対応する。 -/
theorem recover_exponent_real_chain (k l : ℤ) (x : ℝ) :
    (k : ℝ) * x + (-((l : ℝ) * x)) = ((k - l : ℤ) : ℝ) * x :=
  calc (k : ℝ) * x + (-((l : ℝ) * x))
      = (k : ℝ) * x + (-(l : ℝ)) * x := by rw [neg_mul]                     -- ℝ で `-(ab) = (-a)b`
    _ = ((k : ℝ) + (-(l : ℝ))) * x := (add_mul _ _ _).symm                  -- ℝ の分配法則
    _ = ((k : ℝ) - (l : ℝ)) * x := by rw [← sub_eq_add_neg]                 -- ℝ の差は加法の逆元の和
    _ = ((k - l : ℤ) : ℝ) * x := by rw [Int.cast_sub]                       -- `ℤ → ℝ` は差を保つ

/-- **準備 2 の複素数の鎖**: `i(a)_ℂ + (-i)(b)_ℂ = i(c)_ℂ`（`a + (-b) = c`。人手では `a = j_ℝx`、`b = k_ℝx`、
`c = (j_ℤ - k_ℤ)_ℝ x`、`h` は直前の実数の鎖 `recover_exponent_real_chain`）。人手の 5 行に 1 段ずつ対応する。
1 段目は具体版 `neg_I_mul_eq_neg_of_I_mul`（人手 `negative_i_times_complex_is_negation_of_i_times`、`z → b_ℂ`）、
2 段目は具体版 `I_mul_real_neg_eq_neg_I_mul`（人手 `i_times_negated_real_is_negation_of_i_times`、`θ → b`）を右辺から左辺へ、
4 段目の二項の和の像は具体版 `real_inclusion_add`（人手 `real_inclusion_preserves_sum`）を、人手と同じ向きに当てる。 -/
theorem recover_exponent_complex_chain {a b c : ℝ} (h : a + (-b) = c) :
    Complex.I * (a : ℂ) + (-Complex.I) * (b : ℂ) = Complex.I * (c : ℂ) :=
  calc Complex.I * (a : ℂ) + (-Complex.I) * (b : ℂ)
      = Complex.I * (a : ℂ) + (-(Complex.I * (b : ℂ))) := by
        rw [neg_I_mul_eq_neg_of_I_mul]                                        -- `negative_i_times_complex_is_negation_of_i_times`
    _ = Complex.I * (a : ℂ) + Complex.I * ((-b : ℝ) : ℂ) := by
        rw [I_mul_real_neg_eq_neg_I_mul]                                      -- `i_times_negated_real_is_negation_of_i_times`（右辺から左辺へ）
    _ = Complex.I * ((a : ℂ) + ((-b : ℝ) : ℂ)) := (mul_add _ _ _).symm        -- ℂ の分配法則
    _ = Complex.I * ((a + (-b) : ℝ) : ℂ) := by
        rw [real_inclusion_add]                                               -- `real_inclusion_preserves_sum`
    _ = Complex.I * (c : ℂ) := by rw [h]                                      -- 直前の実数の鎖

/-- （読み）`exp(i(n_ℝ x)_ℂ) = exp(i n_ℂ x_ℂ)`（`n ∈ ℤ`、`x ∈ ℝ`）。人手の和 `∑ exp(i((n)_ℝ θ~_μ)_ℂ)` を、
`antiperiodic_exp_sum` の Lean の形（`antiperiodic_complex_exp_sum_zero` ほか）の `∑ exp(i n_ℂ θ~_ℂ)` に直す。
積の像は `real_inclusion_mul`（人手 `real_inclusion_preserves_product`）を右辺から左辺へ当てる。 -/
theorem exp_I_mul_int_mul_real (n : ℤ) (x : ℝ) :
    Complex.exp (Complex.I * (((n : ℝ) * x : ℝ) : ℂ))
      = Complex.exp (Complex.I * (n : ℂ) * (x : ℂ)) := by
  rw [← real_inclusion_mul, Complex.ofReal_intCast, mul_assoc]

/-- **準備 1**（`k ≠ j` の項）: `(∑_{μ=1}^{N} exp(i((j_ℤ - k_ℤ)_ℝ θ~_μ)_ℂ)) A = O`。
`j, k ∈ Fin M` は人手の `j - 1, k - 1` で、人手の `j_ℤ` は `((j : ℕ) : ℤ) + 1`。
`k ≠ j` なら `j_ℤ - k_ℤ ≠ 0` かつ `|j_ℤ - k_ℤ| ≤ M_col - 1 < M_col` なので、`antiperiodic_exp_sum` の「とくに」
（`antiperiodic_complex_exp_sum_nonzero_of_abs_lt`）で和は `0_ℂ`、`zero_scalar_multiple_is_zero_matrix` で `O`。 -/
theorem recover_off_diagonal_term (hM : M ≠ 0) {j k : Fin M} (hkj : k ≠ j) (A : TensorPow M) :
    (∑ μ : Fin M, Complex.exp (Complex.I
        * ((((((j : ℕ) : ℤ) + 1 - (((k : ℕ) : ℤ) + 1) : ℤ) : ℝ)
          * thetaTilde M (((μ : ℕ) : ℤ) + 1) : ℝ) : ℂ))) • A = 0 := by
  have hval : (k : ℕ) ≠ (j : ℕ) := fun h => hkj (Fin.ext h)
  have hj := j.isLt
  have hk := k.isLt
  have hne : (((j : ℕ) : ℤ) + 1 - (((k : ℕ) : ℤ) + 1)) ≠ 0 := by omega
  have habs : |(((j : ℕ) : ℤ) + 1 - (((k : ℕ) : ℤ) + 1))| < (M : ℤ) :=
    abs_lt.mpr ⟨by omega, by omega⟩
  calc (∑ μ : Fin M, Complex.exp (Complex.I
          * ((((((j : ℕ) : ℤ) + 1 - (((k : ℕ) : ℤ) + 1) : ℤ) : ℝ)
            * thetaTilde M (((μ : ℕ) : ℤ) + 1) : ℝ) : ℂ))) • A
      = (0 : ℂ) • A := by
        simp_rw [exp_I_mul_int_mul_real]
        rw [antiperiodic_complex_exp_sum_nonzero_of_abs_lt hM habs hne]
                                -- `antiperiodic_exp_sum` の「とくに」を `0 < |j_ℤ - k_ℤ| < M_col` の整数で
    _ = 0 := zero_smul _ A      -- `zero_scalar_multiple_is_zero_matrix`

/-- **反周期的離散フーリエ逆変換（人手の第 1・2 式の鎖の骨格）**。

族 `x : Fin M → Mat(2,ℂ)^{⊗M}` の変換 `check(x)_μ = ∑_k e_{k,μ} x_k` に対し

  `∑_{μ=1}^{M} f_{j,μ} check(x)_μ = M x_j`（人手の `j` は Lean の `m`、`k` は `j`）。

人手の第 1 式の 2 行目から `antiperiodic_exp_sum` の「とくに」を整数 `0` で当てる行までと 1 段ずつ対応する。 -/
theorem inverse_dft_check (hM : M ≠ 0) (x : Fin M → TensorPow M) (m : Fin M) :
    ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1) • x j)
      = (M : ℂ) • x m :=
  calc ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1) • x j)
      -- (∵ finite_sum_of_scalar_multiples を右辺から左辺へ、各 μ へ同時適用)
      = ∑ μ : Fin M, ∑ j : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
          (checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1) • x j) := by
        simp_rw [Finset.smul_sum]
      -- (∵ scalar_multiple_is_associative を N^2 個の項へ同時適用)
    _ = ∑ μ : Fin M, ∑ j : Fin M, (checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1)
          * checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1)) • x j := by
        simp_rw [smul_smul]
      -- (∵ finite_double_sum_of_matrices_interchange (r = s = N))
    _ = ∑ j : Fin M, ∑ μ : Fin M, (checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1)
          * checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1)) • x j :=
        Finset.sum_comm
      -- (∵ finite_sum_of_scalar_multiples_of_one_matrix を各 k へ同時適用)
    _ = ∑ j : Fin M, (∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1)
          * checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1)) • x j := by
        simp_rw [Finset.sum_smul]
      -- （読み）checkPhase M (-j) λ は f_{j,λ}、checkPhase M k λ は e_{k,λ}
    _ = ∑ j : Fin M, (∑ μ : Fin M,
          Complex.exp (Complex.I * ((((((m : ℕ) : ℤ) + 1 : ℤ) : ℝ)
            * thetaTilde M (((μ : ℕ) : ℤ) + 1) : ℝ) : ℂ))
          * Complex.exp ((-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ)
            * thetaTilde M (((μ : ℕ) : ℤ) + 1) : ℝ) : ℂ))) • x j := by
        simp_rw [checkPhase_neg_eq_exp_I_mul hM, checkPhase_eq_exp_neg_I_mul hM]
      -- (∵ scalar_exp_product を K = ℂ で N^2 個の項へ同時適用。Lean は mathlib の Complex.exp_add)
    _ = ∑ j : Fin M, (∑ μ : Fin M,
          Complex.exp (Complex.I * ((((((m : ℕ) : ℤ) + 1 : ℤ) : ℝ)
            * thetaTilde M (((μ : ℕ) : ℤ) + 1) : ℝ) : ℂ)
          + (-Complex.I) * ((((((j : ℕ) : ℤ) + 1 : ℤ) : ℝ)
            * thetaTilde M (((μ : ℕ) : ℤ) + 1) : ℝ) : ℂ))) • x j := by
        simp_rw [← Complex.exp_add]
      -- (∵ 準備 2 の複素数の鎖を全ての (k, μ) へ同時適用)
    _ = ∑ j : Fin M, (∑ μ : Fin M,
          Complex.exp (Complex.I * ((((((m : ℕ) : ℤ) + 1 - (((j : ℕ) : ℤ) + 1) : ℤ) : ℝ)
            * thetaTilde M (((μ : ℕ) : ℤ) + 1) : ℝ) : ℂ))) • x j := by
        refine Finset.sum_congr rfl fun j _ => ?_
        congr 1
        refine Finset.sum_congr rfl fun μ _ => ?_
        rw [recover_exponent_complex_chain (recover_exponent_real_chain _ _ _)]
      -- (∵ finite_sum_of_matrices_with_single_nonzero_term (q = j)。k ≠ j の項は準備 1 の鎖で O)
    _ = (∑ μ : Fin M,
          Complex.exp (Complex.I * ((((((m : ℕ) : ℤ) + 1 - (((m : ℕ) : ℤ) + 1) : ℤ) : ℝ)
            * thetaTilde M (((μ : ℕ) : ℤ) + 1) : ℝ) : ℂ))) • x m := by
        rw [Finset.sum_eq_single_of_mem m (Finset.mem_univ m)]
        intro j _ hj
        exact recover_off_diagonal_term hM hj (x j)
      -- (∵ ℤ で j_ℤ - j_ℤ = 0)
    _ = (∑ μ : Fin M,
          Complex.exp (Complex.I * ((((0 : ℤ) : ℝ)
            * thetaTilde M (((μ : ℕ) : ℤ) + 1) : ℝ) : ℂ))) • x m := by
        rw [sub_self]
      -- (∵ antiperiodic_exp_sum の「とくに」を整数 0 で。和を Lean の形へ読む段を含む)
    _ = (M : ℂ) • x m := by
        simp_rw [exp_I_mul_int_mul_real]
        rw [Int.cast_zero, antiperiodic_complex_exp_sum_zero hM]

/-- **原文第 1 式（分母を払った形）**: `∑_{μ=1}^{M} check(Z)_μ e^{ij θ~_μ} = M Z_j`。 -/
theorem recover_checkZ (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        checkZ M (((μ : ℕ) : ℤ) + 1)
      = (M : ℂ) • Z m := by
  simp_rw [checkZ]
  exact inverse_dft_check hM Z m

/-- **原文第 2 式（分母を払った形）**: `∑_{μ=1}^{M} check(Y)_μ e^{ij θ~_μ} = M Y_j`。 -/
theorem recover_checkY (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        checkY M (((μ : ℕ) : ℤ) + 1)
      = (M : ℂ) • Y m := by
  simp_rw [checkY]
  exact inverse_dft_check hM Y m

/-- **原文第 1 式**: `Z_j = (1/M) ∑_{μ=1}^{M} check(Z)_μ e^{ij θ~_μ}`。 -/
theorem Z_eq_inverse_dft_check (hM : M ≠ 0) (m : Fin M) :
    Z m = ((M : ℂ))⁻¹ • ∑ μ : Fin M,
      checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) • checkZ M (((μ : ℕ) : ℤ) + 1) := by
  rw [recover_checkZ hM, smul_smul, inv_mul_cancel₀ (Nat.cast_ne_zero.2 hM), one_smul]

/-- **原文第 2 式**: `Y_j = (1/M) ∑_{μ=1}^{M} check(Y)_μ e^{ij θ~_μ}`。 -/
theorem Y_eq_inverse_dft_check (hM : M ≠ 0) (m : Fin M) :
    Y m = ((M : ℂ))⁻¹ • ∑ μ : Fin M,
      checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) • checkY M (((μ : ℕ) : ℤ) + 1) := by
  rw [recover_checkY hM, smul_smul, inv_mul_cancel₀ (Nat.cast_ne_zero.2 hM), one_smul]

/-! ## 生成性 -/

/-- 原文の `{check(Z)_1, …, check(Z)_M, check(Y)_1, …, check(Y)_M}`。 -/
noncomputable def checkZYSet (M : ℕ) : Set (TensorPow M) :=
  (Set.range fun μ : Fin M => checkZ M (((μ : ℕ) : ℤ) + 1)) ∪
    (Set.range fun μ : Fin M => checkY M (((μ : ℕ) : ℤ) + 1))

theorem checkZ_mem_adjoin (μ : Fin M) :
    checkZ M (((μ : ℕ) : ℤ) + 1) ∈ Algebra.adjoin ℂ (checkZYSet M) :=
  Algebra.subset_adjoin (Or.inl ⟨μ, rfl⟩)

theorem checkY_mem_adjoin (μ : Fin M) :
    checkY M (((μ : ℕ) : ℤ) + 1) ∈ Algebra.adjoin ℂ (checkZYSet M) :=
  Algebra.subset_adjoin (Or.inr ⟨μ, rfl⟩)

/-- **原文の「とくに」**: `check(Z), check(Y)` は `Mat(2^M, ℂ)` を単位的 `ℂ` 代数として生成する。

復元公式により各 `Z_j, Y_j` が `check(Z)_μ, check(Y)_μ` の `ℂ` 線型結合なので、
`<Z_Y_generate_algebra>` に帰着する。 -/
theorem checkZ_checkY_generate_algebra (hM : M ≠ 0) :
    Algebra.adjoin ℂ (checkZYSet M) = ⊤ := by
  have hsub : ZYSet M ⊆ (Algebra.adjoin ℂ (checkZYSet M) : Set (TensorPow M)) := by
    rintro w (⟨m, rfl⟩ | ⟨m, rfl⟩)
    · rw [Z_eq_inverse_dft_check hM m]
      exact Subalgebra.smul_mem _
        (Subalgebra.sum_mem _ fun μ _ => Subalgebra.smul_mem _ (checkZ_mem_adjoin μ) _) _
    · rw [Y_eq_inverse_dft_check hM m]
      exact Subalgebra.smul_mem _
        (Subalgebra.sum_mem _ fun μ _ => Subalgebra.smul_mem _ (checkY_mem_adjoin μ) _) _
  refine top_le_iff.1 ?_
  rw [← Z_Y_generate_algebra M]
  exact Algebra.adjoin_le hsub

end Ising2D
