/-
# 「奇数倍の位相では `sin θ = 0` から `cos θ = -1` が従う」（**必要十分版**）

対応する人手証明のラベル: `gamma_2_theta_tilde_nonzero`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_002_claim_gamma2_nonzero`）

具体版: `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimGamma2TildeNonzero.lean`
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

証明の手順は具体版 `cos_thetaTilde_eq_neg_one_of_sin_eq_zero` と同じである:
`sin θ = 0` から `θ = kπ`（`k ∈ ℤ`）、`N·kπ = m·π` の両辺を `π ≠ 0` で割って `N·k = m`、
`N·k` が奇数なので `k` は奇数（`k = 2l` なら `N·k = 2(N·l)` は偶数）、`cos θ = cos(kπ) = (−1)^k = −1`。
具体版の `2(μ − 1/2)/M_col = k` を経る段（割る・掛ける・分配律）は、ここでは `N·k = m` を直接得る段にまとまる。
`π ≠ 0` は割る段に要る（具体版の `pi_is_positive`）。
`N` が整数であることは「`k = 2l` なら `N·k = 2(N·l)` は偶数」の段に要る。`N` を有理数に広げると成り立たない
（`N = 1/2`、`θ = 2π` では `N·θ = π`、`m = 1` は奇数、`sin θ = 0` だが `cos θ = 1`）。
具体版の仮定 `M ≠ 0` は要らない。仮定の形 `N·θ = m·π` が、具体版の `M_col` を掛ける段を既に済ませているからである。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

namespace Ising2D.NecSuf

/-- **必要十分版**: `N·θ = m·π`（`m` は奇数）かつ `sin θ = 0` なら `cos θ = -1`。

人手証明 `gamma_2_theta_tilde_nonzero` の Step 2 + Step 3 の一般形。 -/
theorem cos_eq_neg_one_of_sin_eq_zero_of_odd {θ : ℝ} {N m : ℤ} (hodd : Odd m)
    (hθ : (N : ℝ) * θ = (m : ℝ) * Real.pi) (hsin : Real.sin θ = 0) :
    Real.cos θ = -1 := by
  have hpi : Real.pi ≠ 0 := Real.pi_ne_zero
  -- 具体版の Step 2 の 1 行目: `sin θ = 0 ⟹ ∃k ∈ ℤ, θ = kπ`
  obtain ⟨k, hk⟩ : ∃ k : ℤ, θ = (k : ℝ) * Real.pi := by
    obtain ⟨n, hn⟩ := Real.sin_eq_zero_iff.1 hsin
    exact ⟨n, hn.symm⟩
  -- 具体版の Step 2 の 2〜5 行目に当たる: `N·k = m`（`N·(kπ) = m·π` の両辺を `π ≠ 0` で割る）
  have hNk : (N : ℝ) * (k : ℝ) = (m : ℝ) := by
    apply mul_right_cancel₀ hpi
    rw [mul_assoc, ← hk]
    exact hθ
  have hNkZ : N * k = m := by exact_mod_cast hNk
  -- `k` が奇数であることの鎖: `N·k = m` は奇数、`k = 2l` なら `N·k = 2(N·l)` は偶数
  have hkodd : Odd k := by
    rcases Int.even_or_odd k with ⟨l, hl⟩ | h
    · exact absurd (hNkZ ▸ hodd) (Int.not_odd_iff_even.2 ⟨N * l, by rw [hl]; ring⟩)
    · exact h
  -- 具体版の Step 3 の鎖
  calc Real.cos θ
      = Real.cos ((k : ℝ) * Real.pi) := by rw [hk]
    _ = (-1 : ℝ) ^ k := Real.cos_int_mul_pi k
    _ = -1 := hkodd.neg_one_zpow

end Ising2D.NecSuf
