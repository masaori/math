/-
# `‖W_ℝx‖ ≤ c(M)‖x‖`（具体版）

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_007_claim_operator_bound`、ラベル **`rayleigh_bounds_operator_norm`**）

必要十分版: `Ising2D.NecSuf.IsPsdPair.rayleigh_bounds_operator_norm`
（`Ising2D/NecSuf/RayleighMoments.lean`）

具体版 `rayleigh_bounds_operator_norm`・`rayleigh_bounds_operator_norm_pow` は、人手証明の鎖を同じ順に書いた証明である。
人手の `W_ℝ`（`def_W_real`）は、ここでは仮定 `W.IsSymm`（人手 `W_real_is_symmetric`）と
正定値性 `hpd`（人手 `W_real_is_positive_definite`）を持つ実行列 `W : Matrix n n ℝ` で表す。
本文の `W_ℝ` に当てるのは `PhysicalPartitionFunctionSandwich.lean` の `physicalSymTransferR`（`W_real_is_symmetric`・`W_real_is_positive_definite` を持つ）である。

人手の行と Lean の対応:

| 人手の段 | Lean |
| --- | --- |
| `W_real_is_positive_semidefinite`（`u ≠ 0` は `W_real_is_positive_definite`、`u = 0` は 5 行の鎖） | `psd_of_pd` |
| 一つ目の鎖 6 行 `‖W_ℝx‖^2 = … = y^⊤W_ℝx` | `vecNorm_mulVec_sq_eq_bilinear` |
| 二つ目の鎖 6 行 `‖W_ℝx‖^4 ≤ … = c^2‖x‖^2‖W_ℝx‖^2` | `rayleigh_bounds_operator_norm` の `h4` |
| 場合分けと割り算・平方の 3 行 | `rayleigh_bounds_operator_norm` の後半 |
| `k = 0` の 3 行、帰納法の 5 行 | `rayleigh_bounds_operator_norm_pow` |

人手の `x^⊤W_ℝx ≤ c‖x‖^2`（`def_rayleigh_sup`）は `quad_le_rayleighSup_mul`（`‖x‖^2` を `vecNormSq` で書く）を `vecNorm_sq` で読み替えて引く。
`rayleigh_bounds_operator_normSq`・`rayleigh_bounds_operator_normSq_pow` は必要十分版を実行列へ特殊化したもの、
`rayleigh_bounds_operator_norm_of_necSuf`・`rayleigh_bounds_operator_norm_pow_of_necSuf` はその平方根を取って具体版と同じ主張を得たもので、
具体版が必要十分版の特殊化として得られることの記録である（具体版の証明には使わない）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.DefinitionRayleighSup

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- モーメント `⟪x, W^k x⟫` の行列表示。 -/
theorem matBilin_one_mulVecLin_pow (W : Matrix n n ℝ) (x : n → ℝ) (k : ℕ) :
    matBilin (1 : Matrix n n ℝ) x ((W.mulVecLin ^ k) x) = x ⬝ᵥ W ^ k *ᵥ x := by
  rw [mulVecLin_pow_apply, matBilin_one_apply]

/-- **人手 `W_real_is_positive_semidefinite`**（`W_ℝ` を仮定 `hpd` を持つ実行列 `W` で表した形）: `W_ℝ` は半正定値。
`u ≠ 0` なら正定値性（人手 `W_real_is_positive_definite`）、`u = 0` なら人手の 5 行の鎖で `u^⊤W_ℝu = 0`。
本文の `W_ℝ` に当てたものは `PhysicalPartitionFunctionSandwich.lean` の `Ising2D.W_real_is_positive_semidefinite`。 -/
theorem psd_of_pd {W : Matrix n n ℝ} (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ W *ᵥ x)
    (u : n → ℝ) : 0 ≤ u ⬝ᵥ W *ᵥ u := by
  rcases eq_or_ne u 0 with rfl | hu
  · have h0 : (0 : n → ℝ) ⬝ᵥ W *ᵥ (0 : n → ℝ) = 0 :=
      calc (0 : n → ℝ) ⬝ᵥ W *ᵥ (0 : n → ℝ)
          = ∑ k, ∑ l, (0 : n → ℝ) k * W k l * (0 : n → ℝ) l :=
            dotProduct_mulVec_eq_real_bilinear_value 0 0 W                    -- 1 行目: `def_real_bilinear_value`（`P → W_ℝ`、`x → u`、`y → u`）
        _ = ∑ k, ∑ l, (0 : ℝ) * W k l * 0 := rfl                              -- 2 行目: `u_k = 0`、`u_l = 0` を各項へ
        _ = ∑ _k : n, ∑ _l : n, (0 : ℝ) * 0 :=
            Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
              rw [zero_mul (W k l)]                                           -- 3 行目: `ℝ` で `0·a = 0`（`a → (W_ℝ)_kl`）を各項へ
        _ = ∑ _k : n, ∑ _l : n, (0 : ℝ) :=
            Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
              zero_mul 0                                                      -- 4 行目: `ℝ` で `0·a = 0`（`a → 0`）を各項へ
        _ = 0 := by simp only [Finset.sum_const_zero]                         -- 5 行目: `def_finite_sum_of_real_numbers` の和と `0 + 0 = 0`（具体版が無いので mathlib）
    exact h0.ge
  · exact (hpd u hu).le                                                       -- `u ≠ 0`: `W_real_is_positive_definite`（`x → u`）

/-- `Ising2D.rayleighSup` を必要十分版の仮定 `∀ u, ⟪u, W u⟫ ≤ c⟪u, u⟫` の形にしたもの（`W` に仮定を置かない）。 -/
theorem necSuf_rayleigh_hyp {W : Matrix n n ℝ} (u : n → ℝ) :
    matBilin (1 : Matrix n n ℝ) u (W.mulVecLin u)
      ≤ rayleighSup W * matBilin (1 : Matrix n n ℝ) u u := by
  simpa [vecNormSq] using quad_le_rayleighSup_mul (W := W) u

/-- **`‖Wx‖² ≤ c(M)²‖x‖²`**（必要十分版の特殊化）。 -/
theorem rayleigh_bounds_operator_normSq {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (x : n → ℝ) :
    vecNormSq (W *ᵥ x) ≤ rayleighSup W ^ 2 * vecNormSq x := by
  have hpair := isPsdPair_of_matrix hW hpsd
  have h := hpair.rayleigh_bounds_operator_norm (rayleighSup_nonneg hpsd)
    (necSuf_rayleigh_hyp (W := W)) x
  simpa [vecNormSq] using h

/-- **`‖W^k x‖² ≤ (c(M)²)^k ‖x‖²`**（必要十分版の反復形の特殊化）。 -/
theorem rayleigh_bounds_operator_normSq_pow {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (k : ℕ) (x : n → ℝ) :
    vecNormSq (W ^ k *ᵥ x) ≤ (rayleighSup W ^ 2) ^ k * vecNormSq x := by
  have hpair := isPsdPair_of_matrix hW hpsd
  have h := hpair.rayleigh_bounds_operator_norm_pow (rayleighSup_nonneg hpsd)
    (necSuf_rayleigh_hyp (W := W)) k x
  rw [mulVecLin_pow_apply] at h
  simpa [vecNormSq] using h

/-- **人手 `rayleigh_bounds_operator_norm` の一つ目の鎖 6 行**: `y := W_ℝx` について `‖W_ℝx‖^2 = y^⊤W_ℝx`。 -/
theorem vecNorm_mulVec_sq_eq_bilinear (W : Matrix n n ℝ) (x : n → ℝ) :
    vecNorm (W *ᵥ x) ^ 2 = (W *ᵥ x) ⬝ᵥ W *ᵥ x := by
  set y := W *ᵥ x with hy                                                     -- 置き方 `y := W_ℝx`（成分 `y_k = Σ_l (W_ℝ)_kl x_l`）
  calc vecNorm (W *ᵥ x) ^ 2
      = vecNorm y ^ 2 := rfl                                                  -- 1 行目: `y := W_ℝx`
    _ = ∑ k, y k ^ 2 := by rw [vecNorm_sq, vecNormSq_eq_sum]                  -- 2 行目: `def_matrix_norm` と `(√a)^2 = a`
                                                                              -- （Lean の `vecNormSq` は `Σ y_k^2` で、人手の `|y_k|^2` の `|·|` は現れない）
    _ = ∑ k, y k * y k := by simp only [sq]                                   -- 3 行目: `y_k ∈ ℝ` なので `|y_k|^2 = y_ky_k`
    _ = ∑ k, y k * ∑ l, W k l * x l := by rw [hy]; rfl                        -- 4 行目: `y = W_ℝx` の成分（`mat_mult`、右因子）
    _ = ∑ k, ∑ l, y k * W k l * x l := by
        simp only [Finset.mul_sum, mul_assoc]                                 -- 5 行目: 分配則と乗法の結合則
    _ = y ⬝ᵥ W *ᵥ x := (dotProduct_mulVec_eq_real_bilinear_value y x W).symm  -- 6 行目: `def_real_bilinear_value`（`x → y`、`y → x`）

/-- **`‖W_ℝx‖ ≤ c(M)‖x‖`**（人手証明 `rayleigh_bounds_operator_norm` の前半。鎖を人手と同じ順に書いた具体版）。 -/
theorem rayleigh_bounds_operator_norm {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ W *ᵥ x) (x : n → ℝ) :
    vecNorm (W *ᵥ x) ≤ rayleighSup W * vecNorm x := by
  set c := rayleighSup W with hcdef                                           -- `c := c(M_col)`
  have hc : 0 < c := rayleighSup_pos hpd                                      -- `c ∈ ℝ_{>0}`（`def_rayleigh_sup`）
  have hpsd : ∀ u : n → ℝ, 0 ≤ u ⬝ᵥ W *ᵥ u := psd_of_pd hpd                  -- 準備: 半正定値
  set y := W *ᵥ x with hy                                                     -- `y := W_ℝx`
  have hRx : x ⬝ᵥ W *ᵥ x ≤ c * vecNorm x ^ 2 := by
    rw [vecNorm_sq]; exact quad_le_rayleighSup_mul x                          -- `def_rayleigh_sup` の `x^⊤W_ℝx ≤ c‖x‖^2`
  have hRy : y ⬝ᵥ W *ᵥ y ≤ c * vecNorm y ^ 2 := by
    rw [vecNorm_sq]; exact quad_le_rayleighSup_mul y                          -- 同じ評価（`x → y`）
  have h4 : vecNorm y ^ 4 ≤ c ^ 2 * vecNorm x ^ 2 * vecNorm y ^ 2 :=
    calc vecNorm y ^ 4
        = (vecNorm y ^ 2) ^ 2 := by rw [← pow_mul]                            -- 1 行目: 冪の指数法則
      _ = (y ⬝ᵥ W *ᵥ x) ^ 2 := by rw [vecNorm_mulVec_sq_eq_bilinear]          -- 2 行目: 一つ目の鎖
      _ ≤ (x ⬝ᵥ W *ᵥ x) * (y ⬝ᵥ W *ᵥ y) := psd_cauchy_schwarz hW hpsd x y     -- 3 行目: `psd_cauchy_schwarz`（`P → W_ℝ`）
      _ ≤ (c * vecNorm x ^ 2) * (y ⬝ᵥ W *ᵥ y) :=
          mul_le_mul_of_nonneg_right hRx (hpsd y)                             -- 4 行目: `x^⊤W_ℝx ≤ c‖x‖^2` と `0 ≤ y^⊤W_ℝy`
      _ ≤ (c * vecNorm x ^ 2) * (c * vecNorm y ^ 2) :=
          mul_le_mul_of_nonneg_left hRy
            (mul_nonneg hc.le (sq_nonneg _))                                  -- 5 行目: `y^⊤W_ℝy ≤ c‖y‖^2` と `0 ≤ c‖x‖^2`
      _ = c ^ 2 * vecNorm x ^ 2 * vecNorm y ^ 2 := by ring                    -- 6 行目: `ℝ` の乗法の可換則・結合則
  rcases eq_or_lt_of_le (vecNorm_nonneg y) with h0 | hpos
  · rw [← h0]                                                                 -- `‖W_ℝx‖ = 0` の側: 左辺 0、右辺 `c‖x‖ ≥ 0`
    exact mul_nonneg hc.le (vecNorm_nonneg x)
  · have hpos2 : 0 < vecNorm y ^ 2 := pow_pos hpos 2
    have h2 : vecNorm y ^ 2 ≤ c ^ 2 * vecNorm x ^ 2 := by
      have h4' : vecNorm y ^ 2 * vecNorm y ^ 2 ≤ (c ^ 2 * vecNorm x ^ 2) * vecNorm y ^ 2 := by
        rw [← pow_add]; exact h4
      exact le_of_mul_le_mul_right h4' hpos2                                  -- 両辺を `‖W_ℝx‖^2 > 0` で割る
    have h3 : vecNorm y ^ 2 ≤ (c * vecNorm x) ^ 2 := by
      rw [mul_pow]; exact h2                                                  -- 冪の指数法則 `c^2‖x‖^2 = (c‖x‖)^2`
    exact nonnegative_real_order_from_squares (vecNorm_nonneg y)
      (mul_nonneg hc.le (vecNorm_nonneg x)) h3                                -- `nonnegative_real_order_from_squares`（`u → ‖W_ℝx‖`、`v → c‖x‖`）

/-- **`‖(W_ℝ)^k x‖ ≤ c(M)^k ‖x‖`**（人手証明の帰納法の部分。`k = 0` の 3 行と帰納法の 5 行）。 -/
theorem rayleigh_bounds_operator_norm_pow {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ W *ᵥ x) (k : ℕ) (x : n → ℝ) :
    vecNorm (W ^ k *ᵥ x) ≤ rayleighSup W ^ k * vecNorm x := by
  have hc : 0 < rayleighSup W := rayleighSup_pos hpd                          -- `c > 0`（`def_rayleigh_sup`）
  induction k generalizing x with
  | zero =>
      exact le_of_eq <|
        calc vecNorm (W ^ 0 *ᵥ x)
            = vecNorm ((1 : Matrix n n ℝ) *ᵥ x) := by rw [pow_zero]           -- 1 行目: `def_exp` (1) の `A^0 := I`
          _ = vecNorm x := by rw [one_mulVec]                                 -- 2 行目: `identity_matrix_is_left_unit_of_mat_mult`（mathlib の `one_mulVec`）
          _ = rayleighSup W ^ 0 * vecNorm x := by rw [pow_zero, one_mul]      -- 3 行目: `c^0 = 1`
  | succ k ih =>
      calc vecNorm (W ^ (k + 1) *ᵥ x)
          = vecNorm ((W ^ k * W) *ᵥ x) := by rw [pow_succ]                    -- 1 行目: `def_exp` (1) の `A^{m+1} := A^mA`
        _ = vecNorm (W ^ k *ᵥ (W *ᵥ x)) := by rw [← mulVec_mulVec]           -- 2 行目: `mat_mult_associative`（mathlib の `mulVec_mulVec`）
        _ ≤ rayleighSup W ^ k * vecNorm (W *ᵥ x) := ih (W *ᵥ x)               -- 3 行目: 帰納法の仮定を `W_ℝx` に適用
        _ ≤ rayleighSup W ^ k * (rayleighSup W * vecNorm x) :=
            mul_le_mul_of_nonneg_left (rayleigh_bounds_operator_norm hW hpd x)
              (pow_nonneg hc.le k)                                            -- 4 行目: `‖W_ℝx‖ ≤ c‖x‖` と `c^k ≥ 0`
        _ = rayleighSup W ^ (k + 1) * vecNorm x := by ring                    -- 5 行目: 冪の指数法則と乗法の結合則

/-- **`‖Wx‖ ≤ c(M)‖x‖` を必要十分版から導いたもの**（`rayleigh_bounds_operator_normSq` の平方根を取る）。
具体版 `rayleigh_bounds_operator_norm` と同じ主張が必要十分版の特殊化として得られることの記録で、通しの証明には使わない。 -/
theorem rayleigh_bounds_operator_norm_of_necSuf {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (x : n → ℝ) :
    vecNorm (W *ᵥ x) ≤ rayleighSup W * vecNorm x := by
  have hc0 : 0 ≤ rayleighSup W := rayleighSup_nonneg hpsd
  have h := rayleigh_bounds_operator_normSq hW hpsd x
  calc vecNorm (W *ᵥ x) = Real.sqrt (vecNormSq (W *ᵥ x)) := rfl
    _ ≤ Real.sqrt (rayleighSup W ^ 2 * vecNormSq x) := Real.sqrt_le_sqrt h
    _ = rayleighSup W * vecNorm x := by
        rw [Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq hc0]
        rfl

/-- **`‖W^k x‖ ≤ c(M)^k ‖x‖` を必要十分版から導いたもの**（`rayleigh_bounds_operator_normSq_pow` の平方根を取る）。通しの証明には使わない。 -/
theorem rayleigh_bounds_operator_norm_pow_of_necSuf {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (k : ℕ) (x : n → ℝ) :
    vecNorm (W ^ k *ᵥ x) ≤ rayleighSup W ^ k * vecNorm x := by
  have hc0 : 0 ≤ rayleighSup W := rayleighSup_nonneg hpsd
  have h := rayleigh_bounds_operator_normSq_pow hW hpsd k x
  have hpow : (rayleighSup W ^ 2) ^ k = (rayleighSup W ^ k) ^ 2 := by
    rw [← pow_mul, ← pow_mul, Nat.mul_comm]
  rw [hpow] at h
  calc vecNorm (W ^ k *ᵥ x) = Real.sqrt (vecNormSq (W ^ k *ᵥ x)) := rfl
    _ ≤ Real.sqrt ((rayleighSup W ^ k) ^ 2 * vecNormSq x) := Real.sqrt_le_sqrt h
    _ = rayleighSup W ^ k * vecNorm x := by
        rw [Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq (pow_nonneg hc0 k)]
        rfl

end Ising2D
