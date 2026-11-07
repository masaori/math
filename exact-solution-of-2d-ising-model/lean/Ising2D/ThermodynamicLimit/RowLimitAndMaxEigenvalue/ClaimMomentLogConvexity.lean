/-
# モーメント列 `m_k := x^⊤(W_ℝ)^kx` の正値性と対数凸性（具体版）

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_008b_claim_moment_log_convexity`、ラベル **`moment_log_convexity`**）

必要十分版: `Ising2D.NecSuf.IsPdPair.moment_pos`（正値性）と `Ising2D.NecSuf.IsPsdPair.moment_log_convex`（対数凸性）
（`Ising2D/NecSuf/RayleighMoments.lean`）。内積と自己共役な線型写像の組へ上げたもので、手順は同じである
（人手の【冪の対称性】・【冪の分け方】と【二つの冪で挟んだ値】で `x^⊤(W_ℝ)^{a+b}x = (u^{(b)})^⊤I_ℝu^{(a)}`・`x^⊤(W_ℝ)^{a+b+1}x = (u^{(b)})^⊤W_ℝu^{(a)}`
に着く段は、必要十分版では自己共役性から出る `moment_split`（`⟪W^px, W^qx⟫ = ⟪x, W^{p+q}x⟫`）である。
人手は `W^b` の成分の対称性（`power_of_real_symmetric_complex_matrix_is_real_symmetric` から）で `W^b` を一度に移すが、
`moment_split` は自己共役性で `W` を一つずつ移す帰納法で、冪の対称性はその帰納法に吸収されている。
【`(W_ℝ)^ax` は零でない】は `W_ker`・`pow_ne_zero_of_ne_zero`、`P = I_ℝ`・`P = W_ℝ` の Cauchy–Schwarz は `cs_ip`・`cs_W`）。
必要十分版は人手の `k ≥ 1` の `m_k^2 ≤ m_{k-1}m_{k+1}` を `k → k+1` とずらして `m_{k+1}^2 ≤ m_km_{k+2}` と述べる。
具体版と同じ型の主張を必要十分版の特殊化として得ることは `ClaimMomentLogConvexityFromNecSuf.lean` の
`moment_log_convexity_of_necSuf` が記録している。
対数凸性には正定値性は要らず、半正定値性で足りる（必要十分版の `IsPsdPair`）。正値性には正定値性と `x ≠ 0` が要る。
`‖x‖ = 1` は `x ≠ 0` を出すためだけに使う。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 主張の `m_k := x^⊤(W_ℝ)^kx` | `momentWReal` |
| 【冪の実数の行列】`(W^p)_ℝ = (W_ℝ)^p` | `real_matrix_of_real_entry_matrix_preserves_power`（`A → W`, `q → p`）をそのまま引く |
| 同じ段の `I_ℝ = (W_ℝ)^0 = (W^0)_ℝ = ϱ(I)` の 3 行 | `real_identity_matrix_eq_real_matrix_of_identity` の `calc` の 3 段 |
| 【冪の対称性】6 行と単射性 | `power_of_W_real_entry_symm`（`ClaimTracePowerUpperBound.lean`）をそのまま引く |
| 【`(W_ℝ)^ax` の成分】`u^{(a)}_l = Σ_m ((W_ℝ)^a)_lm x_m` | `*ᵥ` の定義（`rfl`） |
| 【冪の分け方】`W^{a+b} = W^b(IW^a)` の 3 行 | `power_of_W_split_with_identity` の `calc` の 3 段 |
| 同じ段の `W^{a+b+1} = W^b(WW^a)` の 7 行 | `power_of_W_split_with_W` の `calc` の 7 段 |
| 同じ段の `(W_ℝ)^s = (W_ℝ)^b(C_ℝ(W_ℝ)^a)` の 5 行 | `power_of_W_real_split` の `calc` の 5 段（`C = I` は `power_of_W_real_split_with_identity`、`C = W` は `power_of_W_real_split_with_W_real`） |
| 【二つの冪で挟んだ値】10 行 | `real_bilinear_value_between_two_powers` の `calc` の 10 段（人手の `C_ℝ ∈ {I_ℝ, W_ℝ}` を任意の実数の行列 `CR` で述べる。証明は `C_ℝ` の性質を使わない） |
| 【`I_ℝ` と `W_ℝ` の正値性】`y^⊤I_ℝy` の 3 行と、`≥ 0`・`> 0` | `real_bilinear_value_of_real_identity_matrix`（3 段）・`real_identity_matrix_is_positive_semidefinite`・`real_identity_matrix_is_positive_definite` |
| 同じ段の `W_ℝ` の正定値性・半正定値性 | 仮定 `hpd`（`W_real_is_positive_definite`）と `psd_of_pd`（`W_real_is_positive_semidefinite`） |
| 同じ段の `(I_ℝ)_kl = (I_ℝ)_lk` の 3 行 | `real_identity_matrix_entry_symm` の `calc` の 3 段（対称性は `real_identity_matrix_is_symmetric`） |
| 【`(W_ℝ)^ax` は零でない】`x ≠ 0`（`‖x‖ = √0 = 0` の 2 段） | `ne_zero_of_vecNorm_eq_one` の `calc` の 2 段 |
| 同じ段の `a = 0`: `u^{(0)}_l = x_l` の 4 行 | `power_zero_of_W_real_mulVec_apply` の `calc` の 4 段 |
| 同じ段の `(W_ℝ)^{a+1} = W_ℝ(W_ℝ)^a` の 7 行 | `power_succ_of_W_real` の `calc` の 7 段 |
| 同じ段の `u^{(a+1)}_l = (W_ℝu^{(a)})_l` の 8 行 | `power_succ_of_W_real_mulVec_apply` の `calc` の 8 段 |
| 同じ段の背理法の 5 行 | `real_bilinear_value_eq_zero_of_mulVec_eq_zero` の `calc` の 5 段と `power_of_W_real_mulVec_ne_zero` の帰納法 |
| 【正値性】`m_{2a} > 0`・`m_{2a+1} > 0` の 5 行ずつ | `moment_even_pos`・`moment_odd_pos` の `calc` の 5 段 |
| 【`P = W_ℝ` の不等式】8 行 | `moment_sq_le_with_W_real` の `calc` の 8 段 |
| 【`P = I_ℝ` の不等式】8 行 | `moment_sq_le_with_real_identity` の `calc` の 8 段 |
| 奇数 `k = 2p+1`・偶数 `k = 2p+2` の 4 行ずつと添字の確認 | `moment_log_convexity` の二つの `calc` の 4 段（人手と同じく奇数・偶数の順。添字の確認は `omega`） |

- 人手の `W ∈ Mat(d,ℂ)` は Lean の `W : TensorPow M`（添字 `Conf M`、`d = 2^M`）である。一般の `W` で述べ、人手が引く主張を仮定に置く:
  `hW` は `W_is_real_symmetric_positive_definite` の実対称性、`hWRsymm`・`hpd` は `W_real_is_symmetric`・`W_real_is_positive_definite`。
  各補題は使う仮定だけを取る（`hpd` は【`(W_ℝ)^ax` は零でない】と【正値性】と【`P = W_ℝ` の不等式】、`hWRsymm` は【`P = W_ℝ` の不等式】だけ）。
  本文の `W` への当てはめは `PhysicalPartitionFunctionSandwich.lean` の `moment_log_convexity_physical`。
- 人手の `W_ℝ = ϱ(W)` は `realMatrixOfRealEntries W hW.1`、`I_ℝ` は `(1 : Matrix (Conf M) (Conf M) ℝ)`（`def_real_identity_matrix`）、
  `(W^p)_ℝ` に渡す証明は `matrix_pow_hasRealEntries`、`(AB)_ℝ` に渡す証明は `matrix_mul_hasRealEntries` である。
  `A = B` から `A_ℝ = B_ℝ` を出す行は `realMatrixOfRealEntries_congr` で書く。
- 人手の `def_real_matrix_product`・`def_real_matrix_vector_product` は Lean の `Matrix _ _ ℝ` の `*`・`*ᵥ`（成分は和で `rfl`）、
  `def_real_bilinear_value` は `dotProduct_mulVec_eq_real_bilinear_value`、`‖·‖` は `vecNorm` である。
- 人手の「`l ≠ k` の項は 0」の行は mathlib の `Finset.sum_eq_single` で書く（`ClaimTracePowerUpperBound.lean` と同じ扱い）。
  「各項は 0 以上なので和は 0 以上」「正の項があるので和は正」は mathlib の `Finset.sum_nonneg`・`Finset.sum_pos'` で書く
  （人手のこの 2 か所には参照が無い）。`ℝ` の分配則・結合則・交換則と有限和の順序の交換は `Finset.mul_sum`・`Finset.sum_mul`・`Finset.sum_comm`・`ring` で書く。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerUpperBound
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimPsdCauchySchwarz

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 人手【`I_ℝ` と `W_ℝ` の正値性】の `y^⊤I_ℝy = Σ_k y_ky_k`（3 行）。 -/
theorem real_bilinear_value_of_real_identity_matrix (y : Conf M → ℝ) :
    y ⬝ᵥ (1 : Matrix (Conf M) (Conf M) ℝ) *ᵥ y = ∑ k, y k * y k :=
  calc y ⬝ᵥ (1 : Matrix (Conf M) (Conf M) ℝ) *ᵥ y
      = ∑ k, ∑ l, y k * (1 : Matrix (Conf M) (Conf M) ℝ) k l * y l :=
        dotProduct_mulVec_eq_real_bilinear_value y y 1                      -- `def_real_bilinear_value`
    _ = ∑ k, y k * (1 : Matrix (Conf M) (Conf M) ℝ) k k * y k :=
        Finset.sum_congr rfl fun k _ => by
          rw [Finset.sum_eq_single k
            (fun l _ hlk => by rw [Matrix.one_apply_ne (Ne.symm hlk), mul_zero, zero_mul])
            (fun h => absurd (Finset.mem_univ k) h)]                       -- `l ≠ k` の項は `(I_ℝ)_kl = 0`（`def_real_identity_matrix`）なので `0`
    _ = ∑ k, y k * y k := by simp only [Matrix.one_apply_eq, mul_one]       -- `(I_ℝ)_kk = 1`（`def_real_identity_matrix`）

