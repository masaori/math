/-
# 具体版: `check(Z), check(Y)` についての `n` 重交換子

対応する人手証明のラベル: **`nesting_of_commutator_of_H_and_check_Z`**
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensectorT_002_claim_nesting_commutator`）

人手証明と 1 対 1 に対応する。必要十分版は `Ising2D/NecSuf/NestedCommutatorTwoDim.lean` の
`Ising2D.NecSuf.nested_z_even` / `nested_z_odd` / `nested_y_even` / `nested_y_odd`（同じ帰納段階 1・2 をたどる。
帰納段階 1・2 は `nested_z_step_even_to_odd` などに、双線型性は `comm_smul_smul_necSuf` に当たる）で、
本ファイルの 8 本をその特殊化として導く定理は `EigenvalueProblem/ReductionToATheta/ClaimNestedCommutatorFromNecSuf.lean` にある。

## 人手証明との対応

人手は 4 式それぞれを `n ∈ ℤ_{≥0}` についての帰納法で示す。用いるのは
`commutator_of_H_and_check_Z_Y` の (A)〜(D)（`lie_H1Plus_checkZ`・`lie_H1Plus_checkY`・`lie_H2_checkZ`・`lie_H2_checkY`）、
交換子の双線型性 `[αX, βW] = αβ[X, W]`（`comm_smul_smul`。人手の 4 行の鎖どおりで、スカラー倍が積と可換な行は `scalar_identity_commutes`）、
`e^{-iθ~}e^{iθ~} = 1`（人手の準備（位相の積）の 4 行と 1 対 1 の `checkPhase_mul_neg_chain`）だけである。

右辺は `n` の偶奇で場合分けされているので、Lean では `n = 2k` と `n = 2k+1` を別の定理にし、
人手の符号の指数を `k` で書く（`(-1)^{n/2} = (-1)^k`、`(-1)^{(n-1)/2} = (-1)^k`、`(-1)^{(n+1)/2} = (-1)^{k+1}`）。
人手の 3 つの段は次の定理に当たる。

| 人手 | Lean（(h1.z) の場合。ほかの 3 式も同じ並び） |
| --- | --- |
| 基底段階（`n = 0`） | `nesting_H1Plus_checkZ_even` の `k = 0` の場合の `calc` |
| 帰納段階 1（`n` 偶数 → `n+1` 奇数） | `nesting_H1Plus_checkZ_step_even_to_odd` の `calc`（(h1.z) は人手の行と 1 段ずつ。ほかの 3 式は係数の並べ替えをまだ `ring` の 1 段で閉じている） |
| 帰納段階 2（`n` 奇数 → `n+1` 偶数） | `nesting_H1Plus_checkZ_step_odd_to_even` の `calc`（(h1.z) は人手の行と 1 段ずつ。最後の `(n-1)/2+1 = (n+1)/2` は `k` で書くと `k+1` そのもの） |

偶数側の定理は `k` についての帰納法で、`k` から `k+1` へは帰納段階 1 と 2 を続けて当てる。
奇数側の定理は偶数側に帰納段階 1 を当てる。

`n` 重の入れ子交換子は `Ising2D.adPow`（`EigenvalueProblem/ReductionToATheta/ClaimExpConjugation.lean`）で表す。
`adPow X (n+1) A = X (adPow X n A) - (adPow X n A) X` が人手の `C_{n+1} = [K_1H_1^{(+)}, C_n]` に当たる。
`e^{-iθ~_μ}` は `Ising2D.checkPhase M 1 μ`、`e^{iθ~_μ}` は `Ising2D.checkPhase M (-1) μ`
（`EigenvalueProblem/ReductionToATheta/ClaimAntiperiodicExpSum.lean`）。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExpConjugation
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimCommutatorHCheckZY
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionHalfIntegerModes
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimEulerFormulaCosSin
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimNegationInProductAndNegationPlusSelfInCC

namespace Ising2D

variable {M : ℕ}

/-! ## 証明の冒頭で使う 2 つの事実 -/

/-- `e^{-iθ~_μ} e^{iθ~_μ} = 1`（人手が帰納段階で使う唯一の位相の性質）。`M_col ≠ 0` を取らない形で、
必要十分版の特殊化（`ClaimNestedCommutatorFromNecSuf.lean`・`ClaimCoefficientConversionFromNecSuf.lean`）が使う。
指数の和 `checkPhase_add_left` から出し、人手の準備（位相の積）の鎖とは 1 対 1 でない。
人手の鎖と 1 対 1 の形は `checkPhase_mul_neg_chain`。 -/
theorem checkPhase_mul_neg (M : ℕ) (μ : ℤ) :
    checkPhase M 1 μ * checkPhase M (-1) μ = 1 := by
  rw [← checkPhase_add_left]
  norm_num

/-- **人手の準備（位相の積）**: `exp(-i(θ~)_ℂ) exp(i(θ~)_ℂ) = 1_ℂ`。calc の 2〜5 段目が人手の 4 行と 1 段ずつ対応する。
1 段目は `checkPhase M 1 μ`・`checkPhase M (-1) μ` を人手の `exp((-i)(θ~)_ℂ)`・`exp(i(θ~)_ℂ)` と読む段
（`checkPhase_eq_exp_neg_I_mul` と、`1_ℝθ~ = θ~`・`(-i)((-1)_ℝθ~)_ℂ = i(θ~)_ℂ` の書き換え）で、人手に行は無い。 -/
theorem checkPhase_mul_neg_chain (hM : M ≠ 0) (μ : ℤ) :
    checkPhase M 1 μ * checkPhase M (-1) μ = 1 := by
  calc checkPhase M 1 μ * checkPhase M (-1) μ
      -- 読み（人手に行は無い）
      = Complex.exp ((-Complex.I) * (thetaTilde M μ : ℂ))
          * Complex.exp (Complex.I * (thetaTilde M μ : ℂ)) := by
        rw [checkPhase_eq_exp_neg_I_mul hM, checkPhase_eq_exp_neg_I_mul hM]
        congr 2 <;> push_cast <;> ring
    -- 人手 1 行目: `scalar_exp_product` を `K = ℂ` で
    _ = Complex.exp ((-Complex.I) * (thetaTilde M μ : ℂ) + Complex.I * (thetaTilde M μ : ℂ)) :=
        (Complex.exp_add _ _).symm
    -- 人手 2 行目: `negative_i_times_complex_is_negation_of_i_times`（`z → (θ~)_ℂ`）
    _ = Complex.exp (-(Complex.I * (thetaTilde M μ : ℂ)) + Complex.I * (thetaTilde M μ : ℂ)) := by
        rw [neg_I_mul_eq_neg_of_I_mul]
    -- 人手 3 行目: `negation_plus_self_is_zero_in_cc`（`x → i(θ~)_ℂ`）
    _ = Complex.exp 0 := by rw [neg_add_self_complex]
    -- 人手 4 行目: `scalar_exp_zero` を `K = ℂ` で
    _ = 1 := Complex.exp_zero

/-- 交換子の双線型性 `[αX, βW] = αβ[X, W]`（人手の証明の冒頭の 4 行の鎖）。 -/
theorem comm_smul_smul (α β : ℂ) (X W : TensorPow M) :
    ⁅α • X, β • W⁆ = (α * β) • ⁅X, W⁆ := by
  calc ⁅α • X, β • W⁆
      -- 交換子の定義
      = (α • X) * (β • W) - (β • W) * (α • X) := Ring.lie_def _ _
    -- スカラー倍が積と可換であること（`scalar_identity_commutes`）
    _ = (α * β) • (X * W) - (α * β) • (W * X) := by
        rw [smul_mul_smul_comm, smul_mul_smul_comm, mul_comm β α]
    -- 分配則
    _ = (α * β) • (X * W - W * X) := (smul_sub _ _ _).symm
    -- 交換子の定義
    _ = (α * β) • ⁅X, W⁆ := by rw [Ring.lie_def]

/-! ## 人手 (h1.z): `C_n := [K_1H_1^{(+)}, …, [K_1H_1^{(+)}, check(Z)_μ]…]` -/

/-- 人手 (h1.z) の帰納段階 1（`n = 2k` 偶数 → `n+1` 奇数）。 -/
theorem nesting_H1Plus_checkZ_step_even_to_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ)
    (ih : adPow (K1 • H1plus M) (2 * k) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkZ M μ) :
    adPow (K1 • H1plus M) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
  calc adPow (K1 • H1plus M) (2 * k + 1) (checkZ M μ)
      -- `C_{n+1} = [K_1H_1^{(+)}, C_n]` と帰納法の仮定
      = ⁅K1 • H1plus M,
          (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkZ M μ)⁆ := by
        rw [adPow_succ, ih, Ring.lie_def]
    -- 交換子の双線型性
    _ = (K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))) • ⁅H1plus M, checkZ M μ⁆ :=
        comm_smul_smul _ _ _ _
    -- (A)
    _ = (K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))) • ((2 * checkPhase M 1 μ) • checkY M μ) := by
        rw [lie_H1Plus_checkZ hM μ]
    -- `scalar_multiple_is_associative`
    _ = ((K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))) * (2 * checkPhase M 1 μ)) • checkY M μ :=
        smul_smul _ _ _
    -- 以下 5 段: `complex_numbers_form_a_field` の積の結合律・可換律を 1 段に 1 つずつ（人手の 5 行）
    -- 積の結合律を右辺から左辺へ
    _ = (((K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))) * 2) * checkPhase M 1 μ) • checkY M μ := by
        rw [← mul_assoc (K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))) 2 (checkPhase M 1 μ)]
    -- 積の可換律
    _ = ((2 * (K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)))) * checkPhase M 1 μ) • checkY M μ := by
        rw [mul_comm (K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))) 2]
    -- 積の結合律を右辺から左辺へ
    _ = (((2 * K1) * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))) * checkPhase M 1 μ) • checkY M μ := by
        rw [← mul_assoc 2 K1 ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))]
    -- 積の可換律
    _ = ((((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) * (2 * K1)) * checkPhase M 1 μ) • checkY M μ := by
        rw [mul_comm (2 * K1) ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))]
    -- 積の結合律
    _ = (((-1 : ℂ) ^ k * ((2 * K1) ^ (2 * k) * (2 * K1))) * checkPhase M 1 μ) • checkY M μ := by
        rw [mul_assoc ((-1 : ℂ) ^ k) ((2 * K1) ^ (2 * k)) (2 * K1)]
    -- 冪の約束 `x^{m+1} := x^m x`（`scalar_exp_is_limit_of_partial_sums`）。
    -- 続く人手の行 `n/2 = ((n+1)-1)/2` は、`n = 2k` と書くと両辺とも `k` なので Lean に段は無い
    _ = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
        rw [← pow_succ]

/-- 人手 (h1.z) の帰納段階 2（`n = 2k+1` 奇数 → `n+1` 偶数）。 -/
theorem nesting_H1Plus_checkZ_step_odd_to_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ)
    (ih : adPow (K1 • H1plus M) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ) :
    adPow (K1 • H1plus M) (2 * (k + 1)) (checkZ M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * (k + 1))) • checkZ M μ := by
  calc adPow (K1 • H1plus M) (2 * (k + 1)) (checkZ M μ)
      -- `C_{n+1} = [K_1H_1^{(+)}, C_n]`（`2(k+1) = (2k+1)+1`）と帰納法の仮定
      = ⁅K1 • H1plus M,
          (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ)⁆ := by
        rw [show 2 * (k + 1) = 2 * k + 1 + 1 by ring, adPow_succ, ih, Ring.lie_def]
    -- 交換子の双線型性
    _ = (K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ))
          • ⁅H1plus M, checkY M μ⁆ :=
        comm_smul_smul _ _ _ _
    -- (B)
    _ = (K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ))
          • ((-2 * checkPhase M (-1) μ) • checkZ M μ) := by
        rw [lie_H1Plus_checkY hM μ]
    -- `scalar_multiple_is_associative`
    _ = ((K1 * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ)) * (-2 * checkPhase M (-1) μ)) • checkZ M μ :=
        smul_smul _ _ _
    -- 以下 12 段は人手の 12 行と 1 段ずつ対応する（積の結合律・可換律は `complex_numbers_form_a_field`）
    -- `multiply_by_minus_one`（`z → 2`）
    _ = ((K1 * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ)) * (((-1 : ℂ) * 2) * checkPhase M (-1) μ)) • checkZ M μ := by
        rw [neg_one_mul (2 : ℂ)]
    -- 積の結合律を右辺から左辺へ
    _ = (((K1 * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ)) * ((-1 : ℂ) * 2)) * checkPhase M (-1) μ) • checkZ M μ := by
        rw [← mul_assoc (K1 * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ)) ((-1 : ℂ) * 2) (checkPhase M (-1) μ)]
    -- 積の可換律
    _ = ((((-1 : ℂ) * 2) * (K1 * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ))) * checkPhase M (-1) μ) • checkZ M μ := by
        rw [mul_comm (K1 * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ)) ((-1 : ℂ) * 2)]
    -- 積の結合律
    _ = (((-1 : ℂ) * (2 * (K1 * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ)))) * checkPhase M (-1) μ) • checkZ M μ := by
        rw [mul_assoc (-1 : ℂ) 2 (K1 * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ))]
    -- 積の結合律を右辺から左辺へ
    _ = (((-1 : ℂ) * ((2 * K1) * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ))) * checkPhase M (-1) μ) • checkZ M μ := by
        rw [← mul_assoc 2 K1 (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * checkPhase M 1 μ)]
    -- 積の結合律を右辺から左辺へ
    _ = (((-1 : ℂ) * (((2 * K1) * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1))) * checkPhase M 1 μ)) * checkPhase M (-1) μ) • checkZ M μ := by
        rw [← mul_assoc (2 * K1) ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) (checkPhase M 1 μ)]
    -- 積の結合律を右辺から左辺へ
    _ = ((((-1 : ℂ) * ((2 * K1) * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)))) * checkPhase M 1 μ) * checkPhase M (-1) μ) • checkZ M μ := by
        rw [← mul_assoc (-1 : ℂ) ((2 * K1) * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1))) (checkPhase M 1 μ)]
    -- 積の結合律
    _ = (((-1 : ℂ) * ((2 * K1) * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)))) * (checkPhase M 1 μ * checkPhase M (-1) μ)) • checkZ M μ := by
        rw [mul_assoc ((-1 : ℂ) * ((2 * K1) * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)))) (checkPhase M 1 μ) (checkPhase M (-1) μ)]
    -- 積の可換律
    _ = (((-1 : ℂ) * (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1)) * (2 * K1))) * (checkPhase M 1 μ * checkPhase M (-1) μ)) • checkZ M μ := by
        rw [mul_comm (2 * K1) ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1))]
    -- 積の結合律
    _ = (((-1 : ℂ) * ((-1 : ℂ) ^ k * ((2 * K1) ^ (2 * k + 1) * (2 * K1)))) * (checkPhase M 1 μ * checkPhase M (-1) μ)) • checkZ M μ := by
        rw [mul_assoc ((-1 : ℂ) ^ k) ((2 * K1) ^ (2 * k + 1)) (2 * K1)]
    -- 積の結合律を右辺から左辺へ
    _ = ((((-1 : ℂ) * (-1 : ℂ) ^ k) * ((2 * K1) ^ (2 * k + 1) * (2 * K1))) * (checkPhase M 1 μ * checkPhase M (-1) μ)) • checkZ M μ := by
        rw [← mul_assoc (-1 : ℂ) ((-1 : ℂ) ^ k) ((2 * K1) ^ (2 * k + 1) * (2 * K1))]
    -- 積の可換律
    _ = ((((-1 : ℂ) ^ k * (-1 : ℂ)) * ((2 * K1) ^ (2 * k + 1) * (2 * K1))) * (checkPhase M 1 μ * checkPhase M (-1) μ)) • checkZ M μ := by
        rw [mul_comm (-1 : ℂ) ((-1 : ℂ) ^ k)]
    -- 冪の約束 `x^{m+1} := x^m x` を `-1` と `2(K_1)_ℂ` の二か所へ（`scalar_exp_is_limit_of_partial_sums`）。`(2K_1)^{n+1}` の指数 `n+1` は `n = 2k+1` で `2(k+1)`
    _ = (((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * (k + 1))) * (checkPhase M 1 μ * checkPhase M (-1) μ)) • checkZ M μ := by
        rw [← pow_succ, ← pow_succ, show 2 * k + 1 + 1 = 2 * (k + 1) by ring]
    -- 準備の `e^{-iθ~}e^{iθ~} = 1_ℂ`（`checkPhase_mul_neg_chain`）
    _ = (((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * (k + 1))) * 1) • checkZ M μ := by
        rw [checkPhase_mul_neg_chain hM]
    -- `1_ℂ` は `ℂ` の積の単位元。続く人手の行 `(n-1)/2+1 = (n+1)/2` は、`n = 2k+1` と書くと両辺とも `k+1` なので Lean に段は無い
    _ = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * (k + 1))) • checkZ M μ := by
        rw [mul_one]

/-- **人手 (h1.z) の偶数側**: `n = 2k` のとき `(-1)^k (2K_1)^{2k} check(Z)_μ`。 -/
theorem nesting_H1Plus_checkZ_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1plus M) (2 * k) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkZ M μ := by
  induction k with
  | zero =>
    -- 基底段階
    calc adPow (K1 • H1plus M) (2 * 0) (checkZ M μ)
        -- 0 重交換子は恒等写像
        = checkZ M μ := by rw [Nat.mul_zero, adPow_zero]
      -- `(-1)^0 = 1` かつ `(2K_1)^0 = 1`
      _ = ((-1 : ℂ) ^ 0 * (2 * K1) ^ (2 * 0)) • checkZ M μ := by
          rw [pow_zero, Nat.mul_zero, pow_zero, mul_one, one_smul]
  | succ k ih =>
    exact nesting_H1Plus_checkZ_step_odd_to_even hM K1 μ k
      (nesting_H1Plus_checkZ_step_even_to_odd hM K1 μ k ih)

/-- **人手 (h1.z) の奇数側**: `n = 2k+1` のとき `(-1)^k (2K_1)^{2k+1} e^{-iθ~_μ} check(Y)_μ`。 -/
theorem nesting_H1Plus_checkZ_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1plus M) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ :=
  nesting_H1Plus_checkZ_step_even_to_odd hM K1 μ k (nesting_H1Plus_checkZ_even hM K1 μ k)

/-! ## 人手 (h1.y): `D_n := [K_1H_1^{(+)}, …, [K_1H_1^{(+)}, check(Y)_μ]…]` -/

/-- 人手 (h1.y) の帰納段階 1（`n = 2k` 偶数 → `n+1` 奇数）。 -/
theorem nesting_H1Plus_checkY_step_even_to_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ)
    (ih : adPow (K1 • H1plus M) (2 * k) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkY M μ) :
    adPow (K1 • H1plus M) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ := by
  calc adPow (K1 • H1plus M) (2 * k + 1) (checkY M μ)
      -- `D_{n+1} = [K_1H_1^{(+)}, D_n]` と帰納法の仮定
      = ⁅K1 • H1plus M,
          (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkY M μ)⁆ := by
        rw [adPow_succ, ih, Ring.lie_def]
    -- 交換子の双線型性
    _ = (K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k))) • ⁅H1plus M, checkY M μ⁆ :=
        comm_smul_smul _ _ _ _
    -- (B)
    _ = (K1 * ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)))
          • ((-2 * checkPhase M (-1) μ) • checkZ M μ) := by
        rw [lie_H1Plus_checkY hM μ]
    -- スカラー倍の交換と `K_1 (2K_1)^n (-2) = (-1)(2K_1)^{n+1}`
    _ = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ := by
        rw [smul_smul]
        congr 1
        ring

/-- 人手 (h1.y) の帰納段階 2（`n = 2k+1` 奇数 → `n+1` 偶数）。 -/
theorem nesting_H1Plus_checkY_step_odd_to_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ)
    (ih : adPow (K1 • H1plus M) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ) :
    adPow (K1 • H1plus M) (2 * (k + 1)) (checkY M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * (k + 1))) • checkY M μ := by
  calc adPow (K1 • H1plus M) (2 * (k + 1)) (checkY M μ)
      -- `D_{n+1} = [K_1H_1^{(+)}, D_n]`（`2(k+1) = (2k+1)+1`）と帰納法の仮定
      = ⁅K1 • H1plus M,
          (((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ)⁆ := by
        rw [show 2 * (k + 1) = 2 * k + 1 + 1 by ring, adPow_succ, ih, Ring.lie_def]
    -- 交換子の双線型性
    _ = (K1 * ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ))
          • ⁅H1plus M, checkZ M μ⁆ :=
        comm_smul_smul _ _ _ _
    -- (A)
    _ = (K1 * ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ))
          • ((2 * checkPhase M 1 μ) • checkY M μ) := by
        rw [lie_H1Plus_checkZ hM μ]
    -- スカラー倍の交換と `K_1 (2K_1)^n 2 = (2K_1)^{n+1}`
    _ = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * (k + 1))
          * (checkPhase M (-1) μ * checkPhase M 1 μ)) • checkY M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- `e^{iθ~}e^{-iθ~} = 1`
    _ = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * (k + 1))) • checkY M μ := by
        rw [mul_comm (checkPhase M (-1) μ), checkPhase_mul_neg_chain hM, mul_one]

/-- **人手 (h1.y) の偶数側**: `n = 2k` のとき `(-1)^k (2K_1)^{2k} check(Y)_μ`。 -/
theorem nesting_H1Plus_checkY_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1plus M) (2 * k) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkY M μ := by
  induction k with
  | zero =>
    -- 基底段階
    calc adPow (K1 • H1plus M) (2 * 0) (checkY M μ)
        -- 0 重交換子は恒等写像
        = checkY M μ := by rw [Nat.mul_zero, adPow_zero]
      -- `(-1)^0 = 1` かつ `(2K_1)^0 = 1`
      _ = ((-1 : ℂ) ^ 0 * (2 * K1) ^ (2 * 0)) • checkY M μ := by
          rw [pow_zero, Nat.mul_zero, pow_zero, mul_one, one_smul]
  | succ k ih =>
    exact nesting_H1Plus_checkY_step_odd_to_even hM K1 μ k
      (nesting_H1Plus_checkY_step_even_to_odd hM K1 μ k ih)

/-- **人手 (h1.y) の奇数側**: `n = 2k+1` のとき `(-1)^{k+1} (2K_1)^{2k+1} e^{iθ~_μ} check(Z)_μ`。 -/
theorem nesting_H1Plus_checkY_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K1 • H1plus M) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ :=
  nesting_H1Plus_checkY_step_even_to_odd hM K1 μ k (nesting_H1Plus_checkY_even hM K1 μ k)

/-! ## 人手 (h2.z): `E_n := [K_2^*H_2, …, [K_2^*H_2, check(Z)_μ]…]` -/

/-- 人手 (h2.z) の帰納段階 1（`n = 2k` 偶数 → `n+1` 奇数）。 -/
theorem nesting_H2_checkZ_step_even_to_odd (K2star : ℂ) (μ : ℤ) (k : ℕ)
    (ih : adPow (K2star • H2 M) (2 * k) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkZ M μ) :
    adPow (K2star • H2 M) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1)) • checkY M μ := by
  calc adPow (K2star • H2 M) (2 * k + 1) (checkZ M μ)
      -- `E_{n+1} = [K_2^*H_2, E_n]` と帰納法の仮定
      = ⁅K2star • H2 M,
          (((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkZ M μ)⁆ := by
        rw [adPow_succ, ih, Ring.lie_def]
    -- 交換子の双線型性
    _ = (K2star * ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k))) • ⁅H2 M, checkZ M μ⁆ :=
        comm_smul_smul _ _ _ _
    -- (C)
    _ = (K2star * ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k))) • ((-2 : ℂ) • checkY M μ) := by
        rw [lie_H2_checkZ μ]
    -- スカラー倍の交換と結合。`K_2^*(-2) = (-1)(2K_2^*)`
    _ = ((-1 : ℂ) ^ k * (-1) * ((2 * K2star) ^ (2 * k) * (2 * K2star))) • checkY M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- 冪の指数法則を `(-1)` と `2K_2^*` の両方へ適用
    _ = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1)) • checkY M μ := by
        rw [← pow_succ, ← pow_succ]

/-- 人手 (h2.z) の帰納段階 2（`n = 2k+1` 奇数 → `n+1` 偶数）。 -/
theorem nesting_H2_checkZ_step_odd_to_even (K2star : ℂ) (μ : ℤ) (k : ℕ)
    (ih : adPow (K2star • H2 M) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1)) • checkY M μ) :
    adPow (K2star • H2 M) (2 * (k + 1)) (checkZ M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * (k + 1))) • checkZ M μ := by
  calc adPow (K2star • H2 M) (2 * (k + 1)) (checkZ M μ)
      -- `E_{n+1} = [K_2^*H_2, E_n]`（`2(k+1) = (2k+1)+1`）と帰納法の仮定
      = ⁅K2star • H2 M,
          (((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1)) • checkY M μ)⁆ := by
        rw [show 2 * (k + 1) = 2 * k + 1 + 1 by ring, adPow_succ, ih, Ring.lie_def]
    -- 交換子の双線型性
    _ = (K2star * ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1))) • ⁅H2 M, checkY M μ⁆ :=
        comm_smul_smul _ _ _ _
    -- (D)
    _ = (K2star * ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1))) • ((2 : ℂ) • checkZ M μ) := by
        rw [lie_H2_checkY μ]
    -- スカラー倍の交換と結合
    _ = ((-1 : ℂ) ^ (k + 1) * ((2 * K2star) ^ (2 * k + 1) * (2 * K2star))) • checkZ M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- 冪の指数法則
    _ = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * (k + 1))) • checkZ M μ := by
        rw [← pow_succ, show 2 * k + 1 + 1 = 2 * (k + 1) by ring]

/-- **人手 (h2.z) の偶数側**: `n = 2k` のとき `(-1)^k (2K_2^*)^{2k} check(Z)_μ`。 -/
theorem nesting_H2_checkZ_even (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k) (checkZ M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkZ M μ := by
  induction k with
  | zero =>
    -- 基底段階
    calc adPow (K2star • H2 M) (2 * 0) (checkZ M μ)
        -- 0 重交換子は恒等写像
        = checkZ M μ := by rw [Nat.mul_zero, adPow_zero]
      -- `(-1)^0 = 1` かつ `(2K_2^*)^0 = 1`
      _ = ((-1 : ℂ) ^ 0 * (2 * K2star) ^ (2 * 0)) • checkZ M μ := by
          rw [pow_zero, Nat.mul_zero, pow_zero, mul_one, one_smul]
  | succ k ih =>
    exact nesting_H2_checkZ_step_odd_to_even K2star μ k
      (nesting_H2_checkZ_step_even_to_odd K2star μ k ih)

/-- **人手 (h2.z) の奇数側**: `n = 2k+1` のとき `(-1)^{k+1} (2K_2^*)^{2k+1} check(Y)_μ`。 -/
theorem nesting_H2_checkZ_odd (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k + 1) (checkZ M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1)) • checkY M μ :=
  nesting_H2_checkZ_step_even_to_odd K2star μ k (nesting_H2_checkZ_even K2star μ k)

/-! ## 人手 (h2.y): `F_n := [K_2^*H_2, …, [K_2^*H_2, check(Y)_μ]…]` -/

/-- 人手 (h2.y) の帰納段階 1（`n = 2k` 偶数 → `n+1` 奇数）。 -/
theorem nesting_H2_checkY_step_even_to_odd (K2star : ℂ) (μ : ℤ) (k : ℕ)
    (ih : adPow (K2star • H2 M) (2 * k) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkY M μ) :
    adPow (K2star • H2 M) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ := by
  calc adPow (K2star • H2 M) (2 * k + 1) (checkY M μ)
      -- `F_{n+1} = [K_2^*H_2, F_n]` と帰納法の仮定
      = ⁅K2star • H2 M,
          (((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkY M μ)⁆ := by
        rw [adPow_succ, ih, Ring.lie_def]
    -- 交換子の双線型性
    _ = (K2star * ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k))) • ⁅H2 M, checkY M μ⁆ :=
        comm_smul_smul _ _ _ _
    -- (D)
    _ = (K2star * ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k))) • ((2 : ℂ) • checkZ M μ) := by
        rw [lie_H2_checkY μ]
    -- スカラー倍の交換と結合
    _ = ((-1 : ℂ) ^ k * ((2 * K2star) ^ (2 * k) * (2 * K2star))) • checkZ M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- 冪の指数法則
    _ = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ := by
        rw [← pow_succ]

/-- 人手 (h2.y) の帰納段階 2（`n = 2k+1` 奇数 → `n+1` 偶数）。 -/
theorem nesting_H2_checkY_step_odd_to_even (K2star : ℂ) (μ : ℤ) (k : ℕ)
    (ih : adPow (K2star • H2 M) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ) :
    adPow (K2star • H2 M) (2 * (k + 1)) (checkY M μ)
      = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * (k + 1))) • checkY M μ := by
  calc adPow (K2star • H2 M) (2 * (k + 1)) (checkY M μ)
      -- `F_{n+1} = [K_2^*H_2, F_n]`（`2(k+1) = (2k+1)+1`）と帰納法の仮定
      = ⁅K2star • H2 M,
          (((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ)⁆ := by
        rw [show 2 * (k + 1) = 2 * k + 1 + 1 by ring, adPow_succ, ih, Ring.lie_def]
    -- 交換子の双線型性
    _ = (K2star * ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1))) • ⁅H2 M, checkZ M μ⁆ :=
        comm_smul_smul _ _ _ _
    -- (C)
    _ = (K2star * ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1))) • ((-2 : ℂ) • checkY M μ) := by
        rw [lie_H2_checkZ μ]
    -- スカラー倍の交換と結合。`K_2^*(-2) = (-1)(2K_2^*)`
    _ = ((-1 : ℂ) ^ k * (-1) * ((2 * K2star) ^ (2 * k + 1) * (2 * K2star))) • checkY M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- 冪の指数法則を `(-1)` と `2K_2^*` の両方へ適用（`(n-1)/2+1 = (n+1)/2` は `k` で書くと `k+1` そのもの）
    _ = ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * (k + 1))) • checkY M μ := by
        rw [← pow_succ, ← pow_succ, show 2 * k + 1 + 1 = 2 * (k + 1) by ring]

/-- **人手 (h2.y) の偶数側**: `n = 2k` のとき `(-1)^k (2K_2^*)^{2k} check(Y)_μ`。 -/
theorem nesting_H2_checkY_even (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkY M μ := by
  induction k with
  | zero =>
    -- 基底段階
    calc adPow (K2star • H2 M) (2 * 0) (checkY M μ)
        -- 0 重交換子は恒等写像
        = checkY M μ := by rw [Nat.mul_zero, adPow_zero]
      -- `(-1)^0 = 1` かつ `(2K_2^*)^0 = 1`
      _ = ((-1 : ℂ) ^ 0 * (2 * K2star) ^ (2 * 0)) • checkY M μ := by
          rw [pow_zero, Nat.mul_zero, pow_zero, mul_one, one_smul]
  | succ k ih =>
    exact nesting_H2_checkY_step_odd_to_even K2star μ k
      (nesting_H2_checkY_step_even_to_odd K2star μ k ih)

/-- **人手 (h2.y) の奇数側**: `n = 2k+1` のとき `(-1)^k (2K_2^*)^{2k+1} check(Z)_μ`。 -/
theorem nesting_H2_checkY_odd (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (K2star • H2 M) (2 * k + 1) (checkY M μ)
      = ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ :=
  nesting_H2_checkY_step_even_to_odd K2star μ k (nesting_H2_checkY_even K2star μ k)

end Ising2D
