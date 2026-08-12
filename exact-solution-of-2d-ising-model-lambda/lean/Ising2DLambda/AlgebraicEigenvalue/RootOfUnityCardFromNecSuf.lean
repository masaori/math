/-
具体版が必要十分版の特殊化として得られることの導出。
上界は `rootOfUnityFiniteCardLe`、相異なる n 個の元は
`rootPolynomialDistinctFactorization` を j = n として供給する。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityCard
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityCard

namespace Ising2DLambda.AlgebraicEigenvalue

theorem rootOfUnityCardEq_from_necSuf (n : ℕ) (hn : 1 ≤ n) :
    (RootOfUnity n).ncard = n := by
  obtain ⟨hfinite, hupper⟩ := rootOfUnityFiniteCardLe n hn
  obtain ⟨w, _, hmem, hdist, _, _, _⟩ :=
    rootPolynomialDistinctFactorization n hn n le_rfl
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_eq_of_upper_and_distinct_sequence_necSuf
    (RootOfUnity n) n hfinite hupper w hmem hdist

end Ising2DLambda.AlgebraicEigenvalue