/-- 人手【`I_ℝ` と `W_ℝ` の正値性】の `y^⊤I_ℝy ≥ 0`（各項 `y_ky_k` は `0` 以上）。 -/
theorem real_identity_matrix_is_positive_semidefinite (y : Conf M → ℝ) :
    0 ≤ y ⬝ᵥ (1 : Matrix (Conf M) (Conf M) ℝ) *ᵥ y := by
  rw [real_bilinear_value_of_real_identity_matrix]
  exact Finset.sum_nonneg fun k _ => mul_self_nonneg (y k)

/-- 人手【`I_ℝ` と `W_ℝ` の正値性】の `y ≠ 0` なら `y^⊤I_ℝy > 0`（`y_{k_0} ≠ 0` となる `k_0` の項が正）。 -/
theorem real_identity_matrix_is_positive_definite {y : Conf M → ℝ} (hy : y ≠ 0) :
    0 < y ⬝ᵥ (1 : Matrix (Conf M) (Conf M) ℝ) *ᵥ y := by
  rw [real_bilinear_value_of_real_identity_matrix]
  obtain ⟨k0, hk0⟩ := Function.ne_iff.mp hy
  exact Finset.sum_pos' (fun k _ => mul_self_nonneg (y k))
    ⟨k0, Finset.mem_univ k0, mul_self_pos.mpr hk0⟩

/-- 人手【`I_ℝ` と `W_ℝ` の正値性】の `(I_ℝ)_kl = (I_ℝ)_lk`（3 行）。 -/
theorem real_identity_matrix_entry_symm (k l : Conf M) :
    (1 : Matrix (Conf M) (Conf M) ℝ) k l = (1 : Matrix (Conf M) (Conf M) ℝ) l k :=
  calc (1 : Matrix (Conf M) (Conf M) ℝ) k l
      = if k = l then (1 : ℝ) else 0 := Matrix.one_apply                    -- `def_real_identity_matrix`
    _ = if l = k then (1 : ℝ) else 0 := by
        by_cases h : k = l
        · rw [if_pos h, if_pos h.symm]
        · rw [if_neg h, if_neg (Ne.symm h)]                                 -- 場合分けの条件は `k = l` と `l = k` で同じ
    _ = (1 : Matrix (Conf M) (Conf M) ℝ) l k := Matrix.one_apply.symm       -- `def_real_identity_matrix`

