/-
# 「奇数倍の位相では `sin θ = 0` から `cos θ = -1` が従う」（**必要十分版**）

対応する人手証明のラベル: `gamma_2_theta_tilde_nonzero`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_002_claim_gamma2_nonzero`）

具体版: `Ising2D/Part015/Claim002_Gamma2TildeNonzero.lean`
（`Ising2D.gamma2_thetaTilde_ne_zero`）。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明の Step 2・Step 3 は「`θ~_μ = 2π(μ-1/2)/M` について `sin θ~_μ = 0` なら
`2μ-1 = kM` で `k` は奇数、ゆえに `cos θ~_μ = cos(kπ) = -1`」と述べる。
この結論に効いているのは次の 2 つだけである。

* **`θ` を整数倍したものが `π` の奇数倍になること**（`N·θ = m·π`, `m` は奇数）。
* **`sin θ = 0`**。

`M`、`μ`、`2π/M` という具体的な形も、`θ` が運動量であることも、Ising 模型の定数も、
複素数も行列も効いていない。とくに `N`（具体版では `M`）は任意の整数でよく、
`m`（具体版では `2μ-1`）が奇数でありさえすればよい。
整数運動量 `θ_μ = 2πμ/M` が `M·θ_μ = 2μ·π`（**偶数**倍）であることと対比すると、
半整数運動量で例外が消える理由がこの 1 行に凝縮されていることが分かる。

証明も `cos^2 + sin^2 = 1`（`cos θ = ±1` に絞る）と
`cos θ = 1 ⟺ θ ∈ 2πℤ`（`m` の偶奇で排除する）の 2 つしか使っていない。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

namespace Ising2D.NecSuf

/-- **必要十分版**: `N·θ = m·π`（`m` は奇数）かつ `sin θ = 0` なら `cos θ = -1`。

人手証明 `gamma_2_theta_tilde_nonzero` の Step 2 + Step 3 の一般形。 -/
theorem cos_eq_neg_one_of_sin_eq_zero_of_odd {θ : ℝ} {N m : ℤ} (hodd : Odd m)
    (hθ : (N : ℝ) * θ = (m : ℝ) * Real.pi) (hsin : Real.sin θ = 0) :
    Real.cos θ = -1 := by
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  have hsq : Real.cos θ ^ 2 = 1 := by
    have h := Real.sin_sq_add_cos_sq θ
    rw [hsin] at h
    nlinarith [h]
  have hfac : (Real.cos θ - 1) * (Real.cos θ + 1) = 0 := by nlinarith [hsq]
  rcases mul_eq_zero.1 hfac with h | h
  · -- `cos θ = 1` すなわち `θ ∈ 2πℤ` の場合は `m` が偶数になり、奇数性に反する
    exfalso
    have hcos1 : Real.cos θ = 1 := by linarith
    obtain ⟨n, hn⟩ := (Real.cos_eq_one_iff θ).1 hcos1
    rw [← hn] at hθ
    have hcast : ((2 * N * n : ℤ) : ℝ) * Real.pi = ((m : ℤ) : ℝ) * Real.pi := by
      push_cast
      linear_combination hθ
    have hNM : (2 * N * n : ℤ) = m := by
      have h' := mul_right_cancel₀ hpi hcast
      exact_mod_cast h'
    obtain ⟨j, hj⟩ := hodd
    have hdvd : (2 : ℤ) ∣ m := ⟨N * n, by linear_combination -hNM⟩
    omega
  · linarith

end Ising2D.NecSuf
