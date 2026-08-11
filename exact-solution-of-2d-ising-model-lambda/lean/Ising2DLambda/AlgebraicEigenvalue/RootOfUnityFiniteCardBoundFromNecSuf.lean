/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityFiniteCardBound
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityFiniteCardBound

namespace Ising2DLambda.AlgebraicEigenvalue

theorem rootOfUnityFiniteCardLe_from_necSuf (n : ℕ) (hn : 1 ≤ n) :
    (RootOfUnity n).Finite ∧ (RootOfUnity n).ncard ≤ n := by
  apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.finite_ncard_le_of_finset_card_le_necSuf
  intro s hs
  exact rootOfUnitySubsetCardLe n hn s fun w hw => (mem_rootOfUnity).1 (hs hw)

end Ising2DLambda.AlgebraicEigenvalue