/-- 人手【`I_ℝ` と `W_ℝ` の正値性】の `I_ℝ` は `def_real_symmetric_matrix` の意味で対称。 -/
theorem real_identity_matrix_is_symmetric : (1 : Matrix (Conf M) (Conf M) ℝ).IsSymm :=
  Matrix.IsSymm.ext fun k l => real_identity_matrix_entry_symm l k

/-- 人手【`(W_ℝ)^ax` は零でない】の `‖x‖ = 1` なら `x ≠ 0`（`x = 0` なら `‖x‖ = √0 = 0`）。 -/
theorem ne_zero_of_vecNorm_eq_one {x : Conf M → ℝ} (hx : vecNorm x = 1) : x ≠ 0 := by
  intro h0
  have h : vecNorm x = 0 :=
    calc vecNorm x
        = Real.sqrt 0 := by rw [h0, vecNorm, vecNormSq, dotProduct_zero]    -- `def_matrix_norm`（`K = ℝ`）を `x = 0` で開く（成分がすべて `0`）
      _ = 0 := Real.sqrt_zero                                               -- `definition_of_sqrt_r_positive` の `0 ≥ 0`, `0^2 = 0`
  rw [hx] at h
  exact one_ne_zero h

section General

variable (W : TensorPow M) (hW : MatrixIsRealSymmetric W)

/-- 人手の主張の `m_k := x^⊤(W_ℝ)^kx ∈ ℝ`（`W_ℝ = ϱ(W)`）。 -/
noncomputable def momentWReal (x : Conf M → ℝ) (k : ℕ) : ℝ :=
  x ⬝ᵥ (realMatrixOfRealEntries W hW.1 ^ k) *ᵥ x

include hW in
/-- 人手【冪の実数の行列】の `I_ℝ = (W_ℝ)^0 = (W^0)_ℝ = ϱ(I)`（3 行）。 -/
theorem real_identity_matrix_eq_real_matrix_of_identity :
    (1 : Matrix (Conf M) (Conf M) ℝ)
      = realMatrixOfRealEntries (1 : TensorPow M) identity_matrix_hasRealEntries_tensorPow :=
  calc (1 : Matrix (Conf M) (Conf M) ℝ)
      = realMatrixOfRealEntries W hW.1 ^ 0 := (pow_zero _).symm             -- `def_exp` (1) の `A^0 := I`（`K = ℝ`、`I` は `def_real_identity_matrix`）
    _ = realMatrixOfRealEntries (W ^ 0) (matrix_pow_hasRealEntries W hW.1 0) :=
        (real_matrix_of_real_entry_matrix_preserves_power W hW.1 0).symm     -- 【冪の実数の行列】（`p → 0`）
    _ = realMatrixOfRealEntries (1 : TensorPow M) identity_matrix_hasRealEntries_tensorPow :=
        realMatrixOfRealEntries_congr (pow_zero W) _ _                      -- `def_exp` (1) の `A^0 := I`（`K = ℂ`）

/-- 人手【冪の分け方】の `Mat(d,ℂ)` の一つ目の 3 行: `W^{a+b} = W^b(IW^a)`。 -/
theorem power_of_W_split_with_identity (a b : ℕ) : W ^ (a + b) = W ^ b * (1 * W ^ a) :=
  calc W ^ (a + b)
      = W ^ (b + a) := by rw [Nat.add_comm]                                 -- `ℤ` の加法の交換則
    _ = W ^ b * W ^ a := matrix_power_exponent_law W b a                    -- `matrix_power_exponent_law`（`p → b`, `q → a`）
    _ = W ^ b * (1 * W ^ a) := by rw [identity_matrix_mul_tensorPow]        -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 人手【冪の分け方】の `Mat(d,ℂ)` の二つ目の 7 行: `W^{a+b+1} = W^b(WW^a)`。 -/
theorem power_of_W_split_with_W (a b : ℕ) : W ^ (a + b + 1) = W ^ b * (W * W ^ a) :=
  calc W ^ (a + b + 1)
      = W ^ (b + (1 + a)) := by rw [show a + b + 1 = b + (1 + a) by omega]  -- `ℤ` で `a + b + 1 = b + (1 + a)`
    _ = W ^ b * W ^ (1 + a) := matrix_power_exponent_law W b (1 + a)       -- `matrix_power_exponent_law`（`p → b`, `q → 1 + a`）
    _ = W ^ b * (W ^ 1 * W ^ a) := by rw [matrix_power_exponent_law W 1 a]  -- `matrix_power_exponent_law`（`p → 1`, `q → a`）
    _ = W ^ b * (W ^ (0 + 1) * W ^ a) := by rw [Nat.zero_add]               -- `ℤ` で `1 = 0 + 1`
    _ = W ^ b * ((W ^ 0 * W) * W ^ a) := by rw [pow_succ W 0]               -- `def_exp` (1) の `A^{m+1} := A^mA`（`m = 0`）
    _ = W ^ b * ((1 * W) * W ^ a) := by rw [pow_zero]                       -- `def_exp` (1) の `A^0 := I`
    _ = W ^ b * (W * W ^ a) := by rw [identity_matrix_mul_tensorPow W]      -- `identity_matrix_is_left_unit_of_mat_mult`

