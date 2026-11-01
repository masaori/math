/-
# 具体版: `check(Z), check(Y)` についての cosh / sinh の展開係数への変換

対応する人手証明のラベル: **`cosh_sinh_coefficient_conversion_for_check`**
（`structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts` の
`evensectorT_003_claim_coefficient_conversion`）

人手証明と 1 対 1 に対応する。必要十分版は補題 1 について `Ising2D/NecSuf/IteratedCommutatorSmul.lean` の
`Ising2D.NecSuf.iterComm_smul_left`、代入する `nesting_of_commutator_of_H_and_check_Z` について
`Ising2D/NecSuf/NestedCommutatorTwoDim.lean` の `nested_z_even` / `nested_z_odd` / `nested_y_even` / `nested_y_odd` である。
具体版をそれらの特殊化として得る定理は `EigenvalueProblem/ReductionToATheta/ClaimCoefficientConversionFromNecSuf.lean` にある。

## 人手証明との対応

人手は補題 1（生成子のスカラー倍 `ad_{αX}^n = α^n ad_X^n`）と補題 2（`i^n` の偶奇）を用意し、
4 式それぞれで「補題 1 → `nesting_of_commutator_of_H_and_check_Z` の代入 → スカラーの整理 → 補題 2 → 符号の整理」
の鎖を書く。

| 人手 | Lean |
| --- | --- |
| 補題 1 の `ad_{αX}(W) = α ad_X(W)` の 3 行 | `ad_smul_left`（必要十分版 `NecSuf.iterComm_smul_left_one`） |
| 補題 1 の「`ad_X` は ℂ 線型で、合成の各段からスカラーを前へ出せる」 | `ad_smul_right` と `adPow_smul_left` の帰納法（必要十分版 `NecSuf.iterComm_smul_right_one`・`NecSuf.iterComm_smul_left`） |
| 補題 2 の偶数・奇数の 2 行ずつ | `I_pow_even`・`I_pow_odd` |
| (h1.z)(h1.y)(h2.z)(h2.y) の鎖 | `conversion_*_even`・`conversion_*_odd` の `calc` |

右辺は `n` の偶奇で場合分けされているので、`n = 2k` と `n = 2k+1` を別の定理にする
（`(-1)^{n/2} = (-1)^k`、`(-1)^{(n-1)/2} = (-1)^k`、`(-1)^{(n+1)/2} = (-1)^{k+1}`）。
`calc` の最初の行は、人手が `[\tfrac{i}{2}K_1H_1^{(+)}, …]` と書く生成子を `α = i/2`、`X = K_1H_1^{(+)}` に
分ける書き直し（`((1/2)·i·K_1)H = (i/2)(K_1H)`）で、人手では記法の読み方に当たる。
人手の `2^{-n}` は `(2^n)^{-1}` と書く。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimNestedCommutator

namespace Ising2D

variable {M : ℕ}

/-! ## 補題 1（生成子のスカラー倍） -/

/-- 人手の補題 1 の `ad_{αX}(W) = α ad_X(W)`（交換子の第 1 引数についての ℂ 線型性）。 -/
theorem ad_smul_left (α : ℂ) (X W : TensorPow M) :
    (α • X) * W - W * (α • X) = α • (X * W - W * X) := by
  -- 両辺は `ad` の定義（`ad_X(W) = XW - WX`）で開いた形で書いてある
  calc (α • X) * W - W * (α • X)
      -- 交換子の第 1 引数についての ℂ 線型性（スカラー倍を積の外へ出す）
      = α • (X * W) - α • (W * X) := by rw [smul_mul_assoc, mul_smul_comm]
    -- 分配則
    _ = α • (X * W - W * X) := (smul_sub _ _ _).symm

