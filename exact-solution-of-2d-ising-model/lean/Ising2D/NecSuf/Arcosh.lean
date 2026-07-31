/-
# `arcosh` の連続性（必要十分版）

対応する人手証明のラベル: `gamma_is_continuous`（`gamma1_lower_bound_all_theta` も参照）
具体版: `Ising2D/Part012/Claim001_Gamma1LowerBound.lean`,
`Ising2D/Part012/Claim002_GammaContinuous.lean`

## mathlib の状況（`lean/README.md` の記載の訂正）

`lean/README.md` は「mathlib に無いことが分かっているもの」として `Real.arccosh` を挙げているが、
**本リポジトリが固定している mathlib（`v4.32.1`）には `Real.arcosh` が存在する**
（`Mathlib/Analysis/SpecialFunctions/Arcosh.lean`、綴りは `arccosh` ではなく `arcosh`）。
定義は人手証明 `gamma_is_continuous` Step 2 の明示式とまったく同じ

  `Real.arcosh x = Real.log (x + √(x ^ 2 - 1))`

であり、人手証明が Step 2 で証明している内容も `Real.cosh_arcosh`（`1 ≤ x` で
`cosh (arcosh x) = x`）、`Real.arcosh_nonneg`、`Real.continuousOn_arcosh`
（`ContinuousOn arcosh (Ici 1)`）としてすでに用意されている。
したがって**自前定義は不要**であり、本ファイルでは mathlib のものをそのまま使う。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明 Step 3 は「`γ_1(ℝ) ⊆ [1,∞)` なので合成 `γ = arcosh ∘ γ_1` は `ℝ` 上連続」と述べるが、
この合成の連続性に効いているのは

* **内側の関数が連続であること**
* **その値が `1` 以上であること**

の 2 つだけである。**定義域が `ℝ` であることは効いておらず、任意の位相空間でよい。**
`γ_1` が `cos` の 1 次式であることも、周期 `2π` をもつことも、Ising 模型の定数の意味も、
まったく効いていない。mathlib 側が `ContinuousOn arcosh (Ici 1)` という区間つきの形で
述べているのに対し、合成の形にすると区間への制限が消えることも、この抽象化で見える。
-/
import Mathlib.Analysis.SpecialFunctions.Arcosh

namespace Ising2D.NecSuf

/-- **必要十分版**: 値が `1` 以上の連続関数と `arcosh` の合成は連続。
定義域は**任意の位相空間**でよい。人手証明 `gamma_is_continuous` Step 3 の一般形。 -/
theorem continuous_arcosh_comp {X : Type*} [TopologicalSpace X] {f : X → ℝ}
    (hf : Continuous f) (h1 : ∀ x, 1 ≤ f x) : Continuous fun x => Real.arcosh (f x) := by
  refine Real.continuousOn_arcosh.comp_continuous hf fun x => ?_
  exact Set.mem_Ici.2 (h1 x)

end Ising2D.NecSuf