/-- 人手【冪の分け方】の 5 行: `W^s = W^b(CW^a)`（`C ∈ Mat^re`）なら `(W_ℝ)^s = (W_ℝ)^b(C_ℝ(W_ℝ)^a)`。 -/
theorem power_of_W_real_split (C : TensorPow M) (hC : MatrixHasRealEntries C) (s a b : ℕ)
    (hs : W ^ s = W ^ b * (C * W ^ a)) :
    realMatrixOfRealEntries W hW.1 ^ s
      = realMatrixOfRealEntries W hW.1 ^ b
          * (realMatrixOfRealEntries C hC * realMatrixOfRealEntries W hW.1 ^ a) := by
  have hWa := matrix_pow_hasRealEntries W hW.1 a
  have hWb := matrix_pow_hasRealEntries W hW.1 b
  have hCWa := matrix_mul_hasRealEntries C (W ^ a) hC hWa                   -- `CW^a ∈ Mat^re`（`real_matrix_of_real_entry_matrix_preserves_product`）
  calc realMatrixOfRealEntries W hW.1 ^ s
      = realMatrixOfRealEntries (W ^ s) (matrix_pow_hasRealEntries W hW.1 s) :=
        (real_matrix_of_real_entry_matrix_preserves_power W hW.1 s).symm     -- 【冪の実数の行列】（`p → s`）
    _ = realMatrixOfRealEntries (W ^ b * (C * W ^ a)) (matrix_mul_hasRealEntries _ _ hWb hCWa) :=
        realMatrixOfRealEntries_congr hs _ _                                -- 上の二つの鎖
    _ = realMatrixOfRealEntries (W ^ b) hWb * realMatrixOfRealEntries (C * W ^ a) hCWa :=
        real_matrix_of_real_entry_matrix_preserves_product _ _ _ _          -- `real_matrix_of_real_entry_matrix_preserves_product`（`A → W^b`, `B → CW^a`）
    _ = realMatrixOfRealEntries (W ^ b) hWb
          * (realMatrixOfRealEntries C hC * realMatrixOfRealEntries (W ^ a) hWa) := by
        rw [real_matrix_of_real_entry_matrix_preserves_product C (W ^ a) hC hWa]
                                                                            -- `real_matrix_of_real_entry_matrix_preserves_product`（`A → C`, `B → W^a`）
    _ = realMatrixOfRealEntries W hW.1 ^ b
          * (realMatrixOfRealEntries C hC * realMatrixOfRealEntries W hW.1 ^ a) := by
        rw [real_matrix_of_real_entry_matrix_preserves_power W hW.1 a,
          real_matrix_of_real_entry_matrix_preserves_power W hW.1 b]        -- 【冪の実数の行列】（`p → b`, `p → a`）を二か所へ同時に

/-- 人手【冪の分け方】の一つ目: `(W_ℝ)^{a+b} = (W_ℝ)^b(I_ℝ(W_ℝ)^a)`（`C = I`、`C_ℝ = I_ℝ` は【冪の実数の行列】の 3 行）。 -/
theorem power_of_W_real_split_with_identity (a b : ℕ) :
    realMatrixOfRealEntries W hW.1 ^ (a + b)
      = realMatrixOfRealEntries W hW.1 ^ b
          * ((1 : Matrix (Conf M) (Conf M) ℝ) * realMatrixOfRealEntries W hW.1 ^ a) := by
  rw [real_identity_matrix_eq_real_matrix_of_identity W hW]
  exact power_of_W_real_split W hW 1 identity_matrix_hasRealEntries_tensorPow (a + b) a b
    (power_of_W_split_with_identity W a b)

/-- 人手【冪の分け方】の二つ目: `(W_ℝ)^{a+b+1} = (W_ℝ)^b(W_ℝ(W_ℝ)^a)`（`C = W`、`C_ℝ = W_ℝ` は `def_W_real`）。 -/
theorem power_of_W_real_split_with_W_real (a b : ℕ) :
    realMatrixOfRealEntries W hW.1 ^ (a + b + 1)
      = realMatrixOfRealEntries W hW.1 ^ b
          * (realMatrixOfRealEntries W hW.1 * realMatrixOfRealEntries W hW.1 ^ a) :=
  power_of_W_real_split W hW W hW.1 (a + b + 1) a b (power_of_W_split_with_W W a b)

/-- 人手【二つの冪で挟んだ値】の 10 行: `x^⊤((W_ℝ)^b(C_ℝ(W_ℝ)^a))x = (u^{(b)})^⊤C_ℝu^{(a)}`（`u^{(a)} := (W_ℝ)^ax`）。 -/
theorem real_bilinear_value_between_two_powers (CR : Matrix (Conf M) (Conf M) ℝ) (a b : ℕ)
    (x : Conf M → ℝ) :
    x ⬝ᵥ (realMatrixOfRealEntries W hW.1 ^ b * (CR * realMatrixOfRealEntries W hW.1 ^ a)) *ᵥ x
      = ((realMatrixOfRealEntries W hW.1 ^ b) *ᵥ x) ⬝ᵥ CR
          *ᵥ ((realMatrixOfRealEntries W hW.1 ^ a) *ᵥ x) := by
  set Pa := realMatrixOfRealEntries W hW.1 ^ a
  set Pb := realMatrixOfRealEntries W hW.1 ^ b with hPb
  calc x ⬝ᵥ (Pb * (CR * Pa)) *ᵥ x
      = ∑ i, ∑ j, x i * (Pb * (CR * Pa)) i j * x j :=
        dotProduct_mulVec_eq_real_bilinear_value x x _                      -- `def_real_bilinear_value`
    _ = ∑ i, ∑ j, x i * (∑ l, Pb i l * (CR * Pa) l j) * x j := rfl          -- `def_real_matrix_product`
    _ = ∑ i, ∑ j, x i * (∑ l, Pb i l * ∑ m, CR l m * Pa m j) * x j := rfl   -- `def_real_matrix_product`
    _ = ∑ i, ∑ j, ∑ l, ∑ m, x i * Pb i l * CR l m * Pa m j * x j := by
        simp only [Finset.mul_sum, Finset.sum_mul, mul_assoc]               -- `ℝ` の分配則と乗法の結合則
    _ = ∑ l, ∑ m, ∑ i, ∑ j, x i * Pb i l * CR l m * Pa m j * x j := by
        calc ∑ i, ∑ j, ∑ l, ∑ m, x i * Pb i l * CR l m * Pa m j * x j
            = ∑ i, ∑ l, ∑ m, ∑ j, x i * Pb i l * CR l m * Pa m j * x j :=
              Finset.sum_congr rfl fun i _ =>
                Finset.sum_comm.trans (Finset.sum_congr rfl fun l _ => Finset.sum_comm)
          _ = ∑ l, ∑ m, ∑ i, ∑ j, x i * Pb i l * CR l m * Pa m j * x j :=
              Finset.sum_comm.trans (Finset.sum_congr rfl fun l _ => Finset.sum_comm)
                                                                            -- `ℝ` の有限和の順序の交換
    _ = ∑ l, ∑ m, (∑ i, x i * Pb i l) * CR l m * (∑ j, Pa m j * x j) := by
        refine Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun m _ => ?_
        rw [Finset.sum_mul, Finset.sum_mul]
        refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun j _ => by ring
                                                                            -- `ℝ` の分配則と乗法の交換則・結合則
    _ = ∑ l, ∑ m, (∑ i, x i * Pb l i) * CR l m * (∑ j, Pa m j * x j) := by
        simp only [hPb, power_of_W_real_entry_symm W hW b _ _]              -- 【冪の対称性】の `((W_ℝ)^b)_il = ((W_ℝ)^b)_li`
    _ = ∑ l, ∑ m, (∑ i, Pb l i * x i) * CR l m * (∑ j, Pa m j * x j) := by
        simp only [mul_comm (x _) (Pb _ _)]                                 -- `ℝ` の乗法の交換則
    _ = ∑ l, ∑ m, (Pb *ᵥ x) l * CR l m * (Pa *ᵥ x) m := rfl                 -- 【`(W_ℝ)^ax` の成分】を `a` と `b` へ同時に
    _ = (Pb *ᵥ x) ⬝ᵥ CR *ᵥ (Pa *ᵥ x) :=
        (dotProduct_mulVec_eq_real_bilinear_value _ _ CR).symm              -- `def_real_bilinear_value`