/-- 人手の補題 1 の「`ad_X` は ℂ 線型」: `ad_X(αW) = α ad_X(W)`。 -/
theorem ad_smul_right (α : ℂ) (X W : TensorPow M) :
    X * (α • W) - (α • W) * X = α • (X * W - W * X) := by
  calc X * (α • W) - (α • W) * X
      -- スカラー倍を積の外へ出す
      = α • (X * W) - α • (W * X) := by rw [mul_smul_comm, smul_mul_assoc]
    -- 分配則
    _ = α • (X * W - W * X) := (smul_sub _ _ _).symm

/-- **人手の補題 1**: `ad_{αX}^n(W) = α^n ad_X^n(W)`。
`n = 0` は両辺とも `W`（`α^0 = 1`）。`n` から `n+1` へは `ad_{αX} = α ad_X` と、
`ad_X` の合成の各段からスカラーを前へ出せることを当てる。 -/
theorem adPow_smul_left (α : ℂ) (X W : TensorPow M) :
    ∀ n : ℕ, adPow (α • X) n W = α ^ n • adPow X n W
  | 0 => by rw [adPow_zero, adPow_zero, pow_zero, one_smul]
  | n + 1 => by
    calc adPow (α • X) (n + 1) W
        -- `ad` の定義
        = (α • X) * adPow (α • X) n W - adPow (α • X) n W * (α • X) := adPow_succ _ _ _
      -- `ad_{αX} = α ad_X`
      _ = α • (X * adPow (α • X) n W - adPow (α • X) n W * X) := ad_smul_left _ _ _
      -- 帰納法の仮定
      _ = α • (X * (α ^ n • adPow X n W) - (α ^ n • adPow X n W) * X) := by
          rw [adPow_smul_left α X W n]
      -- `ad_X` は ℂ 線型
      _ = α • (α ^ n • (X * adPow X n W - adPow X n W * X)) := by rw [ad_smul_right]
      -- スカラーの積 `α·α^n = α^{n+1}` と `ad` の定義
      _ = α ^ (n + 1) • adPow X (n + 1) W := by rw [smul_smul, ← pow_succ', adPow_succ]

/-! ## 補題 2（虚数単位の冪） -/

/-- **人手の補題 2 の偶数側**: `i^{2k} = (-1)^k`。 -/
theorem I_pow_even (k : ℕ) : Complex.I ^ (2 * k) = (-1 : ℂ) ^ k := by
  calc Complex.I ^ (2 * k)
      -- `n = 2(n/2)`
      = (Complex.I ^ 2) ^ k := pow_mul _ _ _
    -- `i^2 = -1`
    _ = (-1 : ℂ) ^ k := by rw [Complex.I_sq]

/-- **人手の補題 2 の奇数側**: `i^{2k+1} = i (-1)^k`。 -/
theorem I_pow_odd (k : ℕ) : Complex.I ^ (2 * k + 1) = Complex.I * (-1 : ℂ) ^ k := by
  calc Complex.I ^ (2 * k + 1)
      -- `n = 1 + 2((n-1)/2)`
      = Complex.I * (Complex.I ^ 2) ^ k := by rw [pow_succ', pow_mul]
    -- `i^2 = -1`
    _ = Complex.I * (-1 : ℂ) ^ k := by rw [Complex.I_sq]

/-! ## 人手 (h1.z)・(h1.y): `α = i/2`、`X = K_1 H_1^{(+)}` -/

/-- `(i/2)^n = i^n 2^{-n}`。 -/
theorem half_I_pow (n : ℕ) :
    ((1 / 2 : ℂ) * Complex.I) ^ n = Complex.I ^ n * ((2 : ℂ) ^ n)⁻¹ := by
  rw [mul_pow, one_div, inv_pow, mul_comm]

/-- `2^{-n} 2^n = 1`。 -/
theorem two_pow_inv_mul (n : ℕ) : ((2 : ℂ) ^ n)⁻¹ * (2 : ℂ) ^ n = 1 :=
  inv_mul_cancel₀ (pow_ne_zero n two_ne_zero)

/-- **人手 (h1.z) 偶数側**: `n = 2k` のとき `K_1^{2k} check(Z)_μ`（符号が消える）。 -/
theorem conversion_H1Plus_checkZ_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k) (checkZ M μ)
      = (K1 ^ (2 * k)) • checkZ M μ := by
  calc adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k) (checkZ M μ)
      = adPow (((1 / 2 : ℂ) * Complex.I) • (K1 • H1plus M)) (2 * k) (checkZ M μ) := by
        rw [smul_smul]
    -- 補題 1
    _ = ((1 / 2 : ℂ) * Complex.I) ^ (2 * k) • adPow (K1 • H1plus M) (2 * k) (checkZ M μ) :=
        adPow_smul_left _ _ _ _
    -- `nesting_of_commutator_of_H_and_check_Z` (h1.z)
    _ = ((1 / 2 : ℂ) * Complex.I) ^ (2 * k)
          • (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkZ M μ) := by
        rw [nesting_H1Plus_checkZ_even hM K1 μ k]
    -- `(i/2)^n = i^n 2^{-n}`
    _ = (Complex.I ^ (2 * k) * ((2 : ℂ) ^ (2 * k))⁻¹)
          • (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkZ M μ) := by
        rw [half_I_pow]
    -- `(2K_1)^n = 2^n K_1^n`
    _ = (Complex.I ^ (2 * k) * ((2 : ℂ) ^ (2 * k))⁻¹)
          • (((-1 : ℂ) ^ k * ((2 : ℂ) ^ (2 * k) * K1 ^ (2 * k))) • checkZ M μ) := by
        rw [mul_pow]
    -- ℂ の分配律・交換律
    _ = (Complex.I ^ (2 * k) * (((2 : ℂ) ^ (2 * k))⁻¹ * (2 : ℂ) ^ (2 * k))
          * (-1 : ℂ) ^ k * K1 ^ (2 * k)) • checkZ M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- `2^{-n} 2^n = 1`
    _ = (Complex.I ^ (2 * k) * (-1 : ℂ) ^ k * K1 ^ (2 * k)) • checkZ M μ := by
        rw [two_pow_inv_mul, mul_one]
    -- 補題 2
    _ = ((-1 : ℂ) ^ k * (-1 : ℂ) ^ k * K1 ^ (2 * k)) • checkZ M μ := by
        rw [I_pow_even]
    -- `n/2 + n/2 = n`
    _ = ((-1 : ℂ) ^ (2 * k) * K1 ^ (2 * k)) • checkZ M μ := by
        rw [← pow_add, ← two_mul]
    -- `n` 偶数なら `(-1)^n = 1`
    _ = (K1 ^ (2 * k)) • checkZ M μ := by
        rw [pow_mul, neg_one_sq, one_pow, one_mul]

