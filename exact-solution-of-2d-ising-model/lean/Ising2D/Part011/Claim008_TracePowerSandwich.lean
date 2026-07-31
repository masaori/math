/-
# `c(M)^n ≤ tr(W^n) ≤ 2^M c(M)^n`（具体版）

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_008_claim_trace_power_sandwich`、ラベル **`trace_power_sandwich`**）

必要十分版: `Ising2D.NecSuf.IsPsdPair.moment_le_pow`（Step 1）、
`Ising2D.NecSuf.IsPsdPair.moment_log_convex`（Step 2）、
`Ising2D.NecSuf.IsPdPair.moment_pow_le`（Step 3 前半）
（いずれも `Ising2D/NecSuf/RayleighMoments.lean`）

**この証明はスペクトル定理（実対称行列の対角化可能性）を使っていない。**
上からの評価は `rayleigh_bounds_operator_norm` から、下からの評価は
モーメント列 `m_k = xᵀW^k x` の対数凸性 `m_k² ≤ m_{k-1}m_{k+1}` による。
人手証明の経路をそのまま写している。

人手証明の `2^M` は空間の次元なので、ここでは `Fintype.card n` として述べる
（Ising の場合 `n = Conf M` で `Fintype.card (Conf M) = 2^M`）。
-/
import Ising2D.Part011.Claim007_OperatorBound

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- `W^N` も実対称。 -/
theorem IsSymm_pow {W : Matrix n n ℝ} (hW : W.IsSymm) (N : ℕ) : (W ^ N).IsSymm := by
  show (W ^ N)ᵀ = W ^ N
  rw [Matrix.transpose_pow, hW.eq]

/-- `W^N` も半正定値（人手証明 Step 3 の「`W^n` は正定値」の半正定値版）。 -/
theorem psd_pow {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (N : ℕ) (x : n → ℝ) :
    0 ≤ x ⬝ᵥ W ^ N *ᵥ x := by
  have hpair := isPsdPair_of_matrix hW hpsd
  have h := hpair.moment_nonneg x N
  rwa [matBilin_one_mulVecLin_pow] at h

/-- **上からの評価**（人手証明 Step 1）: `tr(W^n) ≤ (dim) c(M)^n`。 -/
theorem trace_pow_le {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (N : ℕ) :
    (W ^ N).trace ≤ (Fintype.card n : ℝ) * rayleighSup W ^ N := by
  have hpair := isPsdPair_of_matrix hW hpsd
  have hdiag : ∀ i : n, (W ^ N) i i ≤ rayleighSup W ^ N := by
    intro i
    have h := hpair.moment_le_pow (rayleighSup_nonneg hW hpsd)
      (necSuf_rayleigh_hyp hW hpsd) (Pi.single i 1) N
    rw [matBilin_one_mulVecLin_pow, single_dotProduct_mulVec_single] at h
    have he : matBilin (1 : Matrix n n ℝ) (Pi.single i 1) (Pi.single i 1) = 1 := by
      simpa [vecNormSq] using vecNormSq_single (n := n) i
    rwa [he, mul_one] at h
  calc (W ^ N).trace = ∑ i, (W ^ N) i i := rfl
    _ ≤ ∑ _i : n, rayleighSup W ^ N := Finset.sum_le_sum fun i _ => hdiag i
    _ = (Fintype.card n : ℝ) * rayleighSup W ^ N := by
        rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]

/-- 単位ベクトルに対する `(xᵀWx)^n ≤ tr(W^n)`（人手証明 Step 2・Step 3）。 -/
theorem quad_pow_le_trace_pow {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ W *ᵥ x) {x : n → ℝ} (hx : vecNormSq x = 1)
    (N : ℕ) :
    (x ⬝ᵥ W *ᵥ x) ^ N ≤ (W ^ N).trace := by
  have hpsd : ∀ y : n → ℝ, 0 ≤ y ⬝ᵥ W *ᵥ y := psd_of_pd hpd
  have hpair := isPdPair_of_matrix hW hpd
  have hx0 : x ≠ 0 := by
    intro h
    rw [h] at hx
    simp [vecNormSq] at hx
  have hip1 : matBilin (1 : Matrix n n ℝ) x x = 1 := by
    simpa [vecNormSq] using hx
  -- Step 2・Step 3: `(xᵀWx)^n ≤ m_n`
  have h1 := hpair.moment_pow_le hx0 hip1 N
  rw [matBilin_one_mulVecLin_pow] at h1
  have h1' : (x ⬝ᵥ W *ᵥ x) ^ N ≤ x ⬝ᵥ W ^ N *ᵥ x := by
    simpa using h1
  -- `m_n ≤ tr(W^n)`（半正定値行列に対する `xᵀAx ≤ ‖x‖² tr A`）
  have h2 := psd_quad_le_normSq_mul_trace (IsSymm_pow hW N) (psd_pow hW hpsd N) x
  rw [hx, one_mul] at h2
  exact le_trans h1' h2

/-- **下からの評価**（人手証明 Step 3 の最後の `sup` を取る操作）: `c(M)^n ≤ tr(W^n)`。 -/
theorem rayleighSup_pow_le_trace_pow {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ W *ᵥ x) {N : ℕ} (hN : 1 ≤ N) :
    rayleighSup W ^ N ≤ (W ^ N).trace := by
  have hpsd : ∀ y : n → ℝ, 0 ≤ y ⬝ᵥ W *ᵥ y := psd_of_pd hpd
  set T := (W ^ N).trace with hT
  have hNne : (N : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr (by omega)
  -- `T > 0`
  obtain ⟨i⟩ := (inferInstance : Nonempty n)
  have hei : (Pi.single i 1 : n → ℝ) ≠ 0 := by
    intro h
    have hu := vecNormSq_single (n := n) i
    rw [h] at hu
    simp [vecNormSq] at hu
  have hTpos : 0 < T := by
    have h := quad_pow_le_trace_pow hW hpd (vecNormSq_single (n := n) i) N
    exact lt_of_lt_of_le (pow_pos (hpd _ hei) N) h
  -- 各 `r ∈ 𝓡` について `r ≤ T^{1/N}`
  have hroot : ∀ r : ℝ, 0 < r → r ^ N ≤ T → r ≤ T ^ ((1 : ℝ) / N) := by
    intro r hr hrN
    have h1 : ((r ^ N : ℝ)) ^ ((1 : ℝ) / N) ≤ T ^ ((1 : ℝ) / N) :=
      Real.rpow_le_rpow (by positivity) hrN (by positivity)
    have h2 : ((r ^ N : ℝ)) ^ ((1 : ℝ) / N) = r := by
      rw [← Real.rpow_natCast r N, ← Real.rpow_mul hr.le, mul_one_div, div_self hNne,
        Real.rpow_one]
    rwa [h2] at h1
  have hle : rayleighSup W ≤ T ^ ((1 : ℝ) / N) := by
    refine csSup_le (rayleighSet_nonempty W) ?_
    rintro r ⟨x, hx, rfl⟩
    have hx0 : x ≠ 0 := by
      intro h
      rw [h] at hx
      simp [vecNormSq] at hx
    exact hroot _ (hpd x hx0) (quad_pow_le_trace_pow hW hpd hx N)
  have hpow : (T ^ ((1 : ℝ) / N)) ^ N = T := by
    rw [← Real.rpow_natCast (T ^ ((1 : ℝ) / N)) N, ← Real.rpow_mul hTpos.le,
      one_div, inv_mul_cancel₀ hNne, Real.rpow_one]
  calc rayleighSup W ^ N ≤ (T ^ ((1 : ℝ) / N)) ^ N :=
        pow_le_pow_left₀ (rayleighSup_nonneg hW hpsd) hle N
    _ = T := hpow

/-- **`c(M)^n ≤ tr(W^n) ≤ (dim) c(M)^n`**（人手証明 `trace_power_sandwich`）。 -/
theorem trace_power_sandwich {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ W *ᵥ x) {N : ℕ} (hN : 1 ≤ N) :
    rayleighSup W ^ N ≤ (W ^ N).trace ∧
      (W ^ N).trace ≤ (Fintype.card n : ℝ) * rayleighSup W ^ N :=
  ⟨rayleighSup_pow_le_trace_pow hW hpd hN, trace_pow_le hW (psd_of_pd hpd) N⟩

end Ising2D
