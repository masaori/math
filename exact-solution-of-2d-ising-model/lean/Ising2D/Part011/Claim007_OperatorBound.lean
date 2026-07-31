/-
# `‖Wx‖ ≤ c(M)‖x‖`（具体版）

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_007_claim_operator_bound`、ラベル **`rayleigh_bounds_operator_norm`**）

必要十分版: `Ising2D.NecSuf.IsPsdPair.rayleigh_bounds_operator_norm`
（`Ising2D/NecSuf/RayleighMoments.lean`）

必要十分版は平方根を取る前の形 `⟪Wx, Wx⟫ ≤ c²⟪x, x⟫` で、順序体上の対称半正定値形式と
それについて自己共役かつ半正定値な作用素だけから従う。本ファイルではそれを実行列へ
特殊化し、人手証明と同じ「平方根を取った形」`‖Wx‖ ≤ c(M)‖x‖` を系として述べる。
-/
import Ising2D.Part011.Definition006_RayleighSup

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- モーメント `⟪x, W^k x⟫` の行列表示。 -/
theorem matBilin_one_mulVecLin_pow (W : Matrix n n ℝ) (x : n → ℝ) (k : ℕ) :
    matBilin (1 : Matrix n n ℝ) x ((W.mulVecLin ^ k) x) = x ⬝ᵥ W ^ k *ᵥ x := by
  rw [mulVecLin_pow_apply, matBilin_one_apply]

/-- 実対称正定値行列は半正定値。 -/
theorem psd_of_pd {W : Matrix n n ℝ} (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ W *ᵥ x)
    (x : n → ℝ) : 0 ≤ x ⬝ᵥ W *ᵥ x := by
  rcases eq_or_ne x 0 with rfl | hx
  · simp
  · exact (hpd x hx).le

/-- `Ising2D.rayleighSup` を必要十分版の仮定 `∀ u, ⟪u, W u⟫ ≤ c⟪u, u⟫` の形にしたもの。 -/
theorem necSuf_rayleigh_hyp {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (u : n → ℝ) :
    matBilin (1 : Matrix n n ℝ) u (W.mulVecLin u)
      ≤ rayleighSup W * matBilin (1 : Matrix n n ℝ) u u := by
  simpa [vecNormSq] using quad_le_rayleighSup_mul hW hpsd u

/-- **`‖Wx‖² ≤ c(M)²‖x‖²`**（必要十分版の特殊化）。 -/
theorem rayleigh_bounds_operator_normSq {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (x : n → ℝ) :
    vecNormSq (W *ᵥ x) ≤ rayleighSup W ^ 2 * vecNormSq x := by
  have hpair := isPsdPair_of_matrix hW hpsd
  have h := hpair.rayleigh_bounds_operator_norm (rayleighSup_nonneg hW hpsd)
    (necSuf_rayleigh_hyp hW hpsd) x
  simpa [vecNormSq] using h

/-- **`‖W^k x‖² ≤ (c(M)²)^k ‖x‖²`**（必要十分版の反復形の特殊化）。 -/
theorem rayleigh_bounds_operator_normSq_pow {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (k : ℕ) (x : n → ℝ) :
    vecNormSq (W ^ k *ᵥ x) ≤ (rayleighSup W ^ 2) ^ k * vecNormSq x := by
  have hpair := isPsdPair_of_matrix hW hpsd
  have h := hpair.rayleigh_bounds_operator_norm_pow (rayleighSup_nonneg hW hpsd)
    (necSuf_rayleigh_hyp hW hpsd) k x
  rw [mulVecLin_pow_apply] at h
  simpa [vecNormSq] using h

/-- **`‖Wx‖ ≤ c(M)‖x‖`**（人手証明 `rayleigh_bounds_operator_norm` の主張そのもの）。 -/
theorem rayleigh_bounds_operator_norm {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (x : n → ℝ) :
    vecNorm (W *ᵥ x) ≤ rayleighSup W * vecNorm x := by
  have hc0 : 0 ≤ rayleighSup W := rayleighSup_nonneg hW hpsd
  have h := rayleigh_bounds_operator_normSq hW hpsd x
  calc vecNorm (W *ᵥ x) = Real.sqrt (vecNormSq (W *ᵥ x)) := rfl
    _ ≤ Real.sqrt (rayleighSup W ^ 2 * vecNormSq x) := Real.sqrt_le_sqrt h
    _ = rayleighSup W * vecNorm x := by
        rw [Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq hc0]
        rfl

/-- **`‖W^k x‖ ≤ c(M)^k ‖x‖`**（人手証明の帰納法の部分）。 -/
theorem rayleigh_bounds_operator_norm_pow {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (k : ℕ) (x : n → ℝ) :
    vecNorm (W ^ k *ᵥ x) ≤ rayleighSup W ^ k * vecNorm x := by
  have hc0 : 0 ≤ rayleighSup W := rayleighSup_nonneg hW hpsd
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