/-- **人手 (h1.z) 奇数側**: `n = 2k+1` のとき `i K_1^{2k+1} e^{-iθ~_μ} check(Y)_μ`。 -/
theorem conversion_H1Plus_checkZ_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k + 1) (checkZ M μ)
      = (Complex.I * K1 ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
  calc adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k + 1) (checkZ M μ)
      = adPow (((1 / 2 : ℂ) * Complex.I) • (K1 • H1plus M)) (2 * k + 1) (checkZ M μ) := by
        rw [smul_smul]
    -- 補題 1
    _ = ((1 / 2 : ℂ) * Complex.I) ^ (2 * k + 1)
          • adPow (K1 • H1plus M) (2 * k + 1) (checkZ M μ) :=
        adPow_smul_left _ _ _ _
    -- `nesting_of_commutator_of_H_and_check_Z` (h1.z)
    _ = ((1 / 2 : ℂ) * Complex.I) ^ (2 * k + 1)
          • (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ) := by
        rw [nesting_H1Plus_checkZ_odd hM K1 μ k]
    -- `(i/2)^n = i^n 2^{-n}`
    _ = (Complex.I ^ (2 * k + 1) * ((2 : ℂ) ^ (2 * k + 1))⁻¹)
          • (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ) := by
        rw [half_I_pow]
    -- `(2K_1)^n = 2^n K_1^n`
    _ = (Complex.I ^ (2 * k + 1) * ((2 : ℂ) ^ (2 * k + 1))⁻¹)
          • (((-1 : ℂ) ^ k * ((2 : ℂ) ^ (2 * k + 1) * K1 ^ (2 * k + 1)) * checkPhase M 1 μ)
            • checkY M μ) := by
        rw [mul_pow]
    -- ℂ の分配律・交換律
    _ = (Complex.I ^ (2 * k + 1) * (((2 : ℂ) ^ (2 * k + 1))⁻¹ * (2 : ℂ) ^ (2 * k + 1))
          * (-1 : ℂ) ^ k * K1 ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- `2^{-n} 2^n = 1`
    _ = (Complex.I ^ (2 * k + 1) * (-1 : ℂ) ^ k * K1 ^ (2 * k + 1) * checkPhase M 1 μ)
          • checkY M μ := by
        rw [two_pow_inv_mul, mul_one]
    -- 補題 2
    _ = (Complex.I * (-1 : ℂ) ^ k * (-1 : ℂ) ^ k * K1 ^ (2 * k + 1) * checkPhase M 1 μ)
          • checkY M μ := by
        rw [I_pow_odd]
    -- `(n-1)/2 + (n-1)/2 = n-1`
    _ = (Complex.I * (-1 : ℂ) ^ (2 * k) * K1 ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
        rw [mul_assoc Complex.I, ← pow_add, ← two_mul]
    -- `n` 奇数なら `(-1)^{n-1} = 1`
    _ = (Complex.I * K1 ^ (2 * k + 1) * checkPhase M 1 μ) • checkY M μ := by
        rw [pow_mul, neg_one_sq, one_pow, mul_one]

/-- **人手 (h1.y) 偶数側**: `n = 2k` のとき `K_1^{2k} check(Y)_μ`。 -/
theorem conversion_H1Plus_checkY_even (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k) (checkY M μ)
      = (K1 ^ (2 * k)) • checkY M μ := by
  calc adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k) (checkY M μ)
      = adPow (((1 / 2 : ℂ) * Complex.I) • (K1 • H1plus M)) (2 * k) (checkY M μ) := by
        rw [smul_smul]
    -- 補題 1
    _ = ((1 / 2 : ℂ) * Complex.I) ^ (2 * k) • adPow (K1 • H1plus M) (2 * k) (checkY M μ) :=
        adPow_smul_left _ _ _ _
    -- `nesting_of_commutator_of_H_and_check_Z` (h1.y)
    _ = ((1 / 2 : ℂ) * Complex.I) ^ (2 * k)
          • (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkY M μ) := by
        rw [nesting_H1Plus_checkY_even hM K1 μ k]
    -- `(i/2)^n = i^n 2^{-n}`
    _ = (Complex.I ^ (2 * k) * ((2 : ℂ) ^ (2 * k))⁻¹)
          • (((-1 : ℂ) ^ k * (2 * K1) ^ (2 * k)) • checkY M μ) := by
        rw [half_I_pow]
    -- `(2K_1)^n = 2^n K_1^n`
    _ = (Complex.I ^ (2 * k) * ((2 : ℂ) ^ (2 * k))⁻¹)
          • (((-1 : ℂ) ^ k * ((2 : ℂ) ^ (2 * k) * K1 ^ (2 * k))) • checkY M μ) := by
        rw [mul_pow]
    -- ℂ の分配律・交換律
    _ = (Complex.I ^ (2 * k) * (((2 : ℂ) ^ (2 * k))⁻¹ * (2 : ℂ) ^ (2 * k))
          * (-1 : ℂ) ^ k * K1 ^ (2 * k)) • checkY M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- `2^{-n} 2^n = 1`
    _ = (Complex.I ^ (2 * k) * (-1 : ℂ) ^ k * K1 ^ (2 * k)) • checkY M μ := by
        rw [two_pow_inv_mul, mul_one]
    -- 補題 2
    _ = ((-1 : ℂ) ^ k * (-1 : ℂ) ^ k * K1 ^ (2 * k)) • checkY M μ := by
        rw [I_pow_even]
    -- `n/2 + n/2 = n`
    _ = ((-1 : ℂ) ^ (2 * k) * K1 ^ (2 * k)) • checkY M μ := by
        rw [← pow_add, ← two_mul]
    -- `n` 偶数なら `(-1)^n = 1`
    _ = (K1 ^ (2 * k)) • checkY M μ := by
        rw [pow_mul, neg_one_sq, one_pow, one_mul]

/-- **人手 (h1.y) 奇数側**: `n = 2k+1` のとき `-i K_1^{2k+1} e^{iθ~_μ} check(Z)_μ`。 -/
theorem conversion_H1Plus_checkY_odd (hM : M ≠ 0) (K1 : ℂ) (μ : ℤ) (k : ℕ) :
    adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k + 1) (checkY M μ)
      = (-Complex.I * K1 ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ := by
  calc adPow (((1 / 2 : ℂ) * Complex.I * K1) • H1plus M) (2 * k + 1) (checkY M μ)
      = adPow (((1 / 2 : ℂ) * Complex.I) • (K1 • H1plus M)) (2 * k + 1) (checkY M μ) := by
        rw [smul_smul]
    -- 補題 1
    _ = ((1 / 2 : ℂ) * Complex.I) ^ (2 * k + 1)
          • adPow (K1 • H1plus M) (2 * k + 1) (checkY M μ) :=
        adPow_smul_left _ _ _ _
    -- `nesting_of_commutator_of_H_and_check_Z` (h1.y)
    _ = ((1 / 2 : ℂ) * Complex.I) ^ (2 * k + 1)
          • (((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ)
            • checkZ M μ) := by
        rw [nesting_H1Plus_checkY_odd hM K1 μ k]
    -- `(i/2)^n = i^n 2^{-n}`
    _ = (Complex.I ^ (2 * k + 1) * ((2 : ℂ) ^ (2 * k + 1))⁻¹)
          • (((-1 : ℂ) ^ (k + 1) * (2 * K1) ^ (2 * k + 1) * checkPhase M (-1) μ)
            • checkZ M μ) := by
        rw [half_I_pow]
    -- `(2K_1)^n = 2^n K_1^n`
    _ = (Complex.I ^ (2 * k + 1) * ((2 : ℂ) ^ (2 * k + 1))⁻¹)
          • (((-1 : ℂ) ^ (k + 1) * ((2 : ℂ) ^ (2 * k + 1) * K1 ^ (2 * k + 1))
              * checkPhase M (-1) μ) • checkZ M μ) := by
        rw [mul_pow]
    -- ℂ の分配律・交換律
    _ = (Complex.I ^ (2 * k + 1) * (((2 : ℂ) ^ (2 * k + 1))⁻¹ * (2 : ℂ) ^ (2 * k + 1))
          * (-1 : ℂ) ^ (k + 1) * K1 ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ := by
        rw [smul_smul]
        congr 1
        ring
    -- `2^{-n} 2^n = 1`
    _ = (Complex.I ^ (2 * k + 1) * (-1 : ℂ) ^ (k + 1) * K1 ^ (2 * k + 1) * checkPhase M (-1) μ)
          • checkZ M μ := by
        rw [two_pow_inv_mul, mul_one]
    -- 補題 2
    _ = (Complex.I * (-1 : ℂ) ^ k * (-1 : ℂ) ^ (k + 1) * K1 ^ (2 * k + 1)
          * checkPhase M (-1) μ) • checkZ M μ := by
        rw [I_pow_odd]
    -- `(n-1)/2 + (n+1)/2 = n`
    _ = (Complex.I * (-1 : ℂ) ^ (2 * k + 1) * K1 ^ (2 * k + 1) * checkPhase M (-1) μ)
          • checkZ M μ := by
        rw [mul_assoc Complex.I, ← pow_add, show k + (k + 1) = 2 * k + 1 by ring]
    -- `n` 奇数なら `(-1)^n = -1`
    _ = (-Complex.I * K1 ^ (2 * k + 1) * checkPhase M (-1) μ) • checkZ M μ := by
        rw [pow_succ, pow_mul, neg_one_sq, one_pow, one_mul, mul_neg_one]

/-! ## 人手 (h2.z)・(h2.y): `α = i`、`X = K_2^* H_2`（`2` の冪は現れない） -/

/-- **人手 (h2.z) 偶数側**: `n = 2k` のとき `(2K_2^*)^{2k} check(Z)_μ`。 -/
theorem conversion_H2_checkZ_even (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkZ M μ)
      = ((2 * K2star) ^ (2 * k)) • checkZ M μ := by
  calc adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkZ M μ)
      = adPow (Complex.I • (K2star • H2 M)) (2 * k) (checkZ M μ) := by rw [smul_smul]
    -- 補題 1
    _ = Complex.I ^ (2 * k) • adPow (K2star • H2 M) (2 * k) (checkZ M μ) :=
        adPow_smul_left _ _ _ _
    -- `nesting_of_commutator_of_H_and_check_Z` (h2.z)
    _ = Complex.I ^ (2 * k) • (((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkZ M μ) := by
        rw [nesting_H2_checkZ_even hM K2star μ k]
    -- 補題 2
    _ = ((-1 : ℂ) ^ k * ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k))) • checkZ M μ := by
        rw [I_pow_even, smul_smul]
    -- `n/2 + n/2 = n`
    _ = ((-1 : ℂ) ^ (2 * k) * (2 * K2star) ^ (2 * k)) • checkZ M μ := by
        rw [← mul_assoc, ← pow_add, ← two_mul]
    -- `n` 偶数なら `(-1)^n = 1`
    _ = ((2 * K2star) ^ (2 * k)) • checkZ M μ := by
        rw [pow_mul, neg_one_sq, one_pow, one_mul]

/-- **人手 (h2.z) 奇数側**: `n = 2k+1` のとき `-i (2K_2^*)^{2k+1} check(Y)_μ`。 -/
theorem conversion_H2_checkZ_odd (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkZ M μ)
      = (-Complex.I * (2 * K2star) ^ (2 * k + 1)) • checkY M μ := by
  calc adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkZ M μ)
      = adPow (Complex.I • (K2star • H2 M)) (2 * k + 1) (checkZ M μ) := by rw [smul_smul]
    -- 補題 1
    _ = Complex.I ^ (2 * k + 1) • adPow (K2star • H2 M) (2 * k + 1) (checkZ M μ) :=
        adPow_smul_left _ _ _ _
    -- `nesting_of_commutator_of_H_and_check_Z` (h2.z)
    _ = Complex.I ^ (2 * k + 1)
          • (((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1)) • checkY M μ) := by
        rw [nesting_H2_checkZ_odd hM K2star μ k]
    -- 補題 2
    _ = (Complex.I * (-1 : ℂ) ^ k * ((-1 : ℂ) ^ (k + 1) * (2 * K2star) ^ (2 * k + 1)))
          • checkY M μ := by
        rw [I_pow_odd, smul_smul]
    -- `(n-1)/2 + (n+1)/2 = n`
    _ = (Complex.I * (-1 : ℂ) ^ (2 * k + 1) * (2 * K2star) ^ (2 * k + 1)) • checkY M μ := by
        rw [← mul_assoc, mul_assoc Complex.I, ← pow_add, show k + (k + 1) = 2 * k + 1 by ring]
    -- `n` 奇数なら `(-1)^n = -1`
    _ = (-Complex.I * (2 * K2star) ^ (2 * k + 1)) • checkY M μ := by
        rw [pow_succ, pow_mul, neg_one_sq, one_pow, one_mul, mul_neg_one]

/-- **人手 (h2.y) 偶数側**: `n = 2k` のとき `(2K_2^*)^{2k} check(Y)_μ`。 -/
theorem conversion_H2_checkY_even (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkY M μ)
      = ((2 * K2star) ^ (2 * k)) • checkY M μ := by
  calc adPow ((Complex.I * K2star) • H2 M) (2 * k) (checkY M μ)
      = adPow (Complex.I • (K2star • H2 M)) (2 * k) (checkY M μ) := by rw [smul_smul]
    -- 補題 1
    _ = Complex.I ^ (2 * k) • adPow (K2star • H2 M) (2 * k) (checkY M μ) :=
        adPow_smul_left _ _ _ _
    -- `nesting_of_commutator_of_H_and_check_Z` (h2.y)
    _ = Complex.I ^ (2 * k) • (((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k)) • checkY M μ) := by
        rw [nesting_H2_checkY_even hM K2star μ k]
    -- 補題 2
    _ = ((-1 : ℂ) ^ k * ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k))) • checkY M μ := by
        rw [I_pow_even, smul_smul]
    -- `n/2 + n/2 = n`
    _ = ((-1 : ℂ) ^ (2 * k) * (2 * K2star) ^ (2 * k)) • checkY M μ := by
        rw [← mul_assoc, ← pow_add, ← two_mul]
    -- `n` 偶数なら `(-1)^n = 1`
    _ = ((2 * K2star) ^ (2 * k)) • checkY M μ := by
        rw [pow_mul, neg_one_sq, one_pow, one_mul]

