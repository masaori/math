/-
# `Σ_k ((W_ℝ)^n)_kk ≤ 2^{M_col} c(M_col)^n` を必要十分版から得る

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_008a_claim_trace_power_upper_bound`、ラベル **`trace_power_upper_bound`**）

具体版 `Ising2D.trace_power_upper_bound`（`ClaimTracePowerUpperBound.lean`）と同じ型の主張を、各 `k` の評価を必要十分版
`Ising2D.NecSuf.IsPsdPair.moment_le_pow` の特殊化で得る `trace_pow_le` から得る。
具体版が必要十分版の特殊化として得られることの記録で、具体版の証明と通しの証明には使わない。
必要十分版の側では `W_ℝ` の正定値性は要らず、半正定値性（`psd_of_pd` で正定値性から出す）で足りる。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerUpperBound

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

section RealMatrix

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- **必要十分版の特殊化**: 対称で半正定値な任意の実数の行列 `W` と `N ≥ 0` について `Σ_k (W^N)_kk ≤ (dim) c(W)^N`。
各 `k` の評価 `e_k^⊤W^Ne_k ≤ c^N` を `NecSuf.IsPsdPair.moment_le_pow` の特殊化で得る。 -/
theorem trace_pow_le {W : Matrix n n ℝ} (hW : W.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ W *ᵥ x) (N : ℕ) :
    (W ^ N).trace ≤ (Fintype.card n : ℝ) * rayleighSup W ^ N := by
  have hpair := isPsdPair_of_matrix hW hpsd
  have hdiag : ∀ i : n, (W ^ N) i i ≤ rayleighSup W ^ N := by
    intro i
    have h := hpair.moment_le_pow (rayleighSup_nonneg hpsd)
      (necSuf_rayleigh_hyp (W := W)) (Pi.single i 1) N
    rw [matBilin_one_mulVecLin_pow, single_dotProduct_mulVec_single] at h
    have he : matBilin (1 : Matrix n n ℝ) (Pi.single i 1) (Pi.single i 1) = 1 := by
      simpa [vecNormSq] using vecNormSq_single (n := n) i
    rwa [he, mul_one] at h
  calc (W ^ N).trace = ∑ i, (W ^ N) i i := rfl
    _ ≤ ∑ _i : n, rayleighSup W ^ N := Finset.sum_le_sum fun i _ => hdiag i
    _ = (Fintype.card n : ℝ) * rayleighSup W ^ N := by
        rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]

end RealMatrix

variable {M : ℕ}

/-- **人手 `trace_power_upper_bound` を必要十分版から得たもの**（具体版 `trace_power_upper_bound` と同じ型）。 -/
theorem trace_power_upper_bound_of_necSuf (W : TensorPow M) (hW : MatrixIsRealSymmetric W)
    (hWRsymm : (realMatrixOfRealEntries W hW.1).IsSymm)
    (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x)
    {n : ℕ} (_hn : 1 ≤ n) :
    ∑ k, (realMatrixOfRealEntries W hW.1 ^ n) k k
      ≤ 2 ^ M * rayleighSup (realMatrixOfRealEntries W hW.1) ^ n := by
  haveI : Nonempty (Conf M) := ⟨fun _ => 0⟩
  have h := trace_pow_le hWRsymm (psd_of_pd hpd) n
  rw [card_conf] at h
  exact h

end Ising2D