/-- 人手【`(W_ℝ)^ax` は零でない】の `a = 0` の 4 行: `u^{(0)}_l = x_l`。 -/
theorem power_zero_of_W_real_mulVec_apply (x : Conf M → ℝ) (l : Conf M) :
    ((realMatrixOfRealEntries W hW.1 ^ 0) *ᵥ x) l = x l :=
  calc ((realMatrixOfRealEntries W hW.1 ^ 0) *ᵥ x) l
      = ∑ m, (realMatrixOfRealEntries W hW.1 ^ 0) l m * x m := rfl          -- 【`(W_ℝ)^ax` の成分】（`a → 0`）
    _ = ∑ m, (1 : Matrix (Conf M) (Conf M) ℝ) l m * x m := by rw [pow_zero]  -- `def_exp` (1) の `A^0 := I`（`K = ℝ`）
    _ = (1 : Matrix (Conf M) (Conf M) ℝ) l l * x l := by
        rw [Finset.sum_eq_single l
          (fun m _ hml => by rw [Matrix.one_apply_ne (Ne.symm hml), zero_mul])
          (fun h => absurd (Finset.mem_univ l) h)]                         -- `m ≠ l` の項は `(I_ℝ)_lm = 0`（`def_real_identity_matrix`）なので `0`
    _ = x l := by rw [Matrix.one_apply_eq, one_mul]                         -- `(I_ℝ)_ll = 1`（`def_real_identity_matrix`）

/-- 人手【`(W_ℝ)^ax` は零でない】の 7 行: `(W_ℝ)^{a+1} = W_ℝ(W_ℝ)^a`。 -/
theorem power_succ_of_W_real (a : ℕ) :
    realMatrixOfRealEntries W hW.1 ^ (a + 1)
      = realMatrixOfRealEntries W hW.1 * realMatrixOfRealEntries W hW.1 ^ a := by
  have hWa := matrix_pow_hasRealEntries W hW.1 a
  have hWWa := matrix_mul_hasRealEntries W (W ^ a) hW.1 hWa
  calc realMatrixOfRealEntries W hW.1 ^ (a + 1)
      = realMatrixOfRealEntries (W ^ (a + 1)) (matrix_pow_hasRealEntries W hW.1 (a + 1)) :=
        (real_matrix_of_real_entry_matrix_preserves_power W hW.1 (a + 1)).symm  -- 【冪の実数の行列】（`p → a + 1`）
    _ = realMatrixOfRealEntries (W ^ (a + 0 + 1)) (matrix_pow_hasRealEntries W hW.1 (a + 0 + 1)) :=
        realMatrixOfRealEntries_congr (by rw [Nat.add_zero]) _ _            -- `ℤ` で `a + 1 = a + 0 + 1`
    _ = realMatrixOfRealEntries (W ^ 0 * (W * W ^ a))
          (matrix_mul_hasRealEntries _ _ (matrix_pow_hasRealEntries W hW.1 0) hWWa) :=
        realMatrixOfRealEntries_congr (power_of_W_split_with_W W a 0) _ _   -- 【冪の分け方】の `Mat(d,ℂ)` の二つ目の鎖（`b → 0`）
    _ = realMatrixOfRealEntries (1 * (W * W ^ a))
          (matrix_mul_hasRealEntries _ _ identity_matrix_hasRealEntries_tensorPow hWWa) :=
        realMatrixOfRealEntries_congr (by rw [pow_zero]) _ _                -- `def_exp` (1) の `A^0 := I`（`K = ℂ`）
    _ = realMatrixOfRealEntries (W * W ^ a) hWWa :=
        realMatrixOfRealEntries_congr (identity_matrix_mul_tensorPow _) _ _  -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = realMatrixOfRealEntries W hW.1 * realMatrixOfRealEntries (W ^ a) hWa :=
        real_matrix_of_real_entry_matrix_preserves_product _ _ _ _          -- `real_matrix_of_real_entry_matrix_preserves_product`（`A → W`, `B → W^a`）
    _ = realMatrixOfRealEntries W hW.1 * realMatrixOfRealEntries W hW.1 ^ a := by
        rw [real_matrix_of_real_entry_matrix_preserves_power W hW.1 a]      -- 【冪の実数の行列】（`p → a`）

