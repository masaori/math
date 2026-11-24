/-
# `γ_1(θ), γ_2(θ)` と `A(θ~_μ)` の書き換え（**具体版**）

対応する人手証明のラベル: `def_gamma1_gamma2_of_theta`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`Athetatilde_001_definition_gamma1_gamma2`）

**必要十分版は無い。** この主張は「`A(θ)` の 4 成分が `γ_1, γ_2` で書ける」という
定義の言い換えであり、取り払える構造が残っていない（`γ_2(-θ)` の明示形を
`cos(-θ) = cos θ`, `sin(-θ) = -sin θ` で計算するだけ）。

## 形式化の方針

人手証明は 015 章で `γ_1, γ_2` を `θ ∈ ℝ` の関数として**ラベル付きで定義し直して**いるが、
式は 008 章のものと文字どおり同一である（本文の `conversion.notes` にもそう書かれている）。
Lean 側では 008 章の時点で既に `θ ∈ ℝ` 全体の関数として
`Ising2D.gamma1` / `Ising2D.gamma2` / `Ising2D.AMat`（`EigenvalueProblem/ReductionToATheta/DefinitionThetaGamma.lean`）
が定義され、書き換え `A(θ) = !![γ_1, γ_2(θ); -γ_2(-θ), γ_1]` も
`Ising2D.AMat_eq` として証明済みである。**したがって新しい定義は導入せず、
半整数運動量 `θ~_μ`（`Ising2D.thetaTilde`、`EigenvalueProblem/ReductionToATheta/ClaimAntiperiodicExpSum.lean`）
への特殊化だけをここに置く。**

`M · θ~_μ = (2μ-1)π`（半整数運動量が `π` の**奇数**倍になること）の `thetaTilde_mul_M` は、必要十分版の仮定へ渡すためだけに使うので
導出のファイル `ClaimGamma2TildeNonzeroFromNecSuf.lean` に置く。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionThetaGamma
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimGamma1LowerBound
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionCheckIndexSet

namespace Ising2D

open Matrix

variable (K : IsingConst)

/-- **人手証明 `def_gamma1_gamma2_of_theta` の書き換え**を半整数運動量へ特殊化した形:
`A(θ~_μ) = !![γ_1(θ~_μ), γ_2(θ~_μ); -γ_2(-θ~_μ), γ_1(θ~_μ)]`。 -/
theorem AMat_thetaTilde_eq (M : ℕ) (μ : ℤ) :
    AMat K (thetaTilde M μ)
      = !![gamma1 K (thetaTilde M μ), gamma2 K (thetaTilde M μ);
          -gamma2 K (-thetaTilde M μ), gamma1 K (thetaTilde M μ)] :=
  AMat_eq K (thetaTilde M μ)

end Ising2D
