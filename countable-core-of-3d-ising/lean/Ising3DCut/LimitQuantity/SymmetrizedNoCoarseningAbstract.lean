/-
「対称化した極限量に対して粗視化は必要でない」の Lean 必要十分版。
零モデル・箱・辺集合を落とし、必要な構造だけを残す：
- 係数非負・次数 $\ge1$・最高次係数正の任意の有理係数多項式 $f$ について、
  $q>0$・$q\neq1$ なら $f(q)\neq f(1/q)$（値そのものは反転不変でない）。
- 項ごとに等しい任意の二つの実数列は、収束すれば同じ極限を持つ。
具体版 `nullModel_symmetrized_no_coarsening` は、$f$ を零モデルの分配多項式、
二列を対称化した実数列に取った特殊化である（反転不変性の証明が項ごとの等式を与える）。
ℝ へ脱出しているのは実数列の極限の一点だけである。
-/
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantStepFourEval
import Ising3DCut.LimitQuantity.RealLimitOfEqualSequences

namespace Ising3DCut.LimitQuantity

open Polynomial Filter Topology

/-- 必要十分版：反転で値は変わる（係数非負・次数 $\ge1$・最高次係数正）が、
項ごとに等しい二つの実数列の極限は一致する。 -/
theorem symmetrized_no_coarsening_abstract {f : ℚ[X]}
    (hc : ∀ i, 0 ≤ f.coeff i) (hn : 1 ≤ f.natDegree) (hlead : 0 < f.leadingCoeff)
    {q : ℚ} (hq : 0 < q) (hq1 : q ≠ 1)
    (a b : ℕ → ℝ) (hab : ∀ n, a n = b n) (ℓ ℓ' : ℝ)
    (ha : Tendsto a atTop (𝓝 ℓ)) (hb : Tendsto b atTop (𝓝 ℓ')) :
    f.eval q ≠ f.eval (1 / q) ∧ ℓ = ℓ' :=
  ⟨eval_ne_eval_inv_of_nonneg_coeff hc hn hlead hq hq1,
    limit_eq_of_pointwise_eq a b hab ℓ ℓ' ha hb⟩

end Ising3DCut.LimitQuantity
