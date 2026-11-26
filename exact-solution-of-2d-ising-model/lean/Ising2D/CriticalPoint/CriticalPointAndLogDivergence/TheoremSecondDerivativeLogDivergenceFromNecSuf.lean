/-
# `G' = (1/4π)∫ ∂γ/∂κ`・`G'' = (1/4π)∫ ∂²γ/∂κ²`（具体版を必要十分版から導く）

具体版 `TheoremSecondDerivativeLogDivergence.lean` の `hasDerivAt_Gfun`・`hasDerivAt_Gfirst`（人手のラベルは
`second_derivative_log_divergence` の Step 1。(R5) を 2 回使う）の主張を、必要十分版
`Ising2D/NecSuf/DiffUnderIntegral.lean` の `hasDerivAt_integral_of_continuousOn` の
`a = 0`, `b = 2π`, `s = {x | x ≠ 0}`, `x₀ = κ` への特殊化から得る（被積分関数は 1 回目が `g = γ`, `g' = ∂γ/∂κ`、
2 回目が `g = ∂γ/∂κ`, `g' = ∂²γ/∂κ²`）。

具体版の Step 1 は長方形 `[0,2π]×[κ − |κ|/2, κ + |κ|/2]` のコンパクト性から `∂γ/∂κ`（2 回目は `∂²γ/∂κ²`）の
上界 `C` を取り、優関数を定数 `C` とする。必要十分版は同じ段を開集合 `s` の中の閉球で行う。
-/
import Ising2D.CriticalPoint.CriticalPointAndLogDivergence.TheoremSecondDerivativeLogDivergence
import Ising2D.NecSuf.DiffUnderIntegral

namespace Ising2D

/-- `hasDerivAt_Gfun` を、`NecSuf.hasDerivAt_integral_of_continuousOn` の `g = γ`, `g' = ∂γ/∂κ`,
`[a,b] = [0,2π]`, `s = {x | x ≠ 0}` への特殊化から得る。 -/
theorem hasDerivAt_Gfun_of_necSuf {κ : ℝ} (hκ : κ ≠ 0) : HasDerivAt Gfun (Gfirst κ) κ := by
  have h := NecSuf.hasDerivAt_integral_of_continuousOn (g := gammaK) (g' := dgammaK)
    (a := 0) (b := 2 * Real.pi) (x₀ := κ) (s := {x : ℝ | x ≠ 0}) isOpen_ne_zero hκ
    (fun x _ => (continuous_gammaK_fixed x).continuousOn)
    (continuousOn_dgammaK.mono (Set.prod_mono_left (Set.subset_univ _)))
    (fun t _ x hx => hasDerivAt_gammaK t hx)
  exact h.const_mul (1 / (4 * Real.pi))

/-- `hasDerivAt_Gfirst` を、`NecSuf.hasDerivAt_integral_of_continuousOn` の `g = ∂γ/∂κ`, `g' = ∂²γ/∂κ²`,
`[a,b] = [0,2π]`, `s = {x | x ≠ 0}` への特殊化から得る。 -/
theorem hasDerivAt_Gfirst_of_necSuf {κ : ℝ} (hκ : κ ≠ 0) : HasDerivAt Gfirst (Gsecond κ) κ := by
  have h := NecSuf.hasDerivAt_integral_of_continuousOn (g := dgammaK) (g' := d2gammaK)
    (a := 0) (b := 2 * Real.pi) (x₀ := κ) (s := {x : ℝ | x ≠ 0}) isOpen_ne_zero hκ
    (fun x hx => (continuous_dgammaK_fixed hx).continuousOn)
    (continuousOn_d2gammaK.mono (Set.prod_mono_left (Set.subset_univ _)))
    (fun t _ x hx => hasDerivAt_dgammaK t hx)
  exact h.const_mul (1 / (4 * Real.pi))

end Ising2D