/-- 人手【`(W_ℝ)^ax` は零でない】の 8 行: `u^{(a+1)}_l = (W_ℝu^{(a)})_l`。 -/
theorem power_succ_of_W_real_mulVec_apply (a : ℕ) (x : Conf M → ℝ) (l : Conf M) :
    ((realMatrixOfRealEntries W hW.1 ^ (a + 1)) *ᵥ x) l
      = (realMatrixOfRealEntries W hW.1 *ᵥ ((realMatrixOfRealEntries W hW.1 ^ a) *ᵥ x)) l := by
  set WR := realMatrixOfRealEntries W hW.1
  calc ((WR ^ (a + 1)) *ᵥ x) l
      = ∑ m, (WR ^ (a + 1)) l m * x m := rfl                                -- 【`(W_ℝ)^ax` の成分】（`a → a + 1`）
    _ = ∑ m, (WR * WR ^ a) l m * x m := by rw [power_succ_of_W_real W hW a] -- 上の式変形
    _ = ∑ m, (∑ n, WR l n * (WR ^ a) n m) * x m := rfl                      -- `def_real_matrix_product`
    _ = ∑ m, ∑ n, WR l n * (WR ^ a) n m * x m := by
        simp only [Finset.sum_mul]                                          -- `ℝ` の分配則と乗法の結合則
    _ = ∑ n, ∑ m, WR l n * (WR ^ a) n m * x m := Finset.sum_comm            -- `ℝ` の有限和の順序の交換
    _ = ∑ n, WR l n * ∑ m, (WR ^ a) n m * x m := by
        simp only [Finset.mul_sum, mul_assoc]                               -- `ℝ` の分配則と乗法の結合則
    _ = ∑ n, WR l n * ((WR ^ a) *ᵥ x) n := rfl                              -- 【`(W_ℝ)^ax` の成分】
    _ = (WR *ᵥ ((WR ^ a) *ᵥ x)) l := rfl                                    -- `def_real_matrix_vector_product`（`P → W_ℝ`, `x → u^{(a)}`）

/-- 人手【`(W_ℝ)^ax` は零でない】の背理法の 5 行: `W_ℝu = 0` なら `u^⊤W_ℝu = 0`。 -/
theorem real_bilinear_value_eq_zero_of_mulVec_eq_zero (u : Conf M → ℝ)
    (hu : realMatrixOfRealEntries W hW.1 *ᵥ u = 0) :
    u ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ u = 0 := by
  set WR := realMatrixOfRealEntries W hW.1
  calc u ⬝ᵥ WR *ᵥ u
      = ∑ k, ∑ l, u k * WR k l * u l := dotProduct_mulVec_eq_real_bilinear_value u u WR
                                                                            -- `def_real_bilinear_value`
    _ = ∑ k, u k * ∑ l, WR k l * u l := by
        simp only [Finset.mul_sum, mul_assoc]                               -- `ℝ` の分配則と乗法の結合則
    _ = ∑ k, u k * (WR *ᵥ u) k := rfl                                       -- `def_real_matrix_vector_product`
    _ = ∑ k, u k * (0 : Conf M → ℝ) k := by rw [hu]                         -- `W_ℝu = 0` という仮定
    _ = 0 := by simp only [Pi.zero_apply, mul_zero, Finset.sum_const_zero]  -- `ℝ` で `r·0 = 0` と `0` の有限和

/-- 人手【`(W_ℝ)^ax` は零でない】: `x ≠ 0` なら `u^{(a)} := (W_ℝ)^ax ≠ 0`（`a` の帰納法。`W_ℝ` の正定値性 `hpd` を使う）。 -/
theorem power_of_W_real_mulVec_ne_zero
    (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x) {x : Conf M → ℝ} (hx : x ≠ 0) :
    ∀ a : ℕ, (realMatrixOfRealEntries W hW.1 ^ a) *ᵥ x ≠ 0
  | 0 => by
      have h0 : (realMatrixOfRealEntries W hW.1 ^ 0) *ᵥ x = x :=
        funext (power_zero_of_W_real_mulVec_apply W hW x)                  -- `u^{(0)} = x`
      rw [h0]; exact hx
  | a + 1 => by
      have hsucc : (realMatrixOfRealEntries W hW.1 ^ (a + 1)) *ᵥ x
          = realMatrixOfRealEntries W hW.1 *ᵥ ((realMatrixOfRealEntries W hW.1 ^ a) *ᵥ x) :=
        funext (power_succ_of_W_real_mulVec_apply W hW a x)                -- `u^{(a+1)} = W_ℝu^{(a)}`
      rw [hsucc]
      intro h0
      have hzero := real_bilinear_value_eq_zero_of_mulVec_eq_zero W hW _ h0  -- 背理法の 5 行
      have hpos := hpd _ (power_of_W_real_mulVec_ne_zero hpd hx a)          -- 帰納法の仮定と【`I_ℝ` と `W_ℝ` の正値性】
      rw [hzero] at hpos
      exact lt_irrefl 0 hpos

/-- 人手【正値性】の `k = 2a` の 5 行: `m_{2a} > 0`。 -/
theorem moment_even_pos
    (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x) {x : Conf M → ℝ} (hx : x ≠ 0) (a : ℕ) :
    momentWReal W hW x (2 * a) > 0 := by
  set WR := realMatrixOfRealEntries W hW.1
  calc momentWReal W hW x (2 * a)
      = x ⬝ᵥ (WR ^ (2 * a)) *ᵥ x := rfl                                     -- `m_k := x^⊤(W_ℝ)^kx`
    _ = x ⬝ᵥ (WR ^ (a + a)) *ᵥ x := by rw [Nat.two_mul]                     -- `ℤ` で `2a = a + a`
    _ = x ⬝ᵥ (WR ^ a * ((1 : Matrix (Conf M) (Conf M) ℝ) * WR ^ a)) *ᵥ x := by
        rw [power_of_W_real_split_with_identity W hW a a]                   -- 【冪の分け方】の一つ目（`b → a`）
    _ = ((WR ^ a) *ᵥ x) ⬝ᵥ (1 : Matrix (Conf M) (Conf M) ℝ) *ᵥ ((WR ^ a) *ᵥ x) :=
        real_bilinear_value_between_two_powers W hW 1 a a x                 -- 【二つの冪で挟んだ値】（`b → a`, `C_ℝ = I_ℝ`）
    _ > 0 :=
        real_identity_matrix_is_positive_definite (power_of_W_real_mulVec_ne_zero W hW hpd hx a)
                                                                            -- 【`(W_ℝ)^ax` は零でない】と【`I_ℝ` と `W_ℝ` の正値性】

