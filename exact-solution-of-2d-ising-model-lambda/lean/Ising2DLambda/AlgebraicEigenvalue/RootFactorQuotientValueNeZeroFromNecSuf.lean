/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.RootFactorQuotientValueNeZero
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootFactorQuotientValueNeZero

namespace Ising2DLambda.AlgebraicEigenvalue

theorem rootFactorQuotientValueNeZero_from_necSuf (n : ℕ) (hn : 1 ≤ n) (w : Qbar)
    (hw : w ∈ RootOfUnity n) :
    qbarPolyEval w (rootFactorQuotient w n) ≠ 0 := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 :=
    ⟨n - 1, (Nat.succ_pred_eq_of_pos hn).symm⟩
  have h1 : qbarPolyEval w (rootFactorQuotient w (m + 1))
      = qbarPolyEval w (qbarPolyPowDiffSum w (m + 1)) := by
    rw [rootPolynomialFactorQuotientEq w (m + 1) hn]
  have h2 : qbarPolyEval w (qbarPolyPowDiffSum w (m + 1))
      = ∑ _i ∈ Finset.range (m + 1), w ^ m :=
    qbarPowDiffQuotientRootValue w m
  have h3 : (∑ _i ∈ Finset.range (m + 1), w ^ m) ≠ 0 :=
    qbarRepeatedSumNeZero
      (qbarPowNeZero w (rootOfUnityElementNeZero (m + 1) hn w hw) m)
      (m + 1) hn
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_chain_ne_zero_necSuf h1 h2 h3

end Ising2DLambda.AlgebraicEigenvalue