/-- **人手 (h2.y) 奇数側**: `n = 2k+1` のとき `i (2K_2^*)^{2k+1} check(Z)_μ`。 -/
theorem conversion_H2_checkY_odd (hM : M ≠ 0) (K2star : ℂ) (μ : ℤ) (k : ℕ) :
    adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkY M μ)
      = (Complex.I * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ := by
  calc adPow ((Complex.I * K2star) • H2 M) (2 * k + 1) (checkY M μ)
      = adPow (Complex.I • (K2star • H2 M)) (2 * k + 1) (checkY M μ) := by rw [smul_smul]
    -- 補題 1
    _ = Complex.I ^ (2 * k + 1) • adPow (K2star • H2 M) (2 * k + 1) (checkY M μ) :=
        adPow_smul_left _ _ _ _
    -- `nesting_of_commutator_of_H_and_check_Z` (h2.y)
    _ = Complex.I ^ (2 * k + 1)
          • (((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ) := by
        rw [nesting_H2_checkY_odd hM K2star μ k]
    -- 補題 2
    _ = (Complex.I * (-1 : ℂ) ^ k * ((-1 : ℂ) ^ k * (2 * K2star) ^ (2 * k + 1)))
          • checkZ M μ := by
        rw [I_pow_odd, smul_smul]
    -- `(n-1)/2 + (n-1)/2 = n-1`
    _ = (Complex.I * (-1 : ℂ) ^ (2 * k) * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ := by
        rw [← mul_assoc, mul_assoc Complex.I, ← pow_add, ← two_mul]
    -- `n` 奇数なら `(-1)^{n-1} = 1`
    _ = (Complex.I * (2 * K2star) ^ (2 * k + 1)) • checkZ M μ := by
        rw [pow_mul, neg_one_sq, one_pow, mul_one]

end Ising2D
