/-
# `c_1c_2^* - s_1s_2^* x` の下界（必要十分版）

対応する人手証明のラベル: `gamma1_lower_bound_all_theta`
具体版: `Ising2D/Part012/Claim001_Gamma1LowerBound.lean`

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明は `γ_1(θ) = c_1c_2^* - s_1s_2^*\cos θ ≥ \cosh(2K_1-2K_2^*) ≥ 1`
を「すべての実数 `θ`」について主張するが、証明に効いているのは次の 2 つだけである。

* **`cos θ ≤ 1`**。`cos` が周期関数であることも、`θ` が実数の全体を動くことも、
  `θ = θ_μ = 2πμ/M` という形であることも、まったく効いていない。
  必要十分版では `cos θ` を「`1` 以下の任意の実数 `x`」に置き換えられる。
* **`sinh(2K_1) sinh(2K_2^*) ≥ 0`**（人手証明は `K_1, K_2^* > 0` から `> 0` を出しているが、
  不等式には `≥ 0` で十分である）。

残りは `cosh` の加法定理 `cosh(u-v) = cosh u cosh v - sinh u sinh v` と `1 ≤ cosh` だけである。
つまり **`γ_1` の下界は「三角関数の値域」と「双曲線関数の加法定理」の 2 点に還元でき、
Ising 模型のパラメータの意味は効いていない。**
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.DerivHyp

namespace Ising2D.NecSuf

/-- **必要十分版**: `x ≤ 1` かつ `sinh u * sinh v ≥ 0` なら
`cosh(u - v) ≤ cosh u * cosh v - sinh u * sinh v * x`。 -/
theorem cosh_sub_le_cosh_mul_cosh_sub {u v x : ℝ} (hx : x ≤ 1)
    (hs : 0 ≤ Real.sinh u * Real.sinh v) :
    Real.cosh (u - v) ≤ Real.cosh u * Real.cosh v - Real.sinh u * Real.sinh v * x := by
  rw [Real.cosh_sub]
  nlinarith

/-- **必要十分版**: 上の下界はさらに `1` 以上である。 -/
theorem one_le_cosh_mul_cosh_sub {u v x : ℝ} (hx : x ≤ 1)
    (hs : 0 ≤ Real.sinh u * Real.sinh v) :
    1 ≤ Real.cosh u * Real.cosh v - Real.sinh u * Real.sinh v * x :=
  le_trans (Real.one_le_cosh (u - v)) (cosh_sub_le_cosh_mul_cosh_sub hx hs)

end Ising2D.NecSuf
