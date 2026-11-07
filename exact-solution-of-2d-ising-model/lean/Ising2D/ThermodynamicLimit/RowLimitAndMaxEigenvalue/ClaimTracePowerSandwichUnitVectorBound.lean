/-
# `trace_power_sandwich` の下からの評価の前半: 単位ベクトル `x` で `(x^⊤W_ℝx)^n ≤ Σ_k ((W_ℝ)^n)_kk`（具体版）

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_008_claim_trace_power_sandwich`、ラベル **`trace_power_sandwich`**）の証明のうち、
【冪の実数の行列】の `(W_ℝ)^1 = W_ℝ`、【`(W_ℝ)^n` の成分の対称性】、【`(W_ℝ)^n` の半正定値性】、【`(W_ℝ)^n` の成分の評価】、
【単位ベクトルでの評価】の段。残りの【正の実数の冪の比較】・【上限への移行】と主張そのものは `ClaimTracePowerSandwich.lean` にある。

必要十分版: `Ising2D.NecSuf.IsPdPair.moment_ratio_le`・`moment_pow_le`（【単位ベクトルでの評価】の `m_k ≥ m_1m_{k-1}`・`m_p ≥ m_1^p`。
`Ising2D/NecSuf/RayleighMoments.lean`）。`m_p ≥ m_1^p` の手順は同じで、`m_k ≥ m_1m_{k-1}` の帰納法の一歩は、人手と具体版が商 `m_k/m_{k-1}` を経るのに対し、
必要十分版は `m_k` を掛けてから約す。具体版と同じ型の主張を必要十分版の特殊化として得ることは
`ClaimTracePowerSandwichUnitVectorBoundFromNecSuf.lean` の `moment_ge_moment_one_pow_of_necSuf` が記録している。
ほかの段には必要十分版を置かない。【`(W_ℝ)^n` の半正定値性】は `moment_log_convexity` の正値性を正規化したベクトルへ当てるだけで、
必要十分版の側の `NecSuf.IsPsdPair.moment_nonneg` は主張は同じだが手順が違う（指数の偶奇に分ける）ので、この段の必要十分版としては置かない。【`(W_ℝ)^n` の成分の評価】と `m_n ≤ T` は、
標準基底 `e_k` と有限の添字の上の対角成分の和（トレース）に固有である。`‖w‖ = 1` は `def_matrix_norm` を開いて `ℝ` の四則で 1 にすることに尽きる。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 【冪の実数の行列】の `(W_ℝ)^1 = W_ℝ` の 6 行 | `power_one_of_W_real` の `calc` の 6 段 |
| 【`(W_ℝ)^n` の成分の対称性】6 行と単射性 | `power_of_W_real_entry_symm`（`ClaimTracePowerUpperBound.lean`、同じ 6 行の鎖）をそのまま引く |
| 【`(W_ℝ)^n` の半正定値性】`z = 0` の場合 | `power_of_W_real_is_positive_semidefinite` の `z = 0` の `calc` の 2 段 |
| 同じ段の `‖z‖^2 ≥ |z_{j_0}|^2 > 0` の 3 行 | `norm_sq_pos_of_component_ne_zero` の `calc` の 3 段 |
| 同じ段の `‖z‖ > 0` | `norm_pos_of_component_ne_zero` |
| 同じ段の `‖w‖ = 1` の 9 行（`w_i := ‖z‖^{-1}z_i`） | `norm_of_inverse_norm_multiple_is_one` の `calc` の 9 段 |
| 同じ段の `z^⊤(W_ℝ)^nz > 0` の 5 行 | `power_of_W_real_is_positive_semidefinite` の `z ≠ 0` の `calc` の 5 段 |
| 【`(W_ℝ)^n` の成分の評価】の各二重和の値（`(e_q)_i` は `i = q` でだけ `1`） | `standard_basis_real_bilinear_value` |
| 同じ段の 7 行と移項 | `power_of_W_real_entry_bound` の `calc` の 7 段と移項 |
| 【単位ベクトルでの評価】`Σ_k x_k^2 = 1` の 3 行 | `sum_sq_of_unit_vector` の `calc` の 3 段 |
| 同じ段の `m_0 = 1` の 7 行 | `moment_zero_eq_one` の `calc` の 7 段 |
| 同じ段の `m_1 = x^⊤W_ℝx` の 2 行 | `moment_one_eq` の `calc` の 2 段 |
| 同じ段の `m_k ≥ m_1m_{k-1}`（`k` の帰納法。`m_k/m_{k-1} ≥ m_1` の 2 行と `m_{k+1}` の 5 行） | `moment_ge_moment_one_mul_prev` の帰納法と二つの `calc` |
| 同じ段の `m_p ≥ m_1^p`（`p` の帰納法の 4 行） | `moment_ge_moment_one_pow` の帰納法と `calc` の 4 段 |
| 同じ段の `m_n ≤ T` の 8 行 | `moment_le_trace_of_power` の `calc` の 8 段 |
| 同じ段の `(x^⊤W_ℝx)^n ≤ T` の 3 行 | `real_bilinear_value_pow_le_trace_of_power` の `calc` の 3 段 |

- 人手の `W ∈ Mat(d,ℂ)` は Lean の `W : TensorPow M`（添字 `Conf M`。`d = 2_ℤ^M` に当たるのは `ℕ` の等式 `card_conf_nat`、`d ∈ ℤ_{≥1}` は人手 `power_of_two_in_integers_is_at_least_one`）である。`ClaimTracePowerUpperBound.lean`・
  `ClaimMomentLogConvexity.lean` と同じく一般の `W` で述べ、人手が引く主張を仮定に置く: `hW` は `W_is_real_symmetric_positive_definite` の実対称性、
  `hWRsymm`・`hpd` は `moment_log_convexity` が要る `W_real_is_symmetric`・`W_real_is_positive_definite`。
- 人手の `W_ℝ = ϱ(W)` は `realMatrixOfRealEntries W hW.1`、`m_k := x^⊤(W_ℝ)^kx` は `momentWReal`、`e_q` は `Pi.single q 1`、
  `T := Σ_k ((W_ℝ)^n)_kk` は `∑ k, (W_ℝ ^ n) k k` である。`‖·‖` は `vecNorm`（`def_matrix_norm` の `K = ℝ`）。
- 人手の「`i ≠ q` の項は 0」の行は、`ClaimTracePowerUpperBound.lean` と同じく mathlib の `Finset.sum_eq_single` で書く。
- 人手の `finite_sum_of_real_scalar_multiples` を当てる行のうち、【`(W_ℝ)^n` の成分の評価】の 4 つの項へ分ける行は mathlib の `Finset.mul_sum`・
  `Finset.sum_sub_distrib`・`Finset.sum_add_distrib` で、`m_n ≤ T` の外側の和へ当てる行は `Finset.sum_mul` で書く（掛ける数が右にあるため）。
  `m_n ≤ T` の「有限和の加法の交換則・結合則」の行（人手に参照が無い）は `Finset.sum_add_distrib` で書く。
- 本文の `W` への当てはめ（`*_physical`）は段ごとには置かない。主張 `trace_power_sandwich` の当てはめ `trace_power_sandwich_physical`（`PhysicalPartitionFunctionSandwich.lean`）が、ここの段をまとめて本文の `W` へ渡す。
- 人手の `ℝ` の分配則・結合則・交換則と、同類項の加法は `ring` で、商と順序の行は mathlib の `div_le_div_of_nonneg_right`・
  `mul_div_cancel_*`・`mul_le_mul_of_nonneg_left` で書く（人手のこれらの行には参照が無い）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimMomentLogConvexity

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 人手【`(W_ℝ)^n` の半正定値性】の `z_{j_0} ≠ 0` なら `‖z‖^2 > 0`（3 行）。 -/
theorem norm_sq_pos_of_component_ne_zero {z : Conf M → ℝ} {j0 : Conf M} (hj0 : z j0 ≠ 0) :
    vecNorm z ^ 2 > 0 :=
  calc vecNorm z ^ 2
      = ∑ j, |z j| ^ 2 := vecNorm_sq_eq_sum_abs_sq z                        -- `def_matrix_norm` と `definition_of_sqrt_r_positive` の `(√b)^2 = b`
    _ ≥ |z j0| ^ 2 :=
        finite_sum_of_nonnegative_reals_ge_term_fintype (fun j => |z j| ^ 2)
          (fun _ => sq_nonneg _) j0                                         -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`a_j → |z_j|^2`, `k → j_0`）
    _ > 0 := by
        rw [sq]; exact mul_pos (abs_pos.mpr hj0) (abs_pos.mpr hj0)          -- `z_{j_0} ≠ 0` なので `|z_{j_0}| > 0` で、`def_power_of_real_number` で `|z_{j_0}|^2 = |z_{j_0}||z_{j_0}|` は正の実数の積

/-- 人手【`(W_ℝ)^n` の半正定値性】の `‖z‖ ≥ 0` と `‖z‖ ≠ 0` から `‖z‖ > 0`。 -/
theorem norm_pos_of_component_ne_zero {z : Conf M → ℝ} {j0 : Conf M} (hj0 : z j0 ≠ 0) :
    vecNorm z > 0 := by
  have hge : 0 ≤ vecNorm z := vecNorm_nonneg z                              -- `def_matrix_norm`
  have hne : vecNorm z ≠ 0 := by                                            -- `‖z‖ = 0` なら `‖z‖^2 = 0^2 = 0`（`def_power_of_real_number`）で `‖z‖^2 > 0` に反する
    intro h
    have h2 := norm_sq_pos_of_component_ne_zero hj0
    rw [h, zero_pow two_ne_zero] at h2
    exact lt_irrefl 0 h2
  exact lt_of_le_of_ne hge (Ne.symm hne)

/-- 人手【`(W_ℝ)^n` の半正定値性】の `w_i := ‖z‖^{-1}z_i` なら `‖w‖ = 1`（9 行）。 -/
theorem norm_of_inverse_norm_multiple_is_one {z : Conf M → ℝ} {j0 : Conf M} (hj0 : z j0 ≠ 0)
    (w : Conf M → ℝ) (hw : ∀ i, w i = (vecNorm z)⁻¹ * z i) :
    vecNorm w = 1 := by
  have hne : vecNorm z ≠ 0 := (norm_pos_of_component_ne_zero hj0).ne'
  calc vecNorm w
      = Real.sqrt (∑ i, |w i| ^ 2) := by
        rw [vecNorm, vecNormSq_eq_sum]
        simp only [square_of_real_absolute_value]                           -- `def_matrix_norm`。`square_of_real_absolute_value` は書き方の差を埋める段
    _ = Real.sqrt (∑ i, ((vecNorm z)⁻¹ * z i) ^ 2) := by
        simp only [hw, square_of_real_absolute_value]                       -- `w_i := ‖z‖^{-1}z_i` と、`square_of_real_absolute_value` の `|q|^2 = q^2` を各項へ同時に
    _ = Real.sqrt (∑ i, ((vecNorm z)⁻¹) ^ 2 * z i ^ 2) := by
        congr 1
        exact Finset.sum_congr rfl fun i _ => by rw [sq, sq, sq]; ring      -- `def_power_of_real_number` で `(st)^2 = (st)(st)`, `s^2 = ss`, `t^2 = tt` と乗法の交換則・結合則を各項へ同時に
    _ = Real.sqrt (((vecNorm z)⁻¹) ^ 2 * ∑ i, z i ^ 2) := by
        rw [finite_sum_of_real_scalar_multiples_fintype]                    -- `finite_sum_of_real_scalar_multiples`（`c → (‖z‖^{-1})^2`）
    _ = Real.sqrt (((vecNorm z)⁻¹) ^ 2 * ∑ i, |z i| ^ 2) := by
        simp only [square_of_real_absolute_value]                           -- `square_of_real_absolute_value` の `|q|^2 = q^2` を各項へ同時に
    _ = Real.sqrt (((vecNorm z)⁻¹) ^ 2 * vecNorm z ^ 2) := by
        rw [vecNorm_sq_eq_sum_abs_sq z]                                     -- 上の `‖z‖^2 = Σ_j|z_j|^2`
    _ = Real.sqrt (((vecNorm z)⁻¹ * vecNorm z) ^ 2) := by
        congr 1; rw [sq, sq, sq]; ring                                      -- `def_power_of_real_number` で `t^2 = tt`（`t → ‖z‖^{-1}, ‖z‖, ‖z‖^{-1}‖z‖`）と乗法の交換則・結合則
    _ = Real.sqrt 1 := by
        rw [inv_mul_cancel₀ hne, one_pow]                                   -- `‖z‖ ≠ 0` なので `‖z‖^{-1}‖z‖ = 1`、`def_power_of_real_number` で `1^2 = 1`
    _ = 1 := Real.sqrt_one                                                  -- `definition_of_sqrt_r_positive` の `1 ≥ 0`, `1^2 = 1`

/-- 人手【`(W_ℝ)^n` の成分の評価】の各二重和: `Σ_iΣ_j (e_q)_iP_ij(e_r)_j = P_qr`
（`(e_q)_i` は `i = q` でだけ `1` でほかは `0` なので、`0` でない項は一つだけ）。 -/
theorem standard_basis_real_bilinear_value (P : Matrix (Conf M) (Conf M) ℝ) (q r : Conf M) :
    ∑ i, ∑ j, (Pi.single q (1 : ℝ) : Conf M → ℝ) i * P i j * (Pi.single r (1 : ℝ) : Conf M → ℝ) j
      = P q r := by
  rw [Finset.sum_eq_single q
    (fun i _ hiq => by simp only [Pi.single_eq_of_ne hiq, zero_mul, Finset.sum_const_zero])
    (fun h => absurd (Finset.mem_univ q) h)]
  rw [Finset.sum_eq_single r
    (fun j _ hjr => by rw [Pi.single_eq_of_ne hjr, mul_zero])
    (fun h => absurd (Finset.mem_univ r) h)]
  rw [Pi.single_eq_same, Pi.single_eq_same, one_mul, mul_one]

section General

variable (W : TensorPow M) (hW : MatrixIsRealSymmetric W)

/-- 人手【冪の実数の行列】の `(W_ℝ)^1 = W_ℝ`（6 行）。 -/
theorem power_one_of_W_real : realMatrixOfRealEntries W hW.1 ^ 1 = realMatrixOfRealEntries W hW.1 :=
  calc realMatrixOfRealEntries W hW.1 ^ 1
      = realMatrixOfRealEntries (W ^ 1) (matrix_pow_hasRealEntries W hW.1 1) :=
        (real_matrix_of_real_entry_matrix_preserves_power W hW.1 1).symm    -- 【冪の実数の行列】（`p → 1`）
    _ = realMatrixOfRealEntries (W ^ (0 + 1)) (matrix_pow_hasRealEntries W hW.1 (0 + 1)) :=
        realMatrixOfRealEntries_congr (by rw [Nat.zero_add]) _ _            -- `ℤ` で `1 = 0 + 1`
    _ = realMatrixOfRealEntries (W ^ 0 * W)
          (matrix_mul_hasRealEntries _ _ (matrix_pow_hasRealEntries W hW.1 0) hW.1) :=
        realMatrixOfRealEntries_congr (pow_succ W 0) _ _                    -- `def_exp` (1) の `A^{m+1} := A^mA`（`K = ℂ`, `m = 0`）
    _ = realMatrixOfRealEntries (1 * W)
          (matrix_mul_hasRealEntries _ _ identity_matrix_hasRealEntries_tensorPow hW.1) :=
        realMatrixOfRealEntries_congr (by rw [pow_zero]) _ _                -- `def_exp` (1) の `A^0 := I`（`K = ℂ`）
    _ = realMatrixOfRealEntries W hW.1 :=
        realMatrixOfRealEntries_congr (identity_matrix_mul_tensorPow W) _ _ -- `identity_matrix_is_left_unit_of_mat_mult` の `IW = W`
    _ = realMatrixOfRealEntries W hW.1 := rfl                               -- `def_W_real`（`W_ℝ := ϱ(W)`）

variable (hWRsymm : (realMatrixOfRealEntries W hW.1).IsSymm)
  (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x)

include hWRsymm hpd

/-- 人手【`(W_ℝ)^n` の半正定値性】: すべての `z ∈ ℝ^d` で `z^⊤(W_ℝ)^nz ≥ 0`。 -/
theorem power_of_W_real_is_positive_semidefinite (n : ℕ) (z : Conf M → ℝ) :
    0 ≤ z ⬝ᵥ (realMatrixOfRealEntries W hW.1 ^ n) *ᵥ z := by
  set P := realMatrixOfRealEntries W hW.1 ^ n with hP
  by_cases hz : z = 0
  · -- `z = 0` の場合
    have h0 : z ⬝ᵥ P *ᵥ z = 0 :=
      calc z ⬝ᵥ P *ᵥ z
          = ∑ i, ∑ j, z i * P i j * z j :=
            dotProduct_mulVec_eq_real_bilinear_value z z P                  -- `def_real_bilinear_value`
        _ = 0 := by simp only [hz, Pi.zero_apply, zero_mul, mul_zero,
              Finset.sum_const_zero]                                        -- 各項が `0·((W_ℝ)^n)_ij·0 = 0`
    exact h0.ge
  · -- `z ≠ 0` の場合: `z_{j_0} ≠ 0` となる `j_0`
    obtain ⟨j0, hj0⟩ := Function.ne_iff.mp hz
    have hsq : vecNorm z ^ 2 > 0 := norm_sq_pos_of_component_ne_zero hj0
    have hne : vecNorm z ≠ 0 := (norm_pos_of_component_ne_zero hj0).ne'
    set w : Conf M → ℝ := fun i => (vecNorm z)⁻¹ * z i with hwdef          -- `w_i := ‖z‖^{-1}z_i`
    have hzw : ∀ i, z i = vecNorm z * w i := fun i => by
      rw [hwdef, mul_inv_cancel_left₀ hne]                                  -- `z_i = ‖z‖(‖z‖^{-1}z_i) = ‖z‖w_i`
    have hw1 : vecNorm w = 1 :=
      norm_of_inverse_norm_multiple_is_one hj0 w fun i => rfl               -- 上の 9 行
    have hpos : z ⬝ᵥ P *ᵥ z > 0 :=
      calc z ⬝ᵥ P *ᵥ z
          = ∑ i, ∑ j, z i * P i j * z j :=
            dotProduct_mulVec_eq_real_bilinear_value z z P                  -- `def_real_bilinear_value`
        _ = ∑ i, ∑ j, (vecNorm z * w i) * P i j * (vecNorm z * w j) := by
            simp only [← hzw]                                               -- `z_i = ‖z‖w_i` を各項へ同時に
        _ = vecNorm z ^ 2 * ∑ i, ∑ j, w i * P i j * w j := by
            rw [← finite_sum_of_real_scalar_multiples_fintype]
            refine Finset.sum_congr rfl fun i _ => ?_
            rw [← finite_sum_of_real_scalar_multiples_fintype]
            exact Finset.sum_congr rfl fun j _ => by ring                   -- 乗法の交換則・結合則と `def_power_of_real_number` で `‖z‖‖z‖ = ‖z‖^2`、`finite_sum_of_real_scalar_multiples`（`c → ‖z‖^2`）を内側と外側の和へ
        _ = vecNorm z ^ 2 * (w ⬝ᵥ P *ᵥ w) := by
            rw [dotProduct_mulVec_eq_real_bilinear_value w w P]             -- `def_real_bilinear_value`
        _ > 0 :=
            mul_pos hsq ((moment_log_convexity W hW hWRsymm hpd hw1).1 n)   -- `‖z‖^2 > 0` と `moment_log_convexity` の正値性（`x → w`, `k → n`）
    exact hpos.le

/-- 人手【`(W_ℝ)^n` の成分の評価】: `2x_k((W_ℝ)^n)_klx_l ≤ x_l^2((W_ℝ)^n)_kk + x_k^2((W_ℝ)^n)_ll`
（`v_i := x_l(e_k)_i − x_k(e_l)_i` に半正定値性を当てる 7 行と移項）。 -/
theorem power_of_W_real_entry_bound (n : ℕ) (x : Conf M → ℝ) (k l : Conf M) :
    2 * x k * (realMatrixOfRealEntries W hW.1 ^ n) k l * x l
      ≤ x l ^ 2 * (realMatrixOfRealEntries W hW.1 ^ n) k k
          + x k ^ 2 * (realMatrixOfRealEntries W hW.1 ^ n) l l := by
  set P := realMatrixOfRealEntries W hW.1 ^ n with hP
  set ek : Conf M → ℝ := Pi.single k 1 with hek
  set el : Conf M → ℝ := Pi.single l 1 with hel
  set v : Conf M → ℝ := fun i => x l * ek i - x k * el i with hv          -- `v_i := x_l(e_k)_i − x_k(e_l)_i`
  have h :
      0 ≤ x l ^ 2 * P k k - 2 * x k * P k l * x l + x k ^ 2 * P l l :=
    calc (0 : ℝ)
        ≤ v ⬝ᵥ P *ᵥ v :=
          power_of_W_real_is_positive_semidefinite W hW hWRsymm hpd n v     -- 【`(W_ℝ)^n` の半正定値性】（`z → v`）
      _ = ∑ i, ∑ j, v i * P i j * v j :=
          dotProduct_mulVec_eq_real_bilinear_value v v P                    -- `def_real_bilinear_value`
      _ = ∑ i, ∑ j, (x l * ek i - x k * el i) * P i j * (x l * ek j - x k * el j) := rfl
                                                                            -- `v` の定義
      _ = x l ^ 2 * ∑ i, ∑ j, ek i * P i j * ek j - x l * x k * ∑ i, ∑ j, ek i * P i j * el j
            - x k * x l * ∑ i, ∑ j, el i * P i j * ek j
            + x k ^ 2 * ∑ i, ∑ j, el i * P i j * el j := by
          simp only [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
          exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by ring
                                                                            -- `ℝ` の分配則・交換則・結合則と、`finite_sum_of_real_scalar_multiples` を内側と外側の和へ
      _ = x l ^ 2 * P k k - x l * x k * P k l - x k * x l * P l k + x k ^ 2 * P l l := by
          rw [standard_basis_real_bilinear_value, standard_basis_real_bilinear_value,
            standard_basis_real_bilinear_value, standard_basis_real_bilinear_value]
                                                                            -- 各二重和で `0` でない項は一つだけ
      _ = x l ^ 2 * P k k - x l * x k * P k l - x k * x l * P k l + x k ^ 2 * P l l := by
          rw [show P l k = P k l from power_of_W_real_entry_symm W hW n l k]  -- 【`(W_ℝ)^n` の成分の対称性】の `((W_ℝ)^n)_lk = ((W_ℝ)^n)_kl`
      _ = x l ^ 2 * P k k - 2 * x k * P k l * x l + x k ^ 2 * P l l := by ring
                                                                            -- `ℝ` の乗法の交換則と同類項の加法
  linarith                                                                  -- 移項

omit hWRsymm hpd in
/-- 人手【単位ベクトルでの評価】の `Σ_k x_k^2 = 1`（3 行）。 -/
theorem sum_sq_of_unit_vector {x : Conf M → ℝ} (hx : vecNorm x = 1) : ∑ k, x k ^ 2 = 1 :=
  calc ∑ k, x k ^ 2
      = ∑ k, |x k| ^ 2 := by simp only [square_of_real_absolute_value]      -- `x_k ∈ ℝ` なので `square_of_real_absolute_value` の `|q|^2 = q^2`（`q → x_k`）
    _ = vecNorm x ^ 2 := (vecNorm_sq_eq_sum_abs_sq x).symm                  -- `def_matrix_norm` と `(√b)^2 = b`
    _ = 1 := by rw [hx, one_pow]                                            -- `‖x‖ = 1` と `def_power_of_real_number` で `1^2 = 1`

omit hWRsymm hpd in
/-- 人手【単位ベクトルでの評価】の `m_0 = 1`（7 行）。 -/
theorem moment_zero_eq_one {x : Conf M → ℝ} (hx : vecNorm x = 1) : momentWReal W hW x 0 = 1 := by
  set I : Matrix (Conf M) (Conf M) ℝ := 1 with hI
  calc momentWReal W hW x 0
      = x ⬝ᵥ (realMatrixOfRealEntries W hW.1 ^ 0) *ᵥ x := rfl              -- `m_0 := x^⊤(W_ℝ)^0x`
    _ = x ⬝ᵥ I *ᵥ x := by rw [pow_zero]                                    -- `def_exp` (1) の `A^0 := I`（`K = ℝ`、`I = I_ℝ`）
    _ = ∑ k, ∑ l, x k * I k l * x l := dotProduct_mulVec_eq_real_bilinear_value x x I
                                                                            -- `def_real_bilinear_value`
    _ = ∑ k, x k * I k k * x k :=
        Finset.sum_congr rfl fun k _ => by
          rw [Finset.sum_eq_single k
            (fun l _ hlk => by rw [hI, Matrix.one_apply_ne (Ne.symm hlk), mul_zero, zero_mul])
            (fun h => absurd (Finset.mem_univ k) h)]                       -- `l ≠ k` の項は `(I_ℝ)_kl = 0`（`def_real_identity_matrix`）なので `0`
    _ = ∑ k, x k * x k := by simp only [hI, Matrix.one_apply_eq, mul_one]   -- `(I_ℝ)_kk = 1`（`def_real_identity_matrix`）
    _ = ∑ k, x k ^ 2 := by simp only [sq]                                   -- `def_power_of_real_number` で `x_k^2 = (x_k^0x_k)x_k = x_kx_k` を各項へ同時に
    _ = 1 := sum_sq_of_unit_vector hx                                       -- 上の式変形

omit hWRsymm hpd in
/-- 人手【単位ベクトルでの評価】の `m_1 = x^⊤W_ℝx`（2 行）。 -/
theorem moment_one_eq (x : Conf M → ℝ) :
    momentWReal W hW x 1 = x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x :=
  calc momentWReal W hW x 1
      = x ⬝ᵥ (realMatrixOfRealEntries W hW.1 ^ 1) *ᵥ x := rfl              -- `m_1 := x^⊤(W_ℝ)^1x`
    _ = x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x := by
        rw [power_one_of_W_real W hW]                                       -- 【冪の実数の行列】の `(W_ℝ)^1 = W_ℝ`

/-- 人手【単位ベクトルでの評価】の `k ≥ 1` で `m_k ≥ m_1m_{k-1}`（`k` についての帰納法）。 -/
theorem moment_ge_moment_one_mul_prev {x : Conf M → ℝ} (hx : vecNorm x = 1) :
    ∀ k : ℕ, 1 ≤ k → momentWReal W hW x k ≥ momentWReal W hW x 1 * momentWReal W hW x (k - 1) := by
  have hlc := moment_log_convexity W hW hWRsymm hpd hx                      -- `moment_log_convexity`
  intro k hk
  induction k, hk using Nat.le_induction with
  | base =>                                                                 -- `k = 1`: `m_1 = m_1·1 = m_1m_0`
      rw [Nat.sub_self, moment_zero_eq_one W hW hx, mul_one]
  | succ k hk ih =>
      have hprev : momentWReal W hW x (k - 1) > 0 := hlc.1 (k - 1)
      have hk0 : momentWReal W hW x k > 0 := hlc.1 k
      have hratio : momentWReal W hW x k / momentWReal W hW x (k - 1) ≥ momentWReal W hW x 1 :=
        calc momentWReal W hW x k / momentWReal W hW x (k - 1)
            ≥ momentWReal W hW x 1 * momentWReal W hW x (k - 1) / momentWReal W hW x (k - 1) :=
              div_le_div_of_nonneg_right ih hprev.le                        -- 帰納法の仮定と、正の `m_{k-1}` での商は順序を保つ
          _ = momentWReal W hW x 1 := mul_div_cancel_right₀ _ hprev.ne'     -- `m_{k-1} > 0` の約分
      calc momentWReal W hW x (k + 1)
          = momentWReal W hW x (k - 1) * momentWReal W hW x (k + 1) / momentWReal W hW x (k - 1) :=
            (mul_div_cancel_left₀ _ hprev.ne').symm                         -- `m_{k-1} > 0` の約分
        _ ≥ momentWReal W hW x k ^ 2 / momentWReal W hW x (k - 1) :=
            div_le_div_of_nonneg_right (hlc.2 k hk) hprev.le                -- `moment_log_convexity` の `m_k^2 ≤ m_{k-1}m_{k+1}` と商の順序
        _ = momentWReal W hW x k * (momentWReal W hW x k / momentWReal W hW x (k - 1)) := by
            rw [sq, mul_div_assoc]                                          -- `def_power_of_real_number` で `m_k^2 = (m_k^0m_k)m_k = m_km_k` と乗法の結合則
        _ ≥ momentWReal W hW x k * momentWReal W hW x 1 :=
            mul_le_mul_of_nonneg_left hratio hk0.le                         -- 上の `m_k/m_{k-1} ≥ m_1` と、正の `m_k` を掛けても順序を保つ
        _ = momentWReal W hW x 1 * momentWReal W hW x (k + 1 - 1) := by
            rw [mul_comm, Nat.add_sub_cancel]                               -- 乗法の交換則と `ℤ` で `k = (k+1)−1`

/-- 人手【単位ベクトルでの評価】の `p ≥ 0` で `m_p ≥ m_1^p`（`p` についての帰納法）。 -/
theorem moment_ge_moment_one_pow {x : Conf M → ℝ} (hx : vecNorm x = 1) :
    ∀ p : ℕ, momentWReal W hW x p ≥ momentWReal W hW x 1 ^ p := by
  have hm1 : momentWReal W hW x 1 > 0 := (moment_log_convexity W hW hWRsymm hpd hx).1 1
  intro p
  induction p with
  | zero =>                                                                 -- `p = 0`: `m_0 = 1 = m_1^0`（`def_power_of_real_number`）
      rw [moment_zero_eq_one W hW hx, pow_zero]
  | succ p ih =>
      calc momentWReal W hW x (p + 1)
          ≥ momentWReal W hW x 1 * momentWReal W hW x (p + 1 - 1) :=
            moment_ge_moment_one_mul_prev W hW hWRsymm hpd hx (p + 1) (Nat.le_add_left 1 p)
                                                                            -- 上の `m_k ≥ m_1m_{k-1}`（`k → p+1`）
        _ = momentWReal W hW x 1 * momentWReal W hW x p := by
            rw [Nat.add_sub_cancel]                                         -- `ℤ` で `(p+1)−1 = p`
        _ ≥ momentWReal W hW x 1 * momentWReal W hW x 1 ^ p :=
            mul_le_mul_of_nonneg_left ih hm1.le                             -- 帰納法の仮定と、正の `m_1` を掛けても順序を保つ
        _ = momentWReal W hW x 1 ^ (p + 1) := by
            rw [mul_comm, pow_succ]                                         -- 乗法の交換則と `def_power_of_real_number` で `m_1^{p+1} = m_1^pm_1`

/-- 人手【単位ベクトルでの評価】の `m_n ≤ T`（`T := Σ_k ((W_ℝ)^n)_kk`、8 行）。 -/
theorem moment_le_trace_of_power {x : Conf M → ℝ} (hx : vecNorm x = 1) (n : ℕ) :
    momentWReal W hW x n ≤ ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k := by
  set P := realMatrixOfRealEntries W hW.1 ^ n with hP
  set T := ∑ k, P k k with hT
  have hs : ∑ k, x k ^ 2 = 1 := sum_sq_of_unit_vector hx
  calc momentWReal W hW x n
      = ∑ k, ∑ l, x k * P k l * x l := dotProduct_mulVec_eq_real_bilinear_value x x P
                                                                            -- `m_n := x^⊤(W_ℝ)^nx` と `def_real_bilinear_value`
    _ = 2⁻¹ * ∑ k, ∑ l, 2 * x k * P k l * x l := by
        rw [← finite_sum_of_real_scalar_multiples_fintype]
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [← finite_sum_of_real_scalar_multiples_fintype]
        exact Finset.sum_congr rfl fun l _ => by ring                       -- `2^{-1}·2 = 1` と `finite_sum_of_real_scalar_multiples`（`c → 2^{-1}`）を内側と外側の和へ
    _ ≤ 2⁻¹ * ∑ k, ∑ l, (x l ^ 2 * P k k + x k ^ 2 * P l l) :=
        mul_le_mul_of_nonneg_left
          (finite_sum_of_real_numbers_is_monotone_fintype _ _ fun k =>
            finite_sum_of_real_numbers_is_monotone_fintype _ _ fun l =>
              power_of_W_real_entry_bound W hW hWRsymm hpd n x k l)
          (by norm_num)                                                     -- 【`(W_ℝ)^n` の成分の評価】を `d^2` 個の項へ同時に、項ごとの不等式の有限和と `2^{-1} > 0` 倍
    _ = 2⁻¹ * (∑ k, ∑ l, x l ^ 2 * P k k + ∑ k, ∑ l, x k ^ 2 * P l l) := by
        rw [← Finset.sum_add_distrib]
        exact congrArg (2⁻¹ * ·) (Finset.sum_congr rfl fun k _ => Finset.sum_add_distrib)
                                                                            -- `ℝ` の有限和の加法の交換則・結合則
    _ = 2⁻¹ * (∑ k, P k k * ∑ l, x l ^ 2 + ∑ k, x k ^ 2 * ∑ l, P l l) := by
        congr 2
        · exact Finset.sum_congr rfl fun k _ => by
            rw [← finite_sum_of_real_scalar_multiples_fintype]
            exact Finset.sum_congr rfl fun l _ => mul_comm _ _
        · exact Finset.sum_congr rfl fun k _ => by
            rw [← finite_sum_of_real_scalar_multiples_fintype]              -- 乗法の交換則と、`finite_sum_of_real_scalar_multiples` を内側の和へ
    _ = 2⁻¹ * ((∑ k, P k k) * (∑ l, x l ^ 2) + (∑ k, x k ^ 2) * (∑ l, P l l)) := by
        rw [Finset.sum_mul, Finset.sum_mul]                                 -- 乗法の交換則と、`finite_sum_of_real_scalar_multiples` を外側の和へ
    _ = 2⁻¹ * (T * 1 + 1 * T) := by rw [hs]                                 -- `T := Σ_k((W_ℝ)^n)_kk` と、上の `Σ_k x_k^2 = 1`
    _ = T := by ring                                                        -- `ℝ` の四則

/-- 人手【単位ベクトルでの評価】のまとめ: 単位ベクトル `x` について `(x^⊤W_ℝx)^n ≤ T`（3 行）。 -/
theorem real_bilinear_value_pow_le_trace_of_power {x : Conf M → ℝ} (hx : vecNorm x = 1) (n : ℕ) :
    (x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x) ^ n
      ≤ ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k :=
  calc (x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x) ^ n
      = momentWReal W hW x 1 ^ n := by rw [moment_one_eq W hW x]            -- 上の `m_1 = x^⊤W_ℝx`
    _ ≤ momentWReal W hW x n := moment_ge_moment_one_pow W hW hWRsymm hpd hx n
                                                                            -- 上の `m_p ≥ m_1^p`（`p → n`）
    _ ≤ ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k :=
        moment_le_trace_of_power W hW hWRsymm hpd hx n                      -- 上の式変形

end General

end Ising2D
