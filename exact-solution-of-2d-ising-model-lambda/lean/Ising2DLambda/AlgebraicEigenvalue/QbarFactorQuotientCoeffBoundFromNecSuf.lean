/-
「因数定理の商の係数上界」の具体版が、必要十分版の特殊化として得られることの導出。
係数の列を `c = f.coeff` と取り、`K_k(w)` の再帰列の一致（既出）で書き換える。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorQuotientCoeffBound
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarFactorQuotientCoeffBound
import Ising2DLambda.AlgebraicEigenvalue.QbarPowDiffSumCoeffBoundFromNecSuf

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarFactorQuotientCoeffBound_from_necSuf
    (f : QbarPoly) (w : Qbar) (n j : ℕ) (h : n ≤ j) :
    (∑ k ∈ Finset.range (n + 1),
      qbarConst (f.coeff k) * qbarPolyPowDiffSum w k).coeff j = 0 := by
  have hsum : (∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k)
      = ∑ k ∈ Finset.range (n + 1),
          Polynomial.C (f.coeff k) * NecSuf.AlgebraicEigenvalue.powDiffSum_necSuf w k := by
    refine Finset.sum_congr rfl (fun k _ => ?_)
    rw [qbarConst, qbarPolyPowDiffSum_eq_coeffBound_necSuf]
  rw [hsum]
  exact NecSuf.AlgebraicEigenvalue.factor_quotient_coeff_bound_necSuf f.coeff w n j h

end Ising2DLambda.AlgebraicEigenvalue