/-- 人手【正値性】の `k = 2a+1` の 5 行: `m_{2a+1} > 0`。 -/
theorem moment_odd_pos
    (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x) {x : Conf M → ℝ} (hx : x ≠ 0) (a : ℕ) :
    momentWReal W hW x (2 * a + 1) > 0 := by
  set WR := realMatrixOfRealEntries W hW.1
  calc momentWReal W hW x (2 * a + 1)
      = x ⬝ᵥ (WR ^ (2 * a + 1)) *ᵥ x := rfl                                 -- `m_k := x^⊤(W_ℝ)^kx`
    _ = x ⬝ᵥ (WR ^ (a + a + 1)) *ᵥ x := by rw [Nat.two_mul]                 -- `ℤ` で `2a + 1 = a + a + 1`
    _ = x ⬝ᵥ (WR ^ a * (WR * WR ^ a)) *ᵥ x := by
        rw [power_of_W_real_split_with_W_real W hW a a]                     -- 【冪の分け方】の二つ目（`b → a`）
    _ = ((WR ^ a) *ᵥ x) ⬝ᵥ WR *ᵥ ((WR ^ a) *ᵥ x) :=
        real_bilinear_value_between_two_powers W hW WR a a x                -- 【二つの冪で挟んだ値】（`b → a`, `C_ℝ = W_ℝ`）
    _ > 0 := hpd _ (power_of_W_real_mulVec_ne_zero W hW hpd hx a)           -- 【`(W_ℝ)^ax` は零でない】と【`I_ℝ` と `W_ℝ` の正値性】

/-- 人手【`P = W_ℝ` の不等式】の 8 行: `(m_{a+b+1})^2 ≤ m_{2a+1}m_{2b+1}`。 -/
theorem moment_sq_le_with_W_real
    (hWRsymm : (realMatrixOfRealEntries W hW.1).IsSymm)
    (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x)
    (x : Conf M → ℝ) (a b : ℕ) :
    momentWReal W hW x (a + b + 1) ^ 2
      ≤ momentWReal W hW x (2 * a + 1) * momentWReal W hW x (2 * b + 1) := by
  set WR := realMatrixOfRealEntries W hW.1
  calc momentWReal W hW x (a + b + 1) ^ 2
      = (x ⬝ᵥ (WR ^ (a + b + 1)) *ᵥ x) ^ 2 := rfl                           -- `m_k := x^⊤(W_ℝ)^kx`
    _ = (x ⬝ᵥ (WR ^ b * (WR * WR ^ a)) *ᵥ x) ^ 2 := by
        rw [power_of_W_real_split_with_W_real W hW a b]                     -- 【冪の分け方】の二つ目
    _ = (((WR ^ b) *ᵥ x) ⬝ᵥ WR *ᵥ ((WR ^ a) *ᵥ x)) ^ 2 := by
        rw [real_bilinear_value_between_two_powers W hW WR a b x]           -- 【二つの冪で挟んだ値】（`C_ℝ = W_ℝ`）
    _ ≤ (((WR ^ a) *ᵥ x) ⬝ᵥ WR *ᵥ ((WR ^ a) *ᵥ x))
          * (((WR ^ b) *ᵥ x) ⬝ᵥ WR *ᵥ ((WR ^ b) *ᵥ x)) :=
        psd_cauchy_schwarz hWRsymm (psd_of_pd hpd) _ _                      -- `psd_cauchy_schwarz`（`P → W_ℝ`, `x → u^{(a)}`, `y → u^{(b)}`）
    _ = (x ⬝ᵥ (WR ^ a * (WR * WR ^ a)) *ᵥ x) * (x ⬝ᵥ (WR ^ b * (WR * WR ^ b)) *ᵥ x) := by
        rw [real_bilinear_value_between_two_powers W hW WR a a x,
          real_bilinear_value_between_two_powers W hW WR b b x]             -- 【二つの冪で挟んだ値】を `(a,a)`, `(b,b)` で両因子へ同時に
    _ = (x ⬝ᵥ (WR ^ (a + a + 1)) *ᵥ x) * (x ⬝ᵥ (WR ^ (b + b + 1)) *ᵥ x) := by
        rw [power_of_W_real_split_with_W_real W hW a a,
          power_of_W_real_split_with_W_real W hW b b]                       -- 【冪の分け方】の二つ目を両因子へ同時に
    _ = (x ⬝ᵥ (WR ^ (2 * a + 1)) *ᵥ x) * (x ⬝ᵥ (WR ^ (2 * b + 1)) *ᵥ x) := by
        rw [Nat.two_mul, Nat.two_mul]                                       -- `ℤ` で `a + a + 1 = 2a + 1`, `b + b + 1 = 2b + 1`
    _ = momentWReal W hW x (2 * a + 1) * momentWReal W hW x (2 * b + 1) := rfl
                                                                            -- `m_k := x^⊤(W_ℝ)^kx` を両因子へ同時に

