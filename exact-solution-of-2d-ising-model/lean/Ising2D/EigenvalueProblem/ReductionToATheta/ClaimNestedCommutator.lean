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
`e^{-iθ~}e^{iθ~} = 1`（`checkPhase_mul_neg`）だけである。

右辺は `n` の偶奇で場合分けされているので、Lean では `n = 2k` と `n = 2k+1` を別の定理にし、
人手の符号の指数を `k` で書く（`(-1)^{n/2} = (-1)^k`、`(-1)^{(n-1)/2} = (-1)^k`、`(-1)^{(n+1)/2} = (-1)^{k+1}`）。
人手の 3 つの段は次の定理に当たる。

| 人手 | Lean（(h1.z) の場合。ほかの 3 式も同じ並び） |
| --- | --- |
| 基底段階（`n = 0`） | `nesting_H1Plus_checkZ_even` の `k = 0` の場合の `calc` |
| 帰納段階 1（`n` 偶数 → `n+1` 奇数） | `nesting_H1Plus_checkZ_step_even_to_odd` の `calc`（人手の 4 行） |
| 帰納段階 2（`n` 奇数 → `n+1` 偶数） | `nesting_H1Plus_checkZ_step_odd_to_even` の `calc`（人手の行。最後の `(n-1)/2+1 = (n+1)/2` は `k` で書くと `k+1` そのもの） |

偶数側の定理は `k` についての帰納法で、`k` から `k+1` へは帰納段階 1 と 2 を続けて当てる。
奇数側の定理は偶数側に帰納段階 1 を当てる。

`n` 重の入れ子交換子は `Ising2D.adPow`（`EigenvalueProblem/ReductionToATheta/ClaimExpConjugation.lean`）で表す。
`adPow X (n+1) A = X (adPow X n A) - (adPow X n A) X` が人手の `C_{n+1} = [K_1H_1^{(+)}, C_n]` に当たる。
`e^{-iθ~_μ}` は `Ising2D.checkPhase M 1 μ`、`e^{iθ~_μ}` は `Ising2D.checkPhase M (-1) μ`
（`EigenvalueProblem/ReductionToATheta/ClaimAntiperiodicExpSum.lean`）。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExpConjugation
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimCommutatorHCheckZY

namespace Ising2D

variable {M : ℕ}

/-! ## 証明の冒頭で使う 2 つの事実 -/

/-- `e^{-iθ~_μ} e^{iθ~_μ} = 1`（人手が帰納段階で使う唯一の位相の性質）。 -/
theorem checkPhase_mul_neg (M : ℕ) (μ : ℤ) :
    checkPhase M 1 μ * checkPhase M (-1) μ = 1 := by
  rw [← checkPhase_add_left]
  norm_num

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
    -- スカラー倍の交換と `K_1 (2K_1)^n 2 = (2K_1)^{n+1}`
    _ = ((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
        rw [smul_smul]
        congr 1
        ring

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
    -- スカラー倍の交換と `K_1 (2K_1)^n (-2) = (-1)(2K_1)^{n+1}`
    _ = ((-1) * (-1 : ℂ) ^ k * (2 * K1) ^ (2 * (k + 1))
          * (checkPhase M 1 μ * checkPhase M (-1) μ)) • checkZ M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- `e^{-iθ~}e^{iθ~} = 1` と `(-1)(-1)^{(n-1)/2} = (-1)^{(n-1)/2+1}`
    _ = ((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * (k + 1))) • checkZ M μ := by
        rw [checkPhase_mul_neg, mul_one, ← pow_succ']

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
        rw [mul_comm (checkPhase M (-1) μ), checkPhase_mul_neg, mul_one]

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