/-- 人手【`P = I_ℝ` の不等式】の 8 行: `(m_{a+b})^2 ≤ m_{2a}m_{2b}`。 -/
theorem moment_sq_le_with_real_identity (x : Conf M → ℝ) (a b : ℕ) :
    momentWReal W hW x (a + b) ^ 2
      ≤ momentWReal W hW x (2 * a) * momentWReal W hW x (2 * b) := by
  set WR := realMatrixOfRealEntries W hW.1
  set I : Matrix (Conf M) (Conf M) ℝ := 1
  calc momentWReal W hW x (a + b) ^ 2
      = (x ⬝ᵥ (WR ^ (a + b)) *ᵥ x) ^ 2 := rfl                               -- `m_k := x^⊤(W_ℝ)^kx`
    _ = (x ⬝ᵥ (WR ^ b * (I * WR ^ a)) *ᵥ x) ^ 2 := by
        rw [power_of_W_real_split_with_identity W hW a b]                   -- 【冪の分け方】の一つ目
    _ = (((WR ^ b) *ᵥ x) ⬝ᵥ I *ᵥ ((WR ^ a) *ᵥ x)) ^ 2 := by
        rw [real_bilinear_value_between_two_powers W hW I a b x]            -- 【二つの冪で挟んだ値】（`C_ℝ = I_ℝ`）
    _ ≤ (((WR ^ a) *ᵥ x) ⬝ᵥ I *ᵥ ((WR ^ a) *ᵥ x))
          * (((WR ^ b) *ᵥ x) ⬝ᵥ I *ᵥ ((WR ^ b) *ᵥ x)) :=
        psd_cauchy_schwarz real_identity_matrix_is_symmetric
          real_identity_matrix_is_positive_semidefinite _ _                 -- `psd_cauchy_schwarz`（`P → I_ℝ`, `x → u^{(a)}`, `y → u^{(b)}`）
    _ = (x ⬝ᵥ (WR ^ a * (I * WR ^ a)) *ᵥ x) * (x ⬝ᵥ (WR ^ b * (I * WR ^ b)) *ᵥ x) := by
        rw [real_bilinear_value_between_two_powers W hW I a a x,
          real_bilinear_value_between_two_powers W hW I b b x]              -- 【二つの冪で挟んだ値】を `(a,a)`, `(b,b)` で両因子へ同時に
    _ = (x ⬝ᵥ (WR ^ (a + a)) *ᵥ x) * (x ⬝ᵥ (WR ^ (b + b)) *ᵥ x) := by
        rw [power_of_W_real_split_with_identity W hW a a,
          power_of_W_real_split_with_identity W hW b b]                     -- 【冪の分け方】の一つ目を両因子へ同時に
    _ = (x ⬝ᵥ (WR ^ (2 * a)) *ᵥ x) * (x ⬝ᵥ (WR ^ (2 * b)) *ᵥ x) := by
        rw [Nat.two_mul, Nat.two_mul]                                       -- `ℤ` で `a + a = 2a`, `b + b = 2b`
    _ = momentWReal W hW x (2 * a) * momentWReal W hW x (2 * b) := rfl      -- `m_k := x^⊤(W_ℝ)^kx` を両因子へ同時に

/-- **人手 `moment_log_convexity`**: 単位ベクトル `x`（`‖x‖ = 1`）について、すべての `k ≥ 0` で `m_k > 0`、
すべての `k ≥ 1` で `m_k^2 ≤ m_{k-1}m_{k+1}`（`m_k := x^⊤(W_ℝ)^kx`）。 -/
theorem moment_log_convexity
    (hWRsymm : (realMatrixOfRealEntries W hW.1).IsSymm)
    (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x)
    {x : Conf M → ℝ} (hx : vecNorm x = 1) :
    (∀ k : ℕ, 0 < momentWReal W hW x k)
      ∧ ∀ k : ℕ, 1 ≤ k →
          momentWReal W hW x k ^ 2 ≤ momentWReal W hW x (k - 1) * momentWReal W hW x (k + 1) := by
  have hx0 : x ≠ 0 := ne_zero_of_vecNorm_eq_one hx                          -- 【`(W_ℝ)^ax` は零でない】の `x ≠ 0`
  refine ⟨fun k => ?_, fun k hk => ?_⟩
  · rcases Nat.even_or_odd' k with ⟨a, rfl | rfl⟩                          -- 【正値性】`k = 2a` か `k = 2a + 1`
    · exact moment_even_pos W hW hpd hx0 a
    · exact moment_odd_pos W hW hpd hx0 a
  · obtain ⟨p, hp | hp⟩ : ∃ p, k = 2 * p + 1 ∨ k = 2 * p + 2 := ⟨(k - 1) / 2, by omega⟩
                                                                            -- `k ≥ 1` なので `p = ⌊(k−1)/2⌋ ∈ ℤ_{≥0}`
    · -- 奇数 `k = 2p + 1`、`(a, b) = (p, p + 1)`
      calc momentWReal W hW x k ^ 2
          = momentWReal W hW x (p + (p + 1)) ^ 2 := by
            rw [show k = p + (p + 1) by omega]                              -- `k = 2p + 1 = a + b`（添字の確認）
        _ ≤ momentWReal W hW x (2 * p) * momentWReal W hW x (2 * (p + 1)) :=
            moment_sq_le_with_real_identity W hW x p (p + 1)                -- 【`P = I_ℝ` の不等式】
        _ = momentWReal W hW x (2 * p) * momentWReal W hW x (2 * p + 2) := by
            rw [show 2 * (p + 1) = 2 * p + 2 by omega]                      -- `a = p`, `b = p + 1`（`2(p+1) = 2p + 2`）
        _ = momentWReal W hW x (k - 1) * momentWReal W hW x (k + 1) := by
            rw [show 2 * p + 2 = k + 1 by omega, show 2 * p = k - 1 by omega]  -- `k = 2p + 1`（添字の確認）
    · -- 偶数 `k = 2p + 2`、`(a, b) = (p, p + 1)`
      calc momentWReal W hW x k ^ 2
          = momentWReal W hW x (p + (p + 1) + 1) ^ 2 := by
            rw [show k = p + (p + 1) + 1 by omega]                          -- `k = 2p + 2 = a + b + 1`（添字の確認）
        _ ≤ momentWReal W hW x (2 * p + 1) * momentWReal W hW x (2 * (p + 1) + 1) :=
            moment_sq_le_with_W_real W hW hWRsymm hpd x p (p + 1)           -- 【`P = W_ℝ` の不等式】
        _ = momentWReal W hW x (2 * p + 1) * momentWReal W hW x (2 * p + 3) := by
            rw [show 2 * (p + 1) + 1 = 2 * p + 3 by omega]                  -- `a = p`, `b = p + 1`（`2(p+1) + 1 = 2p + 3`）
        _ = momentWReal W hW x (k - 1) * momentWReal W hW x (k + 1) := by
            rw [show 2 * p + 1 = k - 1 by omega, show 2 * p + 3 = k + 1 by omega]  -- `k = 2p + 2`（添字の確認）

end General

end Ising2D
